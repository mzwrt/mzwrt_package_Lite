/*
 *  luci-theme-kucat
 *  Copyright (C) 2019-2024 The Sirpdboy Team <herboy2008@gmail.com> 
 *
 *  Have a bug? Please create an issue here on GitHub!
 *      https://github.com/sirpdboy/luci-theme-kucat/issues
 *
 *  luci-theme-bootstrap:
 *      Copyright 2008 Steven Barth <steven@midlink.org>
 *      Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
 *      Copyright 2012 David Menting <david@nut-bolt.nl>
 *
 *  luci-theme-material:
 *      https://github.com/LuttyYang/luci-theme-material/
 *  luci-theme-opentopd:
 *      https://github.com/sirpdboy/luci-theme-opentopd
 *
 *  Licensed to the public under the Apache License 2.0
 */

'use strict';
'require baseclass';
'require ui';
return baseclass.extend({
	__init__: function() {
		ui.menu.load().then(L.bind(this.render, this));
	},

	render: function(tree) {
		var node = tree,
		    url = '';

		this.renderModeMenu(node);

		if (L.env.dispatchpath.length >= 3) {
			for (var i = 0; i < 3 && node; i++) {
				node = node.children[L.env.dispatchpath[i]];
				url = url + (url ? '/' : '') + L.env.dispatchpath[i];
			}

			if (node)
				this.renderTabMenu(node, url);
		}

		document.querySelector('.showSide')
			.addEventListener('click', ui.createHandlerFn(this, 'handleSidebarToggle'));

		document.querySelector('.darkMask')
			.addEventListener('click', ui.createHandlerFn(this, 'handleSidebarToggle'));
			
		document.querySelector(".main > .loading").style.opacity = '0';
		document.querySelector(".main > .loading").style.visibility = 'hidden';

		if (window.innerWidth <= 1152)
			document.querySelector('.main-left').style.width = '0';

		document.querySelector('.main-right').style.overflow = 'auto';
		window.addEventListener('resize', this.handleSidebarToggle, true);
		
	},

	handleMenuExpand: function(ev) {
		var a = ev.target, ul1 = a.parentNode, ul2 = a.nextElementSibling;
		var collapse = false;

		document.querySelectorAll('li.slide.active').forEach(function(li) {
			if (li !== a.parentNode || li == ul1) {
				li.classList.remove('active');
				li.childNodes[0].classList.remove('active');
			}
			if (!collapse && li == ul1) {
				collapse = true;
			}
		});

		if (!ul2)
			return;

		if (ul2.parentNode.offsetLeft + ul2.offsetWidth <= ul1.offsetLeft + ul1.offsetWidth)
			ul2.classList.add('align-left');
		if (!collapse) {
			ul1.classList.add('active');
			a.classList.add('active');

		}
		else
		{
			ul1.classList.remove('active');
			a.classList.remove('active');
		}
		
		a.blur();
		ev.preventDefault();
		ev.stopPropagation();
	},

	renderMainMenu: function(tree, url, level) {
		var l = (level || 0) + 1,
		    ul = E('ul', { 'class': level ? 'slide-menu' : 'nav' }),
		    children = ui.menu.getChildren(tree);

		if (children.length == 0 || l > 2)
			return E([]);

		for (var i = 0; i < children.length; i++) {
			var isActive = ((L.env.dispatchpath[l] == children[i].name) && (L.env.dispatchpath[l - 1] == tree.name)),
				submenu = this.renderMainMenu(children[i], url + '/' + children[i].name, l),
				hasChildren = submenu.children.length,
				slideClass = hasChildren ? 'slide' : null,
				menuClass = hasChildren ? 'menu' : null;
			if (isActive) {
				ul.classList.add('active');
				slideClass += " active";
				menuClass += " active";
			}

			ul.appendChild(E('li', { 'class': slideClass }, [
				E('a', {
					'href': L.url(url, children[i].name),
					'click': (l == 1) ? ui.createHandlerFn(this, 'handleMenuExpand') : null,
					'class': menuClass,
					'data-title': hasChildren ? children[i].title.replace(" ", "_") : children[i].title.replace(" ", "_"),
				}, [_(children[i].title)]),
				submenu
			]));
		}

		if (l == 1) {
			var container = document.querySelector('#mainmenu');

			container.appendChild(ul);
			container.style.display = '';
		}

		return ul;
	},

	renderModeMenu: function(tree) {
		var ul = document.querySelector('#modemenu'),
		    children = ui.menu.getChildren(tree);

		for (var i = 0; i < children.length; i++) {
			var isActive = (L.env.requestpath.length ? children[i].name == L.env.requestpath[0] : i == 0);

			ul.appendChild(E('li', {}, [
				E('a', {
					'href': L.url(children[i].name),
					'class': isActive ? 'active' : null
				}, [ _(children[i].title) ])
			]));

			if (isActive)
				this.renderMainMenu(children[i], children[i].name);

			if (i > 0 && i < children.length)
				ul.appendChild(E('li', {'class': 'divider'}, [E('span')]))
		}

		if (children.length > 1)
			ul.parentElement.style.display = '';
	},

	renderTabMenu: function(tree, url, level) {
		var container = document.querySelector('#tabmenu'),
			    l = (level || 0) + 1,
			    ul = E('ul', { 'class': 'tabs' }),
			    children = ui.menu.getChildren(tree),
			    activeNode = null;

		if (children.length == 0)
			return E([]);

		for (var i = 0; i < children.length; i++) {
			var isActive = (L.env.dispatchpath[l + 2] == children[i].name),
				activeClass = isActive ? ' active' : '',
				className = 'tabmenu-item-%s %s'.format(children[i].name, activeClass);

			ul.appendChild(E('li', { 'class': className }, [
				E('a', { 'href': L.url(url, children[i].name) }, [ _(children[i].title) ] )
			]));

			if (isActive)
				activeNode = children[i];
		}

		container.appendChild(ul);
		container.style.display = '';

		if (activeNode)
			container.appendChild(this.renderTabMenu(activeNode, url + '/' + activeNode.name, l));

		return ul;
	},

	handleSidebarToggle: function(ev) {
		var width = window.innerWidth,
		    darkMask = document.querySelector('.darkMask'),
		    mainRight = document.querySelector('.main-right'),
		    mainLeft = document.querySelector('.main-left'),
		    open = mainLeft.style.width == '';

			if (width > 1152 || ev.type == 'resize')
				open = true;
				
		darkMask.style.visibility = open ? '' : 'visible';
		darkMask.style.opacity = open ? '': 1;

		if (width <= 1152)
			mainLeft.style.width = open ? '0' : '';
		else
			mainLeft.style.width = ''

		mainLeft.style.visibility = open ? '' : 'visible';

		mainRight.style['overflow-y'] = open ? 'visible' : 'hidden';
	}
});

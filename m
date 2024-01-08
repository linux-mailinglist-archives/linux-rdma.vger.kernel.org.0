Return-Path: <linux-rdma+bounces-553-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD5826AC6
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 10:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139631F22125
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 09:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91E11C86;
	Mon,  8 Jan 2024 09:34:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from aliyun-sdnproxy-1.icoremail.net (aliyun-cloud.icoremail.net [47.90.88.95])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873D511709;
	Mon,  8 Jan 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [10.190.64.155] ) by
 ajax-webmail-mail-app4 (Coremail) ; Mon, 8 Jan 2024 17:12:06 +0800
 (GMT+08:00)
Date: Mon, 8 Jan 2024 17:12:06 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: alexious@zju.edu.cn
To: "Simon Horman" <horms@kernel.org>
Cc: "Saeed Mahameed" <saeedm@nvidia.com>, 
	"Leon Romanovsky" <leon@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, 
	"Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Maor Gottlieb" <maorg@mellanox.com>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: fix a double-free in arfs_create_groups
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20240103172254.GB31813@kernel.org>
References: <20231224081348.3535146-1-alexious@zju.edu.cn>
 <20240103172254.GB31813@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5d93189f.7631f.18ce857ef38.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgBXzSxmvJtlmiOHAA--.8335W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgwOAGWadaU02gABsA
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cgo+IE9uIFN1biwgRGVjIDI0LCAyMDIzIGF0IDA0OjEzOjQ4UE0gKzA4MDAsIFpoaXBlbmcgTHUg
d3JvdGU6Cj4gPiBXaGVuIGBpbmAgYWxsb2NhdGVkIGJ5IGt2emFsbG9jIGZhaWxzLCBhcmZzX2Ny
ZWF0ZV9ncm91cHMgd2lsbCBmcmVlCj4gPiBmdC0+ZyBhbmQgcmV0dXJuIGFuIGVycm9yLiBIb3dl
dmVyLCBhcmZzX2NyZWF0ZV90YWJsZSwgdGhlIG9ubHkgY2FsbGVyIG9mCj4gPiBhcmZzX2NyZWF0
ZV9ncm91cHMsIHdpbGwgaG9sZCB0aGlzIGVycm9yIGFuZCBjYWxsIHRvCj4gPiBtbHg1ZV9kZXN0
cm95X2Zsb3dfdGFibGUsIGluIHdoaWNoIHRoZSBmdC0+ZyB3aWxsIGJlIGZyZWVkIGFnYWluLgo+
ID4gCj4gPiBGaXhlczogMWNhYmU2YjA5NjVlICgibmV0L21seDVlOiBDcmVhdGUgYVJGUyBmbG93
IHRhYmxlcyIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGlwZW5nIEx1IDxhbGV4aW91c0B6anUuZWR1
LmNuPgo+IAo+IFRoYW5rcywKPiAKPiBJIGFncmVlIHRoaXMgYWRkcmVzc2VzIHRoZSBpc3N1ZSB0
aGF0IHlvdSBkZXNjcmliZS4KPiBBbmQgYXMgYSBtaW5pbWFsIGZpeCBpdCBsb29rcyBnb29kLgo+
IAo+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Cj4gCj4gSG93
ZXZlciwgSSB3b3VsZCBsaWtlIHRvIHN1Z2dlc3QgdGhhdCBzb21lIGNsZWFuLXVwIHdvcmsgY291
bGQKPiB0YWtlIHBsYWNlIGFzIGEgZm9sbG93LXVwLgo+IAo+IEkgdGhpbmsgdGhhdCB0aGUgZXJy
b3IgaGFuZGxpbmcgaW4gdGhpcyBhcmVhIG9mIHRoZSBjb2RlCj4gaXMgcmF0aGVyIGZyYWdpbGUu
IFRoaXMgaXMgYmVjYXVzZSBpbml0aWFsaXNhdGlvbiBpcyBub3QgbmVjZXNzYXJpbHkKPiB1bndv
dW5kIG9uIGVycm9yIHdpdGhpbiB0aGUgZnVuY3Rpb24gdGhhdCBpbml0aWFsaXNhdGlvbiBvY2N1
cnMuCj4gCj4gSSB0aGluayBpdCB3b3VsZCBiZSBiZXR0ZXIgaWYgYXJmc19jcmVhdGVfZ3JvdXBz
KCk6Cj4gCj4gMS4gUmVsZWFzZWQgYWxsb2NhdGVzIHJlc291cmNlcyBpdCBhbGxvY2F0ZXMsIGlu
Y2x1ZGluZyBmdC0+ZyBhbmQKPiAgICBlbGVtZW50cyBvZiBmdC0+Zywgb24gZXJyb3IuCj4gMi4g
VGhpcyB3YXMgYWNoaWV2ZWQgYnkgdXNpbmcgYSBnb3RvIHVud2luZCBsYWRkZXIuCj4gMy4gVGhl
IGNhbGxlciB0cmVhdGVkIGZ0LT5nIGFzIHVuaW5pdGlhbGlzZWQgaWYKPiAgICBhcmZzX2NyZWF0
ZV9ncm91cHMgZmFpbHMuCj4KIApBZ3JlZSwgSSB0aGluayBhIHVud2luZCBsYWRkZXIgZm9yIGFy
ZnNfY3JlYXRlX2dyb3VwcyBpcyBtdWNoIGJldHRlci4KSSdsbCBmb2xsb3cgdGhpcyBpZGVhIHRv
IHNlbmQgYSB2MiBwYXRjaCBsYXRlci4KQW5vdGhlciBjb21tZW50IGJlbG93LgoKPiBMaWtld2lz
ZSwgSSB0aGluayB0aGF0Ogo+IAo+ICogYXJmc19jcmVhdGVfZ3JvdXBzLCBzaG91bGQgaW5pdGlh
bGlzZSBmdC0+bnVtX2dyb3Vwcwo+IAo+IEFuZCBmdXJ0aGVyLCBsb2dpYyBzaW1pbGFyIHRvIHRo
ZSBhYm92ZSBzaG91bGQgZ3VpZGUKPiBob3cgYXJmc19jcmVhdGVfdGFibGUoKSBpbml0aWFsaXNl
cyBmdC0+dCBhbmQgY2xlYW5zIGl0Cj4gdXAgb24gZXJyb3IuCj4gCgpJIHRoaW5rIHRoYXQgZnQt
PnQgeW91IG1lbnRpb25lZCByZWZlcnMgdG8gbWx4NV9jcmVhdGVfZmxvd190YWJsZS4KSSdkIGxp
a2UgdG8gbWFrZSB0aGUgbGlmZSBjeWNsZSBvZiBmdC0+dCBzaW1pbGFyIHRvIGZ0LT5nIGluIGFy
ZnNfY3JlYXRlX2dyb3VwcywgCmJ1dCBpdCBuZWVkcyB0byBhZGQgYW4gYXJndW1lbnQgZm9yIG1s
eDVfY3JlYXRlX2Zsb3dfdGFibGUgdG8gdHJhbnNmZXIgZnQgdG8gCml0LiBIb3dldmVyLCBtbHg1
X2NyZWF0ZV9mbG93X3RhYmxlIGlzIGNhbGxlZCBpbiBtb3JlIHRoYW4gMzAgZGlmZmVyZW50IHBs
YWNlcyAKdGhyb3VnaG91dCB0aGUga2VybmVsLiBTbyBzdWNoIG1vZGlmaWNhdGlvbiBjb3VsZCBi
ZSBhbm90aGVyIHJlZmFjdG9yaW5nIHBhdGNoCmJ1dCBtYXkgYmUgb3V0IG9mIHRoaXMgZml4IHBh
dGNoJ3MgZHV0eS4KCj4gSSBkaWQgbm90IGxvb2sgYXQgdGhlIGNvZGUgYmV5b25kIHRoZSBzY29w
ZSBkZXNjcmliZWQgYWJvdmUuCj4gQnV0IHRoZSBhYm92ZSBhcmUgZ2VuZXJhbCBwcmluY2lwbGVz
IHRoYXQgbWF5IHdlbGwgYXBwbHkgaW4KPiBvdGhlciBuZWFyYnkgY29kZSB0b28uCj4gCj4gLi4u
Cg==


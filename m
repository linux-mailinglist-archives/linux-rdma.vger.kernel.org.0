Return-Path: <linux-rdma+bounces-610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB1682BBFF
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jan 2024 08:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B811F2576A
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jan 2024 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452305D74F;
	Fri, 12 Jan 2024 07:45:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D28D5D726;
	Fri, 12 Jan 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from alexious$zju.edu.cn ( [124.90.105.91] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 12 Jan 2024 15:45:29 +0800
 (GMT+08:00)
Date: Fri, 12 Jan 2024 15:45:29 +0800 (GMT+08:00)
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
Subject: Re: [PATCH] [v2] net/mlx5e: fix a double-free in arfs_create_groups
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.2-cmXT5 build
 20230825(e13b6a3b) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <20240110162446.GJ9296@kernel.org>
References: <20240108152605.3712050-1-alexious@zju.edu.cn>
 <20240109081837.GJ132648@kernel.org>
 <49a38639.7d59b.18cf38ab939.Coremail.alexious@zju.edu.cn>
 <20240110162446.GJ9296@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <74def06a.828f1.18cfca212e2.Coremail.alexious@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cS_KCgAH2Z0Z7qBlWnu4AA--.20030W
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/1tbiAgoSAGWfu6c2zAAAsG
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

Cj4gT24gV2VkLCBKYW4gMTAsIDIwMjQgYXQgMDk6MjM6MjRQTSArMDgwMCwgYWxleGlvdXNAemp1
LmVkdS5jbiB3cm90ZToKPiA+ID4gT24gTW9uLCBKYW4gMDgsIDIwMjQgYXQgMTE6MjY6MDRQTSAr
MDgwMCwgWmhpcGVuZyBMdSB3cm90ZToKPiA+ID4gPiBXaGVuIGBpbmAgYWxsb2NhdGVkIGJ5IGt2
emFsbG9jIGZhaWxzLCBhcmZzX2NyZWF0ZV9ncm91cHMgd2lsbCBmcmVlCj4gPiA+ID4gZnQtPmcg
YW5kIHJldHVybiBhbiBlcnJvci4gSG93ZXZlciwgYXJmc19jcmVhdGVfdGFibGUsIHRoZSBvbmx5
IGNhbGxlciBvZgo+ID4gPiA+IGFyZnNfY3JlYXRlX2dyb3Vwcywgd2lsbCBob2xkIHRoaXMgZXJy
b3IgYW5kIGNhbGwgdG8KPiA+ID4gPiBtbHg1ZV9kZXN0cm95X2Zsb3dfdGFibGUsIGluIHdoaWNo
IHRoZSBmdC0+ZyB3aWxsIGJlIGZyZWVkIGFnYWluLgo+ID4gPiA+IAo+ID4gPiA+IEZpeGVzOiAx
Y2FiZTZiMDk2NWUgKCJuZXQvbWx4NWU6IENyZWF0ZSBhUkZTIGZsb3cgdGFibGVzIikKPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBaaGlwZW5nIEx1IDxhbGV4aW91c0B6anUuZWR1LmNuPgo+ID4gPiA+
IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Cj4gPiA+IAo+ID4g
PiBXaGVuIHdvcmtpbmcgb24gbmV0ZGV2IChhbmQgcHJvYmFibHkgZWxzZXdoZXJlKQo+ID4gPiBQ
bGVhc2UgZG9uJ3QgaW5jbHVkZSBSZXZpZXdlZC1ieSBvciBvdGhlciB0YWdzCj4gPiA+IHRoYXQg
d2VyZSBleHBsaWNpdGx5IHN1cHBsaWVkIGJ5IHNvbWVvbmU6IEkgZG9uJ3QgcmVjYWxsCj4gPiA+
IHN1cHBseWluZyB0aGUgdGFnIGFib3ZlIHNvIHBsZWFzZSBkcm9wIGl0Lgo+ID4gCj4gPiBJIGFw
b2xvZ2l6ZSwgYnV0IGl0IGFwcGVhcnMgdGhhdCB5b3UgaW5jbHVkZWQgYSAicmV2aWV3ZWQtYnki
IAo+ID4gdGFnIGFsb25nIHdpdGggY2VydGFpbiBzdWdnZXN0aW9ucyBmb3IgdmVyc2lvbiAxIG9m
IHRoaXMgcGF0Y2ggCj4gPiBpbiB0aGUgZmlyc3QgcmV2aWV3IGVtYWlsKGFib3V0IDYgZGF5cyBi
ZWZvcmUpLiAKPiAKPiBZZXMsIHNvcnJ5LiBNeSBzdGF0ZW1lbnQgYWJvdmUgaXMgbm90IGNvcnJl
Y3Q6Cj4gSSBub3cgc2VlIHRoYXQgSSBkaWQgc3VwcGx5IHRoZSB0YWcuCgpOZXZlciBtaW5kLCB5
b3UgZGlkIGdpdmUgYSBsb3Qgb2YgY29uc3RydWN0aXZlIHN1Z2dlc3Rpb24gcHJvYmVybHkgdG8g
ZXZlcnkgcGF0Y2guCkZvcmdldHRpbmcgYWJvdXQgYSB0YWcsIHdlbGwsIGl0IGNhbid0IGJlIGhl
bHBlZC4KCj4gPiBJbiByZXNwb25zZSwgYWZ0ZXIgYSBzaG9ydCBkaXNjdXNzaW9uLCBJIGZvbGxv
d2VkIHNvbWUgb2YgCj4gPiB0aG9zZSBzdWdnZXN0aW9ucyBhbmQgc2VuZCB0aGlzIHYyIHBhdGNo
Lgo+ID4gSSByZWZlcnJlZCB0byB0aGUgIkRlYWxpbmcgd2l0aCB0YWdzIiBzZWN0aW9uIGluIHRo
aXMgS2VybmVsTmV3YmllcyAKPiA+IHRpcHM6IGh0dHBzOi8va2VybmVsbmV3Ymllcy5vcmcvUGF0
Y2hUaXBzQW5kVHJpY2tzIGFuZCB0aG91Z2h0IAo+ID4gdGhhdCBJIHNob3VsZCBpbmNsdWRlIHRo
YXQgdGFnIGluIHYxIGVtYWlsIHRvIHRoaXMgdjIgcGF0Y2guCj4gPiBTbyBub3cgSSdtIGEgbGl0
dGxlIGJpdCBjb25mdXNlZCBoZXJlOiBpZiB0aGUgdGFnIHJ1bGUgaGFzIGNoYW5nZWQgCj4gPiBv
ciBJIGdvdCBzb21lIG1pc3VuZGVyc3RhbmRpbmcgb24gZXhpc3RpbmcgcnVsZXM/IFlvdXIgY2xh
cmlmaWNhdGlvbiAKPiA+IG9uIHRoaXMgbWF0dGVyIHdvdWxkIGJlIGdyZWF0bHkgYXBwcmVjaWF0
ZWQuCj4gCgouLi4KCj4gCj4gUmlnaHQsIEkgdGhpbmsgaXQgd291bGQgYmUgYmVzdCB0byBmb2N1
cyBvbiBmaXhpbmcgYXJmc19jcmVhdGVfZ3JvdXBzKCkuCj4gQW5kIG1ha2luZyBzdXJlIHRoYXQg
bmVpdGhlciBsZWFrcyBub3IgZG91YmxlIGZyZWVzIG9jY3VyLiBBbmQgSSB0aGluawo+IHRoYXQg
YXQgdGhpcyBwb2ludCB0aGF0IGluY2x1ZGVzIGVuc3VyaW5nIGZ0LT5nIGlzIE5VTEwgaWYgaXQg
aGFzIGJlZW4gZnJlZWQuCgpBIHYzIHZlcnNpb24gb2YgdGhpcyBwYXRjaCB3YXMgc2VudCBqdXN0
IG5vdywgd2hpY2ggaXMgZm9jdXNpbmcgb24gYXJmc19jcmVhdGVfZ3JvdXBzIGl0c2VsZi4KSGF2
ZSBhIG5pY2UgZGF5IQo=


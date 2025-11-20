Return-Path: <linux-rdma+bounces-14627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DED42C71FCF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 04:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 991C14E2D8B
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 03:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CFF27CCE2;
	Thu, 20 Nov 2025 03:28:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A723D7E6
	for <linux-rdma@vger.kernel.org>; Thu, 20 Nov 2025 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609322; cv=none; b=dmTEyEJnh/pDluVngeXBe+eDQflD8gq1kpV1NN+xy3MHyAm4dyvX+kWlZwF6YOVJun6KubuDRQizq2VoJy7a64/b1XkEcqrzEuB6AtBkJARBAeWP6r7xn5qcRGatBBcfg2TlxIReL2tZ8dRezlw1u1LAHKJQWfa4YUe8Wp4XQqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609322; c=relaxed/simple;
	bh=wnkTHUFL/MQjHGVAdJTsR5WEB4rs83R+jUip7W/L/HM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xfn1/L2BzInb1bRu9hslbLBOkxvp0R8uHy8M9TIaFQCqhXAh8LcT7Ovgamk1ywj+vxMeY7f9SwzIYvCmwXdNtp9saJqGgEawsn6VxkCrxHQ+c0dSLL6wG0/wIqGAKPVEsRP9oaihX90VljqJslRGhcOYwzGbUcDH6ZGQ15lBK7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Leon Romanovsky <leon@kernel.org>, "huangjunxian6@hisilicon.com"
	<huangjunxian6@hisilicon.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: RE: [????] Re: [????] Re: [PATCH][v2] RDMA/core: Prevent soft lockup
 during large user memory region cleanup
Thread-Topic: [????] Re: [????] Re: [PATCH][v2] RDMA/core: Prevent soft lockup
 during large user memory region cleanup
Thread-Index: AQHcVINZYLa5twxwjECtSFjMAFPff7T2pWMAgAKUKyCAAKZnAIABEaDg
Date: Thu, 20 Nov 2025 03:28:18 +0000
Message-ID: <4482842b3e774a7d996130b0651d1923@baidu.com>
References: <20251113095317.2628-1-lirongqing@baidu.com>
 <20251117174738.GE17968@ziepe.ca>
 <02011baf337649f6997166f223417417@baidu.com>
 <20251119190602.GN17968@ziepe.ca>
In-Reply-To: <20251119190602.GN17968@ziepe.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.3.12
X-FE-Policy-ID: 52:10:53:SYSTEM

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gR3VudGhvcnBl
IDxqZ2dAemllcGUuY2E+DQo+IFNlbnQ6IDIwMjXE6jEx1MIyMMjVIDM6MDYNCj4gVG86IExpLFJv
bmdxaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gQ2M6IExlb24gUm9tYW5vdnNreSA8bGVv
bkBrZXJuZWwub3JnPjsgaHVhbmdqdW54aWFuNkBoaXNpbGljb24uY29tOw0KPiBsaW51eC1yZG1h
QHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbPz8/P10gUmU6IFs/Pz8/XSBSZTogW1BBVENI
XVt2Ml0gUkRNQS9jb3JlOiBQcmV2ZW50IHNvZnQgbG9ja3VwDQo+IGR1cmluZyBsYXJnZSB1c2Vy
IG1lbW9yeSByZWdpb24gY2xlYW51cA0KPiANCj4gT24gV2VkLCBOb3YgMTksIDIwMjUgYXQgMDI6
MDM6MjBBTSArMDAwMCwgTGksUm9uZ3Fpbmcgd3JvdGU6DQo+ID4gPiA+IEZpeCBzb2Z0IGxvY2t1
cCBpc3N1ZXMgYnkgaW5jb3Jwb3JhdGluZyBjb25kX3Jlc2NoZWQoKSBjYWxscw0KPiA+ID4gPiB3
aXRoaW4gX19pYl91bWVtX3JlbGVhc2UoKSwgYW5kIHRoaXMgU0cgZW50cmllcyBhcmUgdHlwaWNh
bGx5DQo+ID4gPiA+IGdyb3VwZWQgaW4gMk1CIGNodW5rcyBvbiB4ODZfNjQsIGFkZGluZyBjb25k
X3Jlc2NoZWQoKSBzaG91bGQgaGFzDQo+ID4gPiA+IG1pbmltYWwNCj4gPiA+IHBlcmZvcm1hbmNl
DQo+ID4gPiA+IGltcGFjdC4NCj4gPiA+DQo+ID4gPiBUaGlzIGlzIG5vdCB0cnVlLCBJIHRoaW5r
IHRoaXMgc2hvdWxkIGhhdmUgYmVlbiBtb3JlIGNhcmVmdWwgdG8gb25seQ0KPiA+ID4gcmVzY2hl
ZCBhZnRlciBsYXJnZXIgZ3JvdXBpbmdzLi4gSG93IG11Y2ggc2xvd2VyIGRpZCB5b3UgbWFrZSBu
b3JtYWwNCj4gNGsgdW5waW5zPz8NCj4gPiA+DQo+ID4gPiBKYXNvbg0KPiA+DQo+ID4NCj4gPiBJ
IGRvbid0IHNlZSB0aGlzIGFzIGEgaXNzdWUgZm9yIHNldmVyYWwgcmVhc29ucy4gRmlyc3QsIHRo
aXMgY29kZSBwYXRoDQo+ID4gaXMgbm90IHBlcmZvcm1hbmNlLWNyaXRpY2FsLg0KPiANCj4gWWVz
IGl0IGlzIQ0KPiANCj4gPiBTZWNvbmQsIHRoZSBudW1iZXIgb2YgY29uZF9yZXNjaGVkDQo+ID4g
Y2FsbHMgYWRkZWQgYnkgdGhpcyBtb2RpZmljYXRpb24gaXMgaWRlbnRpY2FsIHRvIHdoYXQgd2Fz
IGludHJvZHVjZWQNCj4gPiBpbiBjb21taXQgOTI4ZGEzN2EyMjlmMzQ0NCwNCj4gDQo+IE5vIGl0
cyBub3QhIFRoYXQgbG9vcCBkb2VzIGVudGlyZSBiYXRjaGVzIG9mIHBhZ2VzIGludG8gYSBQQUdF
X1NJWkUgbWVtb3J5DQo+IGJ1ZmZlciwgdGhpcyBkb2VzIGl0IGZvciBldmVyeSBzaW5nbGUgNGsg
cGFnZS4NCj4gDQoNClRoYW5rcywgSSB1bmRlcnN0YW5kDQoNClRvIG1pbmltaXplIHBlcmZvcm1h
bmNlIGltcGFjdCBvbiByZWxlYXNpbmcgbWVtb3J5IHJlZ2lvbnMsIGNhbGwgY29uZF9yZXNjaGVk
KCkgcGVyIDRrIGxvb3AsIGhvdyBhYm91dCB0aGUgYmVsb3cgDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2luZmluaWJhbmQvY29yZS91bWVtLmMgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS91bWVt
LmMNCmluZGV4IGM1YjY4NjMuLjYxM2MxNmQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJh
bmQvY29yZS91bWVtLmMNCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3VtZW0uYw0KQEAg
LTQ1LDYgKzQ1LDggQEANCg0KICNpbmNsdWRlICJ1dmVyYnMuaCINCg0KKyNkZWZpbmUgUkVTQ0hF
RF9MT09QX0NOVF9USFJFU0hPTEQgMHhmZmYNCisNCiBzdGF0aWMgdm9pZCBfX2liX3VtZW1fcmVs
ZWFzZShzdHJ1Y3QgaWJfZGV2aWNlICpkZXYsIHN0cnVjdCBpYl91bWVtICp1bWVtLCBpbnQgZGly
dHkpDQogew0KICAgICAgICBib29sIG1ha2VfZGlydHkgPSB1bWVtLT53cml0YWJsZSAmJiBkaXJ0
eTsNCkBAIC01NSwxMCArNTcsMTUgQEAgc3RhdGljIHZvaWQgX19pYl91bWVtX3JlbGVhc2Uoc3Ry
dWN0IGliX2RldmljZSAqZGV2LCBzdHJ1Y3QgaWJfdW1lbSAqdW1lbSwgaW50IGQNCiAgICAgICAg
ICAgICAgICBpYl9kbWFfdW5tYXBfc2d0YWJsZV9hdHRycyhkZXYsICZ1bWVtLT5zZ3RfYXBwZW5k
LnNndCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBETUFfQklE
SVJFQ1RJT05BTCwgMCk7DQoNCi0gICAgICAgZm9yX2VhY2hfc2d0YWJsZV9zZygmdW1lbS0+c2d0
X2FwcGVuZC5zZ3QsIHNnLCBpKQ0KKyAgICAgICBmb3JfZWFjaF9zZ3RhYmxlX3NnKCZ1bWVtLT5z
Z3RfYXBwZW5kLnNndCwgc2csIGkpIHsNCiAgICAgICAgICAgICAgICB1bnBpbl91c2VyX3BhZ2Vf
cmFuZ2VfZGlydHlfbG9jayhzZ19wYWdlKHNnKSwNCiAgICAgICAgICAgICAgICAgICAgICAgIERJ
Vl9ST1VORF9VUChzZy0+bGVuZ3RoLCBQQUdFX1NJWkUpLCBtYWtlX2RpcnR5KTsNCg0KKyAgICAg
ICAgICAgICAgIGlmICghKGkgJiBSRVNDSEVEX0xPT1BfQ05UX1RIUkVTSE9MRCkpIHsNCisgICAg
ICAgICAgICAgICAgICAgICAgIGNvbmRfcmVzY2hlZCgpOw0KKyAgICAgICAgICAgICAgIH0NCisg
ICAgICAgfQ0KKw0KICAgICAgICBzZ19mcmVlX2FwcGVuZF90YWJsZSgmdW1lbS0+c2d0X2FwcGVu
ZCk7DQogfQ0KDQoNCi1MaQ0KDQo=


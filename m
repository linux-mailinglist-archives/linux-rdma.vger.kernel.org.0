Return-Path: <linux-rdma+bounces-14456-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9A4C56155
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 08:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E19C3B7C39
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EE832938B;
	Thu, 13 Nov 2025 07:39:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7232D432
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019541; cv=none; b=bNuBHqYt4SbpZlijW4tICVQjKA9wTuTd8ACup8bkXIzO3Sr3RZQYApQPj382HF1Z484VdRAyXieME5316ZArljPySGqjbF3bOUEcc6A2I/S/To7RDQ+w6FRZY/kIAPtQBZC0Ok/OjctwpC6ow526VrTlFGfDUVFhSfSzEjedutw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019541; c=relaxed/simple;
	bh=e/8cNnch4LKzwszTOLaNWbsfbb5OCmRDw6pEgKxVhS4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mMUgipPT4cADGDVNh5SsDiUdSlvZiIQPskFpSw0czSKeTa/PcCpIF8d7DClfGBq0PjUX5Z2z29olTI8KDvGr1KGM/HH5C2DcyCLQs8Si+9estH49Pf6wYwx82XDSOac0NqtqQDTAFWwUU8zxusdwxRYIpnYnakZ+hOxNPmAM6mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing" <lirongqing@baidu.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdIFJETUEvY29yZTogUHJl?=
 =?utf-8?B?dmVudCBzb2Z0IGxvY2t1cCBkdXJpbmcgbGFyZ2UgdXNlciBtZW1vcnkgcmVn?=
 =?utf-8?Q?ion_cleanup?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gUkRNQS9jb3JlOiBQcmV2ZW50?=
 =?utf-8?B?IHNvZnQgbG9ja3VwIGR1cmluZyBsYXJnZSB1c2VyIG1lbW9yeSByZWdpb24g?=
 =?utf-8?Q?cleanup?=
Thread-Index: AQHcUtj831ZC0pfzsEqn3ZVqQ3Xs+LTsm+cAgAOb+UA=
Date: Thu, 13 Nov 2025 07:38:36 +0000
Message-ID: <17f0ed8403a2456da5377aaf2ec4de94@baidu.com>
References: <20251111070107.2627-1-lirongqing@baidu.com>
 <dab01bc8-d07a-0ba5-405c-1acf14dbe401@hisilicon.com>
In-Reply-To: <dab01bc8-d07a-0ba5-405c-1acf14dbe401@hisilicon.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-FEAS-Client-IP: 172.31.3.14
X-FE-Policy-ID: 52:10:53:SYSTEM

DQo+IE9uIDIwMjUvMTEvMTEgMTU6MDEsIGxpcm9uZ3Fpbmcgd3JvdGU6DQo+ID4gRnJvbTogTGkg
Um9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0KPiA+DQo+ID4gV2hlbiBhIHByb2Nlc3Mg
ZXhpdHMgd2l0aCBudW1lcm91cyBsYXJnZSwgcGlubmVkIG1lbW9yeSByZWdpb25zDQo+ID4gY29u
c2lzdGluZyBvZiA0S0IgcGFnZXMsIHRoZSBjbGVhbnVwIG9mIHRoZSBtZW1vcnkgcmVnaW9uIHRo
cm91Z2gNCj4gPiBfX2liX3VtZW1fcmVsZWFzZSgpIG1heSBjYXVzZSBzb2Z0IGxvY2t1cHMuIFRo
aXMgaXMgYmVjYXVzZQ0KPiA+IHVucGluX3VzZXJfcGFnZV9yYW5nZV9kaXJ0eV9sb2NrKCkNCj4g
PiBpcyBjYWxsZWQgaW4gYSB0aWdodCBsb29wIGZvciB1bnBpbiBhbmQgcmVsZWFzaW5nIHBhZ2Ug
d2l0aG91dA0KPiA+IHlpZWxkaW5nIHRoZSBDUFUuDQo+ID4NCj4gPiBGaXggdGhlIHNvZnQgbG9j
a3VwIGJ5IGFkZGluZyBjb25kX3Jlc2NoZWQoKSBjYWxscyBpbg0KPiA+IF9faWJfdW1lbV9yZWxl
YXNlDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlk
dS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3VtZW0uYyB8IDEg
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS91bWVtLmMNCj4gPiBiL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL3VtZW0uYyBpbmRleCBjNWI2ODYzLi43MGMxNTIwIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL3VtZW0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW5maW5p
YmFuZC9jb3JlL3VtZW0uYw0KPiA+IEBAIC01OSw2ICs1OSw3IEBAIHN0YXRpYyB2b2lkIF9faWJf
dW1lbV9yZWxlYXNlKHN0cnVjdCBpYl9kZXZpY2UgKmRldiwNCj4gc3RydWN0IGliX3VtZW0gKnVt
ZW0sIGludCBkDQo+ID4gIAkJdW5waW5fdXNlcl9wYWdlX3JhbmdlX2RpcnR5X2xvY2soc2dfcGFn
ZShzZyksDQo+ID4gIAkJCURJVl9ST1VORF9VUChzZy0+bGVuZ3RoLCBQQUdFX1NJWkUpLCBtYWtl
X2RpcnR5KTsNCj4gPg0KPiA+ICsJY29uZF9yZXNjaGVkKCk7DQo+IA0KPiBJZiB0aGUgc29mdCBs
b2NrdXAgaXMgY2F1c2VkIGJ5IHVucGluX3VzZXJfcGFnZV9yYW5nZV9kaXJ0eV9sb2NrKCksDQo+
IGNvbmRfcmVzY2hlZCgpIHNob3VsZCBwcm9iYWJseSBiZSBpbnNpZGUgdGhlIGZvcl9lYWNoX3Nn
dGFibGVfc2cgbG9vcC4NCj4gDQoNCk9rLCBpdCBpcyBtb3JlIHJlYXNvbmFibGUgdG8gbW92ZSBp
dCBpbnNpZGUgdGhlIGxvb3AsIGFuZCBjYWxsaW5nIGNvbmRfcmVzY2hlZCBwZXIgMk0gc2hvdWxk
IGhhdmUgbGl0dGxlIHBlcmZvcm1hbmNlIGltcGFjdCwgYW5kIGRvbid0IG5lZWQgdG8gbGltaXQg
dGhlIGNhbGxpbmcgc3BlZWQuDQoNClRoYW5rcw0KDQotTGkNCg0KDQo+IEp1bnhpYW4NCj4gDQo+
ID4gIAlzZ19mcmVlX2FwcGVuZF90YWJsZSgmdW1lbS0+c2d0X2FwcGVuZCk7DQo+ID4gIH0NCj4g
Pg0K


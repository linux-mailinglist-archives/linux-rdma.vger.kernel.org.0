Return-Path: <linux-rdma+bounces-3564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB47591C24E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 17:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2C01C21CBE
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6DB1CD5C4;
	Fri, 28 Jun 2024 15:14:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E8D1CD5C0
	for <linux-rdma@vger.kernel.org>; Fri, 28 Jun 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587667; cv=none; b=TltHNKPWZNFEK7ak6irKOlPSzyKNDG67/kathRdKTtzmzkjeZfuEGnjqFPYbwL/GdZ1pO+155d28xdimaJkoWN7N3ZJzmYnXc8ECTw7/UqdyoGzfm+xziidlwTE2r3/qSxm8CxNC5adj3yKcmRjh/IRrbrYupcAtf9WEOzf4mLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587667; c=relaxed/simple;
	bh=Ys4VPchMhWKVdEXPg8bUnES5/7FLn984fnOf3f288VU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=aCxBnbtHUoLyhxYoERSRvno0tqPTdYzVRHeK5qR8/K2P4PddjGLSCcKwkZpxE2sxKoAuPv312s0fnIqKUMHTPwGVYpGeZ6cIvRApb6xCngJ7tOnHMw7MkGHbLrnR3YXqg8o3rJytaGc7/SfOWNtV+Zd04Ax51IxqicopQJAS61c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-178-4IonzigxN0uJZF0T4V44hQ-1; Fri, 28 Jun 2024 16:14:22 +0100
X-MC-Unique: 4IonzigxN0uJZF0T4V44hQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 28 Jun
 2024 16:13:45 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 28 Jun 2024 16:13:45 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Leon Romanovsky' <leon@kernel.org>, Anand Khoje
	<anand.a.khoje@oracle.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "saeedm@mellanox.com"
	<saeedm@mellanox.com>, "tariqt@nvidia.com" <tariqt@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v4] net/mlx5: Reclaim max 50K pages at once
Thread-Topic: [PATCH v4] net/mlx5: Reclaim max 50K pages at once
Thread-Index: AQHaxhzvGGuhtyfXHkeZpMTT2X9CjbHdTe4Q
Date: Fri, 28 Jun 2024 15:13:45 +0000
Message-ID: <3d5b16d332914d4f810bc0ce48fd8772@AcuMS.aculab.com>
References: <20240619132827.51306-1-anand.a.khoje@oracle.com>
 <20240624095757.GD29266@unreal>
In-Reply-To: <20240624095757.GD29266@unreal>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogTGVvbiBSb21hbm92c2t5DQo+IFNlbnQ6IDI0IEp1bmUgMjAyNCAxMDo1OA0KPiANCj4g
T24gV2VkLCBKdW4gMTksIDIwMjQgYXQgMDY6NTg6MjdQTSArMDUzMCwgQW5hbmQgS2hvamUgd3Jv
dGU6DQo+ID4gSW4gbm9uIEZMUiBjb250ZXh0LCBhdCB0aW1lcyBDWC01IHJlcXVlc3RzIHJlbGVh
c2Ugb2YgfjggbWlsbGlvbiBGVyBwYWdlcy4NCj4gPiBUaGlzIG5lZWRzIGh1bW9uZ291cyBudW1i
ZXIgb2YgY21kIG1haWxib3hlcywgd2hpY2ggdG8gYmUgcmVsZWFzZWQgb25jZQ0KPiA+IHRoZSBw
YWdlcyBhcmUgcmVjbGFpbWVkLiBSZWxlYXNlIG9mIGh1bW9uZ291cyBudW1iZXIgb2YgY21kIG1h
aWxib3hlcyBpcw0KPiA+IGNvbnN1bWluZyBjcHUgdGltZSBydW5uaW5nIGludG8gbWFueSBzZWNv
bmRzLiBXaGljaCB3aXRoIG5vbiBwcmVlbXB0aWJsZQ0KPiA+IGtlcm5lbHMgaXMgbGVhZGluZyB0
byBjcml0aWNhbCBwcm9jZXNzIHN0YXJ2aW5nIG9uIHRoYXQgY3B14oCZcyBSUS4NCj4gPiBUbyBh
bGxldmlhdGUgdGhpcywgdGhpcyBjaGFuZ2UgcmVzdHJpY3RzIHRoZSB0b3RhbCBudW1iZXIgb2Yg
cGFnZXMNCj4gPiBhIHdvcmtlciB3aWxsIHRyeSB0byByZWNsYWltIG1heGltdW0gNTBLIHBhZ2Vz
IGluIG9uZSBnby4NCj4gPiBUaGUgbGltaXQgNTBLIGlzIGFsaWduZWQgd2l0aCB0aGUgY3VycmVu
dCBmaXJtd2FyZSBjYXBhY2l0eS9saW1pdCBvZg0KPiA+IHJlbGVhc2luZyA1MEsgcGFnZXMgYXQg
b25jZSBwZXIgTUxYNV9DTURfT1BfTUFOQUdFX1BBR0VTICsgTUxYNV9QQUdFU19UQUtFDQo+ID4g
ZGV2aWNlIGNvbW1hbmQuDQo+ID4NCj4gPiBPdXIgdGVzdHMgaGF2ZSBzaG93biBzaWduaWZpY2Fu
dCBiZW5lZml0IG9mIHRoaXMgY2hhbmdlIGluIHRlcm1zIG9mDQo+ID4gdGltZSBjb25zdW1lZCBi
eSBkbWFfcG9vbF9mcmVlKCkuDQo+ID4gRHVyaW5nIGEgdGVzdCB3aGVyZSBhbiBldmVudCB3YXMg
cmFpc2VkIGJ5IEhDQQ0KPiA+IHRvIHJlbGVhc2UgMS4zIE1pbGxpb24gcGFnZXMsIGZvbGxvd2lu
ZyBvYnNlcnZhdGlvbnMgd2VyZSBtYWRlOg0KPiA+DQo+ID4gLSBXaXRob3V0IHRoaXMgY2hhbmdl
Og0KPiA+IE51bWJlciBvZiBtYWlsYm94IG1lc3NhZ2VzIGFsbG9jYXRlZCB3YXMgYXJvdW5kIDIw
SywgdG8gYWNjb21tb2RhdGUNCj4gPiB0aGUgRE1BIGFkZHJlc3NlcyBvZiAxLjMgbWlsbGlvbiBw
YWdlcy4NCj4gPiBUaGUgYXZlcmFnZSB0aW1lIHNwZW50IGJ5IGRtYV9wb29sX2ZyZWUoKSB0byBm
cmVlIHRoZSBETUEgcG9vbCBpcyBiZXR3ZWVuDQo+ID4gMTYgdXNlYyB0byAzMiB1c2VjLg0KPiA+
ICAgICAgICAgICAgdmFsdWUgIC0tLS0tLS0tLS0tLS0gRGlzdHJpYnV0aW9uIC0tLS0tLS0tLS0t
LS0gY291bnQNCj4gPiAgICAgICAgICAgICAgMjU2IHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDANCj4gPiAgICAgICAgICAgICAgNTEyIHxAICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDI4Nw0KPiA+ICAgICAgICAgICAgIDEwMjQgfEBAQCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTMzMg0KPiA+ICAgICAgICAgICAg
IDIwNDggfEAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNjU2DQo+ID4g
ICAgICAgICAgICAgNDA5NiB8QEBAQEAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAyNTk5DQo+ID4gICAgICAgICAgICAgODE5MiB8QEBAQEBAQEBAQCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA0NzU1DQo+ID4gICAgICAgICAgICAxNjM4NCB8QEBAQEBAQEBAQEBAQEBA
ICAgICAgICAgICAgICAgICAgICAgICAgICA3NTQ1DQo+ID4gICAgICAgICAgICAzMjc2OCB8QEBA
QEAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyNTAxDQo+ID4gICAgICAgICAg
ICA2NTUzNiB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwDQo+ID4N
Cj4gPiAtIFdpdGggdGhpcyBjaGFuZ2U6DQo+ID4gTnVtYmVyIG9mIG1haWxib3ggbWVzc2FnZXMg
YWxsb2NhdGVkIHdhcyBhcm91bmQgODAwOyB0aGlzIHdhcyB0bw0KPiA+IGFjY29tbW9kYXRlIERN
QSBhZGRyZXNzZXMgb2Ygb25seSA1MEsgcGFnZXMuDQo+ID4gVGhlIGF2ZXJhZ2UgdGltZSBzcGVu
dCBieSBkbWFfcG9vbF9mcmVlKCkgdG8gZnJlZSB0aGUgRE1BIHBvb2wgaW4gdGhpcyBjYXNlDQo+
ID4gbGllcyBiZXR3ZWVuIDEgdXNlYyB0byAyIHVzZWMuDQo+ID4gICAgICAgICAgICB2YWx1ZSAg
LS0tLS0tLS0tLS0tLSBEaXN0cmlidXRpb24gLS0tLS0tLS0tLS0tLSBjb3VudA0KPiA+ICAgICAg
ICAgICAgICAyNTYgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMA0K
PiA+ICAgICAgICAgICAgICA1MTIgfEBAQEBAQEBAQEBAQEBAQEBAQCAgICAgICAgICAgICAgICAg
ICAgICAgMzQ2DQo+ID4gICAgICAgICAgICAgMTAyNCB8QEBAQEBAQEBAQEBAQEBAQEBAQEBAQCAg
ICAgICAgICAgICAgICAgICA0MzUNCj4gPiAgICAgICAgICAgICAyMDQ4IHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDANCj4gPiAgICAgICAgICAgICA0MDk2IHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDANCj4gPiAgICAgICAgICAgICA4
MTkyIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDENCj4gPiAgICAg
ICAgICAgIDE2Mzg0IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAN
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuYW5kIEtob2plIDxhbmFuZC5hLmtob2plQG9yYWNs
ZS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5j
b20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2NDoNCj4gPiAgIC0gRml4ZWQgYSBuaXQgaW4g
cGF0Y2ggc3ViamVjdC4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFu
b3gvbWx4NS9jb3JlL3BhZ2VhbGxvYy5jIHwgNyArKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvcGFnZWFsbG9jLmMNCj4gYi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvcGFnZWFsbG9jLmMNCj4gPiBp
bmRleCBkY2Y1OGVmLi4wNmVlZTNhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21lbGxhbm94L21seDUvY29yZS9wYWdlYWxsb2MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9wYWdlYWxsb2MuYw0KPiA+IEBAIC02MDgsNiAr
NjA4LDcgQEAgZW51bSB7DQo+ID4gIAlSRUxFQVNFX0FMTF9QQUdFU19NQVNLID0gMHg0MDAwLA0K
PiA+ICB9Ow0KPiA+DQo+ID4gKyNkZWZpbmUgTUFYX1JFQ0xBSU1fTlBBR0VTIC01MDAwMA0KDQpJ
dCB3b3VsZCBiZSB0cmFkaXRpb25hbCB0byBlbmNsb3NlIGEgbmVnYXRpdmUgdmFsdWUgaW4gKCku
DQooQWx0aG91Z2ggb25seSAzMCsgeWVhciBvbGQgY29tcGlsZXJzIHdvdWxkIGdlbmVyYXRlIHVu
ZXhwZWN0ZWQgY29kZSBmb3INCglmb28tTUFYX1JFQ0xBSU1fTlBBR0VTDQphbmQgeW91IGhhdmUg
dG8gZ28gYmFjayBpbnRvIHRoZSAxOTcwcyBmb3INCglmb289TUFYX1JFQ0xBSU1fTlBBR0VTDQp0
byBiZSBhIHByb2JsZW0uKQ0KDQo+ID4gIHN0YXRpYyBpbnQgcmVxX3BhZ2VzX2hhbmRsZXIoc3Ry
dWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwNCj4gPiAgCQkJICAgICB1bnNpZ25lZCBsb25nIHR5cGUs
IHZvaWQgKmRhdGEpDQo+ID4gIHsNCj4gPiBAQCAtNjM5LDkgKzY0MCwxMyBAQCBzdGF0aWMgaW50
IHJlcV9wYWdlc19oYW5kbGVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsDQo+ID4NCj4gPiAg
CXJlcS0+ZGV2ID0gZGV2Ow0KPiA+ICAJcmVxLT5mdW5jX2lkID0gZnVuY19pZDsNCj4gPiAtCXJl
cS0+bnBhZ2VzID0gbnBhZ2VzOw0KPiA+ICAJcmVxLT5lY19mdW5jdGlvbiA9IGVjX2Z1bmN0aW9u
Ow0KPiA+ICAJcmVxLT5yZWxlYXNlX2FsbCA9IHJlbGVhc2VfYWxsOw0KPiA+ICsJaWYgKG5wYWdl
cyA8IE1BWF9SRUNMQUlNX05QQUdFUykNCj4gPiArCQlyZXEtPm5wYWdlcyA9IE1BWF9SRUNMQUlN
X05QQUdFUzsNCj4gPiArCWVsc2UNCj4gPiArCQlyZXEtPm5wYWdlcyA9IG5wYWdlczsNCj4gPiAr
DQo+IA0KPiBCVFcsIHRoaXMgY2FuIGJlIHdyaXR0ZW4gYXM6DQo+IAlyZXEtPm5wYWdlcyA9IG1h
eF90KHMzMiwgbnBhZ2VzLCBNQVhfUkVDTEFJTV9OUEFHRVMpOw0KDQpUaGF0IHNob3VsZG4ndCBu
ZWVkIGFsbCB0aGUgKHMzMikgY2FzdHMuDQooSSBkb24ndCB0aGluayBpdCBldmVuIG5lZWRlZCB0
aGVtIGJlZm9yZSBJIHJlbGF4ZWQgdGhlIHR5cGUgY2hlY2suKQ0KDQoJRGF2aWQNCg0KPiANCj4g
VGhhbmtzDQo+IA0KPiA+ICAJSU5JVF9XT1JLKCZyZXEtPndvcmssIHBhZ2VzX3dvcmtfaGFuZGxl
cik7DQo+ID4gIAlxdWV1ZV93b3JrKGRldi0+cHJpdi5wZ193cSwgJnJlcS0+d29yayk7DQo+ID4g
IAlyZXR1cm4gTk9USUZZX09LOw0KPiA+IC0tDQo+ID4gMS44LjMuMQ0KPiA+DQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==



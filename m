Return-Path: <linux-rdma+bounces-17153-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FN/NfvlnmkCXwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17153-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:07:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E1F197007
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E97E3022F54
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3E03ACF00;
	Wed, 25 Feb 2026 12:07:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5D310636;
	Wed, 25 Feb 2026 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021241; cv=none; b=BwmTiGo4y4BHSMl/e8VQkU++daG02gVBAB0DLGU/0ehuHeISg8sSPZPBZm2Y9yTeNVVDg/EYyk29UoxI1eOK9E50cgb1WB2ygrw7HFryfW1JvFPQTN6UXXKMEEk+Tq02CLv/2C8/V+ZMRcnDgfN/5E89c2CMdHBdo9phVrpa0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021241; c=relaxed/simple;
	bh=XdfxQTAGFFiWV0+5lnwv6lnZCALsXt3z0L3rj4/9ktc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7HyMFEUm18ztZGQe1qBAaqnLiZzvM2JpQxntuNFwXoax2mbu5c1bT+FDQcp+1u01UfL7Gduvb0YsB+17WGCyuWKuWYSr71NRM9oif1XY5yzFE1mMq2fk0Kslt6yUhXhe2PryFaULFVBKtgvdDhgf0TWkgHtkilmDeLTyWMKmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
To: Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen
	<kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBb5aSW6YOo6YKu5Lu2XSBSZTogW1BBVENIXVtyZG1hLW5leHRd?=
 =?utf-8?B?IFJETUEvZXJkbWE6IFVzZSBOVU1BLWF3YXJlIGFsbG9jYXRpb24gZm9yIE1U?=
 =?utf-8?Q?T_tables?=
Thread-Topic: =?utf-8?B?W+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF1bcmRtYS1uZXh0XSBSRE1BL2Vy?=
 =?utf-8?Q?dma:_Use_NUMA-aware_allocation_for_MTT_tables?=
Thread-Index: AQHcpjP7k/Iw+4Dad0OC8kUjGmV+c7WSwrOAgACIcJCAAAZBQA==
Date: Wed, 25 Feb 2026 12:07:05 +0000
Message-ID: <b00bcf9a1aee447eb64d955c52851c05@baidu.com>
References: <20260225085143.1721-1-lirongqing@baidu.com>
 <7cfd31d3-fe40-8b2d-cea8-14748db5f35b@linux.alibaba.com>
 <81eac7dd27d344b59da16bd4cef7bc77@baidu.com>
In-Reply-To: <81eac7dd27d344b59da16bd4cef7bc77@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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
X-FEAS-Client-IP: 172.31.50.46
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-17153-lists,linux-rdma=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 56E1F197007
X-Rspamd-Action: no action

DQo+ID4gT24gMi8yNS8yNiA0OjUx4oCvUE0sIGxpcm9uZ3Fpbmcgd3JvdGU6DQo+ID4gPiBGcm9t
OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gPg0KPiA+ID4gQ3VycmVu
dGx5LCBNVFQgKE1lbW9yeSBUcmFuc2xhdGlvbiBUYWJsZSkgYnVmZmVycyBhcmUgYWxsb2NhdGVk
DQo+ID4gPiB3aXRob3V0IE5VTUEgYXdhcmVuZXNzIHVzaW5nIGt6YWxsb2MoKSBhbmQgdnphbGxv
YygpLCB3aGljaCBhbGxvY2F0ZQ0KPiA+ID4gbWVtb3J5IG9uIHRoZSBOVU1BIG5vZGUgb2YgdGhl
IGNhbGxpbmcgQ1BVLiBUaGlzIGNhbiBsZWFkIHRvDQo+ID4gPiBjcm9zcy1ub2RlIG1lbW9yeSBh
Y2Nlc3MgbGF0ZW5jaWVzIGlmIHRoZSBlcmRtYSBkZXZpY2UgaXMgYXR0YWNoZWQNCj4gPiA+IHRv
IGEgZGlmZmVyZW50IE5VTUEgc29ja2V0Lg0KPiA+ID4NCj4gPiA+IFN3aXRjaCB0byBremFsbG9j
X25vZGUoKSBhbmQgdnphbGxvY19ub2RlKCkgdG8gZW5zdXJlIE1UVCBidWZmZXJzDQo+ID4gPiBh
cmUgYWxsb2NhdGVkIG9uIHRoZSBsb2NhbCBOVU1BIG5vZGUgb2YgdGhlIFBDSWUgZGV2aWNlDQo+
IChkZXYtPmF0dHJzLm51bWFfbm9kZSkuDQo+ID4gPiBUaGlzIHJlZHVjZXMgbGF0ZW5jeSBmb3Ig
aGFyZHdhcmUgYWNjZXNzIGFuZCBpbXByb3ZlcyBwZXJmb3JtYW5jZS4NCj4gPiA+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gPiAt
LS0NCj4gPiA+ICBkcml2ZXJzL2luZmluaWJhbmQvaHcvZXJkbWEvZXJkbWFfdmVyYnMuYyB8IDQg
KystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4gPg0KPiA+DQo+ID4gSGksIExpIFJvbmdRaW5nLA0KPiA+DQo+ID4gVGhhbmtzIGZv
ciB0aGUgcGF0Y2guIEhvd2V2ZXIsIEkgdGhpbmsgaXQgaXMgYmV0dGVyIHRvIGtlZXAgdGhlDQo+
ID4gY3VycmVudCBiZWhhdmlvciwgZm9yIHRoZSBmb2xsb3dpbmcgcmVhc29uczoNCj4gPg0KPiA+
IDEuIFRoaXMgcGF0aCBpcyBpbiB0aGUgY29udHJvbCBwbGFuZSwgc28gYWxsb2NhdGluZyBtZW1v
cnkgZnJvbSBhIHJlbW90ZQ0KPiA+ICAgIE5VTUEgbm9kZSBzaG91bGQgbm90IGhhdmUgYSBub3Rp
Y2VhYmxlIHBlcmZvcm1hbmNlIGltcGFjdC4NCj4gDQo+IElmIFRMQiBNaXNzICwgb3IgdGhlIGlu
dGVybmFsIGNhY2hlIG1pc3NlcyAsIGRvZXMgdGhlIEhDQSBuZWVkIHRvIHF1ZXJ5IHRoZSBNVFQ/
DQo+IA0KPiBbTGksUm9uZ3FpbmddDQo+IA0KPiA+IDIuIFdpdGggdGhpcyBjaGFuZ2UsIHRoZSBk
cml2ZXIgbWF5IGZhaWwgdGhlIGFsbG9jYXRpb24gd2hlbiB0aGUgbG9jYWwgTlVNQQ0KPiA+ICAg
IG5vZGUgaXMgb3V0IG9mIG1lbW9yeSwgZXZlbiBpZiBvdGhlciBub2RlcyBzdGlsbCBoYXZlIGF2
YWlsYWJsZSBtZW1vcnkuDQo+ID4NCg0KDQpXaGVuIGttYWxsb2Nfbm9kZSgpIGlzIGNhbGxlZCB3
aXRob3V0IF9fR0ZQX1RISVNOT0RFIGFuZCB0aGUgdGFyZ2V0IG5vZGUNCmxhY2tzIHN1ZmZpY2ll
bnQgbWVtb3J5LCBTTFVCIGFsbG9jYXRlcyBhIGZvbGlvIGZyb20gYSBkaWZmZXJlbnQgbm9kZQ0K
b3RoZXIgdGhhbiB0aGUgcmVxdWVzdGVkIG5vZGUuDQoNClNvIEkgdGhpbmsgdGhpcyBpcyBub3Qg
YSBwcm9ibGVtLg0KDQpbTGksUm9uZ3FpbmddIA0KDQoNCg0KPiA+IFRoYW5rcywNCj4gPiBDaGVu
ZyBYdQ0KPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1h
L2VyZG1hX3ZlcmJzLmMNCj4gPiA+IGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1h
X3ZlcmJzLmMNCj4gPiA+IGluZGV4IDlmNzRhYWQuLjU4ZGE2ZWYgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9kcml2ZXJzL2luZmluaWJhbmQvaHcvZXJkbWEvZXJkbWFfdmVyYnMuYw0KPiA+ID4gKysrIGIv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX3ZlcmJzLmMNCj4gPiA+IEBAIC02MDQs
NyArNjA0LDcgQEAgc3RhdGljIHN0cnVjdCBlcmRtYV9tdHQNCj4gPiAqZXJkbWFfY3JlYXRlX2Nv
bnRfbXR0KHN0cnVjdCBlcmRtYV9kZXYgKmRldiwNCj4gPiA+ICAJCXJldHVybiBFUlJfUFRSKC1F
Tk9NRU0pOw0KPiA+ID4NCj4gPiA+ICAJbXR0LT5zaXplID0gc2l6ZTsNCj4gPiA+IC0JbXR0LT5i
dWYgPSBremFsbG9jKG10dC0+c2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gPiArCW10dC0+YnVmID0g
a3phbGxvY19ub2RlKG10dC0+c2l6ZSwgR0ZQX0tFUk5FTCwNCj4gPiA+ICtkZXYtPmF0dHJzLm51
bWFfbm9kZSk7DQo+ID4gPiAgCWlmICghbXR0LT5idWYpDQo+ID4gPiAgCQlnb3RvIGVycl9mcmVl
X210dDsNCj4gPiA+DQo+ID4gPiBAQCAtNzI5LDcgKzcyOSw3IEBAIHN0YXRpYyBzdHJ1Y3QgZXJk
bWFfbXR0DQo+ID4gKmVyZG1hX2NyZWF0ZV9zY2F0dGVyX210dChzdHJ1Y3QgZXJkbWFfZGV2ICpk
ZXYsDQo+ID4gPiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPiA+DQo+ID4gPiAgCW10
dC0+c2l6ZSA9IEFMSUdOKHNpemUsIFBBR0VfU0laRSk7DQo+ID4gPiAtCW10dC0+YnVmID0gdnph
bGxvYyhtdHQtPnNpemUpOw0KPiA+ID4gKwltdHQtPmJ1ZiA9IHZ6YWxsb2Nfbm9kZShtdHQtPnNp
emUsIGRldi0+YXR0cnMubnVtYV9ub2RlKTsNCj4gPiA+ICAJbXR0LT5jb250aW51b3VzID0gZmFs
c2U7DQo+ID4gPiAgCWlmICghbXR0LT5idWYpDQo+ID4gPiAgCQlnb3RvIGVycl9mcmVlX210dDsN
Cg==


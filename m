Return-Path: <linux-rdma+bounces-17151-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKTqJ4rhnmmCXgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17151-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:48:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40666196DA0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 12:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C8A43023DEE
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 11:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8B43A9D86;
	Wed, 25 Feb 2026 11:47:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670F310636;
	Wed, 25 Feb 2026 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020035; cv=none; b=P47qEcb7ZN1vAdcVJ6t9JVPqb4PJL7iEcwkrHwl9XmFLEr9Uk3qzmkEyvAgX6SLsC/mdyZZlhuVmJrgCPK+K4E96WDbanq9AOv17uOZWxPdrOWYaJZ+5Pdud4vNYMEEBaFPvLdlODWTgiDp9QYI+K4FdK+WobpISW1H/rg917MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020035; c=relaxed/simple;
	bh=KXvoUiyNTwvZY7mwgFaTUUoicsUJb7afqifG+njiBWE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GoNuymry/ZFGG9MBifeIu5a/1uTDMWGKLw0DgxNlBiyblC7gLi+ZBQD1U8UmQVAie940EfYUpoPJfLwmh9Faoig+nrYHglAoqJ6OwhtorZ82qhyP8k6kdzt5Uhyr5O5EPlNa4qIqHmeOJXtv71sysltJakCJJzSxVNPQwkreQ+4=
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
Thread-Index: AQHcpjP7k/Iw+4Dad0OC8kUjGmV+c7WSwrOAgACIcJA=
Date: Wed, 25 Feb 2026 11:46:57 +0000
Message-ID: <81eac7dd27d344b59da16bd4cef7bc77@baidu.com>
References: <20260225085143.1721-1-lirongqing@baidu.com>
 <7cfd31d3-fe40-8b2d-cea8-14748db5f35b@linux.alibaba.com>
In-Reply-To: <7cfd31d3-fe40-8b2d-cea8-14748db5f35b@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17151-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40666196DA0
X-Rspamd-Action: no action

DQo+IE9uIDIvMjUvMjYgNDo1MeKAr1BNLCBsaXJvbmdxaW5nIHdyb3RlOg0KPiA+IEZyb206IExp
IFJvbmdRaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gPg0KPiA+IEN1cnJlbnRseSwgTVRU
IChNZW1vcnkgVHJhbnNsYXRpb24gVGFibGUpIGJ1ZmZlcnMgYXJlIGFsbG9jYXRlZA0KPiA+IHdp
dGhvdXQgTlVNQSBhd2FyZW5lc3MgdXNpbmcga3phbGxvYygpIGFuZCB2emFsbG9jKCksIHdoaWNo
IGFsbG9jYXRlDQo+ID4gbWVtb3J5IG9uIHRoZSBOVU1BIG5vZGUgb2YgdGhlIGNhbGxpbmcgQ1BV
LiBUaGlzIGNhbiBsZWFkIHRvDQo+ID4gY3Jvc3Mtbm9kZSBtZW1vcnkgYWNjZXNzIGxhdGVuY2ll
cyBpZiB0aGUgZXJkbWEgZGV2aWNlIGlzIGF0dGFjaGVkIHRvDQo+ID4gYSBkaWZmZXJlbnQgTlVN
QSBzb2NrZXQuDQo+ID4NCj4gPiBTd2l0Y2ggdG8ga3phbGxvY19ub2RlKCkgYW5kIHZ6YWxsb2Nf
bm9kZSgpIHRvIGVuc3VyZSBNVFQgYnVmZmVycyBhcmUNCj4gPiBhbGxvY2F0ZWQgb24gdGhlIGxv
Y2FsIE5VTUEgbm9kZSBvZiB0aGUgUENJZSBkZXZpY2UgKGRldi0+YXR0cnMubnVtYV9ub2RlKS4N
Cj4gPiBUaGlzIHJlZHVjZXMgbGF0ZW5jeSBmb3IgaGFyZHdhcmUgYWNjZXNzIGFuZCBpbXByb3Zl
cyBwZXJmb3JtYW5jZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpIFJvbmdRaW5nIDxsaXJv
bmdxaW5nQGJhaWR1LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2Vy
ZG1hL2VyZG1hX3ZlcmJzLmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gSGksIExpIFJvbmdRaW5nLA0KPiAN
Cj4gVGhhbmtzIGZvciB0aGUgcGF0Y2guIEhvd2V2ZXIsIEkgdGhpbmsgaXQgaXMgYmV0dGVyIHRv
IGtlZXAgdGhlIGN1cnJlbnQgYmVoYXZpb3IsDQo+IGZvciB0aGUgZm9sbG93aW5nIHJlYXNvbnM6
DQo+IA0KPiAxLiBUaGlzIHBhdGggaXMgaW4gdGhlIGNvbnRyb2wgcGxhbmUsIHNvIGFsbG9jYXRp
bmcgbWVtb3J5IGZyb20gYSByZW1vdGUNCj4gICAgTlVNQSBub2RlIHNob3VsZCBub3QgaGF2ZSBh
IG5vdGljZWFibGUgcGVyZm9ybWFuY2UgaW1wYWN0Lg0KDQpJZiBUTEIgTWlzcyAsIG9yIHRoZSBp
bnRlcm5hbCBjYWNoZSBtaXNzZXMgLCBkb2VzIHRoZSBIQ0EgbmVlZCB0byBxdWVyeSB0aGUgTVRU
Pw0KDQpbTGksUm9uZ3FpbmddIA0KDQo+IDIuIFdpdGggdGhpcyBjaGFuZ2UsIHRoZSBkcml2ZXIg
bWF5IGZhaWwgdGhlIGFsbG9jYXRpb24gd2hlbiB0aGUgbG9jYWwgTlVNQQ0KPiAgICBub2RlIGlz
IG91dCBvZiBtZW1vcnksIGV2ZW4gaWYgb3RoZXIgbm9kZXMgc3RpbGwgaGF2ZSBhdmFpbGFibGUg
bWVtb3J5Lg0KPiANCj4gVGhhbmtzLA0KPiBDaGVuZyBYdQ0KPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9pbmZpbmliYW5kL2h3L2VyZG1hL2VyZG1hX3ZlcmJzLmMNCj4gPiBiL2RyaXZlcnMv
aW5maW5pYmFuZC9ody9lcmRtYS9lcmRtYV92ZXJicy5jDQo+ID4gaW5kZXggOWY3NGFhZC4uNThk
YTZlZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvZXJkbWEvZXJkbWFf
dmVyYnMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9lcmRtYS9lcmRtYV92ZXJi
cy5jDQo+ID4gQEAgLTYwNCw3ICs2MDQsNyBAQCBzdGF0aWMgc3RydWN0IGVyZG1hX210dA0KPiAq
ZXJkbWFfY3JlYXRlX2NvbnRfbXR0KHN0cnVjdCBlcmRtYV9kZXYgKmRldiwNCj4gPiAgCQlyZXR1
cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPg0KPiA+ICAJbXR0LT5zaXplID0gc2l6ZTsNCj4gPiAt
CW10dC0+YnVmID0ga3phbGxvYyhtdHQtPnNpemUsIEdGUF9LRVJORUwpOw0KPiA+ICsJbXR0LT5i
dWYgPSBremFsbG9jX25vZGUobXR0LT5zaXplLCBHRlBfS0VSTkVMLA0KPiA+ICtkZXYtPmF0dHJz
Lm51bWFfbm9kZSk7DQo+ID4gIAlpZiAoIW10dC0+YnVmKQ0KPiA+ICAJCWdvdG8gZXJyX2ZyZWVf
bXR0Ow0KPiA+DQo+ID4gQEAgLTcyOSw3ICs3MjksNyBAQCBzdGF0aWMgc3RydWN0IGVyZG1hX210
dA0KPiAqZXJkbWFfY3JlYXRlX3NjYXR0ZXJfbXR0KHN0cnVjdCBlcmRtYV9kZXYgKmRldiwNCj4g
PiAgCQlyZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gPg0KPiA+ICAJbXR0LT5zaXplID0gQUxJ
R04oc2l6ZSwgUEFHRV9TSVpFKTsNCj4gPiAtCW10dC0+YnVmID0gdnphbGxvYyhtdHQtPnNpemUp
Ow0KPiA+ICsJbXR0LT5idWYgPSB2emFsbG9jX25vZGUobXR0LT5zaXplLCBkZXYtPmF0dHJzLm51
bWFfbm9kZSk7DQo+ID4gIAltdHQtPmNvbnRpbnVvdXMgPSBmYWxzZTsNCj4gPiAgCWlmICghbXR0
LT5idWYpDQo+ID4gIAkJZ290byBlcnJfZnJlZV9tdHQ7DQo=


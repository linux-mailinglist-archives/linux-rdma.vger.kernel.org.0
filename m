Return-Path: <linux-rdma+bounces-17572-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLKsL9dkqmnnQgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17572-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 06:23:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029E21BAFC
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 06:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0E993030481
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 05:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A442B36D4EE;
	Fri,  6 Mar 2026 05:23:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974A2D8768
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 05:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772774612; cv=none; b=iITckCCHE09PI4aHcyoqBrQqBPUd2Oy6hSYxcXACsam69pXvfuR2z0cByWgwsEptx/uUWVfy7qtWGcVnQIkxjVzq0rMSm8CpU4Vi7eevz5k7SPoIhXPrmMitQEKNHubKR6m44mncBYbi2QJlatImsKJbMKlzB+Nm8XHlin/X774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772774612; c=relaxed/simple;
	bh=s3k2mgBoQGh3L/3YjS0PQ2rHxqsbANY9I+XS5dAHRxU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YOCa3jdhnn9pbkCUvRurzSHNPUom4tH4ZbaLbYvMdDM0jpcoiuXuA95KysZBVlic2eVno99zdXejM3FKTqvxOO7qIoqYl5t1DcsKBnGlnV2sT0w6eMr/yiFNTjtTQ/rcSm+94q0q4X1AO0JPrlLGpjBiT2h2+4Vo6lhL0Fz04lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXVtyZG1hLW5leHRdIFJETUEvbWx4NTogVXNlIE5VTUEt?=
 =?gb2312?Q?aware_allocation_for_memory_region_descriptors?=
Thread-Topic: [PATCH][rdma-next] RDMA/mlx5: Use NUMA-aware allocation for
 memory region descriptors
Thread-Index: AQHcpW0aEbCJ3J+x706Dz8WRJyEPeLWhB6eQ
Date: Fri, 6 Mar 2026 05:23:07 +0000
Message-ID: <ccaf962222eb41a6a909ec434ccb80c6@baidu.com>
References: <20260224090757.1761-1-lirongqing@baidu.com>
In-Reply-To: <20260224090757.1761-1-lirongqing@baidu.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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
X-FEAS-Client-IP: 172.31.3.11
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Queue-Id: 4029E21BAFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17572-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

DQo+IFRoZSBtbHg1X2FsbG9jX3ByaXZfZGVzY3MoKSBmdW5jdGlvbiBjdXJyZW50bHkgdXNlcyBr
emFsbG9jKCksIHdoaWNoIGFsbG9jYXRlcw0KPiBtZW1vcnkgb24gdGhlIE5VTUEgbm9kZSBvZiB0
aGUgY2FsbGluZyBDUFUuIE9uIG11bHRpLXNvY2tldCBzeXN0ZW1zLCB0aGlzDQo+IGNhbiBsZWFk
IHRvIGNyb3NzLW5vZGUgbWVtb3J5IGFjY2VzcyBpZiB0aGUgSENBIGlzIGF0dGFjaGVkIHRvIGEg
ZGlmZmVyZW50DQo+IE5VTUEgbm9kZSB0aGFuIHRoZSBwcm9jZXNzIGFsbG9jYXRpbmcgdGhlIE1l
bW9yeSBSZWdpb24gKE1SKS4NCj4gDQo+IFN3aXRjaCB0byBremFsbG9jX25vZGUoKSBhbmQgc3Bl
Y2lmeSB0aGUgbm9kZSBhc3NvY2lhdGVkIHdpdGggdGhlIEhDQSdzIERNQQ0KPiBkZXZpY2UuIFRo
aXMgZW5zdXJlcyB0aGF0IHRoZSBNUiBkZXNjcmlwdG9ycyBhcmUgcmVzaWRlbnQgb24gdGhlIGxv
Y2FsIE5VTUENCj4gbm9kZSwgcmVkdWNpbmcgbGF0ZW5jeSBmb3IgaGFyZHdhcmUgYWNjZXNzLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPg0K
DQpwaW5nDQoNCltMaSxSb25ncWluZ10gDQoNCg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9pbmZpbmli
YW5kL2h3L21seDUvbXIuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pbmZpbmliYW5k
L2h3L21seDUvbXIuYyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9tbHg1L21yLmMNCj4gaW5kZXgg
NjY1MzIzYi4uNWY0YjRkYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2h3L21s
eDUvbXIuYw0KPiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcvbWx4NS9tci5jDQo+IEBAIC0x
OTkwLDcgKzE5OTAsOCBAQCBtbHg1X2FsbG9jX3ByaXZfZGVzY3Moc3RydWN0IGliX2RldmljZSAq
ZGV2aWNlLA0KPiAgCQlhZGRfc2l6ZSA9IG1pbl90KGludCwgZW5kIC0gc2l6ZSwgYWRkX3NpemUp
Ow0KPiAgCX0NCj4gDQo+IC0JbXItPmRlc2NzX2FsbG9jID0ga3phbGxvYyhzaXplICsgYWRkX3Np
emUsIEdGUF9LRVJORUwpOw0KPiArCW1yLT5kZXNjc19hbGxvYyA9IGt6YWxsb2Nfbm9kZShzaXpl
ICsgYWRkX3NpemUsIEdGUF9LRVJORUwsDQo+ICsJCQlkZXZfdG9fbm9kZShkZGV2KSk7DQo+ICAJ
aWYgKCFtci0+ZGVzY3NfYWxsb2MpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiANCj4gLS0NCj4g
Mi45LjQNCg0K


Return-Path: <linux-rdma+bounces-18171-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLCOLYhrt2kYRAEAu9opvQ
	(envelope-from <linux-rdma+bounces-18171-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 03:31:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C42294171
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 03:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C8A5305769C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 02:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D6B30C632;
	Mon, 16 Mar 2026 02:22:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979730DEB2;
	Mon, 16 Mar 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627756; cv=none; b=R4WvC/fh6wpgEEZfc8PZUdGEvKctWdqwSc7fGHqfJsyhUKgmXzkQ3MC7hdV5KpOeUIdLRq/BtGPaxEV5kwuMhsYQuvAweWx3NbxjB0X8qJy59EaNh4bG8Susg1wmg1c2Zcxo/RVJY5GuG/bF7j5n9XTlsG5Q6hHpNRxy8PYaRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627756; c=relaxed/simple;
	bh=/k+caWYYff434WaY+2GBc7G73Hh9Q9GVR2f3d3Rk5Y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VjOG/pC2wV19zv2i4HiJV8CUX4gjjEPbYrvH+/bfXyrDC/YbvAr7Fyt1/vnOZF44Y/1IXZ7oU6AC0D9VURR/9tx+8S4wqo9LaUEmpg6BVLX+kWxHdQvFODdZh/7NB88hZn3zwHknY6S3MIxkwS5ZjkIwRY++6fhFz4q6gZi0FQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: "Li,Rongqing(ACG CCN)" <lirongqing@baidu.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Paul E .
 McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, "Li,Yongkang(ACG CCN)" <liyongkang01@baidu.com>
Subject: =?gb2312?B?tPC4tDogWz8/Pz9dIFJlOiBbUEFUQ0hdW25ldC1uZXh0XSBuZXQvbWx4NTog?=
 =?gb2312?B?RXhwZWRpdGUgbm90aWZpZXIgdW5yZWdpc3RyYXRpb24gZHVyaW5nIGRldmlj?=
 =?gb2312?Q?e_teardown?=
Thread-Topic: [????] Re: [PATCH][net-next] net/mlx5: Expedite notifier
 unregistration during device teardown
Thread-Index: AQHcsgViu7FW/OLoFkmiUoQHYBUjUrWtzQoAgAKl4sA=
Date: Mon, 16 Mar 2026 02:21:44 +0000
Message-ID: <d10a6aaff92249dd9b8e3ec9623492b7@baidu.com>
References: <20260312094804.2744-1-lirongqing@baidu.com>
 <20260314105426.36ae4cba@kernel.org>
In-Reply-To: <20260314105426.36ae4cba@kernel.org>
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
X-FEAS-Client-IP: 172.31.50.12
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Spamd-Result: default: False [2.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18171-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 38C42294171
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiBUaHUsIDEyIE1hciAyMDI2IDA1OjQ4OjA0IC0wNDAwIGxpcm9uZ3Fpbmcgd3JvdGU6DQo+
ID4gRHVyaW5nIGRldmljZSBob3QtdW5wbHVnLCB0aGUgbWx4NSBkcml2ZXIgZXhwZWN0cyBxdWlj
a2x5IHVucmVnaXN0ZXINCj4gPiBub3RpZmljYXRpb24gY2hhaW5zLiBUaGUgc3RhbmRhcmQgYXRv
bWljX25vdGlmaWVyX2NoYWluX3VucmVnaXN0ZXIoKQ0KPiA+IGNhbGxzIHN5bmNocm9uaXplX3Jj
dSgpLCB3aGljaCBpbnRyb2R1Y2VzIHNpZ25pZmljYW50IGxhdGVuY3kgYW5kIGNhbg0KPiA+IGJl
Y29tZSBhIGJvdHRsZW5lY2sgZHVyaW5nIG1hc3MgcmVzb3VyY2UgY2xlYW51cC4NCj4gPg0KPiA+
IEludHJvZHVjZSBhdG9taWNfbm90aWZpZXJfY2hhaW5fdW5yZWdpc3Rlcl9leHBlZGl0ZWQoKSB0
byBsZXZlcmFnZQ0KPiA+IHN5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKSwgYW5kIHVzZSBpdCBz
aWduaWZpY2FudGx5IHJlZHVjaW5nIHdhaXQNCj4gPiB0aW1lcyBpbiB0aGUgZm9sbG93aW5nIHBh
dGhzOg0KPiA+ICAtIEV2ZW50IFF1ZXVlIChFUSkgbm90aWZpZXIgY2hhaW4NCj4gPiAgLSBGaXJt
d2FyZSBldmVudCBub3RpZmllciBjaGFpbg0KPiA+ICAtIElSUSBub3RpZmllciBjaGFpbg0KPiA+
DQo+ID4gVGhpcyBhY2NlbGVyYXRpb24gZW5zdXJlcyBmYXN0ZXIgdGVhcmRvd24gZHVyaW5nIGhv
dC11bnBsdWcgZXZlbnRzLg0KPiANCj4gU29tZSBkZXRhaWxlZCBleGFtcGxlIGFuZCBob3cgbG9u
ZyB0aGUgd2hvbGUgb3BlcmF0aW9uIHRha2VzIHdvdWxkIGJlIGdyZWF0DQo+IGluIHRoZSBjb21t
aXQgbXNnLg0KPiANCk9LLCBJIHdpbGwgYWRkIGluIHYyIA0KPiA+ICAvKioNCj4gPiArICoJYXRv
bWljX25vdGlmaWVyX2NoYWluX3VucmVnaXN0ZXJfZXhwZWRpdGVkIC0gUmVtb3ZlIG5vdGlmaWVy
IGZyb20gYW4NCj4gYXRvbWljIG5vdGlmaWVyIGNoYWluDQo+ID4gKyAqCUBuaDogUG9pbnRlciB0
byBoZWFkIG9mIHRoZSBhdG9taWMgbm90aWZpZXIgY2hhaW4NCj4gPiArICoJQG46IEVudHJ5IHRv
IHJlbW92ZSBmcm9tIG5vdGlmaWVyIGNoYWluDQo+ID4gKyAqDQo+ID4gKyAqCVJlbW92ZXMgYSBu
b3RpZmllciBmcm9tIGFuIGF0b21pYyBub3RpZmllciBjaGFpbiBhbmQgZm9yY2VmdWxseQ0KPiA+
ICsgKglhY2NlbGVyYXRlcyB0aGUgUkNVIGdyYWNlIHBlcmlvZC4NCj4gPiArICoNCj4gPiArICoJ
UmV0dXJucyB6ZXJvIG9uIHN1Y2Nlc3Mgb3IgJS1FTk9FTlQgb24gZmFpbHVyZS4NCj4gDQo+IFdh
cm5pbmc6IGtlcm5lbC9ub3RpZmllci5jOjIxMSBObyBkZXNjcmlwdGlvbiBmb3VuZCBmb3IgcmV0
dXJuIHZhbHVlIG9mDQo+ICdhdG9taWNfbm90aWZpZXJfY2hhaW5fdW5yZWdpc3Rlcl9leHBlZGl0
ZWQnDQo+IA0KPiBrZG9jIHdhbnRzIHlvdSB0byB1c2UgUmV0dXJuOiBvciBSZXR1cm5zOiB0aGUg
Y29sb24gaXMgaG93IGl0IGtub3dzIHRoaXMgaXMgdGhlDQo+IGRvYyBmb3IgcmV0dXJuIHZhbHVl
IG5vdCBqdXN0IGEgcmFuZG9tIG1lbnRpb24gb2YgdGhlIHdvcmQgUmV0dXJucw0KPiAtLQ0KSSB3
aWxsIGZpeCB0aGlzIGluIHYyDQoNClRoYW5rIHlvdQ0KDQpbTGksUm9uZ3FpbmddIA0KDQo+IHB3
LWJvdDogY3INCg==


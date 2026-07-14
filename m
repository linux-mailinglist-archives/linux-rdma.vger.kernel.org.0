Return-Path: <linux-rdma+bounces-23170-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id asp2EGWqVWoLrgAAu9opvQ
	(envelope-from <linux-rdma+bounces-23170-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 05:17:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D875095A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 05:17:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="S 3iFB9N";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23170-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23170-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 387CA3025A58
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 03:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BF73A254C;
	Tue, 14 Jul 2026 03:17:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EFD352017
	for <linux-rdma@vger.kernel.org>; Tue, 14 Jul 2026 03:17:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999074; cv=none; b=s2Hys2a6ewBuyXyivPhBlgKU5X/ydifOkhP4FevOhh0Drr/4ySNsXHDaNb/+OJmugrQPxvmsbTOY9YX6oyn/it9lnBQzjj3jTdXZnqWKba+44EVErgMAzkDCYgR8CxFhis2jGD+83FPPCw9hnnZJgUjOB9uVb3PvApPomcE1KLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999074; c=relaxed/simple;
	bh=zsSe0KuWqFQAQqhZFFHu+5mCeMUH6RhinBaayFDljgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=MnZsKugJP9kD4wl7ENvU80nKJWGwuMsZuvCJ9wKw/vJGXoHl63moeqfnGUVL7xu4DH0980YL593alCeM/FIXKMsBSvqxOOzvvTODeVEwFV2joyXfeSxGg3lDn1eXPN0NKKdI4ssHwcyGZW7azW77GGIfEYa+rqGdBpC69HOVqdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S3iFB9NH; arc=none smtp.client-ip=220.197.31.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=zsSe0KuWqFQAQqhZFFHu+5mCeMUH6RhinBaayFDljgg=; b=S
	3iFB9NHfVGhkqj8tJ7pNrg6W5lfHoFGNA6MhutvOFeibaVHFeLn0/8SKc1gqUGwi
	5f2RfJKZd/p5g6zTidDJObWjPPlF9qQ2cD5H+wD2vIFmbqv3cf6Qcfd3xBkxxwGY
	GSMuzbdWfF0h+Dm2NZ4ywPN0dtokXvgTZLqCfGBPFU=
Received: from 15927021679$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-123 (Coremail) ; Tue, 14 Jul 2026 11:17:32 +0800
 (CST)
Date: Tue, 14 Jul 2026 11:17:32 +0800 (CST)
From: "Xiong Weimin" <15927021679@163.com>
To: "Zhu Yanjun" <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, jgg@nvidia.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: Re:Re: [PATCH] RDMA/rxe: Reject unimplemented implicit ODP cleanly
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <99a613bd-8f32-4a7c-828f-b30097075e76@linux.dev>
References: <20260713010439.331054-1-15927021679@163.com>
 <99a613bd-8f32-4a7c-828f-b30097075e76@linux.dev>
X-NTES-SC: AL_Qu2TAfWStkgu5CSdZekckk8Ugeg8Xsewsvgh249ec8gEnS3E3gkne0R7OnDK/8GtCRqpuSi4WgNwye51fqNZhae7W9hx/b2NWHw4ilLkng==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2f63280c.2ec3.19f5ea13aaa.Coremail.15927021679@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eygvCgD3HzpNqlVq0l4dAA--.9050W
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0Q2tNmpVqk0KagAA3-
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23170-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yanjun.zhu@linux.dev,m:linux-rdma@vger.kernel.org,m:jgg@nvidia.com,m:xiongweimin@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[15927021679@163.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[15927021679@163.com,linux-rdma@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[163.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 506D875095A

CgoKVGhhbmtzIFpodSwgSSB3aWxsIGFkZCB5b3VyIFJldmlld2VkLWJ5IHRhZy4KCgpBdCAyMDI2
LTA3LTE0IDEwOjU1OjM3LCAiWmh1IFlhbmp1biIgPHlhbmp1bi56aHVAbGludXguZGV2PiB3cm90
ZToKPtTaIDIwMjYvNy8xMiAxODowNCwgd2VpbWluIHhpb25nINC0tcA6Cj4+IEZyb206IHhpb25n
d2VpbWluIDx4aW9uZ3dlaW1pbkBreWxpbm9zLmNuPgo+PiAKPj4gcnhlIGFkdmVydGlzZXMgT0RQ
IGJ1dCBub3QgSUJfT0RQX1NVUFBPUlRfSU1QTElDSVQuIFRoZSByZWdfdXNlcl9tciBwYXRoCj4+
IHN0aWxsIGNvbnRhaW5lZCBhIGRlYWQgYnJhbmNoIHRoYXQgY2hlY2tlZCB0aGUgaW1wbGljaXQg
Y2FwYWJpbGl0eSBhbmQKPj4gY291bGQgbmV2ZXIgc3VjY2VlZC4KPj4gCj4+IFJldHVybiAtRU9Q
Tk9UU1VQUCBmb3IgdGhlIGltcGxpY2l0IE9EUCBhZGRyZXNzIHJhbmdlIHVwIGZyb250IHNvIHRo
ZQo+PiBpbnRlbnQgaXMgb2J2aW91cyBhbmQgdGhlIHVucmVhY2hhYmxlIGNvZGUgaXMgZ29uZS4K
Pj4gCj4+IFNpZ25lZC1vZmYtYnk6IHhpb25nd2VpbWluIDx4aW9uZ3dlaW1pbkBreWxpbm9zLmNu
Pgo+PiBDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcKPj4gQ2M6IEphc29uIEd1bnRob3Jw
ZSA8amdnQG52aWRpYS5jb20+Cj4+IC0tLQo+PiAKPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5k
L3N3L3J4ZS9yeGVfb2RwLmMKPj4gKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVf
b2RwLmMKPj4gQEAgLTg3LDE0ICs4Nyw5IEBACj4+ICAgCj4+ICAgCXJ4ZV9tcl9pbml0KGFjY2Vz
c19mbGFncywgbXIpOwo+PiAgIAo+PiAtCWlmICghc3RhcnQgJiYgbGVuZ3RoID09IFU2NF9NQVgp
IHsKPj4gLQkJaWYgKGlvdmEgIT0gMCkKPj4gLQkJCXJldHVybiAtRUlOVkFMOwo+PiAtCQlpZiAo
IShyeGUtPmF0dHIub2RwX2NhcHMuZ2VuZXJhbF9jYXBzICYgSUJfT0RQX1NVUFBPUlRfSU1QTElD
SVQpKQo+PiAtCQkJcmV0dXJuIC1FSU5WQUw7Cj4+IC0KPj4gLQkJLyogTmV2ZXIgcmVhY2ggaGVy
ZSwgZm9yIGltcGxpY2l0IE9EUCBpcyBub3QgaW1wbGVtZW50ZWQuICovCj4+IC0JfQo+Cj5JdCBz
ZWVtcyB0aGF0IHRoZSBhYm92ZSBhcmUgZm9yIGltcGxpY2l0IE9EUC4gSG93ZXZlciB0aGUgaW1w
bGljaXQgT0RQIAo+aXMgbm90IGltcGxlbWVudGVkIGN1cnJlbnRseS4gSSBhbSBmaW5lIHdpdGgg
cmVtb3ZpbmcgdGhpcy4KPgo+UmV2aWV3ZWQtYnk6IFpodSBZYW5qdW4gPHlhbmp1bi56aHVAbGlu
dXguZGV2Pgo+Cj5aaHUgWWFuanVuCj4KPgo+PiArCS8qIEltcGxpY2l0IE9EUCAoc3RhcnQ9MCwg
bGVuZ3RoPVU2NF9NQVgpIGlzIG5vdCBpbXBsZW1lbnRlZC4gKi8KPj4gKwlpZiAoIXN0YXJ0ICYm
IGxlbmd0aCA9PSBVNjRfTUFYKQo+PiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4+ICAgCj4+ICAg
CXVtZW1fb2RwID0gaWJfdW1lbV9vZHBfZ2V0KCZyeGUtPmliX2Rldiwgc3RhcnQsIGxlbmd0aCwg
YWNjZXNzX2ZsYWdzLAo+PiAgIAkJCQkgICAmcnhlX21uX29wcyk7Cj4+IAo=


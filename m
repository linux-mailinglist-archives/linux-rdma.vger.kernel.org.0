Return-Path: <linux-rdma+bounces-23271-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9f0DEwBaV2oAKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-23271-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:59:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E1475CBB1
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 11:59:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="g 0QHF64";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23271-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23271-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2171300F161
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 09:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075673C3450;
	Wed, 15 Jul 2026 09:59:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E1432BC5;
	Wed, 15 Jul 2026 09:59:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784109555; cv=none; b=f2YTXKOx+HUu84a8JscVW5+gYQol7PTpJzaWG+YgtCtGbOSN5ZB7AtFHSDlgU3VL25xGRJhrjv1iJwutTy2oAo9hOLrkgBN9BqiT79P/t2fhZwIFIndrjPghSKZhx3ktLCoJsa4WVe6VT9guhwwYwRDdEsv5pm93J6SAHoFWO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784109555; c=relaxed/simple;
	bh=zSbJg7XMMBwbVhKSPC13G5dCS6JpHC7flw9AlXz0OMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=krBYfydDgGE6AUDtTZJgY4K4MJ+8QCXhK8/f7xheCo9Yo4P0Xhecfa7XBdCV/hlR2vjONOAklo6gcd5T5nw6f09quA0TJdycHDnF7/44q8jkKy/9o0LNDww3iFYnoNEZQGz2jQwQuF4JpA1ZKRtCWxyc2CXSG5CE4R/C8uLTKow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=g0QHF64p; arc=none smtp.client-ip=117.135.210.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=zSbJg7XMMBwbVhKSPC13G5dCS6JpHC7flw9AlXz0OMg=; b=g
	0QHF64pYQlLpRDG1lfk0QFEuRbxNGOgFMlou/OzCZddL+aVpOeb1nhV4t9LSdIcO
	wYpYFWhjyLto39+7YRMFg7H4lmY1Y7LxJpHjLmEhNDCqSA7/ofgc2n/oCpaTbsa7
	AQpmhqKmHjCOFAyjLmXqx5HoKy79gGbyDEuDR3ZbUo=
Received: from kensanya$163.com ( [116.128.244.171] ) by
 ajax-webmail-wmsvr-40-113 (Coremail) ; Wed, 15 Jul 2026 17:57:59 +0800
 (CST)
Date: Wed, 15 Jul 2026 17:57:59 +0800 (CST)
From: kensanya  <kensanya@163.com>
To: "Leon Romanovsky" <leon@kernel.org>
Cc: bvanassche@acm.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: Re:Re: [PATCH] RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind counters
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260715090557.GE21348@unreal>
References: <20260715023016.56767-1-kensanya@163.com>
 <20260715090557.GE21348@unreal>
X-NTES-SC: AL_Qu2TBv2btkws7yicbOkcnkcTg+k8WMW1ufsg2Ydec/sEugrvxwoGdGZ7DETX6fyXMgCeqzmGXwV38vpARqxKzexupUyaJ78qPOkEB6JpWg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6c3eb2da.8145.19f653637b1.Coremail.kensanya@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cSgvCgBXH1OoWVdqcIweAA--.13970W
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbCwQjwzGpXWah7NAAA32
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:bvanassche@acm.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:tanzheng@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kensanya@163.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23271-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kensanya@163.com,linux-rdma@vger.kernel.org];
	HAS_X_PRIO_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04E1475CBB1

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI2LTA3LTE1IDE3OjA1OjU3LCAiTGVvbiBSb21hbm92c2t5
IiA8bGVvbkBrZXJuZWwub3JnPiB3cm90ZToKPk9uIFdlZCwgSnVsIDE1LCAyMDI2IGF0IDEwOjMw
OjE2QU0gKzA4MDAsIGtlbnNhbnlhQDE2My5jb20gd3JvdGU6Cj4+IEZyb206IFRhblpoZW5nIDx0
YW56aGVuZ0BreWxpbm9zLmNuPgo+PiAKPj4gV2hlbiBzcnB0X2FsbG9jX3J3X2N0eHMoKSBmYWls
cyBwYXJ0d2F5IHRocm91Z2ggYSBtdWx0aS1idWZmZXIgaW5kaXJlY3QKPj4gZGVzY3JpcHRvciwg
dGhlIHVud2luZCBwYXRoIGRlc3Ryb3lzIFJETUEgY29udGV4dHMgYnV0IGxlYXZlcyBzdGFsZQo+
PiBuX3J3X2N0eCBhbmQgbl9yZG1hIHZhbHVlcyAoYW5kIGEgZGFuZ2xpbmcgcndfY3R4cyBwb2lu
dGVyKS4gTGF0ZXIKPj4gc3Ffd3JfYXZhaWwgYWNjb3VudGluZyBpbiBzcnB0X3F1ZXVlX3Jlc3Bv
bnNlKCkgb3Igc3JwdF93cml0ZV9wZW5kaW5nKCkKPj4gY2FuIHRoZW4gc3VidHJhY3QgdGhlIHdy
b25nIG51bWJlciBvZiBzZW5kIHF1ZXVlIGNyZWRpdHMuCj4+IAo+PiBSZXNldCB0aGUgY291bnRl
cnMgYW5kIHJ3X2N0eHMgcG9pbnRlciBiZWZvcmUgcmV0dXJuaW5nIGFuIGVycm9yLgo+PiAKPj4g
Rml4ZXM6IGI5OWY4ZTRkN2JjZCAoIklCL3NycHQ6IGNvbnZlcnQgdG8gdGhlIGdlbmVyaWMgUkRN
QSBSRUFEL1dSSVRFIEFQSSIpCj4+IFNpZ25lZC1vZmYtYnk6IFRhblpoZW5nIDx0YW56aGVuZ0Br
eWxpbm9zLmNuPgo+PiAtLS0KPj4gIGRyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0
LmMgfCAzICsrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+PiAKPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0LmMgYi9kcml2ZXJz
L2luZmluaWJhbmQvdWxwL3NycHQvaWJfc3JwdC5jCj4+IGluZGV4IGY2NmNmZDcwYzI2My4uNDY0
NDQyOWZhZTE0IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvdWxwL3NycHQvaWJf
c3JwdC5jCj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0LmMKPj4g
QEAgLTEwMTYsNiArMTAxNiw5IEBAIHN0YXRpYyBpbnQgc3JwdF9hbGxvY19yd19jdHhzKHN0cnVj
dCBzcnB0X3NlbmRfaW9jdHggKmlvY3R4LAo+PiAgCX0KPj4gIAlpZiAoaW9jdHgtPnJ3X2N0eHMg
IT0gJmlvY3R4LT5zX3J3X2N0eCkKPj4gIAkJa2ZyZWUoaW9jdHgtPnJ3X2N0eHMpOwo+PiArCWlv
Y3R4LT5yd19jdHhzID0gJmlvY3R4LT5zX3J3X2N0eDsKPgo+VGhpcyBsaW5lIHNlZW1zIHF1ZXN0
aW9uYWJsZSB0byBtZS4KPllvdSBwcm9iYWJseSBuZWVkIHRvIHdyaXRlOgo+aWYgKGlvY3R4LT5y
d19jdHhzICE9ICZpb2N0eC0+c19yd19jdHgpIHsKPiAga2ZyZWUoaW9jdHgtPnJ3X2N0eHMpOwo+
ICBpb2N0eC0+cndfY3R4cyA9IE5VTEw7Cj59Cj4KPj4gKwlpb2N0eC0+bl9yd19jdHggPSAwOwo+
PiArCWlvY3R4LT5uX3JkbWEgPSAwOwo+Cj5UaGVzZSBsaW5lcyBzZWVtIGNvcnJlY3QgdG8gbWUu
Cj4KPj4gIAlyZXR1cm4gcmV0Owo+PiAgfQo+PiAgCj4+IC0tIAo+PiAyLjI1LjEKPj4gCkhpIEJh
cnQsCgpUaGFua3MgZm9yIHRoZSByZXZpZXcuCgpJIG9yaWdpbmFsbHkgc2V0IHJ3X2N0eHMgYmFj
ayB0byAmaW9jdHgtPnNfcndfY3R4IGFmdGVyIGtmcmVlKCkKYmVjYXVzZSB0aGF0IGlzIHRoZSBv
bmx5IG90aGVyIHZhbGlkIHZhbHVlIHVzZWQgaW4gdGhpcyBmaWxlCihuYnVmcyA9PSAxIHBhdGgp
LCBhbmQgSSB3YW50ZWQgdG8gY2xlYXIgdGhlIGRhbmdsaW5nIHBvaW50ZXIKd2hpbGUga2VlcGlu
ZyB0aGUgZXhpc3RpbmcgImVtYmVkZGVkIHZzIGhlYXAiIGNvbnZlbnRpb24uCgpUaGlzIGlzIGlu
ZGVlZCBtaXNsZWFkaW5nLkkgd2lsbCBjaGFuZ2UgaXQgdG86CglpZiAoaW9jdHgtPnJ3X2N0eHMg
IT0gJmlvY3R4LT5zX3J3X2N0eCkgewoJCWtmcmVlKGlvY3R4LT5yd19jdHhzKTsKCQlpb2N0eC0+
cndfY3R4cyA9IE5VTEw7Cgl9CmFuZCBrZWVwIHRoZSBuX3J3X2N0eCAvIG5fcmRtYSByZXNldHMu
IFdpbGwgc2VuZCBhIHYyLgoKVGhhbmtzLApUYW5aaGVuZwoK


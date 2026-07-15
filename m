Return-Path: <linux-rdma+bounces-23272-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZZCxC9ZcV2qXKQEAu9opvQ
	(envelope-from <linux-rdma+bounces-23272-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 12:11:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9375CCA5
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 12:11:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b="L 9BsoCc";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23272-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23272-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=163.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 377C6302D10F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2026 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02AD43B6D0;
	Wed, 15 Jul 2026 10:09:26 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CB35F16F;
	Wed, 15 Jul 2026 10:09:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110166; cv=none; b=Y6F0VFo9ZINBkVXdVL/JTmXBoOb4JfCkeDEcVCT/Ypb4wfYgsGg2wud1V5gI7I0hZUp/nSFGQLflVcefcl8+NozT65/rfPfpW/I/6DxWC5nfpfYLczm3hEgdVT2D8pLqNbcngInkaWcOxF8QZyf8QZdv8TtdZHyfTMKW3qXtXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110166; c=relaxed/simple;
	bh=j43BRvBeaGz1fP1MwOSdaMOda2xj2CGAv6/RArYFC/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=CEMW0s7hgf+pSpsWr2qYP588HfuQQ34o1N+UWlRInHCytazGpef0Ra8d/hET4hCpVXmXYr2wCel/By2KFmZWxAnDWCC6tD8mz9m7YEA722yY3vudbrMsU1q9/bBUv7YozISdUp7ADPX6X7HUDCYPJ8aQ3yk84cpymVHMsfssCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L9BsoCcz; arc=none smtp.client-ip=117.135.210.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=j43BRvBeaGz1fP1MwOSdaMOda2xj2CGAv6/RArYFC/w=; b=L
	9BsoCczYTCGVCpkpVnNOVQXI/ume/MxrBmrrJx/PlYa925b/exMTISCcsTP5lQGq
	pjgJkjO/C4FOFR+6Z6sq5dwhxIrYgTkqpJFFdTknJrjg0trQeIGpuV2l+dckutqe
	zgmyeUAaSqNnInN1o/vKeupd/fOahk3V+LTHM07dTM=
Received: from kensanya$163.com ( [116.128.244.171] ) by
 ajax-webmail-wmsvr-40-113 (Coremail) ; Wed, 15 Jul 2026 18:08:59 +0800
 (CST)
Date: Wed, 15 Jul 2026 18:08:59 +0800 (CST)
From: kensanya  <kensanya@163.com>
To: "Leon Romanovsky" <leon@kernel.org>
Cc: bvanassche@acm.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: Re:Re:Re: [PATCH] RDMA/srpt: Fix srpt_alloc_rw_ctxs() unwind
 counters
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <6c3eb2da.8145.19f653637b1.Coremail.kensanya@163.com>
References: <20260715023016.56767-1-kensanya@163.com>
 <20260715090557.GE21348@unreal>
 <6c3eb2da.8145.19f653637b1.Coremail.kensanya@163.com>
X-NTES-SC: AL_Qu2TBv2av0ko7yedZOkcnkcTg+k8WMW1ufsg2Ydec/sEugrvxwoGdGZ7DETX6fyXMgCeqzmGXwV38vpARqxKNHGpxpXjeNEEVq4KH5vhHA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <13fef285.8313.19f6540496d.Coremail.kensanya@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cSgvCgD310M7XFdqJY8eAA--.13650W
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbCwRuVcWpXXDu9QQAA3Y
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-23272-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80D9375CCA5

CgoKCgoKCgoKCgoKCgoKCgpBdCAyMDI2LTA3LTE1IDE3OjU3OjU5LCAia2Vuc2FueWEiIDxrZW5z
YW55YUAxNjMuY29tPiB3cm90ZToKPgo+Cj4KPgo+Cj4KPgo+Cj4KPgo+Cj4KPgo+Cj4KPgo+Cj5B
dCAyMDI2LTA3LTE1IDE3OjA1OjU3LCAiTGVvbiBSb21hbm92c2t5IiA8bGVvbkBrZXJuZWwub3Jn
PiB3cm90ZToKPj5PbiBXZWQsIEp1bCAxNSwgMjAyNiBhdCAxMDozMDoxNkFNICswODAwLCBrZW5z
YW55YUAxNjMuY29tIHdyb3RlOgo+Pj4gRnJvbTogVGFuWmhlbmcgPHRhbnpoZW5nQGt5bGlub3Mu
Y24+Cj4+PiAKPj4+IFdoZW4gc3JwdF9hbGxvY19yd19jdHhzKCkgZmFpbHMgcGFydHdheSB0aHJv
dWdoIGEgbXVsdGktYnVmZmVyIGluZGlyZWN0Cj4+PiBkZXNjcmlwdG9yLCB0aGUgdW53aW5kIHBh
dGggZGVzdHJveXMgUkRNQSBjb250ZXh0cyBidXQgbGVhdmVzIHN0YWxlCj4+PiBuX3J3X2N0eCBh
bmQgbl9yZG1hIHZhbHVlcyAoYW5kIGEgZGFuZ2xpbmcgcndfY3R4cyBwb2ludGVyKS4gTGF0ZXIK
Pj4+IHNxX3dyX2F2YWlsIGFjY291bnRpbmcgaW4gc3JwdF9xdWV1ZV9yZXNwb25zZSgpIG9yIHNy
cHRfd3JpdGVfcGVuZGluZygpCj4+PiBjYW4gdGhlbiBzdWJ0cmFjdCB0aGUgd3JvbmcgbnVtYmVy
IG9mIHNlbmQgcXVldWUgY3JlZGl0cy4KPj4+IAo+Pj4gUmVzZXQgdGhlIGNvdW50ZXJzIGFuZCBy
d19jdHhzIHBvaW50ZXIgYmVmb3JlIHJldHVybmluZyBhbiBlcnJvci4KPj4+IAo+Pj4gRml4ZXM6
IGI5OWY4ZTRkN2JjZCAoIklCL3NycHQ6IGNvbnZlcnQgdG8gdGhlIGdlbmVyaWMgUkRNQSBSRUFE
L1dSSVRFIEFQSSIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBUYW5aaGVuZyA8dGFuemhlbmdAa3lsaW5v
cy5jbj4KPj4+IC0tLQo+Pj4gIGRyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0LmMg
fCAzICsrKwo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKPj4+IAo+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0LmMgYi9kcml2ZXJz
L2luZmluaWJhbmQvdWxwL3NycHQvaWJfc3JwdC5jCj4+PiBpbmRleCBmNjZjZmQ3MGMyNjMuLjQ2
NDQ0MjlmYWUxNCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9p
Yl9zcnB0LmMKPj4+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC91bHAvc3JwdC9pYl9zcnB0LmMK
Pj4+IEBAIC0xMDE2LDYgKzEwMTYsOSBAQCBzdGF0aWMgaW50IHNycHRfYWxsb2NfcndfY3R4cyhz
dHJ1Y3Qgc3JwdF9zZW5kX2lvY3R4ICppb2N0eCwKPj4+ICAJfQo+Pj4gIAlpZiAoaW9jdHgtPnJ3
X2N0eHMgIT0gJmlvY3R4LT5zX3J3X2N0eCkKPj4+ICAJCWtmcmVlKGlvY3R4LT5yd19jdHhzKTsK
Pj4+ICsJaW9jdHgtPnJ3X2N0eHMgPSAmaW9jdHgtPnNfcndfY3R4Owo+Pgo+PlRoaXMgbGluZSBz
ZWVtcyBxdWVzdGlvbmFibGUgdG8gbWUuCj4+WW91IHByb2JhYmx5IG5lZWQgdG8gd3JpdGU6Cj4+
aWYgKGlvY3R4LT5yd19jdHhzICE9ICZpb2N0eC0+c19yd19jdHgpIHsKPj4gIGtmcmVlKGlvY3R4
LT5yd19jdHhzKTsKPj4gIGlvY3R4LT5yd19jdHhzID0gTlVMTDsKPj59Cj4+Cj4+PiArCWlvY3R4
LT5uX3J3X2N0eCA9IDA7Cj4+PiArCWlvY3R4LT5uX3JkbWEgPSAwOwo+Pgo+PlRoZXNlIGxpbmVz
IHNlZW0gY29ycmVjdCB0byBtZS4KPj4KPj4+ICAJcmV0dXJuIHJldDsKPj4+ICB9Cj4+PiAgCj4+
PiAtLSAKPj4+IDIuMjUuMQo+Pj4gCj5IaSBCYXJ0LAo+Cj5UaGFua3MgZm9yIHRoZSByZXZpZXcu
Cj4KPkkgb3JpZ2luYWxseSBzZXQgcndfY3R4cyBiYWNrIHRvICZpb2N0eC0+c19yd19jdHggYWZ0
ZXIga2ZyZWUoKQo+YmVjYXVzZSB0aGF0IGlzIHRoZSBvbmx5IG90aGVyIHZhbGlkIHZhbHVlIHVz
ZWQgaW4gdGhpcyBmaWxlCj4obmJ1ZnMgPT0gMSBwYXRoKSwgYW5kIEkgd2FudGVkIHRvIGNsZWFy
IHRoZSBkYW5nbGluZyBwb2ludGVyCj53aGlsZSBrZWVwaW5nIHRoZSBleGlzdGluZyAiZW1iZWRk
ZWQgdnMgaGVhcCIgY29udmVudGlvbi4KPgo+VGhpcyBpcyBpbmRlZWQgbWlzbGVhZGluZy5JIHdp
bGwgY2hhbmdlIGl0IHRvOgo+CWlmIChpb2N0eC0+cndfY3R4cyAhPSAmaW9jdHgtPnNfcndfY3R4
KSB7Cj4JCWtmcmVlKGlvY3R4LT5yd19jdHhzKTsKPgkJaW9jdHgtPnJ3X2N0eHMgPSBOVUxMOwo+
CX0KPmFuZCBrZWVwIHRoZSBuX3J3X2N0eCAvIG5fcmRtYSByZXNldHMuIFdpbGwgc2VuZCBhIHYy
Lgo+Cj5UaGFua3MsCj5UYW5aaGVuZwo+CkhpIExlb24uCgpJJ20gdmVyeSBzb3JyeSwgSSBtYWRl
IGEgbWlzdGFrZS4KClRoYW5rcywKVGFuWmhlbmc=


Return-Path: <linux-rdma+bounces-10114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D36AAD614
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 08:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94F0179343
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 06:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96A20C024;
	Wed,  7 May 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="eRLI6fBn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93414A4CC
	for <linux-rdma@vger.kernel.org>; Wed,  7 May 2025 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599512; cv=none; b=XbiVCNXaHi7GHdgWyW/7VIwX37M24VFMwyrItaz7AAT9ZNF/aasRmAgut3B7iLEKHD5++vrnQdONa+b7Zo1uC1dmtXh8rL2PzUxPiSePHe+aY5BEx3mw5iW/56HY0xrFJsURoRblNxjtOUrEiU9mrWOFwKEJqfNe6viiFw1OhIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599512; c=relaxed/simple;
	bh=MNtlRfjNQnc0euRI2ftn5nBoEwLTa0GS318qy6IJLNU=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=b1Qsw2EA9ERQEhHHBS0+GfQ6F71qqK5IFL4gYZkJkZPmqbdH9clo0K3wIwtY7W72m92gOD5zaKw93RSK+npJxoGdVzL3dHap47CV+SrdyLmMZQXeV1QLjlNbvF3B/4tCE9Y1zLbysWDLgpWwWbYZLYZhcc1uu2qqy+8I+Tv92YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=eRLI6fBn reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=IX1Bsv0yJ/fss4BOSBAmm+e0fCIa9GVJC663M0dtLvA=; b=e
	RLI6fBn64kCIKCwIpmiCMSLMtM4KSecez+4cjYLX8s0vU/9KbSjOHofiZ4fbGpJ9
	WKZVYNIsvNcBekTWMcMN7/22J942oWsccP/cipuYPA/sPQzHYQiSY7vXqeLYqeYu
	jh7SRlTUr7yw3+Mm73SCHzzsahVKdDCG8bCsCpxI5Y=
Received: from hfzhou369$163.com ( [61.49.251.2] ) by
 ajax-webmail-wmsvr-40-142 (Coremail) ; Wed, 7 May 2025 14:31:36 +0800 (CST)
Date: Wed, 7 May 2025 14:31:36 +0800 (CST)
From: =?UTF-8?B?5ZGo5rSq6ZSL?= <hfzhou369@163.com>
To: linux-rdma@vger.kernel.org
Subject: Clarification on rdma-core Code Style and Contribution Guidelines
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2fBPmStkwi4CWbZekfmUwUheo3XMe0vPoi3IZXO598jCDr2QcuYntMIHHY99+OIR6qkReYXxhh4+1HbZN6b5MbwUNGlZo+2FgKx2FzviL3zw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2442ea1c.5bd5.196a9714b5b.Coremail.hfzhou369@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jigvCgDnjxFI_hpoTfKlAA--.24568W
X-CM-SenderInfo: xki2x0jxtwmqqrwthudrp/xtbBaRYRuGfVXU-9wQADsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpEZWFyIE1haW50YWluZXJzLAoKCkkgaG9wZSB0aGlzIG1lc3NhZ2UgZmluZHMgeW91IHdlbGwu
CgoKSSdtIFpob3UgSG9uZ2ZlbmcgZnJvbSBCaXRJbnRlbGxpZ2VuY2UsIGEgbmV0d29yayBjb21w
YW55IGZyb20gQ2hpbmEsIGFuZCBJ4oCZbSBpbnRlcmVzdGVkIGluIGNvbnRyaWJ1dGluZyB0byBy
ZG1hLWNvcmUuIFdoaWxlIHByZXBhcmluZyBteSBwYXRjaGVzLCBJIHdhbnQgdG8gZW5zdXJlIG15
IGNvZGUgYWRoZXJlcyB0byB0aGUgcHJvamVjdOKAmXMgc3R5bGUgZ3VpZGVsaW5lcy4gSG93ZXZl
ciwgSSBub3RpY2VkIGEgZmV3IHVuY2VydGFpbnRpZXMgcmVnYXJkaW5nIHRoZSBjdXJyZW50IHBy
YWN0aWNlczoKCgrigIPigINgLmNsYW5nLWZvcm1hdGAgVXNhZ2U6IFRoZSByZXBvc2l0b3J5IGlu
Y2x1ZGVzIGEgLmNsYW5nLWZvcm1hdCBmaWxlLCBidXQgaXQgaGFzbuKAmXQgYmVlbiB1cGRhdGVk
IGluIGEgd2hpbGUuIFdoZW4gSSByYW4gY2xhbmctZm9ybWF0LTExKSBvbiB0aGUgZXhpc3Rpbmcg
Y29kZWJhc2UsIG5lYXJseSBhbGwgZmlsZXMgc2hvd2VkIGZvcm1hdHRpbmcgZGlmZmVyZW5jZXMu
IFRoaXMgc3VnZ2VzdHMgdGhlIGNvbmZpZyBtaWdodCBub3QgZnVsbHkgYWxpZ24gd2l0aCB0aGUg
YWN0dWFsIGNvZGUgc3R5bGUuIElzIGBjbGFuZy1mb3JtYXRgIHRoZSByZWNvbW1lbmRlZCB0b29s
IGZvciBlbmZvcmNpbmcgc3R5bGUgY29uc2lzdGVuY3k/IElmIHNvLCBpcyB0aGVyZSBhbiB1cGRh
dGVkIHZlcnNpb24gb2YgdGhlIGNvbmZpZyBmaWxlIHRoYXQgbWFpbnRhaW5lcnMgZW5kb3JzZT8K
CgrigIPigINNYW51YWwgU3R5bGUgUnVsZXM6IElmIHRoZSBwcm9qZWN0IHByaW9yaXRpemVzIG1h
bnVhbCBzdHlsZSBlbmZvcmNlbWVudCBvdmVyIGF1dG9tYXRlZCB0b29scywgY291bGQgeW91IHBv
aW50IG1lIHRvIGRvY3VtZW50ZWQgY29udmVudGlvbnMgKGUuZy4sIGluZGVudGF0aW9uLCBuYW1p
bmcsIGNvbW1lbnRzKT8KCgrigIPigINQcmUtU3VibWlzc2lvbiBIYW5kbGluZzogU2hvdWxkIGNv
bnRyaWJ1dG9ycyBtYW51YWxseSBtYXRjaCB0aGUgZXhpc3Rpbmcgc3R5bGUsIG9yIGlzIGl0IGFj
Y2VwdGFibGUgdG8gc3VibWl0IHBhdGNoZXMgcmVmb3JtYXR0ZWQgd2l0aCBhbiB1cGRhdGVkIC5j
bGFuZy1mb3JtYXQ/CgoKQWRkaXRpb25hbGx5LCBpZiB0aGVyZSBhcmUgb3RoZXIgY29udHJpYnV0
aW9uIGd1aWRlbGluZXMgKGUuZy4sIGNvbW1pdCBtZXNzYWdlIGZvcm1hdCwgdGVzdGluZyByZXF1
aXJlbWVudHMpLCBJ4oCZZCBhcHByZWNpYXRlIGFueSBwb2ludGVycyB0byBhdm9pZCB1bm5lY2Vz
c2FyeSByZXZpZXcgb3ZlcmhlYWQuCgoKVGhhbmsgeW91IGZvciB5b3VyIHRpbWUgYW5kIGd1aWRh
bmNlISBJ4oCZbSBoYXBweSB0byBhZGp1c3QgbXkgd29ya2Zsb3cgdG8gYWxpZ24gd2l0aCB0aGUg
cHJvamVjdOKAmXMgc3RhbmRhcmRzLiBMb29raW5nIGZvcndhcmQgdG8geW91ciBpbnNpZ2h0cy4K
CgpCZXN0IHJlZ2FyZHMsClpob3UgSG9uZ2ZlbmcKR2l0aHViLmNvbS96aGY5OTkK


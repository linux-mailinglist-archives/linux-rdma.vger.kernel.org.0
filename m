Return-Path: <linux-rdma+bounces-20998-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IzQNSblDGrIpgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20998-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 00:33:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E6E585AC5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 May 2026 00:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2098A307E8BF
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4A730FC1C;
	Tue, 19 May 2026 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGHzosy7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F3343889
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229826; cv=none; b=oP+mNFGQZ1HTGAHqFKXrKO/GNNjdNffnPEq0nbC+ZcI5uM4qBvA/b7G/rMUGW+6QHiMbIS5TEinQWls3lz3t/hTXEmb3aWJOCGgqKWN0Bh8ngyovhsUQGQExnU4x2BBvYkNyfGNPkgWiRt2AMo56rBOzVpBnK3l2Rj1CiVLtDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229826; c=relaxed/simple;
	bh=S/6uZoS6Btc6uPnAalx9WBQAwUmPEkfC0kVp7L+m4lQ=;
	h=Message-ID:From:Content-Type:MIME-Version:To:Cc:Subject:
	 In-Reply-To:References:Date; b=PmuRcvDeK2M9M4LzWY2JIQDkb6KtvJPtM+aDAQElTEagWllwFoOoe58w0xklKeFdZPMMMmq3fybe6UbzNE+YFSyDFrhhrGYXhklXrEPf9DSfs1tWSzaA3Iin45XYZHjgB1pFZ5xIF4U7sG9lf4NMKXqPqE/oeG8P7C6E2+VJBKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGHzosy7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so61387915e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229823; x=1779834623; darn=vger.kernel.org;
        h=date:references:in-reply-to:subject:cc:to:content-transfer-encoding
         :mime-version:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/6uZoS6Btc6uPnAalx9WBQAwUmPEkfC0kVp7L+m4lQ=;
        b=tGHzosy7zOpwNRdkzBqu1yrpKOxjKi3JO2pfTq9kmYqBt45sGRxGMN41oUrATeFmum
         4Xj9weyIYitQ5QD3pdkP9kDCvTEHWGMll/Gctrgr+nDbYDNaS5ZsYkx75hmy9R0nTXW/
         26drgluVmtO/iqDG9NeHydQzQAqh/bvd0HguFIx4H2AFqnYPkFAGcLq8XMO2OaGrA/fU
         GvxTVw4ZiFytsBgoZBwsPvrJiDKEdsy00YEdpq3HjBOZo0mI9+NC8kYvyWYQrH5Wtw3o
         nAKzs3vdLdFpMmkBJSdzloqz2/Geu1nPMKxzUm5KXYa1YKpa9kQ/zPBuJK24qyIvFzyB
         rBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229823; x=1779834623;
        h=date:references:in-reply-to:subject:cc:to:content-transfer-encoding
         :mime-version:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/6uZoS6Btc6uPnAalx9WBQAwUmPEkfC0kVp7L+m4lQ=;
        b=sRj9ow2kM+VkIhaKmCKvo5bzwxbgq0FkIIgOK5TUCddbGpkD5CnBLOcMmPGuJTSYhR
         3ZCjeVzHrn2XFY7jMecfCCWj+xyJ6jjyocUY7N7qs8o7zxqvLNEVDLvy7TKq6qu+CoMt
         JMhyjPJ5vBb7nsg3EZmIEE83RuGgmtoZIjUMw0qXwi86JP4dc5pkTh/QoJKA6TS3Ea0S
         jlL8ZJO4bwBSE4r50+HxXeP4I4vpe3ujv44hyA3gd3kO0Q0sH9tg6HH1HZhZJRWnZMZI
         OHKYlKezAY0limM4jNTZ8sgqhEDtsGYMvlLaWNXMbZb2auX0Nz1Bgzw6YoVVFxtohGwW
         4uiA==
X-Forwarded-Encrypted: i=1; AFNElJ/MDCKYkdQJ7QKcXwKU8Brb8WAgpxwnYbeyzFVg7QTLf/Dssg8LVrNVx6INwaJsorn82ZD+dl1+0OgD@vger.kernel.org
X-Gm-Message-State: AOJu0YzOtvenI3dMXHHm17bWkaWwVP8MzxQJdlnJhFUQSaxaxOlErK0r
	eVnJ1HrGqk786QCHJTWOfpEFcjlU940esWs7r+kASP6WxyKv2mr38hD7hxuS
X-Gm-Gg: Acq92OHAwZq0bL9Rp7/0CbLP9rbj6XHSk2VK/1RpeuWOvTCXz24CqGzlYphw7qC2jzK
	v+f4i5P4Uz4c3/206yRNhZubB9xNn3r9HL9Lxjmn5i/+ihV0Nkbi0yo3O+myHd2flzQe5TS6Rf4
	tdY2seqkJcV8AxBsSvcrI20bMSaF45xLGSyiDBfdqb/uMpNZYu0UiPoC0fKll3PIWESJf6KLb40
	fyoaZXDW3lQ6JwTgRchyQLDZtvK8gsmGL2nYD3HSma3fmfBsHONIzFjDNKt1B5BvOG40pksgQ/M
	CQbwcVYIjI2ilnEDFKDoiUgygybiYja4Kvu6XOeD2lrve8lWNjF4avxJFJK53I/RHFDv6ywuR5f
	w30Po0IsoySKdOPxuumGnIfXhTnM1JfdnFrEIgb/ZK2rpoK0iggzR2lDUbpTzODsR+WulcfPHiO
	bLXfV/rCnMEA==
X-Received: by 2002:a05:600c:3f1b:b0:48a:7965:b943 with SMTP id 5b1f17b1804b1-48fe661db6dmr322454775e9.29.1779229823063;
        Tue, 19 May 2026 15:30:23 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab52a6sm351711455e9.10.2026.05.19.15.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:30:21 -0700 (PDT)
Message-ID: <6a0ce47d.096dab79.284c84.5b30@mx.google.com>
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/2] RDMA/rxe: fix shared memory TOCTOU in receive path
In-Reply-To: <20260519150042.GL7702@ziepe.ca>
References: <20260518215040.1598586-1-tristan@talencesecurity.com> <0ae59679-5cc9-48e4-87e9-63299684acf8@linux.dev> <20260519145610.GA33515@unreal> <20260519150042.GL7702@ziepe.ca>
Date: Tue, 19 May 2026 22:30:20 +0000
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20998-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mx.google.com:mid]
X-Rspamd-Queue-Id: 57E6E585AC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVHVlLCAxOSBNYXkgMjAyNiwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+IFNpbXBsZSBtaXNi
ZWhhdmUgaXMgb25lIHRoaW5nLCBidXQgaWYgdXNlcnNwYWNlIGNhbiBoYWNrIHRoZSBrZXJuZWwK
PiBhbmQgZ2FpbiBjb250cm9sIG9mIGl0IHRocm91Z2ggdGhpcyBzaGFyZWQgbWVtb3J5IHRoZW4g
d2UgaGF2ZSB0byBmaXgKPiBpdC4KClRoZSBub24tU1JRIHJlY2VpdmUgcGF0aCBpbiBjaGVja19y
ZXNvdXJjZSgpIHNldHMgcXAtPnJlc3Aud3FlCmRpcmVjdGx5IGludG8gdGhlIHNoYXJlZCBtbWFw
IGJ1ZmZlcjoKCiAgICBxcC0+cmVzcC53cWUgPSBxdWV1ZV9oZWFkKHFwLT5ycS5xdWV1ZSwgUVVF
VUVfVFlQRV9GUk9NX0NMSUVOVCk7CgpObyBjb3B5LCBubyB2YWxpZGF0aW9uIG9mIHRoZSBXUUUg
ZmllbGRzLiBFdmVyeSBzdWJzZXF1ZW50IGFjY2Vzcwp0byB3cWUtPmRtYS5udW1fc2dlLCB3cWUt
PmRtYS5zZ2VbXS5sa2V5LCBhbmQgd3FlLT5kbWEuc2dlW10uYWRkcgpyZWFkcyBmcm9tIG1lbW9y
eSB0aGF0IHVzZXJzcGFjZSBjYW4gbW9kaWZ5IGNvbmN1cnJlbnRseS4KClRoZSBjb25jcmV0ZSBw
cm9ibGVtIGlzIGluIGNvcHlfZGF0YSgpLCBjYWxsZWQgdmlhIHNlbmRfZGF0YV9pbigpLgpJdCBy
ZS1yZWFkcyBkbWEtPm51bV9zZ2UgZnJvbSB0aGUgc2hhcmVkIGJ1ZmZlciBvbiBldmVyeSBsb29w
Cml0ZXJhdGlvbiAodGhlIGRtYS0+Y3VyX3NnZSA+PSBkbWEtPm51bV9zZ2UgYm91bmQgY2hlY2sp
LCBhbmQgdXNlcwpzZ2UtPmxrZXkgZm9yIGxvb2t1cF9tcigpIGFuZCBzZ2UtPmFkZHIgdG8gY29t
cHV0ZSB0aGUgaW92YSBmb3IKcnhlX21yX2NvcHkoKS4gQSBjb25jdXJyZW50IHRocmVhZCBjYW46
CgogIDEuIEluY3JlYXNlIG51bV9zZ2U6IHRoZSBzZ2UgcG9pbnRlciB3YWxrcyBwYXN0IHRoZSBX
UUUncwogICAgIGFsbG9jYXRlZCBTR0Ugc2xvdHMgaW50byBhZGphY2VudCBxdWV1ZSBlbnRyaWVz
LCBhbmQgdGhlCiAgICAga2VybmVsIGFjdHMgb24gd2hhdGV2ZXIgbGtleS9hZGRyL2xlbmd0aCB2
YWx1ZXMgaXQgZmluZHMKICAgICB0aGVyZSAtLSBhbGwgYXR0YWNrZXItY29udHJvbGxlZCB0aHJv
dWdoIHRoZSBzYW1lIG1tYXAuCgogIDIuIFN3YXAgc2dlW10ubGtleSBiZXR3ZWVuIGl0ZXJhdGlv
bnM6IHJlZGlyZWN0IHRoZSBNUiBsb29rdXAKICAgICB0byBhIGRpZmZlcmVudCBtZW1vcnkgcmVn
aW9uLgoKICAzLiBNb2RpZnkgc2dlW10uYWRkcjogc2hpZnQgdGhlIHdyaXRlIHRhcmdldCB3aXRo
aW4gdGhlCiAgICAgcmVzb2x2ZWQgTVIuCgpUaGUgZGF0YSBiZWluZyB3cml0dGVuIGlzIGluY29t
aW5nIHBhY2tldCBwYXlsb2FkIChhdHRhY2tlci0KY29udHJvbGxlZCBpbiBsb29wYmFjayksIGRp
cmVjdGlvbiBpcyBSWEVfVE9fTVJfT0JKLgoKVGhlIFNSUSBwYXRoIGFscmVhZHkgaGFuZGxlcyB0
aGlzIGNvcnJlY3RseTogZ2V0X3NycV93cWUoKSBjb3BpZXMKdGhlIFdRRSB0byBrZXJuZWwgbWVt
b3J5IHdpdGggbWVtY3B5KCkgYW5kIHZhbGlkYXRlcyBudW1fc2dlCmFnYWluc3QgbWF4X3NnZSBi
ZWZvcmUgdXNlLiBUaGUgY29tbWVudCB0aGVyZSBzYXlzICJkb24ndCB0cnVzdAp1c2VyIHNwYWNl
IGRhdGEiLiBUaGUgbm9uLVNSUSBwYXRoIGhhcyBuZWl0aGVyIHRoZSBjb3B5IG5vciB0aGUKdmFs
aWRhdGlvbi4KClRoZSByYWNlIHdpbmRvdyBpcyBub3QgdGlnaHQgLS0gdGhlIHNoYXJlZCBwb2lu
dGVyIGlzIHNldCBkdXJpbmcKUkVTUFNUX0NIS19SRVNPVVJDRSBhbmQgdGhlIGZpZWxkcyBhcmUg
Y29uc3VtZWQgYWNyb3NzIENIS19MRU5HVEgKYW5kIEVYRUNVVEUgYmVmb3JlIGNvcHlfZGF0YSgp
IHJ1bnMuCgpJIGNhbiBwcm92aWRlIGEgcmVwcm9kdWNlciBpZiB0aGF0IGhlbHBzIG1vdmUgdGhl
IHBhdGNoZXMgZm9yd2FyZC4KClRyaXN0YW4K


Return-Path: <linux-rdma+bounces-23215-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KySyFHdhVmrF4QAAu9opvQ
	(envelope-from <linux-rdma+bounces-23215-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 18:19:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F375756DF5
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 18:19:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=cQF+11ed;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23215-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23215-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A66AC3028341
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8874A33F2;
	Tue, 14 Jul 2026 16:18:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD93924A076;
	Tue, 14 Jul 2026 16:18:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045931; cv=none; b=Uv9HRBO1uLFY572ConGSFQUxasdGY8IPzKrG4UvLz0OtdsLJp2azTFCChvwLSoQ/Y4gicdDJtkSePDzKvqWjZPJe2263NqtXofyQsgCuBWrLJCNV2aiIkVUK7rBMuVGCuSA+U7A4yzekzBu+LNtxpSjPtXodedbzdau9N86LhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045931; c=relaxed/simple;
	bh=5jhpvelHXRkr+KgJi9FzFCf3OR87GzHpK6BSo1tKqY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltMKwDnjuzl8eD3xL/h8EjrMv5ImNPbMOLrupDx58qY0zliZqo3e7mZANN+eNyIvSdLS/KEs+KgEjFl+VE+ixLbFv5piipPV9L2V+VsPmfiBzJ1omonuWm6CORJ9ZUdJWihse1HvA28h6tmyVzRwYQtywfOqczURPDwf+r7zXKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cQF+11ed; arc=none smtp.client-ip=115.124.30.110
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784045923; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=T3I6JtrPCGC1yfJByv8sZE4okdZHv+KvkXv9UcaOing=;
	b=cQF+11edFA/a7sZkJogYslh+KTgaU3uYCPVHsJ4DaQlNe5bv+fngEYyB6FaGfZfot6JkRB+ks+2kImcSfo/JXScCzAcsO+bXCbWD+Y/Xl7i3lG/Tlfk5TrQrKPgVF6aL5MYlPYT/uyDXgy8k/U9+g1MXLeNPdCmZOMoEsyfa/Oo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X757Q5c_1784045922;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X757Q5c_1784045922 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 00:18:42 +0800
Date: Wed, 15 Jul 2026 00:18:42 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] net/smc: bound wire-controlled CDC cursors
 against the local buffers
Message-ID: <alZhYh6TOvqH0T9s@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260705-b4-disp-28a1bbca-v4-0-be089b98acc6@proton.me>
 <akzG4Hfeom6fNzFX@linux.alibaba.com>
 <20260711104315.82912-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711104315.82912-1-hexlabsecurity@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:wenjia@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:tonylu@linux.alibaba.com,m:pabeni@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23215-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.alibaba.com:from_mime,linux.alibaba.com:mid,linux.alibaba.com:dkim,linux.alibaba.com:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F375756DF5

On 2026-07-11 10:43:26, Bryam Vargas wrote:
>On Tue, 7 Jul 2026 17:29:04 +0800, Dust Li wrote:
>> Are you planning to land these clamps first, and then follow up with a
>> separate validate/abort series?
>
>Yes -- clamp series to net (Cc: stable), then the wire-boundary validate/abort to
>net-next, which is the split from your v3 review. If you'd rather have the
>validate/abort as the primary fix, or both in one series, say so and I'll
>restructure it.
>
>> Looking at your earlier A/B test, it simulates this logic in userspace to
>> demonstrate the bug, but it doesn't actually trigger the bug in our
>> current kernel.
>
>Right -- the earlier one replayed the smc_curs_diff/copy arithmetic over a kmalloc
>buffer. I built the end-to-end version: two AF_SMC sockets over the SMC-D loopback
>(dibs), CONFIG_SMC=m with KASAN, receive path unmodified. Only the sender's on-wire
>producer cursor is forged, modelling what a misbehaving peer sends:
>
>  cdc.prod.wrap = curs.wrap;
>  cdc.prod.count = curs.count;
>+ if (forge) {                 /* peer just bumps the wrap, count stays 0 */
>+     static u16 w;
>+     cdc.prod.wrap = ++w;
>+     cdc.prod.count = 0;
>+ }
>
>The client sends six 1-byte messages, the server recvs into a 2 MB buffer.
>rmb_desc->len = 65504; the three arms on 7.2-rc1:
>
>  honest (no forge)            recv 6        clean
>  forged, patch 2/3 clamp on   recv 65504    clean   (== rmb_desc->len)
>  forged, no clamp             recv 393024   KASAN
>
>In the last arm bytes_to_rcv reaches 6*len, so smc_rx_recvmsg()'s second wrap-around
>chunk (copylen - first_chunk = 393024 - 65504) is read from ring offset 0, past the
>RMB page:
>
>  BUG: KASAN: slab-use-after-free in _copy_to_iter
>  Read of size 327520 ... smc_rx_recvmsg <- smc_recvmsg <- __sys_recvfrom
>
>(use-after-free rather than out-of-bounds only because the over-read lands in a freed
>adjacent slab.) Happy to send the driver.
>
>> the security risk here doesn't seem high to me, since SMC is only meant to
>> be deployed in trusted environments.
>
>Agreed it's low urgency there. The reason I'd still keep the bound in stable: it's a
>peer-driven out-of-bounds read of kernel memory that a buggy, not only malicious,
>peer can hit, and the clamp never resets an honest connection. The stable tag is
>your call.
>
>> once this is actually triggered, it means the data we've been handing to
>> userspace is already wrong ... the connection should be terminated. So I
>> don't really see much value in merging the bound-clamp patches first.
>
>I'm not arguing against the abort -- a bad CDC means the connection can't be trusted
>and should go down, and that's the net-next work. Two points on it.
>
>The predicate has to test the accumulator, not the cursor. Every forged CDC here
>carries count == 0, which is in [0, rmb_desc->len), so it passes any per-cursor
>input check, including patch 1/3; only bytes_to_rcv goes out of range. A
>cursor-boundary abort wouldn't catch this vector.
>
>And placement: if the abort is queued (queue_work -> smc_conn_kill) after the
>atomic_add, a recvmsg() under lock_sock can still read the inflated accumulator in
>the window before teardown runs. A synchronous check that bails before the
>atomic_add avoids that, and so does the consumer clamp.
>
>If you'd prefer a single accumulator-abort in place of the -stable clamp, I'll
>respin it that way and run the same A/B.

Hi Bryam,

Thanks for the detailed explanation — I think you're right. To me the
key point here is that no matter how the peer misbehaves, we should
never let it cause a panic or memory corruption on our side.

So I think your current clamp can stay. In the net-next version we
can add the abort logic, and additionally, it would be best to emit a
warning log whenever the clamp detects an anomaly here.

Best regards, Dust



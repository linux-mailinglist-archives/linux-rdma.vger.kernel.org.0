Return-Path: <linux-rdma+bounces-22357-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E8DqD7MZNGobOgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22357-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 18:15:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C266A1890
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 18:15:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=xEJh8oEs;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22357-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22357-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80BCD30C6D50
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC70340A62;
	Thu, 18 Jun 2026 16:08:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B431079B;
	Thu, 18 Jun 2026 16:08:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798901; cv=none; b=YbT0xHU+lGXLN/9v2zz61bt6xaXraMj1SepNs8iq2StvGSijkuqLPRdd+WU7dTsT0GENh+6/iKA0Y4+Ddya0PxAC4LnbK9f54mxb4Tq4CJbsX0zcUVI67kjOgS1VTZgqcI69CMQhkKemkzM7LnPKKJF4d49eSLuVZwx08r644KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798901; c=relaxed/simple;
	bh=U3qWfoZwH93moURapndx/9QhZN9IoCT8X330pTMepdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLqB2n+PCkNexwWi3FyBrjeIWdS6HGrNbtBIrnLQGVvtkypewZWlK79chBZ4LUzMkoqUynPnxyT9IosGOHQHj9Pl9sxBHLD6L8/ONaDiVpewD+9qhfNI7eJf5OfOMVLfT8APrsZ/BGaNRG0DVs7b8VGKN4VMFIQG5G0GuivpTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xEJh8oEs; arc=none smtp.client-ip=115.124.30.113
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781798896; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=L0VQtyLFwV0ddYoeCQeOA/TDAT1P2OPF2e8FFINakkM=;
	b=xEJh8oEs2c6uaaG9mqwOoiwtieSVKg/vMgVmDl5mTtmNROiw2lUMAV5UFa48mGkLFGoY1Aue05+DwrzfqWlCK41vMHzgmg1qKCg+wScS11aMI8oNjl9OpdE6AXi/+me/Cf9KOQJhw07m7wJTay/EOGFCydTDHxBVSl4okaqZiD4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X57TGq3_1781798895;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X57TGq3_1781798895 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Jun 2026 00:08:15 +0800
Date: Fri, 19 Jun 2026 00:08:15 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: hexlabsecurity@proton.me, Wenjia Zhang <wenjia@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, linux-s390@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Tony Lu <tonylu@linux.alibaba.com>
Subject: Re: [PATCH v3 3/3] net/smc: bound the send length to the send buffer
 in smc_tx_sendmsg()
Message-ID: <ajQX7_9xFI9GSaq5@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260614-b4-disp-edd64be9-v3-0-551fa514257e@proton.me>
 <20260614-b4-disp-edd64be9-v3-3-551fa514257e@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614-b4-disp-edd64be9-v3-3-551fa514257e@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:wenjia@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:edumazet@google.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:ubraun@linux.ibm.com,m:raspl@linux.ibm.com,m:linux-s390@vger.kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:kuba@kernel.org,m:tonylu@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22357-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,proton.me:email,linux.alibaba.com:dkim,linux.alibaba.com:replyto,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4C266A1890

On 2026-06-14 03:23:32, Bryam Vargas via B4 Relay wrote:
>From: Bryam Vargas <hexlabsecurity@proton.me>
>
>On the SMC-D DMB-merge (nocopy) path, smc_cdc_msg_recv_action() advances
>conn->sndbuf_space from the peer's consumer cursor:
>
>	diff_tx = smc_curs_diff(sndbuf_desc->len, &tx_curs_fin,
>				&local_rx_ctrl.cons);
>	atomic_add(diff_tx, &conn->sndbuf_space);
>
>The consumer cursor is wire-controlled and unvalidated, and
>smc_curs_diff()'s differing-wrap branch can return more than
>sndbuf_desc->len, so a forged cursor drives sndbuf_space past the send
>buffer (and across many CDC messages can overflow the signed counter
>negative).  smc_tx_sendmsg() reads it as the available write space and
>performs a wrap-around copy whose second chunk (copylen - first_chunk,
>written at ring offset 0) is never re-bounded to sndbuf_desc->len,
>writing user data past the send buffer -- a heap out-of-bounds write of
>attacker-influenced length and content.

Hi Bryam,

I think this is the same as patch #2.

Best regards,
Dust


>
>Bound the write space to sndbuf_desc->len where it is consumed, treating
>a negative (sign-overflowed) value as out of range too, so the copy
>length can never exceed the ring.  This enforces the documented
>0 <= sndbuf_space <= sndbuf_desc->len invariant at the producer,
>race-free against the CDC tasklet that advances sndbuf_space.
>
>Fixes: cc0ab806fc52 ("net/smc: adapt cursor update when sndbuf and peer DMB are merged")
>Cc: stable@vger.kernel.org
>Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
>---
> net/smc/smc_tx.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
>
>diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
>index 3144b4b1fe29..5916f02060fb 100644
>--- a/net/smc/smc_tx.c
>+++ b/net/smc/smc_tx.c
>@@ -233,6 +233,19 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
> 		/* initialize variables for 1st iteration of subsequent loop */
> 		/* could be just 1 byte, even after smc_tx_wait above */
> 		writespace = atomic_read(&conn->sndbuf_space);
>+		/* sndbuf_space is advanced from the peer's wire-controlled
>+		 * consumer cursor on the SMC-D DMB-merge path; a forged cursor
>+		 * can inflate it past the send buffer, or overflow the signed
>+		 * accumulator to a negative value across many CDC messages
>+		 * (which a plain "> len" check would miss before the size_t
>+		 * cast below turns it huge).  Bound it to the send buffer in
>+		 * either case so the wrap-around write cannot run past
>+		 * sndbuf_desc->len.  This enforces the documented
>+		 * 0 <= sndbuf_space <= sndbuf_desc->len invariant at the
>+		 * producer, race-free against the CDC tasklet.
>+		 */
>+		if (writespace < 0 || writespace > conn->sndbuf_desc->len)
>+			writespace = conn->sndbuf_desc->len;
> 		/* not more than what user space asked for */
> 		copylen = min_t(size_t, send_remaining, writespace);
> 		/* determine start of sndbuf */
>
>-- 
>2.43.0
>


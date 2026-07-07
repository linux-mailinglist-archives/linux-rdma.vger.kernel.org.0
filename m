Return-Path: <linux-rdma+bounces-22812-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SjwJMgR5TGpAlAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22812-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 05:56:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A73C71725B
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 05:56:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=LlakIQbN;
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22812-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22812-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E44E302FA97
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 03:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1E7370D7B;
	Tue,  7 Jul 2026 03:56:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F742086D;
	Tue,  7 Jul 2026 03:56:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783396594; cv=none; b=dNNuNzVOzrCnvhAxlHfuSIeoKYKtE6VgLPs53ItU4gKzW4YLg6f/NfMciRlpRpkpfW2fYut2B6zH3JAiHX3TuI8sdqjaDuBmZSUMtw25LhkcDfW3Kg7eK4OLcBQmfofqDYIpG6j6t3k3zyTM0qzSzBFPT9HVhsVDSFEEBkmHyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783396594; c=relaxed/simple;
	bh=AH0x5XaXy0vIg0qhq+qAwESJKMn/Df6ORcuGRPEcxNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMjylz9Ovnk9Xpql1fhyuk9qpaeC8vAdJlk6vkk7BRrGC45rR7MbM6hycq6C3UdQl1bmdMnU/p66t4c83i4HJwnGnuflRFigvmsiw3k8k5GtdPHL6saa2CRs5/UyR3oEkwVUebUM2MjNxDIRxQ1jJdU8HsJjxD37NavhQkycFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LlakIQbN; arc=none smtp.client-ip=115.124.30.97
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783396581; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=M4RVq49saWLjC2cfzHwMtl8WbBTa/nnpaGr8HOsnPv4=;
	b=LlakIQbNJhf2JQWChhZ0wz876tCXtu0xCIvHcz8tG2i8d5USKunPD8FXAMy0LuW8opJJ3bPjDHsGRRiLqeByteLJY7bO4BKjhjFL+ovP8ug6UbojUMy83l/0tkkqeO4wPUcoqbZJYYDrPN1zamZm9HQIk622W5rxaq5wFdc30t4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X6bdqfX_1783396580;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X6bdqfX_1783396580 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 11:56:21 +0800
Date: Tue, 7 Jul 2026 11:56:20 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	Hans Wippel <hwippel@linux.ibm.com>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/smc: ignore peer-supplied rmbe_idx and dmbe_idx
Message-ID: <akx45Ewt3iuhzCRI@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260702171137.1099051-2-dust.li@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702171137.1099051-2-dust.li@linux.alibaba.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.vnet.ibm.com,m:hwippel@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22812-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,vger.kernel.org:from_smtp,linux.alibaba.com:from_mime,linux.alibaba.com:replyto,linux.alibaba.com:mid,linux.alibaba.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A73C71725B

On 2026-07-03 01:11:38, Dust Li wrote:
>Linux always uses exactly one RMBE per RMB (index 1 for SMC-R) and
>one DMBE per DMB (index 0 for SMC-D), so conn->tx_off is always zero.
>Hardcode these fixed values instead of deriving tx_off from the
>peer-supplied rmbe_idx / dmbe_idx in the CLC Accept/Confirm message.
>
>Fixes: e6727f39004b ("smc: send data (through RDMA)")
>Fixes: 413498440e30 ("net/smc: add SMC-D support in af_smc")
>Cc: stable@vger.kernel.org
>Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
>Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
>---
> net/smc/af_smc.c | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index b5db69073e20..3706e8ac49e0 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -729,11 +729,15 @@ static void smcr_conn_save_peer_info(struct smc_sock *smc,
> {
> 	int bufsize = smc_uncompress_bufsize(clc->r0.rmbe_size);
> 
>-	smc->conn.peer_rmbe_idx = clc->r0.rmbe_idx;
>+	/* Linux uses exactly one RMBE per RMB (always index 1); ignore the
>+	 * peer-supplied rmbe_idx to prevent a malicious peer from setting an
>+	 * out-of-bounds tx_off.
>+	 */
>+	smc->conn.peer_rmbe_idx = 1;
> 	smc->conn.local_tx_ctrl.token = ntohl(clc->r0.rmbe_alert_token);
> 	smc->conn.peer_rmbe_size = bufsize;
> 	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
>-	smc->conn.tx_off = bufsize * (smc->conn.peer_rmbe_idx - 1);
>+	smc->conn.tx_off = 0;

Althrough we only have 1 RMBE/DMBE per RMB/DMB, but this does break SMC
protocol.

I will send another patch, checking the bound in dibs_loopback.c, please
ignore this one.

Thanks sashiko for pointing this out!

Best regards,
Dust


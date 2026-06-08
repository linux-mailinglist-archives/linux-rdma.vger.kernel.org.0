Return-Path: <linux-rdma+bounces-21973-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VccDDRzMJmrhkgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21973-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:05:16 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487D656EA7
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 16:05:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=kJF5s6UJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21973-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21973-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23B17300B53B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 14:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BDE3C4540;
	Mon,  8 Jun 2026 14:04:49 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857F3C4551;
	Mon,  8 Jun 2026 14:04:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927488; cv=none; b=j4vy4vkuHVjtJwDpMaZ5J97NCYKuz9poIz1P0Zrg+VheokCIFhrhTJNRytu4EBv7V61ZR+KJ+4gKCyEu0RfCtG7UxLqGhLyP/ojtTloPAStouEppxJcTGpj+2NDBzy2z5tkepyMoZcP/m9i+TQzUXVEAF7tiW5ub11p063Txk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927488; c=relaxed/simple;
	bh=o9ZqeZQndmaawdy1VD/8gxEmuhGgfg1vq5AT0Ln5GrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4Hlq0HCxtxrULOiZcCrOCAu8/ublYzwvbY03YT9ybNGpsPDtzCgMAE6YNTzkxx4uftZEKcTrW2+xaulnwlAnIwiond6izG5McfrQczEKH/rdrGPpFvS8GlQ026vAwfJV6bo2cRwGvPCG+I0LL+UVbQRqHGFK35lpt7UPoQzhYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kJF5s6UJ; arc=none smtp.client-ip=115.124.30.118
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780927476; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=FzmVchP79tCuI2XT+vBVQjUl7+ilYcFgXsd3+S4/940=;
	b=kJF5s6UJIBhDkFlRchtrOl5qM/4P72r+q5cLmv4lMSxaxrJX7M9Gz745XkWqWNKNMqNUx8+baz3lf5M/Ec0uoYF/tYCEJU48YBI4pJ6R4obRKKAOY2XridSCf8RLrh8hJXZPKgX+14rKekyHRxDhWLL6RiKIzd8pr6j6NwUdCQI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X4Q0kgv_1780927475;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X4Q0kgv_1780927475 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Jun 2026 22:04:35 +0800
Date: Mon, 8 Jun 2026 22:04:34 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: Re: [PATCH net-next v2 2/2] net/smc: reduce TX slot contention with
 exclusive wait
Message-ID: <aibL8g1hxAcZzPRJ@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260528084819.6059-1-alibuda@linux.alibaba.com>
 <20260528084819.6059-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528084819.6059-3-alibuda@linux.alibaba.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alibuda@linux.alibaba.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:horms@kernel.org,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:pasic@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21973-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,alibaba.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3487D656EA7

On 2026-05-28 16:48:19, D. Wythe wrote:
>smc_wr_tx_get_free_slot() waits for a free TX slot with
>wait_event_interruptible_timeout(). Since the wait_event family
>enqueues waiters as non-exclusive, wake_up() may wake multiple
>waiters even though only one can use the slot, causing
>thundering-herd contention when slots are scarce.
>
>Use an exclusive wait loop with prepare_to_wait_exclusive() so
>wake_up() wakes only one waiter per freed slot.
>smc_wr_wakeup_tx_wait() still uses wake_up_all() during link
>teardown, so teardown behavior is unchanged.
>
>Performance measured with netperf TCP_RR (63 flows, 200B write /
>1000B read, 60s duration):
>
>+-------------------------------+---------------+---------------+
>| smcr_max_conns_per_lgr        | 32            | 255           |
>|-------------------------------+---------------+---------------|
>| before                        | 4.85 Gb/s     | 657.95 Mb/s   |
>|-------------------------------+---------------+---------------|
>| after                         | 5.01 Gb/s     | 2.2 Gb/s      |
>+-------------------------------+---------------+---------------+
>
>Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>---
> net/smc/smc_wr.c | 36 ++++++++++++++++++++++++++----------
> 1 file changed, 26 insertions(+), 10 deletions(-)
>
>diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
>index 130bc6c26fb3..3cb47f77130e 100644
>--- a/net/smc/smc_wr.c
>+++ b/net/smc/smc_wr.c
>@@ -153,9 +153,11 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
> 			    struct smc_rdma_wr **wr_rdma_buf,
> 			    struct smc_wr_tx_pend_priv **wr_pend_priv)
> {
>+	unsigned long timeout = SMC_WR_TX_WAIT_FREE_SLOT_TIME;
> 	struct smc_link_group *lgr = smc_get_lgr(link);
> 	struct smc_wr_tx_pend *wr_pend;
> 	u32 idx = link->wr_tx_cnt;
>+	DEFINE_WAIT(wait);
> 	int rc;
> 
> 	*wr_buf = NULL;
>@@ -165,17 +167,31 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
> 		if (rc)
> 			return rc;
> 	} else {
>-		rc = wait_event_interruptible_timeout(
>-			link->wr_tx_wait,
>-			!smc_link_sendable(link) ||
>-			lgr->terminating ||
>-			(smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY),
>-			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
>-		if (!rc) {
>-			/* timeout - terminate link */
>-			smcr_link_down_cond_sched(link);
>-			return -EPIPE;
>+		rc = 0;
>+		for (;;) {
>+			prepare_to_wait_exclusive(&link->wr_tx_wait, &wait,
>+						  TASK_INTERRUPTIBLE);
>+			if (!smc_link_sendable(link) || lgr->terminating ||
>+			    smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY)
>+				break;
>+			timeout = schedule_timeout(timeout);
>+			/* re-check */
>+			if (!smc_link_sendable(link) || lgr->terminating ||
>+			    smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY)
>+				break;
>+			if (!timeout) {
>+				/* timeout - terminate link */
>+				smcr_link_down_cond_sched(link);
>+				break;
>+			}

The change itself looks correct to me. But I think we should probably define
a wait_event_interruptible_exclusive_timeout() helper in include/linux/wait.h
rather than open-coding it in smc ?

>+			if (signal_pending(current)) {
>+				rc = -ERESTARTSYS;
>+				break;
>+			}
> 		}

One more thing, seems we changed the signal here, it's better to add a comment
or note it in the commit message.

Best regards,
Dust



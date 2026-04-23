Return-Path: <linux-rdma+bounces-19495-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Bh6DxoA6mkHrAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19495-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 13:18:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4620E451329
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 13:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39DD53004D99
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 11:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1113E6DF0;
	Thu, 23 Apr 2026 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GrspeKci"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D5318B83;
	Thu, 23 Apr 2026 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943122; cv=none; b=CeeOMFLQYRFT0V+1FZOKpz1+KNsd9T3trW7hcy/LbbAPWeO2Bf6JsJTAm0+k7t0MqBfpCVdPVHpIsDVeFmvPyON0SX+vSLXZuwDZCwCIVKXutozKUumgpediJZx3BRGvm2eejYVC8y4OG8Fx0obqOdxnORaZRmk61SxGd9knj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943122; c=relaxed/simple;
	bh=+Ht1fX7O8pKem0a8MgKLr6XElqTzJxRyeT9Bznf9fMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7hBqOROhiF4ZX1U5Au42nyXCHISLcF104QZAmkoGqJIN8MiCDqRX693DYLQ956ECm2ccUweToUUs7EIBbDJwLdHhq7Lhd7eNi77ul+NDK3rDGe4jnioqRnVX/Z68/NzsidKgJIXs5TCIDT+hO7rnHLu9DSxTim49YIFXCyRNVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GrspeKci; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776943117; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=1EeyjAvqHGtasAKLij7JQvZvTEdx3GHT3hnRxa4XgIo=;
	b=GrspeKciy7JvZWe6DOoSDRXLwkn3fwSms0QANQ1FKJuF+aj9rqRWYrqoXuOoS1XvfXVjSSwZSTrE0YZYCBu9gsFYG+/aJ0R6XWEY+Sn05XyuagSE7dVg309AK5S6U/Bn3E51NzKW32JGw1AtcTf/fBqhJPHw/Le93xVaZgUYkfI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X1ZU3hl_1776943115;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X1ZU3hl_1776943115 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Apr 2026 19:18:36 +0800
Date: Thu, 23 Apr 2026 19:18:35 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Weiming Shi <bestswngs@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.vnet.ibm.com>,
	Ren Wei <n05ec@lzu.edu.cn>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net] net/smc: fix NULL pointer dereference in
 smc_clc_wait_msg()
Message-ID: <aeoAC_rsoqNpmAdl@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260423100205.1093987-3-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423100205.1093987-3-bestswngs@gmail.com>
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SEM_URIBL(3.50)[asu.edu:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[linux.alibaba.com:s=default];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19495-lists,linux-rdma=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linux.alibaba.com,none];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.015];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.alibaba.com:replyto,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 4620E451329
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-23 03:02:07, Weiming Shi wrote:

Hi Weiming,

Ren Wei has already send the patch to the mailist

[PATCH net 1/1] net/smc: avoid early lgr access in smc_clc_wait_msg

Best regards,
Dust

>In smc_listen_work(), smc_clc_wait_msg() is called to wait for a CLC
>PROPOSAL message before any link group has been created, so
>smc->conn.lgr is still NULL at this point. smc_clc_wait_msg() also
>accepts CLC DECLINE messages regardless of the expected type. When a
>DECLINE with SMC_FIRST_CONTACT_MASK set in hdr.typev2 arrives, the code
>unconditionally dereferences smc->conn.lgr to set sync_err, causing a
>NULL pointer dereference.
>
>KASAN reported a null-ptr-deref in smc_clc_wait_msg():
>
> Oops: general protection fault, 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000310-0x0000000000000317]
> RIP: 0010:smc_clc_wait_msg (net/smc/smc_clc.c:793)
> Call Trace:
>  <TASK>
>  smc_listen_work (net/smc/af_smc.c:2491)
>  process_one_work (kernel/workqueue.c:3281)
>  worker_thread (kernel/workqueue.c:3440)
>  kthread (kernel/kthread.c:436)
>  ret_from_fork (arch/x86/kernel/process.c:164)
>  ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
>  </TASK>
> Kernel panic - not syncing: Fatal exception
>
>Add a NULL check for smc->conn.lgr before dereferencing it. 
>
>Fixes: 0cfdd8f92cac ("smc: connection and link group creation")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/smc/smc_clc.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>index c38fc7bf0a7e..d22c9417d239 100644
>--- a/net/smc/smc_clc.c
>+++ b/net/smc/smc_clc.c
>@@ -790,8 +790,10 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
> 		smc->peer_diagnosis = ntohl(dclc->peer_diagnosis);
> 		if (((struct smc_clc_msg_decline *)buf)->hdr.typev2 &
> 						SMC_FIRST_CONTACT_MASK) {
>-			smc->conn.lgr->sync_err = 1;
>-			smc_lgr_terminate_sched(smc->conn.lgr);
>+			if (smc->conn.lgr) {
>+				smc->conn.lgr->sync_err = 1;
>+				smc_lgr_terminate_sched(smc->conn.lgr);
>+			}
> 		}
> 	}
> 
>-- 
>2.43.0


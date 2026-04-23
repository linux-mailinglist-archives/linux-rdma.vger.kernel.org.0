Return-Path: <linux-rdma+bounces-19494-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8qEpNxr86WlyqwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19494-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 13:01:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A545106B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 13:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 201223042270
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Apr 2026 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9C3E3DAD;
	Thu, 23 Apr 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gM4+758l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E2318B83;
	Thu, 23 Apr 2026 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941831; cv=none; b=QynT6MYUdAaRH+6YYkIPx52PM5KDcvd3vrxD5pqAHy03TUYdh2mqT7+JvQnqJQHC3Xo2GP8xxpdbK4BlDWg0kin4JYdZG8n3zIZy41uyWZp6kXkEyPJiLO8QCZsURvDIEy00knNNCxjvYbK8BJ6/2bnyeroq8RZphIQsf5FGXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941831; c=relaxed/simple;
	bh=x1cfWGvw5Do9Wneecux32loFJK989fZi5d5eQM4OJO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckw9TxMCywGW4iUjHbdJHDZs7DnYGHkmJNBjc64O3dad/2+8dUA2oYO2I349HO13nsRn/G4RGGQeRxp50jtS/n6K04F3KHd0uI8Dgu65+DxX8zeXmHdbSGwjNRf53SbdO3vg9wiOEIp15YDBRl4IjS78g1ftAoX69ULQMxd7BLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gM4+758l; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776941819; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=9q1FaQahwENCvtHoXxo/f55d34TX6GkQWSa7xSkulcw=;
	b=gM4+758l0p4Pas0xo1VH+iha7IZbtp1Ddjpn4Ik9jNZqOQWWn3Y+nHj7gKtKPgLU3pMmnbge53Sce1f6yrBYJV5/3+iIZ7dF2HE727j++6DzCa/YixCGSLwlFPYRM4XgKOXBRIkLggLI15KgWczKa0O8n2eDZFcRv9Qb+GQcv1w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X1ZQOX2_1776941817;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X1ZQOX2_1776941817 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Apr 2026 18:56:58 +0800
Date: Thu, 23 Apr 2026 18:56:57 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Ren Wei <n05ec@lzu.edu.cn>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	ubraun@linux.vnet.ibm.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	ruijieli51@gmail.com
Subject: Re: [PATCH net 1/1] net/smc: avoid early lgr access in
 smc_clc_wait_msg
Message-ID: <aen6-Q21biAYoXV_@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <cover.1776850759.git.ruijieli51@gmail.com>
 <08c68a5c817acf198cce63d22517e232e8d60718.1776850759.git.ruijieli51@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c68a5c817acf198cce63d22517e232e8d60718.1776850759.git.ruijieli51@gmail.com>
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19494-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,davemloft.net,google.com,kernel.org,redhat.com,linux.vnet.ibm.com,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:replyto,linux.alibaba.com:dkim,linux.alibaba.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Queue-Id: 788A545106B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-22 23:40:18, Ren Wei wrote:
>From: Ruijie Li <ruijieli51@gmail.com>
>
>A CLC decline can be received while the handshake is still in an early
>stage, before the connection has been associated with a link group.
>
>The decline handling in smc_clc_wait_msg() updates link-group level sync
>state for first-contact declines, but that state only exists after link
>group setup has completed. Guard the link-group update accordingly and
>keep the per-socket peer diagnosis handling unchanged.
>
>This preserves the existing sync_err handling for established link-group
>contexts and avoids touching link-group state before it is available.
>
>Fixes: 0cfdd8f92cac ("smc: connection and link group creation")
>Cc: stable@kernel.org
>Reported-by: Yuan Tan <yuantan098@gmail.com>
>Reported-by: Yifan Wu <yifanwucs@gmail.com>
>Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>Reported-by: Xin Liu <bird@lzu.edu.cn>
>Signed-off-by: Ruijie Li <ruijieli51@gmail.com>
>Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>


Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

>---
> net/smc/smc_clc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>index c38fc7bf0a7e..014d527d5462 100644
>--- a/net/smc/smc_clc.c
>+++ b/net/smc/smc_clc.c
>@@ -788,8 +788,8 @@ int smc_clc_wait_msg(struct smc_sock *smc, void *buf, int buflen,
> 		dclc = (struct smc_clc_msg_decline *)clcm;
> 		reason_code = SMC_CLC_DECL_PEERDECL;
> 		smc->peer_diagnosis = ntohl(dclc->peer_diagnosis);
>-		if (((struct smc_clc_msg_decline *)buf)->hdr.typev2 &
>-						SMC_FIRST_CONTACT_MASK) {
>+		if ((dclc->hdr.typev2 & SMC_FIRST_CONTACT_MASK) &&
>+		    smc->conn.lgr) {
> 			smc->conn.lgr->sync_err = 1;
> 			smc_lgr_terminate_sched(smc->conn.lgr);
> 		}
>-- 
>2.34.1


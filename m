Return-Path: <linux-rdma+bounces-20330-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AgdCjM1AWr2RwEAu9opvQ
	(envelope-from <linux-rdma+bounces-20330-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 03:47:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4C75070B0
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 03:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8635300D687
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 01:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84FD2192F4;
	Mon, 11 May 2026 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UcWEgmtK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0917555;
	Mon, 11 May 2026 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778464040; cv=none; b=dBz8cJTTg8ZNXZVG7xRIvSGsaTvsq7Eugca0wlPaa9VIa8+PUXu+fDIqVm835VtZJWW7qPpv5Un2spKjUF+n5RQwlWWfvbZbo3bVJXUByz/Dder3gsdLgiNMat4LDK/i9ViYrp4irnKAC+FEybMHxMoR4fyB5HaU3obuiH+xeS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778464040; c=relaxed/simple;
	bh=LIKXv1Kd6GGpmKPV+Z8tTgwfopFvpTic/tfiniEgv+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAqX+/hb/9itEK0/YqCskA5rqYq4iklXWBd8cPM4oSEJ18w4lrVQk5heVMWu0qx5V94M/XrBqRGRTVNodQt6VXru3H+QnNfAIbIW6yyPcX4pYezJLRd79y+eDjwnVdu6atIkRXZXeyL0nG5Lken+N9/XnvCAXQ8krkYCWisotjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UcWEgmtK; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778464027; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=CIPIrrLvucNN4Oz2zVGs+g4XHuh9AjvK+xZgw+ovFcI=;
	b=UcWEgmtK82XlyW6t6DMJgOsZMVN8WbuRv3mePhbxrles2CGfgoM3IIEW/a8BCqy54J/ShvcDF9mUEV8YULpibz68/OfYIlIppwuSKP9TPux9ubrOFPFlbim9CzQN5RdXuifMAfyza6XRwC2/WfnOixY5cklZu8UBn8eFlwxtY8k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X2dfoJ._1778464026;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X2dfoJ._1778464026 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 09:47:07 +0800
Date: Mon, 11 May 2026 09:47:06 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: =?iso-8859-1?Q?Nicol=F2?= Coccia <n.coccia96@gmail.com>,
	alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nicolo.coccia@leonardo.com
Subject: Re: [PATCH v3] net/smc: fix sleep-inside-lock in __smc_setsockopt()
 causing local DoS
Message-ID: <agE1Gnk_wJOxIi1V@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260510163414.16651-1-n.coccia96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260510163414.16651-1-n.coccia96@gmail.com>
X-Rspamd-Queue-Id: BC4C75070B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20330-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com,linux.ibm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,linux.alibaba.com:replyto,alibaba.com:email]
X-Rspamd-Action: no action

On 2026-05-10 12:34:13, Nicolò Coccia wrote:
>A logic flaw in __smc_setsockopt() allows a local unprivileged user to
>cause a Denial of Service (DoS) by holding the socket lock indefinitely.
>
>The function __smc_setsockopt() calls copy_from_sockptr() while holding
>lock_sock(sk). By passing a userfaultfd-monitored memory page (or
>FUSE-backed memory on systems where unprivileged userfaultfd is disabled)
>as the optval, an attacker can halt execution during the copy operation,
>keeping the lock held.
>
>Combined with asynchronous tear-down operations like shutdown(), this
>exhausts the kernel wq (kworkers) and triggers the hung task watchdog.
>
>[  240.123456] INFO: task kworker/u8:2 blocked for more than 120 seconds.
>[  240.123489] Call Trace:
>[  240.123501]  smc_shutdown+...
>[  240.123512]  lock_sock_nested+...
>
>This patch moves the user-space copy outside the lock_sock() critical
>section to prevent the issue.
>
>Fixes: a6a6fe27bab4 ("net/smc: Dynamic control handshake limitation by socket options")
>
>Signed-off-by: Nicolò Coccia <n.coccia96@gmail.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Tested-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust

>---
> v1 -> v3:
> - Resend via git send-email to fix webmail whitespace corruption
> - Rebased against netdev/net tree
> - Added Fixes tag
> net/smc/af_smc.c | 17 ++++++++---------
> 1 file changed, 8 insertions(+), 9 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>index 185dbed7de5d..da28652f6810 100644
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -3054,18 +3054,17 @@ static int __smc_setsockopt(struct socket *sock, int level, int optname,
> 
> 	smc = smc_sk(sk);
> 
>+	/* pre-fetch user data outside the lock */
>+	if (optname == SMC_LIMIT_HS) {
>+		if (optlen < sizeof(int))
>+			return -EINVAL;
>+		if (copy_from_sockptr(&val, optval, sizeof(int)))
>+			return -EFAULT;
>+	}
>+
> 	lock_sock(sk);
> 	switch (optname) {
> 	case SMC_LIMIT_HS:
>-		if (optlen < sizeof(int)) {
>-			rc = -EINVAL;
>-			break;
>-		}
>-		if (copy_from_sockptr(&val, optval, sizeof(int))) {
>-			rc = -EFAULT;
>-			break;
>-		}
>-
> 		smc->limit_smc_hs = !!val;
> 		rc = 0;
> 		break;
>-- 
>2.53.0


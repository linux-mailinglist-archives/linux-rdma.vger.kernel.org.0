Return-Path: <linux-rdma+bounces-20279-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pPm1KWCN/mkGswAAu9opvQ
	(envelope-from <linux-rdma+bounces-20279-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 03:26:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 144554FD466
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 03:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 028B830160FA
	for <lists+linux-rdma@lfdr.de>; Sat,  9 May 2026 01:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E326F2AF;
	Sat,  9 May 2026 01:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MzHKQbEN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1A2B2D7;
	Sat,  9 May 2026 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778290013; cv=none; b=S1jqjZmMAbH92HmJx0ZHcnSshf87Ijgi/r1i3cluIoXPNTs5g6o+5s0FojZcrL0se+HIhEVQBlsKuyDvb6vmFn+5taiCGQ7W/vVEtNf94I3eapodZlf7RqA7tXaCcFocmCEnNrsRUkU+xwV7+56qHxTLfysHjx4Ba6ypaWSxa8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778290013; c=relaxed/simple;
	bh=o/pgEhujTgFW9ZrLOfE0EEkoxNHPRtp/uayciKrbSy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItRa1GQEaf6KtPLfh42MPSHTlgXcNUJN8Y5LW1lQNlsyk8T2GOFz9WpYIOnzrjXIznxTbK8nQ/eJDNYNgPszmnLPdQjhpiKcB2qzXoqChAcdB0sox/I2Bp77iNP/e7KKBL+/kJhqOgawaZkDpj5snYKuxeHHyMMUlwx9/Rm5S+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MzHKQbEN; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778290008; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=9UtXgVP0JZ98tn0yJorMvY+odKuLJcc0wOsPfDynW4E=;
	b=MzHKQbENAHOKa+E4dz8w525oX9uUTE5vKK4/EsjO0pyAu4rm4lp7CLGjBk2U2jJIDaaRwGI2iWNlR4HZ+yxjBCw26a5ccdmbnHM6RS9GTOSscqfgwYLUhquN2HcfVGEv/UoN3TLXwAiiJjpAyhXs+6k+7FGCK1PUAXiFWy0I1pE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X2YvkY1_1778290006;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X2YvkY1_1778290006 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 09 May 2026 09:26:47 +0800
Date: Sat, 9 May 2026 09:26:46 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: =?iso-8859-1?Q?Nicol=F2?= Coccia <n.coccia96@gmail.com>,
	alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
	Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	mjambigi@linux.ibm.com,
	=?iso-8859-1?Q?Nicol=F2?= Coccia <nicolo.coccia@leonardo.com>
Subject: Re: [PATCH net] net/smc: fix sleep-inside-lock in __smc_setsockopt()
 causing local DoS
Message-ID: <af6NVrIetbLkENvu@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <CALSA8UaEKUHRqYaYqKFYbUQb4KHipDBDHfgMZHj2Tq0D1Ah7zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALSA8UaEKUHRqYaYqKFYbUQb4KHipDBDHfgMZHj2Tq0D1Ah7zw@mail.gmail.com>
X-Rspamd-Queue-Id: 144554FD466
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20279-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com,linux.ibm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,linux.alibaba.com:replyto]
X-Rspamd-Action: no action

On 2026-05-08 21:33:10, Nicolò Coccia wrote:

Hi Nicolò,

This patch doesn't apply on net/main

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

You should add a Fixes tag here.
>Signed-off-by: Nicolò Coccia nicolo.coccia@leonardo.com>
>---
> net/smc/af_smc.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>--- a/net/smc/af_smc.c
>+++ b/net/smc/af_smc.c
>@@ -XXXX,X +XXXX,X @@ static int __smc_setsockopt(struct socket *sock,
>int level, int optname,
>
>  smc = smc_sk(sk);
>
>+ /* pre-fetch user data outside the lock */
>+ if (optname == SMC_LIMIT_HS) {
>+ if (optlen < sizeof(int))
>+ return -EINVAL;
>+ if (copy_from_sockptr(&val, optval, sizeof(int)))
>+ return -EFAULT;
>+ }
>+
>  lock_sock(sk);
>  switch (optname) {
>  case SMC_LIMIT_HS:
>- if (optlen < sizeof(int)) {
>- rc = -EINVAL;
>- break;
>- }
>- if (copy_from_sockptr(&val, optval, sizeof(int))) {
>- rc = -EFAULT;
>- break;
>- }
>-

The indenting is all messed up

Best regards,
Dust



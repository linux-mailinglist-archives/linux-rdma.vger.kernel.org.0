Return-Path: <linux-rdma+bounces-22275-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1QYwGPgYMWpVbgUAu9opvQ
	(envelope-from <linux-rdma+bounces-22275-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 11:35:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C9868D982
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 11:35:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=TW7cUI5N;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22275-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22275-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C89D3113A72
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 09:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45B421F1E;
	Tue, 16 Jun 2026 09:30:17 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428063043C8;
	Tue, 16 Jun 2026 09:30:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602216; cv=none; b=s9MDrc6jUX9k9qRHpJVZzqbWDN47Tcm0kCDohqgZxuQ+4HzcWZPUXfaQ8HdIFQSc1MOG9WQkTPVFtWXLCXnce5qDRnKHDvI3nlAAKobUE3W8110RKUbJljcxZ7mFlKlk/WFeiZ/2+o4iT+qqpzCTsYCTjZXTOUhADrfZRJmUNrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602216; c=relaxed/simple;
	bh=BZd1+7kFgWteNht00h5YxHdkTi83EI5MB+Ho523Bqnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj7B0JPJ3ShqaG2+yxQbklWbkEfGS6WvJU2/+N7yLyBUKOr7osWqEPP3X6a9EE56XG1E7wqvKMfh3LCqjZMAAj8qtHXU3AJ3n/IOLIJvYI0+H6OY2IbqEyTDvm2HZGng3Ej0M54d3nyt7ZxQn8UcMtt9Btnn/8tI8pFQWCkG3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TW7cUI5N; arc=none smtp.client-ip=115.124.30.112
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781602205; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=081T06/+yJZlOpVrqr9xmO+pHUgrPiz3emTfwHp8+wc=;
	b=TW7cUI5N1kG5CSyANNG2gMx2Bfr9mCgrjynH9crlZJKA+WtJHwDkGR+UweGq8Rqei32w2fwFu2cJ4xgexmrSCB3OZdvLdzOfUYpfg5MpOhvZ4fm0Zcbxw1bhtUMxXU+ugH1AYkSvVVDVLY4NxIAgN3UDLwXjAxitkTZHIh12X/E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X5.0WJf_1781602204;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X5.0WJf_1781602204 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Jun 2026 17:30:04 +0800
Date: Tue, 16 Jun 2026 17:30:03 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Ren Wei <n05ec@lzu.edu.cn>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org
Cc: alibuda@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, ubraun@linux.ibm.com,
	stefan.raspl@linux.ibm.com, davem@davemloft.net,
	yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn,
	lx24@stu.ynu.edu.cn, d4n.for.sec@gmail.com
Subject: Re: [PATCH net 1/1] net: smc: fix splice entry lifetime imbalance in
 smc_rx_splice
Message-ID: <ajEXm3PDY8Wv8Ohh@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <cover.1781097957.git.d4n.for.sec@gmail.com>
 <192d1b44ed358ca143f44ef167d14153bccc51e9.1781097957.git.d4n.for.sec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <192d1b44ed358ca143f44ef167d14153bccc51e9.1781097957.git.d4n.for.sec@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22275-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:ubraun@linux.ibm.com,m:stefan.raspl@linux.ibm.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:lx24@stu.ynu.edu.cn,m:d4n.for.sec@gmail.com,m:d4nforsec@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,davemloft.net,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.alibaba.com:dkim,linux.alibaba.com:replyto,linux.alibaba.com:mid,linux.alibaba.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ynu.edu.cn:email,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3C9868D982

On 2026-06-11 01:54:11, Ren Wei wrote:
>From: Daming Li <d4n.for.sec@gmail.com>
>
>smc_rx_splice() hands candidate pages to splice_to_pipe() without taking
>references for the lifetime of each splice entry first. That breaks the
>splice ownership contract in the VM-backed RMB path.
>
>splice_to_pipe() drops unqueued entries through spd_release(), while
>queued entries are later dropped through the pipe buffer release
>callback. The current code only tries to take page references after the
>splice succeeds, and it derives the number of queued VM pages from a
>mutated offset value. This can underflow page refcounts and trigger a
>use-after-free. It also leaves the socket lifetime imbalanced in the
>multi-page VM case, where one sock_hold() can be followed by multiple
>sock_put() calls.
>
>Fix this by taking the page and socket references for every candidate
>splice entry before calling splice_to_pipe(), and by releasing the
>matching private state, page reference, and socket reference from
>smc_rx_spd_release() for entries that never get queued. This makes the
>SMC splice path follow the normal splice lifetime rules and removes the
>broken post-splice VM page counting entirely.
>
>Fixes: 9014db202cb7 ("smc: add support for splice()")
>Cc: stable@vger.kernel.org
>Reported-by: Yuan Tan <yuantan098@gmail.com>
>Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
>Reported-by: Xin Liu <bird@lzu.edu.cn>
>Assisted-by: Codex:GPT-5.4
>Co-developed-by: Liu Xiao <lx24@stu.ynu.edu.cn>
>Signed-off-by: Liu Xiao <lx24@stu.ynu.edu.cn>
>Signed-off-by: Daming Li <d4n.for.sec@gmail.com>
>Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

The patch looks good to me, a minor nit below

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>


>---
> net/smc/smc_rx.c | 21 +++++++++++----------
> 1 file changed, 11 insertions(+), 10 deletions(-)
>
>diff --git a/net/smc/smc_rx.c b/net/smc/smc_rx.c
>index c1d9b923938d..88aee0d93597 100644
>--- a/net/smc/smc_rx.c
>+++ b/net/smc/smc_rx.c
>@@ -150,18 +150,23 @@ static const struct pipe_buf_operations smc_pipe_ops = {
> static void smc_rx_spd_release(struct splice_pipe_desc *spd,
> 			       unsigned int i)
> {
>+	struct smc_spd_priv *priv = (struct smc_spd_priv *)spd->partial[i].private;
>+	struct sock *sk = &priv->smc->sk;
>+
>+	kfree(priv);
> 	put_page(spd->pages[i]);
>+	sock_put(sk);
> }
> 
> static int smc_rx_splice(struct pipe_inode_info *pipe, char *src, size_t len,
> 			 struct smc_sock *smc)
> {
> 	struct smc_link_group *lgr = smc->conn.lgr;
>-	int offset = offset_in_page(src);
> 	struct partial_page *partial;
> 	struct splice_pipe_desc spd;
> 	struct smc_spd_priv **priv;
> 	struct page **pages;
>+	int offset = offset_in_page(src);

Minor nit:
moving int offset = offset_in_page(src) down breaks the existing
reverse-xmas-tree declaration ordering. We keep this style in SMC.

Best regards,
Dust



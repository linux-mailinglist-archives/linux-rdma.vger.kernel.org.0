Return-Path: <linux-rdma+bounces-18644-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBw1OcopxGmZwgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18644-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:30:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5C832A965
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE964306998B
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A93242B5;
	Wed, 25 Mar 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="s8FWJBFv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8562BDC3F;
	Wed, 25 Mar 2026 18:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462885; cv=none; b=TLQ6uhBEufg0pbw/78r+hVXN1mJfOE1v8KTcA0fZSRLM4pfqaa35cOVAoejuuHK3XXzgGUh57xY029iADQykXdeXVOuHifmdHRxwhS7vcJXxmQsF0y19J5rmJH6EN+AvPztJ3Llc7I4v0/zj0HyqpbKhiiNOtOTFsrLCdgxpsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462885; c=relaxed/simple;
	bh=rjiawx6EmEMwdjLTNNNWaZgrxy7ftF1Ul74ILoIfVaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tOh5Mjygc9DGheXgVx6Z27i8r5AS35ehb2VzlE7GHj+nHnDY1FLsXJyUzFPDlmkruajzad1ak70HFPTsybGF3qjMFBX+rMYMt9sO2KHAAHZOy/Z/lFzNN/8bLDqGtURIwitl0goWnip6C2GEZJZDI0DFlFVF4fQF5Pwc3Ca9dMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=s8FWJBFv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D4CFD4E427F0;
	Wed, 25 Mar 2026 18:21:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A34FC601E2;
	Wed, 25 Mar 2026 18:21:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA71810451AAC;
	Wed, 25 Mar 2026 19:21:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774462880; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=/1T5b3IHwO6ZURBf1fbLrgaom5xpBmA3gheqNHS12NQ=;
	b=s8FWJBFvHPf83UCvUNXQaTtzR9CKeOx8tA2Lo+tynWXPgXZLFrZjPYxJGq6oBPSMJIFrz2
	wQ/lB4GVrOhC3Bq4py9cAj2hyU19cGlg8pnFIrGU18nGN5QeKDdCbKS4L4Kj2C/fJ11P+Q
	VBV6gdrjdMVM862/m/6Ff9XPCrQU7uy0p2J4q97R8H4lejvUrZ8BSKTkasgV0X8aMoxjgb
	JkYeLG1afEmx6uHMLJDWiS8hpb0vACgrlKYd7ChaOufD5HFUyKGRmr7wd61WgITdiknQ3f
	IN4mnmDSK2gs0Alk4ZjcjMYm+c8BvHGrmqJHmy3aNujwFGLJV4xMKgBT7Y5Ukw==
Message-ID: <b826daeb-e7af-42fc-bb18-0113e84b3891@bootlin.com>
Date: Wed, 25 Mar 2026 19:21:14 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/12] ethtool: Convert per-PHY commands to
 dump_one_dev
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Naveen Mamindlapalli
 <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Danielle Ratson <danieller@nvidia.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Leon Romanovsky
 <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Saeed Mahameed <saeedm@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20260325145022.2607545-1-bjorn@kernel.org>
 <20260325145022.2607545-3-bjorn@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260325145022.2607545-3-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18644-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com];
	FREEMAIL_CC(0.00)[nvidia.com,marvell.com,bootlin.com,kernel.org,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6D5C832A965
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Björn

On 25/03/2026 15:50, Björn Töpel wrote:
> Convert PSE, PLCA, PHY, and MSE commands from the separate
> ethnl_perphy_{start,dumpit,done} handlers to use the generic
> dump_one_dev callback. This removes the per-PHY specific dump
> infrastructure (ethnl_perphy_dump_ctx, ethnl_perphy_dump_context,
> ethnl_perphy_start, ethnl_perphy_dumpit, ethnl_perphy_done, and the
> internal helpers) in favor of a shared ethnl_perphy_dump_one_dev()
> function.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  net/ethtool/mse.c     |   1 +
>  net/ethtool/netlink.c | 194 ++++++------------------------------------
>  net/ethtool/netlink.h |   4 +
>  net/ethtool/phy.c     |   1 +
>  net/ethtool/plca.c    |   2 +
>  net/ethtool/pse-pd.c  |   1 +
>  6 files changed, 35 insertions(+), 168 deletions(-)
> 
> diff --git a/net/ethtool/mse.c b/net/ethtool/mse.c
> index e91b74430f76..3f33182283ce 100644
> --- a/net/ethtool/mse.c
> +++ b/net/ethtool/mse.c
> @@ -325,4 +325,5 @@ const struct ethnl_request_ops ethnl_mse_request_ops = {
>  	.cleanup_data = mse_cleanup_data,
>  	.reply_size = mse_reply_size,
>  	.fill_reply = mse_fill_reply,
> +	.dump_one_dev = ethnl_perphy_dump_one_dev,
>  };
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 8d161f0882d0..edeeca67918a 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -399,12 +399,6 @@ static struct ethnl_dump_ctx *ethnl_dump_context(struct netlink_callback *cb)
>  	return (struct ethnl_dump_ctx *)cb->ctx;
>  }
>  
> -static struct ethnl_perphy_dump_ctx *
> -ethnl_perphy_dump_context(struct netlink_callback *cb)
> -{
> -	return (struct ethnl_perphy_dump_ctx *)cb->ctx;
> -}
> -
>  /**
>   * ethnl_default_parse() - Parse request message
>   * @req_info:    pointer to structure to put data into
> @@ -686,169 +680,33 @@ static int ethnl_default_start(struct netlink_callback *cb)
>  	return ret;
>  }
>  
> -/* per-PHY ->start() handler for GET requests */
> -static int ethnl_perphy_start(struct netlink_callback *cb)
> +/* Shared dump_one_dev for per-PHY commands (PSE, PLCA, PHY, MSE) */
> +int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
> +			      struct ethnl_dump_ctx *ctx,
> +			      unsigned long *pos_sub,
> +			      const struct genl_info *info)
>  {
> -	struct ethnl_perphy_dump_ctx *phy_ctx = ethnl_perphy_dump_context(cb);
> -	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
> -	struct ethnl_dump_ctx *ctx = &phy_ctx->ethnl_ctx;
> -	struct ethnl_reply_data *reply_data;
> -	const struct ethnl_request_ops *ops;
> -	struct ethnl_req_info *req_info;
> -	struct genlmsghdr *ghdr;
> -	int ret;
> -
> -	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
> -
> -	ghdr = nlmsg_data(cb->nlh);
> -	ops = ethnl_default_requests[ghdr->cmd];
> -	if (WARN_ONCE(!ops, "cmd %u has no ethnl_request_ops\n", ghdr->cmd))
> -		return -EOPNOTSUPP;
> -	req_info = kzalloc(ops->req_info_size, GFP_KERNEL);
> -	if (!req_info)
> -		return -ENOMEM;
> -	reply_data = kmalloc(ops->reply_data_size, GFP_KERNEL);
> -	if (!reply_data) {
> -		ret = -ENOMEM;
> -		goto free_req_info;
> -	}
> -
> -	/* Unlike per-dev dump, don't ignore dev. The dump handler
> -	 * will notice it and dump PHYs from given dev. We only keep track of
> -	 * the dev's ifindex, .dumpit() will grab and release the netdev itself.
> -	 */
> -	ret = ethnl_default_parse(req_info, &info->info, ops, false);
> -	if (ret < 0)
> -		goto free_reply_data;
> -	if (req_info->dev) {
> -		phy_ctx->ifindex = req_info->dev->ifindex;
> -		netdev_put(req_info->dev, &req_info->dev_tracker);
> -		req_info->dev = NULL;
> -	}
> -
> -	ctx->ops = ops;
> -	ctx->req_info = req_info;
> -	ctx->reply_data = reply_data;
> -	ctx->pos_ifindex = 0;
> -
> -	return 0;
> -
> -free_reply_data:
> -	kfree(reply_data);
> -free_req_info:
> -	kfree(req_info);
> -
> -	return ret;
> -}
> -
> -static int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
> -				     struct ethnl_perphy_dump_ctx *ctx,
> -				     const struct genl_info *info)
> -{
> -	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> -	struct net_device *dev = ethnl_ctx->req_info->dev;
> +	struct net_device *dev = ctx->req_info->dev;
>  	struct phy_device_node *pdn;
>  	int ret;
>  
>  	if (!dev->link_topo)
>  		return 0;
>  
> -	xa_for_each_start(&dev->link_topo->phys, ctx->pos_phyindex, pdn,
> -			  ctx->pos_phyindex) {
> -		ethnl_ctx->req_info->phy_index = ctx->pos_phyindex;
> +	xa_for_each_start(&dev->link_topo->phys, *pos_sub, pdn,
> +			  *pos_sub) {
> +		ctx->req_info->phy_index = *pos_sub;
>  
>  		/* We can re-use the original dump_one as ->prepare_data in
>  		 * commands use ethnl_req_get_phydev(), which gets the PHY from
>  		 * the req_info->phy_index
>  		 */
> -		ret = ethnl_default_dump_one(skb, dev, ethnl_ctx, info);
> +		ret = ethnl_default_dump_one(skb, dev, ctx, info);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	ctx->pos_phyindex = 0;
> -
> -	return 0;
> -}
> -
> -static int ethnl_perphy_dump_all_dev(struct sk_buff *skb,
> -				     struct ethnl_perphy_dump_ctx *ctx,
> -				     const struct genl_info *info)
> -{
> -	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> -	struct net *net = sock_net(skb->sk);
> -	netdevice_tracker dev_tracker;
> -	struct net_device *dev;
> -	int ret = 0;
> -
> -	rcu_read_lock();
> -	for_each_netdev_dump(net, dev, ethnl_ctx->pos_ifindex) {
> -		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
> -		rcu_read_unlock();
> -
> -		/* per-PHY commands use ethnl_req_get_phydev(), which needs the
> -		 * net_device in the req_info
> -		 */
> -		ethnl_ctx->req_info->dev = dev;
> -		ret = ethnl_perphy_dump_one_dev(skb, ctx, info);
> -
> -		rcu_read_lock();
> -		netdev_put(dev, &dev_tracker);
> -		ethnl_ctx->req_info->dev = NULL;
> -
> -		if (ret < 0 && ret != -EOPNOTSUPP) {
> -			if (likely(skb->len))
> -				ret = skb->len;
> -			break;
> -		}
> -		ret = 0;
> -	}
> -	rcu_read_unlock();
> -
> -	return ret;
> -}
> -
> -/* per-PHY ->dumpit() handler for GET requests. */
> -static int ethnl_perphy_dumpit(struct sk_buff *skb,
> -			       struct netlink_callback *cb)
> -{
> -	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
> -	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
> -	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> -	int ret = 0;
> -
> -	if (ctx->ifindex) {
> -		netdevice_tracker dev_tracker;
> -		struct net_device *dev;
> -
> -		dev = netdev_get_by_index(genl_info_net(&info->info),
> -					  ctx->ifindex, &dev_tracker,
> -					  GFP_KERNEL);
> -		if (!dev)
> -			return -ENODEV;
> -
> -		ethnl_ctx->req_info->dev = dev;
> -		ret = ethnl_perphy_dump_one_dev(skb, ctx, genl_info_dump(cb));
> -
> -		if (ret < 0 && ret != -EOPNOTSUPP && likely(skb->len))
> -			ret = skb->len;
> -
> -		netdev_put(dev, &dev_tracker);
> -	} else {
> -		ret = ethnl_perphy_dump_all_dev(skb, ctx, genl_info_dump(cb));
> -	}
> -
> -	return ret;
> -}
> -
> -/* per-PHY ->done() handler for GET requests */
> -static int ethnl_perphy_done(struct netlink_callback *cb)
> -{
> -	struct ethnl_perphy_dump_ctx *ctx = ethnl_perphy_dump_context(cb);
> -	struct ethnl_dump_ctx *ethnl_ctx = &ctx->ethnl_ctx;
> -
> -	kfree(ethnl_ctx->reply_data);
> -	kfree(ethnl_ctx->req_info);
> +	*pos_sub = 0;
>  
>  	return 0;
>  }
> @@ -1410,9 +1268,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
>  	{
>  		.cmd	= ETHTOOL_MSG_PSE_GET,
>  		.doit	= ethnl_default_doit,
> -		.start	= ethnl_perphy_start,
> -		.dumpit	= ethnl_perphy_dumpit,
> -		.done	= ethnl_perphy_done,
> +		.start	= ethnl_default_start,
> +		.dumpit	= ethnl_default_dumpit,
> +		.done	= ethnl_default_done,
>  		.policy = ethnl_pse_get_policy,
>  		.maxattr = ARRAY_SIZE(ethnl_pse_get_policy) - 1,
>  	},
> @@ -1434,9 +1292,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
>  	{
>  		.cmd	= ETHTOOL_MSG_PLCA_GET_CFG,
>  		.doit	= ethnl_default_doit,
> -		.start	= ethnl_perphy_start,
> -		.dumpit	= ethnl_perphy_dumpit,
> -		.done	= ethnl_perphy_done,
> +		.start	= ethnl_default_start,
> +		.dumpit	= ethnl_default_dumpit,
> +		.done	= ethnl_default_done,
>  		.policy = ethnl_plca_get_cfg_policy,
>  		.maxattr = ARRAY_SIZE(ethnl_plca_get_cfg_policy) - 1,
>  	},
> @@ -1450,9 +1308,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
>  	{
>  		.cmd	= ETHTOOL_MSG_PLCA_GET_STATUS,
>  		.doit	= ethnl_default_doit,
> -		.start	= ethnl_perphy_start,
> -		.dumpit	= ethnl_perphy_dumpit,
> -		.done	= ethnl_perphy_done,
> +		.start	= ethnl_default_start,
> +		.dumpit	= ethnl_default_dumpit,
> +		.done	= ethnl_default_done,
>  		.policy = ethnl_plca_get_status_policy,
>  		.maxattr = ARRAY_SIZE(ethnl_plca_get_status_policy) - 1,
>  	},
> @@ -1482,9 +1340,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
>  	{
>  		.cmd	= ETHTOOL_MSG_PHY_GET,
>  		.doit	= ethnl_default_doit,
> -		.start	= ethnl_perphy_start,
> -		.dumpit	= ethnl_perphy_dumpit,
> -		.done	= ethnl_perphy_done,
> +		.start	= ethnl_default_start,
> +		.dumpit	= ethnl_default_dumpit,
> +		.done	= ethnl_default_done,
>  		.policy = ethnl_phy_get_policy,
>  		.maxattr = ARRAY_SIZE(ethnl_phy_get_policy) - 1,
>  	},
> @@ -1528,9 +1386,9 @@ static const struct genl_ops ethtool_genl_ops[] = {
>  	{
>  		.cmd	= ETHTOOL_MSG_MSE_GET,
>  		.doit	= ethnl_default_doit,
> -		.start	= ethnl_perphy_start,
> -		.dumpit	= ethnl_perphy_dumpit,
> -		.done	= ethnl_perphy_done,
> +		.start	= ethnl_default_start,
> +		.dumpit	= ethnl_default_dumpit,
> +		.done	= ethnl_default_done,
>  		.policy = ethnl_mse_get_policy,
>  		.maxattr = ARRAY_SIZE(ethnl_mse_get_policy) - 1,
>  	},
> diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> index e01adc5db02f..dda2f5593ed9 100644
> --- a/net/ethtool/netlink.h
> +++ b/net/ethtool/netlink.h
> @@ -546,6 +546,10 @@ int ethnl_tsinfo_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
>  int ethnl_tsinfo_done(struct netlink_callback *cb);
>  int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info);
>  int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info);
> +int ethnl_perphy_dump_one_dev(struct sk_buff *skb,
> +			      struct ethnl_dump_ctx *ctx,
> +			      unsigned long *pos_sub,
> +			      const struct genl_info *info);
>  
>  extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
>  extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
> index d4e6887055ab..4bb23a5d6ad5 100644
> --- a/net/ethtool/phy.c
> +++ b/net/ethtool/phy.c
> @@ -162,4 +162,5 @@ const struct ethnl_request_ops ethnl_phy_request_ops = {
>  	.reply_size		= phy_reply_size,
>  	.fill_reply		= phy_fill_reply,
>  	.cleanup_data		= phy_cleanup_data,
> +	.dump_one_dev		= ethnl_perphy_dump_one_dev,
>  };
> diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
> index 91f0c4233298..84e902532617 100644
> --- a/net/ethtool/plca.c
> +++ b/net/ethtool/plca.c
> @@ -188,6 +188,7 @@ const struct ethnl_request_ops ethnl_plca_cfg_request_ops = {
>  	.prepare_data		= plca_get_cfg_prepare_data,
>  	.reply_size		= plca_get_cfg_reply_size,
>  	.fill_reply		= plca_get_cfg_fill_reply,
> +	.dump_one_dev		= ethnl_perphy_dump_one_dev,
>  
>  	.set			= ethnl_set_plca,
>  	.set_ntf_cmd		= ETHTOOL_MSG_PLCA_NTF,
> @@ -268,4 +269,5 @@ const struct ethnl_request_ops ethnl_plca_status_request_ops = {
>  	.prepare_data		= plca_get_status_prepare_data,
>  	.reply_size		= plca_get_status_reply_size,
>  	.fill_reply		= plca_get_status_fill_reply,
> +	.dump_one_dev		= ethnl_perphy_dump_one_dev,
>  };
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index 2eb9bdc2dcb9..83f0205053a3 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -338,6 +338,7 @@ const struct ethnl_request_ops ethnl_pse_request_ops = {
>  	.reply_size		= pse_reply_size,
>  	.fill_reply		= pse_fill_reply,
>  	.cleanup_data		= pse_cleanup_data,
> +	.dump_one_dev		= ethnl_perphy_dump_one_dev,
>  
>  	.set			= ethnl_set_pse,
>  	/* PSE has no notification */



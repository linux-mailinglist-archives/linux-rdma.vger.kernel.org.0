Return-Path: <linux-rdma+bounces-18643-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEVYHP8nxGmZwgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18643-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:22:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 641C632A825
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D626F303B91D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 18:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEF6324B2C;
	Wed, 25 Mar 2026 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="04Pb4IdK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0446A31F989;
	Wed, 25 Mar 2026 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462847; cv=none; b=IeV4U7pYXMLZ4lZjfd91iyi5mSOKdWErXQt5vnPsCvlq2BRi2rBs9heu1wgCc3bcc+WIu93rev4grGz9X/2pV1hoSlSsIXKL6b0MXTwz1uLCwjZ97rKdxATxDW2XvFuo6h/vO8KU+EbacnkvCgQ3wXJu8oHHBAjAHMB66QBSjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462847; c=relaxed/simple;
	bh=ltAoat21rJn02f3Y50PvWgqN4+qGImSCOlSy35sz+xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzJm4X0+goHte8gYJDUlK86MBnGqT0MVEScwxwH0X2z0rvONqGxmLhnHufytKNR+Or6CoVp/t4DAcNyN8Rj9Qt5sL+y1SnkN0xFCsi4IofY316klmq8pjfy+W3pzU3+to5moUEEOaT4wKj8Q0+Q+yiOqQZH8jj/LFqRO1fsFwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=04Pb4IdK; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0A3BBC580B1;
	Wed, 25 Mar 2026 18:21:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F3EFD601E2;
	Wed, 25 Mar 2026 18:20:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 338D710451AAC;
	Wed, 25 Mar 2026 19:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774462840; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cTKOwJYNrvvhkzO4zvexjdJUW8inx2Zq1E5eCpvSfc4=;
	b=04Pb4IdKqX0nqRsg1fes6E8hZTdKSXg4UByboLDPjzjUPo3ucEagv9b3oMGvz/8kaxDX1t
	9yvmMBF56Rnh7DBov8eNsCyikKPrEiPj8rFRwJfTwRsiCR5pbyqaZQbqiEdYJ1EZvtg4Qh
	AATtHWnl9NAkzm5aDmZM3+fiXEWP5YqO2KYdGQsayU92nnsI0RHN2bk5Aqc6yY9njuzqqM
	FDS7eko7u6oIgTQ8lmBFy/9OEhi4D5PjIHil+YJgIAAIiKSfdfECIONGuDQ8dI6MTkSTSn
	HmlXX4I+QRfzsQpiiF3N6Y1fmb4n3eFjPT23J2UwkjW8oYrHERtBi1tWcQQZqg==
Message-ID: <267901bc-bde6-443b-bf78-8c73831fc886@bootlin.com>
Date: Wed, 25 Mar 2026 19:20:31 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/12] ethtool: Add dump_one_dev callback for
 per-device sub-iteration
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
 <20260325145022.2607545-2-bjorn@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260325145022.2607545-2-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18643-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,marvell.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[nvidia.com,marvell.com,bootlin.com,kernel.org,broadcom.com,pengutronix.de,gmail.com,armlinux.org.uk,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: 641C632A825
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Björn,

On 25/03/2026 15:50, Björn Töpel wrote:
> Add the dump_one_dev callback to ethnl_request_ops, allowing commands
> to provide custom per-device dump logic with sub-positioning. Extend
> ethnl_dump_ctx with ifindex and pos_sub fields.
> 
> No functional change; no command uses dump_one_dev yet.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

Awesome :) I confirm that the phy dump still works just fine, and this
looks much simpler to me.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  net/ethtool/netlink.c | 66 ++++++++++++++++++-------------------------
>  net/ethtool/netlink.h | 31 ++++++++++++++++++++
>  2 files changed, 58 insertions(+), 39 deletions(-)
> 
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 5046023a30b1..8d161f0882d0 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -346,36 +346,6 @@ int ethnl_multicast(struct sk_buff *skb, struct net_device *dev)
>  
>  /* GET request helpers */
>  
> -/**
> - * struct ethnl_dump_ctx - context structure for generic dumpit() callback
> - * @ops:        request ops of currently processed message type
> - * @req_info:   parsed request header of processed request
> - * @reply_data: data needed to compose the reply
> - * @pos_ifindex: saved iteration position - ifindex
> - *
> - * These parameters are kept in struct netlink_callback as context preserved
> - * between iterations. They are initialized by ethnl_default_start() and used
> - * in ethnl_default_dumpit() and ethnl_default_done().
> - */
> -struct ethnl_dump_ctx {
> -	const struct ethnl_request_ops	*ops;
> -	struct ethnl_req_info		*req_info;
> -	struct ethnl_reply_data		*reply_data;
> -	unsigned long			pos_ifindex;
> -};
> -
> -/**
> - * struct ethnl_perphy_dump_ctx - context for dumpit() PHY-aware callbacks
> - * @ethnl_ctx: generic ethnl context
> - * @ifindex: For Filtered DUMP requests, the ifindex of the targeted netdev
> - * @pos_phyindex: iterator position for multi-msg DUMP
> - */
> -struct ethnl_perphy_dump_ctx {
> -	struct ethnl_dump_ctx	ethnl_ctx;
> -	unsigned int		ifindex;
> -	unsigned long		pos_phyindex;
> -};
> -
>  static const struct ethnl_request_ops *
>  ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] = {
>  	[ETHTOOL_MSG_STRSET_GET]	= &ethnl_strset_request_ops,
> @@ -618,6 +588,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
>  				struct netlink_callback *cb)
>  {
>  	struct ethnl_dump_ctx *ctx = ethnl_dump_context(cb);
> +	const struct genl_info *info = genl_info_dump(cb);
>  	struct net *net = sock_net(skb->sk);
>  	netdevice_tracker dev_tracker;
>  	struct net_device *dev;
> @@ -625,10 +596,20 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
>  
>  	rcu_read_lock();
>  	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> +		if (ctx->ifindex && ctx->ifindex != ctx->pos_ifindex)
> +			break;
> +
>  		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
>  		rcu_read_unlock();
>  
> -		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
> +		if (ctx->ops->dump_one_dev) {
> +			ctx->req_info->dev = dev;
> +			ret = ctx->ops->dump_one_dev(skb, ctx, &ctx->pos_sub,
> +						     info);
> +			ctx->req_info->dev = NULL;
> +		} else {
> +			ret = ethnl_default_dump_one(skb, dev, ctx, info);
> +		}
>  
>  		rcu_read_lock();
>  		netdev_put(dev, &dev_tracker);
> @@ -674,19 +655,26 @@ static int ethnl_default_start(struct netlink_callback *cb)
>  	ret = ethnl_default_parse(req_info, &info->info, ops, false);
>  	if (ret < 0)
>  		goto free_reply_data;
> -	if (req_info->dev) {
> -		/* We ignore device specification in dump requests but as the
> -		 * same parser as for non-dump (doit) requests is used, it
> -		 * would take reference to the device if it finds one
> -		 */
> -		netdev_put(req_info->dev, &req_info->dev_tracker);
> -		req_info->dev = NULL;
> -	}
>  
>  	ctx->ops = ops;
>  	ctx->req_info = req_info;
>  	ctx->reply_data = reply_data;
>  	ctx->pos_ifindex = 0;
> +	ctx->ifindex = 0;
> +	ctx->pos_sub = 0;
> +
> +	if (req_info->dev) {
> +		if (ops->dump_one_dev) {
> +			/* Sub-iterator dumps keep track of the dev's ifindex
> +			 * so the dumpit handler can grab/release the netdev
> +			 * per iteration.
> +			 */
> +			ctx->ifindex = req_info->dev->ifindex;
> +			ctx->pos_ifindex = ctx->ifindex;
> +		}
> +		netdev_put(req_info->dev, &req_info->dev_tracker);
> +		req_info->dev = NULL;
> +	}
>  
>  	return 0;
>  
> diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
> index aaf6f2468768..e01adc5db02f 100644
> --- a/net/ethtool/netlink.h
> +++ b/net/ethtool/netlink.h
> @@ -10,6 +10,28 @@
>  
>  struct ethnl_req_info;
>  
> +/**
> + * struct ethnl_dump_ctx - context structure for generic dumpit() callback
> + * @ops:        request ops of currently processed message type
> + * @req_info:   parsed request header of processed request
> + * @reply_data: data needed to compose the reply
> + * @pos_ifindex: saved iteration position - ifindex
> + * @ifindex:    for filtered dump requests, the ifindex of the targeted netdev
> + * @pos_sub:    iterator position for per-device iteration
> + *
> + * These parameters are kept in struct netlink_callback as context preserved
> + * between iterations. They are initialized by ethnl_default_start() and used
> + * in ethnl_default_dumpit() and ethnl_default_done().
> + */
> +struct ethnl_dump_ctx {
> +	const struct ethnl_request_ops	*ops;
> +	struct ethnl_req_info		*req_info;
> +	struct ethnl_reply_data		*reply_data;
> +	unsigned long			pos_ifindex;
> +	unsigned int			ifindex;
> +	unsigned long			pos_sub;
> +};
> +
>  u32 ethnl_bcast_seq_next(void);
>  int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
>  			       const struct nlattr *nest, struct net *net,
> @@ -365,6 +387,10 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
>   *	used e.g. to free any additional data structures outside the main
>   *	structure which were allocated by ->prepare_data(). When processing
>   *	dump requests, ->cleanup() is called for each message.
> + * @dump_one_dev:
> + *	Optional callback for dumping data for a single device. When set,
> + *	overrides the default dump behavior for GET requests, allowing
> + *	per-device iteration with sub-positioning via @pos_sub.
>   * @set_validate:
>   *	Check if set operation is supported for a given device, and perform
>   *	extra input checks. Expected return values:
> @@ -409,6 +435,11 @@ struct ethnl_request_ops {
>  			  const struct ethnl_reply_data *reply_data);
>  	void (*cleanup_data)(struct ethnl_reply_data *reply_data);
>  
> +	int (*dump_one_dev)(struct sk_buff *skb,
> +			    struct ethnl_dump_ctx *ctx,
> +			    unsigned long *pos_sub,
> +			    const struct genl_info *info);
> +
>  	int (*set_validate)(struct ethnl_req_info *req_info,
>  			    struct genl_info *info);
>  	int (*set)(struct ethnl_req_info *req_info,



Return-Path: <linux-rdma+bounces-17935-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKOrMRYGsWmypwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17935-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:05:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A6825CA38
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 07:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6FB53173787
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 06:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C4F350D74;
	Wed, 11 Mar 2026 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LKYb4nGD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC057286A4;
	Wed, 11 Mar 2026 06:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209104; cv=none; b=S8SyxSTNJe0Jv60/kTOqvi/DT5xRyTFBWacAKE4nSMqlTFlvCiDIQkD6gQouBgIviuSHgLvEbvjVeNqpYhJsgjhYhz/akc9Lo9ASZ8r2SpAj1z8i2IcMu4qUGQDgRFYh7N2QzwIOesqryMvCfqdkfGWRMYfjP7E86pBfpq2xE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209104; c=relaxed/simple;
	bh=EoDZokTNacODFg7MERzvCvMTIvcpDh2LnUT6M/WW8IU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUQZUlhWqBLVLjReTIylbcfGaWO8uq6CFxm2zjcCTu+4723IP6/gu+wnoHuBkU2YAQuIn5NrfgOxgczoasTYXKumBl5KP8ceTeD7uAWg0tCijgnfrLbxzCEWjCaX+xR13ImDo4maDsCjoc61TGK4tk2T/Myv4bAcJGovNKDXW2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LKYb4nGD; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AI0PAb1846058;
	Tue, 10 Mar 2026 23:04:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
	03K6yaXHoWvcycPEd8JMn3X9+r02Wt71VUUHu2hr08=; b=LKYb4nGD7q5F9v7jU
	+v0SsOT4Kp+56vGX+Y7AOuR+dJRJlhljMtQPE6VRZV0QxXX6GidjTLJu5/9beg4v
	8y0jTDJC/LiKQ1iAZsKUztCI5dC7yl+3+Qh+SNyvqoIx8cgzkzPnCTGGS1EOuNUo
	k5JxCZziE8S2qozn2GNkDseVOKoTyHYV5ArBh9PjwEIVFooVS2hGlrVn/mFWVAcQ
	jFBtLj9mJN9jeGSYucX90cCv4ug1vw5Ebv078BcJicvi7UoSlyqV0ax1cFdt1s6r
	Uj3GcG5pbPsoy241CyqVSltyr4atdP5/Fq+0/5uC/wgGGlcjl5g5367CKcl0kGSI
	0X9uA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cte6uknmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 23:04:40 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Mar 2026 23:04:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 10 Mar 2026 23:04:38 -0700
Received: from naveenm-PowerEdge-T630 (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id 8BC3E5B6989;
	Tue, 10 Mar 2026 23:04:31 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:34:30 +0530
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        "Andrew
 Lunn" <andrew+netdev@lunn.ch>,
        Donald Hunter <donald.hunter@gmail.com>,
        "Eric
 Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Danielle Ratson <danieller@nvidia.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        "Kory Maincent" <kory.maincent@bootlin.com>,
        Leon Romanovsky
	<leon@kernel.org>,
        Michael Chan <michael.chan@broadcom.com>,
        Oleksij Rempel
	<o.rempel@pengutronix.de>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>,
        Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan
	<shuah@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Willem de Bruijn
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH 6/11] ethtool: Add MAC loopback support via ethtool_ops
Message-ID: <abEF7pwe7YoFMNjq@naveenm-PowerEdge-T630>
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-7-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310104743.907818-7-bjorn@kernel.org>
X-Authority-Analysis: v=2.4 cv=SPlPlevH c=1 sm=1 tr=0 ts=69b105f8 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=M5GUcnROAAAA:8 a=yMkul1ESBu2jJWT5KQUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA0OSBTYWx0ZWRfXwL6H1FRHddPI
 8xRctcQsi6NFlQSNFDEEnBjuMkLdhZIi73q/tuCqJoQucseU7Ni6eF8/PvCCy1KEjRid/XgWaen
 KOcYXk751JmGEMM9jvgAD+e+6OD35KIrPbsbbJTVZzOB7dPMI8C3vB8LgEyOvO9byq/Tf+89Pvl
 57Okj7fb7orHURxy+C6UG+7akp++vemnoNwLA+vlmcCxE/jthGBXQ1xU/H7k64IG1s8OjvaKgYA
 TKD3fIkxWSAwat5ATnFzbuuGysE+mgiAwTMLxD5W1HvTYUd036837UQA8enfcGVgmqGaLizpO+s
 TlhbNeTzABYnE9plediDn8CQyXRm2KOnfjowPRauy944+au+LlzrviCIrxdMDI4Oe1tO4wmCafi
 30PsAkeEFx04wvizNQBEFLf8qx353uQlIklWiI/FaArthlOF290VAvEYUK/tTgTsJDSbDhwmGzD
 Vj8kVEzRYEQEYiao6lg==
X-Proofpoint-GUID: 3d6G_mDYEiulfnwmQT71ANZNKGGQ1bmr
X-Proofpoint-ORIG-GUID: 3d6G_mDYEiulfnwmQT71ANZNKGGQ1bmr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Rspamd-Queue-Id: 71A6825CA38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17935-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,bootlin.com,redhat.com,nvidia.com,marvell.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naveenm@marvell.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

On 2026-03-10 at 16:17:36, Björn Töpel (bjorn@kernel.org) wrote:
> Extend struct ethtool_ops with three loopback callbacks that drivers
> can implement for MAC-level loopback control:
> 
>  - get_loopback(dev, name, id, entry): exact lookup by name and
>    instance id, used by doit (single-entry GET) requests.
> 
>  - get_loopback_by_index(dev, index, entry): flat enumeration by
>    index, used by dumpit (multi-entry GET) requests to iterate all
>    loopback points on a device.
> 
>  - set_loopback(dev, entry, extack): apply a loopback configuration
>    change. Returns 1 if hardware state changed, 0 if no-op.
> 
> Wire the MAC component into loopback.c's dispatch functions. For dump
> enumeration, MAC entries are tried first via the driver's
> get_loopback_by_index() op, then MODULE/CMIS entries follow at the
> next index offset.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  include/linux/ethtool.h |  7 ++++++
>  net/ethtool/loopback.c  | 56 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 51 insertions(+), 12 deletions(-)
>

The MAC loopback callbacks look good.
Reviewed-by: Naveen Mamindlapalli <naveenm@marvell.com>
 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index c9beca11fc40..8893e732f930 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1321,6 +1321,13 @@ struct ethtool_ops {
>  	int	(*set_mm)(struct net_device *dev, struct ethtool_mm_cfg *cfg,
>  			  struct netlink_ext_ack *extack);
>  	void	(*get_mm_stats)(struct net_device *dev, struct ethtool_mm_stats *stats);
> +	int	(*get_loopback)(struct net_device *dev, const char *name,
> +				u32 id, struct ethtool_loopback_entry *entry);
> +	int	(*get_loopback_by_index)(struct net_device *dev, u32 index,
> +					 struct ethtool_loopback_entry *entry);
> +	int	(*set_loopback)(struct net_device *dev,
> +				const struct ethtool_loopback_entry *entry,
> +				struct netlink_ext_ack *extack);
>  };
>  
>  int ethtool_check_ops(const struct ethtool_ops *ops);
> diff --git a/net/ethtool/loopback.c b/net/ethtool/loopback.c
> index ed184f45322e..9c5834be743f 100644
> --- a/net/ethtool/loopback.c
> +++ b/net/ethtool/loopback.c
> @@ -86,6 +86,10 @@ static int loopback_get(struct net_device *dev,
>  			struct ethtool_loopback_entry *entry)
>  {
>  	switch (component) {
> +	case ETHTOOL_LOOPBACK_COMPONENT_MAC:
> +		if (!dev->ethtool_ops->get_loopback)
> +			return -EOPNOTSUPP;
> +		return dev->ethtool_ops->get_loopback(dev, name, id, entry);
>  	case ETHTOOL_LOOPBACK_COMPONENT_MODULE:
>  		return ethtool_cmis_get_loopback(dev, name, entry);
>  	default:
> @@ -93,10 +97,22 @@ static int loopback_get(struct net_device *dev,
>  	}
>  }
>  
> -static int loopback_get_by_index(struct net_device *dev, u32 index,
> +static int loopback_get_by_index(struct net_device *dev,
> +				 enum ethtool_loopback_component component,
> +				 u32 index,
>  				 struct ethtool_loopback_entry *entry)
>  {
> -	return ethtool_cmis_get_loopback_by_index(dev, index, entry);
> +	switch (component) {
> +	case ETHTOOL_LOOPBACK_COMPONENT_MAC:
> +		if (!dev->ethtool_ops->get_loopback_by_index)
> +			return -EOPNOTSUPP;
> +		return dev->ethtool_ops->get_loopback_by_index(dev, index,
> +							       entry);
> +	case ETHTOOL_LOOPBACK_COMPONENT_MODULE:
> +		return ethtool_cmis_get_loopback_by_index(dev, index, entry);
> +	default:
> +		return -EOPNOTSUPP;
> +	}
>  }
>  
>  static int loopback_prepare_data(const struct ethnl_req_info *req_base,
> @@ -116,7 +132,8 @@ static int loopback_prepare_data(const struct ethnl_req_info *req_base,
>  		ret = loopback_get(dev, req_info->component, req_info->id,
>  				   req_info->name, &data->entry);
>  	else
> -		ret = loopback_get_by_index(dev, req_info->index, &data->entry);
> +		ret = loopback_get_by_index(dev, req_info->component,
> +					    req_info->index, &data->entry);
>  
>  	ethnl_ops_complete(dev);
>  
> @@ -225,6 +242,10 @@ static int __loopback_set(struct net_device *dev,
>  			  struct netlink_ext_ack *extack)
>  {
>  	switch (entry->component) {
> +	case ETHTOOL_LOOPBACK_COMPONENT_MAC:
> +		if (!dev->ethtool_ops->set_loopback)
> +			return -EOPNOTSUPP;
> +		return dev->ethtool_ops->set_loopback(dev, entry, extack);
>  	case ETHTOOL_LOOPBACK_COMPONENT_MODULE:
>  		return ethtool_cmis_set_loopback(dev, entry, extack);
>  	default:
> @@ -274,20 +295,31 @@ static int loopback_dump_one_dev(struct sk_buff *skb,
>  {
>  	struct loopback_req_info *req_info =
>  		container_of(ctx->req_info, struct loopback_req_info, base);
> +	/* pos_sub encodes: upper 16 bits = component phase, lower 16 = index
> +	 * within that component. dump_one_dev is called repeatedly with
> +	 * increasing pos_sub until all components are exhausted.
> +	 */
> +	enum ethtool_loopback_component phase = *pos_sub >> 16;
> +	u32 idx = *pos_sub & 0xffff;
>  	int ret;
>  
> -	for (;; (*pos_sub)++) {
> -		req_info->index = *pos_sub;
> -		ret = ethnl_default_dump_one(skb, ctx->req_info->dev, ctx,
> -					     info);
> -		if (ret == -EOPNOTSUPP)
> -			break;
> -		if (ret)
> -			return ret;
> +	for (; phase <= ETHTOOL_LOOPBACK_COMPONENT_MODULE; phase++) {
> +		for (;; idx++) {
> +			req_info->component = phase;
> +			req_info->index = idx;
> +			ret = ethnl_default_dump_one(skb, ctx->req_info->dev,
> +						     ctx, info);
> +			if (ret == -EOPNOTSUPP)
> +				break;
> +			if (ret) {
> +				*pos_sub = ((unsigned long)phase << 16) | idx;
> +				return ret;
> +			}
> +		}
> +		idx = 0;
>  	}
>  
>  	*pos_sub = 0;
> -
>  	return 0;
>  }
>  
> 
> -- 
> 2.53.0
> 


Return-Path: <linux-rdma+bounces-16386-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFTrHutygWm2GQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16386-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 05:00:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14971D4436
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 05:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 77651300750D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 04:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7872523D7FC;
	Tue,  3 Feb 2026 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqf2XjGj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9B3EBF23;
	Tue,  3 Feb 2026 04:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770091238; cv=none; b=U6atx3iOIyTM7Rwmg1Z9x8olJSIoV3JaXI+ysv2l2HSNdiL8TAO8Lmu/KRvcuQfadtTZKTrI91KIJoCm3CoDT7V3v6/pVyLnhLbYxYvAuXK9wCORC6e4GsIhwCmtviBsY/DdhKy2YzojeImb62Qp7fjYt4rDJ7J3/w3LUBUVCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770091238; c=relaxed/simple;
	bh=CPatNEKH28qAjt1aPmqRMapU1xqE7AwWGfsJFtIzH68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPqa98+BfBOwrnt9K0fnP1C8uB/zzNMrVj8lIJXg4etLeHSTVh4c+3hRmVFOaOEnMiP+NrW9GLLLIiGjln66vy52QvOcZENd9KA4Xd9S7i0OD9k3VKnmsYQe7gisOxcZfRm/cnPXSC1pD4VA+vpuiKhLo2FmBKP4rgep1JQIT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqf2XjGj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C86C116D0;
	Tue,  3 Feb 2026 04:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770091237;
	bh=CPatNEKH28qAjt1aPmqRMapU1xqE7AwWGfsJFtIzH68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gqf2XjGjttc89JaGuSp4AFNUYoIjK1diBRKecHXKhjlg+2XWXGod8SgMv7nG2ktkk
	 nKkatdcR0N3aXg13LxvHwiDpmXBiCd2Nmr0C1a6lIi4UN/8ycpOL0TdR3PLXVnik8C
	 hUDqbLj8SE7T1jMWqV6EtneU4Cfg//WVzpo0GBRmtb+d9IBFSFsA1UIaLHV/PIfih7
	 DoAhEMYN6KzYWp3iMT4qaVguf+93HDM7BpiztQLLoo620+yYtX1CbO/dBzZRlAs6XU
	 3aytLb+URV1PYI8kG0xpfQEJYNeNx244p0CNvS4liQS5o0gUuJ8pZVGlkgqtvVbGJq
	 qg8crXgj5N07Q==
Date: Mon, 2 Feb 2026 20:00:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
 <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 07/14] devlink: Add parent dev to devlink
 API
Message-ID: <20260202200035.742f9500@kernel.org>
In-Reply-To: <20260128112544.1661250-8-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
	<20260128112544.1661250-8-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16386-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 14971D4436
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 13:25:37 +0200 Tariq Toukan wrote:
>  static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
>  				 u8 flags)
>  {
> +	bool parent_dev = flags & DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV;
>  	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
> +	struct devlink *devlink, *parent_devlink = NULL;
> +	struct net *net = genl_info_net(info);
> +	struct nlattr **attrs = info->attrs;
>  	struct devlink_port *devlink_port;
> -	struct devlink *devlink;
>  	int err;
>  
> -	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs,
> -					      dev_lock);
> -	if (IS_ERR(devlink))
> -		return PTR_ERR(devlink);
> +	if (parent_dev && attrs[DEVLINK_ATTR_PARENT_DEV]) {
> +		parent_devlink = devlink_get_parent_from_attrs_lock(net, attrs);
> +		if (IS_ERR(parent_devlink))
> +			return PTR_ERR(parent_devlink);
> +		info->user_ptr[1] = parent_devlink;

Let's convert devlink to use proper overlay struct over info->cb ?
The user_ptr array only has two entries so devlink stuffs all the
extra pointers into the second slot. But the cb is much larger - 48B
so we can easily give each of these values a dedicated pointer.

> +		/* Drop the parent devlink lock but don't release the reference.
> +		 * This will keep it alive until the end of the request.
> +		 */

To be clear -- devlink instances do not behave like netdev instances.
netdev instances prevent unregistration of the netdev.
devlink refs are normal refs, they just keep the memory around.
If memory serves me..

> +		devl_unlock(parent_devlink);
> +	}
>  
> +	devlink = devlink_get_from_attrs_lock(net, attrs, dev_lock);
> +	if (IS_ERR(devlink)) {
> +		err = PTR_ERR(devlink);
> +		goto parent_put;
> +	}


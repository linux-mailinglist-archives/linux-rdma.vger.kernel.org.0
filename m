Return-Path: <linux-rdma+bounces-14814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2685C90D0E
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 05:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AB124E1338
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Nov 2025 04:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64072E7BBA;
	Fri, 28 Nov 2025 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQZOwmXr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A523D7F7;
	Fri, 28 Nov 2025 04:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764302970; cv=none; b=ZMvT1WfKzIbpGHq/Go8/BuSB4L6VX/pjZS6NM3S+1SP3FFaaz6mjNcdFvDvMvhi13CTsWUqM0zM/vVpNXLZ0/BSBQUO3KY4/McUHKd70j5xO8F6N7bpi0cn+urkr/zX66P2FDswm3Iqfxn5vA++Ka28Zp0VJcI6qBQVIq2d4NcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764302970; c=relaxed/simple;
	bh=xNxrINkGkP6EccME6X4OHvhaFD2e7q5J2n/t/3upzbE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0DKVFZ6GmBpOe4UwHLG0st/uc7eW1MRwRC7LwbVG2JKd7Twb3WNacO+65h7yC81NWDZHrCK8QYzqcMMFjEBJfwbm4t1oNH9HUn0MpGw1KKRJj0F/ro/M3tluCA+cksFE+7AmF5rN2QBURd0Ad//9PpWoNVoF+dRVif51DbenLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQZOwmXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35068C4CEF1;
	Fri, 28 Nov 2025 04:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764302970;
	bh=xNxrINkGkP6EccME6X4OHvhaFD2e7q5J2n/t/3upzbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pQZOwmXrAUI6uy5E6iCb5S0ffXZHIseqNup4U0Kpcx8fOpYL7ol+gfkZ4mGoSG1yy
	 Hqa7+F5WdSEy9YHVsLRsaSFn+stJjLV3lGbiS0kcl+mb+6vpPbNUBUw/VREL3ZuUoB
	 dGLXQoU1FxDAsK/Rv0xbW3vUb95qsVq7AEsdACB89wqjvGpckJnKLhHGrlPJ+aPini
	 +SczW98Kz5PQmHnOtQILNLvAkXNgziRrT6siHBqt/eiXD+Ngk+XOZlZaDNLaQZFIxK
	 mh3pXAYnHVK3jx2D9tnl9Otz1qxEExYTS5ba4l1/4Vt6NEotkjqCeaDGoDlRPhMAqA
	 Crk0jR/bOupnQ==
Date: Thu, 27 Nov 2025 20:09:28 -0800
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
 <rdunlap@infradead.org>
Subject: Re: [PATCH net-next V4 08/14] devlink: Allow rate node parents from
 other devlinks
Message-ID: <20251127200928.65ce7349@kernel.org>
In-Reply-To: <1764101173-1312171-9-git-send-email-tariqt@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
	<1764101173-1312171-9-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 22:06:07 +0200 Tariq Toukan wrote:
> @@ -646,6 +706,13 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
>  		goto unlock;
>  	}
>  
> +	if (info->user_ptr[1] && info->user_ptr[1] != devlink &&
> +	    !ops->supported_cross_device_rate_nodes) {
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Cross-device rate parents aren't supported");
> +		return -EOPNOTSUPP;

err = ...
goto unlock

> +	}
> +
>  	err = devlink_nl_rate_set(devlink_rate, ops, info);
>  
>  	if (!err)
-- 
pw-bot: cr


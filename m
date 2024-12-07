Return-Path: <linux-rdma+bounces-6321-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 526B09E7E04
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Dec 2024 03:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085532884EA
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Dec 2024 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DB217BA5;
	Sat,  7 Dec 2024 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at/xwiQr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA844A24;
	Sat,  7 Dec 2024 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537458; cv=none; b=OlmgkUwT2VDK+vF58O9nIDnav3sX1jnJ31Nye1nJFsh4WeR8ayFkfPo4YDxUSbBTMR/EYTvQKZMFnPXskToj600byKIFc5/Gv9RI3YfKO0ZkTOH+5jpVCXHJxyFMM4L9UqHulpuQ9pGvEA3m/pN158+sKYi0ONOv0phZOUq27Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537458; c=relaxed/simple;
	bh=o3fleLF8rhKZgmsU7Srl8yL4fhQs8ZSINTRoFwzIa7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dF2tUqFSUuF5xz0pHJiWeXfNdljYVnPVmOuHHtnqfTL7XmeJpsJrG66ztDVVIY10meDVvD+wemCujBExgNamCxrl/Q5R3tUxyRYPUDUDfEj57OqCv4he5hQoQvzpBCOLGFvymqeEz+HEaMvZoLAKis/3FmSDq2vfKWMEtppn+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at/xwiQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F146FC4CED1;
	Sat,  7 Dec 2024 02:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733537458;
	bh=o3fleLF8rhKZgmsU7Srl8yL4fhQs8ZSINTRoFwzIa7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=at/xwiQrI9hWDh3hMqYJoy9xKm3TDB+LGtCYGIyE4jf2UV0ZTQvEkxOPNHCFNF0Ke
	 uuAhhoymHgu6FWpMk9tlglWG2h1ObmaB7yKTt2TmG6XeLwsfIaXnknp+qULYMM9eVU
	 o8LY9/tGkUSL7CfV+XDIt/qtMqXlVPJhcGfmpsNih8SOSZjuescDXLB5xfBMxFH7dO
	 ZQh2bBvWogb5pFJAtS7p8v5UtFCou1uqjsNcBSRLoC911AFJqlLeTJa3G6BOpjG4XL
	 lzGVH1qI0+lJHIBtiJSU3XFCt4VgLIPeFLEp+olwdtjf5pkVr8L/QCC2ODcGQ+WEwo
	 15ydsdJ3HPISg==
Date: Fri, 6 Dec 2024 18:10:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
 <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next V5 07/11] devlink: Extend devlink rate API with
 traffic classes bandwidth management
Message-ID: <20241206181056.3d323c0e@kernel.org>
In-Reply-To: <20241204220931.254964-8-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
	<20241204220931.254964-8-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 00:09:27 +0200 Tariq Toukan wrote:
> +          min: 0
> +          max: 100

Are full percentage points sufficient granularity?

> +	if (!tb[DEVLINK_ATTR_RATE_TC_INDEX]) {

NL_SET_ERR_ATTR_MISS()

Please limit the string messages where error can be expressed in
machine readable form.

> +		NL_SET_ERR_MSG(extack, "Traffic class index is expected");
> +		return -EINVAL;
> +	}
> +
> +	tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
> +
> +	if (tc_index >= IEEE_8021QAZ_MAX_TCS) {

This can't be enforced by the policy?

> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "Provided traffic class index (%u) exceeds the maximum allowed value (%u)",
> +				   tc_index, IEEE_8021QAZ_MAX_TCS - 1);
> +		return -EINVAL;
> +	}
> +
> +	if (!tb[DEVLINK_ATTR_RATE_TC_BW]) {
> +		NL_SET_ERR_MSG(extack, "Traffic class bandwidth is expected");
> +		return -EINVAL;
> +	}
> +
> +	if (test_and_set_bit(tc_index, bitmap)) {
> +		NL_SET_ERR_MSG(extack, "Duplicate traffic class index specified");

always try to point to attr that caused the issue

> +		return -EINVAL;
> +	}
-- 
pw-bot: cr


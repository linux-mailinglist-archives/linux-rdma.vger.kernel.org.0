Return-Path: <linux-rdma+bounces-7925-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1278A3E777
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 23:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D22422286
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 22:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52014264FBD;
	Thu, 20 Feb 2025 22:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQFrxb+w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7D81EDA2E;
	Thu, 20 Feb 2025 22:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090159; cv=none; b=G+OITMi8yY70EqdLgsPr9PWtEdiKQwaNdpwZaAzk0hNZDBz/92ArHL0VeoATK7kcvSzieniQ/Du+IAV4uXWjlw9BtGqev7C2OyoE9JDTF6YJ7y0Pyu+u5cgXWo8qyQfs++mu191n9gpfHWnR+STJHZjc95dYaRftDGLtcYj6z8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090159; c=relaxed/simple;
	bh=Qq5fyp1AV+CpdB//yQ1N+e6P4hjmeikr9PqMi6ZYCpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiWv6udXMlQbeQelVjVvq8wknWmyCwBPs4xahyuBNvdkJ+oukVxHXOLYP1YBti92cKfAtreLg3wbojSDUsxEd9v+PvKO+A4GDeaArhpP1i1aaWqmrDASUoc/xVIrUFs9a8uveEfJAfapdJVQq6I/s+3E6/HGYKGhVeo3qr3NiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQFrxb+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F2DC4CEE8;
	Thu, 20 Feb 2025 22:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740090158;
	bh=Qq5fyp1AV+CpdB//yQ1N+e6P4hjmeikr9PqMi6ZYCpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQFrxb+wGVuKFNqe4iYp5s2lNsH/ZO4gxs01a3zC7+df3KPWCygwQEur/ZnnjzCFJ
	 aqTiTg+Uo/cyAfAdT4rZ101Dky4EgOrzAI9TjOD0N5xYUiM/xfPOat/OeoxUfLVESD
	 8DFOBH9v6VoxaRs1dsdMagks3sNAsawAfSZhtMEYaqOp5iLqT4cWaSAQMDEbVo/fHB
	 2MY+tbZhLV+QMlNpPCFF+4dXuNEs+s02V93b9uWiFOJoopr11v6jsJ7aKV/fSLBejq
	 OaDAGvcjZL0dC2MBPzAoK0sE7cLm88n+fA1ZeLT//FXh1HPOP36dDfC05JaYpLeJcx
	 Ox/wiLE5ujXrg==
Date: Thu, 20 Feb 2025 14:22:37 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <ttoukan.linux@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 4/4] net/mlx5: Add sensor name to temperature
 event message
Message-ID: <Z7erLQwDBHYoCV7X@x130>
References: <20250213094641.226501-1-tariqt@nvidia.com>
 <20250213094641.226501-5-tariqt@nvidia.com>
 <20250215192935.GU1615191@kernel.org>
 <20250217162719.1e20afac@kernel.org>
 <8369b884-71c9-495a-8a1f-ab8ca4ee5f59@gmail.com>
 <20250219072829.21ee1cfc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250219072829.21ee1cfc@kernel.org>

On 19 Feb 07:28, Jakub Kicinski wrote:
>On Wed, 19 Feb 2025 15:00:57 +0200 Tariq Toukan wrote:
>> >> If you have to respin for some other reason, please consider limiting lines
>> >> to 80 columns wide or less here and elsewhere in this patch where it
>> >> doesn't reduce readability (subjective I know).
>> >
>> > +1, please try to catch such situations going forward
>>
>> This was not missed.
>> This is not a new thing...
>> We've been enforcing a max line length of 100 chars in mlx5 driver for
>> the past few years.
>> I don't have the full image now, but I'm convinced that this dates back
>> to an agreement between the mlx5 and netdev maintainers at that time.
>>
>> 80 chars could be too restrictive, especially with today's large
>> monitors, while 100-chars is still highly readable.
>> This is subjective of course...
>>
>> If you don't have a strong preference, we'll keep the current 100 chars
>> limit. Otherwise, just let me know and we'll start enforcing the
>> 80-chars limit for future patches.
>
>Right, I think mlx5 is the only exception to the 80 column guidance.
>I don't think it's resulting in more readable code, so yes, my
>preference is to end this experiment.
>

The reason in mlx5 was that we wanted to preserve the official HW spec
auto-generated fields names and they are really long.
100 chars worked very well with us for example the following sequence of
code setting up a FW command buffer would have to be broken in every line
if we were to restrict 80 chars per line.

  MLX5_SET(modify_vhca_state_in, in, opcode, MLX5_CMD_OP_MODIFY_VHCA_STATE);
  MLX5_SET(modify_vhca_state_in, in, vhca_state_field_select.sw_function_id, 1);
  MLX5_SET(modify_vhca_state_in, in, vhca_state_context.sw_function_id, sw_fn_id);
  MLX5_SET(modify_vhca_state_in, in, vhca_state_context.arm_change_event, 1);
  MLX5_SET(modify_vhca_state_in, in, vhca_state_field_select.arm_change_event, 1);

But I believe the driver grow larger than caring about those lines too
much, I just did a quick check and it seems less than 2% of the lines are
actually > 80, not sure this is due to being more strict in the past few
years or that we don't really need more than 80 lines.

I also check the interesting cases with macros such
MLX5_SET/MLX5_GET/MLX5_CAP and also the percentile of long lines was very
minor just about 5% in all cases.. 

So I kinda agree mlx5 doesn't need be so special anymore. 
Tariq up to you, you are the main  reviewer now.

Thanks
Saeed.






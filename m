Return-Path: <linux-rdma+bounces-13206-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66FB4FCC0
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 15:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC873ABE68
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4781C340D8F;
	Tue,  9 Sep 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+yZ20h0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9902236435;
	Tue,  9 Sep 2025 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424492; cv=none; b=KA5RCmEg/JuT5p7SbyHGsRMy9oTVJihrM6ieuI+fISnCSDhna4VtJqW5/IUZq4Wm0VtpUYRPhWXvDk2iG3qsgr+F9CzmsJYUDHiARcHQ4r7/lDR7qPnU0YcW5HzUhvNnTPFLM63hkr9dfTIn0NCCxBx9lpjuDHt/Hj93/eI9nf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424492; c=relaxed/simple;
	bh=VMUJFmLcsKGBDDr5v9bXqubrob3qdBOhonNwTJDZQaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpHMoocKTXsO8qx7QLozgRhBI6WIMLttL86gU1uuvbJ30iYRENQIUJ0wXAsyqFqfyKAhwGu6xlFdb8uBYRk4+YLNiEJwiBjK2Tv32t1Qv3pvh7xtDquWYQKWBHDSRJYsxepA0aiikY+s+Vg0ZBSL7FmbZcMB4+wnzqAWHY26xwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+yZ20h0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0751AC4CEF4;
	Tue,  9 Sep 2025 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757424491;
	bh=VMUJFmLcsKGBDDr5v9bXqubrob3qdBOhonNwTJDZQaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+yZ20h0+Dby0VNZESEZBL1k7vPh7lZAT5v4K0c7BYWTYEGfVNgf/a0zNMA6fDYlQ
	 +zZ615z4LihhDOJuqLi1RmI4Exu0DZwTcYrIzjOwNjkRxJP166fiFYjsOj/hvkZUY2
	 Batn+CgQKCn1AOsrK/I+qFkx8HvulAqoi5DYjTnWrIRKxMgyu83yQa6drOdCHLMtyb
	 k5HZPEnsBVqhixIqIPzP5DrZgyfJbIzCi1UX28MjOyeHr67pOwrC83QV11iSMiBAgw
	 c/0Fnqo1X1teBFuFGJPXN19nFNh8koJxx134game4/7YsbmO16fcp62PFVwYlbMXIl
	 HdbUsYstHAdSg==
Date: Tue, 9 Sep 2025 15:20:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>, jiri@resnulli.us
Cc: intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com
Subject: Re: [iwl-next] ice, irdma: Add rdma_qp_limits_sel devlink parameter
 for irdma
Message-ID: <20250909122051.GF341237@unreal>
References: <20250904195719.371-1-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904195719.371-1-tatyana.e.nikolova@intel.com>

On Thu, Sep 04, 2025 at 02:57:19PM -0500, Tatyana Nikolova wrote:
> Add a devlink parameter to switch between different QP resource profiles
> (max number of QPs) supported by irdma for Intel Ethernet 800 devices. The
> rdma_qp_limits_sel is translated into an index in the rsrc_limits_table to
> select a power of two number between 1 and 256 for max supported QPs (1K-256K).
> To reduce the irdma memory footprint, set the rdma_qp_limits_sel default value
> to 1 (max 1K QPs).
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> ---
> Since the changes to irdma are minor, this is targeted to iwl-next/net-next.

<...>

>  #define DEVLINK_LOCAL_FWD_DISABLED_STR "disabled"
>  #define DEVLINK_LOCAL_FWD_ENABLED_STR "enabled"
>  #define DEVLINK_LOCAL_FWD_PRIORITIZED_STR "prioritized"
> @@ -1621,6 +1723,7 @@ enum ice_param_id {
>  	ICE_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>  	ICE_DEVLINK_PARAM_ID_TX_SCHED_LAYERS,
>  	ICE_DEVLINK_PARAM_ID_LOCAL_FWD,
> +	ICE_DEVLINK_PARAM_ID_RDMA_QP_LIMITS_SEL,
>  };

I was under impression that driver-specific devlink knobs are not
allowed. Was this limitation changed for Intel?

Thanks


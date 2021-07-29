Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEEA3DA9FE
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 19:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhG2RVp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 13:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhG2RVp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 13:21:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FD5060EE6;
        Thu, 29 Jul 2021 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627579302;
        bh=h3g/FEBYe0ZYItpN5I4X+aJhmexh9d3Bep3bO86C6Sg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXud0NnXbV0MC1O0ee4Z6S/SPNkF6rQZGsnOw+Qsk6Zhxrt+dRIO8VUW9ohUy8oC0
         sGuoReiWV6XLWc9nfA4xnPdHe49IFtfll4A3y4RexJ2s+HhLQOgPi7939uK6HG4BVC
         G+8ZAWotC2CLuKnjsBDNREoK7GFXh2wAXrnach4M0f5Ag2uLopnnd2cC9Z5NL9SdmU
         WrALmzFdrjWTxi1PyNzQNGgWjt8zsXkvsKWc8rRr1qgX2WTHkUVaNKUsi7XcK6/dCg
         J5JLY9zdf8qlyF3pCWngCa/fU7xLwQwT5YZPR8GoSpSjx0w+4qK67Rt1hWkYMCm7WM
         KJ38FmwZw9rSQ==
Date:   Thu, 29 Jul 2021 20:21:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Shai Malin <smalin@marvell.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@nvidia.com,
        mkalderon@marvell.com, davem@davemloft.net, kuba@kernel.org,
        aelior@marvell.com, pkushwaha@marvell.com,
        prabhakar.pkin@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH for-next 1/3] qed: add get and set support for dscp
 priority
Message-ID: <YQLjosQBfa9JDPf6@unreal>
References: <20210729133032.26278-1-smalin@marvell.com>
 <20210729133032.26278-2-smalin@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729133032.26278-2-smalin@marvell.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 29, 2021 at 04:30:30PM +0300, Shai Malin wrote:
> From: Prabhakar Kushwaha <pkushwaha@marvell.com>
> 
> This patch add support of get or set priority value for a given
> dscp index.
> 
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_dcbx.c | 65 ++++++++++++++++++++++
>  drivers/net/ethernet/qlogic/qed/qed_dcbx.h |  9 +++
>  include/linux/qed/qed_if.h                 |  6 ++
>  3 files changed, 80 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
> index e81dd34a3cac..ba9276599e72 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
> @@ -1280,6 +1280,71 @@ int qed_dcbx_get_config_params(struct qed_hwfn *p_hwfn,
>  	return 0;
>  }

<...>

> +	p_dcbx_info = kmalloc(sizeof(*p_dcbx_info), GFP_KERNEL);
> +	if (!p_dcbx_info)
> +		return -ENOMEM;
> +
> +	memset(p_dcbx_info, 0, sizeof(*p_dcbx_info));

This is open-coded kzalloc().

Thanks

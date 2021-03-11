Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928A8336EB5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Mar 2021 10:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhCKJWV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Mar 2021 04:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231965AbhCKJWH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Mar 2021 04:22:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 610A264E5F;
        Thu, 11 Mar 2021 09:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615454527;
        bh=QRVck+IIsi24TGqXEvxqoBtyhlaKGyxDG/OywFja2Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdq0+S96sulLfadpU8BIgL3NRrGUddU63uusQBKkKf2lVLjDfRuRhb6Ncf1dvrwH2
         VPPYzO8pW6lzbR0DHD3fMZJweKB5529IOqtEDNAZTTe3AnPWoARCHOdA8eEdRYzQOx
         xW74JlEURfReF5oKjznIF8hJ7QPQqb80kOE39U/5+qjRPicPtE6moM68/p0I910EGi
         2TQIWmzY/PZ64ta/JZOuXdUU0ObdgDuwxlSTZrUouXOiSq7bNqSvqFqVjTw59l5Ixx
         UKEWd9qMyrlaumQ/V95hk/xq1t5mjPNkqWu0glEFedfK3tcqC8LM4F89rRfAMTI3vX
         Lu6xfOiIHcqlA==
Date:   Thu, 11 Mar 2021 11:22:03 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband/core: Fix a use after free in cm_work_handler
Message-ID: <YEnhO9EXgI8pwVD2@unreal>
References: <20210311022153.3757-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311022153.3757-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 10, 2021 at 06:21:53PM -0800, Lv Yunlong wrote:
> In cm_work_handler, it calls destory_cm_id() to release
> the initial reference of cm_id_priv taken by iw_create_cm_id()
> and free the cm_id_priv. After destory_cm_id(), iwcm_deref_id
> (cm_id_priv) will be called and cause a use after free.
>
> Fixes: 59c68ac31e15a ("iw_cm: free cm_id resources on the last deref")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/infiniband/core/iwcm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
> index da8adadf4755..cb6b4ac45e21 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -1035,8 +1035,10 @@ static void cm_work_handler(struct work_struct *_work)
>
>  		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
>  			ret = process_event(cm_id_priv, &levent);
> -			if (ret)
> +			if (ret) {
>  				destroy_cm_id(&cm_id_priv->id);
> +				return;

The destroy_cm_id() is called to free ->id and not cm_id_priv. This "return"
leaks cm_id_priv now and what "a use after free" do you see?

> +			}
>  		} else
>  			pr_debug("dropping event %d\n", levent.event);
>  		if (iwcm_deref_id(cm_id_priv))
> --
> 2.25.1
>
>

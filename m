Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21344D77DE
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Mar 2022 20:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbiCMTIa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Mar 2022 15:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiCMTI3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Mar 2022 15:08:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABC865D1B;
        Sun, 13 Mar 2022 12:07:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3BBF6125C;
        Sun, 13 Mar 2022 19:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E59C340E8;
        Sun, 13 Mar 2022 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647198420;
        bh=sdT+tHxbpYLBX3wIqLLmHW1cCkkTCSKzp6egI0tq5QM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dddfGeyKDX4YZCkNYRtOsdXo//j74r/YpjNSJGuciz2bb19+4Wniy7YCjDE6ApY7n
         s7lYbyem8qKoRgxfEHjI9pdevgTzSHPArrnuSbrzVbLSiVt6Nd5bPUVYl2Fo4+zmDc
         OLySDj90EPsuKqcvSEJ+9ZgPI9SmJUGrI0Wvh+DqgP6grWZ0ILkLO8EvyryCF/s15U
         CFTcMWDHbrNpSo71I3T8JUlyzwAjN464MfcoYXewQWsbF91WGQ66JXCrrhtCYBMK8d
         ObmjjaRw+TjUEthmDAfPqAKsRZosSo9WvEhvFqlaCsEjPhOGBs4mPiQRKVDbv2d/CQ
         A3fEcpCBD4/4Q==
Date:   Sun, 13 Mar 2022 21:06:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>
Cc:     jgg@ziepe.ca, yishaih@mellanox.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, fuyq@stu.pku.edu.cn
Subject: Re: [PATCH] RDMA/mlx5: Fix memory leak
Message-ID: <Yi5A0AkiVTLfkYFM@unreal>
References: <1647018361-18266-1-git-send-email-lyz_cs@pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1647018361-18266-1-git-send-email-lyz_cs@pku.edu.cn>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 11, 2022 at 09:06:01AM -0800, Yongzhi Liu wrote:
> [why]
> xa_insert is failed, so caller of subscribe_event_xa_alloc
> cannot call other function to free obj_event. Therefore,
> Resource release is needed on the error handling path to
> prevent memory leak.
> 
> [how]
> Fix this by adding kfree on the error handling path.
> 
> Fixes: 7597385 ("IB/mlx5: Enable subscription for device events over DEVX")
> 
> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

The change itself is correct one, but commit message needs to be improved.
Something like that:

------------------------------------------------------------------
[PATCH] RDMA/mlx5: Fix memory leak in error subscribe event routine

In case second xa_insert() fails, the obj_event is not released.
Fix the error unwind flow to free that memory to avoid memory leak.

Fixes: 7597385 ("IB/mlx5: Enable subscription for device events over DEVX")
Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
-------------------------------------------------------------------

> 
> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
> index 08b7f6b..15c0884 100644
> --- a/drivers/infiniband/hw/mlx5/devx.c
> +++ b/drivers/infiniband/hw/mlx5/devx.c
> @@ -1886,8 +1886,10 @@ subscribe_event_xa_alloc(struct mlx5_devx_event_table *devx_event_table,
>  				key_level2,
>  				obj_event,
>  				GFP_KERNEL);
> -		if (err)
> +		if (err) {
> +			kfree(obj_event);
>  			return err;
> +		}
>  		INIT_LIST_HEAD(&obj_event->obj_sub_list);
>  	}
>  
> -- 
> 2.7.4
> 

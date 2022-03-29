Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5E74EA879
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Mar 2022 09:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiC2H05 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Mar 2022 03:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiC2H05 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Mar 2022 03:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BFF243717
        for <linux-rdma@vger.kernel.org>; Tue, 29 Mar 2022 00:25:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A09DE61521
        for <linux-rdma@vger.kernel.org>; Tue, 29 Mar 2022 07:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88741C340ED;
        Tue, 29 Mar 2022 07:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648538713;
        bh=KuYg/IMDxlGMSF3CjlztUUUMsI3pXRApfWdByMxxecc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aixDxlOa0DwpXDkQhX/0XgR1DcDpPBzkwXk9jymViowDlt9StSFnE2cGc7Ub44rL3
         Nfujl5G66aj3i9wf6baKxsSeasy2pTPEGifQ/zTKOmwwuTb8mYvn4OCADS1muneS5q
         X15o7eDyy/0UceoL4yDEmlqwivMbycTqZKMethd70u/x1H0W67NVEyLvGAGfVovzjB
         Nqs0IwDrdjAxpPthj9J1e0wEVKP+NPpaPTXEZ6bXzUTd3flBdkZ4RzW/NfSfywU2Q5
         lW1MQj09lzNFVIy3IxuSqbZgRfPM3U9d4AYLCGSPprhJGSjuOcADmNg9wUGCrwWsgo
         Ol+Svx/3jOKEg==
Date:   Tue, 29 Mar 2022 10:25:08 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH rdma-rc 1/3] RDMA/mlx5: Don't remove cache MRs when a
 delay is needed
Message-ID: <YkK0VE2fe0HcVCpg@unreal>
References: <cover.1648366974.git.leonro@nvidia.com>
 <73c3fef51ee2bb50ae240306472d9562ba05916f.1648366974.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73c3fef51ee2bb50ae240306472d9562ba05916f.1648366974.git.leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 27, 2022 at 10:55:46AM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> Don't remove MRs from the cache if need to delay the removal.
> 
> Fixes: b9358bdbc713 ("RDMA/mlx5: Fix locking in MR cache work queue")
> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> Reviewed-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 8a87a2f074e4..4a01a0ad7c90 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -562,9 +562,10 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
>  		spin_lock_irq(&ent->lock);
>  		if (ent->disabled)
>  			goto out;
> -		if (need_delay)
> +		if (need_delay) {
>  			queue_delayed_work(cache->wq, &ent->dwork, 300 * HZ);
> -		remove_cache_mr_locked(ent);

This is rebase error and remove_cache_mr_locked() shouldn't be removed.

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 8a87a2f074e4..fc5bc8ff1c57 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -562,8 +562,10 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
                spin_lock_irq(&ent->lock);
                if (ent->disabled)
                        goto out;
-               if (need_delay)
+               if (need_delay) {
                        queue_delayed_work(cache->wq, &ent->dwork, 300 * HZ);
+                       goto out;
+               }
                remove_cache_mr_locked(ent);
                queue_adjust_cache_locked(ent);
        }


> +			goto out;
> +		}
>  		queue_adjust_cache_locked(ent);
>  	}
>  out:
> -- 
> 2.35.1
> 

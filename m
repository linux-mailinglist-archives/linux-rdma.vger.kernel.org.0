Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1565ECAA
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jan 2023 14:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjAENQn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Jan 2023 08:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjAENQ1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 5 Jan 2023 08:16:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52295551CE;
        Thu,  5 Jan 2023 05:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07271B81A3E;
        Thu,  5 Jan 2023 13:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3989EC433F0;
        Thu,  5 Jan 2023 13:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672924582;
        bh=TWkizyzMxIBO+7zu4Vof9qLzprUaIH9Rq37qiXToijs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8Ev1hJrutf8kTctwKrkLTn/z9RW3wUTEhaVrET5DbqKqVKs6e7faFUs07nkeYMsL
         WVOV3p85tlqd/2jS3Z07o6IowutO1MT5i8Uk8bPTpezeFSEBDWZnPwcXg8A/6/sES7
         Fu8/OoA2lYH8xHWenYbxWcvNIFSNqxtpt4jL/MKeX3CKdQC6eM6Fmb7DF3Bj1e573z
         PSlt13p5QY+9y5D9bAfsWLbPgS9b6y/I2itaIdoqbsP/tJDHb4EMaAyBg28/XQkp8b
         2WVMWvwp2Mfv4pa/BOJcuGL1KfPCk7UEq2N92klMNoLtRkWpFQNPv3d9SBAQLwFUl9
         oqycautXt2VHQ==
Date:   Thu, 5 Jan 2023 15:16:18 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        saeedm@nvidia.com, moshe@nvidia.com, shayd@nvidia.com
Subject: Re: [PATCH -next] net/mlx5: fix missing mutex_unlock in
 mlx5_fw_fatal_reporter_err_work()
Message-ID: <Y7bNot3o3nH/Gxrj@unreal>
References: <20230105114220.466631-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105114220.466631-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 05, 2023 at 07:42:20PM +0800, Yang Yingliang wrote:
> Add missing mutex_unlock() before returning from
> mlx5_fw_fatal_reporter_err_work().
> 
> Fixes: 9078e843efec ("net/mlx5: Avoid recovery in probe flows")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/health.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
> index 96417c5feed7..879555ba847d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
> @@ -677,6 +677,7 @@ static void mlx5_fw_fatal_reporter_err_work(struct work_struct *work)
>  	mutex_lock(&dev->intf_state_mutex);
>  	if (test_bit(MLX5_DROP_NEW_HEALTH_WORK, &health->flags)) {
>  		mlx5_core_err(dev, "health works are not permitted at this stage\n");
> +		mutex_unlock(&dev->intf_state_mutex);
>  		return;
>  	}
>  	mutex_unlock(&dev->intf_state_mutex);

Shay is working to rewrite 9078e843efec ("net/mlx5: Avoid recovery in probe flows") completely.

Thanks

> -- 
> 2.25.1
> 

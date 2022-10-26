Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB360DABD
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Oct 2022 07:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiJZFsW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Oct 2022 01:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJZFsU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Oct 2022 01:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC74AA4BB7;
        Tue, 25 Oct 2022 22:48:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5243C61CE4;
        Wed, 26 Oct 2022 05:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E2FC433D7;
        Wed, 26 Oct 2022 05:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666763297;
        bh=j2InCfRFFBpZ19h8sCA3W8+JbJCPhCkk0PmkSABFwqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDhgXyps+lZI1ouAF1nHsRPfldljZ12jEq3k32wDcksyaCpXc1h5gPwl8GFUJWM/k
         rvnBqZigkJW+C+3FzS5utSrfKcVrfjP9wW0dcIDHpuO9hZqT+KajRsSJ6FBThx/KRK
         MNAc5pG/NQsFhAivZ8Wr5yKoH8tLKV5iES4jBVXpL5uHecRxf0/Y8ob5m7qGh5i/96
         ZCr50ugpLsVwBT6sPJ6F0ngcNi2MvdpvJ5RJm/93jMuv2TijnuI4y9fITaDYXQv8xe
         BOk3gYraPCHHE+GcWCX2f2j2bN+GGiKcu5FR6BB9lq2DV9O+tuti+GxLOBRFAZQHlA
         KJpe5yHixQMsQ==
Date:   Wed, 26 Oct 2022 08:48:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Arumugam Kolappan <aru.kolappan@oracle.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, manjunath.b.patil@oracle.com,
        rama.nichanamatlu@oracle.com
Subject: Re: [PATCH  1/1] net/mlx5: update debug log level for remote access
 error syndromes
Message-ID: <Y1jKHcBdcUnluIdU@unreal>
References: <1666689721-30424-1-git-send-email-aru.kolappan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666689721-30424-1-git-send-email-aru.kolappan@oracle.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 25, 2022 at 02:22:01AM -0700, Arumugam Kolappan wrote:
> The mlx5 driver dumps the entire CQE buffer by default for few syndromes.
> Some syndromes are expected due to the application behavior [ex:
> MLX5_CQE_SYNDROME_REMOTE_ACCESS_ERR, MLX5_CQE_SYNDROME_REMOTE_OP_ERR and
> MLX5_CQE_SYNDROME_LOCAL_PROT_ERR]. Hence, for these syndromes, the patch
> converts the log level from KERN_WARNING to KERN_DEBUG. This enables the
> application to get the CQE buffer dump by changing to KERN_DEBUG level
> as and when needed.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Arumugam Kolappan <aru.kolappan@oracle.com>
> ---
>  drivers/infiniband/hw/mlx5/cq.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
> index be189e0..d665129 100644
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@ -267,10 +267,25 @@ static void handle_responder(struct ib_wc *wc, struct mlx5_cqe64 *cqe,
>  	wc->wc_flags |= IB_WC_WITH_NETWORK_HDR_TYPE;
>  }
>  
> -static void dump_cqe(struct mlx5_ib_dev *dev, struct mlx5_err_cqe *cqe)
> +static void dump_cqe(struct mlx5_ib_dev *dev, struct mlx5_err_cqe *cqe,
> +		     struct ib_wc *wc, int dump)
>  {
> -	mlx5_ib_warn(dev, "dump error cqe\n");
> -	mlx5_dump_err_cqe(dev->mdev, cqe);
> +	const char *level;
> +
> +	if (!dump)
> +		return;
> +
> +	mlx5_ib_warn(dev, "WC error: %d, Message: %s\n", wc->status,
> +		     ib_wc_status_msg(wc->status));

Aren't you interested "to hide" this print too? Right now, it will
be printed without relation to your "dump" variable value.

> +
> +	if (dump == 1)
> +		level = KERN_WARNING;
> +
> +	if (dump == 2)
> +		level = KERN_DEBUG;

Please change dump_cqe() arguments to receive level directly, so you
will set "dump = KERN_DEBUG" and not not "dump = 2" in
mlx5_handle_error_cqe().

Thanks

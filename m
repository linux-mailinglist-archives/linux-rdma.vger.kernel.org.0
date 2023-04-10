Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399326DC6C3
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 14:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDJM2W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 08:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDJM2V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 08:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17426423B
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 05:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A612261448
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 12:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCCEC433EF;
        Mon, 10 Apr 2023 12:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681129700;
        bh=QNWeYdCQFLzP0/BlKYGjDo9nFAUQyss8tcJ0yg3Gw70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qcKlPHIT9TrDPyVUOJIMcfU6bCbhfIm0oSey4glpJ1tNmhA5fSlqyjMaQJyGojrSk
         2Mya3/vUnZj0B0539HbMQkujb/VBDKeJppqY9FtdwaCvK1lVSPWdAA9R0XYzHLS7Pq
         r809t+D24/RMxxvEBFj0ck73cuQI0FzpmgR1Os28+8PZkZmWOK3o02rtXWsyKIsAM6
         TiBSPuStAjX3UkeZySuCUV5/OxYKE8BmyZ7IrZ6V23mCS0WQwIwztpopodXZ6IYd7q
         JO0bAyo8kISIo9g4qnhBVD8Fe/oTS3ljScBx4fnxqUW8IlSHZ5DuHiK51Etv5OgYhu
         bXgz7hCnVwpcQ==
Date:   Mon, 10 Apr 2023 15:28:15 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 3/6] RDMA/bnxt_re: Query function capabilities
 from firmware
Message-ID: <20230410122815.GR182481@unreal>
References: <1681125115-7127-1-git-send-email-selvin.xavier@broadcom.com>
 <1681125115-7127-4-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681125115-7127-4-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 04:11:52AM -0700, Selvin Xavier wrote:
> Query Function capabilities to enable advanced features.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index a866951..1b69198 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -83,6 +83,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
>  				unsigned long event, void *ptr);
>  static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev);
>  static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev);
> +static int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev);
>  
>  static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
>  {
> @@ -91,6 +92,9 @@ static void bnxt_re_set_drv_mode(struct bnxt_re_dev *rdev, u8 mode)
>  	cctx = rdev->chip_ctx;
>  	cctx->modes.wqe_mode = bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx) ?
>  			       mode : BNXT_QPLIB_WQE_MODE_STATIC;
> +	if (bnxt_re_hwrm_qcaps(rdev))
> +		dev_err(rdev_to_dev(rdev),
> +			"Failed to query hwrm qcaps\n");

You already print error in bnxt_re_hwrm_qcaps()

>  }

<...>

> +/* Query function capabilities using common hwrm */
> +int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)

<...>

> +	if (rc) {
> +		dev_err(rdev_to_dev(rdev),
> +			"Failed to query capabilities, rc = %#x", rc);
> +		return rc;
> +	}
> +	return 0;
> +}
> +
>  static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
>  				 u16 fw_ring_id, int type)
>  {
> -- 
> 2.5.5
> 



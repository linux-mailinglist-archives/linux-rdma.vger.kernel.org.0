Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC1772B1F1
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFKNE1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFKNE0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 09:04:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0039BB
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 06:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B0326108B
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 13:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CAF8C433EF;
        Sun, 11 Jun 2023 13:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686488664;
        bh=qnNMfyBspyW1zE9ZE9IRtyG908OJWAzzujDJ3yjSmhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wq7UD4iiH8uCoF8BJCjFSE8ZUfse5cMxhELQhfDgHwtYPE+JbZdyjM1iR6mv/ltqb
         rvg45wR4ZD3xnQ68f6MGWnOObbTIXuX60FcH86Nfrx5kmxLpH4pBAEhIvRar0mn3Ua
         SZOa5DjZL0YHnLOZNxqNMKqX4EPoMhnsh8iRPwDz0VgpcMVcMGGDwIAPgxDqAsJWeh
         nx5W4W6+4ypjRe+p66nRi0PvCKAZ3w6on3YfScCwvCvIAIlNLYpZ6YpncW/lxkyfhs
         0dslZPe4iLfr9oqRZ8eE6Ve90GeAaOArsb8b7We5bqVxx/wdsOw0gY8iRf1HXHsjzN
         Cg+MrIuHENsyg==
Date:   Sun, 11 Jun 2023 16:04:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH v4 for-next 3/6] RDMA/bnxt_re: Query function
 capabilities from firmware
Message-ID: <20230611130420.GD12152@unreal>
References: <1685617837-15725-1-git-send-email-selvin.xavier@broadcom.com>
 <1685617837-15725-4-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1685617837-15725-4-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 01, 2023 at 04:10:34AM -0700, Selvin Xavier wrote:
> Query Function capabilities to enable advanced features.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 9cc652e..da99f69 100644
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
>  }
>  
>  static void bnxt_re_destroy_chip_ctx(struct bnxt_re_dev *rdev)
> @@ -340,6 +344,25 @@ static void bnxt_re_fill_fw_msg(struct bnxt_fw_msg *fw_msg, void *msg,
>  	fw_msg->timeout = timeout;
>  }
>  
> +/* Query function capabilities using common hwrm */
> +int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
> +{
> +	struct bnxt_en_dev *en_dev = rdev->en_dev;
> +	struct hwrm_func_qcaps_output resp = {0};
> +	struct hwrm_func_qcaps_input req = {0};

There is no need in 0 here, just use {}

> +	struct bnxt_qplib_chip_ctx *cctx;
> +	struct bnxt_fw_msg fw_msg;

Initialize it to zero from the beginning and remove memset()

> +
> +	cctx = rdev->chip_ctx;
> +	memset(&fw_msg, 0, sizeof(fw_msg));
> +	bnxt_re_init_hwrm_hdr(rdev, (void *)&req,
> +			      HWRM_FUNC_QCAPS, -1, -1);

All callers to bnxt_re_init_hwrm_hdr() provide "-1, -1" and rdev is not
used at all.

> +	req.fid = cpu_to_le16(0xffff);
> +	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
> +			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
> +	return bnxt_send_msg(en_dev, &fw_msg);
> +}
> +
>  static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
>  				 u16 fw_ring_id, int type)
>  {
> -- 
> 2.5.5
> 



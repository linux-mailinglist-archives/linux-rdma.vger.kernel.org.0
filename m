Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801686DC6C0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDJM1H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 08:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDJM1H (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 08:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68218527E
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 05:27:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F33DA60FB1
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 12:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20A3C433D2;
        Mon, 10 Apr 2023 12:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681129625;
        bh=coDRRLfRGQx/5enK8ripK/oDheckhDbh+hn8yPJYGEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z85RYEdVlserQAoCXjLpvZNh2eB1h3NqKnfHPHHgwHHTZvrxPFDAB4/1rbPMLvx4i
         7wZdq4dSJszZ4nXJTpuaqto3p99vA1NynBRKX58au/mt8knHXfv5SpgwiSChG8z48e
         9F2PXgNOhgtO9EHdqzNZ/o04awFHqygEnvOHU2JfaekEMuY+fe4P8hJWpeCz7mZI5o
         WSJLKHGiu7//smrpzluRvdt75UWlKAGqXYFRqI3GPQ886bIRohaSEC5te1e0HPenRk
         FldEeVSO1sKqdj/Ow0iERXcOyEMC7sJ4OgCkvddqdu1iic5lGK5x31tNlTKbNK+l8k
         XlKDXZAVqCjOA==
Date:   Mon, 10 Apr 2023 15:27:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 2/6] RDMA/bnxt_re: Add disassociate ucontext
 support
Message-ID: <20230410122701.GQ182481@unreal>
References: <1681125115-7127-1-git-send-email-selvin.xavier@broadcom.com>
 <1681125115-7127-3-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681125115-7127-3-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 04:11:51AM -0700, Selvin Xavier wrote:
> Add empty stub for disassociate ucontext as done in other vendor
> drivers.

It will be great to mention in commit message that the reason to this
stub is because you use rdma_user_mmap_io().

Thanks

> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index 1d361eb..a866951 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -466,6 +466,10 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
>  	return rc;
>  }
>  
> +static void bnxt_re_disassociate_ucontext(struct ib_ucontext *ibcontext)
> +{
> +}
> +
>  /* Device */
>  
>  static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev)
> @@ -532,6 +536,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
>  	.destroy_qp = bnxt_re_destroy_qp,
>  	.destroy_srq = bnxt_re_destroy_srq,
>  	.device_group = &bnxt_re_dev_attr_group,
> +	.disassociate_ucontext = bnxt_re_disassociate_ucontext,
>  	.get_dev_fw_str = bnxt_re_query_fw_str,
>  	.get_dma_mr = bnxt_re_get_dma_mr,
>  	.get_hw_stats = bnxt_re_ib_get_hw_stats,
> -- 
> 2.5.5
> 



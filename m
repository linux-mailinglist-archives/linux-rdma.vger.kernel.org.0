Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC046CD27E
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjC2HF7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 03:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjC2HFy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 03:05:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586A62D5E
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 00:05:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96B2161A85
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 07:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F225C433D2;
        Wed, 29 Mar 2023 07:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680073549;
        bh=AlNUybu8jWKB08tqTrkfTA1+4Iu8pzaTYmUK5B8UVlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VnTyR63kekqigrKLxhH6LBJNlwFdHLa7EIPoJoStIn/lnfTV9reY5Kmae5/dkxoft
         yjURO+8F26cVK4p+giL83r32QGfwHUJYcsDf5cCbDbccCSkaVc6FkkxSR5uFrQg8Tw
         /3saDzRd0qBsTtpuzRMD0teFcp/M/fWery1zAtEiTPLQV9704bBC6OAuuqJrkYmbqd
         HdAKZlFTdCfw/IL7dcth1lGl9nph7sU1kjMU4TI0fowt3soRzIfBo0noIPPpVDrHiD
         RpmQnhIkv4qARYoZhlkTgVK3H3OevtsOmaUJtIq+NYnb9jKyew5Yv344ZlDooPkU/v
         ohskoNe1e65+w==
Date:   Wed, 29 Mar 2023 10:05:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Add resize_cq support
Message-ID: <20230329070544.GC831478@unreal>
References: <1678868215-23626-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678868215-23626-1-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 15, 2023 at 01:16:55AM -0700, Selvin Xavier wrote:
> Add resize_cq verb support for user space CQs. Resize operation for
> kernel CQs are not supported now.
> 
> Driver should free the current CQ only after user library polls
> for all the completions and switch to new CQ. So after the resize_cq
> is returned from the driver, user libray polls for existing completions
> and store it as temporary data. Once library reaps all completions in the
> current CQ, it invokes the ibv_cmd_poll_cq to inform the driver about
> the resize_cq completion. Adding a check for user CQs in driver's
> poll_cq and complete the resize operation for user CQs.
> Updating uverbs_cmd_mask with poll_cq to support this.
> 
> User library changes are available in this pull request.
> https://github.com/linux-rdma/rdma-core/pull/1315
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 109 +++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   3 +
>  drivers/infiniband/hw/bnxt_re/main.c     |   2 +
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c |  44 +++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h |   5 ++
>  include/uapi/rdma/bnxt_re-abi.h          |   4 ++
>  6 files changed, 167 insertions(+)

<...>

> +struct bnxt_re_resize_cq_req {
> +	__u64 cq_va;

This should be __aligned_u64, see commit:
26b9906612c3 ("RDMA: Change all uapi headers to use __aligned_u64 instead of __u64")

Fixed locally and applied.

Thanks

> +};
> +
>  struct bnxt_re_qp_req {
>  	__aligned_u64 qpsva;
>  	__aligned_u64 qprva;
> -- 
> 2.5.5
> 



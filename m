Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EA06DC6B3
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjDJMVP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 08:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjDJMVF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 08:21:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9355C7AA8
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 05:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25D8261B71
        for <linux-rdma@vger.kernel.org>; Mon, 10 Apr 2023 12:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CC1C433D2;
        Mon, 10 Apr 2023 12:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681129263;
        bh=kogjm9ptK9wRSQkvg5odIbnMQ6Tyx1VVEeSQkShvSbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRXMhl8kv986CdfUq6fe+ePu1pzYevWfuV/huHt8aFoaqkgTivbwQGe1yKiysGlfO
         OBd/wIaqaaAh6HF//Jx96vjlDC03oYbJnPOt/iofW5DaPKWQuSgMWFW3AnjfJjMU9M
         8OARI+ENdSAdui8sr5nhwIMB/57c3J39UQdCGyl0VTnbG9h+N/0oXgVXznPNldXiIt
         OtPX8u8CK+qf7oyavQ0N4wfVtNAW+7wMoUuwROkZzaw3DBmNssnkhc66h4QYAVZ6ev
         84jpBw3bdCtVIa9RJbhSkf6LiHCyeRBtCmi0n3JGZFeCV76arS5aGxelugTVI3gPNE
         nV2mvbmOw2FKw==
Date:   Mon, 10 Apr 2023 15:20:54 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 1/6] RDMA/bnxt_re: Use the common mmap helper
 functions
Message-ID: <20230410122054.GP182481@unreal>
References: <1681125115-7127-1-git-send-email-selvin.xavier@broadcom.com>
 <1681125115-7127-2-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681125115-7127-2-git-send-email-selvin.xavier@broadcom.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 04:11:50AM -0700, Selvin Xavier wrote:
> Replace the mmap handling function with common code in
> IB core. Create rdma_user_mmap_entry for each mmap
> resource and add to the ib_core mmap list. Add mmap_free
> verb support. Also, use rdma_user_mmap_io while mapping
> Doorbell pages.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 110 ++++++++++++++++++++++++++----
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h  |  15 ++++
>  drivers/infiniband/hw/bnxt_re/main.c      |   1 +
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c  |  10 +--
>  drivers/infiniband/hw/bnxt_re/qplib_res.c |   2 +-
>  5 files changed, 115 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index e86afec..c9d134c 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -533,12 +533,42 @@ static int bnxt_re_create_fence_mr(struct bnxt_re_pd *pd)
>  	return rc;
>  }
>  
> +static struct rdma_user_mmap_entry*
> +bnxt_re_mmap_entry_insert(struct bnxt_re_ucontext *uctx, u64 mem_offset,
> +			  enum bnxt_re_mmap_flag mmap_flag, u64 *offset)
> +{
> +	struct bnxt_re_user_mmap_entry *entry = kzalloc(sizeof(*entry), GFP_KERNEL);

Please separate calls to kzalloc() and variable initialization.

Thanks

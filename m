Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9245977B210
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Aug 2023 09:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjHNHIQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Aug 2023 03:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjHNHHt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Aug 2023 03:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00051E63
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 00:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88C3762398
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 07:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE1FC433C7;
        Mon, 14 Aug 2023 07:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691996867;
        bh=iUYfuhEDYRpoF/VbviZ9fCu4Il2kHSKY8H38vsuSIU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n99ZW3DxecbVnyS7z8wz2fYyk5hjy2MHQIsJEH/J+OuguUl6qg/S48joZu6CYBg6S
         wIFHrRgh94OwPhYTey7vd3ntF/w9bNU31EH7YSYHsVJ5sLBDhglT1QthxjpHbT038h
         SpqxRSl+yfL/SurbdBl7p5N45wiroCOyv23jYcxFD93RMVodLo+xEpypw4Z0oBIO5o
         pVMPrwb+cTddcRhJqPTeiT20VyL0aDAABRHPW5r9j0PUljntO8IN/9gOSD4wdC9eZl
         3DVaWLv04YQ+befZyU2aPwEngwKFsbo0sneSaScCyw9LA3ExjsdwGjsVUtKdz/BXf0
         BeZAt8YiUE/Pg==
Date:   Mon, 14 Aug 2023 10:07:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Ruan Jinjie <ruanjinjie@huawei.com>
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH -next v2] RDMA/irdma: Silence the warnings in
 irdma_uk_rdma_write()
Message-ID: <20230814070744.GB3921@unreal>
References: <20230814015805.1002656-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814015805.1002656-1-ruanjinjie@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 14, 2023 at 09:58:05AM +0800, Ruan Jinjie wrote:
> Remove sparse warnings introduced by commit 272bba19d631 ("RDMA: Remove
> unnecessary ternary operators"):
> 
> drivers/infiniband/hw/irdma/uk.c:285:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:285:24: sparse:     got restricted __le32 [usertype] *push_db
> drivers/infiniband/hw/irdma/uk.c:386:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:386:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:386:24: sparse:     got restricted __le32 [usertype] *push_db
> drivers/infiniband/hw/irdma/uk.c:471:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:471:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:471:24: sparse:     got restricted __le32 [usertype] *push_db
> drivers/infiniband/hw/irdma/uk.c:723:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:723:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:723:24: sparse:     got restricted __le32 [usertype] *push_db
> drivers/infiniband/hw/irdma/uk.c:797:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:797:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:797:24: sparse:     got restricted __le32 [usertype] *push_db
> drivers/infiniband/hw/irdma/uk.c:875:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected bool [usertype] push_wqe:1 @@     got restricted __le32 [usertype] *push_db @@
> drivers/infiniband/hw/irdma/uk.c:875:24: sparse:     expected bool [usertype] push_wqe:1
> drivers/infiniband/hw/irdma/uk.c:875:24: sparse:     got restricted __le32 [usertype] *push_db
> 

Fixes: 272bba19d631 ("RDMA: Remove unnecessary ternary operators")

> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308110251.BV6BcwUR-lkp@intel.com/
> ---
> v2:
> - Use "qp->push_mode" check instead of "qp->push_db"
> ---
>  drivers/infiniband/hw/irdma/uk.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Let's wait to get Shiraz's opinion about this patch.
If it is ok, I'll add Fixes line and apply.

Thanks

> 
> diff --git a/drivers/infiniband/hw/irdma/uk.c b/drivers/infiniband/hw/irdma/uk.c
> index a0739503140d..f7150aa75827 100644
> --- a/drivers/infiniband/hw/irdma/uk.c
> +++ b/drivers/infiniband/hw/irdma/uk.c
> @@ -282,7 +282,7 @@ int irdma_uk_rdma_write(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
>  	bool read_fence = false;
>  	u16 quanta;
>  
> -	info->push_wqe = qp->push_db;
> +	info->push_wqe = qp->push_mode;
>  
>  	op_info = &info->op.rdma_write;
>  	if (op_info->num_lo_sges > qp->max_sq_frag_cnt)
> @@ -383,7 +383,7 @@ int irdma_uk_rdma_read(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
>  	u16 quanta;
>  	u64 hdr;
>  
> -	info->push_wqe = qp->push_db;
> +	info->push_wqe = qp->push_mode;
>  
>  	op_info = &info->op.rdma_read;
>  	if (qp->max_sq_frag_cnt < op_info->num_lo_sges)
> @@ -468,7 +468,7 @@ int irdma_uk_send(struct irdma_qp_uk *qp, struct irdma_post_sq_info *info,
>  	bool read_fence = false;
>  	u16 quanta;
>  
> -	info->push_wqe = qp->push_db;
> +	info->push_wqe = qp->push_mode;
>  
>  	op_info = &info->op.send;
>  	if (qp->max_sq_frag_cnt < op_info->num_sges)
> @@ -720,7 +720,7 @@ int irdma_uk_inline_rdma_write(struct irdma_qp_uk *qp,
>  	u32 i, total_size = 0;
>  	u16 quanta;
>  
> -	info->push_wqe = qp->push_db;
> +	info->push_wqe = qp->push_mode;
>  	op_info = &info->op.rdma_write;
>  
>  	if (unlikely(qp->max_sq_frag_cnt < op_info->num_lo_sges))
> @@ -794,7 +794,7 @@ int irdma_uk_inline_send(struct irdma_qp_uk *qp,
>  	u32 i, total_size = 0;
>  	u16 quanta;
>  
> -	info->push_wqe = qp->push_db;
> +	info->push_wqe = qp->push_mode;
>  	op_info = &info->op.send;
>  
>  	if (unlikely(qp->max_sq_frag_cnt < op_info->num_sges))
> @@ -872,7 +872,7 @@ int irdma_uk_stag_local_invalidate(struct irdma_qp_uk *qp,
>  	bool local_fence = false;
>  	struct ib_sge sge = {};
>  
> -	info->push_wqe = qp->push_db;
> +	info->push_wqe = qp->push_mode;
>  	op_info = &info->op.inv_local_stag;
>  	local_fence = info->local_fence;
>  
> -- 
> 2.34.1
> 

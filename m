Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E879265BD64
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Jan 2023 10:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjACJq4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Jan 2023 04:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbjACJqX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Jan 2023 04:46:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F995B0C
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 01:46:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5DD9B80E6B
        for <linux-rdma@vger.kernel.org>; Tue,  3 Jan 2023 09:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE256C433D2;
        Tue,  3 Jan 2023 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672739179;
        bh=KABoHCmkMxW5QjQwa/WXb9i6PZ8xTPpVxhrVPVcUU6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LK6G28iI43c9+d4y9VJJJcF8Imkac3RR0WFPQjqQ0QkRYjq1mHxOV577zoIDLCLFf
         prKhJoC060Ki01i6barXjtVWfQKWyX0AkOyFpkKx9l5V2spNW1AKRGrVCQ7nbbW95/
         UUG7l+YPynkYstq6eBk7mJB0F467Pm6L5r1+UmKX5hbdEC8IVlDbo+8pMaK1iPJuzJ
         9V0VsWjB9vzRv4Kz8sDUVPo5CIqeOtPhpimymZ3cdZbTHUSO/yzVq0z/7qMdcZhDgP
         nd/Bkf8XSnHnObpJ8aztHl6vs9qSk0Rv46WdDSUmphrvSUt2AB2FpQsveEsGFCgx/x
         IdD493E1AbHvg==
Date:   Tue, 3 Jan 2023 11:46:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Yonatan Nachum <ynachum@amazon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, mrgolin@amazon.com
Subject: Re: [PATCH for-rc] RDMA: Fix ib block iterator counter overflow
Message-ID: <Y7P5Z5IsazudRPe7@unreal>
References: <20230102160317.89851-1-ynachum@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102160317.89851-1-ynachum@amazon.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 02, 2023 at 06:03:17PM +0200, Yonatan Nachum wrote:
> When registering a new DMA MR after selecting the best aligned page size
> for it, we iterate over the given sglist to split each entry to smaller,
> aligned to the selected page size, DMA blocks.
> 
> In given circumstances where the sg entry and page size fit certain sizes
> and the sg entry is not aligned to the selected page size, the total size
> of the aligned pages we need to cover the sg entry is >= 4GB. Under this
> circumstances, while iterating page aligned blocks, the counter responsible
> for counting how much we advanced from the start of the sg entry is
> overflowed because its type is u32 and we pass 4GB in size.  This can
> lead to an infinite loop inside the iterator function because in some
> cases the overflow prevents the counter to be larger than the size of
> the sg entry.
> 
> Fix the presented problem with changing the counter type to u64.
> 
> Backtrace:
> [  192.374329] efa_reg_user_mr_dmabuf
> [  192.376783] efa_register_mr
> [  192.382579] pgsz_bitmap 0xfffff000 rounddown 0x80000000
> [  192.386423] pg_sz [0x80000000] umem_length[0xc0000000]
> [  192.392657] start 0x0 length 0xc0000000 params.page_shift 31 params.page_num 3
> [  192.399559] hp_cnt[3], pages_in_hp[524288]
> [  192.403690] umem->sgt_append.sgt.nents[1]
> [  192.407905] number entries: [1], pg_bit: [31]
> [  192.411397] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
> [  192.415601] biter->__sg_advance [665837568] sg_dma_len[3221225472]
> [  192.419823] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
> [  192.423976] biter->__sg_advance [2813321216] sg_dma_len[3221225472]
> [  192.428243] biter->__sg_nents [1] biter->__sg [0000000008b0c5d8]
> [  192.432397] biter->__sg_advance [665837568] sg_dma_len[3221225472]
> 
> Fixes: a808273a495c

The fixes line is truncated. Please fix and resend.

Thanks

> 
> Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
> ---
>  include/rdma/ib_verbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 975d6e9efbcb..6821c7951363 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -2836,7 +2836,7 @@ struct ib_block_iter {
>  	struct scatterlist *__sg;	/* sg holding the current aligned block */
>  	dma_addr_t __dma_addr;		/* unaligned DMA address of this block */
>  	unsigned int __sg_nents;	/* number of SG entries */
> -	unsigned int __sg_advance;	/* number of bytes to advance in sg in next step */
> +	u64 __sg_advance;		/* number of bytes to advance in sg in next step */
>  	unsigned int __pg_bit;		/* alignment of current block */
>  };
>  
> -- 
> 2.38.1
> 

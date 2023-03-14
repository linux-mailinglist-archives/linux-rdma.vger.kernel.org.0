Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E57D6B974D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Mar 2023 15:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjCNOKb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Mar 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjCNOK3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Mar 2023 10:10:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D0E733BC
        for <linux-rdma@vger.kernel.org>; Tue, 14 Mar 2023 07:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 659D2B8169D
        for <linux-rdma@vger.kernel.org>; Tue, 14 Mar 2023 14:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82781C433D2;
        Tue, 14 Mar 2023 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678803025;
        bh=ZQZtfMOQCmpndI6zn5HWHZrcRgnZD04L6tSwPpq7Eyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUPVQc8MzRgAi2R0LK/2gcH9J/d9uYwAff8QrExhLIE4+zDpGNwt8Lyibk8wqV+Qu
         1I2XHkrvk0mclyX2/VRILO5c6RzG+BSJKkHmR2vXlUI5RQXIbf67SbI2xH0spmwyly
         AQ7UMynBKbP1eDNzVWAHP4LLjwF6Vx9NE54QFCUdaPDkmQ0F2IK/KGa13AsGK33MMl
         r+vtbP2OZ7PPawlkksFUJ3rblcD5JTuNQiXoLVoSDnZtigD2pKv2SArhLq6SzUShm/
         +71BpgmgI4cpDEi+gVs7M/0ZENbQXlrJMFERq/uj+OxiUF9feg+sJVwRnsyhlAIrg3
         3jtbrTvhRk8KQ==
Date:   Tue, 14 Mar 2023 16:10:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Message-ID: <20230314141020.GL36557@unreal>
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
 <20230307102924.70577-3-chengyou@linux.alibaba.com>
 <20230314102313.GB36557@unreal>
 <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 14, 2023 at 07:50:19PM +0800, Cheng Xu wrote:
> 
> 
> On 3/14/23 6:23 PM, Leon Romanovsky wrote:
> > On Tue, Mar 07, 2023 at 06:29:24PM +0800, Cheng Xu wrote:
> >> Doorbell resources are exposed to userspace by mmap. The size unit of mmap
> >> is PAGE_SIZE, previous implementation can not work correctly if PAGE_SIZE
> >> is not 4K. We support non-4K page size in this commit.
> > 
> > Why do you need this information in rdma-core?
> > Can you use sysconf(_SC_PAGESIZE) there to understand the page size like
> > other providers?
> > 
> 
> I don't expose PAGE_SIZE to userspace in this patchset, but the *offset* in
> PAGE of the DBs:
> 
> diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
> index b7a0222f978f..57f8942a3c56 100644
> --- a/include/uapi/rdma/erdma-abi.h
> +++ b/include/uapi/rdma/erdma-abi.h
> @@ -40,10 +40,13 @@ struct erdma_uresp_alloc_ctx {
>  	__u32 dev_id;
>  	__u32 pad;
>  	__u32 sdb_type;
> -	__u32 sdb_offset;
> +	__u32 sdb_entid;
>  	__aligned_u64 sdb;
>  	__aligned_u64 rdb;
>  	__aligned_u64 cdb;
> +	__u32 sdb_off;
> +	__u32 rdb_off;
> +	__u32 cdb_off;
>  };
> 
> Our doorbell space is aligned to 4096, this works fine when PAGE_SIZE is
> also 4096, and the doorbell space starts from the mapped page. When
> PAGE_SIZE is not 4096, the doorbell space may starts from the middle of
> the mapped page.
> 
> For example, our SQ doorbell starts from the offset 4096 in PCIe bar 0.
> When we map the first SQ doorbell to userspace when PAGE_SIZE is 64K,
> the doorbell space starts from the offset 4096 in mmap returned address.
> 
> So the userspace needs to know the doorbell space offset in mmaped page.

And can't you preserve same alignment in the kernel for doorbells for every page size?
Just always start from 0.

> 
> Thanks,
> Cheng Xu
> 
> 
> 
> > Thanks

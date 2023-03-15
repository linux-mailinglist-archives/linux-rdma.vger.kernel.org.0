Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931F16BAD8F
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Mar 2023 11:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjCOKXH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Mar 2023 06:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjCOKXF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Mar 2023 06:23:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E1856BA
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 03:22:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0CDEBCE1985
        for <linux-rdma@vger.kernel.org>; Wed, 15 Mar 2023 10:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9180C433EF;
        Wed, 15 Mar 2023 10:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678875735;
        bh=FGtBM5scWfwrxSnuaJjgnq1axHBMvrer2bFWMZ4eZtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=InMYaAJH73yUgdOk4J3bh8daJyxprJmM04c+9ovlgpYF6jdeKhiWhE4Ed7Q6wTVfE
         mr4G6MJm5zKAO+lWKc4G/Z6c2GbsiMBBw4pYlp+at52vaTHFB1afK2Ns3MApoetrVC
         KygedPavT44oRoYMB1W7Pscj9Pd3vbLCDJtMrmXYybF7h6WTj5OWXjvRNkzRG4ZDAS
         /c74NaARriDlomwB6paWanvB1RpazAU9t+thikKIFoLEg38txMAuiZY4TQ63Bu02Nf
         +S3Phh+/tcK3a7B89dj6uWupgMvhv0FmZ3tt7WudcJcY6EH1QehgUTibqizJ/AOhs+
         4hBYSqhopl26w==
Date:   Wed, 15 Mar 2023 12:22:10 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in
 doorbell allocation
Message-ID: <20230315102210.GT36557@unreal>
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
 <20230307102924.70577-3-chengyou@linux.alibaba.com>
 <20230314102313.GB36557@unreal>
 <e6eec8de-7442-7f2b-8c90-af9222b2e12b@linux.alibaba.com>
 <20230314141020.GL36557@unreal>
 <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604d654-583f-52eb-ff76-fd92647d3625@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 15, 2023 at 09:58:06AM +0800, Cheng Xu wrote:
> 
> 
> On 3/14/23 10:10 PM, Leon Romanovsky wrote:
> > On Tue, Mar 14, 2023 at 07:50:19PM +0800, Cheng Xu wrote:
> >>
> >>
> <...>
> >>
> >> Our doorbell space is aligned to 4096, this works fine when PAGE_SIZE is
> >> also 4096, and the doorbell space starts from the mapped page. When
> >> PAGE_SIZE is not 4096, the doorbell space may starts from the middle of
> >> the mapped page.
> >>
> >> For example, our SQ doorbell starts from the offset 4096 in PCIe bar 0.
> >> When we map the first SQ doorbell to userspace when PAGE_SIZE is 64K,
> >> the doorbell space starts from the offset 4096 in mmap returned address.
> >>
> >> So the userspace needs to know the doorbell space offset in mmaped page.
> > 
> > And can't you preserve same alignment in the kernel for doorbells for every page size?
> > Just always start from 0.
> > 
> 
> I've considered this option before, but unfortunately can't, at least for CQ DB.
> The size of our PCIe bar 0 is 512K, and offset [484K, 508K] are CQ doorbells.
> CQ doorbell space is located in offset [36K, 60K] when PAGE_SIZE = 64K, and can't
> start from offset 0 in this case.
> 
> Another reason is that we want to organize SQ doorbell space in unit of 4096.
> In current implementation, each ucontext will be assigned a SQ doorbell space
> for both normal doorbell and direct wqe usage. Unit of 4096, compared with
> larger unit, more ucontexts can be assigned exclusive doorbell space for direct
> wqe.

I have a feeling that there is an existing API for it already.
Let's give a chance for Jason to chime in.

Thanks

> 
> Thanks,
> Cheng Xu

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ECB72B11B
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Jun 2023 11:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjFKJTn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Jun 2023 05:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjFKJTm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 11 Jun 2023 05:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3CD173B
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 02:19:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2179660F1A
        for <linux-rdma@vger.kernel.org>; Sun, 11 Jun 2023 09:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEAAC433D2;
        Sun, 11 Jun 2023 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686475180;
        bh=3qO3e/SfXEgn3Ig8IjySYvTLGM5sZuv6D+9uIKjiB2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i65soJZGef9ug7U/fZdQ3/53df/y6bmnQ5UBGt90vtkTm9n/cE+c1aF2Qhp+hXmvo
         vORpmWGuJTwGAPkpwH5nsekyfAb2KX83ZgPa7mj7/8sKlwlp07XEH9md4HdMSXlSWW
         5kODoOulI90ivXkMhsEVNHP00V/oQ7mC+9ZzTyAhRQR6U5HE3Z6pDc3FqGTmzpCW8V
         f/OSr4Big1eYuHfQbzGpGkefKsySNr1D8pV00yWhV5id2ANf5Q5oEAgZAUJS7Pmryb
         Wb834mwOZa+UieoKV8+5/469wTzkDLzIgU9WYTBI4JjBbHGw1Ah4KLCc2SqxetVJhm
         UVcYlrL0Fh3Sg==
Date:   Sun, 11 Jun 2023 12:19:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 0/4] RDMA/erdma: Add a new doorbell allocation
 mechanism
Message-ID: <20230611091936.GB12152@unreal>
References: <20230606055005.80729-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606055005.80729-1-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 06, 2023 at 01:50:01PM +0800, Cheng Xu wrote:
> Hi,
> 
> This series adds a new doorbell allocation mechanism to meet the
> the isolation requirement for userspace applications. Two main change
> points in this patch set: One is that we extend the bar space for doorbell
> allocation, and the other one is that we associate QPs/CQs with the
> allocated doorbells for authorization. We also keep the original doorbell
> mechanism for compatibility, but only used under CAP_SYS_RAWIO to prevent
> non-privileged access, which suggested by Jason before.
> 
> - #1 configures the current PAGE_SIZE to hardware, so that hardware can
>   organize the mmio space properly.
> - #2~#3 implement the new doorbell allocation mechanism.
> - #4 refactors the doorbell allocation part to make code more simpler and
>   cleaner.
> 
> Thanks,
> Cheng Xu
> 
> Cheng Xu (4):
>   RDMA/erdma: Configure PAGE_SIZE to hardware
>   RDMA/erdma: Allocate doorbell resources from hardware
>   RDMA/erdma: Associate QPs/CQs with doorbells for authorization
>   RDMA/erdma: Refactor the original doorbell allocation mechanism

As a side note, there is no need to perform double not (!!...) when
assigning to bool variables.

Thanks

> 
>  drivers/infiniband/hw/erdma/erdma.h       |  16 +-
>  drivers/infiniband/hw/erdma/erdma_hw.h    |  64 ++++++--
>  drivers/infiniband/hw/erdma/erdma_main.c  |  53 +++----
>  drivers/infiniband/hw/erdma/erdma_verbs.c | 178 +++++++++++++---------
>  drivers/infiniband/hw/erdma/erdma_verbs.h |  13 +-
>  5 files changed, 183 insertions(+), 141 deletions(-)
> 
> -- 
> 2.31.1
> 

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BC61E252
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Nov 2022 14:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiKFNZB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Nov 2022 08:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiKFNZA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 6 Nov 2022 08:25:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4DFDEE6
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 05:25:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A63DB60B7A
        for <linux-rdma@vger.kernel.org>; Sun,  6 Nov 2022 13:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CC3C433C1;
        Sun,  6 Nov 2022 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667741099;
        bh=aZjiJTUr4C9zRYLg8Bsz4nINUAE4uGOTFH16X+cJDAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrkpH65otWNxakFrn+hSh3U6z/PBfxCjwvI2KRl32ApYlY5FuGj1goZjrYHE8V8+Q
         o0WdbC0WA0V1/7OKY0TEURMMHbM0ChfttrzdnJ16tRu4kkp07RmRE4EoA26+yiPv8Z
         lYfjtRo75gJl1veB+JzHmaecsa8HpWYDIsSB7QPlo2QULZUAsODXSu/PILcO8qg4te
         sIIWdHNuhXnSQ02lfXZdtwcq1WWaAlHz4KYneLYZS8cAW9cqcrMZMLty99fzt6o5uG
         hrHgATXLgGhkRx1HTvQohg9FsGYlGpgH7DofZVIdUwefRAw7ECnwIdd4BP+e7nUt3Y
         qlt8FuZ69oyEA==
Date:   Sun, 6 Nov 2022 15:24:54 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Cheng Xu <chengyou@linux.alibaba.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: Re: [PATCH for-next 0/3] RDMA/erdma: Add atomic operations support
Message-ID: <Y2e1pr36v3tm0l5A@unreal>
References: <20221027095741.48044-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221027095741.48044-1-chengyou@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 27, 2022 at 05:57:38PM +0800, Cheng Xu wrote:
> Hi,
> 
> This series introcuces atomic operations support for erdma driver:
> - #1 extends access rights field in FRMR and REG MR commands to support
>   IB_ACCESS_REMOTE_ATOMIC.
> - #2 gets atomic capacity from hardware, and reports the cap to core.
> - #3 implements the IO-path of atomic WR processing.
> 
> Thanks,
> Cheng Xu
> 
> Cheng Xu (3):
>   RDMA/erdma: Extend access right field of FRMR and REG MR to support
>     atomic
>   RDMA/erdma: Report atomic capacity when hardware supports atomic
>     feature
>   RDMA/erdma: Implement atomic operations support

It doesn't pass my static analyzer checks.

➜  kernel git:(wip/leon-for-next) mkt ci
3f69c46621e3 (HEAD -> build) RDMA/erdma: Implement atomic operations support
drivers/infiniband/hw/erdma/erdma_qp.c:365:26: warning: incorrect type in assignment (different base types)
drivers/infiniband/hw/erdma/erdma_qp.c:365:26:    expected restricted __le32 [usertype] key
drivers/infiniband/hw/erdma/erdma_qp.c:365:26:    got unsigned int [usertype] rkey

Thanks

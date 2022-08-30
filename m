Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7834D5A5CD9
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Aug 2022 09:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH3H1J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Aug 2022 03:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3H1J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Aug 2022 03:27:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD537B1DC
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 00:27:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38B9FB8168A
        for <linux-rdma@vger.kernel.org>; Tue, 30 Aug 2022 07:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D106C433D6;
        Tue, 30 Aug 2022 07:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661844425;
        bh=QvS6sIA+D0z4J8xPSA5iq/CvV5x6x0FPq7qEKhshmCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBsfLx0VzrqwF7zQYo4sunfK4puPlZTxUodMj0qVt1ayxidjT3Mv6xXo/GhPK+ksB
         T1dWwm+XjJNA26MRz2QlT2wJHNm7Yy8FNVMrjCLtGCgqNEf4E/tnRSecIK2rQeYdjm
         l5JJUw/t1atL/+uQdIbAPEzY5wc2QEMgkeu5T3fEqc+o6YEg/nGCQndcj4l/MLmFcy
         Tu2r2uUs4jkm6YmbPh0m7Z+fYNs3pxwpXqxfAf5gJawI/RE26ZjnNrtstC63+6hG+0
         Qf5Tddpi3CGKReqAm+YvuqBMBmdXGG8k2kMBu2xiOdvSC6tNIlgU7LEmEbEJaglVep
         tsF/yMifuturg==
Date:   Tue, 30 Aug 2022 10:27:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/4] RDMA/hns: Bugfixes or cleanups for resource
 specs or numbers
Message-ID: <Yw27xaDjcg5iAonk@unreal>
References: <20220829105021.1427804-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829105021.1427804-1-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 29, 2022 at 06:50:17PM +0800, Wenpeng Liang wrote:
> The following is the outline of each patch:
> (1)#1~#3: The earliest code sets the resource specification incorrectly.
> (2)#4: The earliest code used this parameter, but the latest code no longer
>        needs it.
> 
> Chengchang Tang (1):
>   RDMA/hns: Fix supported page size
> 
> Wenpeng Liang (2):
>   RDMA/hns: Fix wrong fixed value of qp->rq.wqe_shift
>   RDMA/hns: Remove redundant member doorbell_qpn of struct hns_roce_qp

I took these to rdma-rc.

> 
> Yixing Liu (1):
>   RDMA/hns: Remove the num_qpc_timer variable

And this to rdma-next.

> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |  2 --
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  5 ++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 ++--
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 10 ++--------
>  5 files changed, 7 insertions(+), 16 deletions(-)
> 
> --
> 2.30.0
> 

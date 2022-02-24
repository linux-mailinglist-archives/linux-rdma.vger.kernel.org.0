Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A1C4C2D1F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 14:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiBXNdF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 08:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiBXNcy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 08:32:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D1D3B3F6
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 05:32:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4327BB81878
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 13:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D6DC340E9;
        Thu, 24 Feb 2022 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709537;
        bh=KW+y0O6POljH/FqaDtzmnqI5Pmlo6DSnzSGwggshKIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NctRCIElCAtwzF7g6pXJh1qYXDF9cAndWQ9OQFMmqGYWOeQdGjKk370mKqaEnNbGg
         DANW8GDvUEK+GLk3RBHJiIV9XQ7rL5CtJket5y92uDCLmFvy2EuBxhgL2fp7oYLGsN
         JJ/KTOigsrcQd8gea8BETFGuwQSj6Cfb07Ejf5Utob5e5b/DgyShPpyAjpe33nD5c6
         BKtBDatmrdijWyzKMwRjy4UVvQStmIxtNDA1iC6m9XXbXouWerxNv1ODmTvbFZyHgH
         7Xu4AQMXP9XKhbLQTuG8kC0FjwpyH4dEuZAEYmuGhUdJuR6Z+M56DGYCyiNWgLelTH
         m50zv7XRZGNMw==
Date:   Thu, 24 Feb 2022 15:32:13 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 6/8] RDMA/hns: Remove similar code that
 configures the hardware contexts
Message-ID: <YheI3Q4NpzGofml2@unreal>
References: <20220218110519.37375-1-liangwenpeng@huawei.com>
 <20220218110519.37375-7-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218110519.37375-7-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 18, 2022 at 07:05:17PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> Remove duplicate code for creating and destroying hardware contexts via
> mailbox.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c    | 12 +++++++++
>  drivers/infiniband/hw/hns/hns_roce_cmd.h    |  5 ++++
>  drivers/infiniband/hw/hns/hns_roce_cq.c     |  8 +++---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  2 --
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  4 +--
>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 29 ++++++---------------
>  drivers/infiniband/hw/hns/hns_roce_srq.c    | 20 +++-----------
>  7 files changed, 35 insertions(+), 45 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

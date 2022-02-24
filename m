Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1D74C2D03
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 14:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbiBXNb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 08:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBXNb0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 08:31:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E29BB7C7D
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 05:30:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 077C761983
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 13:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CFFC340F0;
        Thu, 24 Feb 2022 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709456;
        bh=igkDzmw8k+3cY6diBJLA2Fxy8eIL7amM8UpL93BLlQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IIgpuUH8HJpW6cGfd7b5uhytVsMS465NWX7nAC10jqkOjYGHyHsLmw3VfL2gkVJYN
         VZPUefLLuLkdzLBN1aNfdn/MQBdVh7EZAy+YqRXwfu7dlAYHKEtz67pr4bM2pfEmOz
         zXXrTcsmuL12766O90R/3ZE5YuMISdFQWO1uf+dCNvCKAOF5N/X0kQXdw0BFHS0MDY
         u2TB2D9uvXzTN8A5vuFC3CxFVZ7gtY+7bxPItv4W82BZbJbuKysxWgIYYQpZyWbKTd
         Gv1FSMF1TuR5GKJNNV3uqHUjbXfx2KHMLZ3X0yQcAGdelODa5zwJo++5/+ux0OL6CN
         zImsSfcqFS5Kw==
Date:   Thu, 24 Feb 2022 15:30:52 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/8] RDMA/hns: Remove the unused parameter
 "op_modifier" in mailbox
Message-ID: <YheIjE7d6Kr2ZJYQ@unreal>
References: <20220218110519.37375-1-liangwenpeng@huawei.com>
 <20220218110519.37375-2-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218110519.37375-2-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 18, 2022 at 07:05:12PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> The parameter "op_modifier" is only used for HIP06. It is useless for HIP08
> and later versions. After removing HIP06, this parameter is no longer used,
> so remove it.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c      | 36 ++++++++-----------
>  drivers/infiniband/hw/hns/hns_roce_cmd.h      |  3 +-
>  drivers/infiniband/hw/hns/hns_roce_cq.c       |  4 +--
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 26 +++++++-------
>  .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c       |  6 ++--
>  drivers/infiniband/hw/hns/hns_roce_srq.c      |  4 +--
>  8 files changed, 37 insertions(+), 46 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

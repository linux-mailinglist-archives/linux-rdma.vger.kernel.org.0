Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D4A4C2CFE
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiBXNcA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 08:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiBXNb5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 08:31:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C4816DAE4
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 05:31:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A414561AC7
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 13:31:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 933CEC340F0;
        Thu, 24 Feb 2022 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709484;
        bh=YafpBL7CYNIJWE8Wt8y4hThKCuoYSbxFhVF1bd8yJZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XHHPKO3vjvhsRTeWBiRaNbW1Q6o72DVLcZ+KNSVmpPPi92bXaVeuY8kHE309aR9nC
         wWyIhDr6xq72vCgOtF0YpXm4rkpvXLxjPsx8dxVuDsnqUDzxFhKGVI50nBsaGBm4YU
         iBokDz9HsLCixhsCtkY16M5YTy462ig+HOEerTZZA8ToxlkD7gXjjcCJbszs65cIMM
         ACdVzXFWlBE2bg/KJRLDjsMeRyzvX/u6WXJbC8DE8AKXUnM/j8XvmIj7ziSfKgJIc+
         pblvs9Dz+melNa6rgS6eGvB/nAPKlN6M/zJHuJUzHV2jXAL5YkioRm4WtNmId0512H
         U6bMWEKhnmnkA==
Date:   Thu, 24 Feb 2022 15:31:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 3/8] RDMA/hns: Remove redundant parameter
 "mailbox" in the mailbox
Message-ID: <YheIqC2SUei/4xGp@unreal>
References: <20220218110519.37375-1-liangwenpeng@huawei.com>
 <20220218110519.37375-4-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218110519.37375-4-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 18, 2022 at 07:05:14PM +0800, Wenpeng Liang wrote:
> The parameter "out_param" of the mailbox is always null when the context is
> destroyed. So remove the function parameter "mailbox".
> 
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  1 -
>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 11 +++++------
>  drivers/infiniband/hw/hns/hns_roce_srq.c    |  6 ++----
>  3 files changed, 7 insertions(+), 11 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

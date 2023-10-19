Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A767CF078
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Oct 2023 08:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjJSGxk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Oct 2023 02:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjJSGxj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Oct 2023 02:53:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F2116;
        Wed, 18 Oct 2023 23:53:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47644C433C7;
        Thu, 19 Oct 2023 06:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697698417;
        bh=CIL4UDG1ISiYTN/t5P6MMGLYqFfSIYu1R75YVO/5K9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QnLDw70Pr8YQRAD5oJOK0r4KHulxSMEalvou4/y8Ez72ZR4srDBgVEkAH44yB1uEl
         igc/QHYMd9sxNCSRkcYfLGfzE4t7etyHXDTozrrTSGNzIT38mDxpRAVdnCixcqH9A/
         P1h31mgHQlBgyga3fX0CWMPmRyVCgLAf3Z4n4AnD6kpStXaMfme/4A4ISTsMBS0blF
         ZhMrYaLr0zmL9XXHSmEQNPGcMO8Fj4izyDAwVdS2qZTHGz3Um8AC+mrR6qkGwYrBxP
         Htozey6UE2NJzEGIGoWPG2cEhgPg2J8DIrr+nNrQy5QXM+PskrPEyIg9p/QhrDmTKx
         lpSuN9skzlCtg==
Date:   Thu, 19 Oct 2023 09:53:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 0/7] Bugfixes for hns RoCE
Message-ID: <20231019065333.GK5392@unreal>
References: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017125239.164455-1-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 17, 2023 at 08:52:32PM +0800, Junxian Huang wrote:
> Here is a patchset of several bugfixes.
> 
> Chengchang Tang (3):
>   RDMA/hns: Fix printing level of asynchronous events
>   RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()
>   RDMA/hns: Fix signed-unsigned mixed comparisons
> 
> Junxian Huang (2):
>   RDMA/hns: Fix unnecessary port_num transition in HW stats allocation
>   RDMA/hns: Fix init failure of RoCE VF and HIP08
> 
> Luoyouming (2):
>   RDMA/hns: Add check for SL
>   RDMA/hns: The UD mode can only be configured with DCQCN

I took all these patches to -next, we are in -rc6 now.

Thanks

> 
>  drivers/infiniband/hw/hns/hns_roce_ah.c    | 13 ++++++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 34 +++++++++++++---------
>  drivers/infiniband/hw/hns/hns_roce_main.c  | 22 +++++++-------
>  drivers/infiniband/hw/hns/hns_roce_qp.c    |  2 +-
>  4 files changed, 43 insertions(+), 28 deletions(-)
> 
> --
> 2.30.0
> 

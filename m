Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82B7578088
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 13:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiGRLRm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 07:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiGRLRl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 07:17:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B3E201A6
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 04:17:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7C16125F
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 11:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7681FC341C0;
        Mon, 18 Jul 2022 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658143059;
        bh=FQbgRAKfye50kdKNrc2j+r0egUc/mXEUmU8qWh7qVjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fi9owLVgpUqAzJXJXLkkdi30HeSrp0+1tcFYgVAkuNAHatlVt75KkaADnowthDOcu
         SfX0KvJTK+9nxgWB4hcXL3uoYDq9HyT8a7cWxMfoZQrqaJuQ5Tfq9oGBH2Ts5+W5VK
         4n1v0LNocg3mRbznIv7gQTMfql2CtHiJvT9Lp/toNohdwLxFnVXy+R8/8GdgNhW0vN
         jTcddVrfigRZ+5cX6ulI2bbWMhFsCnT8kHyAWzh1VXbU0gEfIyjKk5Q7VlcH3sjgOX
         Tsx7T7YnvxmbkV/cryVNdNARVpmuBS6+yrUt8ITluNo3/xfengB/OF2jPU+TcJ/qeT
         iap63az50U7Ww==
Date:   Mon, 18 Jul 2022 14:17:34 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v3 for-next 0/5] RDMA/hns: Supports recovery of on-chip
 RAM 1bit ECC errors
Message-ID: <YtVBTuFtlujoy81g@unreal>
References: <20220714134353.16700-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714134353.16700-1-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 14, 2022 at 09:43:48PM +0800, Wenpeng Liang wrote:
> Add support for the 1bit ECC error recovery by abnormal interrupt reporting
> and adjusts the structure of the abnormal interrupt handler.
> 
> The following is the outline of each patch:
> (1)#1~#4: Cleanup and bugfix for the abnormal interrupt handler.
> (2)#5: Support for the 1bit ECC error recovery.
> 
> Changes since v2:
> * Optimize the logic of the exit of fmea_recover_others() in #5.
> * v2 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20220713092630.1657-1-liangwenpeng@huawei.com/
> 
> Changes since v1:
> * Embed ecc_work into structure hns_roce_dev, no longer dynamically allocated in #5.
> * Add the const keyword to the string array that does not change in #5.
> * v1 Link: https://patchwork.kernel.org/project/linux-rdma/cover/20220624110845.48184-1-liangwenpeng@huawei.com/
> 
> Haoyue Xu (5):
>   RDMA/hns: Remove unused abnormal interrupt of type RAS
>   RDMA/hns: Fix the wrong type of return value of the interrupt handler
>   RDMA/hns: Fix incorrect clearing of interrupt status register
>   RDMA/hns: Refactor the abnormal interrupt handler function
>   RDMA/hns: Recover 1bit-ECC error of RAM on chip
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |   1 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 248 +++++++++++++++++---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  13 +-
>  3 files changed, 227 insertions(+), 35 deletions(-)
> 

Thanks, applied.

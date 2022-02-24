Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091C14C2D11
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 14:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiBXNbk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 08:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbiBXNbk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 08:31:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB70716DAD5
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 05:31:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58D3C61A97
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 13:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5A3C340E9;
        Thu, 24 Feb 2022 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709468;
        bh=M92mH61VoE+WqGCvLkQII5HVOfdMbnlXdq7IhgUajXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTrtVPXn5waSHJbY5K/wVymlUFVIHpxlVr6UdQCEBWAloeB7aKjPl1WWUdk6HHyoP
         Mp9fUnI/HuZ/ALo499RAaNN8zbbKTquqC2at6mXwB6RpOEIyEjZTpNwOwmdxWBflHs
         Ck+dlMUcbyGoHYIMBkwIxp5UFb5xhJEd+SHrtxCyDyyVwXhk2qpWN4GiIhRGFNkNWU
         adtGwBulPeR8fsDaK1N72JuIObWQpSHFaS6xAMuFhtlEIMjcEAhj33ZmwRWXXN4hYc
         rTFZG/j6/j+maqxw6Z1Bi6MWjAkAnRbaTA7o2MhGa126BX8gUBDVbgourLUxl4iz/A
         0wwc/bqSQMfcA==
Date:   Thu, 24 Feb 2022 15:31:04 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 2/8] =?utf-8?Q?RDMA=2F?=
 =?utf-8?Q?hns=3A_Remove_fixed_parameter_=E2=80=9Ctimeout?= =?utf-8?B?4oCd?=
 in the mailbox
Message-ID: <YheImBJqSBVsTzDg@unreal>
References: <20220218110519.37375-1-liangwenpeng@huawei.com>
 <20220218110519.37375-3-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220218110519.37375-3-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 18, 2022 at 07:05:13PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> The value of the function parameter “timeout” is unique. Therefore,
> it is unnecessary to specify the parameter “timeout” value each time.
> So remove it.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Haoyue Xu <xuhaoyue1@hisilicon.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c      | 22 ++++++------
>  drivers/infiniband/hw/hns/hns_roce_cmd.h      |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_cq.c       |  5 ++-
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  3 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 35 +++++++------------
>  .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |  3 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c       |  9 ++---
>  drivers/infiniband/hw/hns/hns_roce_srq.c      |  6 ++--
>  8 files changed, 34 insertions(+), 51 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

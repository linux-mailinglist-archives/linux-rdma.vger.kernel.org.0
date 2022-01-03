Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1E2482F20
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 09:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiACIw1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 03:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiACIw1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 03:52:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8C5C061761
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 00:52:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00523B80AC6
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 08:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA1EC36AEE;
        Mon,  3 Jan 2022 08:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641199943;
        bh=MNLn1mAenUFf0r102txuW0bRwKB1P2qYX9kpqasPd+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOjijV+tRr2Ov9Vv+6+Hy3vjf3fwE/NNCfARgx2iC0euAG4QHHuVliktauiZImU6a
         oSVRh0HKwjy1fB7EvJOOsEQq8ZOZnrAnhmtIfWrXAswUT54iFvVQz1LBOjoeALyHbP
         iAbshKiPcJaId+MzAzjh9vOap/42MRGDZB0M/0spSfuGhUbXP7Ujm+/0Xtd5USqkCF
         n8aDFzD/O+7JNYajSRYWLIe7Z765nAliAAFVSGrTbi3X8uPX0k5mw3bhIqjyNr9plC
         NBEDLXNppNy22xHC4ZML8hvbtI0SFOW+9m7bM+SgD9ron5yYovAVEqSVQNxVzIdIlX
         Nu2aPO9Z3XiSw==
Date:   Mon, 3 Jan 2022 10:52:19 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 for-next] RDMA/hns: Remove support for HIP06
Message-ID: <YdK5Q8iqofOU8BGa@unreal>
References: <20211220130558.61585-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220130558.61585-1-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 20, 2021 at 09:05:58PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> HIP06 is no longer supported. In order to reduce unnecessary maintenance,
> the code of HIP06 is removed.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/Kconfig           |   17 +-
>  drivers/infiniband/hw/hns/Makefile          |    5 -
>  drivers/infiniband/hw/hns/hns_roce_ah.c     |    5 +-
>  drivers/infiniband/hw/hns/hns_roce_alloc.c  |    3 +-
>  drivers/infiniband/hw/hns/hns_roce_cmd.c    |    1 -
>  drivers/infiniband/hw/hns/hns_roce_common.h |  202 -
>  drivers/infiniband/hw/hns/hns_roce_cq.c     |   13 -
>  drivers/infiniband/hw/hns/hns_roce_db.c     |    1 -
>  drivers/infiniband/hw/hns/hns_roce_device.h |   64 +-
>  drivers/infiniband/hw/hns/hns_roce_hem.c    |    1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  | 4675 -------------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.h  | 1147 -----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |   13 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |   62 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c     |   22 +-
>  drivers/infiniband/hw/hns/hns_roce_pd.c     |   20 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |   37 +-
>  17 files changed, 33 insertions(+), 6255 deletions(-)
>  delete mode 100644 drivers/infiniband/hw/hns/hns_roce_hw_v1.c
>  delete mode 100644 drivers/infiniband/hw/hns/hns_roce_hw_v1.h

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

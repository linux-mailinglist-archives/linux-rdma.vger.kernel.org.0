Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24E279EDF
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Sep 2020 08:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgI0Ga1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Sep 2020 02:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgI0Ga1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Sep 2020 02:30:27 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0975423A01;
        Sun, 27 Sep 2020 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601188226;
        bh=d1iycjibuhpBKoBR9/un/fisOCINLpPspQvee74TqqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Et5oM5eI6rv2fE6j4cOCzeFa31gLEHGYRAYVes2CmLlGBHNAtyfyQXp2pfB/w9PZY
         5d/RKatr3jmTBjyVMn4M/vIwkEy0h5pgx4lOpb10+mHs1nelAvWrJc7WmMqfWUJ71S
         j7vN/moXqHXukAmOivOM3ByMyHgy/Gd5LxJTqlKo=
Date:   Sun, 27 Sep 2020 09:30:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Support owner mode doorbell
Message-ID: <20200927063004.GG2280698@unreal>
References: <1601022214-56412-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601022214-56412-1-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 25, 2020 at 04:23:34PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> The doorbell needs to store PI information into QPC, so the RoCEE should
> wait for the results of storing, that is, it needs two bus operations to
> complete a doorbell. When ROCEE is in SDI mode, multiple doorbells may be
> interlocked because the RoCEE can only handle bus operations serially. So a
> flag to mark if HIP09 is working in SDI mode is added. When the SDI flag is
> set, the ROCEE will ignore the PI information of the doorbell, continue to
> fetch wqe and verify its validity by it's owner_bit.
>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  5 ++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 28 ++++++++++++++++++++++------
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  3 +++
>  3 files changed, 29 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index a8183ef..517c127 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_device.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -137,9 +137,10 @@ enum {
>  	SERV_TYPE_UD,
>  };
>
> -enum {
> +enum hns_roce_qp_caps {
>  	HNS_ROCE_QP_CAP_RQ_RECORD_DB = BIT(0),
>  	HNS_ROCE_QP_CAP_SQ_RECORD_DB = BIT(1),
> +	HNS_ROCE_QP_CAP_OWNER_DB = BIT(2),
>  };
>
>  enum hns_roce_cq_flags {
> @@ -229,6 +230,8 @@ enum {
>  	HNS_ROCE_CAP_FLAG_FRMR                  = BIT(8),
>  	HNS_ROCE_CAP_FLAG_QP_FLOW_CTRL		= BIT(9),
>  	HNS_ROCE_CAP_FLAG_ATOMIC		= BIT(10),
> +	HNS_ROCE_CAP_FLAG_SDI_MODE		= BIT(14),
> +	HNS_ROCE_CAP_FLAG_MAX			= BIT(28)

This enum is not used.

Thanks

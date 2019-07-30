Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2B7A9DE
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2019 15:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfG3Nka (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Jul 2019 09:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfG3Nka (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 30 Jul 2019 09:40:30 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 936172089E;
        Tue, 30 Jul 2019 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564494029;
        bh=lLGbV+mpWCgMNZeOcfaCo4/ic/rbo0UuAkSC8xLapGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oiJgUVAtLXyHw9eOFBhi/bkbbWaRBgraD2E5VZFStkTKThqJhRW1jDqtloTtQvFwR
         i2kKO69PKFcqy17JlhDbvtFd1j2xTYR89Zu0pMReH7tbB0V1sVxfFjkVoMNn0cwbGe
         u0govlMs6kaGmTvntpPb4o6klRQsv3rS8vF3YYRE=
Date:   Tue, 30 Jul 2019 16:40:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 10/13] RDMA/hns: Remove unnecessary kzalloc
Message-ID: <20190730134025.GD4878@mtr-leonro.mtl.com>
References: <1564477010-29804-1-git-send-email-oulijun@huawei.com>
 <1564477010-29804-11-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564477010-29804-11-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 30, 2019 at 04:56:47PM +0800, Lijun Ou wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> For hns_roce_v2_query_qp and hns_roce_v2_modify_qp,
> we can use stack memory to create qp context data.
> Make the code simpler.
>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 64 +++++++++++++-----------------
>  1 file changed, 27 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 1186e34..07ddfae 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -4288,22 +4288,19 @@ static int hns_roce_v2_modify_qp(struct ib_qp *ibqp,
>  {
>  	struct hns_roce_dev *hr_dev = to_hr_dev(ibqp->device);
>  	struct hns_roce_qp *hr_qp = to_hr_qp(ibqp);
> -	struct hns_roce_v2_qp_context *context;
> -	struct hns_roce_v2_qp_context *qpc_mask;
> +	struct hns_roce_v2_qp_context ctx[2];
> +	struct hns_roce_v2_qp_context *context = ctx;
> +	struct hns_roce_v2_qp_context *qpc_mask = ctx + 1;
>  	struct device *dev = hr_dev->dev;
>  	int ret;
>
> -	context = kcalloc(2, sizeof(*context), GFP_ATOMIC);
> -	if (!context)
> -		return -ENOMEM;
> -
> -	qpc_mask = context + 1;
>  	/*
>  	 * In v2 engine, software pass context and context mask to hardware
>  	 * when modifying qp. If software need modify some fields in context,
>  	 * we should set all bits of the relevant fields in context mask to
>  	 * 0 at the same time, else set them to 0x1.
>  	 */
> +	memset(context, 0, sizeof(*context));

"struct hns_roce_v2_qp_context ctx[2] = {};" will do the trick.

Thanks

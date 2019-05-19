Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC0227E0
	for <lists+linux-rdma@lfdr.de>; Sun, 19 May 2019 19:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfESRhW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 May 2019 13:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbfESRhV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 May 2019 13:37:21 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD3620848;
        Sun, 19 May 2019 07:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558249821;
        bh=avbSjVlOa1onK3Ef+kWNi0ULrkYIzcX6d/A4Dj7oZNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RiZRkdPagwxLPA+x8Q8DUcgAhSk2h7r4cULHdfgJFDFLXuqvgPRs1Zu5nVhRJB4VJ
         pI+OAUok6mHbTlVcw2XhcP63r0iuTWEO214fg3XPwdC+KHreyhQW/+yad2civucZwK
         ri4haI2FFaX0Thmn3d8U9WsKwoQ/egMCKr9CJxjQ=
Date:   Sun, 19 May 2019 10:10:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 4/4] RDMA/hns: Remove jiffies operation in
 disable interrupt context
Message-ID: <20190519071018.GD5822@mtr-leonro.mtl.com>
References: <1558180500-93157-1-git-send-email-oulijun@huawei.com>
 <1558180500-93157-5-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558180500-93157-5-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, May 18, 2019 at 07:55:00PM +0800, Lijun Ou wrote:
> From: Lang Cheng <chenglang@huawei.com>
>
> In some functions, the jiffies operation is unnecessary, and we
> can control delay using the xdelay function only. Especially,
> in hns_roce_v1_clear_hem, the function calls spin_lock_irqsave,
> the context disables interrupt , so we can not use jiffies and
> xsleep.

What does it mean "xdelay and xsleep"?

>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hem.c   | 21 +++++++++++----------
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 19 ++++++++++---------
>  2 files changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
> index 8e29dbb..d0eacd8 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hem.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
> @@ -376,18 +376,19 @@ static int hns_roce_set_hem(struct hns_roce_dev *hr_dev,
>
>  		bt_cmd = hr_dev->reg_base + ROCEE_BT_CMD_H_REG;
>
> -		end = msecs_to_jiffies(HW_SYNC_TIMEOUT_MSECS) + jiffies;
> -		while (1) {
> -			if (readl(bt_cmd) >> BT_CMD_SYNC_SHIFT) {
> -				if (!(time_before(jiffies, end))) {
> -					dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
> -					spin_unlock_irqrestore(lock, flags);
> -					return -EBUSY;
> -				}
> -			} else {
> +		end = HW_SYNC_TIMEOUT_MSECS;
> +		while (end) {
> +			if (!readl(bt_cmd) >> BT_CMD_SYNC_SHIFT)
>  				break;
> -			}
> +
>  			mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
> +			end -= HW_SYNC_SLEEP_TIME_INTERVAL;
> +		}
> +
> +		if (end <= 0) {

end is unsigned and can't be negative.

> +			dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
> +			spin_unlock_irqrestore(lock, flags);
> +			return -EBUSY;
>  		}
>
>  		bt_cmd_l = (u32)bt_ba;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> index 722134f..d82a832 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> @@ -965,8 +965,7 @@ static int hns_roce_v1_recreate_lp_qp(struct hns_roce_dev *hr_dev)
>  	struct hns_roce_free_mr *free_mr;
>  	struct hns_roce_v1_priv *priv;
>  	struct completion comp;
> -	unsigned long end =
> -	  msecs_to_jiffies(HNS_ROCE_V1_RECREATE_LP_QP_TIMEOUT_MSECS) + jiffies;
> +	unsigned long end = HNS_ROCE_V1_RECREATE_LP_QP_TIMEOUT_MSECS;
>
>  	priv = (struct hns_roce_v1_priv *)hr_dev->priv;
>  	free_mr = &priv->free_mr;
> @@ -986,10 +985,11 @@ static int hns_roce_v1_recreate_lp_qp(struct hns_roce_dev *hr_dev)
>
>  	queue_work(free_mr->free_mr_wq, &(lp_qp_work->work));
>
> -	while (time_before_eq(jiffies, end)) {
> +	while (end) {
>  		if (try_wait_for_completion(&comp))
>  			return 0;
>  		msleep(HNS_ROCE_V1_RECREATE_LP_QP_WAIT_VALUE);
> +		end -= HNS_ROCE_V1_RECREATE_LP_QP_WAIT_VALUE;
>  	}
>
>  	lp_qp_work->comp_flag = 0;
> @@ -1103,8 +1103,7 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
>  	struct hns_roce_free_mr *free_mr;
>  	struct hns_roce_v1_priv *priv;
>  	struct completion comp;
> -	unsigned long end =
> -		msecs_to_jiffies(HNS_ROCE_V1_FREE_MR_TIMEOUT_MSECS) + jiffies;
> +	unsigned long end = HNS_ROCE_V1_FREE_MR_TIMEOUT_MSECS ;
>  	unsigned long start = jiffies;
>  	int npages;
>  	int ret = 0;
> @@ -1134,10 +1133,11 @@ static int hns_roce_v1_dereg_mr(struct hns_roce_dev *hr_dev,
>
>  	queue_work(free_mr->free_mr_wq, &(mr_work->work));
>
> -	while (time_before_eq(jiffies, end)) {
> +	while (end) {
>  		if (try_wait_for_completion(&comp))
>  			goto free_mr;
>  		msleep(HNS_ROCE_V1_FREE_MR_WAIT_VALUE);
> +		end -= HNS_ROCE_V1_FREE_MR_WAIT_VALUE;
>  	}
>
>  	mr_work->comp_flag = 0;
> @@ -2464,10 +2464,10 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
>
>  	bt_cmd = hr_dev->reg_base + ROCEE_BT_CMD_H_REG;
>
> -	end = msecs_to_jiffies(HW_SYNC_TIMEOUT_MSECS) + jiffies;
> +	end = HW_SYNC_TIMEOUT_MSECS;
>  	while (1) {
>  		if (readl(bt_cmd) >> BT_CMD_SYNC_SHIFT) {
> -			if (!(time_before(jiffies, end))) {
> +			if (end < 0) {
>  				dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
>  				spin_unlock_irqrestore(&hr_dev->bt_cmd_lock,
>  					flags);
> @@ -2476,7 +2476,8 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
>  		} else {
>  			break;
>  		}
> -		msleep(HW_SYNC_SLEEP_TIME_INTERVAL);
> +		mdelay(HW_SYNC_SLEEP_TIME_INTERVAL);
> +		end -= HW_SYNC_SLEEP_TIME_INTERVAL;
>  	}
>
>  	bt_cmd_val[0] = (__le32)bt_ba;
> --
> 1.9.1
>

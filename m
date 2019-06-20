Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E924CD84
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 14:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfFTMQW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 08:16:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726551AbfFTMQW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 08:16:22 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1DE855016E2E8C01FAFB;
        Thu, 20 Jun 2019 20:16:20 +0800 (CST)
Received: from [127.0.0.1] (10.61.25.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Jun 2019
 20:16:09 +0800
Subject: Re: [PATCH rdma-next] RDMa/hns: Don't stuck in endless timeout loop
To:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Lang Cheng <chenglang@huawei.com>
References: <20190616120558.12960-1-leon@kernel.org>
From:   oulijun <oulijun@huawei.com>
Message-ID: <fe94b648-4b4f-c5a5-79c1-852d4281156a@huawei.com>
Date:   Thu, 20 Jun 2019 20:16:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20190616120558.12960-1-leon@kernel.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ÔÚ 2019/6/16 20:05, Leon Romanovsky Ð´µÀ:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> The "end" variable is declared as unsigned and can't be negative, it
> leads to the situation where timeout limit is not honored, so let's
> convert logic to ensure that loop is bounded.
>
> drivers/infiniband/hw/hns/hns_roce_hw_v1.c: In function _hns_roce_v1_clear_hem_:
> drivers/infiniband/hw/hns/hns_roce_hw_v1.c:2471:12: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>  2471 |    if (end < 0) {
>       |            ^
>
> Fixes: 669cefb654cb ("RDMA/hns: Remove jiffies operation in disable interrupt context")
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hem.h   | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
> index d9d668992e49..258682cbe532 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hem.h
> +++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
> @@ -34,8 +34,8 @@
>  #ifndef _HNS_ROCE_HEM_H
>  #define _HNS_ROCE_HEM_H
>  
> -#define HW_SYNC_TIMEOUT_MSECS		500
>  #define HW_SYNC_SLEEP_TIME_INTERVAL	20
> +#define HW_SYNC_TIMEOUT_MSECS           (25 * HW_SYNC_SLEEP_TIME_INTERVAL)
>  #define BT_CMD_SYNC_SHIFT		31
>  
>  enum {
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> index cc1ea69d0f29..056a6873df7a 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> @@ -2468,7 +2468,7 @@ static int hns_roce_v1_clear_hem(struct hns_roce_dev *hr_dev,
>  	end = HW_SYNC_TIMEOUT_MSECS;
>  	while (1) {
>  		if (readl(bt_cmd) >> BT_CMD_SYNC_SHIFT) {
> -			if (end < 0) {
> +			if (!end) {
>  				dev_err(dev, "Write bt_cmd err,hw_sync is not zero.\n");
>  				spin_unlock_irqrestore(&hr_dev->bt_cmd_lock,
>  					flags);

Yes, thanks.



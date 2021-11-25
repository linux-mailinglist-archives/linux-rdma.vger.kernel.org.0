Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A86345DADE
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 14:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355270AbhKYNXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 08:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346348AbhKYNVL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 08:21:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 084CA60F94;
        Thu, 25 Nov 2021 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637846280;
        bh=qXR36Faqk6oclDY+bYnoHb34/sULFOA/5DDgs878tuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3MuBP89raAM3VYUNmsYpJtZyDnqzFR3/Bn+wN8xCX4QB0lo1tD0yVNNArwa64Pvq
         WacWb/sMjwm43qPUkGHz3tfez3x8jRLhqCPj0a9fQotZ4QyzJS7d8Fz3tbPN2GObUe
         pG37T9roIQwRMKELlf3l0I/K8v5TcsN+OlwCYgbEAZ1KxBAvuD4+CxJLY1XZPsXfKk
         phQnHTWbeUboQpxSbJJa062wZOlweyOWojoDOgCldmrubNoMK/MZvxkxH8hlFVfsyU
         wd8Vrwx1xjVt2ddqelITAwfiNhLiZhVdw5/U9ovCRLEsbOh9uuGjPQpfmJjUMZP7Xs
         OQoUOfngM8EoA==
Date:   Thu, 25 Nov 2021 15:17:52 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-rc] RDMA/hns: Fix the error of destroying resources
 in hw reseting phase
Message-ID: <YZ+NACnl23E8W7rB@unreal>
References: <20211123142402.26936-1-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123142402.26936-1-liangwenpeng@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 23, 2021 at 10:24:02PM +0800, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> When hns_roce_v2_destroy_qp() is called, the brief calling process of the
> driver is as follows:
> 
> ......
> hns_roce_v2_destroy_qp
> hns_roce_v2_qp_modify
> 	   hns_roce_cmd_mbox
> hns_roce_qp_destroy
> 
> If hns_roce_cmd_mbox() detects that the hardware is being reset during
> the execution of the hns_roce_cmd_mbox(), the driver will not be able
> to get the return value from the hardware (the firmware cannot respond
> to the driver's mailbox during the hardware reset phase). The driver
> needs to wait for the hardware reset to complete before continuing to
> execute hns_roce_qp_destroy(), otherwise it may happen that the driver
> releases the resources but the hardware is still accessing. In order to
> fix this problem, HNS RoCE needs to add a piece of code to wait for the
> hardware reset to complete.
> 
> The original interface get_hw_reset_stat() is the instantaneous state
> of the hardware reset, which cannot accurately reflect whether the
> hardware reset is completed, so it needs to be replaced with the
> ae_dev_reset_cnt interface.
> 
> The sign that the hardware reset is complete is that the return value
> of the ae_dev_reset_cnt interface is greater than the original value
> reset_cnt recorded by the driver.
> 
> Fixes: 6a04aed6afae ("RDMA/hns: Fix the chip hanging caused by sending mailbox&CMQ during reset")
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

And what about the other fix?
Should we take both of them or only one?
https://lore.kernel.org/all/20211123084809.37318-1-liangwenpeng@huawei.com

Thanks

> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index ae14329c619c..bbfa1332dedc 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -33,6 +33,7 @@
>  #include <linux/acpi.h>
>  #include <linux/etherdevice.h>
>  #include <linux/interrupt.h>
> +#include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <net/addrconf.h>
> @@ -1050,9 +1051,14 @@ static u32 hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
>  					unsigned long instance_stage,
>  					unsigned long reset_stage)
>  {
> +#define HW_RESET_TIMEOUT_US 1000000
> +#define HW_RESET_SLEEP_US 1000
> +
>  	struct hns_roce_v2_priv *priv = hr_dev->priv;
>  	struct hnae3_handle *handle = priv->handle;
>  	const struct hnae3_ae_ops *ops = handle->ae_algo->ops;
> +	unsigned long val;
> +	int ret;
>  
>  	/* When hardware reset is detected, we should stop sending mailbox&cmq&
>  	 * doorbell to hardware. If now in .init_instance() function, we should
> @@ -1064,7 +1070,11 @@ static u32 hns_roce_v2_cmd_hw_resetting(struct hns_roce_dev *hr_dev,
>  	 * again.
>  	 */
>  	hr_dev->dis_db = true;
> -	if (!ops->get_hw_reset_stat(handle))
> +
> +	ret = read_poll_timeout(ops->ae_dev_reset_cnt, val,
> +				val > hr_dev->reset_cnt, HW_RESET_SLEEP_US,
> +				HW_RESET_TIMEOUT_US, false, handle);
> +	if (!ret)
>  		hr_dev->is_reset = true;
>  
>  	if (!hr_dev->is_reset || reset_stage == HNS_ROCE_STATE_RST_INIT ||
> -- 
> 2.33.0
> 

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6E29811D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 19:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfHURTc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 13:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfHURTc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 13:19:32 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87AE022CF7;
        Wed, 21 Aug 2019 17:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566407970;
        bh=71ENEsP+F98XdHBG8f3fjIBNDWVMQhpPuvMiBO7waD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJnSP3Vz4gGMQryweLWX/mqlFhxoeIcWElLTMd0DHYcUiBWxGNAWA8KiafpwXn//U
         eDAfNiNnpo/15wqW2VajS/+c+QbQRsgE3L2IqmGiW4C30TF6QQUAttY7NJUnY8DlBc
         vmbzXjHbyVCgxiAH1bfsooF8hts0B1qyQn+7wMIU=
Date:   Wed, 21 Aug 2019 20:19:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 1/9] RDMA/hns: Refactor cmd init and mode
 selection for hip08
Message-ID: <20190821171928.GB27741@mtr-leonro.mtl.com>
References: <1566393276-42555-1-git-send-email-oulijun@huawei.com>
 <1566393276-42555-2-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566393276-42555-2-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 09:14:28PM +0800, Lijun Ou wrote:
> From: Yixian Liu <liuyixian@huawei.com>
>
> This patch refactor the initialization of cmd, and also for the cmd
> mode selection on event and poll mode.
>
> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
> Signed-off-by: Lang Chen <chenglang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c  | 14 ++++----------
>  drivers/infiniband/hw/hns/hns_roce_main.c | 18 ++++++++----------
>  2 files changed, 12 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
> index ade26fa..547002f 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
> @@ -251,23 +251,17 @@ int hns_roce_cmd_use_events(struct hns_roce_dev *hr_dev)
>  	hr_cmd->token_mask = CMD_TOKEN_MASK;
>  	hr_cmd->use_events = 1;
>
> -	down(&hr_cmd->poll_sem);
> -
>  	return 0;
>  }
>
>  void hns_roce_cmd_use_polling(struct hns_roce_dev *hr_dev)
>  {
>  	struct hns_roce_cmdq *hr_cmd = &hr_dev->cmd;
> -	int i;
> -
> -	hr_cmd->use_events = 0;
>
> -	for (i = 0; i < hr_cmd->max_cmds; ++i)
> -		down(&hr_cmd->event_sem);
> -
> -	kfree(hr_cmd->context);
> -	up(&hr_cmd->poll_sem);
> +	if (hr_cmd->use_events) {

Ensure that hr_cmd->context == NULL in places where it shouldn't be
kfreed and remove this "if (hr_cmd->use_events)".

Thanks
.


> +		kfree(hr_cmd->context);
> +		hr_cmd->use_events = 0;
> +	}
>  }
>
>  struct hns_roce_cmd_mailbox
> diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
> index 1b757cc..f3b2f67 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_main.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_main.c
> @@ -902,6 +902,7 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
>  		goto error_failed_cmd_init;
>  	}
>
> +	/* EQ depends on poll mode, event mode depends on EQ */
>  	ret = hr_dev->hw->init_eq(hr_dev);
>  	if (ret) {
>  		dev_err(dev, "eq init failed!\n");
> @@ -911,8 +912,9 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
>  	if (hr_dev->cmd_mod) {
>  		ret = hns_roce_cmd_use_events(hr_dev);
>  		if (ret) {
> -			dev_err(dev, "Switch to event-driven cmd failed!\n");
> -			goto error_failed_use_event;
> +			dev_warn(dev,
> +				 "Cmd event  mode failed, set back to poll!\n");
> +			hns_roce_cmd_use_polling(hr_dev);
>  		}
>  	}
>
> @@ -928,12 +930,10 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
>  		goto error_failed_setup_hca;
>  	}
>
> -	if (hr_dev->hw->hw_init) {
> -		ret = hr_dev->hw->hw_init(hr_dev);
> -		if (ret) {
> -			dev_err(dev, "hw_init failed!\n");
> -			goto error_failed_engine_init;
> -		}
> +	ret = hr_dev->hw->hw_init(hr_dev);
> +	if (ret) {
> +		dev_err(dev, "hw_init failed!\n");
> +		goto error_failed_engine_init;
>  	}
>
>  	ret = hns_roce_register_device(hr_dev);
> @@ -955,8 +955,6 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
>  error_failed_init_hem:
>  	if (hr_dev->cmd_mod)
>  		hns_roce_cmd_use_polling(hr_dev);
> -
> -error_failed_use_event:
>  	hr_dev->hw->cleanup_eq(hr_dev);
>
>  error_failed_eq_table:
> --
> 2.8.1
>

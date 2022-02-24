Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AE14C2D07
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 14:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbiBXNbP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Feb 2022 08:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBXNbO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Feb 2022 08:31:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB3B7C7D
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 05:30:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEFD861AB2
        for <linux-rdma@vger.kernel.org>; Thu, 24 Feb 2022 13:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFF0C340E9;
        Thu, 24 Feb 2022 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645709444;
        bh=9JwfqZHMMDyDccNaAShT3VKmYTTPcK00L2toDntvQo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DBS6KKB5G53HChrlTDPSdgEfU7U+V6+z7SIN2xZOsFxiVdZ8Ek3nKd87/j6vYwD0z
         ht/3Zs2LOVZoaD5wdIM82dRfuL7pLzOV+01MwbJgD3W3MMwbQ8fPN4yN60jmFSthjd
         EWKxad7BaTqn+RzYd/IQo3J0OiAbS6gV73Mc3tEQa7jWFpr3zZq8Xloc2NFAq/oWh6
         KXplCqIrbcbiCiuaVZL9XvE2UOXLyglzDqSl2u4WYX5xWwwQgjtO+S91Gyanrmcc/p
         FGRpxANM9GTibJhN7LzmfDH1SQYdHds38ElOogXZMDSuvM7QBdPqaqn2uCbvKg7p2W
         rCWBh2f5cCLXg==
Date:   Thu, 24 Feb 2022 15:30:39 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-next 5/8] RDMA/hns: Refactor mailbox functions
Message-ID: <YheIf4MjkCSrm0XS@unreal>
References: <20220218110519.37375-1-liangwenpeng@huawei.com>
 <20220218110519.37375-6-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218110519.37375-6-liangwenpeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 18, 2022 at 07:05:16PM +0800, Wenpeng Liang wrote:
> From: Chengchang Tang <tangchengchang@huawei.com>
> 
> The current mailbox functions have too many parameters, making the code
> difficult to maintain. So construct a new structure mbox_msg to pass the
> information needed by mailbox.
> 
> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_cmd.c      |  84 +++++++------
>  drivers/infiniband/hw/hns/hns_roce_cmd.h      |   2 +-
>  drivers/infiniband/hw/hns/hns_roce_cq.c       |   9 +-
>  drivers/infiniband/hw/hns/hns_roce_device.h   |  14 ++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 111 +++++++++---------
>  .../infiniband/hw/hns/hns_roce_hw_v2_dfx.c    |   4 +-
>  drivers/infiniband/hw/hns/hns_roce_mr.c       |  13 +-
>  drivers/infiniband/hw/hns/hns_roce_srq.c      |   6 +-
>  8 files changed, 133 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
> index df11acd8030e..0d4766cf6e24 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
> @@ -38,42 +38,60 @@
>  #define CMD_POLL_TOKEN 0xffff
>  #define CMD_MAX_NUM 32
>  
> -static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev, u64 in_param,
> -				     u64 out_param, u32 in_modifier, u8 op,
> -				     u16 token, int event)
> +static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev,
> +				     struct hns_roce_mbox_msg *mbox_msg)
>  {
> -	return hr_dev->hw->post_mbox(hr_dev, in_param, out_param, in_modifier,
> -				     op, token, event);
> +	return hr_dev->hw->post_mbox(hr_dev, mbox_msg);
> +}
> +
> +static void hns_roce_set_basic_mbox_msg(struct hns_roce_mbox_msg *mbox_msg,
> +					u64 in_param, u64 out_param, u8 cmd,
> +					unsigned long tag)
> +{
> +	mbox_msg->in_param = in_param;
> +	mbox_msg->out_param = out_param;
> +	mbox_msg->cmd = cmd;
> +	mbox_msg->tag = tag;
> +}
> +
> +static void hns_roce_set_poll_mbox_msg(struct hns_roce_mbox_msg *mbox_msg)
> +{
> +	mbox_msg->event_en = 0;
> +	mbox_msg->token = CMD_POLL_TOKEN;
> +}
> +
> +static void hns_roce_set_event_mbox_msg(struct hns_roce_mbox_msg *mbox_msg,
> +					struct hns_roce_cmd_context *context)
> +{
> +	mbox_msg->event_en = 1;
> +	mbox_msg->token = context->token;
>  }

I don't see too much value in three functions above. They are called exactly once.

Thanks

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209B07508C9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGLMxm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 08:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjGLMxl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 08:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175A61736;
        Wed, 12 Jul 2023 05:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9397617D4;
        Wed, 12 Jul 2023 12:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9007DC433C8;
        Wed, 12 Jul 2023 12:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689166420;
        bh=Pg9A9mnKvw4Wu1iALCgZhjUHVKyjzHiVGJADCkOOGqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNSbqQ3EyIHIQlbDOGigdsrxIdKVeS8uyfuNt3oNBeuJ17HcMg6ix01i9nFtSKD7p
         O6AbAEQRzeTNYwa1LbVwWyOzgNE27RPzPGLylryD2f4nJSozm2LDrCc7kgg/nyebqu
         ENAp05tbpyt4yMfgL4ybzpUiP5qujyAKcpFBi26KCwQ94zXHTkgCI+Npo3QWjf6C28
         /fupsGakza9DDeE5gyzh0cZcnrKL/uR1XRSyPNbu4nOW5yVwlDRJvw5yqaOHYbcepp
         rddfo8coXynvaELp/GNWHOsyePi58zhM4BUNQ7r3F/23IVEwDc8xamayGbORnhIw+t
         SvnhZytB0CvRg==
Date:   Wed, 12 Jul 2023 15:53:36 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Junxian Huang <huangjunxian6@hisilicon.com>
Cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc 3/3] RDMA/hns: Add check and adjust for function
 resource values
Message-ID: <20230712125336.GE41919@unreal>
References: <20230712060033.15961-1-huangjunxian6@hisilicon.com>
 <20230712060033.15961-4-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712060033.15961-4-huangjunxian6@hisilicon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 12, 2023 at 02:00:33PM +0800, Junxian Huang wrote:
> Currently, RoCE driver gets function resource values from firmware
> without validity check. As these resources are mostly related to memory,
> an invalid value may lead to serious consequence such as kernel panic.
> 
> This patch adds check for these resource values and adjusts the invalid
> ones.
> 
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 116 ++++++++++++++++++++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  37 +++++++
>  2 files changed, 149 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index c4b92d8bd98a..dae0e6959fa0 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -1650,6 +1650,98 @@ static int hns_roce_config_global_param(struct hns_roce_dev *hr_dev)
>  	return hns_roce_cmq_send(hr_dev, &desc, 1);
>  }

<...>

> +static inline bool check_res_is_supported(struct hns_roce_dev *hr_dev,
> +					  struct hns_roce_bt_num *bt_num_entry)
> +{

<...>

> +static inline void adjust_eqc_bt_num(struct hns_roce_caps *caps,
> +				     u16 *invalid_flag)
> +{

No inline functions in *.c files.

Thanks

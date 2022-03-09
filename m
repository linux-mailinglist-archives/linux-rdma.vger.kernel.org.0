Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87574D2961
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Mar 2022 08:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiCIHVI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 02:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiCIHVH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 02:21:07 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5377E105A9C;
        Tue,  8 Mar 2022 23:20:09 -0800 (PST)
Message-ID: <34dbb6e0-e278-a78c-cddd-b9484b1bf5e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646810407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okH9BX0M/dnwpm23ye/VaVE4Ql3FIN8z7dfUJvXGpow=;
        b=A/Au1hLfKvxQP1g+/q7dwU6JX4jJmRsCxgYpHUW2JtFGaaGZcYmjbcR53kANDPwadV6oWT
        YrDdJ4BE9V+Aljtl3WHU7YB4PJ6NcWP28fPm3lwuG7qXxVa68vbSWjEyV++uIJMHyrzrxl
        yIeNCB/9Ae4XqBaM1JoQ23bB8xTnbmY=
Date:   Wed, 9 Mar 2022 09:20:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH for-next 3/9] RDMA/efa: get rid of create_user_ah
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>, jgg@nvidia.com,
        selvin.xavier@broadcom.com, galpress@amazon.com, sleybo@amazon.com,
        liangwenpeng@huawei.com, liweihang@huawei.com,
        mustafa.ismail@intel.com, shiraz.saleem@intel.com,
        leonro@nvidia.com, dennis.dalessandro@cornelisnetworks.com,
        mike.marciniszyn@cornelisnetworks.com, zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220308143705.3403496-1-yajun.deng@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Gal Pressman <gal.pressman@linux.dev>
In-Reply-To: <20220308143705.3403496-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 08/03/2022 16:37, Yajun Deng wrote:
> There is no create_user_ah in ib_device_ops, remove it.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  drivers/infiniband/hw/efa/efa_main.c  | 2 +-
>  drivers/infiniband/hw/efa/efa_verbs.c | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> index 94b94cca4870..b2f3832cd305 100644
> --- a/drivers/infiniband/hw/efa/efa_main.c
> +++ b/drivers/infiniband/hw/efa/efa_main.c
> @@ -361,7 +361,7 @@ static const struct ib_device_ops efa_dev_ops = {
>  	.alloc_ucontext = efa_alloc_ucontext,
>  	.create_cq = efa_create_cq,
>  	.create_qp = efa_create_qp,
> -	.create_user_ah = efa_create_ah,
> +	.create_ah = efa_create_ah,
>  	.dealloc_pd = efa_dealloc_pd,
>  	.dealloc_ucontext = efa_dealloc_ucontext,
>  	.dereg_mr = efa_dereg_mr,
> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> index ecfe70eb5efb..44269eb18780 100644
> --- a/drivers/infiniband/hw/efa/efa_verbs.c
> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> @@ -1959,6 +1959,11 @@ int efa_create_ah(struct ib_ah *ibah,
>  	struct efa_ah *ah = to_eah(ibah);
>  	int err;
>  
> +	if (!udata) {
> +		err = -EOPNOTSUPP;
> +		goto err_out;
> +	}
> +

This part is not needed, kverbs flows are blocked for EFA.

Thanks

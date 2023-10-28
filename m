Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A107DA513
	for <lists+linux-rdma@lfdr.de>; Sat, 28 Oct 2023 05:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbjJ1Dw6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 23:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjJ1Dw6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 23:52:58 -0400
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4467B8
        for <linux-rdma@vger.kernel.org>; Fri, 27 Oct 2023 20:52:54 -0700 (PDT)
Message-ID: <5bbc6456-160d-4566-87ca-13984d795c6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698465172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlpoQS6xjBBJSN7AYIHJNknf8fUOyG0wQHib+hsFjCI=;
        b=ZoL76mWlw4HhbNiKEnFYfeDNB4r6i01HxBLgxXkqiyG3R2+s3u+ysVkUFc+FDKPcN4kzd/
        hf4qrh9Fvtzwwgu5AMVXTtmz0kmXS7CvMAd04eV+L4JE9j0SwfN6BFVJ+MpjU3BjYkJWjT
        9dlZgcIMBEO72atR0oaMaeG/4djrGrI=
Date:   Sat, 28 Oct 2023 11:52:40 +0800
MIME-Version: 1.0
Subject: Re: [PATCH RFC 2/2] RDMA/rxe: set RXE_PAGE_SIZE_CAP to PAGE_SIZE
To:     Li Zhijian <lizhijian@fujitsu.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        matsuda-daisuke@fujitsu.com, bvanassche@acm.org
References: <20231027054154.2935054-1-lizhijian@fujitsu.com>
 <20231027054154.2935054-2-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231027054154.2935054-2-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/10/27 13:41, Li Zhijian 写道:
> RXE_PAGE_SIZE_CAP means the MR page size supported by RXE. However
> in current RXE implementation, only PAGE_SIZE MR works well.
> So change it to PAGE_SIZE only.
> 
> ULPs such as SRP calculating the page size according to this attribute get
> worked again with this change.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Acked-by: Zhu Yanjun <zyjzyj2000@gmail.com>

Thanks a lot.
Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> index d2f57ead78ad..b1cf1e1c0ce1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> @@ -38,7 +38,7 @@ static inline enum ib_mtu eth_mtu_int_to_enum(int mtu)
>   /* default/initial rxe device parameter settings */
>   enum rxe_device_param {
>   	RXE_MAX_MR_SIZE			= -1ull,
> -	RXE_PAGE_SIZE_CAP		= 0xfffff000,
> +	RXE_PAGE_SIZE_CAP		= PAGE_SIZE,
>   	RXE_MAX_QP_WR			= DEFAULT_MAX_VALUE,
>   	RXE_DEVICE_CAP_FLAGS		= IB_DEVICE_BAD_PKEY_CNTR
>   					| IB_DEVICE_BAD_QKEY_CNTR


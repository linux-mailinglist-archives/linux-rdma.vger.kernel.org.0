Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E1C5A28F8
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Aug 2022 16:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbiHZN7t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Aug 2022 09:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344357AbiHZN7q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Aug 2022 09:59:46 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B209B14F3
        for <linux-rdma@vger.kernel.org>; Fri, 26 Aug 2022 06:59:43 -0700 (PDT)
Message-ID: <b02722ae-0eb9-0ba2-ea46-a15ec35426a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661522381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KII0eXHJdgQ6xFt6EjYln4Zvh0hx8w78r5sT10aIMTk=;
        b=EM80DgeqTqtihsXCuMyfSQyWA9b4MJBt1WtHBTu2M7v178Y96XtB6Yh6OXAsb46JcPQ2i8
        oNOwxBJh5gIMt3+en5CNks4MC/ZMTXlbo0kwyHbZF1ad/Nx7CIH57uDGj2vgXUBKB+gKYt
        FWN2tz0XlcV324qTfkMc7bqJ+fEWnLA=
Date:   Fri, 26 Aug 2022 21:59:28 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Remove an unused member from struct rxe_mr
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-rdma@vger.kernel.org, rpearsonhpe@gmail.com,
        lizhijian@fujitsu.com
References: <20220826093453.854991-1-matsuda-daisuke@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220826093453.854991-1-matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/8/26 17:34, Daisuke Matsuda 写道:
> Commit 1e75550648da ("Revert "RDMA/rxe: Create duplicate mapping tables for
> FMRs"") brought back the member 'va' to struct rxe_mr. However, it is
> actually used by nobody and thus can be removed.
> 

Missing Fixes?

Zhu Yanjun

> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 1 -
>   drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
>   3 files changed, 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 850b80f5ad8b..814116ec4778 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -180,7 +180,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>   	mr->access = access;
>   	mr->length = length;
>   	mr->iova = iova;
> -	mr->va = start;
>   	mr->offset = ib_umem_offset(umem);
>   	mr->state = RXE_MR_STATE_VALID;
>   	mr->type = IB_MR_TYPE_USER;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index e264cf69bf55..9ebe9decad34 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1007,7 +1007,6 @@ static int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg,
>   
>   	n = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, rxe_set_page);
>   
> -	mr->va = ibmr->iova;
>   	mr->iova = ibmr->iova;
>   	mr->length = ibmr->length;
>   	mr->page_shift = ilog2(ibmr->page_size);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 96af3e054f4d..a51819d0c345 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -305,7 +305,6 @@ struct rxe_mr {
>   	u32			rkey;
>   	enum rxe_mr_state	state;
>   	enum ib_mr_type		type;
> -	u64			va;
>   	u64			iova;
>   	size_t			length;
>   	u32			offset;


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D068F5AA631
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Sep 2022 05:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiIBDRc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Sep 2022 23:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiIBDR3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Sep 2022 23:17:29 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03E2A99F9
        for <linux-rdma@vger.kernel.org>; Thu,  1 Sep 2022 20:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662088631; i=@fujitsu.com;
        bh=MAfOUAdmwfxfjVrpIQ2an9sG2XiIKicmx0r9EbJl6Ms=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=FQfap/IpDia38fzr6iTmpL1SA/UFf1Qo2kmZB96u31YF2Ah/f4tvRRuKQvViG8s/J
         dE3WUqPc1yZa2Os3rzsR7Q6Vdq5hJBKCeH+2wXT8R0KlbIIW2Lr7JC5QE5WhZmzQZf
         eObcMajOmvEwFmnEtig8DrGY11wzbvaRsOK+tdLuVhMc0JHPrByvBj9fEsIzsMgDhx
         cCBU9rms8MSDQGM7bb2Fbqb6bialQO6OykewjWZ2cMBqz3AeN5InbmrxW+MJ25MBUq
         TAcqR3Bwxu/FdmitZwRAWMMSK7REk7rcWzuBJTw8qmEIpmps4tZo5yq6TX/yBwFcxZ
         Ae6lWEXiD9qkQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRWlGSWpSXmKPExsViZ8ORpLu1VDD
  Z4OIUFYsr//YwWrQsusJmMeXXUmaLZ4d6WSy+TJ3GbHH+WD+7A5vHzll32T127Wpk99i0qpPN
  o7f5HZvH501yAaxRrJl5SfkVCawZx/bMZSxYZlax+9Mj9gbG3VpdjFwcQgIbGSWenD3HDOEsY
  ZJoebyGCcLZyijxoq0XyOHk4BWwk3i77jEjiM0ioCIxe/8rNoi4oMTJmU9YQGxRgQiJh48mgd
  nCAr4S6/tnsoPYzALiEreezAcbKiIwhVFiWdMRsKFCApYSpze8BBvEJqAhca/lJtACDg5OASu
  J73esIXotJBa/OQg1R15i+9s5zCC2hICixJHOvywQdoVE4/RDTBC2msTVc5uYJzAKzUJy3iwk
  Z8xCMnYWkrELGFlWMVonFWWmZ5TkJmbm6BoaGOgaGprqGlvoGhka6SVW6SbqpZbqlqcWl+gCu
  eXFeqnFxXrFlbnJOSl6eaklmxiBkZZSrHZlB+OeVT/1DjFKcjApifIy/RFIFuJLyk+pzEgszo
  gvKs1JLT7EKMPBoSTB+71YMFlIsCg1PbUiLTMHGPUwaQkOHiURXq4ioDRvcUFibnFmOkTqFKM
  ux9TZ//YzC7Hk5eelSonzTgWZIQBSlFGaBzcCloAuMcpKCfMyMjAwCPEUpBblZpagyr9iFOdg
  VBLmVQNZxZOZVwK36RXQEUxAR0yfyQ9yREkiQkqqgclT861LpUfRNJOW1w9756Wa+i7rbPtor
  d7zt5fn+ZQ3U+Ok/TvVTI6H9Bh5PQrd1x7Xq1f6/lJV9KaPh62X1hyf6NXfoS1TEZE1xeZn07
  QKwwMzTvb5sLDJrNnU0/je5WjrxEC2PSofIz7wR5vfke+2iC5j+PbkrcX3LuU2HX29Her21Ze
  jdXbKvFZb/Dw5uaYpnilu5y+mlZVTdZZv8Omt1317byOrhHrPORWFHpnrivMk5h+rdtjrc3aV
  qseu28+Vlhtduiay/sPmcvuP/4umZWY8llgvvXvPthtZwqxHhbbOrLNN+BS0I1Au6suZm8cXy
  MQU9PWYbNOYF1Sovdu2Kit3Qi3L5a8sLgVZSizFGYmGWsxFxYkATIR3zrsDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-5.tower-548.messagelabs.com!1662088629!7399!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4846 invoked from network); 2 Sep 2022 03:17:09 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-5.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Sep 2022 03:17:09 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id 44E761AD;
        Fri,  2 Sep 2022 04:17:09 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 39A341AB;
        Fri,  2 Sep 2022 04:17:09 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 2 Sep 2022 04:17:06 +0100
Message-ID: <ea5f6da8-9da7-07ed-6bf0-be314df9a3ff@fujitsu.com>
Date:   Fri, 2 Sep 2022 11:16:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-rc v6] RDMA/rxe: Fix pd ref counting in rxe mr verbs.
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>, <leon@kernel.org>,
        <jgg@nvidia.com>, <zyjzyj2000@gmail.com>, <jhack@hpe.com>,
        <linux-rdma@vger.kernel.org>
References: <20220901200426.3236-1-rpearsonhpe@gmail.com>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <20220901200426.3236-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 02/09/2022 04:04, Bob Pearson wrote:
> Move referencing pd in mr objects ahead of any possible errors
> so that it will always be set in rxe_mr_complete() to avoid
> seg faults when rxe_put(mr_pd(mr)) is called. Adjust the reference
> counts so that each call to rxe_mr_init_xxx() takes one reference.
> This reference count is dropped in rxe_mr_cleanup() in error paths
> in the reg mr verbs and the dereg mr verb. Minor white space cleanups.
>
> These errors have been seen in rxe_mr_init_user() when there isn't
> enough memory to create the mr maps. Previously the error return
> path didn't reach setting ibpd in mr->ibmr which caused a seg fault.
>
> Fixes: 364e282c4fe7e ("RDMA/rxe: Split MEM into MR and MW")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Reviewed-by Li Zhijian <lizhijian@fujitsu.com>

Thanks

> ---
> v6:
>    Separated from other patch in original series and resubmitted
>    rebased to current for-rc.
>    Renamed from "RDMA/rxe: Set pd early in mr alloc routines" to
>    "RDMA/rxe: Fix pd ref counting in rxe mr verbs"
>    Added more text to describe the change.
>    Added fixes line.
>    Simplified the patch by leaving pd code in rxe_mr.c instead of
>    moving it up to rxe_verbs.c
> v5:
>    Dropped cleanup code from patch per Li Zhijian.
>    Split up into two small patches.
> v4:
>    Added set mr->ibmr.pd back to avoid an -ENOMEM error causing
>    rxe_put(mr_pd(mr)); to seg fault in rxe_mr_cleanup() since pd
>    is not getting set in the error path.
> v3:
>    Rebased to apply to current for-next after
>    	Revert "RDMA/rxe: Create duplicate mapping tables for FMRs"
> v2:
>    Moved setting mr->umem until after checks to avoid sending
>    an ERR_PTR to ib_umem_release().
>    Cleaned up umem and map sets if errors occur in alloc mr calls.
>    Rebased to current for-next.
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 24 ++++++++++++++----------
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 27 +++++++--------------------
>   2 files changed, 21 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 850b80f5ad8b..5f4daffccb40 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -107,7 +107,9 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
>   {
>   	rxe_mr_init(access, mr);
>   
> +	rxe_get(pd);
>   	mr->ibmr.pd = &pd->ibpd;
> +
>   	mr->access = access;
>   	mr->state = RXE_MR_STATE_VALID;
>   	mr->type = IB_MR_TYPE_DMA;
> @@ -125,9 +127,12 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>   	int err;
>   	int i;
>   
> +	rxe_get(pd);
> +	mr->ibmr.pd = &pd->ibpd;
> +
>   	umem = ib_umem_get(pd->ibpd.device, start, length, access);
>   	if (IS_ERR(umem)) {
> -		pr_warn("%s: Unable to pin memory region err = %d\n",
> +		pr_debug("%s: Unable to pin memory region err = %d\n",
>   			__func__, (int)PTR_ERR(umem));
>   		err = PTR_ERR(umem);
>   		goto err_out;
> @@ -139,7 +144,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>   
>   	err = rxe_mr_alloc(mr, num_buf);
>   	if (err) {
> -		pr_warn("%s: Unable to allocate memory for map\n",
> +		pr_debug("%s: Unable to allocate memory for map\n",
>   				__func__);
>   		goto err_release_umem;
>   	}
> @@ -147,7 +152,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>   	mr->page_shift = PAGE_SHIFT;
>   	mr->page_mask = PAGE_SIZE - 1;
>   
> -	num_buf			= 0;
> +	num_buf = 0;
>   	map = mr->map;
>   	if (length > 0) {
>   		buf = map[0]->buf;
> @@ -161,7 +166,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>   
>   			vaddr = page_address(sg_page_iter_page(&sg_iter));
>   			if (!vaddr) {
> -				pr_warn("%s: Unable to get virtual address\n",
> +				pr_debug("%s: Unable to get virtual address\n",
>   						__func__);
>   				err = -ENOMEM;
>   				goto err_cleanup_map;
> @@ -175,7 +180,6 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>   		}
>   	}
>   
> -	mr->ibmr.pd = &pd->ibpd;
>   	mr->umem = umem;
>   	mr->access = access;
>   	mr->length = length;
> @@ -201,22 +205,21 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
>   {
>   	int err;
>   
> +	rxe_get(pd);
> +	mr->ibmr.pd = &pd->ibpd;
> +
>   	/* always allow remote access for FMRs */
>   	rxe_mr_init(IB_ACCESS_REMOTE, mr);
>   
>   	err = rxe_mr_alloc(mr, max_pages);
>   	if (err)
> -		goto err1;
> +		return err;
>   
> -	mr->ibmr.pd = &pd->ibpd;
>   	mr->max_buf = max_pages;
>   	mr->state = RXE_MR_STATE_FREE;
>   	mr->type = IB_MR_TYPE_MEM_REG;
>   
>   	return 0;
> -
> -err1:
> -	return err;
>   }
>   
>   static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
> @@ -630,6 +633,7 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
>   	int i;
>   
>   	rxe_put(mr_pd(mr));
> +
>   	ib_umem_release(mr->umem);
>   
>   	if (mr->map) {
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index e264cf69bf55..95df3b04babc 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -902,18 +902,15 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
>   	if (!mr)
>   		return ERR_PTR(-ENOMEM);
>   
> -	rxe_get(pd);
>   	rxe_mr_init_dma(pd, access, mr);
>   	rxe_finalize(mr);
>   
>   	return &mr->ibmr;
>   }
>   
> -static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
> -				     u64 start,
> -				     u64 length,
> -				     u64 iova,
> -				     int access, struct ib_udata *udata)
> +static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
> +				     u64 length, u64 iova, int access,
> +				     struct ib_udata *udata)
>   {
>   	int err;
>   	struct rxe_dev *rxe = to_rdev(ibpd->device);
> @@ -921,26 +918,19 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
>   	struct rxe_mr *mr;
>   
>   	mr = rxe_alloc(&rxe->mr_pool);
> -	if (!mr) {
> -		err = -ENOMEM;
> -		goto err2;
> -	}
> -
> -
> -	rxe_get(pd);
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
>   
>   	err = rxe_mr_init_user(pd, start, length, iova, access, mr);
>   	if (err)
> -		goto err3;
> +		goto err_cleanup;
>   
>   	rxe_finalize(mr);
>   
>   	return &mr->ibmr;
>   
> -err3:
> -	rxe_put(pd);
> +err_cleanup:
>   	rxe_cleanup(mr);
> -err2:
>   	return ERR_PTR(err);
>   }
>   
> @@ -961,8 +951,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>   		goto err1;
>   	}
>   
> -	rxe_get(pd);
> -
>   	err = rxe_mr_init_fast(pd, max_num_sg, mr);
>   	if (err)
>   		goto err2;
> @@ -972,7 +960,6 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>   	return &mr->ibmr;
>   
>   err2:
> -	rxe_put(pd);
>   	rxe_cleanup(mr);
>   err1:
>   	return ERR_PTR(err);
>
> base-commit: 45baad7dd98f4d83f67c86c28769d3184390e324


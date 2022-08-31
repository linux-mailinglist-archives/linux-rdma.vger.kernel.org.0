Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD2A5A7A67
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 11:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiHaJnS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 05:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiHaJnL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 05:43:11 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19050CEB30
        for <linux-rdma@vger.kernel.org>; Wed, 31 Aug 2022 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661938979; i=@fujitsu.com;
        bh=ysP2EgGPnwFqsasNcNRTQz+khm9zTHPXM7uKrrS6I9c=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=D9HnJSlmaSQRG+txoTaYUhjQSOFl1VfEF943cP7YDlpQR28O+vLeZnGo4IAs2z3Vn
         cCc16SrT+Rc3lGUZEm7+sU7EOB7ytrJG9LXiHoSSM+2Dw+35K3sWN6Y6ST3t4amHps
         /QQCUFcdUzXMZHQvEnThxn8AO7AYmydXckyIvn5wDFFppkygXvxubaaxoGkH3p77Oh
         WHee67v2V+6pOBnTS0SGEjQo+1+vAlYo2PFYNOboc8jZ4V4r+di02Lo59wioxh+CJv
         SjLcJVMHWhGGh1EdQw5b5/YAXhyV+8fT2MrVKDcDhXEcGrhEWiubdHNi7cTXVfNnl2
         WW57MklCq+wBw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRWlGSWpSXmKPExsViZ8OxWVdZlz/
  Z4Nh2Losr//YwWrQsusJm8exQL4vFkx3fGS2+TJ3GbHH+WD+7A5vHzll32T127Wpk9+htfsfm
  8XmTXABLFGtmXlJ+RQJrxqvv4gUftzFW9OzqYmpgXNDP2MXIxSEksJFRYs2ZJVDOUiaJb78uM
  0M42xklnr25A+RwcvAK2Ens2/qFBcRmEVCV2PX4DxtEXFDi5MwnYHFRgQiJh48mgdnCAn4Sb7
  /uYQKxmQXEJW49mc8EMlREYDKTxPejW5kgNnQzSkx8uQ5sEpuAhsS9lpuMIDanQKzEur5WFoh
  uC4nFbw6yQ9jyEtvfzgG7SEJAUeJI518WCLtSovXDLyhbTeLquU3MExiFZiE5cBaSQ2YhGTsL
  ydgFjCyrGC2TijLTM0pyEzNzdA0NDHQNDU11TXQtjfUSq3QT9VJLdctTi0t0DfUSy4v1UouL9
  Yorc5NzUvTyUks2MQIjLKWYJXYH49a+n3qHGCU5mJREeWu5+ZOF+JLyUyozEosz4otKc1KLDz
  HKcHAoSfC2aADlBItS01Mr0jJzgNEOk5bg4FES4Y1WAUrzFhck5hZnpkOkTjEqSonzftICSgi
  AJDJK8+DaYAnmEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3miQKTyZeSVw018BLWYCWvxw
  CTfI4pJEhJRUA9Ncts9NS5Qf89z1NH11O0n812XTmLojq/SSQ68XOGfs//FHMydoaUDUmnMHV
  ysYxaTF1dzZalzS8FdsOfvexONzkk7efN/u/GB3+PS3vIdUTWVT5rMzLDYUjYvzDUi/fH+lqP
  j/oH0XMn+K95w0K9/xKqW/ZcVER9OETTsuvVl02X1Rm+TGj24JhjFXnLJX6oXPunv7k3aC899
  /tQdEhTgnlLUlc71oSq9Jul3Q0D1xW/ks9x0q+7b9OKtoqn1n2bw3Kypfzsm9M69GVGVvFr+E
  ScTbKwk6S/9/5/28vStLKZdzThyb/PS4R7ruO9n3Zc5pPbOouik46vjudR8eCSuZWWqrVzG+q
  /FclW6SKa7EUpyRaKjFXFScCADr1tv6qwMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-19.tower-585.messagelabs.com!1661938978!143583!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 881 invoked from network); 31 Aug 2022 09:42:59 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-19.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 31 Aug 2022 09:42:59 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id B1884153;
        Wed, 31 Aug 2022 10:42:58 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 8BC88142;
        Wed, 31 Aug 2022 10:42:58 +0100 (BST)
Received: from [10.167.226.45] (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 31 Aug 2022 10:42:55 +0100
Message-ID: <4dc820b1-ac65-6380-40b5-aae34d232266@fujitsu.com>
Date:   Wed, 31 Aug 2022 17:42:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Guard mr state against race conditions
Content-Language: en-US
To:     "Pearson, Robert B" <robert.pearson2@hpe.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
        "Hack, Jenny (Ft. Collins)" <jhack@hpe.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20220802212731.2313-1-rpearsonhpe@gmail.com>
 <MW4PR84MB2307FED79C726D8C8AA1FAD7BC9D9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
From:   Li Zhijian <lizhijian@fujitsu.com>
In-Reply-To: <MW4PR84MB2307FED79C726D8C8AA1FAD7BC9D9@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
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

Bob

Is this patch still needed ? it's too big for me to begin reviewing...


On 03/08/2022 05:31, Pearson, Robert B wrote:
> Should make this 'PATCH v2 for-next'
>
> -----Original Message-----
> From: Bob Pearson <rpearsonhpe@gmail.com>
> Sent: Tuesday, August 2, 2022 4:28 PM
> To: jgg@nvidia.com; zyjzyj2000@gmail.com; lizhijian@fujitsu.com; Hack, Jenny (Ft. Collins) <jhack@hpe.com>; linux-rdma@vger.kernel.org
> Cc: Bob Pearson <rpearsonhpe@gmail.com>
> Subject: [PATCH for-next] RDMA/rxe: Guard mr state against race conditions
>
> Currently the rxe driver does not guard changes to the mr state against race conditions which can arise from races between local operations and remote invalidate operations. This patch adds a spinlock to the mr object and makes these state changes atomic. It also introduces parameters to count the number of active dma transfers and indicate that an invalidate operation is pending.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v2
>    Addressed issues raised by Jason Gunthorpe regarding preventing
>    access to memory after a local or remote invalidate operation
>    is carried out. The patch was updated to busy wait the invalidate
>    operation until recent memcpy operations complete while blocking
>    additional dma operations from starting.
> ---
>   drivers/infiniband/sw/rxe/rxe_loc.h   |   6 +-
>   drivers/infiniband/sw/rxe/rxe_mr.c    | 149 +++++++++++++------
>   drivers/infiniband/sw/rxe/rxe_req.c   |   8 +-
>   drivers/infiniband/sw/rxe/rxe_resp.c  | 200 ++++++++++++--------------  drivers/infiniband/sw/rxe/rxe_verbs.h |  10 +-
>   5 files changed, 204 insertions(+), 169 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 22f6cc31d1d6..e643950d58e8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -73,8 +73,8 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,  int copy_data(struct rxe_pd *pd, int access, struct rxe_dma_info *dma,
>   	      void *addr, int length, enum rxe_mr_copy_dir dir);  void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length); -struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> -			 enum rxe_mr_lookup_type type);
> +struct rxe_mr *rxe_get_mr(struct rxe_pd *pd, int access, u32 key); void
> +rxe_put_mr(struct rxe_mr *mr);
>   int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);  int rxe_invalidate_mr(struct rxe_qp *qp, u32 key); @@ -90,6 +90,8 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);  struct rxe_mw *rxe_lookup_mw(struct rxe_qp *qp, int access, u32 rkey);  void rxe_mw_cleanup(struct rxe_pool_elem *elem);
>   
> +int rxe_invalidate_rkey(struct rxe_qp *qp, u32 rkey);
> +
>   /* rxe_net.c */
>   struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
>   				int paylen, struct rxe_pkt_info *pkt); diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 850b80f5ad8b..bf318c9da851 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -61,7 +61,8 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
>   	mr->lkey = mr->ibmr.lkey = lkey;
>   	mr->rkey = mr->ibmr.rkey = rkey;
>   
> -	mr->state = RXE_MR_STATE_INVALID;
> +	spin_lock_init(&mr->lock);
> +
>   	mr->map_shift = ilog2(RXE_BUF_PER_MAP);  }
>   
> @@ -109,7 +110,7 @@ void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr)
>   
>   	mr->ibmr.pd = &pd->ibpd;
>   	mr->access = access;
> -	mr->state = RXE_MR_STATE_VALID;
> +	smp_store_release(&mr->state, RXE_MR_STATE_VALID);
>   	mr->type = IB_MR_TYPE_DMA;
>   }
>   
> @@ -182,7 +183,7 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>   	mr->iova = iova;
>   	mr->va = start;
>   	mr->offset = ib_umem_offset(umem);
> -	mr->state = RXE_MR_STATE_VALID;
> +	smp_store_release(&mr->state, RXE_MR_STATE_VALID);
>   	mr->type = IB_MR_TYPE_USER;
>   
>   	return 0;
> @@ -210,7 +211,7 @@ int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr)
>   
>   	mr->ibmr.pd = &pd->ibpd;
>   	mr->max_buf = max_pages;
> -	mr->state = RXE_MR_STATE_FREE;
> +	smp_store_release(&mr->state, RXE_MR_STATE_FREE);
>   	mr->type = IB_MR_TYPE_MEM_REG;
>   
>   	return 0;
> @@ -255,18 +256,22 @@ static void lookup_iova(struct rxe_mr *mr, u64 iova, int *m_out, int *n_out,
>   	}
>   }
>   
> +/**
> + * iova_to_vaddr - convert IO virtual address to kernel address
> + * @mr:
> + * @iova:
> + * @length:
> + *
> + * Context: should be called while mr is in the VALID state
> + *
> + * Returns: on success returns kernel address else NULL on error  */
>   void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)  {
>   	size_t offset;
>   	int m, n;
>   	void *addr;
>   
> -	if (mr->state != RXE_MR_STATE_VALID) {
> -		pr_warn("mr not in valid state\n");
> -		addr = NULL;
> -		goto out;
> -	}
> -
>   	if (!mr->map) {
>   		addr = (void *)(uintptr_t)iova;
>   		goto out;
> @@ -397,7 +402,7 @@ int copy_data(
>   	}
>   
>   	if (sge->length && (offset < sge->length)) {
> -		mr = lookup_mr(pd, access, sge->lkey, RXE_LOOKUP_LOCAL);
> +		mr = rxe_get_mr(pd, access, sge->lkey);
>   		if (!mr) {
>   			err = -EINVAL;
>   			goto err1;
> @@ -409,7 +414,7 @@ int copy_data(
>   
>   		if (offset >= sge->length) {
>   			if (mr) {
> -				rxe_put(mr);
> +				rxe_put_mr(mr);
>   				mr = NULL;
>   			}
>   			sge++;
> @@ -422,8 +427,7 @@ int copy_data(
>   			}
>   
>   			if (sge->length) {
> -				mr = lookup_mr(pd, access, sge->lkey,
> -					       RXE_LOOKUP_LOCAL);
> +				mr = rxe_get_mr(pd, access, sge->lkey);
>   				if (!mr) {
>   					err = -EINVAL;
>   					goto err1;
> @@ -454,13 +458,13 @@ int copy_data(
>   	dma->resid	= resid;
>   
>   	if (mr)
> -		rxe_put(mr);
> +		rxe_put_mr(mr);
>   
>   	return 0;
>   
>   err2:
>   	if (mr)
> -		rxe_put(mr);
> +		rxe_put_mr(mr);
>   err1:
>   	return err;
>   }
> @@ -498,34 +502,67 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length)
>   	return 0;
>   }
>   
> -/* (1) find the mr corresponding to lkey/rkey
> - *     depending on lookup_type
> - * (2) verify that the (qp) pd matches the mr pd
> - * (3) verify that the mr can support the requested access
> - * (4) verify that mr state is valid
> +/**
> + * rxe_get_mr - lookup an mr from pd, access and key
> + * @pd: the pd
> + * @access: access requirements
> + * @key: lkey or rkey
> + *
> + * Takes a reference to mr
> + *
> + * Returns: on success return mr else NULL
>    */
> -struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
> -			 enum rxe_mr_lookup_type type)
> +struct rxe_mr *rxe_get_mr(struct rxe_pd *pd, int access, u32 key)
>   {
>   	struct rxe_mr *mr;
>   	struct rxe_dev *rxe = to_rdev(pd->ibpd.device);
>   	int index = key >> 8;
> +	int remote = access & IB_ACCESS_REMOTE;
>   
>   	mr = rxe_pool_get_index(&rxe->mr_pool, index);
>   	if (!mr)
>   		return NULL;
>   
> -	if (unlikely((type == RXE_LOOKUP_LOCAL && mr->lkey != key) ||
> -		     (type == RXE_LOOKUP_REMOTE && mr->rkey != key) ||
> -		     mr_pd(mr) != pd || (access && !(access & mr->access)) ||
> -		     mr->state != RXE_MR_STATE_VALID)) {
> +	spin_lock_bh(&mr->lock);
> +	if ((remote && mr->rkey != key) ||
> +	    (!remote && mr->lkey != key) ||
> +	    (mr_pd(mr) != pd) ||
> +	    (access && !(access & mr->access)) ||
> +	    (mr->state != RXE_MR_STATE_VALID)) {
> +		spin_unlock_bh(&mr->lock);
>   		rxe_put(mr);
> -		mr = NULL;
> +		return NULL;
>   	}
> +	mr->num_dma++;
> +	spin_unlock_bh(&mr->lock);
>   
>   	return mr;
>   }
>   
> +/**
> + * rxe_put_mr - drop a reference to mr with an active DMA
> + * @mr: the mr
> + *
> + * Undo the effects of rxe_get_mr().
> + */
> +void rxe_put_mr(struct rxe_mr *mr)
> +{
> +	if (!mr)
> +		return;
> +
> +	spin_lock_bh(&mr->lock);
> +	if (mr->num_dma > 0) {
> +		mr->num_dma--;
> +		if (mr->invalidate && !mr->num_dma) {
> +			mr->invalidate = 0;
> +			mr->state = RXE_MR_STATE_FREE;
> +		}
> +	}
> +	spin_unlock_bh(&mr->lock);
> +
> +	rxe_put(mr);
> +}
> +
>   int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)  {
>   	struct rxe_dev *rxe = to_rdev(qp->ibqp.device); @@ -534,32 +571,46 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 key)
>   
>   	mr = rxe_pool_get_index(&rxe->mr_pool, key >> 8);
>   	if (!mr) {
> -		pr_err("%s: No MR for key %#x\n", __func__, key);
> +		pr_debug("%s: No MR for key %#x\n", __func__, key);
>   		ret = -EINVAL;
>   		goto err;
>   	}
>   
>   	if (mr->rkey ? (key != mr->rkey) : (key != mr->lkey)) {
> -		pr_err("%s: wr key (%#x) doesn't match mr key (%#x)\n",
> +		pr_debug("%s: wr key (%#x) doesn't match mr key (%#x)\n",
>   			__func__, key, (mr->rkey ? mr->rkey : mr->lkey));
>   		ret = -EINVAL;
>   		goto err_drop_ref;
>   	}
>   
>   	if (atomic_read(&mr->num_mw) > 0) {
> -		pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
> +		pr_debug("%s: Attempt to invalidate an MR while bound to MWs\n",
>   			__func__);
>   		ret = -EINVAL;
>   		goto err_drop_ref;
>   	}
>   
>   	if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
> -		pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
> +		pr_debug("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
>   		ret = -EINVAL;
>   		goto err_drop_ref;
>   	}
>   
> -	mr->state = RXE_MR_STATE_FREE;
> +	spin_lock_bh(&mr->lock);
> +	if (mr->state == RXE_MR_STATE_INVALID) {
> +		spin_unlock_bh(&mr->lock);
> +		ret = -EINVAL;
> +		goto err_drop_ref;
> +	} else if (mr->num_dma > 0) {
> +		spin_unlock_bh(&mr->lock);
> +		mr->invalidate = 1;
> +		ret = -EAGAIN;
> +		goto err_drop_ref;
> +	} else {
> +		mr->state = RXE_MR_STATE_FREE;
> +	}
> +	spin_unlock_bh(&mr->lock);
> +
>   	ret = 0;
>   
>   err_drop_ref:
> @@ -581,32 +632,32 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>   	u32 key = wqe->wr.wr.reg.key;
>   	u32 access = wqe->wr.wr.reg.access;
>   
> -	/* user can only register MR in free state */
> -	if (unlikely(mr->state != RXE_MR_STATE_FREE)) {
> -		pr_warn("%s: mr->lkey = 0x%x not free\n",
> -			__func__, mr->lkey);
> -		return -EINVAL;
> -	}
> -
>   	/* user can only register mr with qp in same protection domain */
>   	if (unlikely(qp->ibqp.pd != mr->ibmr.pd)) {
> -		pr_warn("%s: qp->pd and mr->pd don't match\n",
> +		pr_debug("%s: qp->pd and mr->pd don't match\n",
>   			__func__);
>   		return -EINVAL;
>   	}
>   
>   	/* user is only allowed to change key portion of l/rkey */
>   	if (unlikely((mr->lkey & ~0xff) != (key & ~0xff))) {
> -		pr_warn("%s: key = 0x%x has wrong index mr->lkey = 0x%x\n",
> +		pr_debug("%s: key = 0x%x has wrong index mr->lkey = 0x%x\n",
>   			__func__, key, mr->lkey);
>   		return -EINVAL;
>   	}
>   
> -	mr->access = access;
> -	mr->lkey = key;
> -	mr->rkey = (access & IB_ACCESS_REMOTE) ? key : 0;
> -	mr->iova = wqe->wr.wr.reg.mr->iova;
> -	mr->state = RXE_MR_STATE_VALID;
> +	spin_lock_bh(&mr->lock);
> +	if (mr->state == RXE_MR_STATE_FREE) {
> +		mr->access = access;
> +		mr->lkey = key;
> +		mr->rkey = (access & IB_ACCESS_REMOTE) ? key : 0;
> +		mr->iova = wqe->wr.wr.reg.mr->iova;
> +		mr->state = RXE_MR_STATE_VALID;
> +	} else {
> +		spin_unlock_bh(&mr->lock);
> +		return -EINVAL;
> +	}
> +	spin_unlock_bh(&mr->lock);
>   
>   	return 0;
>   }
> @@ -619,6 +670,10 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>   	if (atomic_read(&mr->num_mw) > 0)
>   		return -EINVAL;
>   
> +	spin_lock_bh(&mr->lock);
> +	mr->state = RXE_MR_STATE_INVALID;
> +	spin_unlock_bh(&mr->lock);
> +
>   	rxe_cleanup(mr);
>   
>   	return 0;
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 49e8f54db6f5..9a9ee2a3011c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -570,11 +570,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>   	switch (opcode) {
>   	case IB_WR_LOCAL_INV:
>   		rkey = wqe->wr.ex.invalidate_rkey;
> -		if (rkey_is_mw(rkey))
> -			ret = rxe_invalidate_mw(qp, rkey);
> -		else
> -			ret = rxe_invalidate_mr(qp, rkey);
> -
> +		ret = rxe_invalidate_rkey(qp, rkey);
>   		if (unlikely(ret)) {
>   			wqe->status = IB_WC_LOC_QP_OP_ERR;
>   			return ret;
> @@ -671,7 +667,7 @@ int rxe_requester(void *arg)
>   
>   	if (wqe->mask & WR_LOCAL_OP_MASK) {
>   		err = rxe_do_local_ops(qp, wqe);
> -		if (unlikely(err))
> +		if (err)
>   			goto err;
>   		else
>   			goto done;
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index b36ec5c4d5e0..6c10f9759ae9 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -314,7 +314,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
>   	/* don't trust user space data */
>   	if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
>   		spin_unlock_irqrestore(&srq->rq.consumer_lock, flags);
> -		pr_warn("%s: invalid num_sge in SRQ entry\n", __func__);
> +		pr_debug("%s: invalid num_sge in SRQ entry\n", __func__);
>   		return RESPST_ERR_MALFORMED_WQE;
>   	}
>   	size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge); @@ -402,6 +402,54 @@ static enum resp_states check_length(struct rxe_qp *qp,
>   	}
>   }
>   
> +static struct rxe_mr *rxe_rkey_to_mr(struct rxe_qp *qp, int access, u32
> +rkey) {
> +	struct rxe_mw *mw;
> +	struct rxe_mr *mr;
> +
> +	if (rkey_is_mw(rkey)) {
> +		mw = rxe_lookup_mw(qp, access, rkey);
> +		if (!mw)
> +			return NULL;
> +
> +		if (mw->access & IB_ZERO_BASED)
> +			qp->resp.offset = mw->addr;
> +
> +		mr = mw->mr;
> +		if (!mr) {
> +			rxe_put(mw);
> +			return NULL;
> +		}
> +
> +		spin_lock_bh(&mr->lock);
> +		if (mr->state == RXE_MR_STATE_VALID) {
> +			mr->num_dma++;
> +			rxe_get(mr);
> +		} else {
> +			spin_unlock_bh(&mr->lock);
> +			rxe_put(mw);
> +			return NULL;
> +		}
> +		spin_unlock_bh(&mr->lock);
> +
> +		rxe_put(mw);
> +	} else {
> +		mr = rxe_get_mr(qp->pd, access, rkey);
> +		if (!mr)
> +			return NULL;
> +	}
> +
> +	return mr;
> +}
> +
> +/**
> + * check_rkey - validate rdma parameters for packet
> + * @qp: the qp
> + * @pkt: packet info for the current request packet
> + *
> + * Returns: next state in responder state machine
> + *	    RESPST_EXECUTE on success else an error state
> + */
>   static enum resp_states check_rkey(struct rxe_qp *qp,
>   				   struct rxe_pkt_info *pkt)
>   {
> @@ -415,6 +463,11 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>   	enum resp_states state;
>   	int access;
>   
> +	/*
> +	 * Parse the reth header or atmeth header if present
> +	 * to extract the rkey, iova and length. Else use the
> +	 * updated parameters from the previous packet.
> +	 */
>   	if (pkt->mask & RXE_READ_OR_WRITE_MASK) {
>   		if (pkt->mask & RXE_RETH_MASK) {
>   			qp->resp.va = reth_va(pkt);
> @@ -438,46 +491,20 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>   	/* A zero-byte op is not required to set an addr or rkey. */
>   	if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
>   	    (pkt->mask & RXE_RETH_MASK) &&
> -	    reth_len(pkt) == 0) {
> +	    reth_len(pkt) == 0)
>   		return RESPST_EXECUTE;
> -	}
>   
>   	va	= qp->resp.va;
>   	rkey	= qp->resp.rkey;
>   	resid	= qp->resp.resid;
>   	pktlen	= payload_size(pkt);
>   
> -	if (rkey_is_mw(rkey)) {
> -		mw = rxe_lookup_mw(qp, access, rkey);
> -		if (!mw) {
> -			pr_debug("%s: no MW matches rkey %#x\n",
> -					__func__, rkey);
> -			state = RESPST_ERR_RKEY_VIOLATION;
> -			goto err;
> -		}
> -
> -		mr = mw->mr;
> -		if (!mr) {
> -			pr_err("%s: MW doesn't have an MR\n", __func__);
> -			state = RESPST_ERR_RKEY_VIOLATION;
> -			goto err;
> -		}
> -
> -		if (mw->access & IB_ZERO_BASED)
> -			qp->resp.offset = mw->addr;
> -
> -		rxe_put(mw);
> -		rxe_get(mr);
> -	} else {
> -		mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
> -		if (!mr) {
> -			pr_debug("%s: no MR matches rkey %#x\n",
> -					__func__, rkey);
> -			state = RESPST_ERR_RKEY_VIOLATION;
> -			goto err;
> -		}
> -	}
> +	/* get mr from rkey */
> +	mr = rxe_rkey_to_mr(qp, access, rkey);
> +	if (!mr)
> +		return RESPST_ERR_RKEY_VIOLATION;
>   
> +	/* check that dma fits into mr */
>   	if (mr_check_range(mr, va + qp->resp.offset, resid)) {
>   		state = RESPST_ERR_RKEY_VIOLATION;
>   		goto err;
> @@ -511,7 +538,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>   
>   err:
>   	if (mr)
> -		rxe_put(mr);
> +		rxe_put_mr(mr);
>   	if (mw)
>   		rxe_put(mw);
>   
> @@ -536,8 +563,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
>   				      struct rxe_pkt_info *pkt)
>   {
>   	enum resp_states rc = RESPST_NONE;
> -	int	err;
>   	int data_len = payload_size(pkt);
> +	int err;
>   
>   	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
>   			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ); @@ -610,11 +637,6 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>   	}
>   
>   	if (!res->replay) {
> -		if (mr->state != RXE_MR_STATE_VALID) {
> -			ret = RESPST_ERR_RKEY_VIOLATION;
> -			goto out;
> -		}
> -
>   		vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset,
>   					sizeof(u64));
>   
> @@ -701,59 +723,6 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
>   	return skb;
>   }
>   
> -/**
> - * rxe_recheck_mr - revalidate MR from rkey and get a reference
> - * @qp: the qp
> - * @rkey: the rkey
> - *
> - * This code allows the MR to be invalidated or deregistered or
> - * the MW if one was used to be invalidated or deallocated.
> - * It is assumed that the access permissions if originally good
> - * are OK and the mappings to be unchanged.
> - *
> - * TODO: If someone reregisters an MR to change its size or
> - * access permissions during the processing of an RDMA read
> - * we should kill the responder resource and complete the
> - * operation with an error.
> - *
> - * Return: mr on success else NULL
> - */
> -static struct rxe_mr *rxe_recheck_mr(struct rxe_qp *qp, u32 rkey) -{
> -	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> -	struct rxe_mr *mr;
> -	struct rxe_mw *mw;
> -
> -	if (rkey_is_mw(rkey)) {
> -		mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
> -		if (!mw)
> -			return NULL;
> -
> -		mr = mw->mr;
> -		if (mw->rkey != rkey || mw->state != RXE_MW_STATE_VALID ||
> -		    !mr || mr->state != RXE_MR_STATE_VALID) {
> -			rxe_put(mw);
> -			return NULL;
> -		}
> -
> -		rxe_get(mr);
> -		rxe_put(mw);
> -
> -		return mr;
> -	}
> -
> -	mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> -	if (!mr)
> -		return NULL;
> -
> -	if (mr->rkey != rkey || mr->state != RXE_MR_STATE_VALID) {
> -		rxe_put(mr);
> -		return NULL;
> -	}
> -
> -	return mr;
> -}
> -
>   /* RDMA read response. If res is not NULL, then we have a current RDMA request
>    * being processed or replayed.
>    */
> @@ -769,6 +738,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   	int err;
>   	struct resp_res *res = qp->resp.res;
>   	struct rxe_mr *mr;
> +	int access = IB_ACCESS_REMOTE_READ;
>   
>   	if (!res) {
>   		res = rxe_prepare_res(qp, req_pkt, RXE_READ_MASK); @@ -780,7 +750,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   			mr = qp->resp.mr;
>   			qp->resp.mr = NULL;
>   		} else {
> -			mr = rxe_recheck_mr(qp, res->read.rkey);
> +			mr = rxe_rkey_to_mr(qp, access, res->read.rkey);
>   			if (!mr)
>   				return RESPST_ERR_RKEY_VIOLATION;
>   		}
> @@ -790,7 +760,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   		else
>   			opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
>   	} else {
> -		mr = rxe_recheck_mr(qp, res->read.rkey);
> +		mr = rxe_rkey_to_mr(qp, access, res->read.rkey);
>   		if (!mr)
>   			return RESPST_ERR_RKEY_VIOLATION;
>   
> @@ -812,9 +782,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>   			  payload, RXE_FROM_MR_OBJ);
>   	if (err)
> -		pr_err("Failed copying memory\n");
> +		pr_debug("Failed copying memory\n");
> +
>   	if (mr)
> -		rxe_put(mr);
> +		rxe_put_mr(mr);
>   
>   	if (bth_pad(&ack_pkt)) {
>   		u8 *pad = payload_addr(&ack_pkt) + payload; @@ -824,7 +795,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   
>   	err = rxe_xmit_packet(qp, &ack_pkt, skb);
>   	if (err) {
> -		pr_err("Failed sending RDMA reply.\n");
> +		pr_debug("Failed sending RDMA reply.\n");
>   		return RESPST_ERR_RNR;
>   	}
>   
> @@ -846,16 +817,27 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>   	return state;
>   }
>   
> -static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
> +int rxe_invalidate_rkey(struct rxe_qp *qp, u32 rkey)
>   {
> -	if (rkey_is_mw(rkey))
> -		return rxe_invalidate_mw(qp, rkey);
> -	else
> -		return rxe_invalidate_mr(qp, rkey);
> +	int count = 100;
> +	int err;
> +
> +	do {
> +		if (rkey_is_mw(rkey))
> +			err = rxe_invalidate_mw(qp, rkey);
> +		else
> +			err = rxe_invalidate_mr(qp, rkey);
> +		udelay(1);
> +	} while(err == -EAGAIN && count--);
> +
> +	WARN_ON(!count);
> +
> +	return err;
>   }
>   
> -/* Executes a new request. A retried request never reach that function (send
> - * and writes are discarded, and reads and atomics are retried elsewhere.
> +/* Executes a new request packet. A retried request never reaches this
> + * function (send and writes are discarded, and reads and atomics are
> + * retried elsewhere.)
>    */
>   static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)  { @@ -900,7 +882,7 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>   	if (pkt->mask & RXE_IETH_MASK) {
>   		u32 rkey = ieth_rkey(pkt);
>   
> -		err = invalidate_rkey(qp, rkey);
> +		err = rxe_invalidate_rkey(qp, rkey);
>   		if (err)
>   			return RESPST_ERR_INVALIDATE_RKEY;
>   	}
> @@ -1043,7 +1025,7 @@ static int send_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
>   
>   	err = rxe_xmit_packet(qp, &ack_pkt, skb);
>   	if (err)
> -		pr_err_ratelimited("Failed sending ack\n");
> +		pr_debug("Failed sending ack\n");
>   
>   err1:
>   	return err;
> @@ -1064,7 +1046,7 @@ static int send_atomic_ack(struct rxe_qp *qp, u8 syndrome, u32 psn)
>   
>   	err = rxe_xmit_packet(qp, &ack_pkt, skb);
>   	if (err)
> -		pr_err_ratelimited("Failed sending atomic ack\n");
> +		pr_debug("Failed sending atomic ack\n");
>   
>   	/* have to clear this since it is used to trigger
>   	 * long read replies
> @@ -1103,7 +1085,7 @@ static enum resp_states cleanup(struct rxe_qp *qp,
>   	}
>   
>   	if (qp->resp.mr) {
> -		rxe_put(qp->resp.mr);
> +		rxe_put_mr(qp->resp.mr);
>   		qp->resp.mr = NULL;
>   	}
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index a24fbe984066..77ac6308997c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -271,11 +271,6 @@ enum rxe_mr_copy_dir {
>   	RXE_FROM_MR_OBJ,
>   };
>   
> -enum rxe_mr_lookup_type {
> -	RXE_LOOKUP_LOCAL,
> -	RXE_LOOKUP_REMOTE,
> -};
> -
>   #define RXE_BUF_PER_MAP		(PAGE_SIZE / sizeof(struct rxe_phys_buf))
>   
>   struct rxe_phys_buf {
> @@ -302,7 +297,12 @@ struct rxe_mr {
>   
>   	u32			lkey;
>   	u32			rkey;
> +
>   	enum rxe_mr_state	state;
> +	int			invalidate;
> +	int			num_dma;
> +	spinlock_t		lock;	/* guard state */
> +
>   	enum ib_mr_type		type;
>   	u64			va;
>   	u64			iova;
> --
> 2.34.1
>


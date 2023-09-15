Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356617A127D
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Sep 2023 02:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjIOAqM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Sep 2023 20:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjIOAqM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Sep 2023 20:46:12 -0400
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF8E2700
        for <linux-rdma@vger.kernel.org>; Thu, 14 Sep 2023 17:46:07 -0700 (PDT)
Message-ID: <370d9b26-51b6-f34e-b833-1cae2eb3136e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694738764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/MsuwN47o4V0XAGHhYGbppZPQDISAdWFxhdRULOdgW0=;
        b=PQGBJl6bK17QDGPova8WFBi/HeTeijE1a4A98S4+kQoy5Dc5bN8YuvzGqNOu4vpV/A/gHT
        hWyHPMZLULSgWntr2VoleEdIEXGEi+jlHbH7CyGHMBcnm3ufJSI/PkuOw9+2rKTo3GjWL5
        90frGuSwVnDCy6eZFlbUH066accrWPQ=
Date:   Fri, 15 Sep 2023 08:45:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/rxe: Complete removing newlines from debug
 macros
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        lizhijian@futitsu.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20230914163959.85586-1-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230914163959.85586-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/9/15 0:40, Bob Pearson 写道:
> Earlier patches removed newlines from some debug macros and
> added newlines to instances of these marcros but not all. This
> patch completes this effort by removing newlines from all debug
> macros and adding newlines to all instances of all debug macros
> for the sake of consistency.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe.h       |   6 +-
>   drivers/infiniband/sw/rxe/rxe_comp.c  |   2 +-
>   drivers/infiniband/sw/rxe/rxe_cq.c    |   2 +-
>   drivers/infiniband/sw/rxe/rxe_mw.c    |  28 ++--
>   drivers/infiniband/sw/rxe/rxe_resp.c  |   2 +-
>   drivers/infiniband/sw/rxe/rxe_task.c  |   4 +-
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 212 +++++++++++++-------------
>   7 files changed, 123 insertions(+), 133 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
> index d33dd6cf83d3..d8fb2c7af30a 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -38,7 +38,7 @@
>   
>   #define RXE_ROCE_V2_SPORT		(0xc000)
>   
> -#define rxe_dbg(fmt, ...) pr_debug("%s: " fmt "\n", __func__, ##__VA_ARGS__)
> +#define rxe_dbg(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
>   #define rxe_dbg_dev(rxe, fmt, ...) ibdev_dbg(&(rxe)->ib_dev,		\
>   		"%s: " fmt, __func__, ##__VA_ARGS__)
>   #define rxe_dbg_uc(uc, fmt, ...) ibdev_dbg((uc)->ibuc.device,		\
> @@ -58,7 +58,7 @@
>   #define rxe_dbg_mw(mw, fmt, ...) ibdev_dbg((mw)->ibmw.device,		\
>   		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
>   
> -#define rxe_err(fmt, ...) pr_err_ratelimited("%s: " fmt "\n", __func__, \
> +#define rxe_err(fmt, ...) pr_err_ratelimited("%s: " fmt, __func__, \
>   					##__VA_ARGS__)

Thanks a lot for your efforts.

In this commit, the newlines are removed from rxe_err and rxe_dbg macros.

And the newlines are added into rxe_err and rxe_dbg logs. I am fine with it.


Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>


linux-rmda@vger.kernel.org is not correct. Now I fix it.


Zhu Yanjun

>   #define rxe_err_dev(rxe, fmt, ...) ibdev_err_ratelimited(&(rxe)->ib_dev, \
>   		"%s: " fmt, __func__, ##__VA_ARGS__)
> @@ -79,7 +79,7 @@
>   #define rxe_err_mw(mw, fmt, ...) ibdev_err_ratelimited((mw)->ibmw.device, \
>   		"mw#%d %s:  " fmt, (mw)->elem.index, __func__, ##__VA_ARGS__)
>   
> -#define rxe_info(fmt, ...) pr_info_ratelimited("%s: " fmt "\n", __func__, \
> +#define rxe_info(fmt, ...) pr_info_ratelimited("%s: " fmt, __func__, \
>   					##__VA_ARGS__)
>   #define rxe_info_dev(rxe, fmt, ...) ibdev_info_ratelimited(&(rxe)->ib_dev, \
>   		"%s: " fmt, __func__, ##__VA_ARGS__)
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index d0bdc2d8adc8..1e2eb812010d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -582,7 +582,7 @@ static int flush_send_wqe(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>   
>   	err = rxe_cq_post(qp->scq, &cqe, 0);
>   	if (err)
> -		rxe_dbg_cq(qp->scq, "post cq failed, err = %d", err);
> +		rxe_dbg_cq(qp->scq, "post cq failed, err = %d\n", err);
>   
>   	return err;
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
> index d5486cbb3f10..cba694d4308e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -96,7 +96,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>   
>   	full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>   	if (unlikely(full)) {
> -		rxe_err_cq(cq, "queue full");
> +		rxe_err_cq(cq, "queue full\n");
>   		spin_unlock_irqrestore(&cq->cq_lock, flags);
>   		if (cq->ibcq.event_handler) {
>   			ev.device = cq->ibcq.device;
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> index d9312b5c9d20..c8bfcc3e624f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -52,14 +52,13 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>   {
>   	if (mw->ibmw.type == IB_MW_TYPE_1) {
>   		if (unlikely(mw->state != RXE_MW_STATE_VALID)) {
> -			rxe_dbg_mw(mw,
> -				"attempt to bind a type 1 MW not in the valid state\n");
> +			rxe_dbg_mw(mw, "type 1 mw not in the valid state\n");
>   			return -EINVAL;
>   		}
>   
>   		/* o10-36.2.2 */
>   		if (unlikely((access & IB_ZERO_BASED))) {
> -			rxe_dbg_mw(mw, "attempt to bind a zero based type 1 MW\n");
> +			rxe_dbg_mw(mw, "zero based type 1 mw\n");
>   			return -EINVAL;
>   		}
>   	}
> @@ -67,22 +66,19 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>   	if (mw->ibmw.type == IB_MW_TYPE_2) {
>   		/* o10-37.2.30 */
>   		if (unlikely(mw->state != RXE_MW_STATE_FREE)) {
> -			rxe_dbg_mw(mw,
> -				"attempt to bind a type 2 MW not in the free state\n");
> +			rxe_dbg_mw(mw, "type 2 mw not in the free state\n");
>   			return -EINVAL;
>   		}
>   
>   		/* C10-72 */
>   		if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
> -			rxe_dbg_mw(mw,
> -				"attempt to bind type 2 MW with qp with different PD\n");
> +			rxe_dbg_mw(mw, "type 2 mw with different pd than qp\n");
>   			return -EINVAL;
>   		}
>   
>   		/* o10-37.2.40 */
>   		if (unlikely(!mr || wqe->wr.wr.mw.length == 0)) {
> -			rxe_dbg_mw(mw,
> -				"attempt to invalidate type 2 MW by binding with NULL or zero length MR\n");
> +			rxe_dbg_mw(mw, "type 2 mw with NULL or zero length mr\n");
>   			return -EINVAL;
>   		}
>   	}
> @@ -92,14 +88,13 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>   		return 0;
>   
>   	if (unlikely(mr->access & IB_ZERO_BASED)) {
> -		rxe_dbg_mw(mw, "attempt to bind MW to zero based MR\n");
> +		rxe_dbg_mw(mw, "zero based mr\n");
>   		return -EINVAL;
>   	}
>   
>   	/* C10-73 */
>   	if (unlikely(!(mr->access & IB_ACCESS_MW_BIND))) {
> -		rxe_dbg_mw(mw,
> -			"attempt to bind an MW to an MR without bind access\n");
> +		rxe_dbg_mw(mw, "mr without bind access\n");
>   		return -EINVAL;
>   	}
>   
> @@ -107,24 +102,21 @@ static int rxe_check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>   	if (unlikely((access &
>   		      (IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_ATOMIC)) &&
>   		     !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
> -		rxe_dbg_mw(mw,
> -			"attempt to bind an Writable MW to an MR without local write access\n");
> +		rxe_dbg_mw(mw, "mr without local write access\n");
>   		return -EINVAL;
>   	}
>   
>   	/* C10-75 */
>   	if (access & IB_ZERO_BASED) {
>   		if (unlikely(wqe->wr.wr.mw.length > mr->ibmr.length)) {
> -			rxe_dbg_mw(mw,
> -				"attempt to bind a ZB MW outside of the MR\n");
> +			rxe_dbg_mw(mw, "ZB mw outside of the mr\n");
>   			return -EINVAL;
>   		}
>   	} else {
>   		if (unlikely((wqe->wr.wr.mw.addr < mr->ibmr.iova) ||
>   			     ((wqe->wr.wr.mw.addr + wqe->wr.wr.mw.length) >
>   			      (mr->ibmr.iova + mr->ibmr.length)))) {
> -			rxe_dbg_mw(mw,
> -				"attempt to bind a VA MW outside of the MR\n");
> +			rxe_dbg_mw(mw, "VA mw outside of the mr\n");
>   			return -EINVAL;
>   		}
>   	}
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index da470a925efc..f7daeca5c5e5 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -1442,7 +1442,7 @@ static int flush_recv_wqe(struct rxe_qp *qp, struct rxe_recv_wqe *wqe)
>   
>   	err = rxe_cq_post(qp->rcq, &cqe, 0);
>   	if (err)
> -		rxe_dbg_cq(qp->rcq, "post cq failed err = %d", err);
> +		rxe_dbg_cq(qp->rcq, "post cq failed err = %d\n", err);
>   
>   	return err;
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 1501120d4f52..810ff6d47e4c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -165,9 +165,7 @@ static void do_task(struct rxe_task *task)
>   		if (!cont) {
>   			task->num_done++;
>   			if (WARN_ON(task->num_done != task->num_sched))
> -				rxe_dbg_qp(
> -					task->qp,
> -					"%ld tasks scheduled, %ld tasks done",
> +				rxe_dbg_qp(task->qp, "%ld tasks scheduled, %ld tasks done\n",
>   					task->num_sched, task->num_done);
>   		}
>   		spin_unlock_irqrestore(&task->lock, flags);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 48f86839d36a..d3f5beb495a7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -23,7 +23,7 @@ static int rxe_query_device(struct ib_device *ibdev,
>   	int err;
>   
>   	if (udata->inlen || udata->outlen) {
> -		rxe_dbg_dev(rxe, "malformed udata");
> +		rxe_dbg_dev(rxe, "malformed udata\n");
>   		err = -EINVAL;
>   		goto err_out;
>   	}
> @@ -33,7 +33,7 @@ static int rxe_query_device(struct ib_device *ibdev,
>   	return 0;
>   
>   err_out:
> -	rxe_err_dev(rxe, "returned err = %d", err);
> +	rxe_err_dev(rxe, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -45,7 +45,7 @@ static int rxe_query_port(struct ib_device *ibdev,
>   
>   	if (port_num != 1) {
>   		err = -EINVAL;
> -		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
> +		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>   		goto err_out;
>   	}
>   
> @@ -67,7 +67,7 @@ static int rxe_query_port(struct ib_device *ibdev,
>   	return ret;
>   
>   err_out:
> -	rxe_err_dev(rxe, "returned err = %d", err);
> +	rxe_err_dev(rxe, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -79,7 +79,7 @@ static int rxe_query_pkey(struct ib_device *ibdev,
>   
>   	if (index != 0) {
>   		err = -EINVAL;
> -		rxe_dbg_dev(rxe, "bad pkey index = %d", index);
> +		rxe_dbg_dev(rxe, "bad pkey index = %d\n", index);
>   		goto err_out;
>   	}
>   
> @@ -87,7 +87,7 @@ static int rxe_query_pkey(struct ib_device *ibdev,
>   	return 0;
>   
>   err_out:
> -	rxe_err_dev(rxe, "returned err = %d", err);
> +	rxe_err_dev(rxe, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -100,7 +100,7 @@ static int rxe_modify_device(struct ib_device *ibdev,
>   	if (mask & ~(IB_DEVICE_MODIFY_SYS_IMAGE_GUID |
>   		     IB_DEVICE_MODIFY_NODE_DESC)) {
>   		err = -EOPNOTSUPP;
> -		rxe_dbg_dev(rxe, "unsupported mask = 0x%x", mask);
> +		rxe_dbg_dev(rxe, "unsupported mask = 0x%x\n", mask);
>   		goto err_out;
>   	}
>   
> @@ -115,7 +115,7 @@ static int rxe_modify_device(struct ib_device *ibdev,
>   	return 0;
>   
>   err_out:
> -	rxe_err_dev(rxe, "returned err = %d", err);
> +	rxe_err_dev(rxe, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -128,14 +128,14 @@ static int rxe_modify_port(struct ib_device *ibdev, u32 port_num,
>   
>   	if (port_num != 1) {
>   		err = -EINVAL;
> -		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
> +		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>   		goto err_out;
>   	}
>   
>   	//TODO is shutdown useful
>   	if (mask & ~(IB_PORT_RESET_QKEY_CNTR)) {
>   		err = -EOPNOTSUPP;
> -		rxe_dbg_dev(rxe, "unsupported mask = 0x%x", mask);
> +		rxe_dbg_dev(rxe, "unsupported mask = 0x%x\n", mask);
>   		goto err_out;
>   	}
>   
> @@ -149,7 +149,7 @@ static int rxe_modify_port(struct ib_device *ibdev, u32 port_num,
>   	return 0;
>   
>   err_out:
> -	rxe_err_dev(rxe, "returned err = %d", err);
> +	rxe_err_dev(rxe, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -161,14 +161,14 @@ static enum rdma_link_layer rxe_get_link_layer(struct ib_device *ibdev,
>   
>   	if (port_num != 1) {
>   		err = -EINVAL;
> -		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
> +		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>   		goto err_out;
>   	}
>   
>   	return IB_LINK_LAYER_ETHERNET;
>   
>   err_out:
> -	rxe_err_dev(rxe, "returned err = %d", err);
> +	rxe_err_dev(rxe, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -181,7 +181,7 @@ static int rxe_port_immutable(struct ib_device *ibdev, u32 port_num,
>   
>   	if (port_num != 1) {
>   		err = -EINVAL;
> -		rxe_dbg_dev(rxe, "bad port_num = %d", port_num);
> +		rxe_dbg_dev(rxe, "bad port_num = %d\n", port_num);
>   		goto err_out;
>   	}
>   
> @@ -197,7 +197,7 @@ static int rxe_port_immutable(struct ib_device *ibdev, u32 port_num,
>   	return 0;
>   
>   err_out:
> -	rxe_err_dev(rxe, "returned err = %d", err);
> +	rxe_err_dev(rxe, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -210,7 +210,7 @@ static int rxe_alloc_ucontext(struct ib_ucontext *ibuc, struct ib_udata *udata)
>   
>   	err = rxe_add_to_pool(&rxe->uc_pool, uc);
>   	if (err)
> -		rxe_err_dev(rxe, "unable to create uc");
> +		rxe_err_dev(rxe, "unable to create uc\n");
>   
>   	return err;
>   }
> @@ -222,7 +222,7 @@ static void rxe_dealloc_ucontext(struct ib_ucontext *ibuc)
>   
>   	err = rxe_cleanup(uc);
>   	if (err)
> -		rxe_err_uc(uc, "cleanup failed, err = %d", err);
> +		rxe_err_uc(uc, "cleanup failed, err = %d\n", err);
>   }
>   
>   /* pd */
> @@ -234,14 +234,14 @@ static int rxe_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>   
>   	err = rxe_add_to_pool(&rxe->pd_pool, pd);
>   	if (err) {
> -		rxe_dbg_dev(rxe, "unable to alloc pd");
> +		rxe_dbg_dev(rxe, "unable to alloc pd\n");
>   		goto err_out;
>   	}
>   
>   	return 0;
>   
>   err_out:
> -	rxe_err_dev(rxe, "returned err = %d", err);
> +	rxe_err_dev(rxe, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -252,7 +252,7 @@ static int rxe_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>   
>   	err = rxe_cleanup(pd);
>   	if (err)
> -		rxe_err_pd(pd, "cleanup failed, err = %d", err);
> +		rxe_err_pd(pd, "cleanup failed, err = %d\n", err);
>   
>   	return 0;
>   }
> @@ -279,7 +279,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
>   	err = rxe_add_to_pool_ah(&rxe->ah_pool, ah,
>   			init_attr->flags & RDMA_CREATE_AH_SLEEPABLE);
>   	if (err) {
> -		rxe_dbg_dev(rxe, "unable to create ah");
> +		rxe_dbg_dev(rxe, "unable to create ah\n");
>   		goto err_out;
>   	}
>   
> @@ -288,7 +288,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
>   
>   	err = rxe_ah_chk_attr(ah, init_attr->ah_attr);
>   	if (err) {
> -		rxe_dbg_ah(ah, "bad attr");
> +		rxe_dbg_ah(ah, "bad attr\n");
>   		goto err_cleanup;
>   	}
>   
> @@ -298,7 +298,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
>   					 sizeof(uresp->ah_num));
>   		if (err) {
>   			err = -EFAULT;
> -			rxe_dbg_ah(ah, "unable to copy to user");
> +			rxe_dbg_ah(ah, "unable to copy to user\n");
>   			goto err_cleanup;
>   		}
>   	} else if (ah->is_user) {
> @@ -314,7 +314,7 @@ static int rxe_create_ah(struct ib_ah *ibah,
>   err_cleanup:
>   	cleanup_err = rxe_cleanup(ah);
>   	if (cleanup_err)
> -		rxe_err_ah(ah, "cleanup failed, err = %d", cleanup_err);
> +		rxe_err_ah(ah, "cleanup failed, err = %d\n", cleanup_err);
>   err_out:
>   	rxe_err_ah(ah, "returned err = %d", err);
>   	return err;
> @@ -327,7 +327,7 @@ static int rxe_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
>   
>   	err = rxe_ah_chk_attr(ah, attr);
>   	if (err) {
> -		rxe_dbg_ah(ah, "bad attr");
> +		rxe_dbg_ah(ah, "bad attr\n");
>   		goto err_out;
>   	}
>   
> @@ -336,7 +336,7 @@ static int rxe_modify_ah(struct ib_ah *ibah, struct rdma_ah_attr *attr)
>   	return 0;
>   
>   err_out:
> -	rxe_err_ah(ah, "returned err = %d", err);
> +	rxe_err_ah(ah, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -358,7 +358,7 @@ static int rxe_destroy_ah(struct ib_ah *ibah, u32 flags)
>   
>   	err = rxe_cleanup_ah(ah, flags & RDMA_DESTROY_AH_SLEEPABLE);
>   	if (err)
> -		rxe_err_ah(ah, "cleanup failed, err = %d", err);
> +		rxe_err_ah(ah, "cleanup failed, err = %d\n", err);
>   
>   	return 0;
>   }
> @@ -376,7 +376,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
>   	if (udata) {
>   		if (udata->outlen < sizeof(*uresp)) {
>   			err = -EINVAL;
> -			rxe_err_dev(rxe, "malformed udata");
> +			rxe_err_dev(rxe, "malformed udata\n");
>   			goto err_out;
>   		}
>   		uresp = udata->outbuf;
> @@ -384,20 +384,20 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
>   
>   	if (init->srq_type != IB_SRQT_BASIC) {
>   		err = -EOPNOTSUPP;
> -		rxe_dbg_dev(rxe, "srq type = %d, not supported",
> +		rxe_dbg_dev(rxe, "srq type = %d, not supported\n",
>   				init->srq_type);
>   		goto err_out;
>   	}
>   
>   	err = rxe_srq_chk_init(rxe, init);
>   	if (err) {
> -		rxe_dbg_dev(rxe, "invalid init attributes");
> +		rxe_dbg_dev(rxe, "invalid init attributes\n");
>   		goto err_out;
>   	}
>   
>   	err = rxe_add_to_pool(&rxe->srq_pool, srq);
>   	if (err) {
> -		rxe_dbg_dev(rxe, "unable to create srq, err = %d", err);
> +		rxe_dbg_dev(rxe, "unable to create srq, err = %d\n", err);
>   		goto err_out;
>   	}
>   
> @@ -406,7 +406,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
>   
>   	err = rxe_srq_from_init(rxe, srq, init, udata, uresp);
>   	if (err) {
> -		rxe_dbg_srq(srq, "create srq failed, err = %d", err);
> +		rxe_dbg_srq(srq, "create srq failed, err = %d\n", err);
>   		goto err_cleanup;
>   	}
>   
> @@ -415,7 +415,7 @@ static int rxe_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init,
>   err_cleanup:
>   	cleanup_err = rxe_cleanup(srq);
>   	if (cleanup_err)
> -		rxe_err_srq(srq, "cleanup failed, err = %d", cleanup_err);
> +		rxe_err_srq(srq, "cleanup failed, err = %d\n", cleanup_err);
>   err_out:
>   	rxe_err_dev(rxe, "returned err = %d", err);
>   	return err;
> @@ -433,34 +433,34 @@ static int rxe_modify_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr,
>   	if (udata) {
>   		if (udata->inlen < sizeof(cmd)) {
>   			err = -EINVAL;
> -			rxe_dbg_srq(srq, "malformed udata");
> +			rxe_dbg_srq(srq, "malformed udata\n");
>   			goto err_out;
>   		}
>   
>   		err = ib_copy_from_udata(&cmd, udata, sizeof(cmd));
>   		if (err) {
>   			err = -EFAULT;
> -			rxe_dbg_srq(srq, "unable to read udata");
> +			rxe_dbg_srq(srq, "unable to read udata\n");
>   			goto err_out;
>   		}
>   	}
>   
>   	err = rxe_srq_chk_attr(rxe, srq, attr, mask);
>   	if (err) {
> -		rxe_dbg_srq(srq, "bad init attributes");
> +		rxe_dbg_srq(srq, "bad init attributes\n");
>   		goto err_out;
>   	}
>   
>   	err = rxe_srq_from_attr(rxe, srq, attr, mask, &cmd, udata);
>   	if (err) {
> -		rxe_dbg_srq(srq, "bad attr");
> +		rxe_dbg_srq(srq, "bad attr\n");
>   		goto err_out;
>   	}
>   
>   	return 0;
>   
>   err_out:
> -	rxe_err_srq(srq, "returned err = %d", err);
> +	rxe_err_srq(srq, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -471,7 +471,7 @@ static int rxe_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
>   
>   	if (srq->error) {
>   		err = -EINVAL;
> -		rxe_dbg_srq(srq, "srq in error state");
> +		rxe_dbg_srq(srq, "srq in error state\n");
>   		goto err_out;
>   	}
>   
> @@ -481,7 +481,7 @@ static int rxe_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
>   	return 0;
>   
>   err_out:
> -	rxe_err_srq(srq, "returned err = %d", err);
> +	rxe_err_srq(srq, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -505,7 +505,7 @@ static int rxe_post_srq_recv(struct ib_srq *ibsrq, const struct ib_recv_wr *wr,
>   
>   	if (err) {
>   		*bad_wr = wr;
> -		rxe_err_srq(srq, "returned err = %d", err);
> +		rxe_err_srq(srq, "returned err = %d\n", err);
>   	}
>   
>   	return err;
> @@ -518,7 +518,7 @@ static int rxe_destroy_srq(struct ib_srq *ibsrq, struct ib_udata *udata)
>   
>   	err = rxe_cleanup(srq);
>   	if (err)
> -		rxe_err_srq(srq, "cleanup failed, err = %d", err);
> +		rxe_err_srq(srq, "cleanup failed, err = %d\n", err);
>   
>   	return 0;
>   }
> @@ -536,13 +536,13 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
>   	if (udata) {
>   		if (udata->inlen) {
>   			err = -EINVAL;
> -			rxe_dbg_dev(rxe, "malformed udata, err = %d", err);
> +			rxe_dbg_dev(rxe, "malformed udata, err = %d\n", err);
>   			goto err_out;
>   		}
>   
>   		if (udata->outlen < sizeof(*uresp)) {
>   			err = -EINVAL;
> -			rxe_dbg_dev(rxe, "malformed udata, err = %d", err);
> +			rxe_dbg_dev(rxe, "malformed udata, err = %d\n", err);
>   			goto err_out;
>   		}
>   
> @@ -554,25 +554,25 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
>   
>   	if (init->create_flags) {
>   		err = -EOPNOTSUPP;
> -		rxe_dbg_dev(rxe, "unsupported create_flags, err = %d", err);
> +		rxe_dbg_dev(rxe, "unsupported create_flags, err = %d\n", err);
>   		goto err_out;
>   	}
>   
>   	err = rxe_qp_chk_init(rxe, init);
>   	if (err) {
> -		rxe_dbg_dev(rxe, "bad init attr, err = %d", err);
> +		rxe_dbg_dev(rxe, "bad init attr, err = %d\n", err);
>   		goto err_out;
>   	}
>   
>   	err = rxe_add_to_pool(&rxe->qp_pool, qp);
>   	if (err) {
> -		rxe_dbg_dev(rxe, "unable to create qp, err = %d", err);
> +		rxe_dbg_dev(rxe, "unable to create qp, err = %d\n", err);
>   		goto err_out;
>   	}
>   
>   	err = rxe_qp_from_init(rxe, qp, pd, init, uresp, ibqp->pd, udata);
>   	if (err) {
> -		rxe_dbg_qp(qp, "create qp failed, err = %d", err);
> +		rxe_dbg_qp(qp, "create qp failed, err = %d\n", err);
>   		goto err_cleanup;
>   	}
>   
> @@ -582,9 +582,9 @@ static int rxe_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init,
>   err_cleanup:
>   	cleanup_err = rxe_cleanup(qp);
>   	if (cleanup_err)
> -		rxe_err_qp(qp, "cleanup failed, err = %d", cleanup_err);
> +		rxe_err_qp(qp, "cleanup failed, err = %d\n", cleanup_err);
>   err_out:
> -	rxe_err_dev(rxe, "returned err = %d", err);
> +	rxe_err_dev(rxe, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -597,20 +597,20 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>   
>   	if (mask & ~IB_QP_ATTR_STANDARD_BITS) {
>   		err = -EOPNOTSUPP;
> -		rxe_dbg_qp(qp, "unsupported mask = 0x%x, err = %d",
> +		rxe_dbg_qp(qp, "unsupported mask = 0x%x, err = %d\n",
>   			   mask, err);
>   		goto err_out;
>   	}
>   
>   	err = rxe_qp_chk_attr(rxe, qp, attr, mask);
>   	if (err) {
> -		rxe_dbg_qp(qp, "bad mask/attr, err = %d", err);
> +		rxe_dbg_qp(qp, "bad mask/attr, err = %d\n", err);
>   		goto err_out;
>   	}
>   
>   	err = rxe_qp_from_attr(qp, attr, mask, udata);
>   	if (err) {
> -		rxe_dbg_qp(qp, "modify qp failed, err = %d", err);
> +		rxe_dbg_qp(qp, "modify qp failed, err = %d\n", err);
>   		goto err_out;
>   	}
>   
> @@ -622,7 +622,7 @@ static int rxe_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>   	return 0;
>   
>   err_out:
> -	rxe_err_qp(qp, "returned err = %d", err);
> +	rxe_err_qp(qp, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -644,18 +644,18 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>   
>   	err = rxe_qp_chk_destroy(qp);
>   	if (err) {
> -		rxe_dbg_qp(qp, "unable to destroy qp, err = %d", err);
> +		rxe_dbg_qp(qp, "unable to destroy qp, err = %d\n", err);
>   		goto err_out;
>   	}
>   
>   	err = rxe_cleanup(qp);
>   	if (err)
> -		rxe_err_qp(qp, "cleanup failed, err = %d", err);
> +		rxe_err_qp(qp, "cleanup failed, err = %d\n", err);
>   
>   	return 0;
>   
>   err_out:
> -	rxe_err_qp(qp, "returned err = %d", err);
> +	rxe_err_qp(qp, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -675,12 +675,12 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>   	do {
>   		mask = wr_opcode_mask(ibwr->opcode, qp);
>   		if (!mask) {
> -			rxe_err_qp(qp, "bad wr opcode for qp type");
> +			rxe_err_qp(qp, "bad wr opcode for qp type\n");
>   			break;
>   		}
>   
>   		if (num_sge > sq->max_sge) {
> -			rxe_err_qp(qp, "num_sge > max_sge");
> +			rxe_err_qp(qp, "num_sge > max_sge\n");
>   			break;
>   		}
>   
> @@ -689,27 +689,27 @@ static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
>   			length += ibwr->sg_list[i].length;
>   
>   		if (length > (1UL << 31)) {
> -			rxe_err_qp(qp, "message length too long");
> +			rxe_err_qp(qp, "message length too long\n");
>   			break;
>   		}
>   
>   		if (mask & WR_ATOMIC_MASK) {
>   			if (length != 8) {
> -				rxe_err_qp(qp, "atomic length != 8");
> +				rxe_err_qp(qp, "atomic length != 8\n");
>   				break;
>   			}
>   			if (atomic_wr(ibwr)->remote_addr & 0x7) {
> -				rxe_err_qp(qp, "misaligned atomic address");
> +				rxe_err_qp(qp, "misaligned atomic address\n");
>   				break;
>   			}
>   		}
>   		if (ibwr->send_flags & IB_SEND_INLINE) {
>   			if (!(mask & WR_INLINE_MASK)) {
> -				rxe_err_qp(qp, "opcode doesn't support inline data");
> +				rxe_err_qp(qp, "opcode doesn't support inline data\n");
>   				break;
>   			}
>   			if (length > sq->max_inline) {
> -				rxe_err_qp(qp, "inline length too big");
> +				rxe_err_qp(qp, "inline length too big\n");
>   				break;
>   			}
>   		}
> @@ -747,7 +747,7 @@ static int init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
>   		case IB_WR_SEND:
>   			break;
>   		default:
> -			rxe_err_qp(qp, "bad wr opcode %d for UD/GSI QP",
> +			rxe_err_qp(qp, "bad wr opcode %d for UD/GSI QP\n",
>   					wr->opcode);
>   			return -EINVAL;
>   		}
> @@ -795,7 +795,7 @@ static int init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
>   		case IB_WR_ATOMIC_WRITE:
>   			break;
>   		default:
> -			rxe_err_qp(qp, "unsupported wr opcode %d",
> +			rxe_err_qp(qp, "unsupported wr opcode %d\n",
>   					wr->opcode);
>   			return -EINVAL;
>   		}
> @@ -870,7 +870,7 @@ static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr)
>   
>   	full = queue_full(sq->queue, QUEUE_TYPE_FROM_ULP);
>   	if (unlikely(full)) {
> -		rxe_err_qp(qp, "send queue full");
> +		rxe_err_qp(qp, "send queue full\n");
>   		return -ENOMEM;
>   	}
>   
> @@ -922,14 +922,14 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
>   	/* caller has already called destroy_qp */
>   	if (WARN_ON_ONCE(!qp->valid)) {
>   		spin_unlock_irqrestore(&qp->state_lock, flags);
> -		rxe_err_qp(qp, "qp has been destroyed");
> +		rxe_err_qp(qp, "qp has been destroyed\n");
>   		return -EINVAL;
>   	}
>   
>   	if (unlikely(qp_state(qp) < IB_QPS_RTS)) {
>   		spin_unlock_irqrestore(&qp->state_lock, flags);
>   		*bad_wr = wr;
> -		rxe_err_qp(qp, "qp not ready to send");
> +		rxe_err_qp(qp, "qp not ready to send\n");
>   		return -EINVAL;
>   	}
>   	spin_unlock_irqrestore(&qp->state_lock, flags);
> @@ -959,13 +959,13 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
>   	full = queue_full(rq->queue, QUEUE_TYPE_FROM_ULP);
>   	if (unlikely(full)) {
>   		err = -ENOMEM;
> -		rxe_dbg("queue full");
> +		rxe_dbg("queue full\n");
>   		goto err_out;
>   	}
>   
>   	if (unlikely(num_sge > rq->max_sge)) {
>   		err = -EINVAL;
> -		rxe_dbg("bad num_sge > max_sge");
> +		rxe_dbg("bad num_sge > max_sge\n");
>   		goto err_out;
>   	}
>   
> @@ -976,7 +976,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
>   	/* IBA max message size is 2^31 */
>   	if (length >= (1UL<<31)) {
>   		err = -EINVAL;
> -		rxe_dbg("message length too long");
> +		rxe_dbg("message length too long\n");
>   		goto err_out;
>   	}
>   
> @@ -996,7 +996,7 @@ static int post_one_recv(struct rxe_rq *rq, const struct ib_recv_wr *ibwr)
>   	return 0;
>   
>   err_out:
> -	rxe_dbg("returned err = %d", err);
> +	rxe_dbg("returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -1012,7 +1012,7 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
>   	/* caller has already called destroy_qp */
>   	if (WARN_ON_ONCE(!qp->valid)) {
>   		spin_unlock_irqrestore(&qp->state_lock, flags);
> -		rxe_err_qp(qp, "qp has been destroyed");
> +		rxe_err_qp(qp, "qp has been destroyed\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1020,14 +1020,14 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
>   	if (unlikely((qp_state(qp) < IB_QPS_INIT))) {
>   		spin_unlock_irqrestore(&qp->state_lock, flags);
>   		*bad_wr = wr;
> -		rxe_dbg_qp(qp, "qp not ready to post recv");
> +		rxe_dbg_qp(qp, "qp not ready to post recv\n");
>   		return -EINVAL;
>   	}
>   	spin_unlock_irqrestore(&qp->state_lock, flags);
>   
>   	if (unlikely(qp->srq)) {
>   		*bad_wr = wr;
> -		rxe_dbg_qp(qp, "qp has srq, use post_srq_recv instead");
> +		rxe_dbg_qp(qp, "qp has srq, use post_srq_recv instead\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1065,7 +1065,7 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   	if (udata) {
>   		if (udata->outlen < sizeof(*uresp)) {
>   			err = -EINVAL;
> -			rxe_dbg_dev(rxe, "malformed udata, err = %d", err);
> +			rxe_dbg_dev(rxe, "malformed udata, err = %d\n", err);
>   			goto err_out;
>   		}
>   		uresp = udata->outbuf;
> @@ -1073,26 +1073,26 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   
>   	if (attr->flags) {
>   		err = -EOPNOTSUPP;
> -		rxe_dbg_dev(rxe, "bad attr->flags, err = %d", err);
> +		rxe_dbg_dev(rxe, "bad attr->flags, err = %d\n", err);
>   		goto err_out;
>   	}
>   
>   	err = rxe_cq_chk_attr(rxe, NULL, attr->cqe, attr->comp_vector);
>   	if (err) {
> -		rxe_dbg_dev(rxe, "bad init attributes, err = %d", err);
> +		rxe_dbg_dev(rxe, "bad init attributes, err = %d\n", err);
>   		goto err_out;
>   	}
>   
>   	err = rxe_add_to_pool(&rxe->cq_pool, cq);
>   	if (err) {
> -		rxe_dbg_dev(rxe, "unable to create cq, err = %d", err);
> +		rxe_dbg_dev(rxe, "unable to create cq, err = %d\n", err);
>   		goto err_out;
>   	}
>   
>   	err = rxe_cq_from_init(rxe, cq, attr->cqe, attr->comp_vector, udata,
>   			       uresp);
>   	if (err) {
> -		rxe_dbg_cq(cq, "create cq failed, err = %d", err);
> +		rxe_dbg_cq(cq, "create cq failed, err = %d\n", err);
>   		goto err_cleanup;
>   	}
>   
> @@ -1101,9 +1101,9 @@ static int rxe_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>   err_cleanup:
>   	cleanup_err = rxe_cleanup(cq);
>   	if (cleanup_err)
> -		rxe_err_cq(cq, "cleanup failed, err = %d", cleanup_err);
> +		rxe_err_cq(cq, "cleanup failed, err = %d\n", cleanup_err);
>   err_out:
> -	rxe_err_dev(rxe, "returned err = %d", err);
> +	rxe_err_dev(rxe, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -1117,7 +1117,7 @@ static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
>   	if (udata) {
>   		if (udata->outlen < sizeof(*uresp)) {
>   			err = -EINVAL;
> -			rxe_dbg_cq(cq, "malformed udata");
> +			rxe_dbg_cq(cq, "malformed udata\n");
>   			goto err_out;
>   		}
>   		uresp = udata->outbuf;
> @@ -1125,20 +1125,20 @@ static int rxe_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
>   
>   	err = rxe_cq_chk_attr(rxe, cq, cqe, 0);
>   	if (err) {
> -		rxe_dbg_cq(cq, "bad attr, err = %d", err);
> +		rxe_dbg_cq(cq, "bad attr, err = %d\n", err);
>   		goto err_out;
>   	}
>   
>   	err = rxe_cq_resize_queue(cq, cqe, uresp, udata);
>   	if (err) {
> -		rxe_dbg_cq(cq, "resize cq failed, err = %d", err);
> +		rxe_dbg_cq(cq, "resize cq failed, err = %d\n", err);
>   		goto err_out;
>   	}
>   
>   	return 0;
>   
>   err_out:
> -	rxe_err_cq(cq, "returned err = %d", err);
> +	rxe_err_cq(cq, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -1202,18 +1202,18 @@ static int rxe_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
>   	 */
>   	if (atomic_read(&cq->num_wq)) {
>   		err = -EINVAL;
> -		rxe_dbg_cq(cq, "still in use");
> +		rxe_dbg_cq(cq, "still in use\n");
>   		goto err_out;
>   	}
>   
>   	err = rxe_cleanup(cq);
>   	if (err)
> -		rxe_err_cq(cq, "cleanup failed, err = %d", err);
> +		rxe_err_cq(cq, "cleanup failed, err = %d\n", err);
>   
>   	return 0;
>   
>   err_out:
> -	rxe_err_cq(cq, "returned err = %d", err);
> +	rxe_err_cq(cq, "returned err = %d\n", err);
>   	return err;
>   }
>   
> @@ -1231,7 +1231,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
>   
>   	err = rxe_add_to_pool(&rxe->mr_pool, mr);
>   	if (err) {
> -		rxe_dbg_dev(rxe, "unable to create mr");
> +		rxe_dbg_dev(rxe, "unable to create mr\n");
>   		goto err_free;
>   	}
>   
> @@ -1245,7 +1245,7 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
>   
>   err_free:
>   	kfree(mr);
> -	rxe_err_pd(pd, "returned err = %d", err);
> +	rxe_err_pd(pd, "returned err = %d\n", err);
>   	return ERR_PTR(err);
>   }
>   
> @@ -1259,7 +1259,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
>   	int err, cleanup_err;
>   
>   	if (access & ~RXE_ACCESS_SUPPORTED_MR) {
> -		rxe_err_pd(pd, "access = %#x not supported (%#x)", access,
> +		rxe_err_pd(pd, "access = %#x not supported (%#x)\n", access,
>   				RXE_ACCESS_SUPPORTED_MR);
>   		return ERR_PTR(-EOPNOTSUPP);
>   	}
> @@ -1270,7 +1270,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
>   
>   	err = rxe_add_to_pool(&rxe->mr_pool, mr);
>   	if (err) {
> -		rxe_dbg_pd(pd, "unable to create mr");
> +		rxe_dbg_pd(pd, "unable to create mr\n");
>   		goto err_free;
>   	}
>   
> @@ -1280,7 +1280,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
>   
>   	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
>   	if (err) {
> -		rxe_dbg_mr(mr, "reg_user_mr failed, err = %d", err);
> +		rxe_dbg_mr(mr, "reg_user_mr failed, err = %d\n", err);
>   		goto err_cleanup;
>   	}
>   
> @@ -1290,10 +1290,10 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
>   err_cleanup:
>   	cleanup_err = rxe_cleanup(mr);
>   	if (cleanup_err)
> -		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
> +		rxe_err_mr(mr, "cleanup failed, err = %d\n", cleanup_err);
>   err_free:
>   	kfree(mr);
> -	rxe_err_pd(pd, "returned err = %d", err);
> +	rxe_err_pd(pd, "returned err = %d\n", err);
>   	return ERR_PTR(err);
>   }
>   
> @@ -1310,7 +1310,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
>   	 * rereg_pd and rereg_access
>   	 */
>   	if (flags & ~RXE_MR_REREG_SUPPORTED) {
> -		rxe_err_mr(mr, "flags = %#x not supported", flags);
> +		rxe_err_mr(mr, "flags = %#x not supported\n", flags);
>   		return ERR_PTR(-EOPNOTSUPP);
>   	}
>   
> @@ -1322,7 +1322,7 @@ static struct ib_mr *rxe_rereg_user_mr(struct ib_mr *ibmr, int flags,
>   
>   	if (flags & IB_MR_REREG_ACCESS) {
>   		if (access & ~RXE_ACCESS_SUPPORTED_MR) {
> -			rxe_err_mr(mr, "access = %#x not supported", access);
> +			rxe_err_mr(mr, "access = %#x not supported\n", access);
>   			return ERR_PTR(-EOPNOTSUPP);
>   		}
>   		mr->access = access;
> @@ -1341,7 +1341,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>   
>   	if (mr_type != IB_MR_TYPE_MEM_REG) {
>   		err = -EINVAL;
> -		rxe_dbg_pd(pd, "mr type %d not supported, err = %d",
> +		rxe_dbg_pd(pd, "mr type %d not supported, err = %d\n",
>   			   mr_type, err);
>   		goto err_out;
>   	}
> @@ -1360,7 +1360,7 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>   
>   	err = rxe_mr_init_fast(max_num_sg, mr);
>   	if (err) {
> -		rxe_dbg_mr(mr, "alloc_mr failed, err = %d", err);
> +		rxe_dbg_mr(mr, "alloc_mr failed, err = %d\n", err);
>   		goto err_cleanup;
>   	}
>   
> @@ -1370,11 +1370,11 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>   err_cleanup:
>   	cleanup_err = rxe_cleanup(mr);
>   	if (cleanup_err)
> -		rxe_err_mr(mr, "cleanup failed, err = %d", err);
> +		rxe_err_mr(mr, "cleanup failed, err = %d\n", err);
>   err_free:
>   	kfree(mr);
>   err_out:
> -	rxe_err_pd(pd, "returned err = %d", err);
> +	rxe_err_pd(pd, "returned err = %d\n", err);
>   	return ERR_PTR(err);
>   }
>   
> @@ -1386,19 +1386,19 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>   	/* See IBA 10.6.7.2.6 */
>   	if (atomic_read(&mr->num_mw) > 0) {
>   		err = -EINVAL;
> -		rxe_dbg_mr(mr, "mr has mw's bound");
> +		rxe_dbg_mr(mr, "mr has mw's bound\n");
>   		goto err_out;
>   	}
>   
>   	cleanup_err = rxe_cleanup(mr);
>   	if (cleanup_err)
> -		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
> +		rxe_err_mr(mr, "cleanup failed, err = %d\n", cleanup_err);
>   
>   	kfree_rcu_mightsleep(mr);
>   	return 0;
>   
>   err_out:
> -	rxe_err_mr(mr, "returned err = %d", err);
> +	rxe_err_mr(mr, "returned err = %d\n", err);
>   	return err;
>   }
>   

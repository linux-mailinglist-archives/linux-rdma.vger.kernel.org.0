Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8A26BE4FF
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Mar 2023 10:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCQJKL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Mar 2023 05:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjCQJJv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Mar 2023 05:09:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE3013DC8
        for <linux-rdma@vger.kernel.org>; Fri, 17 Mar 2023 02:09:33 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PdJGf4vmPzKnVV;
        Fri, 17 Mar 2023 17:09:14 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 17 Mar
 2023 17:08:56 +0800
Subject: Re: [PATCH for-next] RDMA/bnxt_re: Add resize_cq support
To:     Selvin Xavier <selvin.xavier@broadcom.com>, <leon@kernel.org>,
        <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>
References: <1678868215-23626-1-git-send-email-selvin.xavier@broadcom.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <2b1e2cd5-4843-b1d9-5ac0-60eefc57d26e@huawei.com>
Date:   Fri, 17 Mar 2023 17:08:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1678868215-23626-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/3/15 16:16, Selvin Xavier wrote:
> Add resize_cq verb support for user space CQs. Resize operation for
> kernel CQs are not supported now.
> 
> Driver should free the current CQ only after user library polls
> for all the completions and switch to new CQ. So after the resize_cq
> is returned from the driver, user libray polls for existing completions

libray -> library

> and store it as temporary data. Once library reaps all completions in the
> current CQ, it invokes the ibv_cmd_poll_cq to inform the driver about
> the resize_cq completion. Adding a check for user CQs in driver's
> poll_cq and complete the resize operation for user CQs.
> Updating uverbs_cmd_mask with poll_cq to support this.
> 
> User library changes are available in this pull request.
> https://github.com/linux-rdma/rdma-core/pull/1315
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 109 +++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |   3 +
>  drivers/infiniband/hw/bnxt_re/main.c     |   2 +
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c |  44 +++++++++++++
>  drivers/infiniband/hw/bnxt_re/qplib_fp.h |   5 ++
>  include/uapi/rdma/bnxt_re-abi.h          |   4 ++
>  6 files changed, 167 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index 989edc7..e86afec 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -2912,6 +2912,106 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  	return rc;
>  }
>  
> +static void bnxt_re_resize_cq_complete(struct bnxt_re_cq *cq)
> +{
> +	struct bnxt_re_dev *rdev = cq->rdev;
> +
> +	bnxt_qplib_resize_cq_complete(&rdev->qplib_res, &cq->qplib_cq);
> +
> +	cq->qplib_cq.max_wqe = cq->resize_cqe;
> +	if (cq->resize_umem) {
> +		ib_umem_release(cq->umem);
> +		cq->umem = cq->resize_umem;
> +		cq->resize_umem = NULL;
> +		cq->resize_cqe = 0;
> +	}
> +}
> +
> +int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata)
> +{
> +	struct bnxt_qplib_sg_info sg_info = {};
> +	struct bnxt_qplib_dpi *orig_dpi = NULL;
> +	struct bnxt_qplib_dev_attr *dev_attr;
> +	struct bnxt_re_ucontext *uctx = NULL;
> +	struct bnxt_re_resize_cq_req req;
> +	struct bnxt_re_dev *rdev;
> +	struct bnxt_re_cq *cq;
> +	int rc, entries;
> +
> +	cq =  container_of(ibcq, struct bnxt_re_cq, ib_cq);
> +	rdev = cq->rdev;
> +	dev_attr = &rdev->dev_attr;
> +	if (!ibcq->uobject) {
> +		ibdev_err(&rdev->ibdev, "Kernel CQ Resize not supported");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (cq->resize_umem) {
> +		ibdev_err(&rdev->ibdev, "Resize CQ %#x failed - Busy",
> +			  cq->qplib_cq.id);
> +		return -EBUSY;
> +	}

Does above cq->resize_umem checking has any conconcurrent protection
again the bnxt_re_resize_cq_complete() called by bnxt_re_poll_cq()?

bnxt_re_resize_cq() seems like a control path operation, while
bnxt_re_poll_cq() seems like a data path operation, I am not sure
there is any conconcurrent protection between them.

> +
> +	/* Check the requested cq depth out of supported depth */
> +	if (cqe < 1 || cqe > dev_attr->max_cq_wqes) {
> +		ibdev_err(&rdev->ibdev, "Resize CQ %#x failed - out of range cqe %d",
> +			  cq->qplib_cq.id, cqe);
> +		return -EINVAL;
> +	}
> +
> +	entries = roundup_pow_of_two(cqe + 1);
> +	if (entries > dev_attr->max_cq_wqes + 1)
> +		entries = dev_attr->max_cq_wqes + 1;
> +
> +	uctx = rdma_udata_to_drv_context(udata, struct bnxt_re_ucontext,
> +					 ib_uctx);
> +	/* uverbs consumer */
> +	if (ib_copy_from_udata(&req, udata, sizeof(req))) {
> +		rc = -EFAULT;
> +		goto fail;
> +	}
> +
> +	cq->resize_umem = ib_umem_get(&rdev->ibdev, req.cq_va,
> +				      entries * sizeof(struct cq_base),
> +				      IB_ACCESS_LOCAL_WRITE);
> +	if (IS_ERR(cq->resize_umem)) {
> +		rc = PTR_ERR(cq->resize_umem);
> +		cq->resize_umem = NULL;
> +		ibdev_err(&rdev->ibdev, "%s: ib_umem_get failed! rc = %d\n",
> +			  __func__, rc);
> +		goto fail;
> +	}
> +	cq->resize_cqe = entries;
> +	memcpy(&sg_info, &cq->qplib_cq.sg_info, sizeof(sg_info));
> +	orig_dpi = cq->qplib_cq.dpi;
> +
> +	cq->qplib_cq.sg_info.umem = cq->resize_umem;
> +	cq->qplib_cq.sg_info.pgsize = PAGE_SIZE;
> +	cq->qplib_cq.sg_info.pgshft = PAGE_SHIFT;
> +	cq->qplib_cq.dpi = &uctx->dpi;
> +
> +	rc = bnxt_qplib_resize_cq(&rdev->qplib_res, &cq->qplib_cq, entries);
> +	if (rc) {
> +		ibdev_err(&rdev->ibdev, "Resize HW CQ %#x failed!",
> +			  cq->qplib_cq.id);
> +		goto fail;
> +	}
> +
> +	cq->ib_cq.cqe = cq->resize_cqe;
> +
> +	return 0;
> +
> +fail:
> +	if (cq->resize_umem) {
> +		ib_umem_release(cq->resize_umem);
> +		cq->resize_umem = NULL;
> +		cq->resize_cqe = 0;
> +		memcpy(&cq->qplib_cq.sg_info, &sg_info, sizeof(sg_info));
> +		cq->qplib_cq.dpi = orig_dpi;
> +	}
> +	return rc;
> +}
> +
>  static u8 __req_to_ib_wc_status(u8 qstatus)
>  {
>  	switch (qstatus) {
> @@ -3425,6 +3525,15 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
>  	struct bnxt_re_sqp_entries *sqp_entry = NULL;
>  	unsigned long flags;
>  
> +	/* User CQ; the only processing we do is to
> +	 * complete any pending CQ resize operation.
> +	 */
> +	if (cq->umem) {
> +		if (cq->resize_umem)
> +			bnxt_re_resize_cq_complete(cq);
> +		return 0;
> +	}
> +
>  	spin_lock_irqsave(&cq->cq_lock, flags);
>  	budget = min_t(u32, num_entries, cq->max_cql);
>  	num_entries = budget;
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> index 9432626..31f7e34 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
> @@ -104,6 +104,8 @@ struct bnxt_re_cq {
>  #define MAX_CQL_PER_POLL	1024
>  	u32			max_cql;
>  	struct ib_umem		*umem;
> +	struct ib_umem		*resize_umem;
> +	int			resize_cqe;
>  };
>  
>  struct bnxt_re_mr {
> @@ -191,6 +193,7 @@ int bnxt_re_post_recv(struct ib_qp *qp, const struct ib_recv_wr *recv_wr,
>  		      const struct ib_recv_wr **bad_recv_wr);
>  int bnxt_re_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  		      struct ib_udata *udata);
> +int bnxt_re_resize_cq(struct ib_cq *ibcq, int cqe, struct ib_udata *udata);
>  int bnxt_re_destroy_cq(struct ib_cq *cq, struct ib_udata *udata);
>  int bnxt_re_poll_cq(struct ib_cq *cq, int num_entries, struct ib_wc *wc);
>  int bnxt_re_req_notify_cq(struct ib_cq *cq, enum ib_cq_notify_flags flags);
> diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> index c5867e7..48bbba7 100644
> --- a/drivers/infiniband/hw/bnxt_re/main.c
> +++ b/drivers/infiniband/hw/bnxt_re/main.c
> @@ -553,6 +553,7 @@ static const struct ib_device_ops bnxt_re_dev_ops = {
>  	.query_srq = bnxt_re_query_srq,
>  	.reg_user_mr = bnxt_re_reg_user_mr,
>  	.req_notify_cq = bnxt_re_req_notify_cq,
> +	.resize_cq = bnxt_re_resize_cq,
>  	INIT_RDMA_OBJ_SIZE(ib_ah, bnxt_re_ah, ib_ah),
>  	INIT_RDMA_OBJ_SIZE(ib_cq, bnxt_re_cq, ib_cq),
>  	INIT_RDMA_OBJ_SIZE(ib_pd, bnxt_re_pd, ib_pd),
> @@ -584,6 +585,7 @@ static int bnxt_re_register_ib(struct bnxt_re_dev *rdev)
>  		return ret;
>  
>  	dma_set_max_seg_size(&rdev->en_dev->pdev->dev, UINT_MAX);
> +	ibdev->uverbs_cmd_mask |= BIT_ULL(IB_USER_VERBS_CMD_POLL_CQ);
>  	return ib_register_device(ibdev, "bnxt_re%d", &rdev->en_dev->pdev->dev);
>  }
>  
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index 96e581c..1d769a3 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -2100,6 +2100,50 @@ int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
>  	return rc;
>  }
>  
> +void bnxt_qplib_resize_cq_complete(struct bnxt_qplib_res *res,
> +				   struct bnxt_qplib_cq *cq)
> +{
> +	bnxt_qplib_free_hwq(res, &cq->hwq);
> +	memcpy(&cq->hwq, &cq->resize_hwq, sizeof(cq->hwq));
> +}
> +
> +int bnxt_qplib_resize_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
> +			 int new_cqes)
> +{
> +	struct bnxt_qplib_hwq_attr hwq_attr = {};
> +	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
> +	struct creq_resize_cq_resp resp = {};
> +	struct cmdq_resize_cq req = {};
> +	struct bnxt_qplib_pbl *pbl;
> +	u32 pg_sz, lvl, new_sz;
> +	u16 cmd_flags = 0;
> +	int rc;
> +
> +	RCFW_CMD_PREP(req, RESIZE_CQ, cmd_flags);
> +	hwq_attr.sginfo = &cq->sg_info;
> +	hwq_attr.res = res;
> +	hwq_attr.depth = new_cqes;
> +	hwq_attr.stride = sizeof(struct cq_base);
> +	hwq_attr.type = HWQ_TYPE_QUEUE;
> +	rc = bnxt_qplib_alloc_init_hwq(&cq->resize_hwq, &hwq_attr);
> +	if (rc)
> +		return rc;
> +
> +	req.cq_cid = cpu_to_le32(cq->id);
> +	pbl = &cq->resize_hwq.pbl[PBL_LVL_0];
> +	pg_sz = bnxt_qplib_base_pg_size(&cq->resize_hwq);
> +	lvl = (cq->resize_hwq.level << CMDQ_RESIZE_CQ_LVL_SFT) &
> +				       CMDQ_RESIZE_CQ_LVL_MASK;
> +	new_sz = (new_cqes << CMDQ_RESIZE_CQ_NEW_CQ_SIZE_SFT) &
> +		  CMDQ_RESIZE_CQ_NEW_CQ_SIZE_MASK;
> +	req.new_cq_size_pg_size_lvl = cpu_to_le32(new_sz | pg_sz | lvl);
> +	req.new_pbl = cpu_to_le64(pbl->pg_map_arr[0]);
> +
> +	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
> +					  (void *)&resp, NULL, 0);
> +	return rc;

	return bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
					    (void *)&resp, NULL, 0);

> +}
> +
>  int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq)
>  {
>  	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> index 0375019..d74d5ea 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
> @@ -400,6 +400,7 @@ struct bnxt_qplib_cq {
>  	u16				count;
>  	u16				period;
>  	struct bnxt_qplib_hwq		hwq;
> +	struct bnxt_qplib_hwq		resize_hwq;
>  	u32				cnq_hw_ring_id;
>  	struct bnxt_qplib_nq		*nq;
>  	bool				resize_in_progress;
> @@ -532,6 +533,10 @@ void bnxt_qplib_post_recv_db(struct bnxt_qplib_qp *qp);
>  int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
>  			 struct bnxt_qplib_swqe *wqe);
>  int bnxt_qplib_create_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq);
> +int bnxt_qplib_resize_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq,
> +			 int new_cqes);
> +void bnxt_qplib_resize_cq_complete(struct bnxt_qplib_res *res,
> +				   struct bnxt_qplib_cq *cq);
>  int bnxt_qplib_destroy_cq(struct bnxt_qplib_res *res, struct bnxt_qplib_cq *cq);
>  int bnxt_qplib_poll_cq(struct bnxt_qplib_cq *cq, struct bnxt_qplib_cqe *cqe,
>  		       int num, struct bnxt_qplib_qp **qp);
> diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
> index b1de99b..f761e75 100644
> --- a/include/uapi/rdma/bnxt_re-abi.h
> +++ b/include/uapi/rdma/bnxt_re-abi.h
> @@ -96,6 +96,10 @@ struct bnxt_re_cq_resp {
>  	__u32 rsvd;
>  };
>  
> +struct bnxt_re_resize_cq_req {
> +	__u64 cq_va;
> +};
> +
>  struct bnxt_re_qp_req {
>  	__aligned_u64 qpsva;
>  	__aligned_u64 qprva;
> 

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C728CF10A4
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 08:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbfKFHxK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 02:53:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55216 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfKFHxK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 02:53:10 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA67oTJJ025456;
        Wed, 6 Nov 2019 07:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=B/R023UKs9YVUEgJmFZmY7kO4mAf/02Z9ZlQE16navE=;
 b=ZaSSgJrIFQCfUZe5LNZmEjxZcsKN3Cb4pzrtveFEzVfHCtrjp+A64/TT1yQI63+Y3IXI
 mNga3W+Pa7asx6y19NvMFG53UQiC2x/3uV+OZlHAZo8PC8PyvT/XyMaqkOFHU392VJSy
 pp3ySDPp76yJWSujunAWptBzvxyvj7R0l3jN4yF8ETWeMps1J0gznr5giTrzLpjY7cG8
 uHgMoBmp2WIYAvdSdOFLRzZz8Miyhl6qcXy/L8ESjQ2ulZP4hMFxH65Cd7ekiLOp9Fcw
 XnfvzC94i/yrmgNmn/EYoWs2m6/vN5SZk00/UXwq6PzlFM+/BI3gXK2MsD7rZ2t0Fm5j fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2w12erbuxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 07:53:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA67qtGI070297;
        Wed, 6 Nov 2019 07:53:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2w35pqfdjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 07:53:06 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA67r5aL026440;
        Wed, 6 Nov 2019 07:53:05 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Nov 2019 07:53:04 +0000
Date:   Wed, 6 Nov 2019 10:52:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     michal.kalderon@marvell.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/qedr: Add doorbell overflow recovery support
Message-ID: <20191106075259.GA22565@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060081
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Michal Kalderon,

This is a semi-automatic email about new static checker warnings.

The patch 9bcc6597f47b: "RDMA/qedr: Add doorbell overflow recovery 
support" from Oct 30, 2019, leads to the following Smatch complaint:

    drivers/infiniband/hw/qedr/verbs.c:1046 qedr_create_cq()
    warn: variable dereferenced before check 'ctx' (see line 970)

drivers/infiniband/hw/qedr/verbs.c
   905  int qedr_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
   906                     struct ib_udata *udata)
   907  {
   908          struct ib_device *ibdev = ibcq->device;
   909          struct qedr_ucontext *ctx = rdma_udata_to_drv_context(
                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   910                  udata, struct qedr_ucontext, ibucontext);
   911          struct qed_rdma_destroy_cq_out_params destroy_oparams;
   912          struct qed_rdma_destroy_cq_in_params destroy_iparams;
   913          struct qedr_dev *dev = get_qedr_dev(ibdev);
   914          struct qed_rdma_create_cq_in_params params;
   915          struct qedr_create_cq_ureq ureq = {};
   916          int vector = attr->comp_vector;
   917          int entries = attr->cqe;
   918          struct qedr_cq *cq = get_qedr_cq(ibcq);
   919          int chain_entries;
   920          u32 db_offset;
   921          int page_cnt;
   922          u64 pbl_ptr;
   923          u16 icid;
   924          int rc;
   925  
   926          DP_DEBUG(dev, QEDR_MSG_INIT,
   927                   "create_cq: called from %s. entries=%d, vector=%d\n",
   928                   udata ? "User Lib" : "Kernel", entries, vector);
   929  
   930          if (entries > QEDR_MAX_CQES) {
   931                  DP_ERR(dev,
   932                         "create cq: the number of entries %d is too high. Must be equal or below %d.\n",
   933                         entries, QEDR_MAX_CQES);
   934                  return -EINVAL;
   935          }
   936  
   937          chain_entries = qedr_align_cq_entries(entries);
   938          chain_entries = min_t(int, chain_entries, QEDR_MAX_CQES);
   939  
   940          /* calc db offset. user will add DPI base, kernel will add db addr */
   941          db_offset = DB_ADDR_SHIFT(DQ_PWM_OFFSET_UCM_RDMA_CQ_CONS_32BIT);
   942  
   943          if (udata) {
   944                  if (ib_copy_from_udata(&ureq, udata, min(sizeof(ureq),
   945                                                           udata->inlen))) {
   946                          DP_ERR(dev,
   947                                 "create cq: problem copying data from user space\n");
   948                          goto err0;
   949                  }
   950  
   951                  if (!ureq.len) {
   952                          DP_ERR(dev,
   953                                 "create cq: cannot create a cq with 0 entries\n");
   954                          goto err0;
   955                  }
   956  
   957                  cq->cq_type = QEDR_CQ_TYPE_USER;
   958  
   959                  rc = qedr_init_user_queue(udata, dev, &cq->q, ureq.addr,
   960                                            ureq.len, true,
   961                                            IB_ACCESS_LOCAL_WRITE,
   962                                            1, 1);
   963                  if (rc)
   964                          goto err0;
   965  
   966                  pbl_ptr = cq->q.pbl_tbl->pa;
   967                  page_cnt = cq->q.pbl_info.num_pbes;
   968  
   969			cq->ibcq.cqe = chain_entries;
   970			cq->q.db_addr = ctx->dpi_addr + db_offset;
                                        ^^^^^^^^^^^^^
New unchecked dereference.

   971		} else {
   972			cq->cq_type = QEDR_CQ_TYPE_KERNEL;
   973	
   974			rc = dev->ops->common->chain_alloc(dev->cdev,
   975							   QED_CHAIN_USE_TO_CONSUME,
   976							   QED_CHAIN_MODE_PBL,
   977							   QED_CHAIN_CNT_TYPE_U32,
   978							   chain_entries,
   979							   sizeof(union rdma_cqe),
   980							   &cq->pbl, NULL);
   981			if (rc)
   982				goto err0;
   983	
   984			page_cnt = qed_chain_get_page_cnt(&cq->pbl);
   985			pbl_ptr = qed_chain_get_pbl_phys(&cq->pbl);
   986			cq->ibcq.cqe = cq->pbl.capacity;
   987		}
   988	
   989		qedr_init_cq_params(cq, ctx, dev, vector, chain_entries, page_cnt,
   990				    pbl_ptr, &params);
   991	
   992		rc = dev->ops->rdma_create_cq(dev->rdma_ctx, &params, &icid);
   993		if (rc)
   994			goto err1;
   995	
   996		cq->icid = icid;
   997		cq->sig = QEDR_CQ_MAGIC_NUMBER;
   998		spin_lock_init(&cq->cq_lock);
   999	
  1000		if (udata) {
  1001			rc = qedr_copy_cq_uresp(dev, cq, udata, db_offset);
  1002			if (rc)
  1003				goto err2;
  1004	
  1005			rc = qedr_db_recovery_add(dev, cq->q.db_addr,
  1006						  &cq->q.db_rec_data->db_data,
  1007						  DB_REC_WIDTH_64B,
  1008						  DB_REC_USER);
  1009			if (rc)
  1010				goto err2;
  1011	
  1012		} else {
  1013			/* Generate doorbell address. */
  1014			cq->db.data.icid = cq->icid;
  1015			cq->db_addr = dev->db_addr + db_offset;
  1016			cq->db.data.params = DB_AGG_CMD_SET <<
  1017			    RDMA_PWM_VAL32_DATA_AGG_CMD_SHIFT;
  1018	
  1019			/* point to the very last element, passing it we will toggle */
  1020			cq->toggle_cqe = qed_chain_get_last_elem(&cq->pbl);
  1021			cq->pbl_toggle = RDMA_CQE_REQUESTER_TOGGLE_BIT_MASK;
  1022			cq->latest_cqe = NULL;
  1023			consume_cqe(cq);
  1024			cq->cq_cons = qed_chain_get_cons_idx_u32(&cq->pbl);
  1025	
  1026			rc = qedr_db_recovery_add(dev, cq->db_addr, &cq->db.data,
  1027						  DB_REC_WIDTH_64B, DB_REC_KERNEL);
  1028			if (rc)
  1029				goto err2;
  1030		}
  1031	
  1032		DP_DEBUG(dev, QEDR_MSG_CQ,
  1033			 "create cq: icid=0x%0x, addr=%p, size(entries)=0x%0x\n",
  1034			 cq->icid, cq, params.cq_size);
  1035	
  1036		return 0;
  1037	
  1038	err2:
  1039		destroy_iparams.icid = cq->icid;
  1040		dev->ops->rdma_destroy_cq(dev->rdma_ctx, &destroy_iparams,
  1041					  &destroy_oparams);
  1042	err1:
  1043		if (udata) {
  1044			qedr_free_pbl(dev, &cq->q.pbl_info, cq->q.pbl_tbl);
  1045			ib_umem_release(cq->q.umem);
  1046			if (ctx)
                            ^^^
Too late.

  1047				rdma_user_mmap_entry_remove(&ctx->ibucontext,
  1048							    cq->q.db_mmap_entry);

regards,
dan carpenter

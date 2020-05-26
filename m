Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347F51E2035
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 12:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbgEZKz2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 06:55:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46666 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388622AbgEZKz2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 May 2020 06:55:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QAfZtB117438;
        Tue, 26 May 2020 10:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=b+Z7BzlfHYydC8vdXeqgRhjC0gMT3xIY4rsvp8/fMjY=;
 b=VhcA4xIXS7lFkYDkhakP6M+k87num3gum0my4nO/gRdDX39BCSLWj/iyZaWQPSll3Nn8
 xwEM+PaVNaWwYm3Z12MTgpTZU7P2oNVroyzbrLDCJwaej8IisaUYWdxQVhclSzKblFTO
 tCtXSvtVaeFSOBb4ecF8jQhRM3xFh3llU/KcbHQQBOb/AvMKMmUFf1vbpV9dF8dlL3ya
 KEkW3t/LTj+5Iaxxxgf9TZ/javYrb4b+FAG7XAyGMTamuotNtt2c06HlJ3Jl4jn2qRqm
 7UL4nnbw9yb4GmyaOyLX3GBNvEXB0S7u4aVfspvaSDg/ql+4YmoN80FzcSz5fe+rJVWw lg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 316u8qs0t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 10:55:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04QAbYhJ143710;
        Tue, 26 May 2020 10:53:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 317dks7rj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 10:53:25 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04QArOln014275;
        Tue, 26 May 2020 10:53:25 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 May 2020 03:53:24 -0700
Date:   Tue, 26 May 2020 13:53:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     bjorn.topel@intel.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] mlx5, xsk: Migrate to new MEM_TYPE_XSK_BUFF_POOL
Message-ID: <20200526105319.GA182291@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9632 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=49 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260081
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9632 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 spamscore=0 cotscore=-2147483648 suspectscore=49
 phishscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005260081
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Björn Töpel,

This is a semi-automatic email about new static checker warnings.

The patch 39d6443c8daf: "mlx5, xsk: Migrate to new
MEM_TYPE_XSK_BUFF_POOL" from May 20, 2020, leads to the following
Smatch complaint:

    drivers/net/ethernet/mellanox/mlx5/core/en_main.c:521 mlx5e_alloc_rq()
    error: we previously assumed 'rq->umem' could be null (see line 396)

drivers/net/ethernet/mellanox/mlx5/core/en_main.c
   365  static int mlx5e_alloc_rq(struct mlx5e_channel *c,
   366                            struct mlx5e_params *params,
   367                            struct mlx5e_xsk_param *xsk,
   368                            struct xdp_umem *umem,
   369                            struct mlx5e_rq_param *rqp,
   370                            struct mlx5e_rq *rq)
   371  {
   372          struct page_pool_params pp_params = { 0 };
   373          struct mlx5_core_dev *mdev = c->mdev;
   374          void *rqc = rqp->rqc;
   375          void *rqc_wq = MLX5_ADDR_OF(rqc, rqc, wq);
   376          u32 rq_xdp_ix;
   377          u32 pool_size;
   378          int wq_sz;
   379          int err;
   380          int i;
   381  
   382          rqp->wq.db_numa_node = cpu_to_node(c->cpu);
   383  
   384          rq->wq_type = params->rq_wq_type;
   385          rq->pdev    = c->pdev;
   386          rq->netdev  = c->netdev;
   387          rq->tstamp  = c->tstamp;
   388          rq->clock   = &mdev->clock;
   389          rq->channel = c;
   390          rq->ix      = c->ix;
   391          rq->mdev    = mdev;
   392          rq->hw_mtu  = MLX5E_SW2HW_MTU(params, params->sw_mtu);
   393          rq->xdpsq   = &c->rq_xdpsq;
   394          rq->umem    = umem;
                ^^^^^^^^^^^^^^^^^^
   395	
   396		if (rq->umem)
                    ^^^^^^^^
Check

   397			rq->stats = &c->priv->channel_stats[c->ix].xskrq;
   398		else
   399			rq->stats = &c->priv->channel_stats[c->ix].rq;
   400		INIT_WORK(&rq->recover_work, mlx5e_rq_err_cqe_work);
   401	
   402		if (params->xdp_prog)
   403			bpf_prog_inc(params->xdp_prog);
   404		rq->xdp_prog = params->xdp_prog;
   405	
   406		rq_xdp_ix = rq->ix;
   407		if (xsk)
   408			rq_xdp_ix += params->num_channels * MLX5E_RQ_GROUP_XSK;
   409		err = xdp_rxq_info_reg(&rq->xdp_rxq, rq->netdev, rq_xdp_ix);
   410		if (err < 0)
   411			goto err_rq_wq_destroy;
   412	
   413		rq->buff.map_dir = rq->xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
   414		rq->buff.headroom = mlx5e_get_rq_headroom(mdev, params, xsk);
   415		pool_size = 1 << params->log_rq_mtu_frames;
   416	
   417		switch (rq->wq_type) {
   418		case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
   419			err = mlx5_wq_ll_create(mdev, &rqp->wq, rqc_wq, &rq->mpwqe.wq,
   420						&rq->wq_ctrl);
   421			if (err)
   422				return err;
   423	
   424			rq->mpwqe.wq.db = &rq->mpwqe.wq.db[MLX5_RCV_DBR];
   425	
   426			wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
   427	
   428			pool_size = MLX5_MPWRQ_PAGES_PER_WQE <<
   429				mlx5e_mpwqe_get_log_rq_size(params, xsk);
   430	
   431			rq->post_wqes = mlx5e_post_rx_mpwqes;
   432			rq->dealloc_wqe = mlx5e_dealloc_rx_mpwqe;
   433	
   434			rq->handle_rx_cqe = c->priv->profile->rx_handlers.handle_rx_cqe_mpwqe;
   435	#ifdef CONFIG_MLX5_EN_IPSEC
   436			if (MLX5_IPSEC_DEV(mdev)) {
   437				err = -EINVAL;
   438				netdev_err(c->netdev, "MPWQE RQ with IPSec offload not supported\n");
   439				goto err_rq_wq_destroy;
   440			}
   441	#endif
   442			if (!rq->handle_rx_cqe) {
   443				err = -EINVAL;
   444				netdev_err(c->netdev, "RX handler of MPWQE RQ is not set, err %d\n", err);
   445				goto err_rq_wq_destroy;
   446			}
   447	
   448			rq->mpwqe.skb_from_cqe_mpwrq = xsk ?
   449				mlx5e_xsk_skb_from_cqe_mpwrq_linear :
   450				mlx5e_rx_mpwqe_is_linear_skb(mdev, params, NULL) ?
   451					mlx5e_skb_from_cqe_mpwrq_linear :
   452					mlx5e_skb_from_cqe_mpwrq_nonlinear;
   453	
   454			rq->mpwqe.log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
   455			rq->mpwqe.num_strides =
   456				BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk));
   457	
   458			rq->buff.frame0_sz = (1 << rq->mpwqe.log_stride_sz);
   459	
   460			err = mlx5e_create_rq_umr_mkey(mdev, rq);
   461			if (err)
   462				goto err_rq_wq_destroy;
   463			rq->mkey_be = cpu_to_be32(rq->umr_mkey.key);
   464	
   465			err = mlx5e_rq_alloc_mpwqe_info(rq, c);
   466			if (err)
   467				goto err_free;
   468			break;
   469		default: /* MLX5_WQ_TYPE_CYCLIC */
   470			err = mlx5_wq_cyc_create(mdev, &rqp->wq, rqc_wq, &rq->wqe.wq,
   471						 &rq->wq_ctrl);
   472			if (err)
   473				return err;
   474	
   475			rq->wqe.wq.db = &rq->wqe.wq.db[MLX5_RCV_DBR];
   476	
   477			wq_sz = mlx5_wq_cyc_get_size(&rq->wqe.wq);
   478	
   479			rq->wqe.info = rqp->frags_info;
   480			rq->buff.frame0_sz = rq->wqe.info.arr[0].frag_stride;
   481	
   482			rq->wqe.frags =
   483				kvzalloc_node(array_size(sizeof(*rq->wqe.frags),
   484						(wq_sz << rq->wqe.info.log_num_frags)),
   485					      GFP_KERNEL, cpu_to_node(c->cpu));
   486			if (!rq->wqe.frags) {
   487				err = -ENOMEM;
   488				goto err_free;
   489			}
   490	
   491			err = mlx5e_init_di_list(rq, wq_sz, c->cpu);
   492			if (err)
   493				goto err_free;
   494	
   495			rq->post_wqes = mlx5e_post_rx_wqes;
   496			rq->dealloc_wqe = mlx5e_dealloc_rx_wqe;
   497	
   498	#ifdef CONFIG_MLX5_EN_IPSEC
   499			if (c->priv->ipsec)
   500				rq->handle_rx_cqe = mlx5e_ipsec_handle_rx_cqe;
   501			else
   502	#endif
   503				rq->handle_rx_cqe = c->priv->profile->rx_handlers.handle_rx_cqe;
   504			if (!rq->handle_rx_cqe) {
   505				err = -EINVAL;
   506				netdev_err(c->netdev, "RX handler of RQ is not set, err %d\n", err);
   507				goto err_free;
   508			}
   509	
   510			rq->wqe.skb_from_cqe = xsk ?
   511				mlx5e_xsk_skb_from_cqe_linear :
   512				mlx5e_rx_is_linear_skb(params, NULL) ?
   513					mlx5e_skb_from_cqe_linear :
   514					mlx5e_skb_from_cqe_nonlinear;
   515			rq->mkey_be = c->mkey_be;
   516		}
   517	
   518		if (xsk) {
   519			err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
   520							 MEM_TYPE_XSK_BUFF_POOL, NULL);
   521			xsk_buff_set_rxq_info(rq->umem, &rq->xdp_rxq);
                                              ^^^^^^^^
Unchecked dereference inside function call.

   522		} else {
   523			/* Create a page_pool and register it with rxq */

regards,
dan carpenter

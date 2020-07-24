Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8E222C31E
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 12:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgGXK3N (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 06:29:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47084 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgGXK3M (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 06:29:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OARQmr186355;
        Fri, 24 Jul 2020 10:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=yqSWeT/k+0r+SQ7/Tzof099jdXUb1EEcH6vxLjg9xTE=;
 b=HhIkb/RIcfeQku4kV7wSK8CTSXCZWVvQsfw4FGW00i50JSD+XVtZMg2txHoQ2MOKaZYX
 97sJv+ZfRjOFAkiP38xqoldjWrjBW481S+ywYohJ444W81HnygEBx2oZZNEUU7qxfaMi
 sK4mB8bp1Ez3M1Gt9Vm4XraZsnCV9i7oSdLJl1daPygZzXaqRy6JrudIeUg196McIWYF
 gVTOucNYPUSJ+YjlVeMZ6Jh0u4DiuaLwqH6PQPIqWuF7PE14OwA6yyTYR8MqpfIRRKaA
 Sw4Rq9gROCKnUg3uXfeCtiu+ajjllfH+1sOZv6sWR6UTBGCHBuLtJsf7kni7qAA0UCir 3A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32bs1mxd3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Jul 2020 10:29:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06OAT9Jg102368;
        Fri, 24 Jul 2020 10:29:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32fhy791q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 10:29:10 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06OAT2LN022291;
        Fri, 24 Jul 2020 10:29:02 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 03:29:01 -0700
Date:   Fri, 24 Jul 2020 13:28:57 +0300
From:   <dan.carpenter@oracle.com>
To:     devesh.sharma@broadcom.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/bnxt_re: Change wr posting logic to accommodate
 variable wqes
Message-ID: <20200724102857.GA319526@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=3
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9691 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240079
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Devesh Sharma,

The patch 2bb3c32c5c5f: "RDMA/bnxt_re: Change wr posting logic to
accommodate variable wqes" from Jul 15, 2020, leads to the following
static checker warning:

	drivers/infiniband/hw/bnxt_re/qplib_fp.c:1989 bnxt_qplib_post_recv()
	warn: struct type mismatch 'rq_wqe_hdr vs sq_sge'

drivers/infiniband/hw/bnxt_re/qplib_fp.c
  1945  int bnxt_qplib_post_recv(struct bnxt_qplib_qp *qp,
  1946                           struct bnxt_qplib_swqe *wqe)
  1947  {
  1948          struct bnxt_qplib_nq_work *nq_work = NULL;
  1949          struct bnxt_qplib_q *rq = &qp->rq;
  1950          struct rq_wqe_hdr *base_hdr;
                       ^^^^^^^^^^^^^^^^^^^^
  1951          struct rq_ext_hdr *ext_hdr;
                       ^^^^^^^^^^^^^^^^^^^
  1952          struct bnxt_qplib_hwq *hwq;
  1953          struct bnxt_qplib_swq *swq;
  1954          bool sch_handler = false;
  1955          u16 wqe_sz, idx;
  1956          u32 wqe_idx;
  1957          int rc = 0;
  1958  
  1959          hwq = &rq->hwq;
  1960          if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_RESET) {
  1961                  dev_err(&hwq->pdev->dev,
  1962                          "QPLIB: FP: QP (0x%x) is in the 0x%x state",
  1963                          qp->id, qp->state);
  1964                  rc = -EINVAL;
  1965                  goto done;
  1966          }
  1967  
  1968          if (bnxt_qplib_queue_full(rq, rq->dbinfo.max_slot)) {
  1969                  dev_err(&hwq->pdev->dev,
  1970                          "FP: QP (0x%x) RQ is full!\n", qp->id);
  1971                  rc = -EINVAL;
  1972                  goto done;
  1973          }
  1974  
  1975          swq = bnxt_qplib_get_swqe(rq, &wqe_idx);
  1976          swq->wr_id = wqe->wr_id;
  1977          swq->slots = rq->dbinfo.max_slot;
  1978  
  1979          if (qp->state == CMDQ_MODIFY_QP_NEW_STATE_ERR) {
  1980                  sch_handler = true;
  1981                  dev_dbg(&hwq->pdev->dev,
  1982                          "%s: Error QP. Scheduling for poll_cq\n", __func__);
  1983                  goto queue_err;
  1984          }
  1985  
  1986          idx = 0;
  1987          base_hdr = bnxt_qplib_get_prod_qe(hwq, idx++);
  1988          ext_hdr = bnxt_qplib_get_prod_qe(hwq, idx++);
  1989          memset(base_hdr, 0, sizeof(struct sq_sge));
                                           ^^^^^^^^^^^^^
  1990          memset(ext_hdr, 0, sizeof(struct sq_sge));
                                          ^^^^^^^^^^^^^
The types are different.  Was this intentional?

  1991          wqe_sz = (sizeof(struct rq_wqe_hdr) +
  1992          wqe->num_sge * sizeof(struct sq_sge)) >> 4;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Also this line could be indented another tab.

  1993          bnxt_qplib_put_sges(hwq, wqe->sg_list, wqe->num_sge, &idx);
  1994          if (!wqe->num_sge) {
  1995                  struct sq_sge *sge;
  1996  
  1997                  sge = bnxt_qplib_get_prod_qe(hwq, idx++);
  1998                  sge->size = 0;
  1999                  wqe_sz++;
  2000          }
  2001          base_hdr->wqe_type = wqe->type;

regards,
dan carpenter

Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D153E2B1707
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 09:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgKMIPn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 03:15:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35774 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMIPn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Nov 2020 03:15:43 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD8E1Xc049282;
        Fri, 13 Nov 2020 08:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=kJkONnTy4qTACnft4+048FilnZRaTNqdgXCvN93D+hI=;
 b=FMXjz5NV9YRmYPrD0qckN6gS+rWO/kD7DFoVqTYiFJ3PwqmH2LLU1/m2Gy2FsVr7XiWq
 OLeP/MVIegEhz7J8Lh6IS4uuDRG8wnkv3VORkzVlO5bSrb/1tVRkfXJ2iToWOHOKOi2W
 hKbmQhYNbzlsTSCvOvzanrnSjDhhFFvt63KzMh/zkY0o5ACNTvoNMnfzhq38l9Mxj4Jp
 EZltwOMDa76GTZGxda4WZq3SvG2sd6qYnSuXW6YemhRK7uqHydQ7PYSyqFIDzEJiXtFK
 USz+SDOm2Vg0Zk8UJkJ/iIx/Ke8hGg8U5qeAdY+JgoQymz4TsW8oO5SArR2P/G6xBJV0 uw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34nh3b9fje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 08:15:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD8FEE5053262;
        Fri, 13 Nov 2020 08:15:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34rt57exys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 08:15:41 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AD8Fehd032184;
        Fri, 13 Nov 2020 08:15:40 GMT
Received: from mwanda (/10.175.206.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Nov 2020 00:15:39 -0800
Date:   Fri, 13 Nov 2020 11:15:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     devesh.sharma@broadcom.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/bnxt_re: Fix broken RoCE driver due to recent L2
 driver changes
Message-ID: <20201113081534.GA50833@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=3 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=3
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130049
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Devesh Sharma,

The patch 6e04b1035689: "RDMA/bnxt_re: Fix broken RoCE driver due to
recent L2 driver changes" from May 25, 2018, leads to the following
static checker warning:

	drivers/infiniband/hw/bnxt_re/qplib_fp.c:471 bnxt_qplib_nq_start_irq()
	warn: 'nq->msix_vec' not released on lines: 471.

drivers/infiniband/hw/bnxt_re/qplib_fp.c
   441  int bnxt_qplib_nq_start_irq(struct bnxt_qplib_nq *nq, int nq_indx,
   442                              int msix_vector, bool need_init)
   443  {
   444          int rc;
   445  
   446          if (nq->requested)
   447                  return -EFAULT;
   448  
   449          nq->msix_vec = msix_vector;
   450          if (need_init)
   451                  tasklet_setup(&nq->nq_tasklet, bnxt_qplib_service_nq);
   452          else
   453                  tasklet_enable(&nq->nq_tasklet);
   454  
   455          snprintf(nq->name, sizeof(nq->name), "bnxt_qplib_nq-%d", nq_indx);
   456          rc = request_irq(nq->msix_vec, bnxt_qplib_nq_irq, 0, nq->name, nq);
   457          if (rc)
   458                  return rc;
   459  
   460          cpumask_clear(&nq->mask);
   461          cpumask_set_cpu(nq_indx, &nq->mask);
   462          rc = irq_set_affinity_hint(nq->msix_vec, &nq->mask);
   463          if (rc) {
   464                  dev_warn(&nq->pdev->dev,
   465                           "set affinity failed; vector: %d nq_idx: %d\n",
   466                           nq->msix_vec, nq_indx);

Say irq_set_affinity_hint() fails then should we call release_irq()?

   467          }
   468          nq->requested = true;
   469          bnxt_qplib_ring_nq_db(&nq->nq_db.dbinfo, nq->res->cctx, true);
   470  
   471          return rc;

I think that maybe the intent was to "return 0;" here even if setting
the hint failed.

   472  }

regards,
dan carpenter

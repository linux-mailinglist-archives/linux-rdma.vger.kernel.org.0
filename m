Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484842DBCA2
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 09:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgLPIZZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 03:25:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39142 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgLPIZZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 03:25:25 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG8JgK4022145;
        Wed, 16 Dec 2020 08:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=DJ0KuJham5pKcttVKxbs/IMTni/Xpk8rQEhQQq+qmW0=;
 b=LBghntth2jXixcnKzGjM0W3Gyajv6EyZjBVSK8TAaWZGm6r/4yxVQgRCXxlm8vA2WonG
 BO6XY0nBlX5CjYvrjohn9qyKRuvbe+LAGRlGptU5+29ekorv4STd5b30lVHacpQ1DtG7
 y6Q12ytP+xg6xEUqutcsssLKu6icJPhKQZ2/9Mqjc3dY3fUe8NBMivx3zOno7eB9IuHw
 IQXtdwxurX7qcVCDGOIsIX8h6bkMb9T3T1dZqsi2vWbujM//9r8cjIr+63UrbS5aJT0O
 HYjfTkXWH5QxQGCANWOkn4oBOWPQd+jPChj1welIl74QlPjI6elgwVKnGEKrpGomD+L1 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35cntm6s0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Dec 2020 08:24:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BG8KBnN144474;
        Wed, 16 Dec 2020 08:24:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 35d7sxg9aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Dec 2020 08:24:41 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BG8Oeew009235;
        Wed, 16 Dec 2020 08:24:40 GMT
Received: from mwanda (/10.175.200.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Dec 2020 00:24:40 -0800
Date:   Wed, 16 Dec 2020 11:24:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/restrack: Convert internal DB from hash to XArray
Message-ID: <X9nEQ9JjSJXVHNSq@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012160053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012160053
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[ I don't know why this warning is only showing up now but I grepped my
  outbox and apparently it's new...  *shrug*  -dan ]

Hello Leon Romanovsky,

The patch fd47c2f99f04: "RDMA/restrack: Convert internal DB from hash
to XArray" from Feb 18, 2019, leads to the following static checker
warning:

	drivers/infiniband/core/restrack.c:261 rdma_restrack_add()
	warn: 'ret' can be either negative or positive

drivers/infiniband/core/restrack.c
   220  void rdma_restrack_add(struct rdma_restrack_entry *res)
   221  {
   222          struct ib_device *dev = res_to_dev(res);
   223          struct rdma_restrack_root *rt;
   224          int ret = 0;
   225  
   226          if (!dev)
   227                  return;
   228  
   229          if (res->no_track)
   230                  goto out;
   231  
   232          rt = &dev->res[res->type];
   233  
   234          if (res->type == RDMA_RESTRACK_QP) {
   235                  /* Special case to ensure that LQPN points to right QP */
   236                  struct ib_qp *qp = container_of(res, struct ib_qp, res);
   237  
   238                  WARN_ONCE(qp->qp_num >> 24 || qp->port >> 8,
   239                            "QP number 0x%0X and port 0x%0X", qp->qp_num,
   240                            qp->port);
   241                  res->id = qp->qp_num;
   242                  if (qp->qp_type == IB_QPT_SMI || qp->qp_type == IB_QPT_GSI)
   243                          res->id |= qp->port << 24;
   244                  ret = xa_insert(&rt->xa, res->id, res, GFP_KERNEL);
   245                  if (ret)
   246                          res->id = 0;
   247          } else if (res->type == RDMA_RESTRACK_COUNTER) {
   248                  /* Special case to ensure that cntn points to right counter */
   249                  struct rdma_counter *counter;
   250  
   251                  counter = container_of(res, struct rdma_counter, res);
   252                  ret = xa_insert(&rt->xa, counter->id, res, GFP_KERNEL);
   253                  res->id = ret ? 0 : counter->id;
   254          } else {
   255                  ret = xa_alloc_cyclic(&rt->xa, &res->id, res, xa_limit_32b,
                              ^^^^^^^^^^^^^^^
This sometimes returns 1 on success.

   256                                        &rt->next_id, GFP_KERNEL);
   257          }
   258  
   259  out:
   260          if (!ret)

if (ret >= 0)?

   261                  res->valid = true;
   262  }

regards,
dan carpenter

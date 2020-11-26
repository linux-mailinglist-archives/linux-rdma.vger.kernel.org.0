Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B333A2C5311
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 12:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbgKZLd6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 06:33:58 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59452 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389236AbgKZLd6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 06:33:58 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AQBObQ3002535;
        Thu, 26 Nov 2020 11:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=zrkLrbOCOmUi6g0aYCCwIw1QKyzg9b4b1pWlkLM9920=;
 b=0iCyDoOn/Nnr6hlr3P/qmrsByWHMxjv8aWsMnUA3IT//DVp+3dKSejNjMw5X7p8phXjD
 Zv6xOjXYuaHXnhJiYbg5wI62w025bb3tCZulN/BT+kkrn0pe6MxRh5ohmwUlG6+jiEGy
 OMCmeS94jqgCFF3nh8GUZY2sWNrd79MWjhvNlQIlQHx/OBfB3xYLVbMQpc4DiGp8/KK7
 S/vr5DRPF6JNdoL2sU0emt04LaQOzridGY3eeZq+5JLxDXPCsvEgf44almFtbVBUWI4y
 S0pxqi83fHYt+u24ugRfsv8grluqkBrEgFx35YR45Ki6f10TNcoQEFyVMYjN9x4hQc9P Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 351kwhnqbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Nov 2020 11:33:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AQBQ6kE060354;
        Thu, 26 Nov 2020 11:33:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 351n2k5vfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 11:33:55 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AQBXsIg016447;
        Thu, 26 Nov 2020 11:33:55 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Nov 2020 03:33:54 -0800
Date:   Thu, 26 Nov 2020 14:33:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     leon@kernel.org
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/restrack: Store all special QPs in restrack DB
Message-ID: <20201126113347.GA128957@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9816 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9816 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=3
 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260070
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Leon Romanovsky,

The patch 0413755c95e7: "RDMA/restrack: Store all special QPs in
restrack DB" from Nov 4, 2020, leads to the following static checker
warning:

	drivers/infiniband/core/restrack.c:235 rdma_restrack_add()
	warn: right shifting more than type allows 8 vs 8

drivers/infiniband/core/restrack.c
   220  void rdma_restrack_add(struct rdma_restrack_entry *res)
   221  {
   222          struct ib_device *dev = res_to_dev(res);
   223          struct rdma_restrack_root *rt;
   224          int ret;
   225  
   226          if (!dev)
   227                  return;
   228  
   229          rt = &dev->res[res->type];
   230  
   231          if (res->type == RDMA_RESTRACK_QP) {
   232                  /* Special case to ensure that LQPN points to right QP */
   233                  struct ib_qp *qp = container_of(res, struct ib_qp, res);
   234  
   235                  WARN_ONCE(qp->qp_num >> 24 || qp->port >> 8,
                                                      ^^^^^^^^^^^^^
qp->port is a u8 so this is always going to be zero.

   236                            "QP number 0x%0X and port 0x%0X", qp->qp_num,
   237                            qp->port);
   238                  res->id = qp->qp_num;
   239                  if (qp->qp_type == IB_QPT_SMI || qp->qp_type == IB_QPT_GSI)
   240                          res->id |= qp->port << 24;
   241                  ret = xa_insert(&rt->xa, res->id, res, GFP_KERNEL);
   242                  if (ret)
   243                          res->id = 0;
   244          } else if (res->type == RDMA_RESTRACK_COUNTER) {
   245                  /* Special case to ensure that cntn points to right counter */

regards,
dan carpenter

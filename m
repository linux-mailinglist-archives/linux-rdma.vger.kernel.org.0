Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E4E3D6F
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Oct 2019 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfJXUja (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Oct 2019 16:39:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34420 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbfJXUja (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Oct 2019 16:39:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OKcl00109123;
        Thu, 24 Oct 2019 20:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=9zEPSHxeCHZGPJ9YmJq+C6IVQphZILDIUmBdidVzFyM=;
 b=DQTIUTylfmnzwymvwEbpjJCtMHxhKj2c/hhVeXMMfy+UVCIKWdLPp9RPCVLStVal2I6B
 YQrlYFGYyU3YdgJy/BRqf++3MJR2NLGlw2gj8L0/dRu8MMVKW85HFaxAW6AGtQ9DR/Sl
 3gbAcGe+DpK7dUZDSChcAu8uc/Irfqdv7TGRCprp5X4Bss4BF24JkvMq4z/0S8jOKBOM
 PqkN3aV8mTZ6rh0JmnG517Tjkm3xGTX6c8XraKLENTzne2zUTA2s7yy6nLYIOyM7CP9C
 3ah9q/hZzSpqlK272o86G/IBpjliCI3X/SH5awzGh6j/qNblv4j0PlMHw1EikV34+sTD EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vqteq642g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 20:39:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9OKdAYF165707;
        Thu, 24 Oct 2019 20:39:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vug0c7snw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Oct 2019 20:39:22 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9OKcmYY027767;
        Thu, 24 Oct 2019 20:38:49 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Oct 2019 13:38:47 -0700
Date:   Thu, 24 Oct 2019 23:38:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/siw: Fix SQ/RQ drain logic
Message-ID: <20191024203841.GA7912@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=987
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240193
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9420 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240193
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Bernard Metzler,

The patch cf049bb31f71: "RDMA/siw: Fix SQ/RQ drain logic" from Oct 4,
2019, leads to the following static checker warning:

	drivers/infiniband/sw/siw/siw_verbs.c:1079 siw_post_receive()
	error: locking inconsistency.  We assume 'read_sem:&qp->state_lock' is both locked and unlocked at the start.

drivers/infiniband/sw/siw/siw_verbs.c
   978  int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
   979                       const struct ib_recv_wr **bad_wr)
   980  {
   981          struct siw_qp *qp = to_siw_qp(base_qp);
   982          unsigned long flags;
   983          int rv = 0;
   984  
   985          if (qp->srq) {
   986                  *bad_wr = wr;
   987                  return -EOPNOTSUPP; /* what else from errno.h? */
   988          }
   989          if (!qp->kernel_verbs) {
   990                  siw_dbg_qp(qp, "no kernel post_recv for user mapped sq\n");
   991                  up_read(&qp->state_lock);
                        ^^^^^^^^^^^^^^^^^^^^^^^^
The patch changes the locking so this isn't held here and should be
released.  Should it be held, though?

   992                  *bad_wr = wr;
   993                  return -EINVAL;
   994          }
   995  
   996          /*
   997           * Try to acquire QP state lock. Must be non-blocking
   998           * to accommodate kernel clients needs.
   999           */
  1000          if (!down_read_trylock(&qp->state_lock)) {
                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  1001                  if (qp->attrs.state == SIW_QP_STATE_ERROR) {
  1002                          /*
  1003                           * ERROR state is final, so we can be sure
  1004                           * this state will not change as long as the QP
  1005                           * exists.
  1006                           *
  1007                           * This handles an ib_drain_rq() call with
  1008                           * a concurrent request to set the QP state
  1009                           * to ERROR.
  1010                           */
  1011                          rv = siw_rq_flush_wr(qp, wr, bad_wr);
  1012                  } else {

regards,
dan carpenter

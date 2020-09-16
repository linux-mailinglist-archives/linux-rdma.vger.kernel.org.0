Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B8926C422
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 17:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIPPY1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 11:24:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48894 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIPPUg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Sep 2020 11:20:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GEcqKn168644;
        Wed, 16 Sep 2020 14:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=GXEFfMoxY5jSnSgBStwhC+9fwy+pwfx20XtAKWyL2UI=;
 b=Q9bS1yU32gq425B+yVqgdWMYvU8QWsGzN9miFHxW0U8Lh8BqgghsamgIZMtXli50pmnb
 ichnAbZwzSxyrbn9CcXOsmMio7bnCsxT3WFIDWziaXkeJVe/uaEST2W8AnDyxSXTu7CQ
 cKT/t5C2JpLNMEScGHqvjqxXhyO4oxNdTR2gDpjJ9YA+CgcipbtQdTPw8Pl7Ute6mqDn
 xhO04wc0l2WXrDKfqLl/LV/0fB9iUGT9HG9Ece13hT+0XbCP4FzfQ0NfMp17sk7j9jl6
 QbMZFyQwflBVdzrG3r7G7SCvj9hsLsBg+YAQLTYyft7xhfBlOw95rNGEA/B7vBYhNu/T Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33gp9mbfun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 14:39:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GEUnHm090074;
        Wed, 16 Sep 2020 14:39:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33h891rqg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 14:39:47 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08GEdj6G007001;
        Wed, 16 Sep 2020 14:39:46 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 14:39:45 +0000
Date:   Wed, 16 Sep 2020 17:39:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     oulijun@huawei.com
Cc:     linux-rdma@vger.kernel.org
Subject: [bug report] RDMA/hns: Avoid unncessary initialization
Message-ID: <20200916143940.GA766708@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=3 mlxscore=0 bulkscore=0 mlxlogscore=806 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=815
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=3 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160111
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Lijun Ou,

The patch a2f3d4479fe9: "RDMA/hns: Avoid unncessary initialization"
from Sep 8, 2020, leads to the following static checker warning:

	drivers/infiniband/hw/hns/hns_roce_hw_v1.c:282 hns_roce_v1_post_send()
	error: uninitialized symbol 'ps_opcode'.

drivers/infiniband/hw/hns/hns_roce_hw_v1.c
   256                          switch (wr->opcode) {
   257                          case IB_WR_RDMA_READ:
   258                                  ps_opcode = HNS_ROCE_WQE_OPCODE_RDMA_READ;
   259                                  set_raddr_seg(wqe,  rdma_wr(wr)->remote_addr,
   260                                                 rdma_wr(wr)->rkey);
   261                                  break;
   262                          case IB_WR_RDMA_WRITE:
   263                          case IB_WR_RDMA_WRITE_WITH_IMM:
   264                                  ps_opcode = HNS_ROCE_WQE_OPCODE_RDMA_WRITE;
   265                                  set_raddr_seg(wqe,  rdma_wr(wr)->remote_addr,
   266                                                rdma_wr(wr)->rkey);
   267                                  break;
   268                          case IB_WR_SEND:
   269                          case IB_WR_SEND_WITH_INV:
   270                          case IB_WR_SEND_WITH_IMM:
   271                                  ps_opcode = HNS_ROCE_WQE_OPCODE_SEND;
   272                                  break;
   273                          case IB_WR_LOCAL_INV:
                                ^^^^^^^^^^^^^^^^^^^^
"ps_opcode" is not initialized for this case statement.

   274                                  break;
   275                          case IB_WR_ATOMIC_CMP_AND_SWP:
   276                          case IB_WR_ATOMIC_FETCH_AND_ADD:
   277                          case IB_WR_LSO:
   278                          default:
   279                                  ps_opcode = HNS_ROCE_WQE_OPCODE_MASK;
   280                                  break;
   281                          }
   282                          ctrl->flag |= cpu_to_le32(ps_opcode);
                                                          ^^^^^^^^^
Uninitialized.

   283                          wqe += sizeof(struct hns_roce_wqe_raddr_seg);
   284  
   285                          dseg = wqe;

regards,
dan carpenter

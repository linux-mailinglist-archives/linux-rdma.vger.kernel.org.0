Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08557C8817
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 14:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfJBMPs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 08:15:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46888 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbfJBMPs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 08:15:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92C95V7168081;
        Wed, 2 Oct 2019 12:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=qmKSNivvkTgcfytciPahzyvZQEHEl62LGZv6o/aOltA=;
 b=NKb+UfsQ5dXPTLOmua/Gee2FzKAUxi0lN9vXDBpz3tdPvWf1BxUEUIKqQcy0/7gBlpgG
 kSm2bFLISC2oi0qlj5vTYWbb6/KITWsNQKEQpezj5AONtB1Pi5TpaxS7ptPvmEIHVwX7
 1CHej7EVDhjVkfVGPd1xFRdsvylmwKBjy+o++QP3f9wkDRSBbnvx2bOQnKuynD6y8I6I
 64XBT4SotUbgZA5je9mqOdoR4fY3eXDlrk7O+kil2nyvZ5mex7dTy9qkHqkzY+YdZ0hR
 rp1gXCGZ+HOxCTnoTgLBlg5q1MPaXCsu9d1F2iEHcu5fHKTpbfTn+QDiNNggpTVn4eiB Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2v9xxuvhxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 12:15:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x92C8LEi010168;
        Wed, 2 Oct 2019 12:15:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2vbsm3s223-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 12:15:27 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x92CFQG7028539;
        Wed, 2 Oct 2019 12:15:27 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Oct 2019 05:15:26 -0700
Date:   Wed, 2 Oct 2019 15:15:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     don.hiatt@intel.com
Cc:     linux-rdma@vger.kernel.org, Laura Abbott <labbott@redhat.com>,
        Greg KH <greg@kroah.com>
Subject: [bug report] IB/hfi1: Eliminate allocation while atomic
Message-ID: <20191002121520.GA11064@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=788
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910020117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9397 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=872 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910020117
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello Don Hiatt,

The patch f8195f3b14a0: "IB/hfi1: Eliminate allocation while atomic"
from Oct 9, 2017, leads to the following static checker warning:

	drivers/infiniband/hw/hfi1/verbs.c:824 build_verbs_tx_desc()
	error: doing dma on the stack (trail_buf)

drivers/infiniband/hw/hfi1/verbs.c
   147  /* Length of buffer to create verbs txreq cache name */
   148  #define TXREQ_NAME_LEN 24
   149  
   150  /* 16B trailing buffer */
   151  static const u8 trail_buf[MAX_16B_PADDING];
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^

This used to be actually allocated on the stack but now it's here.  I
believe this is still a problem.  It's not a problem for most people at
runtime, but it's technically a bug.  And I believe that soon we will
add a check in dma_map_single() which will generate a warning.

   152  
   153  static uint wss_threshold = 80;

[ snip ]

   801          } else {
   802                  ret = sdma_txinit_ahg(
   803                          &tx->txreq,
   804                          ahg_info->tx_flags,
   805                          length,
   806                          ahg_info->ahgidx,
   807                          ahg_info->ahgcount,
   808                          ahg_info->ahgdesc,
   809                          hdrbytes,
   810                          verbs_sdma_complete);
   811                  if (ret)
   812                          goto bail_txadd;
   813          }
   814          /* add the ulp payload - if any. tx->ss can be NULL for acks */
   815          if (tx->ss) {
   816                  ret = build_verbs_ulp_payload(sde, length, tx);
   817                  if (ret)
   818                          goto bail_txadd;
   819          }
   820  
   821          /* add icrc, lt byte, and padding to flit */
   822          if (extra_bytes)
   823                  ret = sdma_txadd_kvaddr(sde->dd, &tx->txreq,
   824                                          (void *)trail_buf, extra_bytes);
                                                        ^^^^^^^^^
This has to be DMAable memory.

   825  
   826  bail_txadd:
   827          return ret;
   828  }


regards,
dan carpenter

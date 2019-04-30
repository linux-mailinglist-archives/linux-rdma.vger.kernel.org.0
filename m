Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 728CAFB5B
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 16:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfD3OY4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 10:24:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55966 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfD3OY4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 10:24:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UEOeOX075205;
        Tue, 30 Apr 2019 14:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=u02ebgOH+Pi973tpKwUoPZrjknDPYJ7A7Hi/qIz9PJc=;
 b=NgpOaUXAcxQCXHw40LLVfCAZlIxFvNaGyeytTKVKlAWLhSOLU3sPf6RMUmQ3ToE+1pB+
 964gHBhausvTade2Xy5fKfw/R5EFPzWwxvMyKiS/FxzvOyTyQvCBXkiBjHHhmITnu6jG
 MlEyzFjQV4us2wywJv8/v7ni1HmQayJrJRQAWWzumo/JE/VfS8JVCly5X5YwOR/X1e9p
 2TxAmfuImcmhn3ymFzWlxMI6GctlxVI4YScWZrU+q8vvJs2XPiYhZ/UJF2UJOdS3hrF9
 cRI4G3xOliCIcbE4g+O2jyV3VzI/AXfZ2cY77CXORL471P/lbYuOculiU/kpYdtXLvOs TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2s4fqq4spv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 14:24:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UEN0KS058521;
        Tue, 30 Apr 2019 14:24:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2s5u510vgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 14:24:39 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3UEOcK2002195;
        Tue, 30 Apr 2019 14:24:38 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.1.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 07:24:35 -0700
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: [PATCH for-next v1 0/4] ib_pd should not have ib_uobject
Date:   Tue, 30 Apr 2019 17:23:20 +0300
Message-Id: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=922
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300090
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=947 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300091
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set complete the cleanup done in the driver/verbs/uverbs
where the dependency of the code in the ib_x uobject pointer was
removed. 

This series include fix requested by Jason to initialize the
driver_udata ucontext in ib_uverbs_get_context that was not
initialized in this flow.

Last, the uobject pointer is removed from the ib_pd as last step 
before I can start adding the pd sharing code. 

PLEASE NOTE! 

The last patch that removed the uobject pointer from the ib_pd
also affected the netlink interface. With this patch the netlink
interface cannot figure the context id from ib_pd. 

Please review this change carefully...

Shamir Rabinovitch (4):
  RDMA/uverbs: initialize uverbs_attr_bundle ucontext in
    ib_uverbs_get_context
  RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
  RDMA/uverbs: uobj_put_obj_read macro should be removed
  IB/{core,hw}: ib_pd should not have ib_uobject pointer

 drivers/infiniband/core/nldev.c            |   5 -
 drivers/infiniband/core/uverbs_cmd.c       | 272 ++++++++++++++-------
 drivers/infiniband/core/verbs.c            |   1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c |   1 -
 drivers/infiniband/hw/mlx5/main.c          |   1 -
 drivers/infiniband/hw/mthca/mthca_qp.c     |   3 +-
 include/rdma/ib_verbs.h                    |   1 -
 include/rdma/uverbs_std_types.h            |  11 +-
 8 files changed, 192 insertions(+), 103 deletions(-)

-- 
2.20.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB6C3B05BB
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 15:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFVNXB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 09:23:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61732 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229907AbhFVNXB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 09:23:01 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MDHQ7v010726;
        Tue, 22 Jun 2021 13:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=O1Sx4kGcePZGpoxqmdhgNlW8ltIzgqo4pLLrxRmS12Q=;
 b=Kf6GeSEE9zPN6rHO6NeAXKNk3GhPkh6T8PvuozvKrYeM4LcXBuQ6CdMzw/Vo5XUNwipx
 5P2ihGN9CVdKxbnowAIgfItIXlSjrPhylDQH0NWbEHmnZnJvPBdSk2xJjX+j3leBUXMD
 ID4lAFjOxCZ0V7B4BdqqcNnKyNRc4ylSLknOICYba3eUFNhRDCke90rto0oM3QKmUnrh
 Ias9aEAgh+5lNDtihNTPpENss2KvzMzM9qf0RR2y0eQrQVG9lq8h5vXwuhLJKxUwYm2o
 77Cf8ubz+jgws3EiDQ6+O2uj0Xy/aTMhx0cUAER55yu1TWqqfgfLDXdrkHxofWC9Rm2Y HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvu51k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:20:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MDFsSK129731;
        Tue, 22 Jun 2021 13:20:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 399tbspdkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:20:40 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.14.4) with ESMTP id 15MDKc0u017457;
        Tue, 22 Jun 2021 13:20:38 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jun 2021 06:20:38 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH for-next 0/2] Fix RMW to bit-fields and remove one superfluous ib_modify_qp
Date:   Tue, 22 Jun 2021 15:20:28 +0200
Message-Id: <1624368030-23214-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220084
X-Proofpoint-ORIG-GUID: YRJxTTAt_ompn7a1U7bF9NULMMMCdAPk
X-Proofpoint-GUID: YRJxTTAt_ompn7a1U7bF9NULMMMCdAPk
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series removes one superfluous ib_modify_qp() when a connected QP
is created through rdma_create_qp(). This commit removes a call to
rdma_init_qp_attr() for connected QPs without holding the qp_mutex.

The second commit tightens the access to bit-fields and synchronizes
the access to them by means of mutex exclusion.

Håkon Bugge (2):
  RDMA/cma: Remove unnecessary INIT->INIT transition
  RDMA/cma: Protect RMW with qp_mutex

 drivers/infiniband/core/cma.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

--
1.8.3.1


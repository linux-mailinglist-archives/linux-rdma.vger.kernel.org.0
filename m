Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DD53B05F8
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFVNm3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 09:42:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55764 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230047AbhFVNm2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 09:42:28 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MDaIEQ023970;
        Tue, 22 Jun 2021 13:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=KDGEpthoHDX788UDIn/5SPyIhKjCNTo2w0xWotbGx8M=;
 b=ZlCp8HGLC3VO0+xNJTlBAiAjHMJ/BqCa/7VkpRT0Mn/lW7nj1xQam6A7WJz+VrW7tfcT
 82GzBEuiGjxDqK+L3GNDjPilmABZ4/pyWMGMtLe0UxLYJXiidOJna9e+EuzYlg1TyPKn
 oVBscdYJMlVM0dnKJ9IddUaDkuPLcUV6QyBzf2HSpQU7RKC08KV4rEkgHsEEVmCCi0iN
 nZq3iySt5fBNHo2Yj0MeM8FDwhFeNridpf9h5ehZhGI2J5dslcqxbgZPonuotWzzwkL0
 epuudvtAq2U4nqPIzaIpMGVdn/e6KjmudXLDXfsPQzjqPJPrumKNqBhdNnTcaJnGEnRp WQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39b98v96ex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:40:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15MDZsnG028668;
        Tue, 22 Jun 2021 13:40:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 399tbsqpj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 13:40:07 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15MDe6sU032386;
        Tue, 22 Jun 2021 13:40:06 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Jun 2021 06:40:05 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH for-next v2 0/2] Fix RMW to bit-fields and remove one superfluous ib_modify_qp
Date:   Tue, 22 Jun 2021 15:39:55 +0200
Message-Id: <1624369197-24578-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220085
X-Proofpoint-ORIG-GUID: RH069yznKZKRTKYLcogq9w85iMCSR34m
X-Proofpoint-GUID: RH069yznKZKRTKYLcogq9w85iMCSR34m
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series removes one superfluous ib_modify_qp() when a connected QP
is created through rdma_create_qp(). This commit removes a call to
rdma_init_qp_attr() for connected QPs without holding the qp_mutex.

The second commit tightens the access to bit-fields and synchronizes
the access to them by means of mutex exclusion.

v1 -> v2:
   * Added mutex protection in cma_resolve_iboe_route() for
     timeout/timeout_set in commit ("RDMA/cma: Protect RMW with
     qp_mutex")

Håkon Bugge (2):
  RDMA/cma: Remove unnecessary INIT->INIT transition
  RDMA/cma: Protect RMW with qp_mutex

 drivers/infiniband/core/cma.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

--
1.8.3.1


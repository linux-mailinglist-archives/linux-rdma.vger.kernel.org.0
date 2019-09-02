Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17BBDA52CC
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfIBJ1s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Sep 2019 05:27:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56316 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfIBJ1r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 05:27:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x829NWI9113181;
        Mon, 2 Sep 2019 09:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=Olp/XAFW3Wk5sD8sqqIIsftyW2V5UWRfgmFkbylxasQ=;
 b=a4Yn2/VXW85tcUzoEvOA7MdTAjUjceTP77QWHTtZbyNEa9TmsUP40/572bb/ZlelPHEF
 2nsppATjLClW9LvHpEJnPf0MVMziEYQ1Vgz93Rvwrueseh59YVA2RAy4MwazHSvdSd20
 Yysc/cf5n/RPhskNO+kLGM2KNS3OZuCY1Q3GdmNYknG9VEaDCD0HsjfwIfvqimg+ld/o
 rlEeca6qI8i58+3XFYQkifc/Iw95VomBZ77EgcmYUszxoJt/TdOtFDVUeqmyXBNwtP6s
 6iW6hmonwjZ4l/LGvGazGEoA2rB1uiuAWpZhAtAc7WWKctELkLw35JW5sNYg4a1U6T28 pw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2us0bwg13e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 09:27:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x829NDXV073544;
        Mon, 2 Sep 2019 09:27:36 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2uqgqk98n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Sep 2019 09:27:36 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x829Rapp003769;
        Mon, 2 Sep 2019 09:27:36 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Sep 2019 02:27:35 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
Subject: [PATCH] RDMA/cma: fix false error message
Date:   Mon,  2 Sep 2019 11:27:31 +0200
Message-Id: <20190902092731.1055757-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909020107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9367 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909020107
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In addr_handler(), assuming status == 0 and the device already has
been acquired (id_priv->cma_dev != NULL), we get the following
incorrect "error" message:

RDMA CM: ADDR_ERROR: failed to resolve IP. status 0

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 19f1730a4f24..c7985c24f914 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3046,7 +3046,7 @@ static void addr_handler(int status, struct sockaddr *src_addr,
 		if (status)
 			pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to acquire device. status %d\n",
 					     status);
-	} else {
+	} else if (status) {
 		pr_debug_ratelimited("RDMA CM: ADDR_ERROR: failed to resolve IP. status %d\n", status);
 	}
 
-- 
2.20.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37895A7AD8
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2019 07:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfIDFpv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Sep 2019 01:45:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50584 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfIDFpv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Sep 2019 01:45:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x845jNF7093150;
        Wed, 4 Sep 2019 05:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=exRf/gRsNataBWsLI7/klYESrGvL0Ww8aGZ4Z04ppok=;
 b=BujNk1RuNtqgjXFoAuy2M/6H2NrNX5N+bpVSo/3+/WFzw1Q3eA5yb67c/KYdjNks0cu4
 Xp6j0XsnzciKBgv6isCePBQnNlkhu2K+X+e68LQ+xVLXYONKX4Vb4xrGkNcgCpTuyXht
 DwMq3KBV4UpnFHTXDLAo06sJlRSSJc9E3Sm6H6kSDWlY2fEbHFOAFSbeHNXL5vbNqaVq
 6kufxJD6mOEYinL6Jbf1wiolYF8oHEYC/eB5V5mhG4JaxbhlbXrn0EMiOJ2E13QMTjp1
 CeC7V2hWlx2W2REb+ZodSbHzLOwS+I/J0GHeTjBC+xTZz4ZhDcX7nrklkrpZeFn674bL 9A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ut7d0r03r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 05:45:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x845iPkn132920;
        Wed, 4 Sep 2019 05:45:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2usu52e9ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Sep 2019 05:45:44 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x845jgZq011253;
        Wed, 4 Sep 2019 05:45:42 GMT
Received: from lap1.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Sep 2019 22:45:42 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     bmt@zurich.ibm.com, galpress@amazon.com, yishaih@mellanox.com,
        jgg@mellanox.com, matanb@mellanox.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Yuval Shaia <yuval.shaia@oracle.com>
Subject: [PATCH] kernel-headers: Update comment to reflect changes
Date:   Wed,  4 Sep 2019 08:45:30 +0300
Message-Id: <20190904054530.4391-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909040061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909040061
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Following change made in commit 08536105d93f ("docs: ioctl-number.txt:
convert it to ReST format") change the comment that refers to
ioctl-number.txt file.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 kernel-headers/rdma/rdma_user_ioctl_cmds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel-headers/rdma/rdma_user_ioctl_cmds.h b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
index 64c14cb0..b8bb285f 100644
--- a/kernel-headers/rdma/rdma_user_ioctl_cmds.h
+++ b/kernel-headers/rdma/rdma_user_ioctl_cmds.h
@@ -36,7 +36,7 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
-/* Documentation/ioctl/ioctl-number.txt */
+/* Documentation/ioctl/ioctl-number.rst */
 #define RDMA_IOCTL_MAGIC	0x1b
 #define RDMA_VERBS_IOCTL \
 	_IOWR(RDMA_IOCTL_MAGIC, 1, struct ib_uverbs_ioctl_hdr)
-- 
2.20.1


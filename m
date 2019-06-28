Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A20F59667
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfF1Ite (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 04:49:34 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1Ite (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 Jun 2019 04:49:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S8mxHV040376;
        Fri, 28 Jun 2019 08:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=4D8QFL/3XbTVzEiMWzUU7hVQJVuawiGGxMYhiOpgGyY=;
 b=yMzomvOvUm+rN7I3ED3veGQ+SjgwPUkyq4CrtnZOsBPhSqvSVgmpGlmdc1wVaLFC13AY
 2amGjNEHP9B4veJ50Pz2Leo9Rio8iMFvVkCDp2eY08D4OK4CENV49G88buqSvQ6iojMu
 v0jV1hN6whtoWD2acAwl3XY5Fc2dqqu4ZjAJ/ssdFMkt908BrDaYmsG47TRoUUxzSyBp
 QkqGCD6aH70sCnwdz2sG3+j8OKh73L4SuGOOuAIEtOcHuFRRDZzhYhHMdQEY3vf2UoLD
 DQ/T7cPRL738G9/RATjUgphoP2Uw85QkFCRKNHQJJ9zPuZqc+XRKMuldGEMsKaU+VDXT eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t9brtmj18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 08:49:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5S8mIAv109968;
        Fri, 28 Jun 2019 08:49:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2t99f5fjgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 08:49:12 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5S8nAId024954;
        Fri, 28 Jun 2019 08:49:10 GMT
Received: from dm-oel.no.oracle.com (/10.172.157.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 01:49:10 -0700
From:   Dag Moxnes <dag.moxnes@oracle.com>
To:     dag.moxnes@oracle.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, parav@mellanox.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/core: Fix race when resolving IP address
Date:   Fri, 28 Jun 2019 10:49:23 +0200
Message-Id: <1561711763-24705-1-git-send-email-dag.moxnes@oracle.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906280104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9301 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280104
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use neighbour lock when copying MAC address from neighbour data struct
in dst_fetch_ha.

When not using the lock, it is possible for the function to race with
neigh_update, causing it to copy an invalid MAC address.

It is possible to provoke this error by calling rdma_resolve_addr in a
tight loop, while deleting the corresponding ARP entry in another tight
loop.

Signed-off-by: Dag Moxnes <dag.moxnes@oracle.com>
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---
v1 -> v2:
   * Modified implementation to improve readability
---
 drivers/infiniband/core/addr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 2f7d141598..51323ffbc5 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -333,11 +333,14 @@ static int dst_fetch_ha(const struct dst_entry *dst,
 	if (!n)
 		return -ENODATA;
 
-	if (!(n->nud_state & NUD_VALID)) {
+	read_lock_bh(&n->lock);
+	if (n->nud_state & NUD_VALID) {
+		memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
+		read_unlock_bh(&n->lock);
+	} else {
+		read_unlock_bh(&n->lock);
 		neigh_event_send(n, NULL);
 		ret = -ENODATA;
-	} else {
-		memcpy(dev_addr->dst_dev_addr, n->ha, MAX_ADDR_LEN);
 	}
 
 	neigh_release(n);
-- 
2.20.1


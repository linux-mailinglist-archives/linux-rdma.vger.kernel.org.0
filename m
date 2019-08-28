Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918759FEB0
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 11:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfH1Jiu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 05:38:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726340AbfH1Jit (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 05:38:49 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7S9ZVxJ129597
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2019 05:38:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unn4mwane-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2019 05:38:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Wed, 28 Aug 2019 10:38:46 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 10:38:44 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7S9chMx57016482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 09:38:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 739E2AE051;
        Wed, 28 Aug 2019 09:38:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CD47AE04D;
        Wed, 28 Aug 2019 09:38:43 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 09:38:43 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, jgg@ziepe.ca, dledford@redhat.com,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v3] RDMA/siw: Fix IPv6 addr_list locking
Date:   Wed, 28 Aug 2019 11:38:41 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19082809-0020-0000-0000-00000364D30D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082809-0021-0000-0000-000021BA24CE
Message-Id: <20190828093841.21993-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=858 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280100
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Walking the address list of an inet6_dev requires
appropriate locking. Since the called function
siw_listen_address() may sleep, we have to use
rtnl_lock() instead of read_lock_bh().

Also introduces sanity checks if we got a device
from in_dev_get() or in6_dev_get().

Changes from v2:
- Use plain version of list_for_each_entry
  in exchange of list_for_each_entry_rcu.

Changes from v1:
- Remove rcu_read_lock()/_unlock().
- Add check for IFA_F_TENTATIVE and
  IFA_F_DEPRECATED flags.

Reported-by: Bart Van Assche <bvanassche@acm.org>
Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 31 +++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 1db5ad3d9580..8c1931a57f4a 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -1962,6 +1962,10 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		struct sockaddr_in s_laddr, *s_raddr;
 		const struct in_ifaddr *ifa;
 
+		if (!in_dev) {
+			rv = -ENODEV;
+			goto out;
+		}
 		memcpy(&s_laddr, &id->local_addr, sizeof(s_laddr));
 		s_raddr = (struct sockaddr_in *)&id->remote_addr;
 
@@ -1991,22 +1995,27 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		struct sockaddr_in6 *s_laddr = &to_sockaddr_in6(id->local_addr),
 			*s_raddr = &to_sockaddr_in6(id->remote_addr);
 
+		if (!in6_dev) {
+			rv = -ENODEV;
+			goto out;
+		}
 		siw_dbg(id->device,
 			"laddr %pI6:%d, raddr %pI6:%d\n",
 			&s_laddr->sin6_addr, ntohs(s_laddr->sin6_port),
 			&s_raddr->sin6_addr, ntohs(s_raddr->sin6_port));
 
-		read_lock_bh(&in6_dev->lock);
+		rtnl_lock();
 		list_for_each_entry(ifp, &in6_dev->addr_list, if_list) {
-			struct sockaddr_in6 bind_addr;
-
+			if (ifp->flags & (IFA_F_TENTATIVE | IFA_F_DEPRECATED))
+				continue;
 			if (ipv6_addr_any(&s_laddr->sin6_addr) ||
 			    ipv6_addr_equal(&s_laddr->sin6_addr, &ifp->addr)) {
-				bind_addr.sin6_family = AF_INET6;
-				bind_addr.sin6_port = s_laddr->sin6_port;
-				bind_addr.sin6_flowinfo = 0;
-				bind_addr.sin6_addr = ifp->addr;
-				bind_addr.sin6_scope_id = dev->ifindex;
+				struct sockaddr_in6 bind_addr  = {
+					.sin6_family = AF_INET6,
+					.sin6_port = s_laddr->sin6_port,
+					.sin6_flowinfo = 0,
+					.sin6_addr = ifp->addr,
+					.sin6_scope_id = dev->ifindex };
 
 				rv = siw_listen_address(id, backlog,
 						(struct sockaddr *)&bind_addr,
@@ -2015,12 +2024,12 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 					listeners++;
 			}
 		}
-		read_unlock_bh(&in6_dev->lock);
-
+		rtnl_unlock();
 		in6_dev_put(in6_dev);
 	} else {
-		return -EAFNOSUPPORT;
+		rv = -EAFNOSUPPORT;
 	}
+out:
 	if (listeners)
 		rv = 0;
 	else if (!rv)
-- 
2.17.2


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 545769F5D0
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 00:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfH0WHc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Aug 2019 18:07:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbfH0WHc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 27 Aug 2019 18:07:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7RM6aBf070482
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 18:07:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unc03j9xf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2019 18:07:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Tue, 27 Aug 2019 23:07:28 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Aug 2019 23:07:25 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7RM7OAv55509176
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 22:07:24 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EE08AE053;
        Tue, 27 Aug 2019 22:07:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1573EAE045;
        Tue, 27 Aug 2019 22:07:24 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Aug 2019 22:07:24 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, jgg@ziepe.ca, dledford@redhat.com,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH v3] RDMA/siw: Fix IPv6 addr_list locking
Date:   Wed, 28 Aug 2019 00:07:20 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19082722-4275-0000-0000-0000035E0F0C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082722-4276-0000-0000-00003870413D
Message-Id: <20190827220720.19581-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=925 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270208
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Walking the address list of an inet6_dev requires
appropriate locking. Since the called function
siw_listen_address() may sleep, we have to use
rtnl_lock() instead of read_lock_bh().

Also introduces:
- sanity checks if we got a device from
  in_dev_get() or in6_dev_get().
- skipping IPv6 addresses flagged IFA_F_TENTATIVE
  or IFA_F_DEPRECATED

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


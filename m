Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7E789D17E
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 16:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfHZOSK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 10:18:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51770 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729039AbfHZOSK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Aug 2019 10:18:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QECjIO093736
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 10:18:09 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umfhh42ks-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 26 Aug 2019 10:18:09 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rdma@vger.kernel.org> from <bmt@zurich.ibm.com>;
        Mon, 26 Aug 2019 15:18:06 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 26 Aug 2019 15:18:03 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7QEI2Wl10289178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 14:18:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AF7AA4054;
        Mon, 26 Aug 2019 14:18:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5346BA405C;
        Mon, 26 Aug 2019 14:18:02 +0000 (GMT)
Received: from spoke.zurich.ibm.com (unknown [9.4.69.152])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 26 Aug 2019 14:18:02 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, jgg@ziepe.ca, dledford@redhat.com,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: [PATCH] RDMA/siw: Fix IPv6 addr_list locking
Date:   Mon, 26 Aug 2019 16:17:40 +0200
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19082614-0012-0000-0000-0000034321A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082614-0013-0000-0000-0000217D56CD
Message-Id: <20190826141740.12969-1-bmt@zurich.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=949 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908260155
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Walking the address list of an inet6_dev requires
appropriate locking. Since the called function
siw_listen_address() may sleep, we have to use
rtnl_lock() + rcu_read_lock_bh() instead of
read_lock_bh().

Also introduces checks if we get a device from
in_dev_get(), or in6_dev_get().

Reported-by: Bart Van Assche <bvanassche@acm.org>
Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_cm.c | 33 +++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index 1db5ad3d9580..8291bfcde995 100644
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
 
@@ -1991,22 +1995,26 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
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
-		list_for_each_entry(ifp, &in6_dev->addr_list, if_list) {
-			struct sockaddr_in6 bind_addr;
-
+		rtnl_lock();
+		rcu_read_lock_bh();
+		list_for_each_entry_rcu(ifp, &in6_dev->addr_list, if_list) {
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
@@ -2015,12 +2023,13 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 					listeners++;
 			}
 		}
-		read_unlock_bh(&in6_dev->lock);
-
+		rcu_read_unlock_bh();
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


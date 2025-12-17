Return-Path: <linux-rdma+bounces-15047-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8467FCC76E9
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 12:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C054303ADE0
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D29335BC1;
	Wed, 17 Dec 2025 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qpi3GS4E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5E1F1302;
	Wed, 17 Dec 2025 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765972115; cv=none; b=SxzGmOAd2SzFvnjKnzK57iVLF+6lkf7zImgBDfk5dd3r9Kt2Y4BxIYrW956kQP6v6ctuHU+33Bi04ONvrhUL4cbCWBv8epbNBjsjGrznJGqcnGL1KEDrROq2zt0XG7VbZGJ6CmisMeAZK0adbrtc9+55ZjEyB7SB810N5DWVFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765972115; c=relaxed/simple;
	bh=2gF72S1YLF3R0pNhYu2u8i+yPBENIA+GEOWOho3xa6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aHfm8K83tGZpLqIH5kfNcOFqcLsK2Pz2KCZxB8cLhvuyimfvxVNSh6GDnol+ZnSyw5/kXRTKd/xlybedlXo7XiDpheTgOx2I8SQoMyPrmPZPSL2+5awjHJPpPMYTLK6b5SYM6Ti91O3VJo0eZAKKVuc/WmO5JLvqSfWvT62DWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qpi3GS4E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGMx3BU018905;
	Wed, 17 Dec 2025 11:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KozKZunQQa2HBaHNYq0kwwfVjsx26Yt4esz51T3RU
	84=; b=Qpi3GS4E53qmdEgkecfGhiMLTRVIdO3rNEmgJu5Qa39lf0mfik8/InV8G
	JkbUsiA4a9MnmoeQ7UXYmztlI2Ln9PvponlOr9chfACXHdusQP5XvlWO30zOqW6O
	j08J2M3yaV04A+aA6FLMIAxt0NwGrIQ1E2HmnBtA2AYxcuSJrtWLeFaXnaGdzPbZ
	tuHzwf4oNWH4NHTSRzFOwjBj1iQHe7cY+lc2ETzrM8aFMnMwHkegS9AMnsw3wdKt
	vF4AHjzmRgAKRuDMVUV4nh/XgDTW1/6Y6ucR6NHeZL58Xjf2gW0NWkt4k1KnzGs1
	Ha6fETlVpOOsXY3OJS8m6l3Bsy4dQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjq444t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 11:48:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BHBmPu7021915;
	Wed, 17 Dec 2025 11:48:25 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjq444r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 11:48:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH8N1Y6005690;
	Wed, 17 Dec 2025 11:48:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgp0mj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 11:48:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BHBmJKE11731368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 11:48:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD4F12004E;
	Wed, 17 Dec 2025 11:48:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C87DB2004D;
	Wed, 17 Dec 2025 11:48:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Dec 2025 11:48:19 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 90B12E0B19; Wed, 17 Dec 2025 12:48:19 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Subject: [PATCH net] net/smc: Initialize smc hashtables before registering users
Date: Wed, 17 Dec 2025 12:48:19 +0100
Message-ID: <20251217114819.2725882-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfXxwD6kTJvvUnO
 U5zv0jOFsXg73v8vV/F4bde97bdp1PXZuwGVLkNky6lhjH497SV3G7z30RT7htCy/cu+hjphexu
 xE2QO2RSzZqiqJ/vgMJouyxkFh4UsjOMlcE08nUBkspOD4lFTulWAnt+aMGjFZu1AAeKP1qRGgI
 qD1UK3QzCGI5aAqdqKltypJowU/bFKolmEl23pGr4/pESeEFh3YnOwyxJdP61jlsQf4mSzVI88r
 MwCm5Bw4B+1brEiYovK3JB7QvCd3tvIzeWosJSJ3QxU8FqCoP/C0rybiSFqQUs2p2a+/Q8P6U7b
 RMSYZn33tQYMjdzzBkMuWZTXWHQL8wRXzD9aquYyr01u3PLls83ttwrJfSO7LUPW+sVWrxFtdhs
 eUYOVKUALRlceX6Lg2ci7YxYtpMvzg==
X-Proofpoint-GUID: fny2lBTx4ZfyHRB8CAoQpTr3_tW8_8H0
X-Proofpoint-ORIG-GUID: 9J7UBLqWusDpmmmEcrWxT1snfOgcUXHz
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=69429889 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=VnNF1IyMAAAA:8 a=QX6q0mGeDEkcqCcECHkA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001

During initialisation of the SMC module initialize smc_v4/6_hashinfo before
calling smc_nl_init(), proto_register() or sock_register(), to avoid a race
that can cause use of an uninitialised pointer in case an smc protocol is
called before the module is done initialising.

syzbot report:
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
Call Trace:
 <TASK>
 smc_diag_dump+0x59/0xa0 net/smc/smc_diag.c:236
 netlink_dump+0x647/0xd80 net/netlink/af_netlink.c:2325
 __netlink_dump_start+0x59f/0x780 net/netlink/af_netlink.c:2440
 netlink_dump_start include/linux/netlink.h:339 [inline]
 smc_diag_handler_dump+0x1ab/0x250 net/smc/smc_diag.c:251
 sock_diag_rcv_msg+0x3dc/0x5f0
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f0/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901

Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
Reported-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/smc/af_smc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f97f77b041d9..b0f4405fb714 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3524,6 +3524,9 @@ static int __init smc_init(void)
 		goto out_pernet_subsys_stat;
 	smc_clc_init();
 
+	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
+	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
+
 	rc = smc_nl_init();
 	if (rc)
 		goto out_ism;
@@ -3581,8 +3584,6 @@ static int __init smc_init(void)
 		pr_err("%s: sock_register fails with %d\n", __func__, rc);
 		goto out_proto6;
 	}
-	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
-	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
 
 	rc = smc_ib_register_client();
 	if (rc) {
-- 
2.51.0



Return-Path: <linux-rdma+bounces-12607-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532FB1C8FB
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C44D564F91
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D87D29B8C6;
	Wed,  6 Aug 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h7h8/58U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBC29AB10;
	Wed,  6 Aug 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494903; cv=none; b=G/uC5Md3Yj1jeg+aytpjTczDgZ64ZKtX9P9O7G9izUOtRmT/olzvpzHuhR8Rm+0kEcbJUddpIw6WnMr6Pw0EWfu0gt8gRhZGJvwxd6OepFOB0R9FUog8NpzyPM+bYzyYy6VJ6uevkP7Bi/JmnvEkTpi+X4ECX9Q5o+hx3rVP+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494903; c=relaxed/simple;
	bh=A0cEO1IjMFQGU/91KruzluQEM+jZalZQ6j3GdwIZK98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOXiYqLHGLpxWA2Wh2rvIE79s5i6e5p4/s7umWtSaYF0U/RIPfwGt4aYN3R5W3yXkQpxLgABIS5JB/hE/ZZMKjGL73JlWRtxvpv1dcxl21daOOy/7/NDZrY8sPUJaeYENdBdn9xOl4SopmRtxnAJZYPcOZE2UtkcX5HBg5k+rA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h7h8/58U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766icQq017912;
	Wed, 6 Aug 2025 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WJKed3KXMGV5ekitr
	OAXUYfuousL4aKXDGBZu9XEUzQ=; b=h7h8/58UCjgKbcHwW08qKRLg54qZP9D2X
	HGB/ZEVBLZi08D5dN9hSAh8zNXEqTTkWI4tPlyBnigZM7DQxsyI9Tpin2sixE4+s
	iwKplEHD1cdbXbTe8iSGYSM+gGk19C7v3+GJP0H64AD/YU04Rj8r5f4/Nwqb01+m
	ETSuNYByWT0NbTr25qoXKiAIk7AyzTYrPl7LaYe65BxmhKTiJUhQ8xt7w37gZsFZ
	kTsV2ArsdWcVu2/AsW7yzy742xxILLBzrj+RrIqacqvUvMJjjAnSwcqMP8Ukb3H/
	a1yNQfprs4o/pHAjnwEi8Nyttmo8VPxjS28JpKW9ZpdDuHFGHQQsw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63519s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FfRaT026230;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63519m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CL35r020592;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwmv8vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfMdK50069986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D302E2004B;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDE3120049;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 93618E1275; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
Subject: [RFC net-next 02/17] s390/ism: Log module load/unload
Date: Wed,  6 Aug 2025 17:41:07 +0200
Message-ID: <20250806154122.3413330-3-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250806154122.3413330-1-wintera@linux.ibm.com>
References: <20250806154122.3413330-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfXzrFPv2v8arjL
 JS6wChNd4HbIVLQ0b/qugStKs6Vg0wI/N5mNadnsidrwXc66cM4WgOBS5lhCnJdF9WHy/33E5pX
 7AdkPbRtSCHS2fCL2vW30K48s1fUpmv494ZQbJh0BJPbZLHL7aEUhh23G39Md6xNOuYWok8usYC
 Yk1jGsk7fR4OVMKjiS351knyQMa6ePmiuVQ5McTeRpuIV12AnuP0UaZDnJn9hZC32GlPUvERqE3
 sagE9K8q1Zhvhb9Hx+58lyvylOInIt61hZ1HhXK8VgH9gctINBYxl0NyeygioXDJmWmziRMe7Mb
 Si8JcNaQFfTu52yJ8N5pdQnCHE9nlhhQONjUXhfEThyuKPKxDQl674wj1mi9bZ+yhn4KlMmhZae
 d7VtN6qCeE2l9sWKjiScF39DYUuFs1ul9RA4LDE0xdLtx3xlOJOwvFhZiXBaYXv6TLSRfb1L
X-Proofpoint-GUID: UxkKOS0sS1Bt2BU7mcGrO_rjENLuCztS
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=2SnCHD6kJk22Aa3V3LsA:9
X-Proofpoint-ORIG-GUID: bCHFJejGaStmbt3IIdA9XcnIMaf0AeZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060096

Add log messages to visualize timeline of module loads and unloads.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 6cd60b174315..a543e59818bb 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -718,8 +718,12 @@ static int __init ism_init(void)
 	debug_register_view(ism_debug_info, &debug_hex_ascii_view);
 	ret = pci_register_driver(&ism_driver);
 	if (ret)
-		debug_unregister(ism_debug_info);
+		goto err_dbg_unreg;
+	pr_info("module loaded\n");
+	return 0;
 
+err_dbg_unreg:
+	debug_unregister(ism_debug_info);
 	return ret;
 }
 
@@ -727,6 +731,7 @@ static void __exit ism_exit(void)
 {
 	pci_unregister_driver(&ism_driver);
 	debug_unregister(ism_debug_info);
+	pr_info("module unloaded\n");
 }
 
 module_init(ism_init);
-- 
2.48.1



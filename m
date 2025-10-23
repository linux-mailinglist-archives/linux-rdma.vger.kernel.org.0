Return-Path: <linux-rdma+bounces-14026-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B52C0204C
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 17:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618A43B6707
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 15:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3664222068D;
	Thu, 23 Oct 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="czB/VHzj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550012FCBF5;
	Thu, 23 Oct 2025 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232011; cv=none; b=hr4O29lDzANMnAcQpFx1Cj+ocapTKBr94Y4140gr1J+3UCQzsiisa2IdZc9KpmsMV1MZHn7kZIIW2xssowtBNfJlHK0YfbrcQFEaNpTVpti+BKvXl827SES6bQdApDJO0XcQYxbu//21W6anxEVnVl/HpYonwXESkPmU5gljryM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232011; c=relaxed/simple;
	bh=UoQ13NiOpGEiKHmwMpKk6tQhEhUFeAhW/pw6KPT0wg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYjm59+InjG0/yph8496Ww5DkxvDKM5Hy0mE2Fk5BvNEC3L+oyJymY8dps6dKRAbkbotyo1iwDMuEwthLHMShONWHti6jZlshFBphkWKO3CiSkQpzRwCt+hzse7QfNU2INMJUQzye8QwjdAnXlzgocP7K7u4QDWZBb3m5z+9VGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=czB/VHzj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6tuVH019265;
	Thu, 23 Oct 2025 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Av0H3oynECbxpqDu2AL7/Q8q2mkewhV28IVGTKriN
	SM=; b=czB/VHzj9ULWNVCFBwHoQd09I2+ahNHQLazFMGj05zOnpvkRdBMTH96NW
	soxGkprKJVy1XzC/Jzb0LmyLzuKhpaS2QRexIf2Gg7XiaohFXKMGK6y5vZAqWHNY
	LjqvSPnjbHSuHZy/vVdJAPoeilpRV2hGtV9nT1KBsmFK45ryz4kqnFI5beDMCRVA
	+r8gqJ+aqU/v1+4YhhlgpPmEsfftpz2vOEoKyV2caI5kiUbTdWKq7l8yFp4A2Qrk
	RMRwHPt33X+FDPb8UurkWPo8OPUjF+N06E5c7moevcN3dAHL4urlgfzPqsO463Hg
	AYTcJjm5TurVBBKbl8x9c3o32kyww==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w1e0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:06:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NF619q013455;
	Thu, 23 Oct 2025 15:06:41 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30w1e0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:06:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEZrks011075;
	Thu, 23 Oct 2025 15:06:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx1e3bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:06:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NF6aDB26608020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:06:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77C0E2004D;
	Thu, 23 Oct 2025 15:06:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 646772004B;
	Thu, 23 Oct 2025 15:06:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Oct 2025 15:06:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 3A99CE0505; Thu, 23 Oct 2025 17:06:36 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: Julian Ruess <julianr@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 1/2] dibs: Remove reset of static vars in dibs_init()
Date: Thu, 23 Oct 2025 17:06:35 +0200
Message-ID: <20251023150636.3995476-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Thhvfx46WOP6PAZCaySNauprniLkgjZP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+dGYMbMp9Hd9
 wTK2r/i6byqOBUakCbYEPsyjaYhWp2Ko33i5am64cZaxilWE2tiD1OFdS0Ks6vA2h1BJJB1yJcn
 zU7MleHmS9Vj7rZXi2NEVuw0hgRJAWmSrfHocAqecpzSP00DVks1bMbz234Ug1zg6aVBe6DGtsc
 tdWjfsGJx8km9ZnNcqd+GDP4CuPu98HQUvN7BYOupUBZvYSrJQ1egdGX02EddPvwFwjZJgoPofm
 /akljc9dEmoLl8uqat/s5gTh3BT+eKR4CHTJLD+mkS8LDepZJsu+wr8D7fNU4B+GSGKLUiKKmOf
 aH/B5v4az78YVKBGaNwhE/QUGSdvMtL1fX2T/Grm9B5cb8ooLHVv3QJ6CT7y/vw99B12BsTKu44
 KJ4rE3ZKKErNGtWo11vijnNNm9fLYA==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68fa4481 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=8oxiqV0urVS3dNMH5xsA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: _U9ukBPxbYPmKBgv-HbeQZ81lRSho-wk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

'clients' and 'max_client' are static variables and therefore don't need to
be initialized.

Reported-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/dibs/dibs_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index 0374f8350ff7..b015578b4d2e 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -254,9 +254,6 @@ static int __init dibs_init(void)
 {
 	int rc;
 
-	memset(clients, 0, sizeof(clients));
-	max_client = 0;
-
 	dibs_class = class_create("dibs");
 	if (IS_ERR(dibs_class))
 		return PTR_ERR(dibs_class);
-- 
2.48.1



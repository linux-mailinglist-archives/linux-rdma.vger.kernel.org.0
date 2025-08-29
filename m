Return-Path: <linux-rdma+bounces-12992-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62775B3B8AD
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E181C251CE
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB6D307AD8;
	Fri, 29 Aug 2025 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="snAno35Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF43043A7;
	Fri, 29 Aug 2025 10:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756463250; cv=none; b=D+RK2ndHOpCFHGlG6Rp8nLOoEfag1rHFkii/wK12+h+Q3gGlOPbqXDozuMg4ZP5dh04EQAWP2anecCUTbrQwZJ7IXebxfFK2Fxcy7Kq5Egqk+qEOZKC6qbBFnf4b1HCZIn56gSbNv0aJQjN49BuiUb/1do/kYH3p9wcyids7bWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756463250; c=relaxed/simple;
	bh=ogvsYKcqQZQ58IlZfNAiQWG4fD0WX3djKM0QC90r8NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4grAJtbO+OeguRc4PUkf/vJSomDSpkyjru4FfqOBtjuO1x9f8Pj69mNzHUoNuo/6FAFIoPvl1a+p3T7cL+jheUB1zUgfWawQ3DTP+rBSueJTu466uvj8ECM5ziQiRIoJIMhGFpzmDSUNx2U4Px/igpI4OpMX8kzwSN4cBubJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=snAno35Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8HVau003380;
	Fri, 29 Aug 2025 10:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AU+pRV65ps+lu6fGxxvRI1p8KFY8JeO6/KMsaZ58Q
	rE=; b=snAno35Q8iaY0/QsAfBYhGbweaMBZVe9vjCE4fHFArZ8HK3JaG1l2D3b7
	0TxfysEPYT3y69sFSPtvOtSYbh27/6OkoMBA5CxsCHqs+m3I0bAFHHmmq9QpC4/B
	PI72yUSC1GRFiARjS8bVBuw/Y/CnQqKxSB9N5nJabGoAyxL/kuWgQlTHmBbZIyty
	LcDDXtrAkJa57dqGg2/7qSzuxoTnupm9MjWEVamsHA4X5edS5++YHriCz1Y1mUIv
	ao2gdUcOn81elJGVVVwZa9i9ihZXeiSBVpfmQcS7MtsJYvlz+GmbooLM0RY0S+cr
	6xZSYeUG+7rG0/1ahmxkOhQB4wSAw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q558f6e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 10:27:21 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57TARKjl008595;
	Fri, 29 Aug 2025 10:27:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q558f6dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 10:27:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57T7qdxm002612;
	Fri, 29 Aug 2025 10:27:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qt6ms65h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 10:27:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57TARFxa48693604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:27:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84C562004D;
	Fri, 29 Aug 2025 10:27:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73C9320040;
	Fri, 29 Aug 2025 10:27:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 Aug 2025 10:27:15 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id 48727E1555; Fri, 29 Aug 2025 12:27:15 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH net] net/smc: Remove validation of reserved bits in CLC Decline message
Date: Fri, 29 Aug 2025 12:26:26 +0200
Message-ID: <20250829102626.3271637-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0WvA0CzlySulRvhK5ccT1h0AxxuVivi3
X-Proofpoint-ORIG-GUID: giABUWTggCoPcEnqCyM9aRAHaWcyPulq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfXydCKU1CQtvPJ
 Aj+K5oDX1Kb362QoKRfdi2zE+KHZJX5fGUo2t1DMGWJjvvQA2U7l2wszjOo9mhm9BXcdDOWNcgi
 7NiXopzF3jWpcsxAlIN0R1zrB90zs1W/ynpd9jvtO2CbKfGEM3i1IJNmtAJcHTYqwyx8+2GfGTF
 yIUIH58SrI8BEyQSReyDMlMl4T311rRk6k3KVizMuq6CXKFHg3WiAUsSHsNAdSLtIzdbQQ7mJmF
 DKKMfJD0QC5HBFO4vyVHJLE/Sxmc1jiBLOM7/uFZhKLsp9XHR5dBgyWwEh4K7UdRbQcMYo7MHXB
 4Ezn2vff8D+WeNhc2F0lF8k51FAllzmlMfFFLU3UvdK7qBdwq50FnVEgQq3xpOH199nSJaKDsfz
 J80Oiu3P
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68b18089 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=48vgC7mUAAAA:8 a=VnNF1IyMAAAA:8 a=LEj5UjtMw8U8hYbBKdQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

Currently SMC code is validating the reserved bits while parsing the incoming
CLC decline message & when this validation fails, its treated as a protocol
error. As a result, the SMC connection is terminated instead of falling back to
TCP. As per RFC7609[1] specs we shouldn't be validating the reserved bits that
is part of CLC message. This patch fixes this issue.

CLC Decline message format can viewed here[2].

[1] https://datatracker.ietf.org/doc/html/rfc7609#page-92
[2] https://datatracker.ietf.org/doc/html/rfc7609#page-105

Fixes: 8ade200(net/smc: add v2 format of CLC decline message)

Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reference-ID: LTC214332
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

---
 net/smc/smc_clc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index 5a4db151fe95..08be56dfb3f2 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -426,8 +426,6 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
 {
 	struct smc_clc_msg_hdr *hdr = &dclc->hdr;
 
-	if (hdr->typev1 != SMC_TYPE_R && hdr->typev1 != SMC_TYPE_D)
-		return false;
 	if (hdr->version == SMC_V1) {
 		if (ntohs(hdr->length) != sizeof(struct smc_clc_msg_decline))
 			return false;
-- 
2.48.1



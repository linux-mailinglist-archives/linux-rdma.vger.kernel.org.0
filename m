Return-Path: <linux-rdma+bounces-12604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 057FCB1C8F2
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A967E18A850A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6506129ACEC;
	Wed,  6 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XgLcg2xK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE329A323;
	Wed,  6 Aug 2025 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494902; cv=none; b=ahpQrf2h2t63yjIiPPOhUSOIRHnJo9bfp+6AtZZY2mGH6AxIzMHmWNhIs999pAPDbCqtRO+wbtON5X4lYS0yWE7Oi+fyjAEqtQzq48UGacR2zdxjhfuVS/KMnluH5f7NNZa7LgJ+kW/OweQ9GrY0qHoMgMjOZRv9a0PTIxU+wjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494902; c=relaxed/simple;
	bh=qk9utnmfjum8pSSAEyCxqfC1cnuP/GTjTNatjdVHnBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grFb+fjCE8Co5theG24fgwm+gbVw4m6eHI0FHgoFPoqjwJ4bXUv4ThEMBBLUypo2VpMjKqzyySc4RjkwxPVYE6pH9/1hghupv9ksDYk1obo/DFkW+vgrJCFNoLVg9Z6dfuNG55mSXmaW00G4XSDVIv7qm/aNppp/J+cZ21RYUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XgLcg2xK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768kGur010278;
	Wed, 6 Aug 2025 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/Y4aKijQ/5IBhdnqm
	+t3k3egHQMhIOQj1KYxNTkSsks=; b=XgLcg2xKvaFaCcVPwJYRD0Ff0n13wWrJ3
	0vEGdUxB3ouWertMlhvWwIxWL18tbQaW9nHr6R21PuNUSjntjOlb/ygJXXejjdX4
	Cl5U+zeZTMlDr7wibeDPfSU3W2dt0OuB+dlM2JG4I5UenwfFXb9EFd3O6ZOEHWOr
	GgQL2tRWaIp4g80DdRfDYKeOkM9BI4tV+5yYrPL5fAQorUDolnn7zFrxT5ADlwAL
	flaCbbQ1elLI1ey9rnrO0XLsVBd/PQKdq5CV1TmuMNu5LUxL/ORiPvRi3++Zw17d
	KBrbHgltlG/3JacK6Rq6NGv9MOjLOwR/myQgFxiMb6G1M+W1Vj9cg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63n22t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FNERU013677;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63n22n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CUC9j001627;
	Wed, 6 Aug 2025 15:41:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwqv8k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfNji5374248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 153162004F;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 039D22004D;
	Wed,  6 Aug 2025 15:41:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 9C779E1284; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
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
Subject: [RFC net-next 05/17] net/smc: Improve log message for devices w/o pnetid
Date: Wed,  6 Aug 2025 17:41:10 +0200
Message-ID: <20250806154122.3413330-6-wintera@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX4SgQe7Rzatxn
 1EnTmOREwoZac68jVsY7JPll81/dO7uTWuSBBBn7mc9XhqqhxiS+M741Xtcurqs2gMLUzIZD5my
 yy4e0yplHX3eW13S76yCs+SG5DNvut7rIq/effPyOeHO928EgG82GHClTisANuHHLd6NqUKmNgQ
 ZtrfvAC9A3KRhub5ugWxvvopUm189RikJ1q9CigVK+eFklwJX52ReMjTmrIV2OwR0s4S3f2tYK4
 37Ui9IDhD6k/YH7/cO68CVycQ8QljZ2Qjbq3edz/O+8YSvQJlVkVqEBcCHTNABNde9ArrqBDpjg
 GxPTyOMIP5QuwYJOjajMbnUG1whleUlK4XdEITNJmu0QYKpa4pV0/msFj/74LX14gVf4kf5sFmx
 2Aj85IfVPSdKRZfZSyRFs971PZwaUAzf2CdtH+jQ0DiTbYBSOD70+jgyvVZpGhb3dCN6Ytd0
X-Proofpoint-ORIG-GUID: pImYRRYeq3cgMhz7D-q-tSLrG0a2K939
X-Authority-Analysis: v=2.4 cv=LreSymdc c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=ZmQWjMfew9ivcFZuHVcA:9
X-Proofpoint-GUID: -6TQSEq19DSUK7OS0Enz5Of0J7i516XY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxlogscore=767 bulkscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508060096

Explicitly state in the log message, when a device has no pnetid.
"with pnetid" and "has pnetid" was misleading for devices without pnetid.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/smc/smc_ib.c  | 18 +++++++++++-------
 net/smc/smc_ism.c | 13 +++++++++----
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
index 53828833a3f7..f2de12990b5b 100644
--- a/net/smc/smc_ib.c
+++ b/net/smc/smc_ib.c
@@ -971,13 +971,17 @@ static int smc_ib_add_dev(struct ib_device *ibdev)
 					   smcibdev->pnetid[i]))
 			smc_pnetid_by_table_ib(smcibdev, i + 1);
 		smc_copy_netdev_ifindex(smcibdev, i);
-		pr_warn_ratelimited("smc:    ib device %s port %d has pnetid "
-				    "%.16s%s\n",
-				    smcibdev->ibdev->name, i + 1,
-				    smcibdev->pnetid[i],
-				    smcibdev->pnetid_by_user[i] ?
-				     " (user defined)" :
-				     "");
+		if (smc_pnet_is_pnetid_set(smcibdev->pnetid[i]))
+			pr_warn_ratelimited("smc:    ib device %s port %d has pnetid %.16s%s\n",
+					    smcibdev->ibdev->name, i + 1,
+					    smcibdev->pnetid[i],
+					    smcibdev->pnetid_by_user[i] ?
+						" (user defined)" :
+						"");
+		else
+			pr_warn_ratelimited("smc:    ib device %s port %d has no pnetid\n",
+					    smcibdev->ibdev->name, i + 1);
+
 	}
 	schedule_work(&smcibdev->port_event_work);
 	return 0;
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 7363f8be9f94..503a9f93b392 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -515,10 +515,15 @@ static void smcd_register_dev(struct ism_dev *ism)
 	}
 	mutex_unlock(&smcd_dev_list.mutex);
 
-	pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
-			    dev_name(&ism->dev), smcd->pnetid,
-			    smcd->pnetid_by_user ? " (user defined)" : "");
-
+	if (smc_pnet_is_pnetid_set(smcd->pnetid))
+		pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
+				    dev_name(&ism->dev), smcd->pnetid,
+				    smcd->pnetid_by_user ?
+					" (user defined)" :
+					"");
+	else
+		pr_warn_ratelimited("smc: adding smcd device %s without pnetid\n",
+				    dev_name(&ism->dev));
 	return;
 }
 
-- 
2.48.1



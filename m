Return-Path: <linux-rdma+bounces-12600-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A334B1C8E9
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987E4564B84
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7671C2980AC;
	Wed,  6 Aug 2025 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mWT/PGmD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAA2951B3;
	Wed,  6 Aug 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494899; cv=none; b=drJugu6VeGdEaeIzfoK4KaBzyhOpVlKw05yxiZ5B5ajRrrb70AVNRCXei08FFTLwTN6hUXXK1WtiFgHHZhOs6PEEq096YxKs5RQc02ngHgeSY8PrzZyYT9xq+bYfvwo2H/M2W+2sMCFp+qzaLyvJZPlmAkjzjK7IUngZ4UppLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494899; c=relaxed/simple;
	bh=ms8jUoYFODe5gUZXpcG9Jfh2tTzd9g2oLEprlfLQj5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCQa+r7QCRK8Hv7OKfu3CfZa7i+B1AFzVu6El7lr+cufdvqHCejusPm6EXOLR3Cv1GfgQCJVHzh4Pv2xcw+hcosTecKDMmk5rlVPExL4ueK8I4L5r+WlT8NXUz7/juL+aEGBtM5U7NmqLJJntr5bsIAOAi6Y2n5z4sP6bsF2/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mWT/PGmD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5768JSGK021831;
	Wed, 6 Aug 2025 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cc9n4QUOR5KsJEJ3Q
	a0saXIW+DyBSQwFjNVpT8Rsu2k=; b=mWT/PGmDR39blmxZAknIzJGXIwlh0DxQ9
	hUEIu/ugvDingZ8Kaywq0KPIEO8BsYuQ2TUoqCmZVarz7c7jpyIFQw1Ug+EgY4rk
	YTa3bGtgbmE3VTeXK3STUAwXRqDOBmSU1q9QtabuBpt2rA6R7ivh1jZ6CsQpXOiN
	HxoyjrIpSsTnvc9I585SX2co+4zHZuUYTLv3wOLHE00heJU5Stkw2wpg2wLZgRpW
	I/c98pbC+bm1znFnCoU3d3y0uyRXCvaVIYI+hMvDaHKaZcaZjLvhEXHMW6PW+cx1
	rS88PLCVvG3NxNw798y4fvSbnbC1kyGVlvirg9y2X67oHGjF1cAZA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq61w19t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FaIeW004349;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq61w19h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CGEZ4001558;
	Wed, 6 Aug 2025 15:41:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwqv8k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfMRD38863228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB9752004B;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B79BD2004E;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 907C7E084E; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
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
Subject: [RFC net-next 01/17] net/smc: Remove __init marker from smc_core_init()
Date: Wed,  6 Aug 2025 17:41:06 +0200
Message-ID: <20250806154122.3413330-2-wintera@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfXyLzQTfMUzmln
 +8EU7CTcWztWb+FmL0osoh/xPkBFrt5B2hIZGQvCTvxeE6Y36YEHEAVzgoE7n6h58Z1X/q1eIav
 s8hiHUYmLkI4g68d0wQ4zUaD8gasCVx5KVIcp5byRiZkOTxNl+tPh72NKmA0MU1D34jNjF0sslh
 bhw14ogpvlRn4Kd1qnIh8cL+SBz7fBMKmY6+uCF2cCpzShLWxTp2zMz3i3x+35PBpJ96wlZHmvw
 OSq2klUrn+e/deZGx9jPNJ9d46xsrFT9mDLynGaXw9fOpbNgzOVo4tN4oQTQ6HUVZeRN/4FBmgH
 QrNCtg185uX/wdA7LjSyF1x2hzj5K67tRAHJxUwqb0sXVLmwcn1DiU19xaKGQWPm72cXVjpttSN
 TZDE1wmumFCEz1CrO5ALVilPhJbiHbNeYhka62SGwmACzGr7ArDgsZKzewMx6UKvP8cmIyV7
X-Proofpoint-GUID: puU9SRD1brToUCTL1INiKiWcexP1uD58
X-Authority-Analysis: v=2.4 cv=BIuzrEQG c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=Ghz-T2kl8ok8k3dI31sA:9
X-Proofpoint-ORIG-GUID: mJkg1irmYo_UgIklfFhqFNF3wM0Uls0w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060096

Remove the __init marker because smc_core_init() is not the
init function of the smc module and for consistency with
smc_core_exit() which neither has an __exit marker.

Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 262746e304dd..67f9e0b83ebc 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2758,7 +2758,7 @@ static struct notifier_block smc_reboot_notifier = {
 	.notifier_call = smc_core_reboot_event,
 };
 
-int __init smc_core_init(void)
+int smc_core_init(void)
 {
 	return register_reboot_notifier(&smc_reboot_notifier);
 }
-- 
2.48.1



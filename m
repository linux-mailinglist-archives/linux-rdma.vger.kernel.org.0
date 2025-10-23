Return-Path: <linux-rdma+bounces-14027-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A394EC0205B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 17:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F18D9507AB2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03B3333435;
	Thu, 23 Oct 2025 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iXU94Yfl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62932ED3B;
	Thu, 23 Oct 2025 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232015; cv=none; b=ClZOUw6siQZboaAhB2hqi/EiAPhLmaJ+mKX4ubfmGVqJeqgpSoTbA45WFYwfIMmwIQG/DWFRXXNeInBSD6drE4/hMRQYzNFvzZ4wuvK+l7APyuX6dZxYGAber0RLnBWbAZZoE7Vgs8RoCqlnor0jGFS3yU/yexkw3rujmvjsHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232015; c=relaxed/simple;
	bh=BRiUMqg9zivpYlI+dRZOSj6q2DCT+GPC87GO8SOJluE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7jtrk6es0KvnywkdGZE4hOhEyGkU9LYKmjsAa8dqykd1KCff/Ti9itePbQiljuNlY3x0XNPv08wsLmMgLu2nVcJ9rn11xvNSM9VBUoHehDXYiOIUuG60b8OMKzVwFq1bhRBnHhhvs8ucIObtEItceAf0bOQPTfANx1s8ghkbpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iXU94Yfl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NEhZVE006824;
	Thu, 23 Oct 2025 15:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ki3Evuoe0B+CtagIG
	0TkiV52xQ1F0jWit7yNZUWO56s=; b=iXU94YflbpY407zElBAat94ElCDYIU/o7
	n4kap5LUNABFa6WZln5BCssPcywrpxfLA5EzRbKzXFkZjWgrNkrumv5sgZuLUjQ2
	+reRl9OAd5ClAhDN79VlOkOfldhti+WWUOJKF/mVulwmdAw/kwKLwjZJXINNhVHr
	i2b+die3uTyOfaP3fSxMyer+tlF1Pr0om7RVSD0r8YWzJm4xiKWWUukqBdXkcYQR
	u99Ds+zbLn4/dHoMn8LQdnmo2FQmwKsSSbMtRECHh6sIsv3dZXC5nBfdOrgUS06T
	5ERflUTHoXGW/SgBdjS4yeW4yq71qWhdZ+hURHgRjw3N1S+XbX9kg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3272xyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:06:41 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NF4cPI012254;
	Thu, 23 Oct 2025 15:06:41 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v3272xyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:06:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59ND9n5r014676;
	Thu, 23 Oct 2025 15:06:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sekr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 15:06:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59NF6a1937945798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Oct 2025 15:06:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82FE020043;
	Thu, 23 Oct 2025 15:06:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DEC120040;
	Thu, 23 Oct 2025 15:06:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Oct 2025 15:06:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 3F35DE0AE5; Thu, 23 Oct 2025 17:06:36 +0200 (CEST)
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
Subject: [PATCH net-next 2/2] dibs: Use subsys_initcall()
Date: Thu, 23 Oct 2025 17:06:36 +0200
Message-ID: <20251023150636.3995476-2-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023150636.3995476-1-wintera@linux.ibm.com>
References: <20251023150636.3995476-1-wintera@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68fa4481 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=m79NEi6q5JIdXVT0lr0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1RVhHVXvwkgb
 RdbhPWY/IS5629wtPQbx7I4GIs7BcJer4pmmHzkcLNwHkt1yMz9snvsBvWxPXSBLr8GGjtH6BvT
 E+mSSGBeG50mScOUj4cHMfQnx2sjEq7PyNwGLLHdAlrqSEQSYv/GW6aUHARS7IoTxTj9qjsFt7M
 yGyFtGp56TeLgSlhdoC1k0lzAE5DHcvJhYjHJKjo1SUfcowEnBNEZ3jz17QJKrpwX6PMhpwFdXm
 vAlFeiFhxPLwlOWdGq6BjS4o4/rJTtuT8y75BHa6fMcgJVX5UA7If3FehRLswVbMaAw+gccYQZa
 l8oqonUsU4uMwMb53es1l3TBqbxAbzOfx9fLPaf4ekGW9PC29J/kjFe46NUW/sJeTOlPzlt91Zl
 iT2MdAvGbIiWXYOFObfu/eWPSUloUA==
X-Proofpoint-GUID: SOYrsDjzavQjsdXSkb1-D5rOyWyG7NvC
X-Proofpoint-ORIG-GUID: bLTXkn7G35PaUaHzU8ihRTp1WwNN2fWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

In the case of built-in modules, the order of module_init() calls are
derived from the Makefiles.

Use subsys_initcall() for the dibs module, to make sure dibs_init() is
executed before dibs clients like smc and dibs devices like ism are
initialized. So future dibs client or dibs device modules can use
module_init() without the risk of getting the order in the Makefiles wrong.

Reported-by: Mete Durlu <meted@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/dibs/dibs_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index b015578b4d2e..dac14d843af7 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -271,5 +271,5 @@ static void __exit dibs_exit(void)
 	class_destroy(dibs_class);
 }
 
-module_init(dibs_init);
+subsys_initcall(dibs_init);
 module_exit(dibs_exit);
-- 
2.48.1



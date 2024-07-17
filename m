Return-Path: <linux-rdma+bounces-3898-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEDD93451C
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 01:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EADC91F22209
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jul 2024 23:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7DD5674E;
	Wed, 17 Jul 2024 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lWviJCHX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A012B9D2;
	Wed, 17 Jul 2024 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721259956; cv=none; b=GdpLTeKHpkV/SGa5mNo6w2AeX/w5V5WTHyvPlG/4wwTVxilspTRSRkZg/9ES/QZodJkmzW1Gr6KpG2OPoQM6iycs6U8N7KTZ9tbtOYV+lT+MboHnFXJBGQv6W+qj7V71SOYG/btpeLIqT07D/EaAfO6ZQ9kGscL34nD/KAHkM/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721259956; c=relaxed/simple;
	bh=bEE7jrhRvIhDs4BUi8JQGINZgPgShvPL6adGnRB8/pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=imHFGzu6hm6xuvy7n4vZaVWzV7yhRfuG2O+BLKlOwRPbfNDE2H/ty3oA/mOERUObphxxdoewUSiGvT2pExcpBIZK/meRzrEA6Px7wcKGxTHKiUyeaTu+Ke5eBJCrrnxe4L0OOIt0Hbw2yMy+EHPow89cb6+xy4W9VPEn09Icea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lWviJCHX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFnsJ6005577;
	Wed, 17 Jul 2024 23:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OXNvBF64Nz59ICjneZvIeP
	MOzayqGkeJCmGYYUPvj2k=; b=lWviJCHX956Vr8aSyaAWe3iW+/tlnf+9FhHCPW
	Of0yFUH7uAT872AYlxpcxhwZJS/8w960fZUX2+iobDE/A0aFZqsU0KIMhrggPr1A
	DRYweSytAJb3sNSzoKO9az7HnAlr8eqxjFZS5/9HF87V2YJThsD8UyJEAKljYtca
	1nruc5Ye3wA+y9N3KZnUxl1zJEPn/bhMsZWZcIOLqTNclPF8snvbVogFrsOrp6gV
	q2P7H4j6tFxzoj9T/EHC/teCsBrRx2ksCrww8sPkWmghv0CwevWq31VQgScXCSJE
	pMQ9kS8RD7u/tQoGxWdQYG8aD1EgHeDcssIk+P8tH7YOkDgw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfukvuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 23:45:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HNjihC008226
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 23:45:44 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 16:45:44 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 17 Jul 2024 16:45:36 -0700
Subject: [PATCH] RDMA/rds: Remove duplicate MODULE_LICENSE() from ib.c
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240717-ml-net-rds-rdma-v1-1-5cc471a5e20f@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJ9XmGYC/x3MMQ7CMAyF4atUnrGUVkCAqyAGJzXUUhOQXVCkq
 nfHMLzhG96/grEKG1y6FZQ/YvKsjn7XQZ6oPhhldMMQhn2IfcQyY+UFdTRfIaQcj+HEh3NOAfz
 1Ur5L+xevN3ciY0xKNU+/ziz13bzQFixkCyts2xcr0ePUhQAAAA==
To: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <rds-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gEtE7ZsbICbKLd3i4V3rys0uyPF3ufbq
X-Proofpoint-ORIG-GUID: gEtE7ZsbICbKLd3i4V3rys0uyPF3ufbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_18,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170180

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. One strategy for identifying such
modules is to search for files which have a MODULE_LICENSE() but which
do not have a MODULE_DESCRIPTION(). net/rds/ib.c is one such file. And
its product, ib.o, is a component of the rds_rdma module via:

obj-$(CONFIG_RDS_RDMA) += rds_rdma.o
rds_rdma-y :=	rdma_transport.o \
			ib.o ib_cm.o ib_recv.o ib_ring.o ib_send.o ib_stats.o \
			ib_sysctl.o ib_rdma.o ib_frmr.o

Interestingly, when CONFIG_RDS_RDMA=m, the missing description warning
is NOT emitted by modpost. This is because rdma_transport.c contains a
MODULE_DESCRIPTION() that describes this module. And in addition,
rdma_transport.c contains a MODULE_LICENSE() for this module.

Since rdma_transport.c already contains both the MODULE_LICENSE() and
the MODULE_DESCRIPTION() for the rds_rdma module, remove the duplicate
MODULE_LICENSE() from ib.c

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 net/rds/ib.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/rds/ib.c b/net/rds/ib.c
index 9826fe7f9d00..4a33f911673b 100644
--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -603,5 +603,3 @@ int rds_ib_init(void)
 out:
 	return ret;
 }
-
-MODULE_LICENSE("GPL");

---
base-commit: 797012914d2d031430268fe512af0ccd7d8e46ef
change-id: 20240717-ml-net-rds-rdma-ac7608e59cb0



Return-Path: <linux-rdma+bounces-13308-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8016DB546B6
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 11:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E831C851F0
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133427B356;
	Fri, 12 Sep 2025 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LT0kvgcd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3311A27B332;
	Fri, 12 Sep 2025 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757668610; cv=none; b=u0ICh9m4yhHW33lcYdoOwLFH8DVwa13t+2Nq4kNCjNkFIaBftIcDG5PJ9KJ3wn9Vd8ZaAXYIYXtRAkf7Q0O7rPpSIWFYfmqtGc5SS+ispxMmyyfcZeSCtgRrOYOsKXOPB4xyojylseP+k/mi1SGf6TV/wR0q8Ln0ulI9g07V+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757668610; c=relaxed/simple;
	bh=R6TdoxJTGLt58giAE9c066CGOKBAyKfPk46y8hSTDuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzgsXVhGMn2SPwYPZ9WEZrP81rSaVx+yJaj4DGUfy5dN3oYt0xCoXoPCyQV/nNP+EeLoF+TbNcx04l1xv75oj80+F02K8uqcR7L4gtB6DqtFmHaXM0noTRbIambGlTXMIANFOSuMtYL0xI9kr37du3FyeTjd2A7WUdZ3jfAbtm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LT0kvgcd; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1vv7x019342;
	Fri, 12 Sep 2025 09:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=i6PS96kxqQ3nhDF+Bey3wocVR2JPq
	/nepgh0WRD2V4Y=; b=LT0kvgcdztN0EXZueELwJzj0vDj35t26BQTXliPkNrfuG
	GC/XTi1qfa1VT0mpGm6k9En4moQj9qdnfKCkGH7X2VbomclvrYFDWRsKhFGxyvBX
	Iv1/phbHpSlu5emjjvrL93D4Zh8XZigk+sQWVUlfL2jpizf7D18mZMZaqN15+wDD
	iEoJXXRR0uhhGWooIw+5goiDVuDvG08iDA3X9yEP2WQeLWO5L7j/wPFcfV3VUR4w
	SapMifFIQ78OiwjXOadmmJOzBkBBH7UqzAMwiuQPvSjYJETlvv/KZILirNSXtRhP
	RF4+Jl9sOwN4HpxgAm+2H5wLrnnZAmXH/EnCicanw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226syw01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:16:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C89Xqo032848;
	Fri, 12 Sep 2025 09:16:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdekcbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:16:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58C9CJW1014831;
	Fri, 12 Sep 2025 09:16:37 GMT
Received: from prahar-home.osdevelopmeniad.oraclevcn.com (prahar-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.152])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdekcay-1;
	Fri, 12 Sep 2025 09:16:37 +0000
From: Pradyumn Rahar <pradyumn.rahar@oracle.com>
To: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jv@jvosburgh.net,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: pradyumn.rahar@oracle.com, anand.a.khoje@oracle.com,
        rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com,
        rajesh.sivaramasubramaniom@oracle.com
Subject: [PATCH RFC net 1/1] net/bonding: add 0 to the range of arp_missed_max
Date: Fri, 12 Sep 2025 09:16:35 +0000
Message-ID: <20250912091635.3577586-1-pradyumn.rahar@oracle.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120087
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c3e4f6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=pX0Wh22Zp09VsyUOIvQA:9
X-Proofpoint-ORIG-GUID: kiB0TVr1IJRuu_X43Rxpcot7nDFicyfn
X-Proofpoint-GUID: kiB0TVr1IJRuu_X43Rxpcot7nDFicyfn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfXzWg9fZiTXyMU
 rx9sIoU1Ljf56RLhgNf28jCsXv1b+GgrG6p70bA1ZmTSkXHMc/cqomBOXp26BEUAeENptP9OAVP
 rVeCKW8A2YeVF1EiBTo94UIhXGyjX5e3O42GSZ6bQQ5U5AJdA7Oow1OlFdh0k7HmDDzyNYsFn86
 Lar7k/80dUF6ugHuxQGyb/+5aS4JBi4hNnlUOv2vUh33jIArRhCOmBBrtwXonSDJPJkkBMDrsfx
 bvIO2rkiGxrQHAg40FbY/fm3FtKV8qExrzdEl5O84za02AgeTFsD2tVIIqu16jHGylsUhBd+JFs
 QYmEJfmFhQTOT0mKt9uFUpUu8PTh3hsMPXjm5fau/0+9/KWwJFXsufcsN720W8j7quSt/d1O5ui
 fKVwYezo

NetworkManager uses 0 to indicate that the option `arp_missed_max`
is in unset state as this option is not compatible with 802.3AD,
balance-tlb and balance-alb modes.

This causes kernel to report errors like this:

kernel: backend0: option arp_missed_max: invalid value (0)
kernel: backend0: option arp_missed_max: allowed values 1 - 255
NetworkManager[1766]: <error> [1757489103.9525] platform-linux: sysctl: failed to set 'bonding/arp_missed_max' to '0': (22) Invalid argument
NetworkManager[1766]: <warn>  [1757489103.9525] device (backend0): failed to set bonding attribute 'arp_missed_max' to '0'

when NetworkManager tries to set this value to 0

Signed-off-by: Pradyumn Rahar <pradyumn.rahar@oracle.com>
---
 drivers/net/bonding/bond_options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index 3b6f815c55ff..243fde3caecd 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -230,7 +230,7 @@ static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
 };
 
 static const struct bond_opt_value bond_missed_max_tbl[] = {
-	{ "minval",	1,	BOND_VALFLAG_MIN},
+	{ "minval",	0,	BOND_VALFLAG_MIN},
 	{ "maxval",	255,	BOND_VALFLAG_MAX},
 	{ "default",	2,	BOND_VALFLAG_DEFAULT},
 	{ NULL,		-1,	0},
-- 
2.43.7



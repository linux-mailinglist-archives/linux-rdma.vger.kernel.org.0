Return-Path: <linux-rdma+bounces-17299-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Bf+Fj+7oWlhwAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17299-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 16:41:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B63551BA0D3
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003613083033
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Feb 2026 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C7243900B;
	Fri, 27 Feb 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CWzlPCdz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29992D46CE
	for <linux-rdma@vger.kernel.org>; Fri, 27 Feb 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206817; cv=none; b=Gw+BwSElFQ9R+ormLP3S2ie3Fdsxebo7Gc5oUe7081s4OisIc8W4v+5W0y9Rvktnrg7CLr9SBMpuJdqWkWzHljFPGlot3wQ3oEv1Z6b8Mo4LOp+EvRoNMzSjqYsSmdSpcATquhkgWMbdaY8VI7g6tI6uNkdnWvTq6AatShz6Q2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206817; c=relaxed/simple;
	bh=C567CMuwuVyTpsFnwNHhzRh7/OjeLIGFSlHaNgBGGVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kOnMBJsdjdfHQ1VcFOyu6f04DfbhOjJeCsIPGM7vN47SSw5d0x78UHJe3jaOqSzT75YGjPMfpsrFWYA9VMxrA9DmBufoit6VFaeuQTDZawaqDdpyjm/guPHsIIjaWKVwnhADq3AeLCm9FjJ5I6udvgmkayJOso/tLBoS4Ny5ekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CWzlPCdz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61REXDeg2160276;
	Fri, 27 Feb 2026 15:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=jdSZ3b/a6BS4PAoJX4rJi9CZa6fe/
	91e9X7Mj2+njmQ=; b=CWzlPCdzMU23KEL1Sk+vSzIizxRSH9xiIux9ikRRfimjI
	xn+c2XuZz9XGCewN2po8e/kOFoK8ZTJRW4hhqa7CtVTNWPUCCoQzEVBKVjiFmHnU
	gRcvv55Axxqo2Is9Ci06hBE6UGJl5r3n/kP/kCXE1ofI8M4qLu5bnsgbdnwRaqiT
	zvr8Gxnznp7RSY1Wt3xZimVjH67yWwBi+yTD2+DoI5sL9o2yUl/sGmVSusbBqsGO
	xpZchXVJy576u56iF9r9TO1nLzMwY4Rv2qaaZ4aA2T5AIZlCnta/9X8hV6SssAHX
	tJ5jrFprqBLHxusqETSHIeIIarPOlsgR4COeOcuYA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjh01bs4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 15:40:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61REnGPZ016957;
	Fri, 27 Feb 2026 15:40:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35e0xen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 15:40:05 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61RFe5d9032939;
	Fri, 27 Feb 2026 15:40:05 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4cf35e0xd9-1;
	Fri, 27 Feb 2026 15:40:05 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: usman.ansari@broadcom.com, siva.kallam@broadcom.com, leon@kernel.org,
        jgg@ziepe.ca, kalesh-anakkur.purayil@broadcom.com,
        vikas.gupta@broadcom.com, bhargava.marreddy@broadcom.com,
        linux-rdma@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH] RDMA/bng_re: Fix CREQ BAR base validity check in bng_re_map_creq_db
Date: Fri, 27 Feb 2026 07:35:21 -0800
Message-ID: <20260227154002.71038-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_03,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270139
X-Proofpoint-ORIG-GUID: OE1DZheGQwP5JOSdRi1aDGShZQdCXqw7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE0MCBTYWx0ZWRfX8d9zj1Qz6L6X
 ryr02Z6IXx7bNFm2Ae7LpaPXWxXiEFBbr5yYLZznMjeNN+P31HZgMzVYmeKqqZX4qISTPtV6Qcd
 pKk0QKbK+T5qu3mEYA9VbAUsgdt/HAp4flkcFEKQog5jhjMeREpOvt4hoBHdyF5XO5mrvsMi6Zg
 w5Y7aFi81BqPibrZuI9oIVzt4+mD64UV7ztidkakL4a1n6s35REtTiuv0v+Kh/MZkyDaWC7RmTo
 wQDozKW3+2/Zxq2uKGHWdR9KNiRIzZsyMcWMxLuWRDBo9M8KTGRA5PRVnfXaK7t6+RmRlqX/gI/
 1+s3St1Dti0X44s11YX5kzTaUBObazPHooGtWltLhESuMq8qHguISQ9uIAWVFvtreulS+pUPbLX
 hxc/D9nbvpOdXbKx5UWRCl0uwOAj9r50k1dJzuHqngyGMrIK4rD5dccqFbFgn+muEU0zm/SFT7J
 CAu6+X8YC04/WnFf6Gg==
X-Proofpoint-GUID: OE1DZheGQwP5JOSdRi1aDGShZQdCXqw7
X-Authority-Analysis: v=2.4 cv=D+xK6/Rj c=1 sm=1 tr=0 ts=69a1bad8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=zPxBYkUB4hjSTSPddH0A:9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alok.a.tiwari@oracle.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17299-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:dkim,oracle.com:email];
	DKIM_TRACE(0.00)[oracle.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B63551BA0D3
X-Rspamd-Action: no action

bng_re_map_creq_db() initializes creq_db->reg.bar_id to the fixed BAR
index used for the CREQ doorbell, then reads the BAR start address via
pci_resource_start().

The existing code checked !bar_id, which is not a validity test for the
PCI resource start. Check !bar_base instead and log an error when the
BAR start address is 0.

Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/infiniband/hw/bng_re/bng_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
index 17d7cc3aa11d..92e7fa4dcf1a 100644
--- a/drivers/infiniband/hw/bng_re/bng_fw.c
+++ b/drivers/infiniband/hw/bng_re/bng_fw.c
@@ -581,7 +581,7 @@ static int bng_re_map_creq_db(struct bng_re_rcfw *rcfw, u32 reg_offt)
 	creq_db->dbinfo.flags = 0;
 	creq_db->reg.bar_id = BNG_FW_COMM_CONS_PCI_BAR_REGION;
 	creq_db->reg.bar_base = pci_resource_start(pdev, creq_db->reg.bar_id);
-	if (!creq_db->reg.bar_id)
+	if (!creq_db->reg.bar_base)
 		dev_err(&pdev->dev,
 			"CREQ BAR region %d resc start is 0!",
 			creq_db->reg.bar_id);
-- 
2.50.1



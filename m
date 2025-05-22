Return-Path: <linux-rdma+bounces-10519-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76578AC0600
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 09:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11783AB92B
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 07:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA49B22259E;
	Thu, 22 May 2025 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FL5i/l6L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B6221F0C;
	Thu, 22 May 2025 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899879; cv=none; b=kehzBlInTErN1zP9xO3dwBgz1qfTEVHvZFZdaUrPiD8qr6QJQ4bGAilQvDP91zxHlAO3Na9hqJpMnF46Brwi9Nkr0744cI2Uivw+dGjkARKSUxKjwJ2+VCEseklhgfpwlJxcRuOIKPyQUeTmwAh8LWcukwuI5tsL+gF7ZG0/aXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899879; c=relaxed/simple;
	bh=BtfqiiRVqsS0qxmtfX2D1M+DLGt+ChVTw//uQUiE3wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHqqC6+7bYMGoChx55htPp7AgtYVWhaRAEVLVR6RfbcvusM3yfotbikMPm/bgyuhUbP7yYIWFQImZy1Y2igwea9Avot8fJYnLvW7Ul9Y3lUktZ1+pn9kYcN+L8gXEX+xa2J0zqzZuTHa+itc7DnXHUJ6HZIhmZ12JD0mWfXx1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FL5i/l6L; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7ROLP029466;
	Thu, 22 May 2025 07:44:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=KdIlyvNjiLcuBmr3Kr7MVS1P4syN4
	KwyuOVBb9M68+Q=; b=FL5i/l6LqhLTkV3AsiezY/x84Hs5BGKsVm37l+8bfY8VS
	LZJxEu3kkw+hY2w/85/Qz9ShiUdtrMHnRZU9MR+CsLwlkTLotT4NdcHjgcA+4Tnb
	Ul3TrwnrIKounIjwJ759HdMBMD9Lc2eiWp9ds6jAze/dueWB3isYNH2P5mvP053C
	mAe31tftwjyjgdO78i1MI+FuvQDMr01GKUHW/5lFevc0wweUQdYvQ1Y+w8TUU6Qk
	VFO4zj3Mt6bbeGbnFrQD27uIEAB0ju5mnGnPGycx3bwrpH4WT6vCa+26G1eSSsdz
	jeFmpAG/KnB8MdQBOa/JmgyvRpc/eu7KLNtPgl8dA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46syhyr10y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 07:44:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54M68SQ8032152;
	Thu, 22 May 2025 07:44:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46rwenbbpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 07:44:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54M7iGRw032471;
	Thu, 22 May 2025 07:44:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46rwenbbng-1;
	Thu, 22 May 2025 07:44:16 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-doc@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: [PATCH] Doc: networking: Fix various typos in rds.rst
Date: Thu, 22 May 2025 00:43:55 -0700
Message-ID: <20250522074413.3634446-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505220077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA3NiBTYWx0ZWRfX04lAryPlQSxg R3f04CqHWQUcs/hB+4Cp/Smqx0z3cz/QrWZh4OrCc0n+nc4i6WK1DRujbgXa0Boqgstv+yDVq0Q oxEpi6kj4GUrp0RnBO8MqQDWpGYP7ecPiZXQV7Dp1PGNDfJwJ4R9deQUVQRaD8QNj3NI6eHdq2N
 ssf1C6vEgIbUt0nIGutno3+WN7y65lGEKth0JZ2koCWG3bka/f0OlKfhoEPJO82jZwJ4eCUXWXq Sh3LmC5y8YTfrjSHGYLbbPty8c9XZ0FqYQpquizQDDWHZNttclzg171Il6mRs3amJJ4af8HQ3xG Ea948U2Cux3rHm2KAkGRH9meoti9xCHLvXhg0yk8o2oVyu7p2r9UOlg6W0krC3fllBzIgcmmN2F
 oEGkqpPp1uEUXs8aDU9SJ8e9Njo5dwzT27CYpOxadT6hwNB0QQ4HU28BvZx2kCzrcBibSYaJ
X-Authority-Analysis: v=2.4 cv=Q9bS452a c=1 sm=1 tr=0 ts=682ed5d2 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=ey4ux691lM9AAju7rYoA:9
X-Proofpoint-GUID: 2Ct7Ow3-rlpZ2FCOA6-r7z-mmIelWrsZ
X-Proofpoint-ORIG-GUID: 2Ct7Ow3-rlpZ2FCOA6-r7z-mmIelWrsZ

Corrected "sages" to "messages" in the bitmap allocation description.
Fixed "competed" to "completed" in the recv path datagram handling section.
Corrected "privatee" to "private" in the multipath RDS section.
Fixed "mutlipath" to "multipath" in the transport capabilities description.

These changes improve documentation clarity and maintain consistency.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 Documentation/networking/rds.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/rds.rst b/Documentation/networking/rds.rst
index 498395f5fbcb..41b0a6182fe4 100644
--- a/Documentation/networking/rds.rst
+++ b/Documentation/networking/rds.rst
@@ -265,7 +265,7 @@ RDS Protocol
 
       The bitmaps are allocated as connections are brought up.  This
       avoids allocation in the interrupt handling path which queues
-      sages on sockets.  The dense bitmaps let transports send the
+      messages on sockets.  The dense bitmaps let transports send the
       entire bitmap on any bitmap change reasonably efficiently.  This
       is much easier to implement than some finer-grained
       communication of per-port congestion.  The sender does a very
@@ -373,7 +373,7 @@ The recv path
     - validate header checksum
     - copy header to rds_ib_incoming struct if start of a new datagram
     - add to ibinc's fraglist
-    - if competed datagram:
+    - if completed datagram:
 	 - update cong map if datagram was cong update
 	 - call rds_recv_incoming() otherwise
 	 - note if ack is required
@@ -415,7 +415,7 @@ Multipath RDS (mprds)
   I/O workqs and reconnect threads are driven from the rds_conn_path.
   Transports such as TCP that are multipath capable may then set up a
   TCP socket per rds_conn_path, and this is managed by the transport via
-  the transport privatee cp_transport_data pointer.
+  the transport private cp_transport_data pointer.
 
   Transports announce themselves as multipath capable by setting the
   t_mp_capable bit during registration with the rds core module. When the
@@ -430,7 +430,7 @@ Multipath RDS (mprds)
   This is done by sending out a control packet exchange before the
   first data packet. The control packet exchange must have completed
   prior to outgoing hash completion in rds_sendmsg() when the transport
-  is mutlipath capable.
+  is multipath capable.
 
   The control packet is an RDS ping packet (i.e., packet to rds dest
   port 0) with the ping packet having a rds extension header option  of
-- 
2.47.1



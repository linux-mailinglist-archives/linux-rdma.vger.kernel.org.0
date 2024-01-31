Return-Path: <linux-rdma+bounces-818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94284369D
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 07:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296601C259BA
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 06:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D113E48C;
	Wed, 31 Jan 2024 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TPI6HSO2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0213F8C0;
	Wed, 31 Jan 2024 06:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682306; cv=none; b=oXqOqlNcw+DvZIb9pIUzUEhoSmff5zagElnO9g8oBOXZU0tuPL7EttgECvD5VeqGwp70iGjZZRoXIjR4ZLW+Sy8Lx0yfmQgEtDLskaU3Qb2b8fIjtEDmMxMeafkKeiNE0PZoD4RFJM8cNV9YDWlEnClAjgsq47/k3Vh/Z4AEjcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682306; c=relaxed/simple;
	bh=2OixQkP1XzLT6upfkeYL3L91QeFp8NUr/iLMR5vPQMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QP7TXhG+nZYEkgpnU9SFzuYmHmHJWngiri5rcJXcspF3hu/yEUGfUPY88CZmMgHdTZDnu5EleUcTCuyQAI5KY6/O4gbL80QvCgG8xaecFr+IoP3e6kzu8Kx2LL3+MFkBHrEDSMgZR2DTn4QuQMqjbKmQlvIQsPDpzhT8zZ4ZBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TPI6HSO2; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UKwxjD003144;
	Wed, 31 Jan 2024 06:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=A9/Y6j4xelEy7IoU7lyY7odQxgra+0pw5+1WBLZmJ7k=;
 b=TPI6HSO2w83Qx1uoOHnVArIxRnARz65gejBZ4keH4l89p9Y8If16XQeo6/2q7d3NBTh7
 qBIFeSeQeKCDvZH8D6DScanCHXQYI7gOpwPFYN7KL2jOObRdzuJcYMrv4H6EycrCsrdm
 zuYHM2YezVEXJwvxIO6S0zRQH4rmvrQgNa9y2TnN0ozmFgaF709XmbTFXFvCx2nD3T1l
 i7tJOPZUhmUO7hLJRfAo1xlkoBRPTvE/kvr6QAoGocB9bILCs9qe6YdcECOVZqHvkDT9
 2yAx99StaGOZcMlLVkaLVVc1EItnh2Wx1XZd2H7EbUkdOjPf2sTBZYeo6zmiHBEr2s+i aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvr8egtm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 06:24:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40V61JUE035424;
	Wed, 31 Jan 2024 06:24:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9ebs2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 06:24:57 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40V6MZN0010633;
	Wed, 31 Jan 2024 06:24:56 GMT
Received: from brm-x62-14.us.oracle.com (brm-x62-14.us.oracle.com [10.80.150.231])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9ebs27-1;
	Wed, 31 Jan 2024 06:24:56 +0000
From: William Kucharski <william.kucharski@oracle.com>
To: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH 0/1] RDMA/srpt: Do not register event handler until srpt device is fully setup
Date: Tue, 30 Jan 2024 23:24:37 -0700
Message-Id: <20240131062438.869370-1-william.kucharski@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_02,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=5 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310047
X-Proofpoint-ORIG-GUID: OEhXAkNA8GtjUwouApNKrZKbVXLcMT5v
X-Proofpoint-GUID: OEhXAkNA8GtjUwouApNKrZKbVXLcMT5v

Upon occasion, KASAN testing would report a use-after-free Write in
srpt_refresh_port().

In the course of trying to diagnose this, I noticed that the code in
srpt_add_one() registers an event handler for the srpt device and then
initializes the ports on the device. If any portion of the
device port initialization fails, it removes the registration for the
event handler in the error leg.

This felt like a race condition, where an event handler was registered
before the device ports were fully initialized.

While I can't definitively say this was the issue - this change may just
modify timing to mask the real issue - when modified to not register
the event handler until all of the device ports are intialized,
the issue no longer reproduces in KASAN.

I'm submitting  this patch if only so those better acquainted with
the details of this procedure can analyze whether this was an actual
issue or just intellectual uncomfortableness with the code.

William Kucharski (1):
  Upon rare occasions, KASAN reports a use-after-free Write in srpt_refresh_port().

 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.43.0



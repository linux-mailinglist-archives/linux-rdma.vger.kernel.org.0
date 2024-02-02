Return-Path: <linux-rdma+bounces-862-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9EE846BA9
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 10:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7C11C26D18
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D9277634;
	Fri,  2 Feb 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BCRR712n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB78260DEC;
	Fri,  2 Feb 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865371; cv=none; b=TrDtq7wCChvlvpJR0OiatltOp0DgDUaCZP337woHIQU2bHvO7GXs3q65VfeDtY7G6A+MXmn/9dyKudpRfIsIscDMQOsD1/jBNoDGiQPgAEhnYpnAhCWyj35MmNsO+DXacfccKLpqKc3j4K8PQ+Sz8Yx2IGxfbuQCD2dSN+dY3OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865371; c=relaxed/simple;
	bh=+utyHnnx9mcGZ5J4PzIt8PfsL+g+nYZNc6Byd7gtxHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aVLCiXjdADWR+i7l5D6Tk3Y7PEn7fqy0xLaisMKGwYwFpH8nYPPjqem9oHEEGa6BgdsgYCrUwM9RhLEvXuUkH8IGrdbWAClx9gInCW4V7/dEqYvr0c8KXazGdC3nxQLuvfnUmTT7vknOozEL0SoAUcyrhdaJ4peTgDnJIkIOnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BCRR712n; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4128TnWD029241;
	Fri, 2 Feb 2024 09:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=nabJQnqAUmVC+1+SxWOFnpj8FY4yKxXdJKuu8QKdFzE=;
 b=BCRR712nAjPMqSNTleQD+pSd7CZGfQD5tg0LPFo7Ro3BuyFGhUSqEdh2t8cotfQ8wP9d
 qp0uB5zh728wMpBCCmI6e/9lpaGmcBtDO/YwHCDIjZusP4fx8WCfMrMWmD2X1TA5Pdeq
 hjHE6vxq+Ub6cHb+9R4XnDmFIYx/8IiSAAlH8Stss/UK/n53XixEqbOq/jIPla6XvjbB
 zB+cearnXbmRa1NfTr/KqjhlRCDoBFDp/boZfxtX+hHliwcWhb6tybSa/TaNFxRlv/tv
 7CrL11QAa0fKbhbvrghk8ZXUVZMdPzjHOMjLRJ1o+q256InkG55tUI+3DQrx/v29QJA/ DA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcv73vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 09:16:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4127aox4005321;
	Fri, 2 Feb 2024 09:16:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9hnqha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 09:16:02 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4129G2Gb000955;
	Fri, 2 Feb 2024 09:16:02 GMT
Received: from brm-x62-14.us.oracle.com (brm-x62-14.us.oracle.com [10.80.150.231])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9hnqd6-1;
	Fri, 02 Feb 2024 09:16:02 +0000
From: William Kucharski <william.kucharski@oracle.com>
To: Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v2 0/1] RDMA/srpt: Do not register event handler until srpt device is fully setup
Date: Fri,  2 Feb 2024 02:15:48 -0700
Message-Id: <20240202091549.991784-1-william.kucharski@oracle.com>
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
 definitions=2024-02-02_03,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=1 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020067
X-Proofpoint-ORIG-GUID: 77geklJuJGoCb6RxvUP-NTfhO4GpkeB9
X-Proofpoint-GUID: 77geklJuJGoCb6RxvUP-NTfhO4GpkeB9

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

Changelog:
v2:
  * Added Fixes tag

William Kucharski (1):
  RDMA/srpt: Do not register event handler until srpt device is fully setup

 drivers/infiniband/ulp/srpt/ib_srpt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
2.39.3


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



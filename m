Return-Path: <linux-rdma+bounces-2565-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F108CB9CC
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 05:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208591F22DD7
	for <lists+linux-rdma@lfdr.de>; Wed, 22 May 2024 03:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E4B249F5;
	Wed, 22 May 2024 03:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oWQGm2jU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973B139B;
	Wed, 22 May 2024 03:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716348784; cv=none; b=j9QsirrPrXHNqCAAETOaH9Vi5OFqY56Fz81UvurqchNkI9lXrmeQNGbzqBttE0SvQYFAYFNROTMX+6YMjEerORqsaJWJymu+7vSONlEPO4Yagex+HB70G245PYMRzCUUE2I2PrVNSpyA/rJZ1sx4M4+THmdtrOFgRr2xoCd+QLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716348784; c=relaxed/simple;
	bh=LPR/3OUX7k4uodzrLlE9kM1YyY3naFlHqoeE6DgyglE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K9brh0qkIFuYBkUWaqVjssCsRIcCPbRdIps8aQxc79B9VSmfmQTujVuE7DmNVUOpbQN+Wv3Gxs1DyK+5wF8mSBLdGYUXOmdlNmilM/kRhf2mvPkPk89DxmPgA/8k0jr87purruoQ1s3+scZ55ohX/cDdePw3h5EJfXj17atXMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oWQGm2jU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LJi1pS004574;
	Wed, 22 May 2024 03:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=Wixmg3oAwvlEp7wraIn9B9q1PFisDmfBpVWJ4kNjCUY=;
 b=oWQGm2jUv4hcNfvHEqyO8tAN5cHPXk4lab33Wlz54xpCYMlqp+ZdhawkRUCOXis8D/cP
 PE1gffdLQC1lNsY/jlK0sK3mVczHMxVKe2PPW01w5nWlP6sqKzuVQMspioRxMopktiid
 pvwSryJlUF6FfImZfQS3tm5dhkeBXA+OjzuyivVYJbyKWFNCbj0PIORyMespfjpbuyco
 WfzArcjfBPuxMvX1HdgCZVnxCEEZir7Cwv/etpH3BkpgxZE19/BDyfbmKogD65+ssXUi
 Pwe2n4JfJUZi48VD+V5Wz655dD212Rb3S05LN8ix3kZyQy7Xqy1STN6VE7YUenK/Sw7s IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6kxv6scm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 03:33:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44M0XvaK038479;
	Wed, 22 May 2024 03:33:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsem896-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 03:33:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44M3Txah038463;
	Wed, 22 May 2024 03:33:00 GMT
Received: from aakhoje-ol.in.oracle.com (dhcp-10-76-55-136.vpn.oracle.com [10.76.55.136])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6jsem88e-1;
	Wed, 22 May 2024 03:32:59 +0000
From: Anand Khoje <anand.a.khoje@oracle.com>
To: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: anand.a.khoje@oracle.com, rama.nichanamatlu@oracle.com,
        manjunath.b.patil@oracle.com
Subject: [PATCH 0/1] RDMA/mlx5: Release CPU for other processes in mlx5_free_cmd_msg() 
Date: Wed, 22 May 2024 09:02:55 +0530
Message-Id: <20240522033256.11960-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 Content-Type:
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_01,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220024
X-Proofpoint-GUID: bHqx_4QwdUItVzMTZoVKOLzApzQ3fMxg
X-Proofpoint-ORIG-GUID: bHqx_4QwdUItVzMTZoVKOLzApzQ3fMxg

FW pages are allocated and reclaimed through a worker pages_handler().  This
worker allocates mlx5 mailbox messages to populate meta-data associated with the
pages being allocated or reclaimed.  During reclaim of pages, after getting the
meta-data of the pages to reclaim and releasing the pages, the dma pool
associated with the mailbox message is freed using dma_pool_free(), where it
tried to find the dma_page of this dma_pool by walking the page_list.  This is a
slow approach and if the number of pages reclaimed is high, it takes a lot of
time in execution of one work.  As a result, other critical processes are
starved of CPU.

This patch checks if time spent in mlx5_free_cmd_msg() is more than 2 msec, it
yields the CPU for other processes to use.

In our tests, we were able to allocate around 3.4 million FW pages and tried to
deallocate all of them at once, this resulted in the worker thread to yield the
CPU many times.

May 21 04:39:28 kernel: mlx5_core 0000:17:00.0:
mlx5_free_cmd_msg:1352:(pid 327407): Spent more than 2 msecs, yielding CPU
May 21 04:39:28 kernel: mlx5_core 0000:17:00.0:
mlx5_free_cmd_msg:1352:(pid 327407): Spent more than 2 msecs, yielding CPU
May 21 04:39:29 kernel: mlx5_core 0000:17:00.0:
mlx5_free_cmd_msg:1352:(pid 327407): Spent more than 2 msecs, yielding CPU
May 21 04:39:29 kernel: mlx5_core 0000:17:00.0:
mlx5_free_cmd_msg:1352:(pid 327407): Spent more than 2 msecs, yielding CPU


Anand Khoje (1): RDMA/mlx5: Release CPU for other processes in
mlx5_free_cmd_msg()

 drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 7 +++++++ 1 file changed, 7
insertions(+)

-- 1.8.3.1



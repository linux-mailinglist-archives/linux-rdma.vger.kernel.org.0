Return-Path: <linux-rdma+bounces-13114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 248E7B45A97
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2292F7C10EC
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C37836CE11;
	Fri,  5 Sep 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="aRpCABN3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2136.outbound.protection.outlook.com [40.107.94.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF79218EA8;
	Fri,  5 Sep 2025 14:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082745; cv=fail; b=MFFr1JjG74M3sYRoR+/cJVQtLqW361CTyGNdIObXKfI9c1hiHFsqmsLHJvu2II52cT3ktdlAMJvds3nI5CijA80oUqUsi1GApsQxaTgfE7qSp7Ke17ebWpbkYXt/lYU1dq/KK6lpZWiu6pGgkov/DmBqcifJF4Z3v0GNqisTXNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082745; c=relaxed/simple;
	bh=ZwB7GyqENjsuTSqMpBHSwVwrQh1gD3NXhBX2COIsKe8=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=b61n3iO1TICbzRISQ1IAxYQMqiVW/lKElxJ28jBva7BkYTBL+a6NgTyvBc9eaaQqBsfYyXt7elLOUmfsWsyoNj/3PDdN88dGYqDUrJcceHC+Oy6/JjJenvo9L8c24pr36vB5Bqd2Z5UvCxPJUYwjP0wMUVeCwFvRoguha9Mab9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=aRpCABN3; arc=fail smtp.client-ip=40.107.94.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtVVYqsW5YzZ43XKU89b+zkqbtw1BbBkpD7Uh9prxHZwUIJSn8xp3/xF1OT0oGrBaZchNs8bgCQe4DN0hwVfRD5WMrsDQJgba4EMDumq52lHachiWWTg/UKizK4en8KwaNpbqadGBH/qNFC4n4jVz1i6fhDCW66EgxfzHL4/fbC6HVXzmHomVOBHAH0Jr6csej69HVvrecvanhs7Z7T0l21E2jPWMWkEjmKwJm6NDsMYZGcY9r8s0I3dEh1YJYISQz2Me8ZzCnkBy8TJHulvo3sCYf2/oznab7ae5hrc8YehE5sR3s57N5+EbXZ7lZ5QS89AnnCH9sPU7SEKVHx2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrfWkrZvp1ZzqH4saKy0ECavUPwdcjJSFqTeT8cAV1k=;
 b=iuTxKNv+VtLZD6vxfFYer3Ru42vKQXGt3kZF+3odJk6bCu9UCsf9LY4yKZzlB0z/48Dpif9wmFuGCMmy/9pf3sBgk+NacAwdesVezV1x0YoQTRQ0Emcs1j5NysNJ9v9XiC8cvCBXe66aZ0jULhzGAx7KFkr6phEeJ9h8X1ZGOOfIdO4tNmUX4AxPVnoEV4cDcC/8ioobYRknz959SAGIfadPhOe4mCjO812tsBhBG+wgTD+gsdUdl7udEGSglcDlT1JcDZMoaHytM6OqVzoB63Z2smla9f/JhTGLgXnkf922EQryG6o7EJPgxjZ9XrblBhQEhHUnMZ7Zcv19J4LT3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 173.12.59.113) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrfWkrZvp1ZzqH4saKy0ECavUPwdcjJSFqTeT8cAV1k=;
 b=aRpCABN3vkv8Xi/EuZpQMkAB0h/N+GAuTmvKXUJ/jRRiadbp20HrmEXShCzmu5/+elRNx1ympFwhcPHlVfEBs4n6ghrGaywxbcrCEuhO2W6yAu53N1yVVhlwQTrmL23fJ2MdBuulAw5nUCkj6C7XEOLr140RowsHQNj8d2nQDyd6K7EGaioBpxpog1NbjJIq8/TVJ6fFHak3gEM3BkUxJ/vgqAFvrh3VeulcgT5QdFCjOGsw84x5/jizKfdZg8PvzZXsGCokqM+u/VUJL/rytEN2e882WGBvLro80MuWCBQI67kY+lwpLICfRFIMGZjCMLn0ihC8dB4JUO8AuncXKw==
Received: from CYXPR02CA0009.namprd02.prod.outlook.com (2603:10b6:930:cf::17)
 by CO1PR01MB8889.prod.exchangelabs.com (2603:10b6:303:272::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Fri, 5 Sep 2025 14:32:19 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::c7) by CYXPR02CA0009.outlook.office365.com
 (2603:10b6:930:cf::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.20 via Frontend Transport; Fri,
 5 Sep 2025 14:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 173.12.59.113)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 173.12.59.113 as permitted sender)
 receiver=protection.outlook.com; client-ip=173.12.59.113;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (173.12.59.113) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Fri, 5 Sep 2025 14:32:16 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id DB76914D721;
	Fri,  5 Sep 2025 10:32:15 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id C012E1810D6C3;
	Fri,  5 Sep 2025 10:32:15 -0400 (EDT)
Subject: [PATCH for-rc] IB/rdmavt: Fix lock dependency in rvt_send/recv_cq
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: stable@vger.kernel.org, Nick Child <nchild@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
Date: Fri, 05 Sep 2025 10:32:15 -0400
Message-ID:
 <175708273545.611781.8035611015794018890.stgit@awdrv-04.cornelisnetworks.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|CO1PR01MB8889:EE_
X-MS-Office365-Filtering-Correlation-Id: 0403e888-e620-4df1-d54a-08ddec89037a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sk8ybnVqQ1ZJYVBlWUlab2pCZXJZR0JZbTlyeFRkZFl6SU9GN2VZVUducDV0?=
 =?utf-8?B?MzJUdVZDejkxY056dm45OUYwZ1BSY0s5U2pVMDc0Sk4rTjliV3A3c2NkU1pP?=
 =?utf-8?B?RjJXRWJKclMwUnNUWGpVRmdEZWFCNXU0dDNPU1Zzb216TjNUb0xFMnk4R2RQ?=
 =?utf-8?B?QTN1eVJNYjl4WTdqdjM1aWFPcTZDVFdLQ3JEajFiL2p1N1F3QXc2VFNZQWxh?=
 =?utf-8?B?QXE5ZVdyejErOE1BcWxtclNiUmJ0M09XT3hrbzhLWU9ySVBYVWhnb0NWWExP?=
 =?utf-8?B?TVIwcU9SMUdXVWRZdjNReExmWUYvMGx5MjRBZjB5eWZ0UDdMN2o0UGx3d1ZM?=
 =?utf-8?B?L1JnSmMrM2RuZ3l5SEhTTnpHVFQ0bXdyemdBVkMwY1JUT1cvSEJ4TUloUVls?=
 =?utf-8?B?cHBEZThxWTlKV2R4clBuTEhpMkp3OGplMDhBdzNPTFF3MUZMa3dpTVVoOWt5?=
 =?utf-8?B?Z1R4VFd3VU9vSGtzL1BRN2U4ZlU4VjcxcFY5WXpBS2YrMHlPTWZwT2NZbzYy?=
 =?utf-8?B?eXA1cFk5NEYzZW5IcCtYR0FWYXJmcU4raFRub2ltTkRTSFN3YUttS3l4RS9L?=
 =?utf-8?B?TldQWTY1S2NUSGFNSTkzTWlXMDNobXlZTlF2QWF2dFZlaHhXeWhFWi85MDZF?=
 =?utf-8?B?MEhqWTRtWDEwL3NRUzNyQmI2c1ZYTDdlczNWSzVOd21BWm8yQjVZaGdKbEd4?=
 =?utf-8?B?emtBY2lzenFlc25PRG00Rzh5ZiszYldCMXVJTVFJb2NlK3B3WkxoNUNYY0Ja?=
 =?utf-8?B?Q3NvUnkybVFLVVQ3WDlVTmJzSU5iUkMxVGFUTFVlMVZVSlUvUWdjU3VzUkxu?=
 =?utf-8?B?VHRJTHRWbnIxK0taTER4YXFMbng3QkkwOFdqaXlyZFhONWtpWkYrY0pNUnEv?=
 =?utf-8?B?NGhETEJtTDVNMXhHMUw0NkRCVHpHT1hKVFhWRXpVZjBtWUh0MTk1ckVXNnd4?=
 =?utf-8?B?WnNuWUFoMTZUbHU3dnV1eHVUQ3J5YnFydU96YjMzRU01cTRDQkhyd1BuVTNp?=
 =?utf-8?B?am9TVTBOa2NXTXBuYkJwVllzNnhhc2hUMDlsWG02SVlqUG1uSW5VVDliZzJH?=
 =?utf-8?B?Ym9obHFUQ2k2ZmhGWnU4NnlyVmcwM0dDdnM2MWMwOSt3M3RqTnBjOEZHS1lY?=
 =?utf-8?B?bU5zUVlHVEdMcUNGQXVQNHQ1TFBUQ1Zkd3pEM3JNWXM4NzdRbFhiVE1veGsy?=
 =?utf-8?B?T1Q2dExLc2MzVUI5ZnBlMHMzU3N2dXdPa1pqN05jeVMrbTJvY3FQRFhVZXJx?=
 =?utf-8?B?bFdFelZ3eCt1YktIek5ZNC90UndiQURTU2Y5NXQyOG9tRmN2aXViWk9UY01m?=
 =?utf-8?B?T2FKcUowdlh0bHQxQlRNWnhLQUtRLzhRVVk0S3dMSi9rdkUwaDhuZ3FNWEFN?=
 =?utf-8?B?ZUJZZGowbjFGcHF0VnVuRVVJcGpFRE1xNlhpM3VDREx3dEhTQU1OaTJ2SVQ3?=
 =?utf-8?B?eEpuS3NsM05EWU1hZWJ1MWtUS3JidVFtWTZYNGlOQjRlTlh3RlVsY3J5TXFr?=
 =?utf-8?B?L29vWHg5WU0rWHNERE0rL2xrUkNRL21ES3JyVjZwODdqUHA5MDFhSmcxd2FZ?=
 =?utf-8?B?ZENkaWpidHJVNlIwUzgvREZXVTJXK0UvaE93SkpEVHBqT2RmR3ZUZk9ETzFv?=
 =?utf-8?B?YlFFZWl3TFc0a1FrOTVMQVV2L1V5SGNyeTVmQW5qUG16T0FhcHIwdi9YT1ZV?=
 =?utf-8?B?WEdOWU1LMVUvb3NkS1JaeGR0ZUYvNjFrdkZ0UE52eXdiUjJsUjRoVzZYWnEr?=
 =?utf-8?B?eUFXQ1V4R3Bqakp5ZFU5bWRpaXRsbEIzcE0yUTU5alV4NTE3MyswL3M5WmFo?=
 =?utf-8?B?R1RNT3hVTk5TTUVsM1ZlRDdvZEJiYnQvWHo4ejVLUHNZaEl1TDcyVHRqNkd1?=
 =?utf-8?B?Tis3S0NWUEVPVE9XOWRkVUNtdEFCdEJ1TEhHRnNQWHNzTjdmcnpsY1FXUUll?=
 =?utf-8?B?alMwVHBtQzc0QVc1ZE4vd1lqMUNpNjNSdmc2TjR6Uy9Vejl0anYxNnk4Yk9t?=
 =?utf-8?B?NHNUZGJ4aWdmZStSYUFacFljZTJhWXp4R2NxVGE0VUl3dU0raVR4aStXS0VD?=
 =?utf-8?Q?r2jmic?=
X-Forefront-Antispam-Report:
	CIP:173.12.59.113;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:173-12-59-113-Philadelphia.hfc.comcastbusiness.net;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 14:32:16.6260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0403e888-e620-4df1-d54a-08ddec89037a
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[173.12.59.113];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB8889

From: Nick Child <nchild@cornelisnetworks.com>

This fixes commit 4d809f69695d4e ("IB/rdmavt: add lock to call to
rvt_error_qp to prevent a race condition")
and commit 22cbc6c2681a0a ("IB/rdmavt: add missing locks in
rvt_ruc_loopback").

The 2 commits introduced ABBA hard lockup windows.
The r_lock always must be grabbed before the s_lock.

Simply swapping the order of grabbed locks before calling
rvt_send_complete is not acceptable since 99% of the time
rvt_send_complete will not need the r_lock, the completion queue
is likely not full and therefore a call to rvt_error_qp will never
happen. Grabbing both r_lock and s_lock before adding something to
a completion queue is overkill.

On the otherhand, reverting the above commits will allow for a possible
lockdep issue. rvt_send/recv_cq CAN invoke rvt_error_qp. In those cases,
they MUST have both r and s locks.

It turns out that several callers of rvt_error_qp totally ignored this
dependency.

Therefore, undo the afformentioned commits AND implement a wrapper
function around rvt_error_qp that forces the calling functions to specify
what locks they hold. This forces all possible paths to be aware of their
ownership of the r and s lock. The wrapper can then obtain the correct
locks if it needs to.

This is a necessary ugliness to continue to manage layered spinlocks in a
function that is called from several possible codepaths.

Note there are cases when callers only held the s lock. In order to
prevent further ABBA spinlocks we must not attempt to grab the r lock
while someone else holds it. If someone holds it we must drop the s lock
and grab r then s.

Fixes: 4d809f69695d4e ("IB/rdmavt: add lock to call to rvt_error_qp to prevent a race condition")
Fixes: 22cbc6c2681a0a ("IB/rdmavt: add missing locks in rvt_ruc_loopback").
Cc: stable@vger.kernel.org
Signed-off-by: Nick Child <nchild@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/qp.c       |    3 +
 drivers/infiniband/hw/hfi1/rc.c       |   47 ++++++++------
 drivers/infiniband/hw/hfi1/tid_rdma.c |   16 +++--
 drivers/infiniband/hw/hfi1/uc.c       |    9 ++-
 drivers/infiniband/hw/hfi1/ud.c       |   11 ++-
 drivers/infiniband/hw/hfi1/verbs.c    |    9 ++-
 drivers/infiniband/hw/hfi1/verbs.h    |    5 +-
 drivers/infiniband/sw/rdmavt/qp.c     |  110 +++++++++++++++++++++++----------
 include/rdma/rdmavt_qp.h              |   35 ++++++++---
 9 files changed, 165 insertions(+), 80 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/qp.c b/drivers/infiniband/hw/hfi1/qp.c
index f3d8c0c193ac..d4e4fa1ce7a7 100644
--- a/drivers/infiniband/hw/hfi1/qp.c
+++ b/drivers/infiniband/hw/hfi1/qp.c
@@ -895,7 +895,8 @@ static void hfi1_qp_iter_cb(struct rvt_qp *qp, u64 v)
 	spin_lock_irq(&qp->r_lock);
 	spin_lock(&qp->s_hlock);
 	spin_lock(&qp->s_lock);
-	lastwqe = rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+	lastwqe = rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR,
+			       RVT_QP_LOCK_STATE_RS);
 	spin_unlock(&qp->s_lock);
 	spin_unlock(&qp->s_hlock);
 	spin_unlock_irq(&qp->r_lock);
diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index b36242c9d42c..b3edd0030c7e 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -357,11 +357,7 @@ static int make_rc_ack(struct hfi1_ibdev *dev, struct rvt_qp *qp,
 	return 1;
 error_qp:
 	spin_unlock_irqrestore(&qp->s_lock, ps->flags);
-	spin_lock_irqsave(&qp->r_lock, ps->flags);
-	spin_lock(&qp->s_lock);
-	rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
-	spin_unlock(&qp->s_lock);
-	spin_unlock_irqrestore(&qp->r_lock, ps->flags);
+	rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR, RVT_QP_LOCK_STATE_NONE);
 	spin_lock_irqsave(&qp->s_lock, ps->flags);
 bail:
 	qp->s_ack_state = OP(ACKNOWLEDGE);
@@ -448,7 +444,8 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 		clear_ahg(qp);
 		wqe = rvt_get_swqe_ptr(qp, qp->s_last);
 		hfi1_trdma_send_complete(qp, wqe, qp->s_last != qp->s_acked ?
-					 IB_WC_SUCCESS : IB_WC_WR_FLUSH_ERR);
+					 IB_WC_SUCCESS : IB_WC_WR_FLUSH_ERR,
+					 RVT_QP_LOCK_STATE_S);
 		/* will get called again */
 		goto done_free_tx;
 	}
@@ -523,7 +520,8 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 				}
 				rvt_send_complete(qp, wqe,
 						  err ? IB_WC_LOC_PROT_ERR
-						      : IB_WC_SUCCESS);
+						      : IB_WC_SUCCESS,
+						  RVT_QP_LOCK_STATE_S);
 				if (local_ops)
 					atomic_dec(&qp->local_ops_pending);
 				goto done_free_tx;
@@ -1063,7 +1061,8 @@ int hfi1_make_rc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 			hfi1_kern_exp_rcv_clear_all(req);
 			hfi1_kern_clear_hw_flow(priv->rcd, qp);
 
-			hfi1_trdma_send_complete(qp, wqe, IB_WC_LOC_QP_OP_ERR);
+			hfi1_trdma_send_complete(qp, wqe, IB_WC_LOC_QP_OP_ERR,
+						 RVT_QP_LOCK_STATE_S);
 			goto bail;
 		}
 		req->state = TID_REQUEST_RESEND;
@@ -1601,8 +1600,10 @@ void hfi1_restart_rc(struct rvt_qp *qp, u32 psn, int wait)
 				}
 
 				hfi1_trdma_send_complete(qp, wqe,
-							 IB_WC_RETRY_EXC_ERR);
-				rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+							 IB_WC_RETRY_EXC_ERR,
+							 RVT_QP_LOCK_STATE_RS);
+				rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR,
+					     RVT_QP_LOCK_STATE_RS);
 			}
 			return;
 		} else { /* need to handle delayed completion */
@@ -1795,7 +1796,7 @@ void hfi1_rc_send_complete(struct rvt_qp *qp, struct hfi1_opa_header *opah)
 		rvt_qp_complete_swqe(qp,
 				     wqe,
 				     ib_hfi1_wc_opcode[wqe->wr.opcode],
-				     IB_WC_SUCCESS);
+				     IB_WC_SUCCESS, RVT_QP_LOCK_STATE_S);
 	}
 	/*
 	 * If we were waiting for sends to complete before re-sending,
@@ -1827,6 +1828,7 @@ struct rvt_swqe *do_rc_completion(struct rvt_qp *qp,
 {
 	struct hfi1_qp_priv *priv = qp->priv;
 
+	lockdep_assert_held(&qp->r_lock);
 	lockdep_assert_held(&qp->s_lock);
 	/*
 	 * Don't decrement refcount and don't generate a
@@ -1838,10 +1840,10 @@ struct rvt_swqe *do_rc_completion(struct rvt_qp *qp,
 	    cmp_psn(qp->s_sending_psn, qp->s_sending_hpsn) > 0) {
 		trdma_clean_swqe(qp, wqe);
 		trace_hfi1_qp_send_completion(qp, wqe, qp->s_last);
-		rvt_qp_complete_swqe(qp,
-				     wqe,
+		rvt_qp_complete_swqe(qp, wqe,
 				     ib_hfi1_wc_opcode[wqe->wr.opcode],
-				     IB_WC_SUCCESS);
+				     IB_WC_SUCCESS,
+				     RVT_QP_LOCK_STATE_RS);
 	} else {
 		struct hfi1_pportdata *ppd = ppd_from_ibp(ibp);
 
@@ -1958,7 +1960,7 @@ static void update_qp_retry_state(struct rvt_qp *qp, u32 psn, u32 spsn,
  *
  * This is called from rc_rcv_resp() to process an incoming RC ACK
  * for the given QP.
- * May be called at interrupt level, with the QP s_lock held.
+ * May be called at interrupt level. Both r and s lock should be held.
  * Returns 1 if OK, 0 if current operation should be aborted (NAK).
  */
 int do_rc_ack(struct rvt_qp *qp, u32 aeth, u32 psn, int opcode,
@@ -1973,6 +1975,7 @@ int do_rc_ack(struct rvt_qp *qp, u32 aeth, u32 psn, int opcode,
 	int diff;
 	struct rvt_dev_info *rdi;
 
+	lockdep_assert_held(&qp->r_lock);
 	lockdep_assert_held(&qp->s_lock);
 	/*
 	 * Note that NAKs implicitly ACK outstanding SEND and RDMA write
@@ -2232,8 +2235,10 @@ int do_rc_ack(struct rvt_qp *qp, u32 aeth, u32 psn, int opcode,
 				if (wqe->wr.opcode == IB_WR_TID_RDMA_READ)
 					hfi1_kern_read_tid_flow_free(qp);
 
-				hfi1_trdma_send_complete(qp, wqe, status);
-				rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+				hfi1_trdma_send_complete(qp, wqe, status,
+							 RVT_QP_LOCK_STATE_RS);
+				rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR,
+					     RVT_QP_LOCK_STATE_RS);
 			}
 			break;
 
@@ -2265,6 +2270,7 @@ static void rdma_seq_err(struct rvt_qp *qp, struct hfi1_ibport *ibp, u32 psn,
 {
 	struct rvt_swqe *wqe;
 
+	lockdep_assert_held(&qp->r_lock);
 	lockdep_assert_held(&qp->s_lock);
 	/* Remove QP from retry timer */
 	rvt_stop_rc_timers(qp);
@@ -2472,8 +2478,8 @@ static void rc_rcv_resp(struct hfi1_packet *packet)
 	status = IB_WC_LOC_LEN_ERR;
 ack_err:
 	if (qp->s_last == qp->s_acked) {
-		rvt_send_complete(qp, wqe, status);
-		rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+		rvt_send_complete(qp, wqe, status, RVT_QP_LOCK_STATE_RS);
+		rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR, RVT_QP_LOCK_STATE_RS);
 	}
 ack_done:
 	spin_unlock_irqrestore(&qp->s_lock, flags);
@@ -2963,7 +2969,8 @@ void hfi1_rc_rcv(struct hfi1_packet *packet)
 		wc.dlid_path_bits = 0;
 		wc.port_num = 0;
 		/* Signal completion event if the solicited bit is set. */
-		rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr));
+		rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr),
+			    RVT_QP_LOCK_STATE_R);
 		break;
 
 	case OP(RDMA_WRITE_ONLY):
diff --git a/drivers/infiniband/hw/hfi1/tid_rdma.c b/drivers/infiniband/hw/hfi1/tid_rdma.c
index eafd2f157e32..e7b58e7ad233 100644
--- a/drivers/infiniband/hw/hfi1/tid_rdma.c
+++ b/drivers/infiniband/hw/hfi1/tid_rdma.c
@@ -2569,7 +2569,7 @@ void hfi1_rc_rcv_tid_rdma_read_resp(struct hfi1_packet *packet)
 	 * all remaining requests.
 	 */
 	if (qp->s_last == qp->s_acked)
-		rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+		rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR, RVT_QP_LOCK_STATE_RS);
 
 ack_done:
 	spin_unlock_irqrestore(&qp->s_lock, flags);
@@ -4195,13 +4195,14 @@ void hfi1_rc_rcv_tid_rdma_write_resp(struct hfi1_packet *packet)
 ack_op_err:
 	status = IB_WC_LOC_QP_OP_ERR;
 ack_err:
-	rvt_error_qp(qp, status);
+	rvt_error_qp(qp, status, RVT_QP_LOCK_STATE_RS);
 ack_done:
 	if (fecn)
 		qp->s_flags |= RVT_S_ECN;
 	spin_unlock_irqrestore(&qp->s_lock, flags);
 }
 
+/* called with s_lock held */
 bool hfi1_build_tid_rdma_packet(struct rvt_swqe *wqe,
 				struct ib_other_headers *ohdr,
 				u32 *bth1, u32 *bth2, u32 *len)
@@ -4218,8 +4219,9 @@ bool hfi1_build_tid_rdma_packet(struct rvt_swqe *wqe,
 	bool last_pkt;
 
 	if (!tidlen) {
-		hfi1_trdma_send_complete(qp, wqe, IB_WC_REM_INV_RD_REQ_ERR);
-		rvt_error_qp(qp, IB_WC_REM_INV_RD_REQ_ERR);
+		hfi1_trdma_send_complete(qp, wqe, IB_WC_REM_INV_RD_REQ_ERR,
+					 RVT_QP_LOCK_STATE_S);
+		rvt_error_qp(qp, IB_WC_REM_INV_RD_REQ_ERR, RVT_QP_LOCK_STATE_S);
 	}
 
 	*len = min_t(u32, qp->pmtu, tidlen - flow->tid_offset);
@@ -4816,8 +4818,10 @@ static void hfi1_tid_retry_timeout(struct timer_list *t)
 				(u64)priv->tid_retry_timeout_jiffies);
 
 			wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
-			hfi1_trdma_send_complete(qp, wqe, IB_WC_RETRY_EXC_ERR);
-			rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+			hfi1_trdma_send_complete(qp, wqe, IB_WC_RETRY_EXC_ERR,
+						 RVT_QP_LOCK_STATE_RS);
+			rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR,
+				     RVT_QP_LOCK_STATE_RS);
 		} else {
 			wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
 			req = wqe_to_tid_req(wqe);
diff --git a/drivers/infiniband/hw/hfi1/uc.c b/drivers/infiniband/hw/hfi1/uc.c
index 33d2c2a218e2..e758aa55421b 100644
--- a/drivers/infiniband/hw/hfi1/uc.c
+++ b/drivers/infiniband/hw/hfi1/uc.c
@@ -47,7 +47,8 @@ int hfi1_make_uc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 		}
 		clear_ahg(qp);
 		wqe = rvt_get_swqe_ptr(qp, qp->s_last);
-		rvt_send_complete(qp, wqe, IB_WC_WR_FLUSH_ERR);
+		rvt_send_complete(qp, wqe, IB_WC_WR_FLUSH_ERR,
+				  RVT_QP_LOCK_STATE_S);
 		goto done_free_tx;
 	}
 
@@ -100,7 +101,8 @@ int hfi1_make_uc_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 				local_ops = 1;
 			}
 			rvt_send_complete(qp, wqe, err ? IB_WC_LOC_PROT_ERR
-							: IB_WC_SUCCESS);
+							: IB_WC_SUCCESS,
+					  RVT_QP_LOCK_STATE_S);
 			if (local_ops)
 				atomic_dec(&qp->local_ops_pending);
 			goto done_free_tx;
@@ -430,7 +432,8 @@ void hfi1_uc_rcv(struct hfi1_packet *packet)
 		wc.dlid_path_bits = 0;
 		wc.port_num = 0;
 		/* Signal completion event if the solicited bit is set. */
-		rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr));
+		rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr),
+			    RVT_QP_LOCK_STATE_R);
 		break;
 
 	case OP(RDMA_WRITE_FIRST):
diff --git a/drivers/infiniband/hw/hfi1/ud.c b/drivers/infiniband/hw/hfi1/ud.c
index 89d1bae8f824..1e54c9a2087b 100644
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -213,7 +213,8 @@ static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
 	wc.dlid_path_bits = rdma_ah_get_dlid(ah_attr) & ((1 << ppd->lmc) - 1);
 	wc.port_num = qp->port_num;
 	/* Signal completion event if the solicited bit is set. */
-	rvt_recv_cq(qp, &wc, swqe->wr.send_flags & IB_SEND_SOLICITED);
+	rvt_recv_cq(qp, &wc, swqe->wr.send_flags & IB_SEND_SOLICITED,
+		    RVT_QP_LOCK_STATE_R);
 	ibp->rvp.n_loop_pkts++;
 bail_unlock:
 	spin_unlock_irqrestore(&qp->r_lock, flags);
@@ -458,7 +459,8 @@ int hfi1_make_ud_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 			goto bail;
 		}
 		wqe = rvt_get_swqe_ptr(qp, qp->s_last);
-		rvt_send_complete(qp, wqe, IB_WC_WR_FLUSH_ERR);
+		rvt_send_complete(qp, wqe, IB_WC_WR_FLUSH_ERR,
+				  RVT_QP_LOCK_STATE_S);
 		goto done_free_tx;
 	}
 
@@ -500,7 +502,8 @@ int hfi1_make_ud_req(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 			ud_loopback(qp, wqe);
 			spin_lock_irqsave(&qp->s_lock, tflags);
 			ps->flags = tflags;
-			rvt_send_complete(qp, wqe, IB_WC_SUCCESS);
+			rvt_send_complete(qp, wqe, IB_WC_SUCCESS,
+					  RVT_QP_LOCK_STATE_S);
 			goto done_free_tx;
 		}
 	}
@@ -1015,7 +1018,7 @@ void hfi1_ud_rcv(struct hfi1_packet *packet)
 		dlid & ((1 << ppd_from_ibp(ibp)->lmc) - 1);
 	wc.port_num = qp->port_num;
 	/* Signal completion event if the solicited bit is set. */
-	rvt_recv_cq(qp, &wc, solicited);
+	rvt_recv_cq(qp, &wc, solicited, RVT_QP_LOCK_STATE_R);
 	return;
 
 drop:
diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 3cbbfccdd8cd..c7743e17cb33 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -592,7 +592,8 @@ static void verbs_sdma_complete(
 
 	spin_lock(&qp->s_lock);
 	if (tx->wqe) {
-		rvt_send_complete(qp, tx->wqe, IB_WC_SUCCESS);
+		rvt_send_complete(qp, tx->wqe, IB_WC_SUCCESS,
+				  RVT_QP_LOCK_STATE_S);
 	} else if (qp->ibqp.qp_type == IB_QPT_RC) {
 		struct hfi1_opa_header *hdr;
 
@@ -1060,7 +1061,8 @@ int hfi1_verbs_send_pio(struct rvt_qp *qp, struct hfi1_pkt_state *ps,
 pio_bail:
 	spin_lock_irqsave(&qp->s_lock, flags);
 	if (qp->s_wqe) {
-		rvt_send_complete(qp, qp->s_wqe, wc_status);
+		rvt_send_complete(qp, qp->s_wqe, wc_status,
+				  RVT_QP_LOCK_STATE_S);
 	} else if (qp->ibqp.qp_type == IB_QPT_RC) {
 		if (unlikely(wc_status == IB_WC_GENERAL_ERR))
 			hfi1_rc_verbs_aborted(qp, &ps->s_txreq->phdr.hdr);
@@ -1268,7 +1270,8 @@ int hfi1_verbs_send(struct rvt_qp *qp, struct hfi1_pkt_state *ps)
 			hfi1_cdbg(PIO, "%s() Failed. Completing with err",
 				  __func__);
 			spin_lock_irqsave(&qp->s_lock, flags);
-			rvt_send_complete(qp, qp->s_wqe, IB_WC_GENERAL_ERR);
+			rvt_send_complete(qp, qp->s_wqe, IB_WC_GENERAL_ERR,
+					  RVT_QP_LOCK_STATE_S);
 			spin_unlock_irqrestore(&qp->s_lock, flags);
 		}
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/hfi1/verbs.h b/drivers/infiniband/hw/hfi1/verbs.h
index 070e4f0babe8..a6d3023adcc8 100644
--- a/drivers/infiniband/hw/hfi1/verbs.h
+++ b/drivers/infiniband/hw/hfi1/verbs.h
@@ -446,10 +446,11 @@ void hfi1_wait_kmem(struct rvt_qp *qp);
 
 static inline void hfi1_trdma_send_complete(struct rvt_qp *qp,
 					    struct rvt_swqe *wqe,
-					    enum ib_wc_status status)
+					    enum ib_wc_status status,
+					    enum rvt_qp_lock_state lock_state)
 {
 	trdma_clean_swqe(qp, wqe);
-	rvt_send_complete(qp, wqe, status);
+	rvt_send_complete(qp, wqe, status, lock_state);
 }
 
 extern const enum ib_wc_opcode ib_hfi1_wc_opcode[];
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index e825e2ef7966..d6d314de2930 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -703,7 +703,8 @@ void rvt_qp_mr_clean(struct rvt_qp *qp, u32 lkey)
 	if (rvt_ss_has_lkey(&qp->r_sge, lkey) ||
 	    rvt_qp_sends_has_lkey(qp, lkey) ||
 	    rvt_qp_acks_has_lkey(qp, lkey))
-		lastwqe = rvt_error_qp(qp, IB_WC_LOC_PROT_ERR);
+		lastwqe = rvt_error_qp(qp, IB_WC_LOC_PROT_ERR,
+				       RVT_QP_LOCK_STATE_RS);
 check_lwqe:
 	spin_unlock(&qp->s_lock);
 	spin_unlock(&qp->s_hlock);
@@ -1271,18 +1272,7 @@ int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *init_attr,
 	return ret;
 }
 
-/**
- * rvt_error_qp - put a QP into the error state
- * @qp: the QP to put into the error state
- * @err: the receive completion error to signal if a RWQE is active
- *
- * Flushes both send and receive work queues.
- *
- * Return: true if last WQE event should be generated.
- * The QP r_lock and s_lock should be held and interrupts disabled.
- * If we are already in error state, just return.
- */
-int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err)
+static int __rvt_error_qp_locked(struct rvt_qp *qp, enum ib_wc_status err)
 {
 	struct ib_wc wc;
 	int ret = 0;
@@ -1362,6 +1352,64 @@ int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err)
 bail:
 	return ret;
 }
+
+/**
+ * rvt_error_qp - put a QP into the error state
+ * @qp: the QP to put into the error state
+ * @err: the receive completion error to signal if a RWQE is active
+ * @lock_state: caller ownership representation of r and s lock
+ *
+ * Flushes both send and receive work queues.
+ *
+ * Return: true if last WQE event should be generated.
+ * The QP r_lock and s_lock should be held and interrupts disabled.
+ * If we are already in error state, just return.
+ */
+int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err,
+		 enum rvt_qp_lock_state lock_state)
+{
+	int ret;
+
+	switch (lock_state) {
+	case RVT_QP_LOCK_STATE_NONE:
+		unsigned long flags;
+
+		/* only case where caller may not have handled irqs */
+		spin_lock_irqsave(&qp->r_lock, flags);
+		spin_lock(&qp->s_lock);
+		ret = __rvt_error_qp_locked(qp, err);
+		spin_unlock(&qp->s_lock);
+		spin_unlock_irqrestore(&qp->r_lock, flags);
+		break;
+
+	case RVT_QP_LOCK_STATE_S:
+		/* r_lock -> s_lock ordering can be broken here iff
+		 * no one else is using the r_lock at the moment
+		 */
+		if (!spin_trylock(&qp->r_lock)) {
+			/* otherwise we must respect ordering */
+			spin_unlock(&qp->s_lock);
+			spin_lock(&qp->r_lock);
+			spin_lock(&qp->s_lock);
+		}
+		ret = __rvt_error_qp_locked(qp, err);
+		spin_unlock(&qp->r_lock);
+		break;
+
+	case RVT_QP_LOCK_STATE_R:
+		spin_lock(&qp->s_lock);
+		ret = __rvt_error_qp_locked(qp, err);
+		spin_unlock(&qp->s_lock);
+		break;
+
+	case RVT_QP_LOCK_STATE_RS:
+		fallthrough;
+	default:
+		ret = __rvt_error_qp_locked(qp, err);
+	}
+
+	return ret;
+}
 EXPORT_SYMBOL(rvt_error_qp);
 
 /*
@@ -1549,7 +1597,8 @@ int rvt_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		break;
 
 	case IB_QPS_ERR:
-		lastwqe = rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+		lastwqe = rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR,
+				       RVT_QP_LOCK_STATE_RS);
 		break;
 
 	default:
@@ -2460,15 +2509,13 @@ void rvt_comm_est(struct rvt_qp *qp)
 }
 EXPORT_SYMBOL(rvt_comm_est);
 
+/* assumes r_lock is held */
 void rvt_rc_error(struct rvt_qp *qp, enum ib_wc_status err)
 {
-	unsigned long flags;
 	int lastwqe;
 
-	spin_lock_irqsave(&qp->s_lock, flags);
-	lastwqe = rvt_error_qp(qp, err);
-	spin_unlock_irqrestore(&qp->s_lock, flags);
-
+	lockdep_assert_held(&qp->r_lock);
+	lastwqe = rvt_error_qp(qp, err, RVT_QP_LOCK_STATE_R);
 	if (lastwqe) {
 		struct ib_event ev;
 
@@ -2772,10 +2819,11 @@ void rvt_qp_iter(struct rvt_dev_info *rdi,
 EXPORT_SYMBOL(rvt_qp_iter);
 
 /*
- * This should be called with s_lock and r_lock held.
+ * This should be called with s_lock held.
  */
 void rvt_send_complete(struct rvt_qp *qp, struct rvt_swqe *wqe,
-		       enum ib_wc_status status)
+		       enum ib_wc_status status,
+		       enum rvt_qp_lock_state lock_state)
 {
 	u32 old_last, last;
 	struct rvt_dev_info *rdi;
@@ -2787,7 +2835,7 @@ void rvt_send_complete(struct rvt_qp *qp, struct rvt_swqe *wqe,
 	old_last = qp->s_last;
 	trace_rvt_qp_send_completion(qp, wqe, old_last);
 	last = rvt_qp_complete_swqe(qp, wqe, rdi->wc_opcode[wqe->wr.opcode],
-				    status);
+				    status, lock_state);
 	if (qp->s_acked == old_last)
 		qp->s_acked = last;
 	if (qp->s_cur == old_last)
@@ -3123,7 +3171,8 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
 	wc.sl = rdma_ah_get_sl(&qp->remote_ah_attr);
 	wc.port_num = 1;
 	/* Signal completion event if the solicited bit is set. */
-	rvt_recv_cq(qp, &wc, wqe->wr.send_flags & IB_SEND_SOLICITED);
+	rvt_recv_cq(qp, &wc, wqe->wr.send_flags & IB_SEND_SOLICITED,
+		    RVT_QP_LOCK_STATE_R);
 
 send_comp:
 	spin_unlock_irqrestore(&qp->r_lock, flags);
@@ -3131,9 +3180,7 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
 	rvp->n_loop_pkts++;
 flush_send:
 	sqp->s_rnr_retry = sqp->s_rnr_retry_cnt;
-	spin_lock(&sqp->r_lock);
-	rvt_send_complete(sqp, wqe, send_status);
-	spin_unlock(&sqp->r_lock);
+	rvt_send_complete(sqp, wqe, send_status, RVT_QP_LOCK_STATE_S);
 	if (local_ops) {
 		atomic_dec(&sqp->local_ops_pending);
 		local_ops = 0;
@@ -3187,18 +3234,15 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
 	spin_unlock_irqrestore(&qp->r_lock, flags);
 serr_no_r_lock:
 	spin_lock_irqsave(&sqp->s_lock, flags);
-	spin_lock(&sqp->r_lock);
-	rvt_send_complete(sqp, wqe, send_status);
-	spin_unlock(&sqp->r_lock);
+	rvt_send_complete(sqp, wqe, send_status, RVT_QP_LOCK_STATE_S);
 	if (sqp->ibqp.qp_type == IB_QPT_RC) {
 		int lastwqe;
 
-		spin_lock(&sqp->r_lock);
-		lastwqe = rvt_error_qp(sqp, IB_WC_WR_FLUSH_ERR);
-		spin_unlock(&sqp->r_lock);
-
+		lastwqe = rvt_error_qp(sqp, IB_WC_WR_FLUSH_ERR,
+					RVT_QP_LOCK_STATE_S);
 		sqp->s_flags &= ~RVT_S_BUSY;
 		spin_unlock_irqrestore(&sqp->s_lock, flags);
+
 		if (lastwqe) {
 			struct ib_event ev;
 
diff --git a/include/rdma/rdmavt_qp.h b/include/rdma/rdmavt_qp.h
index d67892944193..35339bbe39cc 100644
--- a/include/rdma/rdmavt_qp.h
+++ b/include/rdma/rdmavt_qp.h
@@ -137,6 +137,16 @@
 #define RVT_SEND_OR_FLUSH_OR_RECV_OK \
 	(RVT_PROCESS_SEND_OK | RVT_FLUSH_SEND | RVT_PROCESS_RECV_OK)
 
+/*
+ * Internal relay of held Queue Pair lock state
+ */
+enum rvt_qp_lock_state {
+	RVT_QP_LOCK_STATE_NONE = 0,
+	RVT_QP_LOCK_STATE_S,
+	RVT_QP_LOCK_STATE_R,
+	RVT_QP_LOCK_STATE_RS
+};
+
 /*
  * Internal send flags
  */
@@ -767,7 +777,8 @@ rvt_qp_swqe_incr(struct rvt_qp *qp, u32 val)
 	return val;
 }
 
-int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err);
+int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err,
+		 enum rvt_qp_lock_state lock_state);
 
 /**
  * rvt_recv_cq - add a new entry to completion queue
@@ -775,18 +786,20 @@ int rvt_error_qp(struct rvt_qp *qp, enum ib_wc_status err);
  * @qp: receive queue
  * @wc: work completion entry to add
  * @solicited: true if @entry is solicited
+ * @lock_state: caller ownership representation of r and s lock
  *
  * This is wrapper function for rvt_enter_cq function call by
  * receive queue. If rvt_cq_enter return false, it means cq is
  * full and the qp is put into error state.
  */
 static inline void rvt_recv_cq(struct rvt_qp *qp, struct ib_wc *wc,
-			       bool solicited)
+			       bool solicited,
+			       enum rvt_qp_lock_state lock_state)
 {
 	struct rvt_cq *cq = ibcq_to_rvtcq(qp->ibqp.recv_cq);
 
 	if (unlikely(!rvt_cq_enter(cq, wc, solicited)))
-		rvt_error_qp(qp, IB_WC_LOC_QP_OP_ERR);
+		rvt_error_qp(qp, IB_WC_LOC_QP_OP_ERR, lock_state);
 }
 
 /**
@@ -795,18 +808,20 @@ static inline void rvt_recv_cq(struct rvt_qp *qp, struct ib_wc *wc,
  * @qp: send queue
  * @wc: work completion entry to add
  * @solicited: true if @entry is solicited
+ * @lock_state: caller ownership representation of r and s lock
  *
  * This is wrapper function for rvt_enter_cq function call by
  * send queue. If rvt_cq_enter return false, it means cq is
  * full and the qp is put into error state.
  */
 static inline void rvt_send_cq(struct rvt_qp *qp, struct ib_wc *wc,
-			       bool solicited)
+			       bool solicited,
+			       enum rvt_qp_lock_state lock_state)
 {
 	struct rvt_cq *cq = ibcq_to_rvtcq(qp->ibqp.send_cq);
 
 	if (unlikely(!rvt_cq_enter(cq, wc, solicited)))
-		rvt_error_qp(qp, IB_WC_LOC_QP_OP_ERR);
+		rvt_error_qp(qp, IB_WC_LOC_QP_OP_ERR, lock_state);
 }
 
 /**
@@ -829,13 +844,15 @@ static inline u32
 rvt_qp_complete_swqe(struct rvt_qp *qp,
 		     struct rvt_swqe *wqe,
 		     enum ib_wc_opcode opcode,
-		     enum ib_wc_status status)
+		     enum ib_wc_status status,
+		     enum rvt_qp_lock_state lock_state)
 {
 	bool need_completion;
 	u64 wr_id;
 	u32 byte_len, last;
 	int flags = wqe->wr.send_flags;
 
+	lockdep_assert_held(&qp->s_lock);
 	rvt_qp_wqe_unreserve(qp, flags);
 	rvt_put_qp_swqe(qp, wqe);
 
@@ -860,7 +877,8 @@ rvt_qp_complete_swqe(struct rvt_qp *qp,
 			.qp = &qp->ibqp,
 			.byte_len = byte_len,
 		};
-		rvt_send_cq(qp, &w, status != IB_WC_SUCCESS);
+		rvt_send_cq(qp, &w, status != IB_WC_SUCCESS,
+			    lock_state);
 	}
 	return last;
 }
@@ -886,7 +904,8 @@ void rvt_copy_sge(struct rvt_qp *qp, struct rvt_sge_state *ss,
 		  void *data, u32 length,
 		  bool release, bool copy_last);
 void rvt_send_complete(struct rvt_qp *qp, struct rvt_swqe *wqe,
-		       enum ib_wc_status status);
+		       enum ib_wc_status status,
+		       enum rvt_qp_lock_state lock_state);
 void rvt_ruc_loopback(struct rvt_qp *qp);
 
 /**




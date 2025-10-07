Return-Path: <linux-rdma+bounces-13792-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E28BC1CCD
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Oct 2025 16:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56B2B4EA26F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Oct 2025 14:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175EF2E1EE1;
	Tue,  7 Oct 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C8fN+aKS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAA2DFA2B;
	Tue,  7 Oct 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848532; cv=none; b=k0mdQzwooLzd4+/KJaJlkKug0sWFzCju9itwu660YpEhNwPSfSXnNyM82Bqzr5i/v/RYrL5n/B6PzV7BNIC755maLa0nnJUWmMOKbweVG/KEu2r8KoOeDvK4/jEU0LWZ75fWZYNfgh80PQe2JrQnZP5W2nfSUmFpyLm0h45yiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848532; c=relaxed/simple;
	bh=z5HmmgPSnRAHY03Khmg/L4NBt5sSkrUdWDBcy72dlIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiMOpzisp+dISagX0cgB/+dUkwhvyCXLNDWs6WYiKKuCqxXi5lr6MTeLdl85ZQolmrfhTqxbuVN2I8e01d3Uq7pIBGgfgL0HhcvUzbhq5oL9Vxdi5w0eh8b/mYqTsuBn3wIgh7Yye85Hy6me/FIp7ozeqepOuTpuZ3RkCWELBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C8fN+aKS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59775qAm007914;
	Tue, 7 Oct 2025 14:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9OeCrfT7+te8QI0hZM2PY0LLpqc1e1Cpvi/YOWkra
	Ac=; b=C8fN+aKSI0wW1Xiwn9SybcMR6H/NY8NtWxn08Acq4NnoJU/K5cAhMU8iC
	1gpBLsI79X3ZbpkVUlRxRZxvjjjak5H9krT7t6JO5YzlTmE40NUtN9czta9mOLpG
	nblR8DZOYje9gZgQPLJ3sX6NK9RlHg3P8Np9clj/2KxK4eLQREwlvm4TfJBlNIJA
	on5n8As8oDo4PZfdkbbwLfO1wUR4Xuov+5pc2KON0X8Z8lXgm4L/zKwNOOMwII0P
	4Etdp73YOdSCpkh7n2HzcD1e9QIOYEqSNVL7cbI+L65Yka0Ilbj5BxWppuenkO0m
	UcTx6u5AyNHJXY/MxlsGjh803cgwg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pfawb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 14:48:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 597Eh7HO025642;
	Tue, 7 Oct 2025 14:48:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pfaw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 14:48:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 597EbcPU021251;
	Tue, 7 Oct 2025 14:48:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kgm1bfne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 14:48:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 597EmRoP52756784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Oct 2025 14:48:27 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEA3E20043;
	Tue,  7 Oct 2025 14:48:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A576E20040;
	Tue,  7 Oct 2025 14:48:26 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Oct 2025 14:48:26 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Shay Drori <shayd@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Vesker <valex@mellanox.com>,
        Feras Daoud <ferasda@mellanox.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH net v2] net/mlx5: Avoid deadlock between PCI error recovery and health reporter
Date: Tue,  7 Oct 2025 16:48:26 +0200
Message-ID: <20251007144826.2825134-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvT3+FF9 c=1 sm=1 tr=0 ts=68e52840 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=sWKEhP36mHoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_69atRxAefIsapZGGosA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 3ZoUPiVvIgFsDPfY5UT_l0KEZREjcV77
X-Proofpoint-GUID: 35fo2wBLflfgKKVPIECL0i4FqqLQSy3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwOSBTYWx0ZWRfXzPSpuHAmWTJy
 dDNc64Q1Q72geC3T9so5xRBqqNrE7wUh4yJAOfky/qoyv1uqVo9855Sc8IhXTQepAKFQRoe9YhS
 s4M1ac2jMHdr0XANzsY/9XaMvHPrCDpSoF5hE6KpZZs2n4CnAhmuRkHVV1Ygi3kMLVfLs1BD7jj
 K5NQ0CZFfrLENgSHH0Dd8iYyfiux1AfrHC8E+nXKxPHPYl3vgSZQduixOP+Kr0ejgecc4QZYIRT
 mjeF/T33kgkW09VbA+CAXDjZk9AE1h1LHHMDEHa329B2yHi88TpG5tMHdjodazVM1iZuSApx4Ev
 pkilGvBZ3KYKLKQKgSiBI50COdQF2yTO5yYIvqvIZnhdx8399B7b3960HsFbYsZxayItsXCsYnD
 NOjH9A2vfGW/rD9W9k1u0M5H47J88Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040009

Try to block further PCI config accesses just once when trying to acquire
the VSC GW lock. PCI error recovery on s390 may be blocking accesses
while trying to acquire the devlink lock that mlx5_crdump_collect is
holding already. In effect, this sacrifices the crdump if there is
contention with other tasks about PCI config accesses.

During error recovery testing a pair of tasks was reported to be hung:

[10144.859042] mlx5_core 0000:00:00.1: mlx5_health_try_recover:338:(pid 5553): health recovery flow aborted, PCI reads still not working
[10320.359160] INFO: task kmcheck:72 blocked for more than 122 seconds.
[10320.359169]       Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
[10320.359171] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10320.359172] task:kmcheck         state:D stack:0     pid:72    tgid:72    ppid:2      flags:0x00000000
[10320.359176] Call Trace:
[10320.359178]  [<000000065256f030>] __schedule+0x2a0/0x590
[10320.359187]  [<000000065256f356>] schedule+0x36/0xe0
[10320.359189]  [<000000065256f572>] schedule_preempt_disabled+0x22/0x30
[10320.359192]  [<0000000652570a94>] __mutex_lock.constprop.0+0x484/0x8a8
[10320.359194]  [<000003ff800673a4>] mlx5_unload_one+0x34/0x58 [mlx5_core]
[10320.359360]  [<000003ff8006745c>] mlx5_pci_err_detected+0x94/0x140 [mlx5_core]
[10320.359400]  [<0000000652556c5a>] zpci_event_attempt_error_recovery+0xf2/0x398
[10320.359406]  [<0000000651b9184a>] __zpci_event_error+0x23a/0x2c0
[10320.359411]  [<00000006522b3958>] chsc_process_event_information.constprop.0+0x1c8/0x1e8
[10320.359416]  [<00000006522baf1a>] crw_collect_info+0x272/0x338
[10320.359418]  [<0000000651bc9de0>] kthread+0x108/0x110
[10320.359422]  [<0000000651b42ea4>] __ret_from_fork+0x3c/0x58
[10320.359425]  [<0000000652576642>] ret_from_fork+0xa/0x30
[10320.359440] INFO: task kworker/u1664:6:1514 blocked for more than 122 seconds.
[10320.359441]       Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
[10320.359442] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[10320.359443] task:kworker/u1664:6 state:D stack:0     pid:1514  tgid:1514  ppid:2      flags:0x00000000
[10320.359447] Workqueue: mlx5_health0000:00:00.0 mlx5_fw_fatal_reporter_err_work [mlx5_core]
[10320.359492] Call Trace:
[10320.359521]  [<000000065256f030>] __schedule+0x2a0/0x590
[10320.359524]  [<000000065256f356>] schedule+0x36/0xe0
[10320.359526]  [<0000000652172e28>] pci_wait_cfg+0x80/0xe8
[10320.359532]  [<0000000652172f94>] pci_cfg_access_lock+0x74/0x88
[10320.359534]  [<000003ff800916b6>] mlx5_vsc_gw_lock+0x36/0x178 [mlx5_core]
[10320.359585]  [<000003ff80098824>] mlx5_crdump_collect+0x34/0x1c8 [mlx5_core]
[10320.359637]  [<000003ff80074b62>] mlx5_fw_fatal_reporter_dump+0x6a/0xe8 [mlx5_core]
[10320.359680]  [<0000000652512242>] devlink_health_do_dump.part.0+0x82/0x168
[10320.359683]  [<0000000652513212>] devlink_health_report+0x19a/0x230
[10320.359685]  [<000003ff80075a12>] mlx5_fw_fatal_reporter_err_work+0xba/0x1b0 [mlx5_core]
[10320.359728]  [<0000000651bbf852>] process_one_work+0x1c2/0x458
[10320.359733]  [<0000000651bc073e>] worker_thread+0x3ce/0x528
[10320.359735]  [<0000000651bc9de0>] kthread+0x108/0x110
[10320.359737]  [<0000000651b42ea4>] __ret_from_fork+0x3c/0x58
[10320.359739]  [<0000000652576642>] ret_from_fork+0xa/0x30

No kernel log of the exact same error with an upstream kernel is
available - but the very same deadlock situation can be constructed there,
too:

- task: kmcheck
  mlx5_unload_one() tries to acquire devlink lock while the PCI error
  recovery code has set pdev->block_cfg_access by way of
  pci_cfg_access_lock()
- task: kworker
  mlx5_crdump_collect() tries to set block_cfg_access through
  pci_cfg_access_lock() while devlink_health_report() had acquired
  the devlink lock.

A similar deadlock situation can be reproduced by requesting a
crdump with
  > devlink health dump show pci/<BDF> reporter fw_fatal

while PCI error recovery is executed on the same <BDF> physical function
by mlx5_core's pci_error_handlers. On s390 this can be injected with
  > zpcictl --reset-fw <BDF>

Extensive tests with the same setup that showed the original dead-lock
didn't reproduce, nor did the second deadlock situation hit with
this patch applied.

Fixes: b25bbc2f24dc ("net/mlx5: Add Vendor Specific Capability access gateway")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

---

v1:
Attempted to fix this differently, but still had potential for deadlocks
and the second inject reproduced it quite regularly, still
https://lore.kernel.org/netdev/20250807131130.4056349-1-gbayer@linux.ibm.com/
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index 432c98f2626d..f668237b6bb0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -73,7 +73,9 @@ int mlx5_vsc_gw_lock(struct mlx5_core_dev *dev)
 	u32 lock_val;
 	int ret;
 
-	pci_cfg_access_lock(dev->pdev);
+	if (!pci_cfg_access_trylock(dev->pdev))
+		return -EBUSY;
+
 	do {
 		if (retries > VSC_MAX_RETRIES) {
 			ret = -EBUSY;
-- 
2.48.1



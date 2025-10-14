Return-Path: <linux-rdma+bounces-13863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77714BDA890
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Oct 2025 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FE519A48B2
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Oct 2025 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF40283686;
	Tue, 14 Oct 2025 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BC6vOCHd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53762BE029;
	Tue, 14 Oct 2025 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760457553; cv=none; b=oS0wrP1cNoLgu407fuyV+lqUtSf2qO3/TGIan1JZEbFu7x/mG7QPNk9k6Ys/AV4JHQjuD/uC3+38Bl96uTuCA7lcEQdMw0n7bDpVRaZvPNvUZjWcJz2AkCVSM/Y8+uU4OQY80x8MTq5Ztv4DPfPxDgiKRoqTQwPUbtCtmKGpW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760457553; c=relaxed/simple;
	bh=Cv3+0bdWHxsmuDhQ8zLrQ2TdE8JMQBBh3cle+GrPpPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WYbIHzR9vAC1rHhuw7dFG27R9lGQ79TQ+RO7IHyLXY9WqXZSpXMmJGk1z7KnmOxGOkpM5iINrX4TNtYue3nmJuUDUijJTw7+bK6HuIwl7fRZQBFnircqg6aYvQ5EMbDOR+cTmT7Z96SFskXesqMxcKVeAlW4jDU5aLliMM0bgas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BC6vOCHd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EBLWCC020097;
	Tue, 14 Oct 2025 15:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ATCasm+SNbcvU+hgj+0l+2g8Eiuvo3QQPP16vdtgz
	MU=; b=BC6vOCHdmg04nV6qYMRKOhhPrJ7cwhlvYVlTvfafsFo35TMTIz6/mIWXW
	DiFKXhALI/PFlRStnoGbIqY6nMbG9eS0tapdgA4Zryv/64jOJHhNZtCdG/iULraC
	HLb6D2Vyh+hNAdC8G3Na6sVzKVURvPHazSu8EEmfZCiqJGDvW9WLXl6Ep5WoKQhT
	2rOTiQNJCQNx8IFGPbkXCgtkZWUvSrJDRrTwpUHx7WoWc2vFUM6JrARf1qiOVKt0
	zV2ihiNOzRCUXGCM+WK+TVjA03H2vWk0CEb8wa5Ohfs5otuoBS0F14frE4BoN+2g
	bHmJr+EZFM/hO1JzBmyQGsNfNjxAQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8qpra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 15:59:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEGtDX003663;
	Tue, 14 Oct 2025 15:59:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xxuvdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 15:59:03 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EFwxLY17563972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 15:58:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CEE02006A;
	Tue, 14 Oct 2025 15:58:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6F1C20063;
	Tue, 14 Oct 2025 15:58:52 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 15:58:52 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Shay Drori <shayd@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/pci: Avoid deadlock between PCI error recovery and mlx5 crdump
Date: Tue, 14 Oct 2025 17:58:52 +0200
Message-ID: <20251014155852.1684916-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t567cn2NCJ0Gnp5Ep6bO0w1cB8b52nrw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX0WTciNDtlrxZ
 fujmjphion22mM0VCyDMkVeQF30fIVe7pSI1SZadFFiMpwDFVvrtBtAIS55I9BHNaNN4Z/jmiwr
 4Jcb8CLT1Kg/SJhxKJD8qqHgFkJiQmOa5y6aBZQ/W8fV9p4I80RRmNJ0Ytmm2qV/QvhRGQboWTq
 d5iNWJGieTXTCO1LszOmSWrkbYGOc24hTduR7CdLGpkGaIfc5cDN+DEPWbxJUqwAP4croGCAZlf
 PI7jbfMO4wFVQbaIeLFdJ9G6ciCOeNmOsWCxKvNE2Z1i8cUsUWdTYbE7y4A/tL3NTmDnGebzEQq
 YxV0norOqsJ0vanoUxvBfp7nc+pQ9P4cW9NoHE2Fja935UE2jAJYFwd+n5pw8KSvaW9/uE0x16g
 9sebdN825ectDVSVG2j2pYqXCr5wQA==
X-Proofpoint-GUID: t567cn2NCJ0Gnp5Ep6bO0w1cB8b52nrw
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ee7348 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZSSbZbepod2aoZfJsqwA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

Do not block PCI config accesses through pci_cfg_access_lock() when
executing the s390 variant of PCI error recovery: Acquire just
device_lock() instead of pci_dev_lock() as powerpc's EEH and
generig PCI AER processing do.

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

Tests with this patch failed to reproduce that second deadlock situation,
the devlink command is rejected with "kernel answers: Permission denied" -
and we get a kernel log message of:

Oct 14 13:32:39 b46lp03.lnxne.boe kernel: mlx5_core 1ed0:00:00.1: mlx5_crdump_collect:50:(pid 254382): crdump: failed to lock vsc gw err -5

because the config read of VSC_SEMAPHORE is rejected by the underlying
hardware.

Two prior attempts to address this issue have been discussed and
ultimately rejected [1], with the primary argument that s390's
implementation of PCI error recovery is imposing restriction that
neither powerpc's EEH nor PCI AER handling need. Tests show that PCI
error recovery on s390 is running to completion even without blocking
access to PCI config space.

Link[1]: https://lore.kernel.org/all/20251007144826.2825134-1-gbayer@linux.ibm.com/

Fixes: 4cdf2f4e24ff ("s390/pci: implement minimal PCI error recovery")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>

---

Hi Niklas, Shay, Jason,

by now I believe fixing this in s390/pci is the right way to go, since
the other PCI error recovery implementations apparently don't require
this strict blocking of accesses to the PCI config space.

Hi Alexander, Vasily, Heiko,

while I sent this to netdev since prior versions were discussed there,
I assume this patch will go through the s390 tree, right?

Thanks,
Gerd
---
 arch/s390/pci/pci_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index d930416d4c90..da0de34d2e5c 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -187,7 +187,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	 * is unbound or probed and that userspace can't access its
 	 * configuration space while we perform recovery.
 	 */
-	pci_dev_lock(pdev);
+	device_lock(&pdev->dev);
 	if (pdev->error_state == pci_channel_io_perm_failure) {
 		ers_res = PCI_ERS_RESULT_DISCONNECT;
 		goto out_unlock;
@@ -254,7 +254,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	if (driver->err_handler->resume)
 		driver->err_handler->resume(pdev);
 out_unlock:
-	pci_dev_unlock(pdev);
+	device_unlock(&pdev->dev);
 	zpci_report_status(zdev, "recovery", status_str);
 
 	return ers_res;
-- 
2.48.1



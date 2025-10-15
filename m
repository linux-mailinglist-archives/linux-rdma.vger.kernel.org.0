Return-Path: <linux-rdma+bounces-13869-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 827DFBDE2FC
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 13:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 05C16357368
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Oct 2025 11:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D27831D753;
	Wed, 15 Oct 2025 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C/9p5kVQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BDD1CD15;
	Wed, 15 Oct 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526374; cv=none; b=trb33LkEYhQhhclHHhePku1a9oIrTJ0cjbGhM7G1zbP1ATpFPfdYtugpJVO8gewkr+jd3grJJklHkkyrGSUsHJMhIkuevCLst0eia53+PdVVtacsrN4OvKZA0upYbbFOJ1bN8nf34flCegnLA1NE06u+wdnMmkXJ8AMP7bfCY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526374; c=relaxed/simple;
	bh=v2m1nZvipFsvJCcpj7l8+Lu9t06yeYMQvP3RHG2lI5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P4OA8gTpsnp9fME/e7PR99479UP+ZT4tbxlkk6SSA+KYp/bpy+V0cxCoUBDx4ePx/9MZ9DaEi6m7r4Qv+NJUiPwNRnckPscUIO13HRPZ53kcxo6QBcTKKcjS/wR18DYWSC3eG2gpu0amK8tvbQbG+a++OJX5lBhFjiPX43B4fJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C/9p5kVQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F78cBL030866;
	Wed, 15 Oct 2025 11:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=aMdGnUMd3S7RwZUWiP1bego+z+SZ
	stP1PgG1cky2HFk=; b=C/9p5kVQXhhisMLTKzMZPJJZ7wDMnCSge/EAgf4hzMKD
	VIzWiDE+413174EsNOrZYPtIBinPcgvyQIPOMLwAEDfExwy+3fUpJb0ZTVyxgc+7
	/zc33wtE0++QAeYsGGg/ZWBfX5g8pScIO23o3RV2TjQIbovvg+bqPB9CKuBn2N+e
	wj/HF2G2SiLENV68CVjevfVkKy0tZWl32CZPjZvruMJid4iVOTbKZAHToxURbNPi
	x4FRRDnRKx2QYWOljKCuwF9yFeWLJKIOijg3Yd7KtoBxbj2HJk+Ai0GU72WeRuxT
	q34sDZJlxwjXx6njFd16Hy3YEIr36BF0AeTczdc06w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8v1je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 11:06:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59F9VcNa015190;
	Wed, 15 Oct 2025 11:06:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r1js85gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 11:06:01 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59FB5txK43844072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 11:05:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C009D20101;
	Wed, 15 Oct 2025 11:05:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DEFD200FF;
	Wed, 15 Oct 2025 11:05:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 11:05:55 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 15 Oct 2025 13:05:53 +0200
Subject: [PATCH v2] s390/pci: Avoid deadlock between PCI error recovery and
 mlx5 crdump
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-fix_pcirecov_master-v2-1-e07962fe9558@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIABCA72gC/x2MQQqAMAzAviI9O5iTTvArIiK10x6c0okIsr87P
 AaSvJBYhRP01QvKtyQ5YgFXV0DbHFc2shQGZx02tkET5JlOEmU67mmf08VqEAO3nUXy5KGUp3L
 R/usw5vwBx0vtXmUAAAA=
X-Change-ID: 20251015-fix_pcirecov_master-55fe3705c6c6
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shay Drori <shayd@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -CCVnUTQ3VGEUY4HSuHRZFVjLn0wqABz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX2VxZaC/DFP9b
 sE5BVKjv+31wkzcKDZbVeA46jR7xXaJFbcZtYvPFXcYdapSKQ6O+iJSfEKyTxONM3//lLF6nHRh
 Acj1WTLZyl+5L6/l1Y5yxtHSsiisJxvPM8vq3UZ7x8garpAr74OJ2xS78+We07RXsq88GEGODTL
 ov2wqzWmHobNWM4oxisvpXgI0nMltpewEH02FIJ3Ko6Uy6YLZauOH7fOjmNCs/RxkLr4g5XwEap
 y43Fzgievcekh1h7cRURxBGL34xCJ3nM34j0E5KJT+YWnhhv6PeXUU0Oez0x6u6/DEVgLGoLjjl
 ZJ3N6yF5gEyOgStJmbIkfthvlqoBJN0d+dBj1FAzuxRDnDy+g4F/DbXg9mTrPtuFUInQ13kYuje
 McYwf0BOuz+1XlCcxx2uGc1vJKY12g==
X-Proofpoint-GUID: -CCVnUTQ3VGEUY4HSuHRZFVjLn0wqABz
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ef801a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=ZSSbZbepod2aoZfJsqwA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
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
ultimately rejected [see link], with the primary argument that s390's
implementation of PCI error recovery is imposing restrictions that
neither powerpc's EEH nor PCI AER handling need. Tests show that PCI
error recovery on s390 is running to completion even without blocking
access to PCI config space.

Link: https://lore.kernel.org/all/20251007144826.2825134-1-gbayer@linux.ibm.com/

Fixes: 4cdf2f4e24ff ("s390/pci: implement minimal PCI error recovery")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
All,

sorry for the immediate v2, but I had to rebase this to a current
upstream commit since v1 didn't apply cleanly, as Niklas pointed out in
private. The following assessment from v1 is still valid, though:

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
index b95376041501f479eee20705d45fb8c68553da71..27db1e72c623f8a289cae457e87f0a9896ed241d 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -188,7 +188,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	 * is unbound or probed and that userspace can't access its
 	 * configuration space while we perform recovery.
 	 */
-	pci_dev_lock(pdev);
+	device_lock(&pdev->dev);
 	if (pdev->error_state == pci_channel_io_perm_failure) {
 		ers_res = PCI_ERS_RESULT_DISCONNECT;
 		goto out_unlock;
@@ -257,7 +257,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 		driver->err_handler->resume(pdev);
 	pci_uevent_ers(pdev, PCI_ERS_RESULT_RECOVERED);
 out_unlock:
-	pci_dev_unlock(pdev);
+	device_unlock(&pdev->dev);
 	zpci_report_status(zdev, "recovery", status_str);
 
 	return ers_res;

---
base-commit: 9b332cece987ee1790b2ed4c989e28162fa47860
change-id: 20251015-fix_pcirecov_master-55fe3705c6c6

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>



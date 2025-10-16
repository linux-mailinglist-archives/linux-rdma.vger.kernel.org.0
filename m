Return-Path: <linux-rdma+bounces-13884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3CEBE2A4B
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98571188638A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CE31DDBF;
	Thu, 16 Oct 2025 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X7v9tVPP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EF631CA42;
	Thu, 16 Oct 2025 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608548; cv=none; b=QWiEFotYM+85wTwE0stwEl68Nmznhq+xVi1SSpQO6/rRJnadIZzIcTqUdGhnGhDkenC+kdhD271FkHSA+QQiNdIgmCZVZXb0eNRdZj5vSBZpeX4RLuL8WYojcrt4XXTlg9CyHNtP36OfGS2E8Q/i+xWMjprQIJ73U5gkRyZLGpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608548; c=relaxed/simple;
	bh=WaHJcppaHfmpqPT94nkk2b8FWT7Z886jFAvP3lSGR/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jHO0p/89oW9eF6XlgT/qGn4fDgnMDyMfky1JmPrPYlZHa600/f4YAzPxDwzgoQ87bm1sb+WIzoJ0w1+PRN3LdvDVJCzYZwE/YT81Bjklq+3fmiae9NnTnydt5kIwtY0pxcWmw4ipPZ5q7Wu4vK0FzBUR5sUe0Dc9th4hIv1LsHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X7v9tVPP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FM7elj021041;
	Thu, 16 Oct 2025 09:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=v8L/XaJJedGtgX4ZoXrPanG37G3j
	C4AFYJF+J4PWRBQ=; b=X7v9tVPPuHL8JtLuE0HRv5KkFFqHlmJcJZaJJYa9y2Yq
	n140ilWnuzNLnIJdq2hsC/LDAICkXAhj11AEWFmoXN1QgRgLTqZsm9lcQ2eMpPMR
	C6LULtqAgwsctxyoLoWxRSZsJKUw5Tsuol/lLmUKnYSaq4HPY4IdiH1d/Jw/rOBe
	HDGJF8s0AkSSiR0g55LUXwWEQgN6qqRhdt34Q6KJy/gBDXYSTBG5J9LTp62aFcy8
	HaZhS1wXzyQBed7zk15GHYpqkcOriC7U00RPFltm1ZWxEPuLC1GSL5yWS9f3MDxu
	ITFJU9Shq0wRuDLABCielq8FIjgX/k6ShSzOXLlndg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew08pvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 09:55:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G6F4uL003626;
	Thu, 16 Oct 2025 09:55:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy54yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 09:55:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59G9tTmn47448428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 09:55:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 983AB2004F;
	Thu, 16 Oct 2025 09:27:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D2F32004E;
	Thu, 16 Oct 2025 09:27:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 09:27:04 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Thu, 16 Oct 2025 11:27:03 +0200
Subject: [PATCH v3] s390/pci: Avoid deadlock between PCI error recovery and
 mlx5 crdump
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-fix_pcirecov_master-v3-1-9fb7c7badd67@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAGa68GgC/32NUQ6CMBBEr0L225JSsiB+eQ9DCNZFNrEtabHBk
 N7dygH8fJOZNzsE8kwBLsUOniIHdjZDfSpAz6N9kuBHZlBSYSUrFBNvw6LZk3ZxMGNYyQvEiep
 Wom50A3m5eMq1w3rrM88cVuc/x0lUv/S/LypRCZJt16iJOsTz9cX2vZV8N6V2BvqU0hcSh+/Wu
 gAAAA==
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
        linux-rdma@vger.kernel.org, stable@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HFngLfK9v-M4-cF5971wyzgHObP-mA_5
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f0c11a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=xSZCUV4fZdx31TixUsIA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX8QojlHdVXh2B
 1OqdtT89Q29igKg3cmirFIZHsIkIhGxPoiAY66PZz6xEhUfz3+Qy92gC0nZk+FpL8iOAWrOOjzZ
 CkaOG8ehXsEcWsYsyMHDkQ/bvFJcFdmUTqT5lJYGZh1LTPC2IApLDwYz/ubhnOiSTVQX00MPqL3
 ip2HmnpaZ07X+gWWXf2W+UNruxC7mXqdZk7jH6leNc1stqMDvLxP4RMrbXWBB0RUqmZBcs6cfuW
 29SWhveS0YEnt4R0Wi6yKIonCFhgWtoQpfM4vaSghJeJwoVdMdpHf78WPYlw9VL4CVBKi09m7vM
 t/x68mHlnj3W8Z1jiMvpOcC+DEERrXeE/3H2vqvjecV5c8pnwTDJtLZAWcvSUui2EEzd9bVFVVj
 RVOEPnQXFge6uuZ8y2Ilqx5CuxHeiQ==
X-Proofpoint-GUID: HFngLfK9v-M4-cF5971wyzgHObP-mA_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

Do not block PCI config accesses through pci_cfg_access_lock() when
executing the s390 variant of PCI error recovery: Acquire just
device_lock() instead of pci_dev_lock() as powerpc's EEH and
generig PCI AER processing do.

During error recovery testing a pair of tasks was reported to be hung:

mlx5_core 0000:00:00.1: mlx5_health_try_recover:338:(pid 5553): health recovery flow aborted, PCI reads still not working
INFO: task kmcheck:72 blocked for more than 122 seconds.
      Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kmcheck         state:D stack:0     pid:72    tgid:72    ppid:2      flags:0x00000000
Call Trace:
 [<000000065256f030>] __schedule+0x2a0/0x590
 [<000000065256f356>] schedule+0x36/0xe0
 [<000000065256f572>] schedule_preempt_disabled+0x22/0x30
 [<0000000652570a94>] __mutex_lock.constprop.0+0x484/0x8a8
 [<000003ff800673a4>] mlx5_unload_one+0x34/0x58 [mlx5_core]
 [<000003ff8006745c>] mlx5_pci_err_detected+0x94/0x140 [mlx5_core]
 [<0000000652556c5a>] zpci_event_attempt_error_recovery+0xf2/0x398
 [<0000000651b9184a>] __zpci_event_error+0x23a/0x2c0
INFO: task kworker/u1664:6:1514 blocked for more than 122 seconds.
      Not tainted 5.14.0-570.12.1.bringup7.el9.s390x #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u1664:6 state:D stack:0     pid:1514  tgid:1514  ppid:2      flags:0x00000000
Workqueue: mlx5_health0000:00:00.0 mlx5_fw_fatal_reporter_err_work [mlx5_core]
Call Trace:
 [<000000065256f030>] __schedule+0x2a0/0x590
 [<000000065256f356>] schedule+0x36/0xe0
 [<0000000652172e28>] pci_wait_cfg+0x80/0xe8
 [<0000000652172f94>] pci_cfg_access_lock+0x74/0x88
 [<000003ff800916b6>] mlx5_vsc_gw_lock+0x36/0x178 [mlx5_core]
 [<000003ff80098824>] mlx5_crdump_collect+0x34/0x1c8 [mlx5_core]
 [<000003ff80074b62>] mlx5_fw_fatal_reporter_dump+0x6a/0xe8 [mlx5_core]
 [<0000000652512242>] devlink_health_do_dump.part.0+0x82/0x168
 [<0000000652513212>] devlink_health_report+0x19a/0x230
 [<000003ff80075a12>] mlx5_fw_fatal_reporter_err_work+0xba/0x1b0 [mlx5_core]

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

mlx5_core 1ed0:00:00.1: mlx5_crdump_collect:50:(pid 254382): crdump: failed to lock vsc gw err -5

because the config read of VSC_SEMAPHORE is rejected by the underlying
hardware.

Two prior attempts to address this issue have been discussed and
ultimately rejected [see link], with the primary argument that s390's
implementation of PCI error recovery is imposing restrictions that
neither powerpc's EEH nor PCI AER handling need. Tests show that PCI
error recovery on s390 is running to completion even without blocking
access to PCI config space.

Link: https://lore.kernel.org/all/20251007144826.2825134-1-gbayer@linux.ibm.com/
Cc: stable@vger.kernel.org
Fixes: 4cdf2f4e24ff ("s390/pci: implement minimal PCI error recovery")
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
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
Changes in v3:
- Incorporate changes to commit message as suggested by Niklas.
- Link to v2: https://lore.kernel.org/r/20251015-fix_pcirecov_master-v2-1-e07962fe9558@linux.ibm.com

Changes in v2:
- Rebase to upstream master
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



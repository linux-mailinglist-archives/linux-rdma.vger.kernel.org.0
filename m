Return-Path: <linux-rdma+bounces-12624-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7078B1D8A9
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 15:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867A1189393D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ED525A2A2;
	Thu,  7 Aug 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FK1nzQ7h"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0B214813;
	Thu,  7 Aug 2025 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572308; cv=none; b=dLdAOcF+1Wy9shSLizxlDNIZ8PmL+IcFXMuXZeDnGWazd5QAUdHr+WVWkXxFTmq8LVrLtpuvDwJeJQgUVRob4k69/6Wcck87Re7LpQv9plmMSVzZIx7+cxrZPuYXbkr/4oSnrqTsAKFzNGfpNRJ8WjG84Vm9xcloU29/d/TUcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572308; c=relaxed/simple;
	bh=m26lHftS7IlP7iMGha5zcOVxy2cQ5Y4OefzgkzmDR7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R3IdiuXbUd5P4Y7+DCESIRSOFbmJIqBQN+YQ3lU/N/mwGpVxenlM0VrFnKYZdk2w2GEv6kLU/clf0bvEh52hnEIhjRADGOSZXRAEAW5nNpvlmPN5SWzeKi3BdNBFZ3O5IfsWJ8PiBIo9F4zj/Mi74jraHf4a3oOnDeNcQ4yryd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FK1nzQ7h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5776AYew021685;
	Thu, 7 Aug 2025 13:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Hq6l2Vqaq2ClYP24fuqKUawfQczgoqoysESf8KFRt
	i0=; b=FK1nzQ7hyINYu6PIQ6E99KsFxdmJkNbl3Rl7REfZVeB9Iaw2XadFFNHbB
	y7CMqFWHFeQDs3gZu6zAqs9VZxFyS9V5S5StF5350uhg8g/WRaIj0xGciMPSLzEV
	t0ib8lckmzkn8e8Mj84K5F4zbPaSliJ/5x4x0MBbThLt7N2l2HEBOyZms6mx38Iq
	+ZHQTBkN1AGytgp1WGS/tjNYG1p3fCzbT7CItEaEaocswNHdHIFppagG+nzLcVfv
	px2dx6PNEhduOXv0npgxONkApz799J3Wgsq4L52n5C44S+R2GCZaT8PmrV95ZSc9
	APvsZJw4ByRMzd1GK0YRxBmMj5j9g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63a48s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:11:36 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577D9gQ0011197;
	Thu, 7 Aug 2025 13:11:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63a48p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:11:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5779eev2022647;
	Thu, 7 Aug 2025 13:11:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqgqtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:11:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577DBVJv53150180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 13:11:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E889920043;
	Thu,  7 Aug 2025 13:11:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4D3A20040;
	Thu,  7 Aug 2025 13:11:30 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 13:11:30 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Mohamed Khalfella <mkhalfella@purestorage.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net/mlx5: Avoid deadlock between PCI error recovery and health reporter
Date: Thu,  7 Aug 2025 15:11:30 +0200
Message-ID: <20250807131130.4056349-1-gbayer@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=6894a608 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=VnNF1IyMAAAA:8 a=bw0WNZ3Bkwh0Ihv45_YA:9
X-Proofpoint-GUID: uvjlW20QgFidYsL1fE9SvzET59v4Ld5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEwMyBTYWx0ZWRfX/MXrqH9WlIQp
 lWNNAcnNoBsqPjhog3y1ehaA3BpAZW3FR1q9mHd8IJwYPgKuKYt24A/Hj6NS9Me8Ud7O0wUImCF
 sfvZqWzt1mU+ybNt9Qk3GXEy7YqW/m/zYQZaWzvHYuqB+ZISkxr9tu/7Y4mEAyUab6Q3+xx3eN9
 UtpYcT9FjHTPGyW2Jn4gMs3fVJ++FI9Jj4332lHSg33/Gw+Dox/70Teg5QB6MlWyml9wI9ciP/W
 dg30zllj4gMxAk0ytXSRLh7UUUBK+y3FW6zo4tHJMrhtoO+sYdtJUgIEA5DRO+6m5A6zT0u+RK/
 x5sG07h+R4xEjz7IrbN3j+rSG9xL1Il/0pH6rGHEf6BN+4Gv/V+BRg2RdMfMnE7O//sqgtDM2NY
 zByHx093AOjhmJHRCocTuUD81FNb6Rze2HaklRgKYORESUAFFr8vqIBGlGgPzTy+Thx+3hDu
X-Proofpoint-ORIG-GUID: xNt2Ifd1HMgDAfVOfXdai4ywFg0ik2Yk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070103

During error recovery testing a pair of tasks was reported to be hung
due to a dead-lock situation:

- mlx5_unload_one() trying to acquire devlink lock while the PCI error
  recovery code had acquired the pci_cfg_access_lock().
- mlx5_crdump_collect() trying to acquire the pci_cfg_access_lock()
  while devlink_health_report() had acquired the devlink lock.

Move the check for pci_channel_offline prior to acquiring the
pci_cfg_access_lock in mlx5_vsc_gw_lock since collecting the crdump will
fail anyhow while PCI error recovery is running.

Fixes: 33afbfcc105a ("net/mlx5: Stop waiting for PCI if pci channel is offline")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---

Hi all,

while the initial hit was recorded during "random" testing, where PCI
error recovery and poll_health() tripped almost simultaneously, I found
a way to reproduce a very similar hang at will on s390:

Inject a PCI error recovery event on a Physical Function <BDF> with
  zpcictl --reset-fw <BDF>

then request a crdump with
  devlink health dump show pci/<BDF> reporter fw_fatal

With the patch applied I didn't get the hang but kernel logs showed:
[  792.885743] mlx5_core 000a:00:00.0: mlx5_crdump_collect:51:(pid 1415): crdump: failed to lock vsc gw err -13

and the crdump request ended with:
kernel answers: Permission denied

Thanks, Gerd
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
index 432c98f2626d..d2d3b57a57d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c
@@ -73,16 +73,15 @@ int mlx5_vsc_gw_lock(struct mlx5_core_dev *dev)
 	u32 lock_val;
 	int ret;
 
+	if (pci_channel_offline(dev->pdev))
+		return -EACCES;
+
 	pci_cfg_access_lock(dev->pdev);
 	do {
 		if (retries > VSC_MAX_RETRIES) {
 			ret = -EBUSY;
 			goto pci_unlock;
 		}
-		if (pci_channel_offline(dev->pdev)) {
-			ret = -EACCES;
-			goto pci_unlock;
-		}
 
 		/* Check if semaphore is already locked */
 		ret = vsc_read(dev, VSC_SEMAPHORE_OFFSET, &lock_val);
-- 
2.48.1



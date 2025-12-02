Return-Path: <linux-rdma+bounces-14856-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB52C9B465
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Dec 2025 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E27D4E3084
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Dec 2025 11:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9E30F93A;
	Tue,  2 Dec 2025 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rJjTd+vF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7C30214E;
	Tue,  2 Dec 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764674006; cv=none; b=l9YA45SH4kkiIzNZEmBQiUYwWZ+fWDR8MtukGgaCzdJZ9mw9xgpovbE3aeeThdfEu/X3zmhAAp6EwtC6qn9+ywJihDw2VSr2gCQDXLaYWFwdNUD5jklwk+UQI6WyvJ8QjtRz4Bv/bk9bNWXF+qDvMVeoF/ac47MZ7uAk8184Qfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764674006; c=relaxed/simple;
	bh=keGcTYwsLwdj2ChdMPqRhx7QAtBnAzQIGZXf/N4gSz4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AnCDs81y1YGmq1DI/TlinCRp9vGik6IJUmtJ/edvKRfa7b9KpFzASvi41TFKveAqaN+BuYNV+NUB26Am//pL3bUahy2fEX3VEk2GlrLgcgR6MtWpKKySV4GuWzcFDc0MpFqmeJYs4dZdSJLqt6NSeymWu4cZLUiV2lFdp6Fm7Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rJjTd+vF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2AtTTk031757;
	Tue, 2 Dec 2025 11:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rblBnmAUGiZ3hwl7PnlczalI4c5Y
	vILwz3dcXl3HoeA=; b=rJjTd+vF4Polmm5UbQh66Wlr7DwjmTtWoKFmxaAcpujm
	gz0cQUXILEWi/ESLkLokSp60FAi2696HBnewDIaORb87KhZbRPgQEy5tZ3x0pNTP
	mLvOqeID2QZVh8Us/Uu9jWM5JrWdUcz07od7SzdI3gjP/d3PG6bDkhYnSjQEDJBJ
	xmGPaRHI8VVaH7VRfcOjWn8Tf+WqUcrf4fshLIT7+gX1LvcGAUutx0F9yD6ZnxfD
	YL0aWtfeQlcqjdwuLd+O8wM14jkRdWZtCcIPJ3xZ15ubBo8g+Nr9Krb966kR46tF
	Cmb8QQdIjXMAuaRmh/3zHEMYTZO7cql9KT0vJhgEvg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg4q53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 11:13:09 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B2B4dKO020019;
	Tue, 2 Dec 2025 11:13:08 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrbg4q4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 11:13:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B28CX2r029323;
	Tue, 2 Dec 2025 11:13:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ardv1bnqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Dec 2025 11:13:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B2BD3rP43450832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Dec 2025 11:13:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D48F420043;
	Tue,  2 Dec 2025 11:13:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 870C02004E;
	Tue,  2 Dec 2025 11:13:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Dec 2025 11:13:03 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Tue, 02 Dec 2025 12:12:57 +0100
Subject: [PATCH net] net/mlx5: Fix double unregister of HCA_PORTS component
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIALjJLmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDIKGbllkRn5OYrmuWaGqZZGyZaJBknKwEVF1QlAqUApsUrZSXWqIUW1s
 LAGP4BAVeAAAA
X-Change-ID: 20251202-fix_lag-6a59b39a0b3c
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shay Drory <shayd@nvidia.com>,
        Simon Horman <horms@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5pZmpnQk6WvClrOKhI1CkQ_c6e-P3Qkb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAxNiBTYWx0ZWRfXwohvJcgaBXBu
 y42CwzbLeiLat1T6oz1f3gd4JHsTaUOaRtClNP0Zk4s2B81c50bn08qJL1f8bfCXuRME8D4+j8B
 xcqJ2eDxS7bJBtQxl4fQDRFWzcauHncLsjlydaFUG6m3FY+5dEeWaOjPvPXpCDo90uyyZx4UFLg
 5pXBAHgjtaTMIytnR9lesJBNiz95UfWp32wFJZPrTfxGp03dInvTf3cCapszkVVSLodKFOzrNlC
 0OPkofsUjCVNFr1pMl0gxIZBy2tnJPbKPkK8sw/c3SXA0YlHh4dNlTK6uvqwetpJZXIiJL390fp
 iMbhv7yxeYxQ3Gm+sdXWxmW0P1cHd3astPxrDddp6h2q0LZKbF+s35BSzHKQ6sYvt5eEg0RKV/b
 J5Qzhjj29p+6Rd5NnMyAGKQsvDdh5g==
X-Authority-Analysis: v=2.4 cv=UO7Q3Sfy c=1 sm=1 tr=0 ts=692ec9c5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=lpMsz9KTY4IS-HHdNcEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XpH6jlo8paa3nL-Gb_iNUNyDcf7xQiZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290016

Clear hca_devcom_comp in device's private data after unregistering it in
LAG teardown. Otherwise a slightly lagging second pass through
mlx5_unload_one() might try to unregister it again and trip over
use-after-free.

On s390 almost all PCI level recovery events trigger two passes through
mxl5_unload_one() - one through the poll_health() method and one through
mlx5_pci_err_detected() as callback from generic PCI error recovery.
While testing PCI error recovery paths with more kernel debug features
enabled, this issue reproducibly led to kernel panics with the following
call chain:

 Unable to handle kernel pointer dereference in virtual kernel address space
 Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803 ESOP-2 FSI
 Fault in home space mode while using kernel ASCE.
 AS:00000000705c4007 R3:0000000000000024
 Oops: 0038 ilc:3 [#1]SMP

 CPU: 14 UID: 0 PID: 156 Comm: kmcheck Kdump: loaded Not tainted
      6.18.0-20251130.rc7.git0.16131a59cab1.300.fc43.s390x+debug #1 PREEMPT

 Krnl PSW : 0404e00180000000 0000020fc86aa1dc (__lock_acquire+0x5c/0x15f0)
            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
 Krnl GPRS: 0000000000000000 0000020f00000001 6b6b6b6b6b6b6c33 0000000000000000
            0000000000000000 0000000000000000 0000000000000001 0000000000000000
            0000000000000000 0000020fca28b820 0000000000000000 0000010a1ced8100
            0000010a1ced8100 0000020fc9775068 0000018fce14f8b8 0000018fce14f7f8
 Krnl Code: 0000020fc86aa1cc: e3b003400004        lg      %r11,832
            0000020fc86aa1d2: a7840211           brc     8,0000020fc86aa5f4
           *0000020fc86aa1d6: c09000df0b25       larl    %r9,0000020fca28b820
           >0000020fc86aa1dc: d50790002000       clc     0(8,%r9),0(%r2)
            0000020fc86aa1e2: a7840209           brc     8,0000020fc86aa5f4
            0000020fc86aa1e6: c0e001100401       larl    %r14,0000020fca8aa9e8
            0000020fc86aa1ec: c01000e25a00       larl    %r1,0000020fca2f55ec
            0000020fc86aa1f2: a7eb00e8           aghi    %r14,232

 Call Trace:
  __lock_acquire+0x5c/0x15f0
  lock_acquire.part.0+0xf8/0x270
  lock_acquire+0xb0/0x1b0
  down_write+0x5a/0x250
  mlx5_detach_device+0x42/0x110 [mlx5_core]
  mlx5_unload_one_devl_locked+0x50/0xc0 [mlx5_core]
  mlx5_unload_one+0x42/0x60 [mlx5_core]
  mlx5_pci_err_detected+0x94/0x150 [mlx5_core]
  zpci_event_attempt_error_recovery+0xcc/0x388

Fixes: 5a977b5833b7 ("net/mlx5: Lag, move devcom registration to LAG layer")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Hi Shay et al,

while checking for potential regressions by Lukas Wunner's recent work
on pci_save/restore_state() for the recoverability of mlx5 functions I
consistently hit this bug. (Bjorn has queued this up for 6.19, according
to [0] and [1]) 

Apparently, the issue is unrelated to Lukas' work but can be reproduced
with master. It appears to be timing-sensitive, since it shows up only
when I use s390's debug_defconfig, but I think needs fixing anyhow, as
timing can change for other reasons, too.

I've spotted two additional places where the devcom reference is not
cleared after calling mlx5_devcom_unregister_component() in
drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c that I have not
addressed with a patch, since I'm unclear about how to test these
paths.

Thanks,
Gerd

[0] https://lore.kernel.org/all/cover.1760274044.git.lukas@wunner.de/
[1] https://lore.kernel.org/linux-pci/cover.1763483367.git.lukas@wunner.de/
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 3db0387bf6dcb727a65df9d0253f242554af06db..8ec04a5f434dd4f717d6d556649fcc2a584db847 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -1413,6 +1413,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
 static void mlx5_lag_unregister_hca_devcom_comp(struct mlx5_core_dev *dev)
 {
 	mlx5_devcom_unregister_component(dev->priv.hca_devcom_comp);
+	dev->priv.hca_devcom_comp = NULL;
 }
 
 static int mlx5_lag_register_hca_devcom_comp(struct mlx5_core_dev *dev)

---
base-commit: 4a26e7032d7d57c998598c08a034872d6f0d3945
change-id: 20251202-fix_lag-6a59b39a0b3c

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>



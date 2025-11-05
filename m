Return-Path: <linux-rdma+bounces-14271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD3BC373E0
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 19:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE3D3AA0BA
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 17:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B43161BD;
	Wed,  5 Nov 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cE/J2MVz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7753009DD;
	Wed,  5 Nov 2025 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365375; cv=none; b=VfaQ2wwVwVluabUhdPrfVMUMvU0isiuFq3XN4mYEeGTa22qc8i28C2OBkxAUcVK9cOxGkL+TiyT+a51RVDlNJkPpPiDk1SyRe1ffiSX0rbmrxiIM+tgF1X27bzbYm68a+USPFwMO2I600tl/tGa5fUrIRTvl7QFEMECyHyHAWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365375; c=relaxed/simple;
	bh=K6RtfM/ZBRJc1j2ZCmyLqGYaCeW5pCrLX+E/78w8rTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DxGWiDGnvleLjcWIo75/m44nChiKhEnLwKUYcsTPvYCy5PzXskNCfdZGl/rYkzggLcBpdxI2vmHMbLqtQe0Gsbk+JhKCJxO4y6YhC27kieLq/EzArKnJ99gc/eZ6HVVKFrKiknBMxa27kVO74peHyyc3rjHsgXvSEFieEm1KjD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cE/J2MVz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5929VA029163;
	Wed, 5 Nov 2025 17:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9cDY+k
	ZTdNUIeHNAMjXz5Cd9F2eI3YGfU4lUB9KY1uE=; b=cE/J2MVzZ0DP34z8PIyipn
	QbjXwCFtud7ilpuoIEXCKGhOI0IzZJ5k/K9XbCUi067pRco32cGTqXxIYqj/37bp
	nIS2ZPdkusp4CtNkIFK6tusvIlXtNgH9LXD2Khe+3gGMIG3ESnT1jjcT2csYWU2b
	c27ViRBwVYyMd5Gz3icOrXH6tkVmcYzQcS1OxjmqNYCOmIgRhnv3K1WRqB5qtFqZ
	Mi1izP7WoU/G3i6q+1y2youQMai4OwkOxZnLOHPRklXCm9hogG9GEP/n1GAFFXgo
	9tBOpU3Lu7371CMdsKHJSA15ZObwIPxh/+uoEfVzo6eM27rVHrGOYgBCj6CUn63Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q92y8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:56:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5Hq2Pw006009;
	Wed, 5 Nov 2025 17:56:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q92y87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:56:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5FPKdV018738;
	Wed, 5 Nov 2025 17:56:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnhf3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:56:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5Htu5335848576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 17:55:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE7E320040;
	Wed,  5 Nov 2025 17:55:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DC7620043;
	Wed,  5 Nov 2025 17:55:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 17:55:56 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 05 Nov 2025 18:55:14 +0100
Subject: [PATCH RFC 2/2] ib/mlx5: Request PCIe AtomicOps enabled for all 3
 sizes
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-mlxatomics-v1-2-10c71649e08d@linux.ibm.com>
References: <20251105-mlxatomics-v1-0-10c71649e08d@linux.ibm.com>
In-Reply-To: <20251105-mlxatomics-v1-0-10c71649e08d@linux.ibm.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690b8fb2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=b1J1qY0uxHIh8xAgF6MA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: bPfq8gigml4u1wwZ6MwcwbjcJLlFC5YA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX/lyIkXEOze4o
 PJO0wvWndqve+AVI0Lu+l7sUxeuw4FK+TZ3XPQerO+OuiWHfApwH3BVzKwV3oUNTQ1gJShc9NQP
 MrMazETPsBMZ8cIXiCyz1bYGsUfzi8U4w4nsvS/LGwPAE8TeKMfSASLSWMQxCJxnnF2pv6gzlJK
 vrvtvJ98OxXS3DYVlNSuSzh2XnFODEIwejt6UWn6xPK0fL5boOJaGQvnC7PLOSEpp9wbK5pR54o
 icg6GQbkjtiwjeQdINZbLVX1NEPeJezus+ZYayNjb3BtMe3FEO7F8eMNc5hAU770y0vDQpWrgS/
 ykUvYXg3QQAzGYuTxJAdYjivMKR303u3Op8cxsZxQwnZBnCmPhNTrfrzJE/VE74wiK4Q0F+vJh1
 ip3Dhk3pizF/89FGPC8jME82lKBn4Q==
X-Proofpoint-GUID: NSIOLwpGiWoW11-T5dJr66D3njdtVttl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

Pass fully populated capability bit-mask requesting support for all 3
sizes of AtomicOps at once when attempting to enable AtomicOps for PCI
function.

When called individually, pci_enable_atomic_ops_to_root() may enable the
device to send requests as soon as one size is supported. According to
PCIe Spec 7.0 Section 6.15.3.1 support of 32-bit and 64-bit AtomicOps
completer capabilities are tied together for root-ports. Only the
128-bit/CAS completer capabilities is an optional feature, but still we
might end up end up enabling AtomicOps despite 128-bit/CAS is not
supported at the root-port.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/infiniband/hw/mlx5/data_direct.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/data_direct.c b/drivers/infiniband/hw/mlx5/data_direct.c
index b81ac5709b56f6ac0d9f60572ce7144258fa2794..112185be53f1ccc6a797e129f24432bdc86008ae 100644
--- a/drivers/infiniband/hw/mlx5/data_direct.c
+++ b/drivers/infiniband/hw/mlx5/data_direct.c
@@ -179,9 +179,9 @@ static int mlx5_data_direct_probe(struct pci_dev *pdev, const struct pci_device_
 	if (err)
 		goto err_disable;
 
-	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32) &&
-	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP64) &&
-	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP128))
+	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+						PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+						PCI_EXP_DEVCAP2_ATOMIC_COMP128))
 		dev_dbg(dev->device, "Enabling pci atomics failed\n");
 
 	err = mlx5_data_direct_vpd_get_vuid(dev);

-- 
2.48.1



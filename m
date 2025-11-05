Return-Path: <linux-rdma+bounces-14270-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D71C3738A
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 18:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC4E134E2B0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 17:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B30335086;
	Wed,  5 Nov 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ez7GQ6Pk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ABD242D97;
	Wed,  5 Nov 2025 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365375; cv=none; b=AyXqiUtwhH3oUAMQaJHBr6xOolifo2STBK5YCgnL3DsGjgsF5+ldFl14dPwm3gVbbXbHcS3DVNhakW9m6LqmDrlZvHKZMcAF1Ru/ulU/UhmN7EhjTavnfLToJyo2Bc13WIH55n7gtrl5tr0IZ7ZAYBGhshiWWTNqtfXxuR9DW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365375; c=relaxed/simple;
	bh=NVRZhXRiOL269p9SttqUbi+y/oKidmCIpi8/oyKYIBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaaktKt3QI8IwvN0t0Xx6Yo+q0XJ3oqgJuGLsjOOoPbLBktWsz90nRLINX3Aqv5iw1W7Rgi84rSIUylymWkOT1k2Ufdgk7tlDUEHh1rwL5kpo1pFfPazd6kBl3NHo8NP9cSeA1kc8zggITgbu98DWv7OBpWxrUm0G4c9Ciyive8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ez7GQ6Pk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5H6Fcg020916;
	Wed, 5 Nov 2025 17:56:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cBlscb
	cyr/EdYb6qf2bG25PH16WB8vtwpgl2Um4wrrM=; b=ez7GQ6PkcknV8KXi9AsUq7
	8q7vrqhc11CJztlNebfrZx3Ph/w/5YCOltAV1YY0h1/5ZESTBkKPooyfkvXPi57X
	mu5yzjZFlsyse6qkHCqfbCo3leHV/e7WmZ1sd/q97jof24ex3v5YujFYLUt8jY4H
	jIO4Z1z3bpaihah5VFbr9hEMNKozWRGCodmB3syNmlV1NEbLrNMF1cADR48ajaqa
	3Dh9tjsJRoWvMzZUexjQIeBbGTa5GZo5vzN3uAjPekncIdcmaDkWNbWRmDTH+9eS
	u0fd/6hd4TfUpvk2jK54nnhoXhrBiwqphcv71bv0E/L0t3T376HeJSlWG8r635qQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q92y8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:56:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5HmtUV000776;
	Wed, 5 Nov 2025 17:56:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q92y85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:56:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5GCfa0012875;
	Wed, 5 Nov 2025 17:56:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y8216n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:56:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5HtuXh38207754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 17:55:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AB5020040;
	Wed,  5 Nov 2025 17:55:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C222004B;
	Wed,  5 Nov 2025 17:55:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 17:55:56 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 05 Nov 2025 18:55:13 +0100
Subject: [PATCH RFC 1/2] net/mlx5: Request PCIe AtomicOps enabled for all 3
 sizes
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-mlxatomics-v1-1-10c71649e08d@linux.ibm.com>
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
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=b1J1qY0uxHIh8xAgF6MA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: qZmbtuYyxhVEAR6iwRK0AfGllfIa_99s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX7JZS5mu3eVFR
 Z4gNIsBI195NJqr9VDr5NeQ+wh4gfA8opyHuKv0lKiqu8LyPRzVpLk50IwgbW0NKFhASwMz1DiO
 7sUKclpUvc8h8YRXag2UQLg7m25fQloDJiF5xDcXpBD2gcCSFhQjCkfZDrY1NIIOpjvvlWx889n
 ZRzokq9+LjNIGTfXI/WmJzr2UrTrX+LN3RT2CvpCH3PTVciSNbSoV/Jqhorp0J6PC4rKGN4JGJ3
 a32GdVZJdW4+QP1n5UDYuW3jvY2mKh0LdCAvsvBD5+4hkN8ZfbrPVbaAS9tRbifDKrWI5QDmA/l
 BXKRvY60KP+idnNuyrlBpaWhLoY13pTynDT3rCgS9aiPr64XwFQZ54/iWI3olCjH0p3fQaR6eZ0
 6DbYLSvlYzRX0LwtED3hKyUFQwOYHA==
X-Proofpoint-GUID: AVkpLnhkEHlKLjZ_wEBF0R1DGJtmXu14
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
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 70c156591b0ba9c61dd99818043003e50e177590..69152a9dae2be07e023fa42fd9ef010c8b255c4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -934,9 +934,9 @@ static int mlx5_pci_init(struct mlx5_core_dev *dev, struct pci_dev *pdev,
 		goto err_clr_master;
 	}
 
-	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32) &&
-	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP64) &&
-	    pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP128))
+	if (pci_enable_atomic_ops_to_root(pdev, PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+						PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+						PCI_EXP_DEVCAP2_ATOMIC_COMP128))
 		mlx5_core_dbg(dev, "Enabling pci atomics failed\n");
 
 	dev->iseg_base = dev->bar_addr;

-- 
2.48.1



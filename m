Return-Path: <linux-rdma+bounces-14272-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2556CC373EF
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 19:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2193B5B9A
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC9E33F8AB;
	Wed,  5 Nov 2025 17:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L0Tc/caI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127533E349;
	Wed,  5 Nov 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365378; cv=none; b=UZ58drBrdeqk54b5C6Jc161v7FrGRCmzl4iSnGfbAMapLuwqSVJeLLaNkM+qwl+OVmQC6Xc3ldZb/0ZKaxjZvjzGY+F/MqrvyWS2qflf5z07djmkY8ImH4bKyzQRJckHxuRosIRTCqeDbAzPZqXFckzN0Xy6fFP2NLLNvpfbCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365378; c=relaxed/simple;
	bh=pXhFBrRqbkZGWVJSQbl82X0IMtNkqqdvvuHaYAuVWzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o768sjQN529B+gr6WFFgI2922CMNohQ+iqlgM8Gh6MJt/q8608Hn4LDO1H0ePsgQnKMCAbExyLHEQqrEy0/UqfQmw0ia8T4yiR4LLtLN+yrbnuNQCwkA4r8bx7iqWB7d0bNbmN2MKqYtn4Jl2c66UuLWGoLRW+VKkcVuCX8KgIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L0Tc/caI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5G6xPT019164;
	Wed, 5 Nov 2025 17:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=6vSe7hmXkk4DxxtQOctnFl27rZ2U
	jZN3dQir/9Prrv4=; b=L0Tc/caIuC5Ya2IqZJReOjSYPkhtZFYBgYlL/olZD1Yk
	2H0vTVLp1DAaM2PPrEGekjobC9h2Sp403HZyYJRnQqnskzp7ZEmX4/OvLlpW1kdW
	tPq+UFmmEMBDtkYqNwwICU8n0Bcz5zO3yzzfUaaLLveEyICaWIPMO5rzRyMfNRtn
	2QyNV9V2CDWQqV6caKN8BMTcLaEp3z0jdFeeBZK8057yrxx7dHu1rLtp9Mp39DtQ
	Jx4RhrlB71KAm1qqAoGkyAla6NDvwXttgqUAviWvWGLOvOfGMDk+xXsZh5BribwL
	39SK2kKyQ6OI2bfcESpwxyArBokBOLlK7+mz4CIBag==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v22dda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:56:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5Hsru8007406;
	Wed, 5 Nov 2025 17:56:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v22dd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:56:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5GWvKE012872;
	Wed, 5 Nov 2025 17:56:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y8216n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 17:55:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5HtuBW38207750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 17:55:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4648720043;
	Wed,  5 Nov 2025 17:55:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 131B720040;
	Wed,  5 Nov 2025 17:55:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 17:55:56 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH RFC 0/2] mlx5/pci: Fix enablement of PCIe AtomicOp Requests
Date: Wed, 05 Nov 2025 18:55:12 +0100
Message-Id: <20251105-mlxatomics-v1-0-10c71649e08d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICPC2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMT3dycisSS/NzM5GJdU3Mjy1SLxDQzgyRLJaCGgqLUtMwKsGHRSkF
 uzkqxtbUAv0zjuGEAAAA=
X-Change-ID: 20251024-mlxatomics-5729e8af60b9
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
X-Proofpoint-GUID: NYVXY3HGMWwgEGswIr28G_DNa6H2wtYd
X-Proofpoint-ORIG-GUID: jvohXOaYyF8P3KT2DJXIt7oafp4JqYqd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX1xx+pmLj+xv+
 6yFwQQhA7xOzwJqauLtgXbTRXUELJtN4acDyh/WqL1CnzhrDOe98l5SAl4Vy5DMf7n2dw3MaHI1
 eBr8C9aDqg0cLfBwzCcGHUYqfCrKRjjj9/zOoF/NbEteiF185ZqkHKWCCZM6vbjRz0zVBVAOyyu
 ubR7I8VRFLkk7mONVLONGLohlMdZmRsFFOmsz+Ki3vMmr7L9fudZ4zO0M1KM17xkMeDMiYszE7g
 j/c5jbOXEPNGlHEBGprLH4I3hTWv9pQ1DTa5nLFg9zeYRAQ8E9AM0QBxwW5v3aFXqpgJcW/Yd3E
 t27byNwSJz2V6Pxe4KYrQtTnQpW2Q9jBs53ZH9JjipTppAryEv5R/7bi9CeqvcUGdKxjFw4Isip
 Zo+WfmwcSqcMUzb0IZKDeNI99f9UCQ==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=690b8fb1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=DldPwnUYV5aijb35eRkA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

As I promised in
https://lore.kernel.org/linux-pci/9c7c4217171fb56c505dc90b8c73b2ce079207a9.camel@linux.ibm.com/#t
here's an RFC patch proposing to correct the usage of
pci_enable_atomic_ops_to_root() in the Ethernet and InfiniBand drivers
for Mellanox/NVidia devices.

With this fix, AtomicOp Requests would only be enabled if a root-port
correctly announced its capability to support all AtomicOps including
the optional 128bit CAS - as the drivers intend to.

That said, on the only x86 system that I can test this on, it appears
that UEFI is already enabling AtomicOp Requests for the ConnectX-6 Dx
card in that system.

Overall, both the enablement of PCIe AtomicOps by core PCI code, and
their usage by (very few) device drivers, appear to be in need of some
attention?

Thanks,
Gerd

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Gerd Bayer (2):
      net/mlx5: Request PCIe AtomicOps enabled for all 3 sizes
      ib/mlx5: Request PCIe AtomicOps enabled for all 3 sizes

 drivers/infiniband/hw/mlx5/data_direct.c       | 6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
change-id: 20251024-mlxatomics-5729e8af60b9

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>



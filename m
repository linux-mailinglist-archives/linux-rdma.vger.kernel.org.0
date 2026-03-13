Return-Path: <linux-rdma+bounces-18147-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNI8AFBAtGmJjwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18147-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 17:50:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA1F2876A8
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16966301222E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 16:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5803C9EF7;
	Fri, 13 Mar 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TJc5z2gO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71514315D28;
	Fri, 13 Mar 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420604; cv=none; b=u+CQREdBeZb7nAyrySYa506o1IWDKnS6k/YoE9rPnzIlJ9rbud3GjxJMStAoeeYCSEIl5/jDABETw2vRDQJYUXEREO0aOVsldHnXDmjW+3ULYDJzb4SS0Zl+v7ay08WzzXKdnc7D6/MJ3af0hvbG8AO4XNc2BzU8RgMs/Wcbs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420604; c=relaxed/simple;
	bh=oPzbOpjl4ErVRw3d409qRPI4Qd78TuFOJOQe3n592Vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7Es4j5+YfsGX6oLRquLbLgvMzq6Ri7XcoZXzx+/9rv5If04y4liiYhT/h5hIVqlZpOSxJX60t8w4Lw9KG/TZIBSuzYVrNaKEI+ubOaY1LskKm5rBViTy7nMHhgEkIRltJ51bbTS8/kFrI1sKUhEEd3Pyk2o7ysxULU7T/3Ivsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TJc5z2gO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6JHiW2924617;
	Fri, 13 Mar 2026 16:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rbvAwT
	opgtyZ90BXjRpm+X5L4XvMpEa30+b0MOWg11Y=; b=TJc5z2gOgCL1fgQKAPPRR/
	JsAco9+iwcb2RD8CEXGmfpCPJoY2koELODgYjaWuP8CumfauILtTiJdzdeTWaHZE
	un+8kKrUzgONj7i71OMXtw71gCMDDZSee8dmH5bmJ40Ultag5d9+ivjLZtDREE4m
	JXjmQ+bSzZx8wljxJvBlP85aEQc67iif3WSrJPR/7p8FQZd3Fy+Mj8hrnVA5EoJA
	3zrAvWPLaYacAptvm6f1O344SsMLOqlDJCuLh2ebXHhflbb2fls0Ck1z6hiVOumJ
	voyr9EMYBgHJaFy+YiTRsegUsHxgxO2snmX3Lzdh+GBy8+cQsmXuGuGQPBYpKExQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh950vdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 16:49:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DF6F5Z014748;
	Fri, 13 Mar 2026 16:49:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha8ffns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 16:49:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DGnmEn49217984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 16:49:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FB2720040;
	Fri, 13 Mar 2026 16:49:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F403B2004F;
	Fri, 13 Mar 2026 16:49:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 16:49:47 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 13 Mar 2026 17:49:34 +0100
Subject: [PATCH v4 1/2] PCI: AtomicOps: Do not enable if root-port
 capabilities are unknown
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-fix_pciatops-v4-1-93bc70a63935@linux.ibm.com>
References: <20260313-fix_pciatops-v4-0-93bc70a63935@linux.ibm.com>
In-Reply-To: <20260313-fix_pciatops-v4-0-93bc70a63935@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=QKtlhwLL c=1 sm=1 tr=0 ts=69b44031 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=y92EubQfrlY9IES1mRIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMiBTYWx0ZWRfX4ncpxEQH1Um2
 SeKbwV/YN36qzbenLvd+gqxicZGwNgUxdEoIjnFI3hLyx1tDUA/yBVWUTeSzqYfy075SZZAdigf
 D7E86Uwyb1Y0/h/oHWD7bbTDD70jb5Pm2yzEO+bo9hHL/UaE8BUqJZzNy/X4/ZgqFAJTBOHZL5x
 KsrHur+RwJZy49oIEUjUrWKWf8gWLWynMiRUYW9ZYCwECGiUDgIY7SC6txkjg91X1vhVrZ1iQ8P
 eulzOCdOqE3t4YRH/BDWfEGwcjTXVg8ZtX40g0XbioRZ05vS2b3CXS8+7Lxpo8KALSkqpYuHj4t
 uEws1O5Glm4OS5xzvITnfgBbEU3jPUefcL5OuRp4lCKz5YRuVBtfM7JAxVR0dn5GSXlT0zVBVnP
 odiiOvwTNLHUWnjXfCeSCLaK0/SlpnfC1KyB5vuDoY7SeYBtbWTMLalf5dPwvaUChQZjCdWMZR6
 sok0cXpVO4nyaSnlPZA==
X-Proofpoint-ORIG-GUID: w9G9ymIRkTgXHzujdcdXrv3z3bzCTVaI
X-Proofpoint-GUID: ZVhVvyM9W43RBLhyrSNrpmqRkpnEdcuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603130132
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-18147-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4AA1F2876A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When inspecting the config space of a Connect-X physical function in an
s390 system after it was initialized by the mlx5_core device driver, we
found the function to be enabled to request AtomicOps despite the
system's root-complex lacking support for completing them:

1ed0:00:00.1 Ethernet controller: Mellanox Technologies MT2894 Family [ConnectX-6 Lx]
	Subsystem: Mellanox Technologies Device 0002
  [...]
	DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
		 AtomicOpsCtl: ReqEn+
		 IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
		 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-

Turns out the device driver calls pci_enable_atomic_ops_to_root() which
defaulted to enable AtomicOps requests even if it had no information
about the root-port that the PCIe device is attached to.

Change to logic of pci_enable_atomic_ops_to_root() to fully traverse the
PCIe tree upwards, check that the bridge devices support delivering
AtomicOps transactions, and finally check that there is a root-port at
the end that does support completing AtomicOps.

Do not enable AtomicOps requests if nothing can be learned about how the
device is attached - e.g. if it is on an "isolated" bus, as in s390.

Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/pci/pci.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f1044416281aba11bf071ea89488a..94e90988df86b3278b1b6abbc326abf9b4a4a962 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3676,7 +3676,7 @@ void pci_acs_init(struct pci_dev *dev)
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
 	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
+	struct pci_dev *bridge = NULL;
 	u32 cap, ctl2;
 
 	/*
@@ -3714,29 +3714,27 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 		switch (pci_pcie_type(bridge)) {
 		/* Ensure switch ports support AtomicOp routing */
 		case PCI_EXP_TYPE_UPSTREAM:
-		case PCI_EXP_TYPE_DOWNSTREAM:
-			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
-				return -EINVAL;
-			break;
-
-		/* Ensure root port supports all the sizes we care about */
-		case PCI_EXP_TYPE_ROOT_PORT:
-			if ((cap & cap_mask) != cap_mask)
-				return -EINVAL;
-			break;
-		}
-
-		/* Ensure upstream ports don't block AtomicOps on egress */
-		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {
+			/* Upstream ports must not block AtomicOps on egress */
 			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
 						   &ctl2);
 			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
 				return -EINVAL;
+			fallthrough;
+		/* All switch ports need to route AtomicOps */
+		case PCI_EXP_TYPE_DOWNSTREAM:
+			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
+				return -EINVAL;
+			break;
 		}
-
 		bus = bus->parent;
 	}
 
+	/* Finally, last bridge must be root port and support requested sizes */
+	if ((!bridge) ||
+	    (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT) ||
+	    ((cap & cap_mask) != cap_mask))
+		return -EINVAL;
+
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
 				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
 	return 0;

-- 
2.51.0



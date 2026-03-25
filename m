Return-Path: <linux-rdma+bounces-18637-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMXVNFAAxGmlvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18637-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:33:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7B3328142
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 611A530E5E8F
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EC3D524D;
	Wed, 25 Mar 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fzVWslcD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06A22D7B9;
	Wed, 25 Mar 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451796; cv=none; b=K30wwIlFJQmw6CMlRxFMAGYKpo4NtKLw6g9qdbeJNAKWU2YWdlUUBcR6CiGno/9RaJAouy919h9u6YG7+vgBLWrr07S02ZWm0aBAGT3Ck0oztiRZfUaog+2std1Hjs8QktDGk4pGNtFulVyK9IyO4YK4IMKTd1W/9A3p8JzR+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451796; c=relaxed/simple;
	bh=wVku9XYjlcw9pXIwqbMui1w0Fu41eorazCFz7dd4Fxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVMzCbgagOpSpc2z673bMt8O7lewHVgNmqlIbSk7qLZcVkD4Wxy7zDoepzeWiGDYqmusvvFZVeJzl7ag4VKK3vsM1h2IDrG0QGPGLdQfpO3yGXjxUekbht9+ykc1MNVRvCRHKF2njzr3oG4OztluXJvYE9BwNJWtcdo1qffYmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fzVWslcD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P9KXX13640057;
	Wed, 25 Mar 2026 15:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IZM9iV
	EJR8udFqcpjfNu4uqJ/KNL/9NB0MPaqhItBHo=; b=fzVWslcDl7abmHZw2dGyTb
	LK5cLGASnS0K1QOmsRqo3roSOtoDUuZryD3btddAreHhPGePrbw6sZYQ4Tt9a18M
	E2a2bpxwpAduPSUZnYp/xnzVDv+L9+q8WxTbhfpa0w8sG0Urx8LU00TG920edx/f
	+DS5kmh2CitTk/bShK5oOkhIHIiKE4cg2j5/2Ewzwm/mOo5r/Truw14eIHNn1ZUo
	s7B1xckGT7bMy2+MYGrKqUTH66ckr+cQee4qo8BvfNeTv/aTmJnQaQ7UaA/i3jzb
	macqsmoUVGF5VHbsCCdzXoz7UHleykGepeocYqVLLwJrGYKD8EQWHB1+0lBcgISQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky086qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 15:16:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PAxYqV031635;
	Wed, 25 Mar 2026 15:16:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsy5sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 15:16:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PFGOHF50856288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 15:16:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA93D20040;
	Wed, 25 Mar 2026 15:16:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E542004D;
	Wed, 25 Mar 2026 15:16:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 15:16:24 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 25 Mar 2026 16:16:17 +0100
Subject: [PATCH v6 1/2] PCI: AtomicOps: Do not enable without support in
 root complex
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-fix_pciatops-v6-1-10bf19d76dd1@linux.ibm.com>
References: <20260325-fix_pciatops-v6-0-10bf19d76dd1@linux.ibm.com>
In-Reply-To: <20260325-fix_pciatops-v6-0-10bf19d76dd1@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Leon Romanovsky <leon@kernel.org>,
        Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEwNiBTYWx0ZWRfX98LmQ4B2W+DB
 Gv/WPBiDPwdfzl5bzCk5adAkUwh5VV5BbdhQK5B49PQUc8nBfhRp+9PD7fJSq+FB6A/fFJNkrOe
 uVZGeg3NQuxThg+5hZA1mhIyiQkbFkk5UeaWt5ED15h1VoHLOtF5Z3dkOnzr2Zt/m2K5lYT6lTj
 3FCCMi/v848dty+N1CO7XwQjSi28Yj1HlOeH33zJr0uYsXY5TbgJGgfPSCqtoBu7Xz/NgItOPy7
 YPF22kN0rFKOJ1MrN6URjahJI81N/1XICJYlxVzO6SL3Cf1BYyi66VxY2evlz9Ae06kljBtofzs
 xjFi7hp+OhGsj+H8botRH1CVB2joV27ohhdVJiZGMi5cbaUOwmPF8J5CfIXWqs/EO0n/4YIyBHi
 wUSWw6QEVSfHB9XEw6QlwbvGF2sNHzVHE8BMXo22KEcs5iRa+9PgrSXB/pqRh3DEV/Q1RJh5eZO
 jWoICEj1n1m85QagFZw==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c3fc4d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Hx5SdpTRtzwH465PzOMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rnuTNvRXxuHVYp6kF1wGfPuuu60UW4sL
X-Proofpoint-GUID: xhuNwk8t0ZsChDnOiSezc9PsQ1zgGuCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250106
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-18637-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: BC7B3328142
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
about the root-port that the PCIe device is attached to. Similarly,
AtomicOps requests are enabled for root complex integrated endpoints
(RCiEPs) unconditionally.

Change the logic of pci_enable_atomic_ops_to_root() to fully traverse the
PCIe tree upwards, check that the bridge devices support delivering
AtomicOps transactions, and finally check that there is a root port at
the end that does support completing AtomicOps - or that the support for
completing AtomicOps at the root complex is announced through some other
arch specific way.

Introduce a new pcibios_connects_to_atomicops_capable_rc() function to
implement the check - and default to always "true". This leaves the
semantics for today's RCiEPs intact. Pass in the device in question and
the requested capabilities for future expansions.
For s390, override pcibios_connects_to_atomicops_capable_rc() to
always return "false".

Do not change the enablement of AtomicOps requests if there is no
positive confirmation that the root complex can complete PCIe AtomicOps.

Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 arch/s390/pci/pci.c |  5 +++++
 drivers/pci/pci.c   | 48 +++++++++++++++++++++++++++++++-----------------
 include/linux/pci.h |  1 +
 3 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2a430722cbe415dd56c92fed2e513e524f46481a..a0bef77082a153a258fbe4abb1070b22e020888e 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -265,6 +265,11 @@ static int zpci_cfg_store(struct zpci_dev *zdev, int offset, u32 val, u8 len)
 	return rc;
 }
 
+bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32 cap_mask)
+{
+	return false;
+}
+
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f1044416281aba11bf071ea89488a..006aa589926cb290de43f152100ddaf9961407d1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3660,6 +3660,19 @@ void pci_acs_init(struct pci_dev *dev)
 	pci_disable_broken_acs_cap(dev);
 }
 
+static bool pci_is_atomicops_capable_rp(struct pci_dev *dev, u32 cap, u32 cap_mask)
+{
+	if (!dev || !(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT))
+		return false;
+
+	return (cap & cap_mask) == cap_mask;
+}
+
+bool __weak pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32 cap_mask)
+{
+	return true;
+}
+
 /**
  * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
  * @dev: the PCI device
@@ -3676,8 +3689,9 @@ void pci_acs_init(struct pci_dev *dev)
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
 	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
-	u32 cap, ctl2;
+	struct pci_dev *bridge = NULL;
+	u32 cap = 0;
+	u32 ctl2;
 
 	/*
 	 * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
@@ -3714,29 +3728,29 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
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
 
+	/*
+	 * Finally, last bridge must be root port and support requested sizes
+	 * or firmware asserts support
+	 */
+	if (!(pci_is_atomicops_capable_rp(bridge, cap, cap_mask) ||
+	      pcibios_connects_to_atomicops_capable_rc(dev, cap_mask)))
+		return -EINVAL;
+
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
 				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
 	return 0;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..ef90604c39859ea8e61e5392d0bdaa1b0e43874b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -692,6 +692,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void *release_data);
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
+bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *dev, u32 cap_mask);
 
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
 

-- 
2.51.0



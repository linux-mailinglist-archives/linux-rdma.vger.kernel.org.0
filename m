Return-Path: <linux-rdma+bounces-18791-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Fg2Bl53ymnk9AUAu9opvQ
	(envelope-from <linux-rdma+bounces-18791-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 15:15:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FC535BC3D
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 15:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C56F3077DE0
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 13:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF513D5221;
	Mon, 30 Mar 2026 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aIoIb2ae"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891883D3CE5;
	Mon, 30 Mar 2026 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876215; cv=none; b=XYx3dCy/UKIQBr8Lk3OZgy9DPtqRp4EzOhqMbwYDPSY43+jN/68DOva22aCdCY+ObSI6g8smyqIAZaldNn/OTtHa3UFoewZbUr41jNnYrapcJkx0TfPaG7phyBnd1Ngoyt+QvzTKF+y72D0DfgpDxKqGhTTpU1vJuIo2A8jT4Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876215; c=relaxed/simple;
	bh=pEzu946U0T2iItoXe0YjWLg8MJNt4vqOxymBFtXMGZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hL8H9ewn2F3m471xZrfYH+rY4qeVice7sgrlJeIzlbFomWkrIV7b+OhzwuabKisILWcE6eHJgzjnfiOe7qLrlint8f5W1cITPlD3R0+eznNOG+Qm3uOcL4UMlao4BtIzpBUufyFo/DgagWfbhbvqLvvR/PFEm+8M9tFoTuyg/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aIoIb2ae; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TJKd4X4032815;
	Mon, 30 Mar 2026 13:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2qsAr6
	zDUNL29w2hCtlM13yliWWfgwr21psCtOIf3VQ=; b=aIoIb2aebt9HopI3FdM6O0
	FvpmXtoQklRYT6NxvLWNpXbNSvVMKbfhB3duSWxWS/nRHM04em5fGuB6oHq/01Ad
	XejgG0nlGCJJf3+ODmFC8RZC14nJSl1mPbhihVOdL1rJW3+ghVRdNlyS+0ty+bI3
	F7TYivq5EHNsaxf2Dfkllhij1xf/BWk1lDxdO2s//v/lnTRGRNoCq5WTaUTRR/MZ
	yOZS4DMGXIO0w+hipaOepaXgLfol3BEvsrQ3iMWGPnVTwG606geS8If1fVsnAUfC
	GWa3J5lxWUfzJkHFoZ8Qay1xIzb05Ceh7Ch+2GKAj2JCnFmEvWRYofqxC0h3h5bQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66mrxhsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 13:10:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62U9VCDR021722;
	Mon, 30 Mar 2026 13:10:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasd44t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 13:10:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UDA35O25952556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 13:10:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6DB72004B;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA60B2004E;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 30 Mar 2026 15:09:45 +0200
Subject: [PATCH v7 2/3] PCI: AtomicOps: Do not enable without support in
 root port
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-fix_pciatops-v7-2-f601818417e8@linux.ibm.com>
References: <20260330-fix_pciatops-v7-0-f601818417e8@linux.ibm.com>
In-Reply-To: <20260330-fix_pciatops-v7-0-f601818417e8@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ca762f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=_mftJHerZaGdetTijZQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwMCBTYWx0ZWRfX1mbUbnKn2x+v
 MHZwBxBfsyIcPD8VR2ULzTm2hS0Cz17WGF920ac5GzufgVv+NAHaLuUXXDPdHj5thVgyXdKbFRw
 Q0wlwVSScsHoTFabp6ndj2ViKtDmwX7T1QHOlSEjYY6XyfU123kdaAfTab+uRIjAAXwdMH0ea52
 ygIpEGQUaNkSM+Zubz/G9Uo+i7l+3ap7cJJg3Dv1E6ROdrpgQPjrRlHLvajVjCX8BNoXYMzrRDn
 pXjnZl1rkLf+eOQucEFfwBGHeBqwgYX2JeLt/W69bh5Zz//FHHQIm1B9a5g73EfJoLv0RaMbcZE
 BEES2gzETQV+Kl7KZihCux6juWrzWUqtubLkhJHEdCDmCu38elFHE7+4G9z6eB45h9PF2LNzB1q
 9taUlqMJhV3erENURstKX0lCNj9aEyMihjAJl7A/1+xqVK5ubsWuAWpJmVdRgmWj6RTb52ET2op
 lADjQUE3LeM68FD8fjg==
X-Proofpoint-GUID: B_4ybmFZb-ydMJRx7ujbF-JVpktvhKZS
X-Proofpoint-ORIG-GUID: CXzppuWT8MI_Pcw6JBvY2DWShiLK31Zh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300100
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18791-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+]
X-Rspamd-Queue-Id: C0FC535BC3D
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
about the root port that the PCIe device is attached to.

Change the logic of pci_enable_atomic_ops_to_root() to fully traverse the
PCIe tree upwards, check that the bridge devices support delivering
AtomicOps transactions, and finally check that there is a root port at
the end that does support completing AtomicOps.

Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/pci/pci.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 135e5b591df405e87e7f520a618d7e2ccba55ce1..57af00ecdc97086a32c063ff86f8a39087ad1f5e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3660,6 +3660,14 @@ void pci_acs_init(struct pci_dev *dev)
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
 /**
  * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
  * @dev: the PCI device
@@ -3676,8 +3684,9 @@ void pci_acs_init(struct pci_dev *dev)
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
@@ -3713,29 +3722,25 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
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
+	if (!(pci_is_atomicops_capable_rp(bridge, cap, cap_mask)))
+		return -EINVAL;
+
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
 				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
 	return 0;

-- 
2.51.0



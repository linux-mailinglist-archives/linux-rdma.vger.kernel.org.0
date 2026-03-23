Return-Path: <linux-rdma+bounces-18526-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDmAGuh+wWl2TgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18526-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 18:56:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C12FAAE3
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 18:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C95CF322DBA8
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 17:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D1A3D5651;
	Mon, 23 Mar 2026 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XZ+LE/xq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B23C9459;
	Mon, 23 Mar 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287735; cv=none; b=I+jH7e3fjtc2ipTv+q80GS9/RHnGUmtGF4/ZD2aE2vif81FggrOUXTacq7mrHJ/KVkRqJYo/UYfxqn18fBkBJ/fRKvBTnGMb7802Wxm/CETkOB+XD3Xe0m4E7UvmZ5VwfTKUIo+fL0MEyhYY3KXX+FoPl+0vSZ+/uD2CYiqDCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287735; c=relaxed/simple;
	bh=UzzwLVN5fQWfPj6BIVjZr5XKGWPpBGZV+Stj5naA0CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9CjgecGS/xxy2LpinZEcO/Ks8rkwVbg2gQ7PyIiOqxmhpkUL4hZ8py3Ew69IHdxptqa6gSCdny6GTPm7tv/6REZdRRR4jesPjrt/zYjuks3Nw5gHXZqS6qtBuW/NSWrmNGaYl/wOyG0NWPO3nkeK+5/bmJIIo+/viX3rql4h30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XZ+LE/xq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NCmnpE4107185;
	Mon, 23 Mar 2026 17:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I6oU1k
	iE/GOW86cTR2R+90Z3xRFmH3Qi1yucw1jAJK4=; b=XZ+LE/xqT+NhZdJvV30Ew8
	RYoLQK4kj4YmBQFhy+8qMobQc7TD/WyyCFUKqjq1qiqrBGSiVOPAFkAVQJgv7f/M
	TXWFKB6axKiwnfDwo9vO4jkWePNvCqKyT3Pu7prAyDI+8WOYKQ840EmRZ+rFZMze
	UA4KL4GBfhHGbFnBH8gSgOPXdTGRXxhlBy1oLBJdTo8tG8OP5yX6xVHupeigTvIH
	RGqwZhCbgbOWClblyN7BKzE814BJtZexaCRDTvbs5UuHAjoXYLmCr6NxLfF0FCgw
	55F7pCHZS9gfUQUpIIhOz3Ta1A1yG5j/9397y+ZTEdMtnpy/e0ReJpRSwWYFh2Vg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxyypgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 17:42:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NH6ogU026685;
	Mon, 23 Mar 2026 17:42:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kpa2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 17:42:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NHg15a45285688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 17:42:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5134720043;
	Mon, 23 Mar 2026 17:42:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1477A2004F;
	Mon, 23 Mar 2026 17:42:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 17:42:01 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 23 Mar 2026 18:41:50 +0100
Subject: [PATCH v5 1/2] PCI: AtomicOps: Do not enable without support in
 root complex
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fix_pciatops-v5-1-fada7233aea8@linux.ibm.com>
References: <20260323-fix_pciatops-v5-0-fada7233aea8@linux.ibm.com>
In-Reply-To: <20260323-fix_pciatops-v5-0-fada7233aea8@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNyBTYWx0ZWRfX8aQVnSJZR6xp
 5ZupDXjinE2p8qmuVrrU/kEtJSOhBDSlfw+bEVOTTJ/FFlpdSDeonTCAArexse3geiOyPeklbxa
 1iAHXxoGf6RNwy1fcpeCTqVw9UA6PuEJ5+/XJRyLURhcgDDekBe6ZDY2THFlmC7iuwETeXqK7nU
 0myEEGxCfs2CSN/cvOtDteLAY0cSmeutGzfIYh+2dtgLFrlqIfd+yIFR8hG4bbOMXCssWnVmEPD
 QExWOJ/eIIxxPbaFXtI3zGwgZEVa4TKBkMR1nqnvcd0270t/UQarpTDpWFZzTPp1ULyqZ4Yjlt/
 WmP/GGGHh6HGjrR07tCcOmA+cubkNXOWhJTjswrrFmLosKdXzS4EBAxILQI+35GPkFBHxFXm+zq
 V+4PEnAtfPyHsCQTne+BGlAkEwTcTJPa7y1tSwmGgayRWmrDZ7jeyU9CNq26j6wuH7D7VoTbMrI
 39tN+wAwz4cJmABUpvA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c17b6e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Hx5SdpTRtzwH465PzOMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ed4KDtjBNk18OlPzCI46e3YvU6vXg7Tp
X-Proofpoint-GUID: Dz8NA6si3VQAcceB92T1gKZAhs8-1yW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230127
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-18526-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2A4C12FAAE3
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
AtomicOps requests are enabled for root-complex integrated endpoints
(RCiEPs) unconditionally.

Change the logic of pci_enable_atomic_ops_to_root() to fully traverse the
PCIe tree upwards, check that the bridge devices support delivering
AtomicOps transactions, and finally check that there is a root-port at
the end that does support completing AtomicOps - or that the support for
completing AtomicOps at the root complex is announced through some other
arch-specific way.

This announcement is implemented through the new
pcibios_connects_to_atomicops_capable_rc() function - with a default
implementation to always return "true" to leave the semantics for RCiEPs
intact. For s390, override pcibios_connects_to_atomicops_capable_rc() to
always return "false".

Do not change the enablement of AtomicOps requests if there is no
positive confirmation that the root complex can complete PCIe AtomicOps.

Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 arch/s390/pci/pci.c |  5 +++++
 drivers/pci/pci.c   | 46 +++++++++++++++++++++++++++++-----------------
 include/linux/pci.h |  1 +
 3 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2a430722cbe415dd56c92fed2e513e524f46481a..a13235d3218e8ca451e25fe8d9094500fa21aa26 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -265,6 +265,11 @@ static int zpci_cfg_store(struct zpci_dev *zdev, int offset, u32 val, u8 len)
 	return rc;
 }
 
+bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *pdev, u32 cap_mask)
+{
+	return false;
+}
+
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f1044416281aba11bf071ea89488a..c1143f8e6b2a0f029feb3c4390ac6f33837f6de1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3660,6 +3660,21 @@ void pci_acs_init(struct pci_dev *dev)
 	pci_disable_broken_acs_cap(dev);
 }
 
+
+static bool pci_is_atomicops_capable_rp(struct pci_dev *dev, u32 cap, u32 cap_mask)
+{
+	if ((!dev) ||
+	     !(pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT))
+		return false;
+
+	return ((cap & cap_mask) == cap_mask);
+}
+
+bool __weak pcibios_connects_to_atomicops_capable_rc(struct pci_dev *pdev, u32 cap_mask)
+{
+	return true;
+}
+
 /**
  * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
  * @dev: the PCI device
@@ -3676,7 +3691,7 @@ void pci_acs_init(struct pci_dev *dev)
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
 	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
+	struct pci_dev *bridge = NULL;
 	u32 cap, ctl2;
 
 	/*
@@ -3714,29 +3729,26 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
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
+	if (!(pci_is_atomicops_capable_rp(bridge, cap, cap_mask) ||
+	     pcibios_connects_to_atomicops_capable_rc(dev, cap_mask)))
+		return -EINVAL;
+
 	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
 				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
 	return 0;
@@ -3813,7 +3825,7 @@ static int __pci_request_region(struct pci_dev *pdev, int bar,
 
 err_out:
 	pci_warn(pdev, "BAR %d: can't reserve %pR\n", bar,
-		 &pdev->resource[bar]);
+			&pdev->resource[bar]);
 	return -EBUSY;
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d512301de4d462fe7e5097c32af5c6f8d..498f266c9838c55e9b03d03fef49a82358047f4f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -692,6 +692,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 				 void *release_data);
 
 int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge);
+bool pcibios_connects_to_atomicops_capable_rc(struct pci_dev *pdev, u32 cap_mask);
 
 #define PCI_REGION_FLAG_MASK	0x0fU	/* These bits of resource flags tell us the PCI region flags */
 

-- 
2.51.0



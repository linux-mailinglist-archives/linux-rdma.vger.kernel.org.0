Return-Path: <linux-rdma+bounces-17616-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WE5fDn0Oq2nwZgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17616-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 18:27:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 395F72261F8
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 18:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8ED73056D58
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 17:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F3B4301C5;
	Fri,  6 Mar 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XVibHAV6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F630CDBC;
	Fri,  6 Mar 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817257; cv=none; b=SNeyvvz4TgtjPALvfBrBfMN2KBZu4DXenZal6uNoND0rFjWz3OILF9pqo7TVW4u4LTnIr1bvR+D2071UJI4CX1InC+Px0Q+iXbUcCNCdQWREx85P0ubwiCi0KYA2bNWP5yMiAc01Hl0kB+5uJM+xGH4uWiXMFo6AVwYca8+HpGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817257; c=relaxed/simple;
	bh=LjSRyZhNm78EnpUVpklUgncTMdoJK/vj6Mpy4u1yUik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4UY+gUua5Mj4Ria/Z/OX0iMyChReFAe69nk3mLbj/Tt9zitTayTyQy1nw7J49eKdDUDCkOffDcfi4eDPzuxTyC0O2FgiZ9gFHYnnkLbdM7CvnABx1PMy+vyF707ma7tGqD5cSsI7wIRfM5rHYgLDRuMZcmpatbzElrjhJ/HXxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XVibHAV6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6267t4bo2198741;
	Fri, 6 Mar 2026 17:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=C6EyTk
	VwPmKS+xTPkBWPf3/Z0hLqIMl/7s/QH96q8QQ=; b=XVibHAV6TUj6EQT+jhzTFR
	CBcuMII+4ICBPul32kUmXDpLb7rx63iHuJd+SWSdxClOBcLxyc/89bUG6rDbD1+r
	1sN5NN9t4AQh6DhhN2aguw+qMzAhn3bLIW2R00arbXsBtdl29WUAWMPEpJhNLdie
	PwjsqrBYKSYmuuP+w1DoOayq9nSaC7G7rzhYN8IHevP3af1tE4zs/J+ATPwAUWpt
	29XEApWyRSgcYchU63OXhDlvQ8EaMl5TRPS68atv5jdlpXu3JbMKB2wE0/v0wetG
	h5Awekn52D7jvpDbiHiYTiY7h6HlMCE3KIGK+6dC9rJqE30cKlzq8S8VvLrfNN6w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdsm6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 17:14:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626GTVFf003266;
	Fri, 6 Mar 2026 17:14:09 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2ygvma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 17:14:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626HE5AN46268758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 17:14:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F2122004D;
	Fri,  6 Mar 2026 17:14:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D936E2004F;
	Fri,  6 Mar 2026 17:14:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Mar 2026 17:14:04 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 06 Mar 2026 18:13:58 +0100
Subject: [PATCH v3 1/2] PCI: AtomicOps: Define valid root port capabilities
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-fix_pciatops-v3-1-99d12bcafb19@linux.ibm.com>
References: <20260306-fix_pciatops-v3-0-99d12bcafb19@linux.ibm.com>
In-Reply-To: <20260306-fix_pciatops-v3-0-99d12bcafb19@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69ab0b62 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8GgRulezAQhDBDp5LV8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LoB0NE7ebOYJgEMSDJ21VLelw4onBN7B
X-Proofpoint-GUID: LRfCEYBGKcouF1OWMR60rAad_9AdpzFS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE2MiBTYWx0ZWRfX03LphA00eAi7
 dFG3Xd8/YlUFD+MfJu7VwotAFhujoN3tD+Bxo6rzwVshWfHmPGu1Lq92CINjm2odp1/ajuieyrP
 1l1j+9f6NBqINJSlL1XuUej42oVuii93pGhfEKtGP7CXDnB4wCisP/uWOoGRUM6sZTNKmmpX9Eu
 /wDrO919wavwomJWSOKiWFm8oHz4mSeLcd8t4PDzeddAsMLIdy5jbObt4s+57FmneWqZIwV7D8Z
 3m6X69ycdtNxZBUqI7P2ZS9m2/slUnUNsGv4G5u+pW65MNN1+lm6j726v80ZRZOmXzKaM//r6VD
 22TEr3zB/b6S2DkjETGDzvU89/wIF/FAqvBTqC+YbdeE60WyYRCw+jEmX9d+shSia3WW+14UB8k
 HHZxl5JXtfVGs0t6uTqm8KUwccqDRPRit2E9RVQ9V0lxD2s69H8HCRIz5tG31/c/5M044uuSzix
 shJYGD0RUjC8vv37Rhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060162
X-Rspamd-Queue-Id: 395F72261F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.958];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17616-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+]
X-Rspamd-Action: no action

Provide the two combinations of Atomic Op Completion size attributes
that a root port may support per PCIe Spec 7.0 section 6.15.3.1. -
besides the trivial "No support" - as two new defines.

Change documentation of pci_enable_atomic_ops_to_root() that these are
the only ones that should be used. Also, spell out that all requested
capabilities need to be supported at the root port for enable to
succeed. Also emphasize that on success, this sets AtomicOpsCtl:ReqEn to
1, and leaves it untouched in case of failure.

Suggested-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/pci/pci.c             | 13 +++++++------
 include/uapi/linux/pci_regs.h |  8 ++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f1044416281aba11bf071ea89488a..cc8abe6b1d07661488895876dbbcf8aaeadf4a17 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3663,15 +3663,16 @@ void pci_acs_init(struct pci_dev *dev)
 /**
  * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
  * @dev: the PCI device
- * @cap_mask: mask of desired AtomicOp sizes, including one or more of:
- *	PCI_EXP_DEVCAP2_ATOMIC_COMP32
- *	PCI_EXP_DEVCAP2_ATOMIC_COMP64
- *	PCI_EXP_DEVCAP2_ATOMIC_COMP128
+ * @cap_mask: root port must support combinations of AtomicOp sizes
+ *	PCI_EXP_ROOT_PORT_ATOMIC_BASE
+ *	PCI_EXP_ROOT_PORT_ATOMIC_FULL
  *
  * Return 0 if all upstream bridges support AtomicOp routing, egress
  * blocking is disabled on all upstream ports, and the root port supports
- * the requested completion capabilities (32-bit, 64-bit and/or 128-bit
- * AtomicOp completion), or negative otherwise.
+ * all the requested completion capabilities (BASE: 32-bit, 64-bit or
+ * FULL: 32/64- and 128-bit AtomicOp completion). In that case enable the
+ * device to send AtomicOp requests. Otherwise, return negative and leave
+ * the enablement in the PCI config space untouched.
  */
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 14f634ab9350d5442192162225b5e5202dbe2308..63ac62b882a94c6873a0db433ba808332ddbea04 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -669,6 +669,14 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP32	0x00000080 /* 32b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
+/* PCIe spec 7.0 6.15.3.1: Root ports may support one of 2 sets of Atomic Ops */
+#define  PCI_EXP_ROOT_PORT_ATOMIC_BASE		\
+	(PCI_EXP_DEVCAP2_ATOMIC_COMP32 |	\
+	 PCI_EXP_DEVCAP2_ATOMIC_COMP64)
+#define  PCI_EXP_ROOT_PORT_ATOMIC_FULL		\
+	(PCI_EXP_DEVCAP2_ATOMIC_COMP32 |	\
+	 PCI_EXP_DEVCAP2_ATOMIC_COMP64 |	\
+	 PCI_EXP_DEVCAP2_ATOMIC_COMP128)
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
 #define  PCI_EXP_DEVCAP2_TPH_COMP_MASK	0x00003000 /* TPH completer support */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */

-- 
2.51.0



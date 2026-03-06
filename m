Return-Path: <linux-rdma+bounces-17615-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A+pMFwNq2k/ZgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17615-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 18:22:36 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5496225F62
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 18:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE7AB30775C8
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2C3423A94;
	Fri,  6 Mar 2026 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r3lYaMHr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6733123D;
	Fri,  6 Mar 2026 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817255; cv=none; b=J38CLAk1nclXOdsP9SGCyFGoHsewl7932j0pCE+Jy32wrhx32vxYUS9+RUoy+AmDr8ErFAdK3BGSvpiezMLI7kdxOmfddSAbileEszwvcq35F99EPQzSnWwQma1BB2UWWCfYRPYpspikdS4rcat6E93ZXEveAiZwoIGm1r0fpvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817255; c=relaxed/simple;
	bh=o6VJeQyvdF8sluPuypwR31NZuyAPIZ6njNUnRKK3xck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TmDNSgzLYEP8T21i18P0AEd8MYP3J8naCHkdD/c48g1sWldgqQpJ2nmZ1B/qHnKqMtRD2FuxJs2Ilw56cn7ZIKAZOOSCUG7GkVOFIvM1ZnljfZgRaR/w8B8oxai9vFUT65mYKsBDF9NlT8LKzMTY8awqNJDts4HgM9z31YDZhzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r3lYaMHr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6265xX6P1938926;
	Fri, 6 Mar 2026 17:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yNgeVx
	WFeQuNfZOKEGXswceUvqNdkuSeuOfc7dV8XuQ=; b=r3lYaMHryUKzL7x2Rs9w88
	kEPef60F80ZffOh32orTXis6/O9WdCJin13jw/v9Lb33G66KTjKI18f8l20EH5ho
	Hc5W0HPWotekpbW/J9hb7KI5LYhGhNNW3Q5qrMWSzZ1aGgjXnEmAz9wuZjkzfz1O
	GgJH3DYK3BWpY7PIb3CJ8CfVrPCxidRhyZjj6xva9+qPHAMG+d63maKwt9BEH+Hx
	Fbsg+3ZwcnQD4Zi+Ysn/i2NBj4gDQBer/n9RyLaQIbRe/8S4U9rIO7uafXi0LHkL
	fGmuZchrnolK9jKoAkr9OgkZ/5g1EgfNbo451P5Ck3ZajrgSaTgqXIS1PVLu4jwA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrjhqpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 17:14:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626ExE9m008816;
	Fri, 6 Mar 2026 17:14:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1rg32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 17:14:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626HE5de46268762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 17:14:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E69F2004F;
	Fri,  6 Mar 2026 17:14:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1306E2004E;
	Fri,  6 Mar 2026 17:14:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Mar 2026 17:14:05 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 06 Mar 2026 18:13:59 +0100
Subject: [PATCH v3 2/2] PCI: AtomicOps: Fix logic in enable function
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-fix_pciatops-v3-2-99d12bcafb19@linux.ibm.com>
References: <20260306-fix_pciatops-v3-0-99d12bcafb19@linux.ibm.com>
In-Reply-To: <20260306-fix_pciatops-v3-0-99d12bcafb19@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69ab0b62 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ud980_RLCRqylQVSWKAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE2MiBTYWx0ZWRfX2oKgBMBfkkba
 7OetCSS45o7LKDtHWVw8/o9wNtN5TyurORZzR9G4uZ1TVAE75PNudQJMTde8oA7F1e8sTLPgJ59
 hVjdwh67zTEi0PpH+h/AaEgbt7xorqgJ6CpTC/3vq1SwguOB4ns230/x+fp3L+3RTt+UU8nZ+c5
 aLfRUjptJ65Tap5Pw1C0oapTw3+JY9udZykS378Tk7IL8DBfhvOZHiMlnWXzJLhd6swLyZcTvwl
 9KTxLmilDvL0P3drgTEcbCNJIy4v3XZt73iHnKtusMMP91m36+yI7QEKAf0kSWUFIog/9xSdk+Q
 rtAcvoJykfi9Xwq1TbL+JUNcdM+6zcjyuFfe5W2cOiJqE6wdA2FrRafWShI+DjsQ3BUKoRIYghx
 r6uOVbu/WwI3UtlnkfXgG8+KLwzOqpjHVSC/rn1XZtXiaE4Y6kHqBMcqtxzaJl0d/nUn0GWqy+l
 stplczivw5lhcoT/vbA==
X-Proofpoint-GUID: zn42x3jkt0ZS9LoIc48rpJ9nhUIXcNWk
X-Proofpoint-ORIG-GUID: bRWP3uFGBbxRaVPYW9XwslJ_Ru1E7una
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060162
X-Rspamd-Queue-Id: A5496225F62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.955];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17615-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+]
X-Rspamd-Action: no action

Move the check for root port requirements past the loop within
pci_enable_atomic_ops_to_root() that checks on potential switch
(up- and downstream) ports.

Inside the loop traversing the PCI tree upwards, prepend the switch case
to validate the routing capability on any port with a fallthrough-case
that does the additional check for Atomic Ops not being blocked on
upstream ports.

Do not enable Atomic Op Requests if nothing can be learned about how the
device is attached - e.g. if it is on an "isolated" bus, as in s390.

Reported-by: Alexander Schmidt <alexs@linux.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/pci/pci.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cc8abe6b1d07661488895876dbbcf8aaeadf4a17..23db6ad5f310ed009a9b2ca4933c7498e0d22b85 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3677,7 +3677,7 @@ void pci_acs_init(struct pci_dev *dev)
 int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 {
 	struct pci_bus *bus = dev->bus;
-	struct pci_dev *bridge;
+	struct pci_dev *bridge = NULL;
 	u32 cap, ctl2;
 
 	/*
@@ -3715,29 +3715,27 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
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



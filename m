Return-Path: <linux-rdma+bounces-18146-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADKcMU1AtGlljgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18146-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 17:50:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F4D2876A1
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 17:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6CA5D300F2BF
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5AF3C9EE7;
	Fri, 13 Mar 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NbjAMiV6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159E35F183;
	Fri, 13 Mar 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420604; cv=none; b=O+YPFO9RvQwVvXC4tvGuttAKI0ECLWAtTnNkNG6HlBGVjhdZSjChXpvi5yC8mGLvVnquybgpflAJ2HyjEvMr3b6a1LpS8x/O0F6ruYdQIPyEew7Exl9lSo5qz6AxaDvsDJ8GWy7ysKKMUD5C/8k7nuwreZxU4AAV7rLMNUCjKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420604; c=relaxed/simple;
	bh=khgCIKMhtONiwvS7xOYf/RE/LUbHsHn+0k6FKbfRu6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHoSIYkckygBpOrcvWuG2QL6E1V5N5iHvX5fIrQo4QeygPS3fgGD6qYEh4BIFhL+/Z86S1IE8XaUep6e7bn1/mvI5EhnUIWZPMGowIgrGyAjnAwQmbea5pN6fponxBwGM7hMEsQVwwXDIrtDA2nXVT6aWFuxG013GtwGqxrASrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NbjAMiV6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6aO2W2281597;
	Fri, 13 Mar 2026 16:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1MtSar
	9yhjYeWfHjTQYC+Xx5EWZPh+lBocLKhblO3N4=; b=NbjAMiV6hIn1HBKXtTwljq
	xiYSd9XXi4gcpdiLyveoPYCbJKnZ5PrZUvpdzT8crRxUWsARaqhKbsJxL35rYd01
	SzEOuMsBJDjtTuoLdDqTvOKBMPiJ84eCzmIemuBZewQrXPA1MfFE4My+y521LSAs
	J0MCa1ZmYkUqPKvbIK8hnaSa/5ZoDJSp2zCT5aJgoYdqqr6mbogM7Lob0jXIAYSW
	V7vM+qO0yNVxgw4CozNvF8BwPkb0ROZy/8Hh1ak4qOTBRbfJazcZx/P+Z0Zs2KzE
	wPxXp8hI852EqGxqZV9IqzoGo6pwI0CTNVOYTgM9nlnTqkxbsgfGqzgOIMsBQc3A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91rtgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 16:49:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DF51tj008855;
	Fri, 13 Mar 2026 16:49:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha77gm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 16:49:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DGnmOB52822364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 16:49:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E0ED2004B;
	Fri, 13 Mar 2026 16:49:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B182004D;
	Fri, 13 Mar 2026 16:49:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 16:49:48 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 13 Mar 2026 17:49:35 +0100
Subject: [PATCH v4 2/2] PCI: AtomicOps: Update references to PCIe spec
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-fix_pciatops-v4-2-93bc70a63935@linux.ibm.com>
References: <20260313-fix_pciatops-v4-0-93bc70a63935@linux.ibm.com>
In-Reply-To: <20260313-fix_pciatops-v4-0-93bc70a63935@linux.ibm.com>
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
X-Proofpoint-GUID: z7T5-Ompxl0_AWHWE94q7ro_GTnDIGdl
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b44032 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=GT8QqqGQBE3YBt8_gt0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMiBTYWx0ZWRfX23eletseCwKm
 tavDo0VsMGaBANkmwbPh6hOzKXYBIrOVtTF1IxKTebjEE0FnvcJomAxxIZexZIXR4hXWzXDnVa4
 XF1NXamNLc8ZvTsa8G7vRyyFeYviDDNHi0rVKCb82RWGqV5nqkam117rBq5RUGSb/TPteTF5RF4
 tdpz8xub3ALGCGqCiCGIY6a+u8Q8Mp6Q1PmdN+8ZJplMHCbYCzu93xZHO2kKWTYgYeZbEFfdazZ
 Xb5trvgd+SPpP4THJfc0gXIArgXzMHo86TcQqtJxND1YVO9oF8omWYSdBjTuG4JTksBaBtezHF6
 BT7VPFyZx/KgXBmeMwtzSbIzjTM/b8nJ6/YrEH+xZal0jrubNGku0OduxRGgKL+AbSlD2/1WedQ
 VykwAZC8MUKJzCfMqXDqVaXUsF4jY9XijomqNKYV9bPUBHCcyJ4G8Fm3Kp/ArNjoIn5++kiUdqi
 d8f6FMuNSoN9COS9rfw==
X-Proofpoint-ORIG-GUID: oacAtUYMfDtqUoUmXTrlDJUtI3vD1DU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130132
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-18146-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 16F4D2876A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Point to the relevant sections in the most recent release 7.0 of the
PCIe spec. Text has mostly just moved around without any semantic
change.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/pci/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 94e90988df86b3278b1b6abbc326abf9b4a4a962..b1dd977d811253b70c8dd859a1ff05b1970b7661 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3680,7 +3680,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	u32 cap, ctl2;
 
 	/*
-	 * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
+	 * Per PCIe r7.0, sec 7.5.3.16, the AtomicOp Requester Enable bit
 	 * in Device Control 2 is reserved in VFs and the PF value applies
 	 * to all associated VFs.
 	 */
@@ -3691,9 +3691,9 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 		return -EINVAL;
 
 	/*
-	 * Per PCIe r4.0, sec 6.15, endpoints and root ports may be
+	 * Per PCIe r7.0, sec 6.15, endpoints and root ports may be
 	 * AtomicOp requesters.  For now, we only support endpoints as
-	 * requesters and root ports as completers.  No endpoints as
+	 * requesters and root ports as completers. No endpoints as
 	 * completers, and no peer-to-peer.
 	 */
 

-- 
2.51.0



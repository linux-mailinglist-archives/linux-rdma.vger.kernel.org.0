Return-Path: <linux-rdma+bounces-18788-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEI2LwZ3ymnk9AUAu9opvQ
	(envelope-from <linux-rdma+bounces-18788-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 15:13:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC1035BBB5
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 15:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C2793048071
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 13:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993EC3002A9;
	Mon, 30 Mar 2026 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U9k3SEGC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B53D333F;
	Mon, 30 Mar 2026 13:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876213; cv=none; b=qHvOQX44tohTxTViaCE8CBsTSUihVi7ME/Lm7gJvfpLq4/x6fBmE1G/moOPSPtKoGS22QD7xRNWFlgdNy7GYMowKifanoUPALTdpq8g3PAYiP3bLEzYpzhaYz1Jyd/U7BPdPptqxVLRVuiz2/BtLeEW4TiurxY+YpERObmwazNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876213; c=relaxed/simple;
	bh=+z0ds1dEkDsjD2TbiG1J1ECIKxoY5I0HhGpLfURiclQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6N64RkF3eC7iGirr7L40XZRjhR4B1W4Yrt1+7ZshddW2cNEnRwrPsa4uHAgRhdFSB8eajiOwTy0SrVFX8VnXeWS9BcFnN0JYi7RxW8SdEhTrdfz42zZhNGI1RPKRqfEXE4+stsC/NX+JcmfSroZPeMB2L2qsO0oN4gJkWY3l8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U9k3SEGC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U0jCiT462561;
	Mon, 30 Mar 2026 13:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CHeSzO
	4goq394woaZUo2vkt/fxPpeKAgtzg8EVdB714=; b=U9k3SEGCyHG5yQb7QvISk3
	5GHtl1iCyzCoWlnunTc0+O9IB9zfY+PrUCUuvC+rtmaC+AEb/wx0QJAmb8NlJ6fw
	IhrClLOTT2+XshHlnwQMxa5008uTuSaAEjCTXu5BYyzAtZDdr2p+hhGLfvQtEPyh
	UWGxtgCOP9ybe//Zh/OKQ/oWhDXuSow3uh6lQ3sRaoHMsJi6Gnek5mGyokLTXR31
	6iMhyF6qMD2/G66tQdHPPIVXRL3SjpAfzXvXLq8RrUctGGc+26YUl1d6jfCLgw36
	2HarZWGsMUx/jfAFcaBvW6gaxixjiyecwK/4APOQmJSfmxyNE5TNoyAfnvfPszsA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnevwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 13:10:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UBFMQD008703;
	Mon, 30 Mar 2026 13:10:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11cqy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 13:10:06 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UDA2SD42664208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 13:10:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A628F2004B;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68C032004D;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 30 Mar 2026 15:09:44 +0200
Subject: [PATCH v7 1/3] PCI: AtomicOps: Do not enable requests by RCiEPs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-fix_pciatops-v7-1-f601818417e8@linux.ibm.com>
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
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: nR_7MWUNmRcBNJwufyVy4G_yWkey58SG
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69ca762f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=l8ywxVsZnL7a6Sv94yEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwMCBTYWx0ZWRfX2sq8oqfMVQA+
 YeBcz7oajtbLWPeE9dkM/BaFYthp6zT+ff9iEmmOX9AsLPLOf8TXoicBR8gPeDxDDsk5qyG5Frb
 VYL2l3eO0/k9pnW7LICm0O+TqhI9UXcWctZuOshqgoqipqfECUH8e830QOZRSBiZvo2UMm25Jhs
 YOc7AKGL0BPBIC8D2N7dkf7yqxl3iWX37t3KPrUu/u6G32QWM4bxrVimZ2AT17/IKoCR9LAvQoR
 ezfqlbZgXCLCew2how5IZUefljiZaXfdiiuMmrzrCqoE6oqsNvPIv2meOCOv1OsUV74F0zI4yKx
 cKOHkNypn0M+al4GxQEGlUVFA1t4D5Da7KUf4zjrIvG5VoAfUI1s11heAaFizpajFSSQB5cAB5i
 G+rb4kv2yrDtwr6ZXOn00uV/UnggzT6TAvEI3b3x1PKGsjfyrTYeZkv+nWXcUpYz/Y0VBFvBHqd
 Fm9OovqYqPLfnXxpTpw==
X-Proofpoint-ORIG-GUID: P-slp7YBInZbi8orMA2p2Lc-oqwdirtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300100
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
	TAGGED_FROM(0.00)[bounces-18788-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7BC1035BBB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since root complex integrated end points (RCiEPs) attach to a bus that
has no bridge device describing the root port, the capability to
complete AtomicOps requests cannot be determined with PCIe methods.

Change default of pci_enable_atomic_ops_to_root() to not enable
AtomicOps requests on RCiEPs.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/pci/pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f1044416281aba11bf071ea89488a..135e5b591df405e87e7f520a618d7e2ccba55ce1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3692,15 +3692,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 
 	/*
 	 * Per PCIe r4.0, sec 6.15, endpoints and root ports may be
-	 * AtomicOp requesters.  For now, we only support endpoints as
-	 * requesters and root ports as completers.  No endpoints as
+	 * AtomicOp requesters.  For now, we only support (legacy) endpoints
+	 * as requesters and root ports as completers.  No endpoints as
 	 * completers, and no peer-to-peer.
 	 */
 
 	switch (pci_pcie_type(dev)) {
 	case PCI_EXP_TYPE_ENDPOINT:
 	case PCI_EXP_TYPE_LEG_END:
-	case PCI_EXP_TYPE_RC_END:
 		break;
 	default:
 		return -EINVAL;

-- 
2.51.0



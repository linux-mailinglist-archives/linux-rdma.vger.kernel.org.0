Return-Path: <linux-rdma+bounces-18148-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHv0A65AtGlljgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18148-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 17:51:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDF82878C5
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 17:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7759430D4BE2
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC89B3CAE99;
	Fri, 13 Mar 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RNy9iP3E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DAC37CD33;
	Fri, 13 Mar 2026 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420605; cv=none; b=vCrsU/N5NqyXOEX9NOnRuwvUaJozUMnkWok6mg4GPPJ5Ntk/veZnLpUAhQrzw3KzkoXQRzfi65iZ1jgnfbLgCo7ZbvPKslK6rGGMPRhcfYXJj+3/JyfQxDMDELdCc9KF7fQMfPAMmAhYVtiYQYo4SP6rRRcYDcUAIaJ2XvQ9VAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420605; c=relaxed/simple;
	bh=xTzdpMZCYondJWEPk8JkMgA5FD7i4J67sYgqTY+tQsU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZNWladers9aQMlLh5b8HbUQI4OjZFVj93zorOWqj+fi6XbeYpj/3OHT2p7di8h3QmWfL3iQ5A5P09LOxk/eUltNins9XZgqsLbSClxrFjpuUyCQHlhstFue9YqeLwhuYg1eb6FeWlbYnryUXZrVoPHFWCivx6qFh+xPdNYbxDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RNy9iP3E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6wBBf2258884;
	Fri, 13 Mar 2026 16:49:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=iX9r2AiI1prHt7JakZMj6s5f6wmv
	YMSn4/rnU5rjBf4=; b=RNy9iP3ELk0VTUm3EWcIpXzUzJ/CcAzbm4BE3ugNBEHl
	BrfJVVGxMw5efE+gJ29XEr0iKajM/DjlKNng86ZRyO02YFIRdmJmns50v0S0pxzS
	sRjo3djH9c7mzLbj8NCca+eLioioSptX6WAbB12aNzhbwdNkd6rPyJ1hdbF+Rp0F
	j5nWN3pTbLPAEK/d7czlAPtWbpm2bY9ckH93kTXMNLiI5T2YjExVgmKTbDtOmQ81
	cXB8vnW2tIOQ0MVdyKnPO8PNQhYGD7Jc3JPE39nMHt6Yyy46oNJZLo3yRy2CCQOG
	7UIt9jf8HpTLQbTdo1sovI+O5DlHVq76ndkRLu9apw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92gtg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 16:49:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DF2CPD021303;
	Fri, 13 Mar 2026 16:49:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha9qff0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 16:49:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DGnmBp52822358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 16:49:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF1C62004E;
	Fri, 13 Mar 2026 16:49:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEDDC20040;
	Fri, 13 Mar 2026 16:49:47 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 16:49:47 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH v4 0/2] PCI: AtomicOps: Fix pci_enable_atomic_ops_to_root()
Date: Fri, 13 Mar 2026 17:49:33 +0100
Message-Id: <20260313-fix_pciatops-v4-0-93bc70a63935@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB1AtGkC/23P3Q6CMAwF4Fcxu3Zk3eTPK9/DGMNGkSbCCMMFQ
 3h3B9EYiZenzfnSTsxhT+jYcTexHj05sm0Ih/2Ombpob8ipDJlJIWMAkfCKxmtnqBhs53iKWSI
 yNEYLxUKl6zHsV+58CbkmN9j+ueoelukbAvELeeCCY2nirIhTnUg83al9jBHpJjK2YQvm5ReQs
 LnEywCUAhTmOkWJfwH1ARKhtq94FYA8L0FqU1Qa8i0wz/MLtCtFmi4BAAA=
X-Change-ID: 20251106-fix_pciatops-7e8608eccb03
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
X-Proofpoint-ORIG-GUID: _QrGwSjVUPltmE9RPpDZxFai8piLVSAM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEzMiBTYWx0ZWRfX+LXl7S5e9XGM
 SHb9sApOmPvqZxVPqPJDvGIywPwOOn2yjAurS0VdLCAJCWawF5qstdSkDOI3dXMCFCTYqMf22QR
 VzfUgp5c0hxFROV7o/AirdQFnzvsSosDljael8C/tBWS1SE+BIlyKwWFfFgUhYjvC2ZvSC2P+9G
 wgs1nfsVS2ioYHSAIbTshjoJNDhEGzPvSDQeSp/cF/62cbtjn0vclrhhqEJ1K+CVpNPFaZe8BlI
 0QfJajSouRd0kNMk4Lrl7hDvQyDsZgj7PCwrvNkzRUTClyid3AAyybmi2Aj+CqjdtaEUyC5iVbl
 C2YKHGHo00KFsPqq9ycVkZOqriabqS+Uk79Od3RwCZ5sgLUtGsIe40+zrV7BHhHUx28uELJlLyf
 fWZWCWICPra0iqE29EvnnWvMqRnmlUmGbHt3xJCKNGceaEvFsM5SwfgZKsGKRrrAcptvCUTEcE3
 oSrw7egM+3NyOmQYjoQ==
X-Proofpoint-GUID: CEBKxirgksMMj3B9GRt_JX9Ixqbp2o9n
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b44032 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rbBVMOfHOAgcstZCQ3AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130132
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-18148-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7DDF82878C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bjorn et al.

On s390, AtomicOp Requests are enabled on a PCI function that supports
them, despite the helper being ignorant about the root port's capability
to supporting their completion.

Patch 1: Fix the logic in pci_enable_atomic_ops_to_root()
Patch 2: Update references to PCIe spec in that function.

I did test that the issue is fixed with these patches. Also, I verified
that on a Mellanox/Nvidia ConnectX-6 adapter plugged straight into the
root port of a x86 system still gets AtomicOp Requests enabled.

Due to lacking the required hardware, I did not test this with any PCIe
switches between root port and endpoint. So test exposure to other
environments is highly appreciated.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Changes in v4:
- drop patch 1 - it will become the base of a new series
- previous patch 2, now 1: reword commit message
- add a new patch to update references to PCI spec within
  pci_enable_atomic_ops_to_root()
- rebase to latest master
- Link to v3: https://lore.kernel.org/r/20260306-fix_pciatops-v3-0-99d12bcafb19@linux.ibm.com

Changes in v3:
- rebase to 7.0-rc2
- gentle ping
- add netdev and rdma lists for awareness
- Link to v2: https://lore.kernel.org/r/20251216-fix_pciatops-v2-0-d013e9b7e2ee@linux.ibm.com

Changes in v2:
- rebase to 6.19-rc1
- otherwise unchanged to v1
- Link to v1: https://lore.kernel.org/r/20251110-fix_pciatops-v1-0-edc58a57b62e@linux.ibm.com

---
Gerd Bayer (2):
      PCI: AtomicOps: Do not enable if root-port capabilities are unknown
      PCI: AtomicOps: Update references to PCIe spec

 drivers/pci/pci.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)
---
base-commit: 0257f64bdac7fdca30fa3cae0df8b9ecbec7733a
change-id: 20251106-fix_pciatops-7e8608eccb03

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>



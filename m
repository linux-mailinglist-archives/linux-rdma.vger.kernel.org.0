Return-Path: <linux-rdma+bounces-18790-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPFRLUR3ymnk9AUAu9opvQ
	(envelope-from <linux-rdma+bounces-18790-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 15:14:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3614535BC06
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 15:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18290306DCDC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315863D47A3;
	Mon, 30 Mar 2026 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A8dcuJU8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496193D34AE;
	Mon, 30 Mar 2026 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876214; cv=none; b=t93md4A+BBAglG28a/JjRM2/Wdjenm1AKOGQnuyb+kj8q+ZezHQ8aJDRL6BHdeTqEF8a7LLwD6uTEOTvajj9fHfVoiZ8LBr9fTHhu2g2BeXTy13IiH4fVn6luKOgIEnWW//1DHB7/UrHhnu0oF3s4QwmAQvJ8tkooKsDRZdZQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876214; c=relaxed/simple;
	bh=0WpXNmINXeVMHKFY8pV8yHTpHakSBdQoEYW2a2Gu4t0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CYFA1GyIWIgpLNJuPSsxm9LyvftQIN+dtga4cV7fmEJSInBWd6iNVbNDJmUhyqXEsWND9AnoOHlulzy618pl8CHmnDzsSd/gJJaj4GUCglNBCXUNhHfrG9Ovj11aQy5GxgxuScxCVbYRQelntYHEE5Xo6BvPLqW12RNqAn1kLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A8dcuJU8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UCsHAo3587823;
	Mon, 30 Mar 2026 13:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=3I35eUYlAKW8mFUQ9C7xezobrVjM
	L+hOrP3NDrhy/V0=; b=A8dcuJU8+ltGZb7otEjoZwO3xhvhsT1+NnaC/bdUtqkx
	I8F4rp8ESWPSsTdNibL9AHGfeHPyUdA9SgQI5ddNL8flxOz/FPb8h75AZfjhYsQf
	7ElGOsV0w7fYEUEM6g9Yz0OtT/2bw7qEVl1Zx3XSgiglBMft64rrzQMDfeaaCpwU
	iyzUz2KL5EMRgZ0BEgUy8HqMa9BtYRAxM3wLELELVh6ioWyCPCn0F3skW9bUFVbr
	nnJg3aQxR0yjIHZtACjlzQpq2dzuaH9v5JR1fM+k2XGdKiB/yTPA0AljjrM3iE9k
	kUwFXdIadVmOUKGVRlBhZmIyzMfiF/behaXJWZPRGQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66mrxhsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 13:10:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UBA3kL030947;
	Mon, 30 Mar 2026 13:10:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhjmsxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 13:10:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UDA2PV42664204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 13:10:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6257B2004B;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2119220043;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH v7 0/3] PCI: AtomicOps: Fix pci_enable_atomic_ops_to_root()
Date: Mon, 30 Mar 2026 15:09:43 +0200
Message-Id: <20260330-fix_pciatops-v7-0-f601818417e8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABd2ymkC/23P3WrDMAwF4Fcpvl6KZdV23Ku9xyjDP8pqWJMQt
 6aj5N3nlI1lJpdH4nxID5ZoipTYcfdgE+WY4tCXoF92zJ9t/0FNDCUzwYUE4Krp4v199NFehzE
 1mlrFW/LecWSlMk5U9k/u7VTyOabrMH099QzL9AcC/h/K0PCGgpetldopQa+fsb/d99Fd9n64s
 AXL4g8QUF2SRQECByTjNAnaBPAXUBzrVzIWwJgAwnnbOTBbwGEFAFbAYQHQec2tQoNyC5ArQNS
 ALEBng9UC0ZJttwC1BmQFqAIAdx2YoFUIUAPzPH8DARsnr/EBAAA=
X-Change-ID: 20251106-fix_pciatops-7e8608eccb03
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
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=7zwmxoYQV6rCx-UIAC4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwMCBTYWx0ZWRfXxJEenwXwTeIx
 IOX1S2sBdyQms61MrmkjxMjuHsK+3wzYuTn5896QffYl1NT+ZuBc6/f21x7bA/Zbdn0igVRZ/vh
 DZi3V5UTaZI7BhmsMBoLCPK5CaqM1c33mdDgUcL+XYowE5zKH25zba9ljJBi3VcIXeBJsKXndFU
 zDNyF8t+CJ9p5IRF96ebwB1/3cqiOban3pFXSzy/MZsnP8+f0/4b6vs2G7oWg0h6lpL3RaFgJQ6
 e6Eht8vzv8YdQDe6GrWRl/OurBvQSfy5fiGWWpxiSCPja5VvKdgbPyBBU+Sn44VWh82CSI/9fxV
 2iaj9fg5nBICM66VUheWvldeLqijVm99WjAaVL3sLzl2TsXTpg6t3m8aAxxpHI9IafofJSWp+Pa
 x9s21qZ2yu7WmPTixq/ZDyRaYwj5PWt9284Mu5ubvPiMX6qTk8tzRIu3VQgQsxY0yob10MKnda8
 g5YJHxCPedQG9WksPyQ==
X-Proofpoint-GUID: 2jPg5nYGLv5jPOt00D2_nVxs-3Vtxl6M
X-Proofpoint-ORIG-GUID: hFI6YSonbms8A70CRRFvdbqptKdyt-B7
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
	TAGGED_FROM(0.00)[bounces-18790-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+]
X-Rspamd-Queue-Id: 3614535BC06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Bjorn et al.

On s390, AtomicOp Requests are enabled on a PCI function that supports
them, despite the helper being ignorant about the root port's capability
to supporting their completion.

Patch 1: Do not enable AtomicOps Requests on RCiEPs
Patch 2: Fix the logic in pci_enable_atomic_ops_to_root()
Patch 3: Update references to PCIe spec in that function.

I did test that the issue is fixed with these patches. Also, I verified
that on a Mellanox/Nvidia ConnectX-6 adapter plugged straight into the
root port of a x86 system still gets AtomicOp Requests enabled.

Due to a lack of the required hardware, I did not test this with any PCIe
switches between root port and endpoint. So test exposure in other
environments is highly appreciated.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Changes in v7:
- Prepend series with a patch to explicitly exclude RCiEPs from
  enablement of AtomicOps Requests
- Limit the core patch 2 to enforce a full check of the entire
  PCIe hierarchy for support of AtomicOps capabilities.
- Rebase to v7.0-rc6
- Link to v6: https://lore.kernel.org/r/20260325-fix_pciatops-v6-0-10bf19d76dd1@linux.ibm.com

Changes in v6:
- Incorporate Ilpo's editorial comments.
- Correct logic in pci_is_atomicops_capable_rp() (annotated by Sashiko)
- Link to v5: https://lore.kernel.org/r/20260323-fix_pciatops-v5-0-fada7233aea8@linux.ibm.com

Changes in v5:
- Introduce new pcibios_connects_to_atomicops_capable_rc() so arch's can
  declare AtomicOps support outside of PCIe config space. Defaults to
  "true" - except s390.
- rebase to 7.0-rc5
- Link to v4: https://lore.kernel.org/r/20260313-fix_pciatops-v4-0-93bc70a63935@linux.ibm.com

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
Gerd Bayer (3):
      PCI: AtomicOps: Do not enable requests by RCiEPs
      PCI: AtomicOps: Do not enable without support in root port
      PCI: AtomicOps: Update references to PCIe spec

 drivers/pci/pci.c | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)
---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20251106-fix_pciatops-7e8608eccb03

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>



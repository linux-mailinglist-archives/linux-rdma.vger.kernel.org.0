Return-Path: <linux-rdma+bounces-18636-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLfhOvcCxGm0vQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18636-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:44:55 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BC9328503
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6AB633D75CF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749383C4578;
	Wed, 25 Mar 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gneg3v9y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00020010C;
	Wed, 25 Mar 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451796; cv=none; b=BRocw2/GmocDGHjCEe9NjOww3xVAW2or7m4NAjOfoLjxplZx+ol9WjGEMAxUwcZFob4CUkekkKFyk5PZzwHCCW1Kc1cEBYqTy3RylINKhVB6pIngrplnjoZEVv+ochaakO+60vA1uY3oMbmOUlHofkuldhlGkk+8VuuFwwseOcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451796; c=relaxed/simple;
	bh=VpbZhNuuSl/ns05S2kGFJP+U2qoOXBtQ2LQID/TIRtI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CvcXbzVNs7E1EUqwKThaVEewUw5ffP3WkLhl+ZJrTKYoCa4mfVTG/kahN08BXghm8k61xTaMc+eKKo0ekRv69Nj6T6lciCIMoy/pa3/hHO8/GDZ/K/Uk2eTstxFXDWmIlmIf0V0gKyGWb49lDB3p9iL/mrWRRQL4hR5mqGyuhJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gneg3v9y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P1HmXV2945148;
	Wed, 25 Mar 2026 15:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=02sTmvQ1zAB6bEnH7R8KDUUjdfiw
	m1jwy5u8OYUaRS8=; b=gneg3v9ykjLDh13RUpbib2s6I9us1k/FkHkgS7uMJeZ8
	RUmp323tjLcEzXoN4Z8uyGKoHgLUcBR81qZNuKyyldGoghVWID6AiBzgMsE+5uLc
	R9WyUuB6D5R4r5iZsmwvZtuZNNUxmgfQvCuvWZFaCzAeIKpeWkTWOsYKxq99MOWx
	Yw224eEVbv/jihc4EyGsuRE0hTsK2hSRvVq9aYGlLpJMsGFU/Tsoorg5pb3RSXYk
	A0lcp1fzbJ+34yvp8q/yjUnXJ/HjnD1gOc1tbgjbq/+CKOVJ6zlqY3z71x1HH1tm
	qNSxTIUtrRt+Rw5bK7uFGtZWrMF9hCVH06m1A8tFGw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktv08m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 15:16:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PC6MbX004380;
	Wed, 25 Mar 2026 15:16:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c26sgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 15:16:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PFGOOd41156904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 15:16:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B3092004B;
	Wed, 25 Mar 2026 15:16:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F0EB20040;
	Wed, 25 Mar 2026 15:16:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 15:16:24 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH v6 0/2] PCI: AtomicOps: Fix pci_enable_atomic_ops_to_root()
Date: Wed, 25 Mar 2026 16:16:16 +0100
Message-Id: <20260325-fix_pciatops-v6-0-10bf19d76dd1@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAED8w2kC/23P3WrDMAwF4Fcpvp6LLdV23Ku9xxjDP8pqWJMQd
 6aj5N3nlI11JpdH4nxIN5ZpTpTZcXdjM5WU0zjUoJ92LJzc8E48xZoZCFBSCs37dH2bQnKXccr
 cUKdFRyF4gaxWppnq/s69vNZ8Svkyzl93vch1+gNJ8R8qkgtOMajOKeM10PNHGj6v++TP+zCe2
 YoV+ANANpcUqEAUEsl6Q0CbAP4CWmD7SsEKWBsl+OB6L+0WcHgAJDbAYQXQByOcRotqC1APALS
 AqkDvojOA6Mh1LbAsyzeQ/xyisAEAAA==
X-Change-ID: 20251106-fix_pciatops-7e8608eccb03
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
X-Proofpoint-ORIG-GUID: uQjG6wlYtha8bjQIqZwWRzjebZrwsQDO
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c3fc4d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vQOT1DpSoXcvsw1ccD4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEwNiBTYWx0ZWRfX2GpDRAcc6WTz
 1HSdAIaG00oASGwIuCFa6XeHxOR0NoGEHIKMQFmACACBss1N41BmzFVu63Ha//zUCjHgN2AAJW+
 K3tFA3s0pOfj7Swva3WEFJJB70AuF+HSXhBlnEMf9Nbwiuf20Ggwjg3bwowAFt5TrrkSeD/LwyV
 FXyC7FfxgwoG1JNG8nbzZvSqe+msGrPgxrbggPgxscqf82gMJsix/VmvjecEkp2jRpX4RxgScbn
 IogOwZZ/+ka6J378SkulTFktb6oPiryxPOpm+dsmgsakLYmC5NPs9TjRzSS1At6/UFm7VpSB17+
 bNOrHq6UK8CRkNtMG7dLQGqt2vb2fGON2mHVICp2M0XIblt2PAXH/XtUXLSOgAi5uCy6ud1nJkX
 r455av+7ObpP8nAdwhLzF7n90SutxmmgOm88oXVxt6NDvJ7Tmy/q49X9Aae+ykrScIEbe6aSuoy
 HZo88bJJ0GlPWMxv7EQ==
X-Proofpoint-GUID: joWoaCiOBWI4xkTdCkeMdT5UmKbpaHg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250106
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-18636-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 87BC9328503
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
environments is highly appreciated. One particularly rare setup is a
RCiEP that might act as a AtomicOps Requestor - but was subject to a
regression in v4 as reported by Sashiko.

v5 of this series tries to make no functional changes for that class of
devices either.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
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
Gerd Bayer (2):
      PCI: AtomicOps: Do not enable without support in root complex
      PCI: AtomicOps: Update references to PCIe spec

 arch/s390/pci/pci.c |  5 +++++
 drivers/pci/pci.c   | 54 +++++++++++++++++++++++++++++++++--------------------
 include/linux/pci.h |  1 +
 3 files changed, 40 insertions(+), 20 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20251106-fix_pciatops-7e8608eccb03

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>



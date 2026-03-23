Return-Path: <linux-rdma+bounces-18524-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMA1C81+wWknTgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18524-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 18:56:29 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3612FAA85
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 18:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29B5B3223735
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740C63CAE80;
	Mon, 23 Mar 2026 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s+IaSmnC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307B3CA4BB;
	Mon, 23 Mar 2026 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287732; cv=none; b=Wg4YD8jMJH19mWTALD+9ttkzRnUBRl1QRwcvbyfEKeIryUOvJwRkl7NAojDkRumtKaKJL/CxUB0i4+Ig2OoJtMWdqLR/pRd9GtE9KLWpjL/MkEx5IWhZGchkSViPYRLPae86KMtL4g/5Io+S1svGKCBVuLald5Z+epeBIx/1cPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287732; c=relaxed/simple;
	bh=kP/UWgyTwUu5lvrtfJPg6b/LG77ShIc4DsmqeDDRCbI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KAMyBc3b2nViIboMVhJOWgtm2yVvj6LLJgGRNd8XOGbEx1qku/hwVdjfWFG3KUy8QhVVkW9ws+dq22VHtG/6gwhlOmdBr2APWz2dzyKSfhsMSxURfvNcihQ6a45PP0bl6EY4mjTksxRoXuzENPEbokf/uVhU2B5KgZvVWNGipSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s+IaSmnC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFjHan447711;
	Mon, 23 Mar 2026 17:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=EB6FW/TWznasljGqCcp2tvakL3Kf
	1tR6FQh/R80n4RI=; b=s+IaSmnCybZyBRQY96eaoW+CBD4P500apikCql43nL6N
	T5fvSCil2DNSVRcnf1uilx0uH0jHY+O8dgQLfF3aciYuRgmtf/5RWqR1iDiDOsp7
	aNPTyAqkA/8N0T+xVU6bpQ8+nVn657sKgEFtha2wlNW05S2uGjjzVbzrHF1U+AUq
	7/F1bjZm+3LyddwOWudJ4V0DABgr7xr3Z5x2mFNJsDlzPkyyb2g1u2KYxkp6EpuZ
	kok3f20k3jFw1Nba5n8XSnOflmkntkiQnTdu2hxSWpE58scd0cmLALgjVjYyV19a
	IbNzFBcGqh5KvVjbX7rXtmUmvwlXyDS4vMQVcvO+YQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9r2q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 17:42:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NG4BqB031605;
	Mon, 23 Mar 2026 17:42:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nspgwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 17:42:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NHg1rg45285684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 17:42:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 105932004E;
	Mon, 23 Mar 2026 17:42:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C39B220043;
	Mon, 23 Mar 2026 17:42:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 17:42:00 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH v5 0/2] PCI: AtomicOps: Fix pci_enable_atomic_ops_to_root()
Date: Mon, 23 Mar 2026 18:41:49 +0100
Message-Id: <20260323-fix_pciatops-v5-0-fada7233aea8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF17wWkC/23P0WrDMAwF0F8pfp6LZNVOvKf9xyjDdtRVsCYh7
 kxLyb/PKRvbQh+vxD1IN5V5Es7qeXNTExfJMvQ12KeNSsfQv7OWrmZlwFhEcPogl7cxSTgPY9Y
 Ntw5aTikCqVoZJ677O/e6r/ko+TxM17tecJl+Qwj/oYIaNHfJtsE20Rl++ZD+87KVeNqm4aQWr
 JhfwODqkmIq0AES+9iw4YcA/QAOaP1KoQp436GJKRwi+kfA7g+AtAJ2C0AxNRAcebJrYJ7nL/K
 hCgtvAQAA
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
X-Proofpoint-ORIG-GUID: s_B5zmyNPUhx_Urc7cxrlrgiWU8H5Ioq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNyBTYWx0ZWRfX5CZZcJaJctQP
 i3JFsiBPGyjSBPoenkoJ1Whdnwt/z6oj28qNkJZhlYDVAMtQn6wHjYwEv9x0+bFhRV3Vd1nUAnC
 /ydE+0f7Rxo+RYVgCEEtSKMbBmCccS4iTk7ScfQD/YwkvGBG9IqqESY4/erGISgiZwaLzY+24bx
 gQ5cFjsXCfAcUQb6/xBAG+p1EzCUutJLRvPDHg8y+73CEGYFo9RTnqYdKHpxtN3XEXzTiR/eT9x
 nKWRs5x2pzKAZK6fMVp8GXeudx5J18BC8f+gIj1OvlXgXQhGAoo9jzqelVEajRg8t544U3PLYYa
 Y3YQEIFS4iZcqr08/MNM2h6eUM5aIclWaBJIydQjwQnPEx18SRE/PuSbr/1+ycfH9ZW1TmeLuyo
 fWeenmB3N9lpuryY77EQrb1irnUsnnIEOybRGutg4e3qCfwKWWlxoo8x5DHM3iOGmrpHu8+UBYu
 DHY1MYgzCHhpk9c38HQ==
X-Proofpoint-GUID: HUIW40nPqApzgVOEgtccLpNPo7juv01k
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c17b6e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=vQOT1DpSoXcvsw1ccD4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
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
	TAGGED_FROM(0.00)[bounces-18524-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: DD3612FAA85
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
 drivers/pci/pci.c   | 52 ++++++++++++++++++++++++++++++++--------------------
 include/linux/pci.h |  1 +
 3 files changed, 38 insertions(+), 20 deletions(-)
---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20251106-fix_pciatops-7e8608eccb03

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>



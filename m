Return-Path: <linux-rdma+bounces-18525-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGZrGXWCwWnATgQAu9opvQ
	(envelope-from <linux-rdma+bounces-18525-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 19:12:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 279B02FB02F
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 19:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52B5531551E9
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F56C3CBE73;
	Mon, 23 Mar 2026 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CbbIcVxL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0833CA4AF;
	Mon, 23 Mar 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774287735; cv=none; b=utKoP/LXZnrwCCsP1dgQsvidx5bGRh69B+M2fWSTTkehkjJPGIA8VlqKsI82XoZ+ynMg0vrdCdFZBS6GzlBAvXT0CBgsCbTsvEx//uJJGjwilf0mnlmS2gCkF51XxyTXWkNTtEy4OMCuqlm9dBDpD4m1mIKzbOrV3UGJswdEBa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774287735; c=relaxed/simple;
	bh=zrLVJdsj2xj26f+5MMV71txjt9WOFbmNImdJJSiEXBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eAqFh7Vub5Ai34AqlUx/jo0Tj7m1903yyhGibmd9D9HTUZJI1BeQlHZ+M9XxBBOhcdHCF5kVzwSH/OBJDy6gdoPBY1EwZlQ5qq5m7cgCGePHv6n2mfDRVqj0DQANGjgZNWGI5OM44hU4nj4UYFtNCSDokkgrALjamwS7LHcPGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CbbIcVxL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N8sYjj3255707;
	Mon, 23 Mar 2026 17:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QwswFw
	tV3LAFfylhjXBfUeHEfQMdVgAYk5tz+zm7JvQ=; b=CbbIcVxLsqqIOLEfPOUUni
	7UlzXTvla2cetxnbRlMuutL5AtqB9R5jA6peHwZipIwlPgESkWacu/4HARiWwjQM
	H+zW9Fo81GyTRl/RNc3K2yl52zogiIXGd+J9MLqzFSg1GdhRGftvjhTQfB3o3YgH
	hMd/+ernXW28NCSq3tvTQBELQjGigp6VCfkRqyWU1wNF3AAh5cU8Ollb/H8Lk5H/
	J50QFfv7qKoBP3lIPx/scE/qfDMhnid29dE5tZ6HHQ+ePY5yLsAaPkU4Wu7wO8/Q
	ubcHnp+k2cQTUgB2TbROfAHde5dFnuJ7GsEuO3fVbyA5ioyYSKbrJV6YEC/hxE0Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumfrs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 17:42:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NFriVg031592;
	Mon, 23 Mar 2026 17:42:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nspgwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 17:42:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NHg1VV45285696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 17:42:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D4C520043;
	Mon, 23 Mar 2026 17:42:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55EEE2004D;
	Mon, 23 Mar 2026 17:42:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 17:42:01 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 23 Mar 2026 18:41:51 +0100
Subject: [PATCH v5 2/2] PCI: AtomicOps: Update references to PCIe spec
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fix_pciatops-v5-2-fada7233aea8@linux.ibm.com>
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
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: eWgJrRiVhxH3dps7lrlp1t5Vod0TM67w
X-Proofpoint-ORIG-GUID: H6kcuBex_MfWrPpLOzOjXuvIj5egMWF1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEyNyBTYWx0ZWRfX55AyJXs8QiFa
 n1JR2Ug45Wyl6m5BTOUWVT1BAGjsa7sNYdwNCX5bV84N4F/Zc38NVki4STtxvkrnsZsauk/RAjY
 zbqEYxQlK2MfcLCcB9E4YMqBF5PZfVf8bISfQrrxS/hIWiXdGEQSdTk0elcI5c/y2626WHzNcep
 dPSzL3SDAd3eGpuzsItCmtl6mmqAnHhagRZrqUOZsc7Ne9vx0uMfzStV/Dl05uSJu2DXZj7AlQE
 8U+/o8c/u0JKk8bknYyRXhr+vtIJIe60AiW4FQD8mq6fw6kzIieKslCsJiJq2zCwa1wHZKjX2Xx
 O+np1Vu90p9USmpv6txnx4/GxqlJKsGJj1goqOVAWaPrnLqWbqIJqV85FsoWF50N0by8meKat/9
 bcYZ4/gt8DFHcRJAsrw625TGYm/FrYW7YMxFaWOjtsCcWNIBFIbhXIxsP07ATxVgGghDlUvpuwX
 Z7Q35AbYZs7kagAVQiQ==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c17b6e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=GT8QqqGQBE3YBt8_gt0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230127
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-18525-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 279B02FB02F
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
index c1143f8e6b2a0f029feb3c4390ac6f33837f6de1..d0d52ccf1ac18ce5a1917a713af9ab87b61cb7f9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3695,7 +3695,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	u32 cap, ctl2;
 
 	/*
-	 * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
+	 * Per PCIe r7.0, sec 7.5.3.16, the AtomicOp Requester Enable bit
 	 * in Device Control 2 is reserved in VFs and the PF value applies
 	 * to all associated VFs.
 	 */
@@ -3706,9 +3706,9 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
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



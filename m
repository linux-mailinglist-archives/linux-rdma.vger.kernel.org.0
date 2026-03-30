Return-Path: <linux-rdma+bounces-18789-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPN2ECN3ymnk9AUAu9opvQ
	(envelope-from <linux-rdma+bounces-18789-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 15:14:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F068435BBD2
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 15:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF02B304F5C6
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51A3D3D19;
	Mon, 30 Mar 2026 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tXTXejvD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E343D3486;
	Mon, 30 Mar 2026 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876214; cv=none; b=CFR+oe2aItTszVBOzqByYhGhHu2g2hFk0yt645rwfgMZJPXZ4Co6hRSzGzFbVBU+u2fi7qGZioHiW9ykBOTAKdWxOqn5iAF/rDozIBPVahMZfjQZjs6x086rgxL1Yk94InBlUGhFxAcqMSWXFxewtRLphGtWTkUOUCivbOOQzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876214; c=relaxed/simple;
	bh=9jmNyaOt/0cBAnwwLqfRspUEA0PjzlJZz4Yks/N0ptg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m5yCiYzMVSkqH7SS9+9MLxJKpn2H1+yF8z7Qe8RAgWyjc01T49UC6pfbkaXJsAwIL3tLoHkkzJVaZS7CXzjCHfPfHTvTcz7y1i/btkbkszvZ5R9KLsaCDKkMbnP7RZx1FGgVWny6DCvihBf4LG7JsDU9xI//G/p+kNha/2/zJCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tXTXejvD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TMJRej505649;
	Mon, 30 Mar 2026 13:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YusLYK
	c1zZAvs79QbUL4PnOWSxVkj8Y3/1w9SLjr/W0=; b=tXTXejvD67mTAgqN7+xyhx
	HDSOMsnxdBn0t+1fYfU697k1/L5Aq+YbH2Xl3t8CXj+y//AP1pJi85g0aF93UEBp
	ZrInXKlMtHoiUjZlZns/fJNyJg/zu5w2dJgfrZqu/BNgWd6ARGqRw7S8t0Db4iTC
	Oh4JXl3mkMOO8w0JEJPXTgUQwxE86d7hqKNRvpc1h6S1dOewZGaSqrn+8mfw0dhv
	kw3t37cVdk+RiAbPN9zVrU5T9kpuPGpUHuyYOIgnOPZ2aCtlVHSVJZ9l9429E6MI
	7BHUUc4rWI+IG7E/cWsOAf503jqrA3Nk6q9I5WS7Au6TNz9qLfmZ6EWgIaYoJLKg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1pxcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 13:10:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UATOjC022266;
	Mon, 30 Mar 2026 13:10:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tamvy0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 13:10:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UDA33G25952558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 13:10:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 307C92004F;
	Mon, 30 Mar 2026 13:10:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB1912004D;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 13:10:02 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 30 Mar 2026 15:09:46 +0200
Subject: [PATCH v7 3/3] PCI: AtomicOps: Update references to PCIe spec
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-fix_pciatops-v7-3-f601818417e8@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69ca7630 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=9UpU5CifMvqjbUjnZUAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iinQCws480Z3GQ6ayIZmDRpOPfgImJx3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwMCBTYWx0ZWRfXzPAdaEWaQDxq
 MFSc44PvvqPul7Ki2zlU+MfspgH43rVg282i/OsZTd1PWAUPClazyGmjHVcH+b6Be7L/QVjCgZL
 N2tXNbF4WmqGvPndDJV5w6JCbSZk8dQOM5gnTkIeaMfFU9nJFHArJ6PeZnNf6KsYaIDmk5mtKvz
 FBgKYHE8nVIpKmcTOoOrl8zZyrtZz/FCzT0ctxENjfRzCRex+ybKoQOxGryE0IGMfZRtFzLDLJT
 me40YK9VUcFYWjgFeUTbZxaTYKhMB4VXLohmsZ/7PIsPdSRcOZucXDEJukSnENUfVHLdgs9x/f/
 FkLTDp89JPaKuog/Ue+JmOIQ/KkcL6ebMrufhgiBuqvjdxU2PKbPB/2eQ6psbgSZTojs3JDP8Vw
 s6OwGZkPiov5lQRGg49ox7tc0jVd5X0P56AMmDsHxioeKstyx09ow/M1cPPaVSIeuoLJgqEh+iM
 rvoddYShwKGvKUdqmzg==
X-Proofpoint-GUID: 37mMKGp9UjzJCLjZ9nBHREfsPsDi-nOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300100
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-18789-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: F068435BBD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Point to the relevant sections in the most recent release 7.0 of the
PCIe spec. Text has mostly just moved around without any semantic
change.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 57af00ecdc97086a32c063ff86f8a39087ad1f5e..b99ab47678b006004af6cdb9b0e9f9ca4a28b6e1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3689,7 +3689,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	u32 ctl2;
 
 	/*
-	 * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
+	 * Per PCIe r7.0, sec 7.5.3.16, the AtomicOp Requester Enable bit
 	 * in Device Control 2 is reserved in VFs and the PF value applies
 	 * to all associated VFs.
 	 */
@@ -3700,7 +3700,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 		return -EINVAL;
 
 	/*
-	 * Per PCIe r4.0, sec 6.15, endpoints and root ports may be
+	 * Per PCIe r7.0, sec 6.15, endpoints and root ports may be
 	 * AtomicOp requesters.  For now, we only support (legacy) endpoints
 	 * as requesters and root ports as completers.  No endpoints as
 	 * completers, and no peer-to-peer.

-- 
2.51.0



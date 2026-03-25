Return-Path: <linux-rdma+bounces-18638-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFXhEF0AxGmlvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18638-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:33:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10428328162
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A960430E76E9
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD363E3DB5;
	Wed, 25 Mar 2026 15:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D3B8pcER"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFA222E3E9;
	Wed, 25 Mar 2026 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451796; cv=none; b=q/DZVel9qZwoXAM2lxrBui4ohVvVhWKComfYegd/cFQlWm2tYGEnOVXvEs/bQRc6KwpGxdO7sZ4OswSaXewD/XwPSNOeiFiZFbUObE90NRfeK/IWA2EUG4n4rXqz5IB89IGIid39pxGE1A+tLCAIWDIjfEVeHRlU88FLOg1Jxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451796; c=relaxed/simple;
	bh=NhspUJx9w1VVKJpz++cvxMB4eYCccI/wl+Vo7BADFfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F3HIwakhwhzWXFPeKN+kZAHpKnbCaD5xsmNrqyN8aQyYEnqvhOcqglK2LheYKHyhnRpRzpyRZxR3OphhRBeSl+yhvy+G1tTO2/UpTLJ856Cp0apn8m9WnBfuqy1alsnm3WgLlDoTzYeAcDj/7pR+gVVAm4EE+9QShXyNhB6wFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D3B8pcER; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PBQIeS511484;
	Wed, 25 Mar 2026 15:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4nUrHb
	OAPxrqOyZDmI8Ux9wOjU9BEC8kz64uahnDd30=; b=D3B8pcERoXiLb7Vy4tSbOR
	aa82x4PDntPy1WYe7xrDU9URflYWTZZXbiYpEu3x9itJRiw9/qeRKbRF5meN4FDX
	eHRF/0McLSziPJGkYhAhL9nKQupncnrXWF5fPM1DP2IFBBR31RU0gRr3H8x+3iuN
	9ERii2ifyFxZZGgqHj+lsjychiw4V4MlaBgFV1dSI0+F9fPlVYuydCCjadNSYl0a
	x+/q+y3syWZcK/w7HqtdQy4nVRAoULHBxpqx3cXIv2MGa81KfmVxitsP/wecjPVW
	D2tI2u4MyxEO1T7FY6xQ9z0sSOhi0Wa/yMp0Er3gQwW8TjS9E3IDATBcpmv8Z0yQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa1314-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 15:16:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PC68IX004387;
	Wed, 25 Mar 2026 15:16:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d28c26sgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 15:16:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PFGPin46530934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 15:16:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3027F20040;
	Wed, 25 Mar 2026 15:16:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E170B20043;
	Wed, 25 Mar 2026 15:16:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 15:16:24 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 25 Mar 2026 16:16:18 +0100
Subject: [PATCH v6 2/2] PCI: AtomicOps: Update references to PCIe spec
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-fix_pciatops-v6-2-10bf19d76dd1@linux.ibm.com>
References: <20260325-fix_pciatops-v6-0-10bf19d76dd1@linux.ibm.com>
In-Reply-To: <20260325-fix_pciatops-v6-0-10bf19d76dd1@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: VwmHIEthOOEXBIOUMOhdt2WMoFnPH4Dj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEwNiBTYWx0ZWRfX3PbbJQ1k+U/+
 gmKijxUsLKuQVsbARuhI5MqqvyN1nbjaVzHfPVzfxBK9Z1qOy9Vads9JBFit9ocWAQEuM8WlivJ
 wXK8zz4RDKCxmuRHs45A3qlxhw4/Zs6v9bTSK4e+vYwDw0OUQmyK0S+V6tg/J7u94n2w0cUt9i7
 lQpSIc9DXQoYT+XLHGCFekoRV1GjXUilCnlI8P/FXTwRUhRXNv8sc7VQMT5NeNxuKZr8xS312Cf
 eZIAEhNJicXr0DseQ1f0XJeZaUnXGg/LS0eRtW0oXiezxCpLr+jO++z6KSA5yNtHwuCZqfI6F5r
 HBAlwYxJG8WEG7pIxacaSwS6bGNUkxY3JoRoa/nBHE4rIF+SNsw5xnyVx9FsPMZ/rYUQFEqB1Hm
 aUp+oy2bzxRugeIPfibNSh3m9RZtO3hO8mB+7HJEqmKrzOv4q5GMJPurSI3MRH2dZQ8mx7GZn5z
 xod4jRxBgGn5/BFSmZg==
X-Proofpoint-GUID: J2oMZxSS8Q3GN44Y4yOuo_IS5f3AHtID
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c3fc4f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=sHiWSa_0ZEpyENxDyHEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250106
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-18638-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 10428328162
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
index 006aa589926cb290de43f152100ddaf9961407d1..fc211af0b6361cd8f5101b681a97bd1ad1304d9d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3694,7 +3694,7 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	u32 ctl2;
 
 	/*
-	 * Per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable bit
+	 * Per PCIe r7.0, sec 7.5.3.16, the AtomicOp Requester Enable bit
 	 * in Device Control 2 is reserved in VFs and the PF value applies
 	 * to all associated VFs.
 	 */
@@ -3705,9 +3705,9 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
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



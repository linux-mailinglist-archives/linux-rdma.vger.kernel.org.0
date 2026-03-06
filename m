Return-Path: <linux-rdma+bounces-17614-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPk6L5QNq2k/ZgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17614-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 18:23:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A24B225FC2
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 18:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7C16307528E
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04641163E;
	Fri,  6 Mar 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rT+ENp9n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21F301016;
	Fri,  6 Mar 2026 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817255; cv=none; b=BauRc3VQU+Ls/1BuOsD+B6v4jjx95F8n1PqfyczmcECjE4kpwnUCmuHfqx0dqspQEUKWy9qAIlVlyhxBpB2jscdPjmui8X4vqVSmxFxG0YlVx81xy/Ou1BCZnZPku116xXfB7OVcmb3wPdtp1JnOzNK+sDaVQ/zHXb7PkKZFHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817255; c=relaxed/simple;
	bh=sC0UA3HGh+vvY+glSh0Z1KBEsW7LssAg4KQrcg3e2HM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=S4zucfdPxCFoI4zlV/69v52tfoGhHYxtYp+rDEmCJ5Di68I8vGsFcr30GmckQh1wbqsrBPrbReKMvc1WIj5IUgwyLmitWzGM7n7NwGSjfusVmf6I8e7NJXtVjR9wHpjoQEPsp8Z6A9Mk5wTEZMirBWNMr8iPeyMoVhymgIdsZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rT+ENp9n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6265G3jX2966823;
	Fri, 6 Mar 2026 17:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=zqF2tgZOu4+g9WSY2jpKPjaKdyyB
	itdYIpnUb0kkSb8=; b=rT+ENp9npbs9xC1Yq5iL4ucDCmHUpZhXExy4fkTiwxeD
	Nuicpbx7u8DiiNHopqlphWbGCwJsh1hIwqro+MUOvxmFbksdNtsLl14T4hgy6jBi
	eL1TuP53hZMHgO9+msdiDWyAgm/CiWF1EUsyWMJsys+RaOneFJxK2AaipmDLHxgl
	P7jwixcZHlk+X9bx9yQOAEQjgAKG36M5OWOTnzxtZmgjaYio3XoPM76CbMPY5qj8
	udLbJxl1it1Ar/QpXgGnBHhdhD2V7v9H7fg72KMJdFd5YjjXb79LLlCUd3UGbd7n
	Y3LQsQ4Nbt8g1C/WtaG5Mx3I5bX533aLvBrNwbitFw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskd9mje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 17:14:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626DFfFu003201;
	Fri, 6 Mar 2026 17:14:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2ygvm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 17:14:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626HE4k027918700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 17:14:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D51332004E;
	Fri,  6 Mar 2026 17:14:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A42182004D;
	Fri,  6 Mar 2026 17:14:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Mar 2026 17:14:04 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH v3 0/2] PCI: AtomicOps: Fix pci_enable_atomic_ops_to_root()
Date: Fri, 06 Mar 2026 18:13:57 +0100
Message-Id: <20260306-fix_pciatops-v3-0-99d12bcafb19@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFULq2kC/2XO2wrCMAyA4VcZubYj7dhBr3wPEVm76AJuHe0sk
 7F3txuCqJd/Qj4ygyfH5OGQzOAosGfbx8h2CZi27m8kuIkNClUuJRbiytNlMFyPdvCipKrAioz
 RmEE8GRzF/cadzrFb9qN1z00Pcp2+IYnfUJACBTUmr+q81IWi4537x5Sy7lJjO1ixoD6Akj+fB
 BWBBmVGe12Soj9gWZYXnNw6he0AAAA=
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
X-Proofpoint-GUID: tSUQ0VflUwKyYu-21dE9ye7pIvfZXIQ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE2MiBTYWx0ZWRfX9AWxr+yUj8zN
 PSXhdYfOHWIGXToEllsf1uJ8DB4OOBN/Dl8fNTSVqeNX3GIunNwyo/bkBzMOQw9IcsplpHNVC0H
 jJJZEBSfz4BjVxfzVJaUy49LeasL8SAlAvBWCE+/URaF2cSjWLvEvCcmrY/+hG/er0tH7mustpX
 8O//M+J2FlgDAwr17vhEmiiq+atrYidEjzyht+rPoSGhSSYnnyL75cpSWuUKV1w5Vw+ziY61D8c
 XwG6I+gUzR71r9Lh/UMLogbsRVhWByZ1TwagiCbMlpLsAXP2roDpIZSk/5QZ7NlTZqd8CDSq/rU
 rBG7+UKj+nsF1InuOBcShfGpr9o0wbtxCJIED+yD9sSI0WBp8+KrfYw/jCjODUzCRpkSV2viNs8
 Gjn+LQvSqPZdxo2XrV5CUyJGZQgwZfDSNnxD34XukCgtAtZPe8Y8Rko43tdYQhBZBK8aHfk73/p
 Zxc766MKqnBop4I3Ggw==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69ab0b62 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=AXBlPMOSM4AmvKD3g9wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: T7KQx6Fzn0zi_m8NhBWvjPqEaQu8ZwtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060162
X-Rspamd-Queue-Id: 5A24B225FC2
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
	NEURAL_HAM(-0.00)[-0.956];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gbayer@linux.ibm.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17614-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+]
X-Rspamd-Action: no action

Hi Bjorn et al.

this series addresses a few issues that have come up with the helper
function that enables Atomic Op Requests to be initiated by PCI
enpoints:

A. Most in-tree users of this helper use it incorrectly [0].
B. On s390, Atomic Op Requests are enabled, although the helper
   cannot know whether the root port is really supporting them.
C. Loop control in the helper function does not guarantee that a root
   port's capabilities are ever checked against those requested by the
   caller.

Address these issue with the following patches:
Patch 1: Make it harder to mis-use the enablement function,
Patch 2: Addresses issues B. and C.

I did test that issue B is fixed with these patches. Also, I verified
that Atomic Ops enablement on a Mellanox/Nvidia ConnectX-6 adapter
plugged straight into the root port of a x86 system still gets AtomicOp
Requests enabled. However, I did not test this with any PCIe switches
between root port and endpoint.

Ideally, both patches would be incorporated immediately, so we could
start correcting the mis-uses in the device drivers. I don't know of any
complaints when using Atomic Ops on devices where the driver is
mis-using the helper. Patch 2 however, is fixing an obseved issue.

[0]: https://lore.kernel.org/all/fbe34de16f5c0bf25a16f9819a57fdd81e5bb08c.camel@linux.ibm.com/
[1]: https://lore.kernel.org/all/20251105-mlxatomics-v1-0-10c71649e08d@linux.ibm.com/

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
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
      PCI: AtomicOps: Define valid root port capabilities
      PCI: AtomicOps: Fix logic in enable function

 drivers/pci/pci.c             | 43 +++++++++++++++++++++----------------------
 include/uapi/linux/pci_regs.h |  8 ++++++++
 2 files changed, 29 insertions(+), 22 deletions(-)
---
base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
change-id: 20251106-fix_pciatops-7e8608eccb03

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>



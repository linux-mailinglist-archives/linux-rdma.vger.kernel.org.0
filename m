Return-Path: <linux-rdma+bounces-14039-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B53CC07842
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 19:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFEB3B138F
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Oct 2025 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6734165A;
	Fri, 24 Oct 2025 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FU2e9WFS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB820B7EE;
	Fri, 24 Oct 2025 17:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326326; cv=none; b=YYVEecPdPRfUCmmHxb02Wy7FTmcTvytULZvoKEJkYEIyPxX1PoYVplylb63+3eRH8ozL+IxVC9mAXiXMCm01LE0DeQHMteiSqChePxnrqoL/oL2wcz4/uJ1iDVp5+VDGLN6r3HBcaY+G9NfkJdPmPOGhhf2K85dnl8JBt/k7dJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326326; c=relaxed/simple;
	bh=AfNO7AfHAlXPgGj2alUF63tnjUZwheK/G4fxmFfbuGU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=emCCX0s67ParODBs2L5rUD2y1rkQ5fEz5PX2/ONaTpfnrWmkk7P25wNFkLguTvHKfbwtOBiToipEAi7QQ/feSs6yYcacvqM8o80GI6JUQMHub6Nk8o7p5/nCou5Cz8vRtvISopI9Lgnw+zNHR4UGgghWPdp5rmRgaMPwkYgUnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FU2e9WFS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O9M8NP022673;
	Fri, 24 Oct 2025 17:18:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=AfNO7AfHAlXPgGj2alUF63tnjUZw
	heK/G4fxmFfbuGU=; b=FU2e9WFSuanBEWZnLCWH0oQ6cRdU7wJ4glP2NXRhPl34
	jC6HibO/bvkNRJh1pxg+9/xAeAQFhlCBRffzoNFCEq6/k+QFRi+gy5X9dDLEMYuY
	rXn58xWFRrcKHMK5c2+K9yL/WxFzy+PrbpoXMOsOSbf9YfZDeMHpLgEBLoStZ7rt
	7FzUmJJC+2FcL+vzzGxmxxB/Hm7tX52xG7K+RAaF+yz3zxstyrwhYLFjqnpdpDJC
	hA+PI+DebPY/0YyOU0rsUV0QdM8E9zvfBQ6PzGVM2oLP/2Jylt9bAZO9sbbLSG7S
	t7r4w/wZPCnOj62yGrdo+rqEwBvGlN8RP93pSqkCCw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33frgmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 17:18:42 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OHIgl0007092;
	Fri, 24 Oct 2025 17:18:42 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33frgmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 17:18:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OF2vWF002488;
	Fri, 24 Oct 2025 17:18:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejv0an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 17:18:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59OHIbQL36307422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 17:18:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BA3D20063;
	Fri, 24 Oct 2025 17:18:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F19F20043;
	Fri, 24 Oct 2025 17:18:37 +0000 (GMT)
Received: from [9.155.208.229] (unknown [9.155.208.229])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 17:18:37 +0000 (GMT)
Message-ID: <fbe34de16f5c0bf25a16f9819a57fdd81e5bb08c.camel@linux.ibm.com>
Subject: Q: Usage of pci_enable_atomic_ops_to_root()
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jay Cornwall
 <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Schmidt
	 <alexs@linux.ibm.com>,
        netdev <netdev@vger.kernel.org>,
        linux-rdma
	 <linux-rdma@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Date: Fri, 24 Oct 2025 19:18:36 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fbb4f2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=Z-1Y28NNKDyCUGFnF4sA:9
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: fK4NLzhJfZTh9VHByR2TCJIr_TS86hca
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1LYYjiKSGxY0
 FkpQcKoe0qatc1Dai1NsWu+wXNE11/bsfg/VlBov5YYC9ty6ITM8fco18Tn5ZA1rmGybUT6WCaC
 j7zPmVuDlCwEsMNqeF9d5Qj+L9QrmDMYmpVVk9duH+/KuvvKVhdiXoH7sZWt1f4YylvsXg11zRk
 oZkJDsc2E1rYca6f8sZYZlR3xnjF3YrXsqmdO4ZpF7qBK8PcedITq+huJWqTp48oOzJYZJtE9uI
 rvg5HJFaLuEy5iSEPd7/qkn5Z4omVYzLnH61FjmDTj926UIPRAXTWa8CXbTq60p/B7MnAX6WAY5
 ABm81Jxbt4gUVfqJbW96V5OYIzLay+BS81DL6Pdq42PV4Pjb0zmTvwIA9qiL6AdriaOVuC+x/On
 5Npm4Wi+wfs/GZBTJhYFBU4ql4kilw==
X-Proofpoint-ORIG-GUID: _gIjN8HnxohWXeEI6YacsDsFk70iJyC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Hi all,

I stumbled over mlx5's usage of pci_enable_atomic_ops_to_root() at

https://elixir.bootlin.com/linux/v6.18-rc2/source/drivers/net/ethernet/mell=
anox/mlx5/core/main.c#L937

and was wondering if its repeated calls with the 3 available sizes gave
it the intended result.

I assume the intent was to enable requesting AtomicOps only if all
three sizes 32/64/128-bit were supported at the root-complex. However,
pci_enable_atomic_ops_to_root() would enable the request at the PCIe
level, even if just 32-bit sized Ops was supported at the root-complex.

So I checked other users in the kernel and found an inconclusive
picture:
The AMD GPU that this was originally introduced for [0] checks for a
combination of two sizes, while a few infiniband/ethernet and the vfio-
pci driver do variations of sequential checks (potentially enabling
requests that they don't want to)

Now the PCIe Spec Rev. 7.0 has also a mixed bag. Section 6.15.3.1
mandates for Root Ports:

> If a Root Port implements any AtomicOp Completer capability for host
> memory access, it must implement all 32-bit and 64-bit AtomicOp
> Completer capabilities. Implementing 128-bit CAS Completer capability
> is optional.

While this is specific, marking the CAS Op Completions in the 128-bit
variant optional, the Capability bits just specify 128-bit AtomicOps
(all AtomicOps: FetchAdd, Swap, CAS). Strictly interpreted, this would
require root port implementors to announce all-or-nothing of 32/64/128-
bit AtomicOps - which kind of makes the size-granularity of the
capability bits useless - and leave the endpoint device (and its
driver) attempting to use 128-bit CAS in the dark...

[0]: https://lore.kernel.org/linux-pci/1515113100-4718-1-git-send-email-Fel=
ix.Kuehling@amd.com/

Can anybody shed some light on this?
Thank you,
Gerd


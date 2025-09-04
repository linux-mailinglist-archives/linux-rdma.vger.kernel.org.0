Return-Path: <linux-rdma+bounces-13099-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B1DB44837
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 23:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E2CA48793
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 21:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE8229BDAD;
	Thu,  4 Sep 2025 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h4byn6Rl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFFC29AB02;
	Thu,  4 Sep 2025 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020393; cv=none; b=NWipBOB35PYpCbGUoJAqye999TKtxrbQswF01zkqIC0a4C2K99fbuav+ufGmta25F2xC6AhEMwN1KeRbiN6DGt+oRVhqUor6q7G0nYfB+87s8Ffs2294Aqn7Sq4qijBLfEszdzKxbQNw8lzks+pe6D2F4sqobAumvLgzXJDZZlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020393; c=relaxed/simple;
	bh=cJeYw+fnmGuV/6yhEDTOpXJYJivHESINJnODijfUJeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJNtsJhK8vsw3gpLuceJIqzJAx4bo7OPJ/0l7YHMQlBLlr3WZIosmGHL9ptSXlKw3+EZDb7qW0Vbt/R0qa6/acZ9uz+ggxxYBNq32VXKm9Bj81Fp9P8N58nztmTMdhaAv1UM3ViZ04nO6ePZ+YiPdQLRpqe1nGe9pCSKHz8+lbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h4byn6Rl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584EDNYw020235;
	Thu, 4 Sep 2025 21:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=gGSz/3wzTB7ULIot6d2uI8FCULkYJSh7CX+787MXO
	VI=; b=h4byn6RlpOx5ytI43RfSm5XhBgP3sgbYbqD4FmYQEwY6Fyf49G5xx+QPv
	tQgvUjTB/WB71enpUwZyGJHjp2jy/AyjhJkKs04/lNSoyVrY86vXvsCLFwNiYGgr
	zzlB2eSg1WYWIytYb2/4sYBsLPizFbM3edNkyVGt7ICKPVnFuN/Hcy+1T47twXgW
	aLdCYjsyMhzDMsJffvXI3WMAFI4mPDTuqGlMwUw8oyf31abP6goXM02H45nlLtX0
	6g9N9uo0GP0Nl/ED9mT5m+xbSNwOONt0d5ZDsypDey0luSwy3aoKl6s7Gl8H2GER
	LpXfZU0BTgXJmEe8f3YajiKnpXRIA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3cs3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 21:13:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 584L77Lr003791;
	Thu, 4 Sep 2025 21:13:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3cs3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 21:13:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584J2KhP021170;
	Thu, 4 Sep 2025 21:13:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmpxfn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 21:13:05 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584LD1e661342030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 21:13:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FADC20040;
	Thu,  4 Sep 2025 21:13:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E6962004B;
	Thu,  4 Sep 2025 21:13:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 21:13:01 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH net-next 0/2] net/smc: make wr buffer count configurable 
Date: Thu,  4 Sep 2025 23:12:51 +0200
Message-ID: <20250904211254.1057445-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0N7XCAWMBfEUIccWqvYX4h1yw78u_pk2
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68ba00e3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=OPAOpny1AAAA:8 a=piJGGMyLFvZckxoXyWEA:9
 a=Vt4qOV5uLRUYeah0QK8L:22
X-Proofpoint-GUID: qbasB6_8y8NRLwbyo1x5bU3BRhdVeJoR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX5fgMXwX73yyl
 /tNGGMedGYSG4BCjH6gySXDmbq0K1RRZzjHsORObH+dInnYbJZHqkq/r/q46myRS5gK9T80Ieh1
 9Dki9g66Sr0HJnX/LeDHUhuFWOpJGpdtKEVTzEoi/J13NtqBibFSYiGc5tPghXMTh8sbi5nFKG2
 ZkDoDa2hXe2LxKCuPGUbcJvzYScVNrJPTt/9ckdoLgMjUQgLnfYu+KoQPvBZh7tnaTJsczsys0I
 875M6VBsIy7IeBf1uok+mlShVufxTfgPnKuJg1WRXstyr2Acn033N49gCiPcbrlxv69oIwSepx2
 oqQ1SHTHgYsPtgl/cGhX/evbO3zhLtdxvePYxm4w20SUaKl3JkCNnAjTbNFummK2p6RJKNyx8qW
 u6QOK0tL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034

The current value of SMC_WR_BUF_CNT is 16 which leads to heavy
contention on the wr_tx_wait workqueue of the SMC-R linkgroup and its
spinlock when many connections are competing for the work request
buffers. Currently up to 256 connections per linkgroup are supported.

To make things worse when finally a buffer becomes available and
smc_wr_tx_put_slot() signals the linkgroup's wr_tx_wait wq, because
WQ_FLAG_EXCLUSIVE is not used all the waiters get woken up, most of the
time a single one can proceed, and the rest is contending on the
spinlock of the wq to go to sleep again.

Addressing this by simply bumping SMC_WR_BUF_CNT to 256 was deemed
risky, because the large-ish physically continuous allocation could fail
and lead to TCP fall-backs. For reference see this discussion thread on
"[PATCH net-next] net/smc: increase SMC_WR_BUF_CNT" (in archive
https://lists.openwall.net/netdev/2024/11/05/186), which concludes with
the agreement to try to come up with something smarter, which is what
this series aims for.

Additionally if for some reason it is known that heavy contention is not
to be expected going with something like 256 work request buffers is
wasteful. To address these concerns make the number of work requests
configurable, and introduce a back-off logic with handles -ENOMEM form
smc_wr_alloc_link_mem() gracefully.

Halil Pasic (2):
  net/smc: make wr buffer count configurable
  net/smc: handle -ENOMEM from smc_wr_alloc_link_mem gracefully

 Documentation/networking/smc-sysctl.rst | 40 +++++++++++++++++++++++++
 net/smc/smc.h                           |  2 ++
 net/smc/smc_core.c                      | 34 ++++++++++++++-------
 net/smc/smc_core.h                      |  6 ++++
 net/smc/smc_ib.c                        |  7 ++---
 net/smc/smc_llc.c                       |  2 ++
 net/smc/smc_sysctl.c                    | 22 ++++++++++++++
 net/smc/smc_wr.c                        | 32 ++++++++++----------
 net/smc/smc_wr.h                        |  2 --
 9 files changed, 115 insertions(+), 32 deletions(-)


base-commit: 5ef04a7b068cbb828eba226aacb42f880f7924d7
-- 
2.48.1



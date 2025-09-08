Return-Path: <linux-rdma+bounces-13164-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13427B49CA2
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 00:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8951BC05C9
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629F2E7BCC;
	Mon,  8 Sep 2025 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KG8awAPp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4A523B61A;
	Mon,  8 Sep 2025 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368935; cv=none; b=JMVSIk7abRjsB97AsNDxpX3TakOT1LOJMnCJcAcmswFHwFzWtPE5X4EgEOW92HKvA8mGYOyvcUnT2jwuAXs+k8RhRQdsg2TIspeiu2/Qb3l/JRxYg1OJ3FDDX9mqssN1KJGZVL3YHmYb0qGMmMY5XQzPEBfqVEkltwoeQ3VIEyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368935; c=relaxed/simple;
	bh=hhE6RGL+FRpzFdGhBf7AK1KQErFfrcOxy9ye5CpwxNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWLJ+tZP4YoTlIDwlVvJ9AA/kpuC/wiU+n4vcJ1QFR6M/8Nm9wB6/piZ5i/7qvzqn0J6pvr1WF/NLtY+Kn2B4fnDvL6+xtDrtlB83iXptlI5PNEzft7vkc345Jubyfeyuyy1NcXkcVG64j0stuRNweaOuNBhDMd7GA0T6ZgF2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KG8awAPp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588HsGjK006469;
	Mon, 8 Sep 2025 22:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qpbTHU8EIW3qhR3cjrpx1set9Uut6u/PXSeZfaBSi
	UM=; b=KG8awAPpy/C8y8G7pcV5X4hzRXpOUghByGPU04rmEVwNGpkvEmBFtmduT
	0HC4ecesu04ME5Gh4+nKfGd11+bGuZc1Zwm1fsQnjy/5yVCkHM0KiTXqheZzB8Xi
	POcJ8dNBh9mOEbRfkOSkF88yvRA4b8qhfQUqwuMbzaVdOztxftyPubWb+rXJ4wDS
	tWOg4HhHKw26sZrtUKyFsuBacT0YEsUAg1SJfcnLdWAEpIaP+GezXzkbpgWMi9V7
	uUclB/POEwa/DO/MyeYgWlFdz4lKLLjoxpX/9FchUoXUrJz8CLPUfPdT2AqqDTcM
	aNTxUWEhXFtx8hI0ZcTAkEs1wKMZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwm43j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 22:02:09 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588LrKxp027864;
	Mon, 8 Sep 2025 22:02:08 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwm43a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 22:02:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588KC61K011435;
	Mon, 8 Sep 2025 22:02:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9u8b5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 22:02:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 588M24Vk61538686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Sep 2025 22:02:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF4F20040;
	Mon,  8 Sep 2025 22:02:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADBA820043;
	Mon,  8 Sep 2025 22:02:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Sep 2025 22:02:03 +0000 (GMT)
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
Subject: [PATCH net-next v2 0/2] net/smc: make wr buffer count configurable 
Date: Tue,  9 Sep 2025 00:01:48 +0200
Message-ID: <20250908220150.3329433-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZvQu3b2NvW__VhgPLhLqlyl9HpPgnH97
X-Proofpoint-ORIG-GUID: gtQ_0s5TQzq9r25UlxbXbPysDtje5wda
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bf5261 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=OPAOpny1AAAA:8 a=vF7HM7XGAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=piJGGMyLFvZckxoXyWEA:9
 a=Vt4qOV5uLRUYeah0QK8L:22 a=bNn2QJc11pDkoTYzAKk6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXxlIICvURjiWB
 1Cz96MRYfonkWO8i63gCKHPysWKwCzMbVrW93SYq+Qle4vnGNs5YUxwNCjsbjomitPms7p/TCJd
 TRdPvmTox6zp4KaCBLPvIOLLOVsQNKVMVCadK0gHjZDp8ioTDtVu84pkWnJ3BZ1qLNxYEg4UORQ
 7A0UO92puRlWP61kG38eoSHgRNpBdg0NIpFG1AI8cEZEzYRIoCWNdKP1LlDEgHWOTdqh6E1o0gy
 x0GjXacKyA7lpL0e2uwBNxPAJt7nwDvITRhr4uj9JnLiQr7uXO6BUqvZqM3CrhVzkThr4chzuU/
 IM8R//Mue9lOkkowbi5cGuHA/ZTABKIlUmwie197k7fokePIlItP2kMnAAqRBWTFAulq/mP327l
 CVtsbWxG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

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

Changelog:
v2:
 1) Fixed https://lore-kernel.gnuweeb.org/linux-doc/202509070225.pVKkaaCr-lkp@intel.com/
 2) Inspired by 1) made the sysctls namespaced and moved the backing
    variables into struct netns_smc 
 3) Use tabs instead of spaces for alignment in (Dust Li) 
 4) Renamed the sysctls form smcr_max_*_wr to smcr_pref_*_wr (along with
    the affiliated fields/variables based on the discussion with Dust Li
    (although maximal is mathematically accurate preferred is more fitting
    IMHO). Should the community decide tha max was better I can roll
    this change back very quickly
 5) Removed Wenjia's r-b form patch 1 as quite a few things changed
 4) Add r-b from Mahanta I forgot to add in v1 (which remains the
    same moduo rename.
v1: https://lore.kernel.org/all/20250904211254.1057445-1-pasic@linux.ibm.com/

Halil Pasic (2):
  net/smc: make wr buffer count configurable
  net/smc: handle -ENOMEM from smc_wr_alloc_link_mem gracefully

 Documentation/networking/smc-sysctl.rst | 40 +++++++++++++++++++++++++
 include/net/netns/smc.h                 |  2 ++
 net/smc/smc_core.c                      | 34 ++++++++++++++-------
 net/smc/smc_core.h                      |  8 +++++
 net/smc/smc_ib.c                        |  7 ++---
 net/smc/smc_llc.c                       |  2 ++
 net/smc/smc_sysctl.c                    | 22 ++++++++++++++
 net/smc/smc_sysctl.h                    |  2 ++
 net/smc/smc_wr.c                        | 32 ++++++++++----------
 net/smc/smc_wr.h                        |  2 --
 10 files changed, 119 insertions(+), 32 deletions(-)


base-commit: f3883b1ea5a8f31df4eba1c2cb5196e3a249a09e
-- 
2.48.1



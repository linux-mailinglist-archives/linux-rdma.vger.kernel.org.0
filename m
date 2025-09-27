Return-Path: <linux-rdma+bounces-13683-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5CBBA64E3
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 01:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46E317E9E9
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Sep 2025 23:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E624467A;
	Sat, 27 Sep 2025 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SMyPM4rg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01CC242D76;
	Sat, 27 Sep 2025 23:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759015328; cv=none; b=b+1KiT2QHU58AqqIbBMXj1jwTSbvld8dc6ZhfV4SV01O39adCz/2iSr2cd1pHRd1RloyiU4q48R1GUl/GN5nus636GJ6acgnLXmiFBlSS3tQPBZPyzDajNTQd8E/81SqE5VWohpe+YOWuQLdrqsU/OI7JYm12Pnc1qiLpZZMmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759015328; c=relaxed/simple;
	bh=nuuwxGP7lH4Yh/FVa9IqHS0/3jDUp0lUMzIBTQ9N0Qo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KZtpiKGQ0xS0vDRnhpBM+dvxa/lLQwdewvj2xXA1EezqyjfyrCuAkI60h4uSy1+O/jAI7rKrSOFH5rdTaA/VSncdqMktpzuMKxsGX1UICJFaR7fyKNwWLP5djHbHc/j6E7HQFVRCKRKUvAFs550mxghRoUXOofjIMdhTV47lHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SMyPM4rg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58RLJE31010719;
	Sat, 27 Sep 2025 23:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cKtaW3JXyhcEJsSU9Q/ZGCXqMZKcv9aJSdQgar5AU
	sk=; b=SMyPM4rgIofCwmi6bkWrSTWBqTC/8skdxdQppfilTSeuqUsErkw8EB2ym
	ck+xzEygNUzP29Whoe77MmlaY7rd2mrAohFq8gb/fmjICYydgUZMeB0afeMX6TXY
	gJ0a0T9Iuxt4YaCYAan5eYnnJfT2G9BE1Q3ujlCEXP0l2rHbD0Du0WP5TmvbLGRc
	r0V5jUy0ez4PTCkMMqy6Z51M8QmVLH0rBW+PmHsE/lCbbcKDaiQZX7QfW98qNZgo
	ffEl4dIv4Qh35ymRb88x3MHbdk7J9i+nhL/JDT0njMAenEkCfYTCp//1oMLWEsLd
	z36N7gwdHe7bmCKezDQO8OrNMzBig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e6untf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Sep 2025 23:21:52 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58RNLqUY030562;
	Sat, 27 Sep 2025 23:21:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e6unt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Sep 2025 23:21:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58RJxQll023758;
	Sat, 27 Sep 2025 23:21:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49ddbda5c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Sep 2025 23:21:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58RNLkVj46268896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Sep 2025 23:21:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80AD720049;
	Sat, 27 Sep 2025 23:21:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DEA320040;
	Sat, 27 Sep 2025 23:21:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 27 Sep 2025 23:21:46 +0000 (GMT)
From: Halil Pasic <pasic@linux.ibm.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH net-next v4 0/2] net/smc: make wr buffer count configurable 
Date: Sun, 28 Sep 2025 01:21:42 +0200
Message-ID: <20250927232144.3478161-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IAhUJsWLZSKfjtrkPHBCZN60MbCZ_ItN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX6DWqHWtGC2NY
 b53z49SeZDVV3RIugdxqw5a3lRqzLgVBEZymAGhyrOmvfE3m53L+22bh5S9zXQwhMvwCtrSTvgT
 ql8djtlhoU8YWO/+oXZjCpGQehuPnU/ppLLYFcUODN3UcRp98zs1H+Uj107Cz7rzyco4cqjbQbe
 nCZhEjF+J73GINppY1xQ82cm+cdsZhxU8hcALA73JJ2VJCy+NuGHXhFqXIarVMSi8wkbrJaq2jM
 p9adA82Y/nlsW1ZRrVN6TFEaXz5HAa/P6Oy6P9pogbaBn5nLiAx0BOv6G8hszys1mbf9blN17iP
 XxdsfymUT0X9+TNkVFztAOlVcxC80C2ax+VG0HYAkVtMrmr04ZglZygWwHZwEuaANDsSp0q1pmH
 LGvOs6fWwAqapcRuLTEYc18qmRmF9w==
X-Proofpoint-GUID: 4-biHiXiClGR2u2_Q_8OxjKDpaMDXv8e
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68d87190 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=OPAOpny1AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=piJGGMyLFvZckxoXyWEA:9 a=Vt4qOV5uLRUYeah0QK8L:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020

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
---

Changelog:
---------
v4:
 * Fix ungrammatical sentences in smc-sysctl.rst (Paolo)
 * Remove unrelated whitespce change (Paolo)
 * Add comment on qp_attr.cap.max_send__wr (Paolo)
 * Reword commit messages (Paolo)
 * Add r-b's by Sid 
v3: https://lore.kernel.org/netdev/20250921214440.325325-1-pasic@linux.ibm.com/
v2: https://lore.kernel.org/netdev/20250908220150.3329433-1-pasic@linux.ibm.com/
v1: https://lore.kernel.org/all/20250904211254.1057445-1-pasic@linux.ibm.com/


Halil Pasic (2):
  net/smc: make wr buffer count configurable
  net/smc: handle -ENOMEM from smc_wr_alloc_link_mem gracefully

 Documentation/networking/smc-sysctl.rst | 40 +++++++++++++++++++++++++
 include/net/netns/smc.h                 |  2 ++
 net/smc/smc_core.c                      | 34 ++++++++++++++-------
 net/smc/smc_core.h                      |  8 +++++
 net/smc/smc_ib.c                        |  8 ++---
 net/smc/smc_llc.c                       |  2 ++
 net/smc/smc_sysctl.c                    | 22 ++++++++++++++
 net/smc/smc_sysctl.h                    |  2 ++
 net/smc/smc_wr.c                        | 31 +++++++++----------
 net/smc/smc_wr.h                        |  2 --
 10 files changed, 119 insertions(+), 32 deletions(-)


base-commit: e835faaed2f80ee8652f59a54703edceab04f0d9
-- 
2.48.1



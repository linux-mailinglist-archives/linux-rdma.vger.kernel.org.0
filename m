Return-Path: <linux-rdma+bounces-14080-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB57FC11E3C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 23:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C56EF1884AA4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 22:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC2032E140;
	Mon, 27 Oct 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="itMBx5My"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D483128BA;
	Mon, 27 Oct 2025 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761605357; cv=none; b=LBoXU4OSz37zlXwlmbZQGwjndzV7qPGh3yNHld0csQCdiRio+zcyc6ySz3TVrA3oE/5NpQKEO6qJlvpSan9rezUR1l9JO2AwIw2DmTYZCSCs7UATTr6u0I8KQSxaoDuivWVlUSU2+TH74wfvPpcUtO0w/YqYDs99Mqsra0VWYeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761605357; c=relaxed/simple;
	bh=iA2KzMAXzjS0dvEBVNewkroSRiQXPtFeN4k5LUgsyeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gea2futsmcn3BuGUeJAMjIRyy1h9Bte4x5c1L/NUVajT9NBPsL7DyFsCJm1X5++MYi/eOPdPkSH7Z8D+v091OyGdn+Mw1Wi99hhi3mRDSukMyiM1LXh3H/TU230p+y3D9boht8Vw3Fxsf6dtejMLWZ8T30RmmcGDZgjE0eh4JOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=itMBx5My; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RJV5Au013020;
	Mon, 27 Oct 2025 22:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=niEgPNdK73IG2K9RPRq+Bi/ZJzkx+OYfS2ccysrNo
	JA=; b=itMBx5MyOY4wiORNCrtX5DhEw1SeNan3hB4c5c556+DhfHk+ugLJGiC3u
	W97WX4GOajkCS4pubrQmSG0uUYa6Ime/9Cn3LA9jg3IpVUYGxDtqp2hbU+FuR+EK
	P20bkjrqFYJYQANbPzxJ22YBwhWZzMyxXWgnfxZ2d3zszcATrJQalj8NT6bg/hKA
	zrGUddY8afq4eHQ8brqG/j4MruZhZ7jXZew+fyZLb4UQOLLXWUe3oGpS6aOto/SB
	7IBevKz+t/hkCLfM6lXfHYhet24Lu/HpnKxrMI90KA1GdedL4bXn6dfzuYtjkz2k
	rvZXmHTrV2cOp+LcltlmT5z51ZHmw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p2916kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 22:49:04 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59RMn36n009832;
	Mon, 27 Oct 2025 22:49:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p2916ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 22:49:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59RJL9kv006806;
	Mon, 27 Oct 2025 22:49:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1bk0ynsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 22:49:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RMmwJe43975158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 22:48:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48B9420043;
	Mon, 27 Oct 2025 22:48:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05DFC20040;
	Mon, 27 Oct 2025 22:48:58 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 22:48:57 +0000 (GMT)
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
        Tony Lu <tonylu@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
        Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v6 0/2] net/smc: make wr buffer count configurable 
Date: Mon, 27 Oct 2025 23:48:54 +0100
Message-ID: <20251027224856.2970019-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX8ILttVUODp08
 bsCQK7DdXenRX73MHgW5xg56/1B8u6iTNp622guvFhHKwBPltoDBX6LWZdo8hU+l4kqX4oC/nHT
 QoGwZwuPQ+IUZwhimZ2cnKywFkvxdgy9eUN56SCJFh3PCDjHCIbwI3Pli7G1XslpD6DxOpvocrK
 nYPlJWP3Nq/icuz+Cv2OM2D6zlLVxYOY08YO9tb/wCzJkF4jseKwtN0aKrTgR8ZxmuZelGRG2Li
 8DO3S6TiDWorrTZeJqQSrgWPHZXg3Mpghb6lXuUKBJdSZ+4INU/OquhrE4D8jHVd8c+RNe3H3Dk
 GDGiMMRb57PIhl9A6Fp2TY8Sv4xakCj3/YdazhDjx3nDSCJCC0yyHCiRASQ/TiedxU8sY4U3oDN
 7tDsUZV2m8vLIXVrn+Te9xkWuMWYtg==
X-Proofpoint-GUID: AJzGdb778uBJmh8RMt4_oou7HGpMgsOy
X-Authority-Analysis: v=2.4 cv=V8ZwEOni c=1 sm=1 tr=0 ts=68fff6e0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=OPAOpny1AAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=piJGGMyLFvZckxoXyWEA:9 a=Vt4qOV5uLRUYeah0QK8L:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 7MvIe4UGSYdd4ODUgl0939jlY-IlITLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510250019

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
v6: 
 * Added r-b's by Dust Li
 * Replaced "So called" with "So-called" (Bagas)
v5: https://lore.kernel.org/netdev/20250929000001.1752206-1-pasic@linux.ibm.com/
v4: https://lore.kernel.org/netdev/20250927232144.3478161-1-pasic@linux.ibm.com/
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
 net/smc/smc_ib.c                        | 10 +++----
 net/smc/smc_llc.c                       |  2 ++
 net/smc/smc_sysctl.c                    | 22 ++++++++++++++
 net/smc/smc_sysctl.h                    |  2 ++
 net/smc/smc_wr.c                        | 31 +++++++++----------
 net/smc/smc_wr.h                        |  2 --
 10 files changed, 121 insertions(+), 32 deletions(-)


base-commit: bfe62db5422b1a5f25752bd0877a097d436d876d
-- 
2.48.1



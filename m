Return-Path: <linux-rdma+bounces-13538-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C854CB8E6D0
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 23:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9100D4E196B
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Sep 2025 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC92D0635;
	Sun, 21 Sep 2025 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TmXe8I2S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109452C11FC;
	Sun, 21 Sep 2025 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758491103; cv=none; b=kIE04SRmuqrpNmTJfAWul9ctiS+QPGmEN2nXTs5SUFmVwB0Er1Oqs6aRKq1ROlM0j6ZdaySMxSrAq83qtnU9Pdl+kfx2sXuKedAZMdTH/TofQWgHAfupyC05t4LyahPrsKE04+VrWtavsm4+gTMQmT3/8UIraw6C4r+iR+w+xG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758491103; c=relaxed/simple;
	bh=zTX5DV/aiTvoh1j+UpnxrPzly+mHdoqCnjqcwsVay8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfx0QEsDVGwPb1KPqCBJqchAqO7iD+O5RYFx+cEjipFD988sBzAkZTLC01ycIli4gXpc3Y2oG1RUG/5BbLFx4P9bVyEfRdS9rKVsddrsSR+4226VbI95K53QKxZ44pcSiWpD6u/I/vNIg5ps0sgVYcJVlg5y7URD/FpAMgykf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TmXe8I2S; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L8dJ3P022391;
	Sun, 21 Sep 2025 21:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=h+/IkVWn//lNrkR3o1eZul4QL3mj8/Ds3ViOjtvU+
	Ds=; b=TmXe8I2SI59Vg88mkCKLslaiooAw7XIIoxQOdrZeMMlxi4qmgfwqy15QT
	VBafheu9UCxpb0BQ42Fo9llcFv/N4fe+qSE5AbsQoMkvnVaI7XYf0Lb3E+G8cMER
	LLThRX4bdZGODcBsDpIa01i1K3Y5zKjwpeZ2q/L7OlW4iAJf49LUApkXb/E8tFTV
	EVXQXbwRmxflmZkpb5PMCwW7aRglFunHDdWWI2MCZiWWrIkOVj3cEbx0oD/AbRg0
	BK1pW3Zr5AKVJbj1pOw1pG3/ZHshTJ27R5zRoJ/T4rKLr7catLJio+++2edNvGJu
	Qcxird7Yljb4bmTfl0Q552YxrlRcg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpjy08n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 21:44:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58LLiotK006760;
	Sun, 21 Sep 2025 21:44:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpjy08k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 21:44:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58LIwPWL019727;
	Sun, 21 Sep 2025 21:44:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83ju3bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Sep 2025 21:44:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58LLijxW36962608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 21:44:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B8E20043;
	Sun, 21 Sep 2025 21:44:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AFD120040;
	Sun, 21 Sep 2025 21:44:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 21 Sep 2025 21:44:45 +0000 (GMT)
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
Subject: [PATCH net-next v3 0/2] net/smc: make wr buffer count configurable 
Date: Sun, 21 Sep 2025 23:44:38 +0200
Message-ID: <20250921214440.325325-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d071d3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=OPAOpny1AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=piJGGMyLFvZckxoXyWEA:9 a=Vt4qOV5uLRUYeah0QK8L:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX6LammChpIlK5
 Rl0FjGdl0A2sObnLpkmMkBUaN09iJ5ktrIN/uY56pYaKw1Jb/yzsmZ8wkviepQ9/tdnWk++xR4V
 hhMIwB26l1ZT0fAldIlgexlmkQ7qLtI1wigD2Oa0kN3fucC7wLELEJOKNoo8K1cmmkhEdvXDG5W
 D9O2ta2sAW/O9vjCKDaUejGNVDU09G+ebVzUuPCx1vaqqb5x5eIaV+voix6RwAcB1itbk9NyqIZ
 03/cTDndqW8wvkmUwHKI7kobD+d8BZmgFtDfcpt5NNW2C6Cvi+FOHF2F5J4Fj15tk/qQdGf47ZH
 ib0WPpDm6krZ7QgDlLXOC9jciHZMJM29pj6Q+ZMBiEuJvNdsdXjxdhLdYtsF19sCfRbRRpi5UmN
 /YdQqO8j
X-Proofpoint-ORIG-GUID: EWxjh1-D48bpdiSDUXaGRtF_ZEl7_IHf
X-Proofpoint-GUID: vY-nyu1wOHBr6kuyQP9uTiUeEQFl5TS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_08,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010

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
v3:
 1) Renamed back sysctls from smcr_pref_*_wr to smcr_max_*_wr (Dust Li)
 2) Using link->wr_rx_buflen instead of SMC_WR_BUF_SIZE when allocating
    wr_rx_bufs to not break what was fixed with 
    commit 27ef6a9981fe ("net/smc: support SMC-R V2 for rdma devices
    with max_recv_sge equals to 1") (Dust Li)
 3) Removed unwanted 'this control' in the documentation in #1
    (Dust Li)
v2: https://lore.kernel.org/netdev/20250908220150.3329433-1-pasic@linux.ibm.com/
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


base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
-- 
2.48.1



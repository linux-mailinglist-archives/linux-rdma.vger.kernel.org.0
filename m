Return-Path: <linux-rdma+bounces-13719-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0B2BA799C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 02:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F586176007
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 00:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFFA1C84AE;
	Mon, 29 Sep 2025 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ISK2oOvg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A37333F6;
	Mon, 29 Sep 2025 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759104029; cv=none; b=cFYK+r6Bq8wUIgaYEt0RlHPBDe3wuSxfgQ03K//wPjaMrN67pkBZURb67y2aylcprY8k6LIH49Ai9Qq5zq7KdDZ8mrPd4tpSGX7j9CVZded5VfnIhb7U6jDPI1LG8ls791Xqlds0mRVXdLsQvwmtPe8jROH2hkMIg3sBPwh6HPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759104029; c=relaxed/simple;
	bh=M+8HMW4Fh6OK4Hz/R6zXRnBPy/8QEo2dSANk56c/yok=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kO25ZMEBfWwJZpL44sNVB3IrUw6/kLBdf6EafRCQwzy6rHfIjo3IEcS2ONt6p1vDEROk3FEHENZ2sGDGHQY15T/27tZLtZ8BawhBBI3PxQ+bjm1ehZ65uKYXGPq5t1Z7Wz3HcQlIr6I9Q2vNTYOa1TWSUCRNNLwgwnV/J4EIFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ISK2oOvg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SAkd4H026037;
	Mon, 29 Sep 2025 00:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1CuVaQu2ZLTLPZRT7jm5p12CJZvNLA0UOcK2fl2Bp
	fY=; b=ISK2oOvgrxnijsn/xvCcW+VrPQSGetwotRq6tmFDRcBP9g426uNHxsABL
	Ja1LfygRctYlFDGpACtLRwaomQvpwNBWq4rFGrlfmOlvogZ1JkUo8x1aUhgklP2h
	qg0qOY0sYZUq40rbeMya9uS/DOEK9zYJbb/w3Y8A3lQuoj6+pYafmPmv/Hv3/N1W
	pOoCAys0CRXQ/JIxh4a9mpRiGJXx6DAVT3610z+k+uz+kc/CQJHDSF+BLhpp7ALU
	6ALKWWQ4rbKvYn9ygkqsosA/Muyh63DPFK1is2UtGRWw+zeNHdmOt2VAloS8nfvf
	3WYhUcqBTo1K10CrghE+IBcuWcUCQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e6yaw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 00:00:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58T009v6008385;
	Mon, 29 Sep 2025 00:00:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e6yaw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 00:00:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58SIZDDH007292;
	Mon, 29 Sep 2025 00:00:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurjkfs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Sep 2025 00:00:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58T004LZ53543286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 00:00:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E388920043;
	Mon, 29 Sep 2025 00:00:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 914A920040;
	Mon, 29 Sep 2025 00:00:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Sep 2025 00:00:03 +0000 (GMT)
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
Subject: [PATCH net-next v5 0/2] net/smc: make wr buffer count configurable 
Date: Mon, 29 Sep 2025 01:59:59 +0200
Message-ID: <20250929000001.1752206-1-pasic@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CutAPlPge7EgJjykul8zpkpGuZSW6pCy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfXyY6wFq71PSLt
 UUE0Wq5sOoRfW/SEgTHotPyeXPiexkUSWQ0K9vFbqEnODPQR8F/fwfFI0Jp2RmGedD2yiElYBrw
 p95v2p5fSHAccDTdbTEH0/+t/sVg+8/ahdtvmfqKYQqQTaDqp14Edkq2eRtpyN/k9zyX9KZo2jh
 3J9ePv17iUPeQj5eAUH8fx1fOuX4AC4tzqHZLbxxsoqxI710R0AeEs3TiYbib+tAr+9Ob8pii3g
 cQyagIZZaZsiCnkxUfawDGN14zeTRTRpI1Jm7n5KIKBONkBrl/KB3mtVcmX/PybGgTVtlJ8sSqx
 5f1EzH1oqEoy1wGUMbroyok4K56FOV4n0hlQ03+wpPQP1UV7kn7pXWuXJFMoebh/7MOa2PoQDrn
 nnHYVTg5052pwpQuEdMHwo4pf9w1jw==
X-Proofpoint-GUID: 32lPrucm31XxhfVay1fX8mcyZn2Sgkhh
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68d9cc0a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=OPAOpny1AAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=piJGGMyLFvZckxoXyWEA:9 a=Vt4qOV5uLRUYeah0QK8L:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_10,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
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
v5:
 * Added back a code comment about the value of qp_attr.cap.max_send_wr 
   after Dust Li's explanation of the comment itsef and the logic behind 
   it, and removed the paragraph from the commit message that concerns 
   itself with the removal of that comment. (Dust Li)
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


base-commit: e835faaed2f80ee8652f59a54703edceab04f0d9
-- 
2.48.1



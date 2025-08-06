Return-Path: <linux-rdma+bounces-12603-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD1DB1C8EE
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 17:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0350D565D64
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Aug 2025 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8891729AB0E;
	Wed,  6 Aug 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E6q0EEkh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36CE295DA6;
	Wed,  6 Aug 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494901; cv=none; b=qTsLfcWnh5BrFjgKnvmb3nv3cpiL45gEZJ6+z8NITCAccuviEA+Znc00z5AYPD5y6+4+w+b0hh0j52nTTGTsTokOwxd8tiVdssJa67T9A3zavRoVxP8XJNdQymYds6AwgP8NFKFQk5rMgpXQldjkRCayaSThZhTxzs37OTjWwAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494901; c=relaxed/simple;
	bh=4bdk7AHt9AnV752bP4FvV36lEbjHn3xsjb+eqYfdJjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSwBdw9rGt5T8PSsm8lvMwuK4yUZkAlnqeXu9XkhhO6gj7AD69kRWYIeywr49bLdcdtKTm8Mx47oalJZ4cjYgcHZEh/hktJMWvPOnAK3DAg1tQBeRFnl8MV8bRCEKxTeX+wWHOrwKPBsR3iqyH5Qpqj18oT66RkOVPQdCEwchdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E6q0EEkh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766tOFE019719;
	Wed, 6 Aug 2025 15:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=eFN4NGgkWBcvO2hocpGwDg+ZHAJ9g7nGT0aN/UFZc
	cg=; b=E6q0EEkhWX+YlfSJzfMBBY+ioUHgmpeU6KTXuvtwr7lH+U7Y9ICj3aXdS
	pvReu4Ew/6lsNrTfYq/3zwyDaMg7fC2V3IOYQs2Xop2EJuy3hSsSJWxSJH0EBbXi
	cX+N8647hbEL1VP8xc8tTIs5Vcwgjo4tWJKxy9nIzjCOfhsjap7tKOK7OgX6OZm8
	mTxzWZ8sarKMTJDuu+PMierTjrFYJRD5Oz+PloG05MQ41JzilEC5+b7c2C7IeyKI
	6FegoyC5ucTdYwK+t8wCxjg/X++gkzQ3H3XPabwUTqC8R4i2S12Vn2GpMcPm9rih
	UmK1Ns1hzRVGxUZIqXbftjZT6mD/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26ttcmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:28 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576FOIRr030921;
	Wed, 6 Aug 2025 15:41:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26ttcmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CJL97025897;
	Wed, 6 Aug 2025 15:41:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwn493w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 15:41:26 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576FfNQi31523396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 15:41:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3F1E20040;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D048C2004D;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 15:41:22 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 8D955E07B5; Wed, 06 Aug 2025 17:41:22 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-rdma@vger.kernel.org
Subject: [RFC net-next 00/17] dibs - Direct Internal Buffer Sharing
Date: Wed,  6 Aug 2025 17:41:05 +0200
Message-ID: <20250806154122.3413330-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vFiHp9VI_MygDPeVweTVAtMGoC20E2k8
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=689377a8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=3nI6nj7hAAAA:8 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8
 a=mkMtH7XpAAAA:8 a=RRLKIy59WTDJEBabzTEA:9 a=bb6nGAbfQKYA:10
 a=PUQwBqpy_9XipHPXVRm3:22 a=I9Slk6e--tAXHahELIuT:22
X-Proofpoint-GUID: wYlZ38PhPGBUyOUh9DRXRBI5Oze49chZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5NiBTYWx0ZWRfX1wk8pKr4fiIz
 j4F8Ku53X9H+QzShwxHDUeIIU++gIPU52QtwKjeR1GU0VIX76r+7OjLUnyLX7Y4Jn+r6K0FmMKs
 NnFDl2jqCED0BfMRh5uw9N1UolDGGkd/LLcWjQrj2Zmhh5An6azQpLByvlyujJK6tZOaYuiOuMa
 W8eBZFjsuPHZy4+PLdTSY3cTypdYM3DU1EhjmI/7QwMdtwUllZqdBuYX1KvlkWTB9yACi4etHgw
 kBva4usum425sw3pICfDgJ9iwcSw08cCwua5P2k1fYKrVN2o60RMxrJlSsEZd145BJ/aMzhYQLN
 KbvigB7k/W/K+afROIi9ePtCdStJR0xQNgoFVckUY4MotqFucciFUb1qPMCd2+3Lb94G808TCRR
 JUOenLQ5Rvp6n8pe54qa1LdG9YQmKMDHr58G1EHl234qQBNx8DnY4Xab3fUAZMJaK5qw+dPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=765
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060096

This series introduces a generic abstraction of existing components like:
- the s390 specific ISM device (Internal Shared Memory),
- the SMC-D loopback mechanism (Shared Memory Communication - Direct)
- the client interface of the SMC-D module to the transport devices
This generic shim layer can be extended with more devices, more clients and
more features in the future.

This layer is called 'dibs' for Direct Internal Buffer Sharing based on the
common scheme that these mechanisms enable controlled sharing of memory
buffers within some containing entity such as a hypervisor or a Linux
instance.

Benefits:
- Cleaner separation of ISM and SMC-D functionality
- simpler and less module dependencies
- Clear interface definition.
- Extendable for future devices and clients.

An overview was given at the Netdev 0x19 conference, recordings and slides
are available [1].

Background / Status quo:
------------------------
Currently s390 hardware provides virtual PCI ISM devices (Internal Shared
Memory). Their driver is in drivers/s390/net/ism_drv.c. The main user is
SMC-D (net/smc). The ism driver offers a client interface so other
users/protocols can also use them, but it is still heavily intermingled
with the smc code. Namely, the ism module cannot be used without the smc
module, which feels artificial.

There is ongoing work to extend the ISM concept of shared buffers that can
be accessed directly by another instance on the same hardware: [2] proposed
a loopback interface (ism_lo), that can be used on non-s390 architectures
(e.g. between containers or to test SMC-D). A minimal implementation went
upstream with [3]: ism_lo currently is a part of the smc protocol and
rather hidden.

[4] proposed a virtio definition of ism (ism_virtio) that can be used
between kvm guests.

We will shortly send an RFC for an dibs client that uses dibs as transport
for TTY.

Concept:
--------
Create a shim layer in net/dibs that contains common definitions and code
for all dibs devices and all dibs clients. Any device or client module only
needs to depend on this dibs layer module and any device or client code
only needs to include the definitions in include/linux/dibs.h.

The name dibs was chosen to clearly distinguish it from the existing s390
ism devices. And to emphasize that it is not about sharing whole memory
regions with anybody, but dedicating single buffers for another system.

Implementation:
---------------
The end result of this series is: A dibs shim layer with
One dibs client: smc-d
Two dibs device drivers: ism and dibs-loopback
Everything prepared to add more clients and more device drivers.

As net-next is still closed, I am sending this series as RFC to give
reviewers an early start (vacation season). This series is based on
net-next tag 'bpf-next-6.17' and contains everything I want to include for
the initial implementation.

Patches 1-5 contain some issues that were found along the way. They make
sense on their own, but also enable a better structured dibs series.

There are three components that exist today:
a) smc module (especially SMC-D functionality, which is an ism client today)
b) ism device driver (supports multiple ism clients today)
c) smc-loopback (integrated with smc today)
In order to preserve existing functionality at each step, these are not
moved to dibs layer by component, instead:
- the dibs layer is established in parallel to existing code [patches 6-9]
- then some service functions are moved to the dibs layer [patches 10-15]
- the actual data movement is moved to the dibs layer [patch 16]
- and last event handling is moved to the dibs layer [patch 17]

Future:
-------
Items that are not part of this patchset but could be added later:
- dynamically add or remove dibs_loopback. That will be allow for simple
  testing of add_dev()/del_dev()
- handle_irq(): Call clients without interrupt context. e.g using
  threaded interrupts. I left this for a follow-on, because it includes
  conceptual changes for the smcd receive code.
- Any improvements of locking scopes. I mainly moved some of the the
  existing locks to dibs layer. I have the feeling there is room for
  improvements.

Link: [1] https://netdevconf.info/0x19/sessions/talk/communication-via-internal-shared-memory-ism-time-to-open-up.html
Link: [2] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
Link: [3] https://lore.kernel.org/linux-kernel//20240428060738.60843-1-guwen@linux.alibaba.com/
Link: [4] https://groups.oasis-open.org/communities/community-home/digestviewer/viewthread?GroupId=3973&MessageKey=c060ecf9-ea1a-49a2-9827-c92f0e6447b2&CommunityKey=2f26be99-3aa1-48f6-93a5-018dce262226&hlmlt=VT

Alexandra Winter (14):
  net/smc: Remove __init marker from smc_core_init()
  s390/ism: Log module load/unload
  net/smc: Remove error handling of unregister_dmb()
  net/smc: Decouple sf and attached send_buf in smc_loopback
  net/smc: Improve log message for devices w/o pnetid
  net/dibs: Create net/dibs
  net/dibs: Register smc as dibs_client
  net/dibs: Register ism as dibs device
  net/dibs: Define dibs loopback
  net/dibs: Define dibs_client_ops and dibs_dev_ops
  net/dibs: Local gid for dibs devices
  net/dibs: Move vlan support to dibs_dev_ops
  net/dibs: Move query_remote_gid() to dibs_dev_ops
  net/dibs: Move data path to dibs layer

Julian Ruess (3):
  net/dibs: Move struct device to dibs_dev
  net/dibs: Create class dibs
  net/dibs: Move event handling to dibs layer

 MAINTAINERS                |   9 +-
 drivers/s390/net/Kconfig   |   3 +-
 drivers/s390/net/ism.h     |  53 +++-
 drivers/s390/net/ism_drv.c | 580 ++++++++++++++-----------------------
 include/linux/dibs.h       | 479 ++++++++++++++++++++++++++++++
 include/linux/ism.h        |  93 ------
 include/net/smc.h          |  51 +---
 net/Kconfig                |   1 +
 net/Makefile               |   1 +
 net/dibs/Kconfig           |  27 ++
 net/dibs/Makefile          |   8 +
 net/dibs/dibs_loopback.c   | 355 +++++++++++++++++++++++
 net/dibs/dibs_loopback.h   |  57 ++++
 net/dibs/dibs_main.c       | 280 ++++++++++++++++++
 net/smc/Kconfig            |  16 +-
 net/smc/Makefile           |   1 -
 net/smc/af_smc.c           |  12 +-
 net/smc/smc_clc.c          |   6 +-
 net/smc/smc_core.c         |   8 +-
 net/smc/smc_core.h         |   5 +
 net/smc/smc_diag.c         |   2 +-
 net/smc/smc_ib.c           |  18 +-
 net/smc/smc_ism.c          | 233 ++++++++-------
 net/smc/smc_ism.h          |  36 ++-
 net/smc/smc_loopback.c     | 421 ---------------------------
 net/smc/smc_loopback.h     |  60 ----
 net/smc/smc_pnet.c         |   8 +-
 net/smc/smc_tx.c           |   3 +
 28 files changed, 1672 insertions(+), 1154 deletions(-)
 create mode 100644 include/linux/dibs.h
 delete mode 100644 include/linux/ism.h
 create mode 100644 net/dibs/Kconfig
 create mode 100644 net/dibs/Makefile
 create mode 100644 net/dibs/dibs_loopback.c
 create mode 100644 net/dibs/dibs_loopback.h
 create mode 100644 net/dibs/dibs_main.c
 delete mode 100644 net/smc/smc_loopback.c
 delete mode 100644 net/smc/smc_loopback.h

-- 
2.48.1



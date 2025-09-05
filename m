Return-Path: <linux-rdma+bounces-13117-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B94FAB45B08
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D51A4504B
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45783728B2;
	Fri,  5 Sep 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oGI3DZ0Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9A36CE1C;
	Fri,  5 Sep 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084083; cv=none; b=MNCBib8sAwegqeTdf/r++lmQk8svCLXc2W/nGV4dS9/wlCWGvvHdyIWD5Wvvx9uxtcEPFGorjc0Wd/U++vEFuKxUToWinFnNDuRhjiin4hZOgUB7/AYg+Sl51wxV6sFysRvJHYVGedys9quvMvtLQyWFEfnN0hqVb9Dl42GqXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084083; c=relaxed/simple;
	bh=qeSR4qIqUSBvHUJEzB23WTCxGh5d6cfSGfgCyPGYs/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eyY9ktHq4HvYdDuq65FQk0zehluacI0S8HXIOFoYm5kBtNE4uv+LfQg3FAzAYFisCOkRP6mhRw6sc4H/geRcYl4OvR6SdneOtki/CEGZbMvAfueYnoSkKvBzuq1yXnBnsSgB4wlaNGDSYG0qBcV0QEDyY82bgGNmJs2xJ5YSQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oGI3DZ0Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585AlqY3008655;
	Fri, 5 Sep 2025 14:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Rov2MAzAz/Lce47qf9xNKZ10+IfV0/4X6+1aUpftK
	nc=; b=oGI3DZ0QLbeyd4sLPJK62mmqjx5yCqw/YvbDLNFq5uPJ6tm+3pzziFFcL
	s0QfMOLPxisdgC9n0wfcpu8rRGjQGcO6ZhPBw9942in1fIzaSkNmOEgg35HAEE9Y
	Yt72r8DQhflGE4eQjk1wANANFC4aqBFHfXgYNWjmtaoIUO3i/uLI/H41af3HQNy7
	JLvc9KWeYfT/er+kLZXkuPe6eOJaSUcSMrLhKkaS8WNrgwRxv3tvQNcB9G7vIGoI
	5NuUU75I5MIFWfF7qz7XRiDVBdmOYw0AQG7LBP/RnCU6t7KzBk0IelmAcSGFVxy+
	cvtFqfH4+N7Royj4bP4BYhwMDmUMA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswds98a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585Ejakv028852;
	Fri, 5 Sep 2025 14:54:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswds983-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585Bltsf019927;
	Fri, 5 Sep 2025 14:54:32 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmuj6vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 14:54:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585EsSmr24838774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 14:54:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7016620043;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5029B20040;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 14:54:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id 183CAE111A; Fri, 05 Sep 2025 16:54:28 +0200 (CEST)
From: Alexandra Winter <wintera@linux.ibm.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Sidraya Jayagond <sidraya@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Julian Ruess <julianr@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mahanta Jambigi <mjambigi@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 00/14] dibs - Direct Internal Buffer Sharing
Date: Fri,  5 Sep 2025 16:54:13 +0200
Message-ID: <20250905145428.1962105-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68baf9a9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=3nI6nj7hAAAA:8 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8
 a=mkMtH7XpAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=DPgQZZUEgBTEjLq2gQoA:9
 a=bb6nGAbfQKYA:10 a=PUQwBqpy_9XipHPXVRm3:22 a=I9Slk6e--tAXHahELIuT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX2B3zMei5wCSN
 9XJJ4bMvYkNmy1HzwZxGD+vGTcof4Dud1/e3VgyCaM28F/8DgmKB08q9vEKHG8e4zx6UIWlLOqd
 6TbPS8qGKozqe6sDmSw3A3zMHJzFcjPfgJk9+R+1sKBgU8/kvJjb6M2GtlhsU7rS1CJ9fAm+Aej
 i0oh9CmfiKuzT6jQvV/WoAXu40k+8edo4BlSM87qAUKoS+HjX91td0ZQggp3ID8TKN2in13Fw/J
 /8VYcpprt2wHzQxOWCZcpmuXawXBKRU8t6F7vCQ/I47jj4r7b7dkWNMC9dzAP1IvXoWBJVbo6u0
 qoZb+6S40AFn5Nlo31fmUXq0r7UvsP4kXnFVdBQt9B60Fq8cXotCeS85i2PSm9czSBCW+5DA4Wk
 pPrB47/L
X-Proofpoint-GUID: nY3Eeb0uyrl0ErNa1dzFfbR1ALHePr44
X-Proofpoint-ORIG-GUID: pb3ZhSFPg8LWuXxXaZl5TkGXurPSgVdZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

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
- One dibs client: smc-d
- Two dibs device drivers: ism and dibs-loopback
- Everything prepared to add more clients and more device drivers.

Patches 1-2 contain some issues that were found along the way. They make
sense on their own, but also enable a better structured dibs series.

There are three components that exist today:
a) smc module (especially SMC-D functionality, which is an ism client today)
b) ism device driver (supports multiple ism clients today)
c) smc-loopback (integrated with smc today)
In order to preserve existing functionality at each step, these are not
moved to dibs layer by component, instead:
- the dibs layer is established in parallel to existing code [patches 3-6]
- then some service functions are moved to the dibs layer [patches 7-12]
- the actual data movement is moved to the dibs layer [patch 13]
- and last event handling is moved to the dibs layer [patch 14]

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
- The device drivers should not loop through the client array
- dibs_dev_op.*_dmb() functions reveal unnecessary details of the
  internal dmb struct to the clients
- Check whether client calls to dibs_dev_ops should be replaced by
  interface functions that provide additional value
- Check whether device driver calls to dibs_client_ops should be replaced
  by interface functions that provide additional value.

Link: [1] https://netdevconf.info/0x19/sessions/talk/communication-via-internal-shared-memory-ism-time-to-open-up.html
Link: [2] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
Link: [3] https://lore.kernel.org/linux-kernel//20240428060738.60843-1-guwen@linux.alibaba.com/
Link: [4] https://groups.oasis-open.org/communities/community-home/digestviewer/viewthread?GroupId=3973&MessageKey=c060ecf9-ea1a-49a2-9827-c92f0e6447b2&CommunityKey=2f26be99-3aa1-48f6-93a5-018dce262226&hlmlt=VT

---
Changes in v1:
- Don't change __init in smc_core_init() (was [1]) (Dust Li)
- Split off log message improvements from this series (was [2,5]) (Dust Li)
- Fix arch/s390/[debug_]defconfig [4,6,7,14]
- Helptext of dibs/Kconfig [3,6]
- include linux/slab.h to avoid Wimplicit-function-declaration of
  kzalloc() and kfree() [5,6] (Simon Horman and
                             'kernel test robot <lkp@intel.com>')
- Fix transient use of undefined 'ism' pointer [7] (Simon Horman)
- Fix transient scope of IS_ENABLED(CONFIG_ISM) [7,13] (Simon Horman)
- Change position of is_attached in sruct smc_buf_desc to reduce gaps [1] (Dust Li)
- Fix SW-pnetid handling for s390 ism devices [9]
- use dibs->dev instead of defining dibs_get_dev() [8]
- add const to uuid_t* parameters [12,14] (Julian Ruess)
- no log message for module load/unload [3] (Jakub Kicinski)

RFC:
- Link: https://lore.kernel.org/netdev/20250806154122.3413330-1-wintera@linux.ibm.com/
---

Alexandra Winter (11):
  net/smc: Remove error handling of unregister_dmb()
  net/smc: Decouple sf and attached send_buf in smc_loopback
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

 MAINTAINERS                       |   9 +-
 arch/s390/configs/debug_defconfig |   4 +-
 arch/s390/configs/defconfig       |   4 +-
 drivers/s390/net/Kconfig          |   3 +-
 drivers/s390/net/ism.h            |  53 ++-
 drivers/s390/net/ism_drv.c        | 573 +++++++++++-------------------
 include/linux/dibs.h              | 464 ++++++++++++++++++++++++
 include/linux/ism.h               |  28 +-
 include/net/smc.h                 |  51 +--
 net/Kconfig                       |   1 +
 net/Makefile                      |   1 +
 net/dibs/Kconfig                  |  23 ++
 net/dibs/Makefile                 |   8 +
 net/dibs/dibs_loopback.c          | 356 +++++++++++++++++++
 net/dibs/dibs_loopback.h          |  57 +++
 net/dibs/dibs_main.c              | 278 +++++++++++++++
 net/smc/Kconfig                   |  16 +-
 net/smc/Makefile                  |   1 -
 net/smc/af_smc.c                  |  12 +-
 net/smc/smc_clc.c                 |   6 +-
 net/smc/smc_core.c                |   6 +-
 net/smc/smc_core.h                |   5 +
 net/smc/smc_diag.c                |   2 +-
 net/smc/smc_ism.c                 | 224 ++++++------
 net/smc/smc_ism.h                 |  36 +-
 net/smc/smc_loopback.c            | 165 +--------
 net/smc/smc_loopback.h            |  19 +-
 net/smc/smc_pnet.c                |  25 +-
 net/smc/smc_tx.c                  |   3 +
 29 files changed, 1667 insertions(+), 766 deletions(-)
 create mode 100644 include/linux/dibs.h
 create mode 100644 net/dibs/Kconfig
 create mode 100644 net/dibs/Makefile
 create mode 100644 net/dibs/dibs_loopback.c
 create mode 100644 net/dibs/dibs_loopback.h
 create mode 100644 net/dibs/dibs_main.c

-- 
2.48.1



Return-Path: <linux-rdma+bounces-13493-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 116F3B844B8
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 13:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ABA0540DC3
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A43306B04;
	Thu, 18 Sep 2025 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aD5jZzcP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4263064A3;
	Thu, 18 Sep 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193541; cv=none; b=UisSE1KL39PNEfYFDPDfimYAuyP7DRIEhtbbtH5U6ISreYK2rRxkq14xuLnWRuFSL8BLDaNAypN1oPvvnftLYAAPiXOx/c/PsJcqtfW+cPSzqR+uBcxGIIzRToevpE9MMpZREOHsqNpssX0IuQpMJHDWS9AHOZZwdUMJb6b3FfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193541; c=relaxed/simple;
	bh=dQkXa90qNk9B2bidayqq13jyVbeEZMS3lvMURNMRVOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDIeD08APimLWFCPNHMSkw2Qo5ShM52sdqlHCmMhwK6HuV5HDVWiOtlOh91IcP12QuYpMuSdTacIoGCRiBGAsSYhyGrtfHlk56juXpxerFHWOFaNQpbXBwFCS8jWZKJ3Iv8jZF1LkE2Sn/EcotjkYgLEr6dqmTRj8LLMCPkrtBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aD5jZzcP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7ZpZC000625;
	Thu, 18 Sep 2025 11:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=w58PcKGE7xrgL3DIcSmpbH+3e5BoAmFqFxbtcG5n5
	3M=; b=aD5jZzcPcmX6J2+De6wkE6X7rccuo/lKYKRs3BwsBFmW8cP+B+mt+D0qo
	HwC/Id0FAyyldYn4NF+L6K6RQ8OC5BT5mc11mYrEM11SAnhLZkPC9PkDvd3Ksdv8
	KM363ql3/a1VSA5B62Pt5fBnK0jCjeutN+FH8RVWVWknUsCK0dU1VH2xPoWvAons
	yyXbl/2c7xbGyWrAeavRt+FicNBjLWb7maQH5OIEsUJdNZ6U5+U6bpZBafOy4Xyj
	FgHkFTyGF+yD87oVeTF+rQV/WgbxYNbXsqhq2lo9HbBGR5eRQlrXyXhXniamSLS2
	cVWiR3ImujgperDfzT7pY625o1EbQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwh0yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58IB2LM1015961;
	Thu, 18 Sep 2025 11:05:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwh0y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7LUbl008988;
	Thu, 18 Sep 2025 11:05:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3nxyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 11:05:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58IB510M50790700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 11:05:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0190920063;
	Thu, 18 Sep 2025 11:05:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3C1E2004B;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Sep 2025 11:05:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id A0B22E0722; Thu, 18 Sep 2025 13:05:00 +0200 (CEST)
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
        Sven Schnelle <svens@linux.ibm.com>, Simon Horman <horms@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Konstantin Shkolnyy <kshk@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Shannon Nelson <sln@onemain.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH net-next v3 00/14] dibs - Direct Internal Buffer Sharing
Date: Thu, 18 Sep 2025 13:04:46 +0200
Message-ID: <20250918110500.1731261-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EYvIQOmC c=1 sm=1 tr=0 ts=68cbe762 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=3nI6nj7hAAAA:8 a=VwQbUJbxAAAA:8 a=SRrdq9N9AAAA:8
 a=mkMtH7XpAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8 a=RkOrkl1-BjnOTL04EN0A:9
 a=bb6nGAbfQKYA:10 a=PUQwBqpy_9XipHPXVRm3:22 a=I9Slk6e--tAXHahELIuT:22
X-Proofpoint-ORIG-GUID: Iu8qXOkcmNY0ka6IzXJnShIDURsiPsb6
X-Proofpoint-GUID: pQ4tK1QQhb_5jwybk54IWfbXsH05l3vq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA2NSBTYWx0ZWRfX4bjuyrebDvB8
 JVtsdld+4/g3ihuZfN46q8mhp2yCA5hVxFZNhUuKmL3bI0hRNSUi0Q6XeK6tOJ0+iUeoVjy2F7O
 8ESmPQyLdXtMgqSVUqA2ibJ/23WWk1rczbRYLNxBzru6f4bB/zismVQxVUHiicKDJV+dz317Mjg
 gCA/V/25vFzppTAD5zMvW6PEfVq+i2m/FSQPxs6WVuBxc+8VLZdaCtdQPtqP1O8qpt0tdQVWS/u
 lubIR7GWTMTmpUzW3jKDkg7K9jQ0KvWYK9Z3efbzOEJpXrm9LyLV9ew0MKE4GptseZAOE81ZUtB
 pMD+WmX6mQpHKxH8VeAH4jHjJxCpTG6lv4QanRPtHNRo8fw7spSUNa2GvlHPj4Dsr6xQ1XO0Cs6
 Ki+g9XvD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180065

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
Items that are not part of this patchset but can be added later:
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
Changes in v3:
- Use kfree() instead of kvfree() for kmalloc()ed dmbs (Paolo Abeni) [13]

Changes in v2:
- More fixes of transient scope of IS_ENABLED(CONFIG_ISM) [7,13] (patchwork)
- Delete obsolete net/smc/smc_loopback.* files [13] (Dust Li)
- Fix transient usage of supports_v2() after rebase on top of
  091d019adce0 ("net/smc: remove unused function smc_lo_supports_v2") [7]
- Fix CC according to get_maintainer.pl (patchwork)
- Place dibs level code in drivers/dibs/ instead of net/dibs/ (Dust Li, Julian Ruess)
- Link: https://lore.kernel.org/netdev/20250911194827.844125-1-wintera@linux.ibm.com/

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
- Change position of is_attached in struct smc_buf_desc to reduce gaps [1] (Dust Li)
- Fix SW-pnetid handling for s390 ism devices [9]
- use dibs->dev instead of defining dibs_get_dev() [8]
- add const to uuid_t* parameters [12,14] (Julian Ruess)
- no log message for module load/unload [3] (Jakub Kicinski)
- Link: https://lore.kernel.org/netdev/20250905145428.1962105-1-wintera@linux.ibm.com/

RFC:
- Link: https://lore.kernel.org/netdev/20250806154122.3413330-1-wintera@linux.ibm.com/ 

Alexandra Winter (11):
  net/smc: Remove error handling of unregister_dmb()
  net/smc: Decouple sf and attached send_buf in smc_loopback
  dibs: Create drivers/dibs
  dibs: Register smc as dibs_client
  dibs: Register ism as dibs device
  dibs: Define dibs loopback
  dibs: Define dibs_client_ops and dibs_dev_ops
  dibs: Local gid for dibs devices
  dibs: Move vlan support to dibs_dev_ops
  dibs: Move query_remote_gid() to dibs_dev_ops
  dibs: Move data path to dibs layer

Julian Ruess (3):
  dibs: Move struct device to dibs_dev
  dibs: Create class dibs
  dibs: Move event handling to dibs layer

 MAINTAINERS                       |   9 +-
 arch/s390/configs/debug_defconfig |   4 +-
 arch/s390/configs/defconfig       |   4 +-
 drivers/Makefile                  |   1 +
 drivers/dibs/Kconfig              |  23 ++
 drivers/dibs/Makefile             |   8 +
 drivers/dibs/dibs_loopback.c      | 356 +++++++++++++++++++
 drivers/dibs/dibs_loopback.h      |  57 +++
 drivers/dibs/dibs_main.c          | 278 +++++++++++++++
 drivers/s390/net/Kconfig          |   3 +-
 drivers/s390/net/ism.h            |  53 ++-
 drivers/s390/net/ism_drv.c        | 573 +++++++++++-------------------
 include/linux/dibs.h              | 464 ++++++++++++++++++++++++
 include/linux/ism.h               |  28 +-
 include/net/smc.h                 |  51 +--
 net/Kconfig                       |   1 +
 net/smc/Kconfig                   |  16 +-
 net/smc/Makefile                  |   1 -
 net/smc/af_smc.c                  |  12 +-
 net/smc/smc_clc.c                 |   6 +-
 net/smc/smc_core.c                |   6 +-
 net/smc/smc_core.h                |   5 +
 net/smc/smc_diag.c                |   2 +-
 net/smc/smc_ism.c                 | 224 ++++++------
 net/smc/smc_ism.h                 |  36 +-
 net/smc/smc_loopback.c            | 421 ----------------------
 net/smc/smc_loopback.h            |  60 ----
 net/smc/smc_pnet.c                |  25 +-
 net/smc/smc_tx.c                  |   3 +
 29 files changed, 1645 insertions(+), 1085 deletions(-)
 create mode 100644 drivers/dibs/Kconfig
 create mode 100644 drivers/dibs/Makefile
 create mode 100644 drivers/dibs/dibs_loopback.c
 create mode 100644 drivers/dibs/dibs_loopback.h
 create mode 100644 drivers/dibs/dibs_main.c
 create mode 100644 include/linux/dibs.h
 delete mode 100644 net/smc/smc_loopback.c
 delete mode 100644 net/smc/smc_loopback.h

-- 
2.48.1



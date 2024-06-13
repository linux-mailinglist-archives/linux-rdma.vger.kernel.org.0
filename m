Return-Path: <linux-rdma+bounces-3111-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B6906723
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 10:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFE21C20E78
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0176B13E40E;
	Thu, 13 Jun 2024 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="JI7Sr9p6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C0522F
	for <linux-rdma@vger.kernel.org>; Thu, 13 Jun 2024 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267898; cv=none; b=uH0J5IbH1huSWw/1pm1eJDNyf/MVpVOFWvFBi1oPTfmnAd6Q+1XEcPRxfe+zqBU0bFDYB8UUEiTqCk50LnjKB+XG6ys3fhT9wYECI+Hg8a7k9rXt67SkI3z+tO42YGLgtqtzfdYT2rC+r3lDfgIT0xa60ZntSsW7TsGXxNYPrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267898; c=relaxed/simple;
	bh=JUaEX9cxLPwEzZfM9QD1sGAhE4irtdTHkQesi0gE55w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CEsKbBkLv7NEHDhKOdAh3IQVakCC5MAphZPHb02ywq95xinemmw42+/a/pJMO81kTlulsV1wDcY+O+4fpaCJ3grSKrtKK2ntZVdqcAAnOEV5jz2c372r8kSjY95H8OJESW0Rs+ts3mUX846Q07GcYy+eJUcb9nyXt6Yy7rj4PVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=JI7Sr9p6; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1718267890; bh=JUaEX9cxLPwEzZfM9QD1sGAhE4irtdTHkQesi0gE55w=;
	h=From:To:Cc:Subject:Date:From;
	b=JI7Sr9p6bToqkyRFPToXqA4r9P34900UuiswB9gbPbyKKzoF298lx4wQvBa9tYCRU
	 YjNn3QF28GvpfHWicAc24Nd10koLZ8IsWDGqHcAEX/b0pZFwE5HoGQer4OATjWu6ZG
	 f3E4ludOXtKoRLF5IGGKi5T+5j+L5Jirg3UtNZvUP5Sh5OI5lLGZ5lOuL9IvaNVqC5
	 lFbJMfDePeIW6lTrlJIv1SlUp7vFmMwYQquf1eIJpjPNflR8IjWXa7sE4Qv7+glhCE
	 br9UZEStf+B2L4H+VcpDK04xM1dl1m77CTzCwN3Fs1Gd1H6e9NBc2rIqS8gbDzJHdD
	 DthtoggriVDRQ==
Received: from oshpigelman-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by oshpigelman-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 45D8c2vX1440923;
	Thu, 13 Jun 2024 11:38:02 +0300
From: Omer Shpigelman <oshpigelman@habana.ai>
To: linux-rdma@vger.kernel.org
Cc: ogabbay@kernel.org, oshpigelman@habana.ai, zyehudai@habana.ai
Subject: [PATCH 0/4] hbl: HabanaLabs RDMA provider
Date: Thu, 13 Jun 2024 11:37:58 +0300
Message-Id: <20240613083802.1440904-1-oshpigelman@habana.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a provider which exposes hbl devices to user applications for
scaling of AI neural networks training through ROCEv2 protocol.
The hbl provider supports a DV API for fully operating the device.

The patches are also available at:
https://github.com/HabanaAI/rdma-core/tree/hbl_next

More info about the kernel driver and the HW can be found in the kernel
patch set:
https://lore.kernel.org/all/20240613082208.1439968-1-oshpigelman@habana.ai/

Omer Shpigelman (4):
  Update kernel headers
  hbl: HabanaLabs RDMA provider
  pyverbs/hbl: direct verbs support
  tests/hbl: direct verbs tests

 CMakeLists.txt                               |    2 +
 MAINTAINERS                                  |    5 +
 README.md                                    |    1 +
 buildlib/check-build                         |    1 +
 debian/control                               |    3 +-
 debian/copyright                             |    5 +
 debian/ibverbs-providers.install             |    1 +
 debian/ibverbs-providers.lintian-overrides   |    4 +-
 debian/ibverbs-providers.symbols             |   16 +
 debian/libibverbs-dev.install                |    7 +
 debian/rules                                 |    2 +-
 kernel-headers/CMakeLists.txt                |    4 +
 kernel-headers/rdma/hbl-abi.h                |  204 ++++
 kernel-headers/rdma/hbl_user_ioctl_cmds.h    |   66 ++
 kernel-headers/rdma/hbl_user_ioctl_verbs.h   |  106 ++
 kernel-headers/rdma/ib_user_ioctl_verbs.h    |    1 +
 libibverbs/verbs.h                           |    8 +-
 providers/hbl/CMakeLists.txt                 |   14 +
 providers/hbl/hbl-abi.h                      |   25 +
 providers/hbl/hbl.c                          |  225 ++++
 providers/hbl/hbl.h                          |  155 +++
 providers/hbl/hbldv.h                        |  433 +++++++
 providers/hbl/libhbl.map                     |   19 +
 providers/hbl/man/CMakeLists.txt             |   14 +
 providers/hbl/man/hbldv.7.md                 |   38 +
 providers/hbl/man/hbldv_create_cq.3.md       |   68 ++
 providers/hbl/man/hbldv_create_encap.3.md    |  116 ++
 providers/hbl/man/hbldv_create_usr_fifo.3.md |  121 ++
 providers/hbl/man/hbldv_is_supported.3.md    |   43 +
 providers/hbl/man/hbldv_modify_qp.3.md       |  102 ++
 providers/hbl/man/hbldv_open_device.3.md     |   59 +
 providers/hbl/man/hbldv_query_cq.3.md        |   84 ++
 providers/hbl/man/hbldv_query_device.3.md    |   61 +
 providers/hbl/man/hbldv_query_port.3.md      |  125 ++
 providers/hbl/man/hbldv_query_qp.3.md        |   63 +
 providers/hbl/man/hbldv_set_port_ex.3.md     |  106 ++
 providers/hbl/verbs.c                        | 1085 ++++++++++++++++++
 providers/hbl/verbs.h                        |   27 +
 pyverbs/CMakeLists.txt                       |    3 +-
 pyverbs/providers/hbl/CMakeLists.txt         |   10 +
 pyverbs/providers/hbl/__init__.pxd           |    0
 pyverbs/providers/hbl/__init__.py            |    0
 pyverbs/providers/hbl/hbl_enums.pxd          |   39 +
 pyverbs/providers/hbl/hbl_enums.pyx          |    0
 pyverbs/providers/hbl/hbldv.pxd              |   60 +
 pyverbs/providers/hbl/hbldv.pyx              |  394 +++++++
 pyverbs/providers/hbl/libhbl.pxd             |  142 +++
 pyverbs/providers/hbl/libhbl.pyx             |    0
 redhat/rdma-core.spec                        |    6 +
 suse/rdma-core.spec                          |   21 +
 tests/CMakeLists.txt                         |    2 +
 tests/hbl_base.py                            |   89 ++
 tests/test_hbldv.py                          |  226 ++++
 util/util.h                                  |   13 +
 54 files changed, 4416 insertions(+), 8 deletions(-)
 create mode 100644 kernel-headers/rdma/hbl-abi.h
 create mode 100644 kernel-headers/rdma/hbl_user_ioctl_cmds.h
 create mode 100644 kernel-headers/rdma/hbl_user_ioctl_verbs.h
 create mode 100644 providers/hbl/CMakeLists.txt
 create mode 100644 providers/hbl/hbl-abi.h
 create mode 100644 providers/hbl/hbl.c
 create mode 100644 providers/hbl/hbl.h
 create mode 100644 providers/hbl/hbldv.h
 create mode 100644 providers/hbl/libhbl.map
 create mode 100644 providers/hbl/man/CMakeLists.txt
 create mode 100644 providers/hbl/man/hbldv.7.md
 create mode 100644 providers/hbl/man/hbldv_create_cq.3.md
 create mode 100644 providers/hbl/man/hbldv_create_encap.3.md
 create mode 100644 providers/hbl/man/hbldv_create_usr_fifo.3.md
 create mode 100644 providers/hbl/man/hbldv_is_supported.3.md
 create mode 100644 providers/hbl/man/hbldv_modify_qp.3.md
 create mode 100644 providers/hbl/man/hbldv_open_device.3.md
 create mode 100644 providers/hbl/man/hbldv_query_cq.3.md
 create mode 100644 providers/hbl/man/hbldv_query_device.3.md
 create mode 100644 providers/hbl/man/hbldv_query_port.3.md
 create mode 100644 providers/hbl/man/hbldv_query_qp.3.md
 create mode 100644 providers/hbl/man/hbldv_set_port_ex.3.md
 create mode 100644 providers/hbl/verbs.c
 create mode 100644 providers/hbl/verbs.h
 create mode 100644 pyverbs/providers/hbl/CMakeLists.txt
 create mode 100644 pyverbs/providers/hbl/__init__.pxd
 create mode 100644 pyverbs/providers/hbl/__init__.py
 create mode 100644 pyverbs/providers/hbl/hbl_enums.pxd
 create mode 100644 pyverbs/providers/hbl/hbl_enums.pyx
 create mode 100644 pyverbs/providers/hbl/hbldv.pxd
 create mode 100644 pyverbs/providers/hbl/hbldv.pyx
 create mode 100644 pyverbs/providers/hbl/libhbl.pxd
 create mode 100644 pyverbs/providers/hbl/libhbl.pyx
 create mode 100644 tests/hbl_base.py
 create mode 100644 tests/test_hbldv.py

-- 
2.34.1



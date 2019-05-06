Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9735A14F11
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfEFPHn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:07:43 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50072 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726917AbfEFPHm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:42 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:40 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7edW019922;
        Mon, 6 May 2019 18:07:40 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 00/11] Add traffic in pyverbs
Date:   Mon,  6 May 2019 18:07:27 +0300
Message-Id: <20190506150738.19477-1-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This PR adds the support for RDMA traffic in pyverbs. It's
consisted roughly of three parts - Address handle support, QP
support and example (RC pingpong).

Noa Osherovich (11):
  pyverbs: Add support for address handle creation
  pyverbs: Add unittests for address handle creation
  Documentation: Document Address Handle creation with pyverbs
  pyverbs: Add work requests related classes
  pyverbs: Add QP related classes
  pyverbs: Introducing QP class
  pyverbs: Add missing device capabilities
  pyverbs/tests: Add control-path unittests for QP class
  Documentation: Document QP creation and basic usage with pyverbs
  pyverbs/examples: Add base classes for pyverbs applications
  pyverbs/examples: RC pingpong

 Documentation/pyverbs.md         |   64 +-
 buildlib/pyverbs_functions.cmake |   11 +-
 pyverbs/CMakeLists.txt           |   15 +-
 pyverbs/addr.pxd                 |   16 +-
 pyverbs/addr.pyx                 |  389 ++++++++++-
 pyverbs/cq.pxd                   |    4 +
 pyverbs/cq.pyx                   |   13 +
 pyverbs/device.pxd               |    1 +
 pyverbs/device.pyx               |    6 +-
 pyverbs/examples/__init__.py     |    0
 pyverbs/examples/common.py       |  331 ++++++++++
 pyverbs/examples/rc_pingpong.py  |  208 ++++++
 pyverbs/libibverbs.pxd           |  203 ++++++
 pyverbs/libibverbs_enums.pxd     |    6 +
 pyverbs/pd.pxd                   |    2 +
 pyverbs/pd.pyx                   |   14 +-
 pyverbs/qp.pxd                   |   32 +
 pyverbs/qp.pyx                   | 1046 ++++++++++++++++++++++++++++++
 pyverbs/tests/addr.py            |   72 ++
 pyverbs/tests/qp.py              |  255 ++++++++
 pyverbs/tests/utils.py           |  128 +++-
 pyverbs/utils.py                 |  100 +++
 pyverbs/wr.pxd                   |   16 +
 pyverbs/wr.pyx                   |  310 +++++++++
 24 files changed, 3206 insertions(+), 36 deletions(-)
 create mode 100644 pyverbs/examples/__init__.py
 create mode 100644 pyverbs/examples/common.py
 create mode 100644 pyverbs/examples/rc_pingpong.py
 create mode 100644 pyverbs/qp.pxd
 create mode 100644 pyverbs/qp.pyx
 create mode 100644 pyverbs/tests/addr.py
 create mode 100644 pyverbs/tests/qp.py
 create mode 100644 pyverbs/utils.py
 create mode 100644 pyverbs/wr.pxd
 create mode 100644 pyverbs/wr.pyx

-- 
2.17.2


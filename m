Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0399AD548
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbfIIJHU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:20 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48368 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389612AbfIIJHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:19 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:16 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fow028426;
        Mon, 9 Sep 2019 12:07:15 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 00/12] Add XRCD and SRQ support to pyverbs
Date:   Mon,  9 Sep 2019 12:07:00 +0300
Message-Id: <20190909090712.11029-1-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following patches provide support for XRCD and SRQ objects in
pyverbs, including a documentation update, to demonstrate a basic
usage, and a test using these objects.
Preceding this support are a few fixes found on the way: wrong
assignments fixes and cleanup of redundant enum entries.

Maxim Chicherin (12):
  pyverbs: Fix WC creation process
  pyverbs: Fix CQ and PD assignment in QPAttr
  pyverbs: Remove TM enums
  pyverbs: Introducing XRCD class
  pyverbs: Introducing SRQ class
  pyverbs: Support XRC QPs when modifying QP states
  pyverbs: Add XRC to ODPCaps
  Documentation: Document creation of XRCD and SRQ
  tests: Add missing constant in UDResources
  tests: Fixes to to_rts() in RCResources
  tests: Add XRCResources class
  tests: Add XRC ODP test case

 Documentation/pyverbs.md     |  51 ++++++++++
 pyverbs/CMakeLists.txt       |   2 +
 pyverbs/cq.pxd               |   2 +
 pyverbs/cq.pyx               |  47 +++++++---
 pyverbs/device.pxd           |   5 +
 pyverbs/device.pyx           |  49 +++++++++-
 pyverbs/libibverbs.pxd       |  52 ++++++++++-
 pyverbs/libibverbs_enums.pxd |  30 +-----
 pyverbs/pd.pxd               |   1 +
 pyverbs/pd.pyx               |   6 +-
 pyverbs/qp.pxd               |   4 +
 pyverbs/qp.pyx               |  91 ++++++++++++++----
 pyverbs/srq.pxd              |  24 +++++
 pyverbs/srq.pyx              | 176 +++++++++++++++++++++++++++++++++++
 pyverbs/xrcd.pxd             |  17 ++++
 pyverbs/xrcd.pyx             |  91 ++++++++++++++++++
 tests/base.py                | 160 ++++++++++++++++++++++++++-----
 tests/test_cq.py             |   2 -
 tests/test_odp.py            |  32 +++++--
 tests/utils.py               |  48 +++++++++-
 20 files changed, 791 insertions(+), 99 deletions(-)
 mode change 100644 => 100755 Documentation/pyverbs.md
 mode change 100644 => 100755 pyverbs/CMakeLists.txt
 mode change 100644 => 100755 pyverbs/cq.pyx
 mode change 100644 => 100755 pyverbs/device.pxd
 mode change 100644 => 100755 pyverbs/device.pyx
 mode change 100644 => 100755 pyverbs/libibverbs.pxd
 mode change 100644 => 100755 pyverbs/libibverbs_enums.pxd
 mode change 100644 => 100755 pyverbs/qp.pyx
 create mode 100755 pyverbs/srq.pxd
 create mode 100755 pyverbs/srq.pyx
 create mode 100755 pyverbs/xrcd.pxd
 create mode 100755 pyverbs/xrcd.pyx
 mode change 100644 => 100755 tests/base.py
 mode change 100644 => 100755 tests/test_odp.py
 mode change 100644 => 100755 tests/utils.py

-- 
2.21.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C148D91D74
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 08:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHSG6g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 02:58:36 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:53152 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbfHSG6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Aug 2019 02:58:35 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 19 Aug 2019 09:58:30 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7J6wUNC004602;
        Mon, 19 Aug 2019 09:58:30 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 00/14] rdma-core tests infrastructure
Date:   Mon, 19 Aug 2019 09:58:13 +0300
Message-Id: <20190819065827.26921-1-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, rdma-core provides no test suite for users/developers.
This means that for users, there is no way to sanity-check a fresh
installation, and for developers, no comfortable API to write tests
to be shipped along new features.
This series is changing the way we use pyverbs for tests and provides
an easy-to-use classes and methods to make tests development fast.
A testing.md file is available under the Documentation directory,
explaining the design and usage in details.
This PR also unifies the output of the current API tests, so when
executed in verbose mode, the output will be the same for all tests.

Maxim Chicherin (7):
  tests: BaseResources Class
  tests: RDMATestCase
  tests: RCResources and UDResources classes
  tests: ODP requires decorator
  tests: Add traffic helper methods
  tests: Add ODP RC test
  tests: Add ODP UD test

Noa Osherovich (7):
  pyverbs/tests: Rename base class
  pyverbs: Move tests to a stand-alone directory
  build: Add pyverbs-based test to the build
  tests: TrafficResources class
  tests: Fix test locating process
  Documentation: Add background for rdma-core tests
  tests: Unify API tests' output

 CMakeLists.txt                                |  11 +
 Documentation/testing.md                      | 126 ++++++++
 buildlib/pyverbs_functions.cmake              |   7 +
 debian/python3-pyverbs.install                |   2 +
 pyverbs/CMakeLists.txt                        |  17 -
 pyverbs/run_tests.py                          |  22 --
 pyverbs/tests/__init__.py                     |   0
 pyverbs/tests/base.py                         |  23 --
 redhat/rdma-core.spec                         |   2 +
 run_tests.py                                  |  16 +
 suse/rdma-core.spec                           |   2 +
 tests/CMakeLists.txt                          |  15 +
 tests/__init__.py                             |  17 +
 tests/base.py                                 | 293 ++++++++++++++++++
 pyverbs/tests/addr.py => tests/test_addr.py   |   4 +-
 pyverbs/tests/cq.py => tests/test_cq.py       |  10 +-
 .../tests/device.py => tests/test_device.py   |  12 +-
 pyverbs/tests/mr.py => tests/test_mr.py       |  46 ++-
 tests/test_odp.py                             |  41 +++
 pyverbs/tests/pd.py => tests/test_pd.py       |   4 +-
 pyverbs/tests/qp.py => tests/test_qp.py       |   6 +-
 {pyverbs/tests => tests}/utils.py             | 199 ++++++++++++
 22 files changed, 782 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/testing.md
 delete mode 100644 pyverbs/run_tests.py
 delete mode 100644 pyverbs/tests/__init__.py
 delete mode 100644 pyverbs/tests/base.py
 create mode 100644 run_tests.py
 create mode 100644 tests/CMakeLists.txt
 create mode 100644 tests/__init__.py
 create mode 100644 tests/base.py
 rename pyverbs/tests/addr.py => tests/test_addr.py (97%)
 rename pyverbs/tests/cq.py => tests/test_cq.py (97%)
 rename pyverbs/tests/device.py => tests/test_device.py (97%)
 rename pyverbs/tests/mr.py => tests/test_mr.py (90%)
 create mode 100644 tests/test_odp.py
 rename pyverbs/tests/pd.py => tests/test_pd.py (95%)
 rename pyverbs/tests/qp.py => tests/test_qp.py (98%)
 rename {pyverbs/tests => tests}/utils.py (52%)

-- 
2.21.0


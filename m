Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4A3E6F9
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfD2PzS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 11:55:18 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47431 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728501AbfD2PzR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 11:55:17 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 29 Apr 2019 18:55:15 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x3TFtF7l025539;
        Mon, 29 Apr 2019 18:55:15 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 0/4] pyverbs: General improvements
Date:   Mon, 29 Apr 2019 18:55:09 +0300
Message-Id: <20190429155513.30543-1-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series precedes pyverbs' traffic series with some needed changes:
- Some enums were missing.
- Modify some of the user-visible prints for a more readable output
  as well as to avoid an exception thrown when printing an
  uninitialized object.
- Tests: Coverage and performance improvements.
- Add events support.

Noa Osherovich (4):
  pyverbs: Add missing enums
  pyverbs: Changes to print-related functions
  pyverbs/tests: Improvements
  pyverbs: Add events support

 pyverbs/CMakeLists.txt       |   1 +
 pyverbs/cq.pxd               |   3 +
 pyverbs/cq.pyx               |  57 +++++++-
 pyverbs/device.pyx           |  87 +++++++++---
 pyverbs/libibverbs.pxd       |   2 +
 pyverbs/libibverbs_enums.pxd |  60 ++++++++
 pyverbs/tests/base.py        |  23 +++
 pyverbs/tests/cq.py          | 168 ++++++++++------------
 pyverbs/tests/device.py      | 235 ++++++++++++++-----------------
 pyverbs/tests/mr.py          | 265 +++++++++++++++++------------------
 pyverbs/tests/pd.py          |  58 +++-----
 pyverbs/tests/utils.py       |  69 ++++++---
 12 files changed, 587 insertions(+), 441 deletions(-)
 create mode 100644 pyverbs/tests/base.py

-- 
2.17.2


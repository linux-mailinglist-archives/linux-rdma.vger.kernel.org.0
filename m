Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6999164869
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jul 2019 16:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfGJOb5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Jul 2019 10:31:57 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47973 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726617AbfGJOb5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Jul 2019 10:31:57 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 10 Jul 2019 17:31:51 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x6AEVpIi004077;
        Wed, 10 Jul 2019 17:31:51 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 0/4] pyverbs fixes
Date:   Wed, 10 Jul 2019 17:22:47 +0300
Message-Id: <20190710142251.9396-1-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The following is a series of fixes to pyverbs:
The first two patches clean the compilation warning introduces in
Fedora 30.
The third patch fixes a wrong casting.
The last one fixes the handling of bad work requests in post send and
post recv operations.

Maxim Chicherin (1):
  pyverbs: Avoid casting pointers to object type

Noa Osherovich (3):
  pyverbs: Fix Cython future warning during build
  build: Remove warning-causing compilation flag from pyverbs
  pyverbs: Fix assignments of bad work requests

 CMakeLists.txt                   |  7 +++++
 buildlib/pyverbs_functions.cmake |  7 ++++-
 pyverbs/addr.pxd                 |  2 ++
 pyverbs/base.pxd                 |  2 ++
 pyverbs/cq.pxd                   |  3 ++
 pyverbs/cq.pyx                   | 23 ++------------
 pyverbs/device.pxd               |  2 ++
 pyverbs/libibverbs_enums.pxd     |  3 ++
 pyverbs/mr.pxd                   |  2 ++
 pyverbs/pd.pxd                   |  3 ++
 pyverbs/pd.pyx                   |  4 ---
 pyverbs/qp.pxd                   |  3 ++
 pyverbs/qp.pyx                   | 54 ++++++++++++++++++--------------
 pyverbs/wr.pxd                   |  2 ++
 pyverbs/wr.pyx                   | 17 +++-------
 15 files changed, 73 insertions(+), 61 deletions(-)

-- 
2.21.0


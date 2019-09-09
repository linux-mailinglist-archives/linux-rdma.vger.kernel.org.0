Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63AD5AD549
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 11:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbfIIJHT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 05:07:19 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48377 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389605AbfIIJHT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Sep 2019 05:07:19 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 9 Sep 2019 12:07:16 +0300
Received: from reg-l-vrt-059-007.mtl.labs.mlnx (reg-l-vrt-059-007.mtl.labs.mlnx [10.135.59.7])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x8997Fp7028426;
        Mon, 9 Sep 2019 12:07:16 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     linux-rdma@vger.kernel.org, Maxim Chicherin <maximc@mellanox.com>
Subject: [PATCH rdma-core 09/12] tests: Add missing constant in UDResources
Date:   Mon,  9 Sep 2019 12:07:09 +0300
Message-Id: <20190909090712.11029-10-noaos@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909090712.11029-1-noaos@mellanox.com>
References: <20190909090712.11029-1-noaos@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maxim Chicherin <maximc@mellanox.com>

GRH_SIZE constant was missing in class implementation
despite being used by create_mr method.

Signed-off-by: Maxim Chicherin <maximc@mellanox.com>
---
 tests/base.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/base.py b/tests/base.py
index a28e9b9dc466..b9bdaea93c96 100644
--- a/tests/base.py
+++ b/tests/base.py
@@ -274,6 +274,7 @@ class RCResources(TrafficResources):
 class UDResources(TrafficResources):
     UD_QKEY = 0x11111111
     UD_PKEY_INDEX = 0
+    GRH_SIZE = 40
 
     def create_mr(self):
         self.mr = MR(self.pd, self.msg_size + self.GRH_SIZE,
-- 
2.21.0


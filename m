Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB914F19
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 17:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfEFPHs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 11:07:48 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:50124 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727541AbfEFPHr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 11:07:47 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from noaos@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 May 2019 18:07:41 +0300
Received: from reg-l-vrt-059-009.mtl.labs.mlnx (reg-l-vrt-059-009.mtl.labs.mlnx [10.135.59.9])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x46F7edd019922;
        Mon, 6 May 2019 18:07:41 +0300
From:   Noa Osherovich <noaos@mellanox.com>
To:     leon@kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org, Noa Osherovich <noaos@mellanox.com>
Subject: [PATCH rdma-core 07/11] pyverbs: Add missing device capabilities
Date:   Mon,  6 May 2019 18:07:34 +0300
Message-Id: <20190506150738.19477-8-noaos@mellanox.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190506150738.19477-1-noaos@mellanox.com>
References: <20190506150738.19477-1-noaos@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

New device extended capabilities are defined outside the enum. Add
them to pyverbs as well.

Signed-off-by: Noa Osherovich <noaos@mellanox.com>
---
 pyverbs/libibverbs_enums.pxd | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/pyverbs/libibverbs_enums.pxd b/pyverbs/libibverbs_enums.pxd
index b76914208074..85b5092c486f 100644
--- a/pyverbs/libibverbs_enums.pxd
+++ b/pyverbs/libibverbs_enums.pxd
@@ -408,6 +408,9 @@ cdef extern from '<infiniband/verbs.h>':
         IBV_RAW_PACKET_CAP_IP_CSUM          = 1 << 2
         IBV_RAW_PACKET_CAP_DELAY_DROP       = 1 << 3
 
+    cdef unsigned long long IBV_DEVICE_RAW_SCATTER_FCS
+    cdef unsigned long long IBV_DEVICE_PCI_WRITE_END_PADDING
+
 
 cdef extern from "<infiniband/tm_types.h>":
     cpdef enum ibv_tmh_op:
@@ -415,3 +418,6 @@ cdef extern from "<infiniband/tm_types.h>":
         IBV_TMH_RNDV          = 1
         IBV_TMH_FIN           = 2
         IBV_TMH_EAGER         = 3
+
+_IBV_DEVICE_RAW_SCATTER_FCS = IBV_DEVICE_RAW_SCATTER_FCS
+_IBV_DEVICE_PCI_WRITE_END_PADDING = IBV_DEVICE_PCI_WRITE_END_PADDING
-- 
2.17.2


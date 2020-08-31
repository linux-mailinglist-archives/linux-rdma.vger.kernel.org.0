Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557EA257CC3
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 17:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgHaPbT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 11:31:19 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58911 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728826AbgHaPbR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 11:31:17 -0400
Received: from nexussix.ar.arcelik (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 506AB24000C;
        Mon, 31 Aug 2020 15:31:13 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH] infiniband: remove unnecessary fallthrough usage
Date:   Mon, 31 Aug 2020 18:30:34 +0300
Message-Id: <20200831153033.113952-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since /* fallthrough */ comments are deprecated[1], they are being replaced
by new 'fallthrough' pseudo-keyword.

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?\
        highlight=fallthrough#implicit-switch-case-fall-through

This sometimes leads to unreachable code warnings by static analyzers,
particularly in this case, Coverity Scanner. (CID 1466512)

Remove unnecessary 'fallthrough' keywords to prevent dead code
warnings.

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 drivers/infiniband/hw/qib/qib_mad.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_mad.c b/drivers/infiniband/hw/qib/qib_mad.c
index e7789e724f56..f972e559a8a7 100644
--- a/drivers/infiniband/hw/qib/qib_mad.c
+++ b/drivers/infiniband/hw/qib/qib_mad.c
@@ -2322,7 +2322,6 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
 			ret = cc_get_congestion_control_table(ccp, ibdev, port);
 			goto bail;
 
-			fallthrough;
 		default:
 			ccp->status |= IB_SMP_UNSUP_METH_ATTR;
 			ret = reply((struct ib_smp *) ccp);
@@ -2339,7 +2338,6 @@ static int process_cc(struct ib_device *ibdev, int mad_flags,
 			ret = cc_set_congestion_control_table(ccp, ibdev, port);
 			goto bail;
 
-			fallthrough;
 		default:
 			ccp->status |= IB_SMP_UNSUP_METH_ATTR;
 			ret = reply((struct ib_smp *) ccp);
-- 
2.28.0


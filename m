Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BEF3F0D0C
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Aug 2021 22:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhHRU6W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Aug 2021 16:58:22 -0400
Received: from saphodev.broadcom.com ([192.19.11.229]:41472 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233798AbhHRU6V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Aug 2021 16:58:21 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id DFBD77A21;
        Wed, 18 Aug 2021 13:57:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com DFBD77A21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1629320266;
        bh=DwSY61xYq492Pv4BaUB7pMO5Me20+0qO76ocGtgwS94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdRzQGN0O7bttkZ3QwRDIQjdD2huraA+gG/7xLnssl7tMTFgMfj5s3pVQsXorxETn
         Q9qxCbytaVE+haqt88Feu0sfsCdSHfT8sty7hbt9ks6xIW+omxnvJog4PDtDe+2FZx
         Ht4ySbKQqSCev0hlmdyNjtexxUdAv5Q/KNI/9aBo=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Subject: [PATCH rdma-rc 3/3] RDMA/bnxt_re: Fix query SRQ failure
Date:   Wed, 18 Aug 2021 13:57:36 -0700
Message-Id: <1629320256-4034-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1629320256-4034-1-git-send-email-selvin.xavier@broadcom.com>
References: <1629320256-4034-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fill the missing parameters for the FW command while
querying SRQ.

Fixes: 37cb11acf1f7 ("RDMA/bnxt_re: Add SRQ support for Broadcom adapters")
Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index d4d4959..312bf25 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -713,6 +713,8 @@ int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 	sbuf = bnxt_qplib_rcfw_alloc_sbuf(rcfw, sizeof(*sb));
 	if (!sbuf)
 		return -ENOMEM;
+	req.resp_size = sizeof(*sb) / BNXT_QPLIB_CMDQE_UNITS;
+	req.srq_cid = cpu_to_le32(srq->id);
 	sb = sbuf->sb;
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req, (void *)&resp,
 					  (void *)sbuf, 0);
-- 
2.5.5


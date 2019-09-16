Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02EB32FF
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Sep 2019 03:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfIPBgP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Sep 2019 21:36:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfIPBgP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 15 Sep 2019 21:36:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 696C8878E44;
        Mon, 16 Sep 2019 01:36:15 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1708660BF3;
        Mon, 16 Sep 2019 01:36:12 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     linux-rdma@vger.kernel.org, bvanassche@acm.org
Cc:     Honggang Li <honli@redhat.com>
Subject: [rdma-core patch] srp_daemon: print maximum initiator to target IU size
Date:   Mon, 16 Sep 2019 09:36:07 +0800
Message-Id: <20190916013607.9474-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Mon, 16 Sep 2019 01:36:15 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Honggang Li <honli@redhat.com>

The 'Send Message Size' field of IOControllerProfile attributes
contains the maximum initiator to target IU size.

When there is something wrong with SRP login to a third party
SRP target, whose ib_srpt parameters can't be collected with
ordinary method, dump the 'Send Message Size' may help us to
diagnose the problem.

Signed-off-by: Honggang Li <honli@redhat.com>
---
 srp_daemon/srp_daemon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/srp_daemon/srp_daemon.c b/srp_daemon/srp_daemon.c
index 337b21c7..90533c77 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -1022,6 +1022,8 @@ static int do_port(struct resources *res, uint16_t pkey, uint16_t dlid,
 			pr_human("        vendor ID: %06x\n", be32toh(target->ioc_prof.vendor_id) >> 8);
 			pr_human("        device ID: %06x\n", be32toh(target->ioc_prof.device_id));
 			pr_human("        IO class : %04hx\n", be16toh(target->ioc_prof.io_class));
+			pr_human("        Maximum initiator to target IU size: %d\n",
+				 be32toh(target->ioc_prof.send_size));
 			pr_human("        ID:        %s\n", target->ioc_prof.id);
 			pr_human("        service entries: %d\n", target->ioc_prof.service_entries);
 
-- 
2.21.0


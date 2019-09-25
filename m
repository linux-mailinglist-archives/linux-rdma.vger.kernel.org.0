Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF85EBD5C6
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 02:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390105AbfIYAmP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Sep 2019 20:42:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389492AbfIYAmP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Sep 2019 20:42:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F92E3082131;
        Wed, 25 Sep 2019 00:42:15 +0000 (UTC)
Received: from dhcp-128-227.nay.redhat.com (unknown [10.66.128.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF25C60852;
        Wed, 25 Sep 2019 00:42:13 +0000 (UTC)
From:   Honggang LI <honli@redhat.com>
To:     bvanassche@acm.org
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Honggang Li <honli@redhat.com>
Subject: [rdma-core patch v2] srp_daemon: print maximum initiator to target IU size
Date:   Wed, 25 Sep 2019 08:42:00 +0800
Message-Id: <20190925004200.32401-1-honli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 25 Sep 2019 00:42:15 +0000 (UTC)
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
index 337b21c7..cf046b79 100644
--- a/srp_daemon/srp_daemon.c
+++ b/srp_daemon/srp_daemon.c
@@ -1022,6 +1022,8 @@ static int do_port(struct resources *res, uint16_t pkey, uint16_t dlid,
 			pr_human("        vendor ID: %06x\n", be32toh(target->ioc_prof.vendor_id) >> 8);
 			pr_human("        device ID: %06x\n", be32toh(target->ioc_prof.device_id));
 			pr_human("        IO class : %04hx\n", be16toh(target->ioc_prof.io_class));
+			pr_human("        Maximum size of Send Messages in bytes: %d\n",
+				 be32toh(target->ioc_prof.send_size));
 			pr_human("        ID:        %s\n", target->ioc_prof.id);
 			pr_human("        service entries: %d\n", target->ioc_prof.service_entries);
 
-- 
2.21.0


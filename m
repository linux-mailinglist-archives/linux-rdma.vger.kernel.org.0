Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE5D147A
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbfJIQti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:49:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731145AbfJIQti (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Oct 2019 12:49:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB3E36696F
        for <linux-rdma@vger.kernel.org>; Wed,  9 Oct 2019 16:49:37 +0000 (UTC)
Received: from dddlaptop.redhat.com (ovpn-117-216.phx2.redhat.com [10.3.117.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 880DE5C1D6;
        Wed,  9 Oct 2019 16:49:37 +0000 (UTC)
From:   Donald Dutile <ddutile@redhat.com>
To:     linux-rdma@vger.kernel.org
Cc:     ddutile@redhat.com
Subject: [PATCH] ib/srp: Add missing new line after displaying fast_io_fail_tmo param
Date:   Wed,  9 Oct 2019 12:49:37 -0400
Message-Id: <20191009164937.21989-1-ddutile@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 09 Oct 2019 16:49:37 +0000 (UTC)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Long-time missing new-line in sysfs output.
Simply add it.

Signed-off-by: Donald Dutile <ddutile@redhat.com>
---
 drivers/infiniband/ulp/srp/ib_srp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index cee855e85705..8fff3d6bce53 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -165,9 +165,9 @@ static int srp_tmo_get(char *buffer, const struct kernel_param *kp)
 	int tmo = *(int *)kp->arg;
 
 	if (tmo >= 0)
-		return sprintf(buffer, "%d", tmo);
+		return sprintf(buffer, "%d\n", tmo);
 	else
-		return sprintf(buffer, "off");
+		return sprintf(buffer, "off\n");
 }
 
 static int srp_tmo_set(const char *val, const struct kernel_param *kp)
-- 
2.18.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C4C375D80
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 01:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhEFXiN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 19:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhEFXiM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 19:38:12 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2D1C061574
        for <linux-rdma@vger.kernel.org>; Thu,  6 May 2021 16:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-Id:Date:Cc:To:From;
        bh=y26Xj1XG2gca4jDBkijfpjPGS784fVXX09iFUz+bJbg=; b=noRlAoeiy/PCKExiPjsoaUFqwr
        Yy+NcpnTUaPdYagry8GnBlklDTGlbHVmq43NvMhMQTUxOoixAs88EMvfNxiuPro0dV8PgSa9JW1oC
        7uDydx59NSJDLRDx2q+F+Ceso/a7pFfMvKax9WmmryktCj6qhhkmPH3srV5LTToXO/PAmQwhi/n9i
        QhsZxu8pmxKc0qBV+yaUc+h7IYST5UzRQmywFWPSNa7PeX29IJKcx+9zP1Cqdq30oEzzqPFQKXrgp
        5KaP1jpt0B0qVPacFbXV3Ku8GLrXnxRbUb5SE7WM6SgxkMEulTIwApWc2HU3B7eTECsxolWPf1JSq
        YsyunE7U+g5PFY0HyYBlUZ8sbXr/nDoHVzSFARLT0s2UXQAnrRGM2P7QDvZtZBE+8t9Vz3HFaeyre
        BnaDQRzlPGCuR/WFFJKDZi3FznZ8qP+Z+5+uV3LP6+QoajsqH7nc+VHnwVkHbWwD1whyLm3Gcbtuh
        n/INrwC0dLl3lQ6KTau0Zr3/;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lenYK-0004IL-PF; Thu, 06 May 2021 23:37:08 +0000
From:   Stefan Metzmacher <metze@samba.org>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 02/31] rdma/siw: call smp_mb() after mem->stag_valid = 0 in siw_invalidate_stag() too
Date:   Fri,  7 May 2021 01:36:08 +0200
Message-Id: <04384dc3dd5396ae770aebf5434810f489605c63.1620343860.git.metze@samba.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1620343860.git.metze@samba.org>
References: <cover.1620343860.git.metze@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We already do the same in siw_mr_drop_mem().

Fixes: 2251334dcac9 ("rdma/siw: application buffer management")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 61c17db70d65..8596ce1ef5a3 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -309,6 +309,8 @@ int siw_invalidate_stag(struct ib_pd *pd, u32 stag)
 	 * state if invalidation is requested. So no state check here.
 	 */
 	mem->stag_valid = 0;
+	/* make STag invalid visible asap */
+	smp_mb();
 
 	siw_dbg_pd(pd, "STag 0x%08x now invalid\n", stag);
 out:
-- 
2.25.1


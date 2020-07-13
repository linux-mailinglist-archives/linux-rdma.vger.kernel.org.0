Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670E921E2A2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2020 23:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgGMVsg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jul 2020 17:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGMVsg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jul 2020 17:48:36 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F41EC061755;
        Mon, 13 Jul 2020 14:48:36 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id A0111BC0D1;
        Mon, 13 Jul 2020 21:48:32 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     sagi@grimberg.me, maxg@mellanox.com, dledford@redhat.com,
        jgg@ziepe.ca, bvanassche@acm.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, target-devel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH v2] IB: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 23:48:26 +0200
Message-Id: <20200713214826.42487-1-grandmaster@al2klimov.de>
In-Reply-To: <20200713135031.GA25301@ziepe.ca>
References: <20200713135031.GA25301@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Just drivers/infiniband. There's nothing for include/rdma.

 drivers/infiniband/ulp/iser/Kconfig | 2 +-
 drivers/infiniband/ulp/srp/Kconfig  | 2 +-
 drivers/infiniband/ulp/srpt/Kconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/Kconfig b/drivers/infiniband/ulp/iser/Kconfig
index 3016a0c9a9f0..6ba73ae1291b 100644
--- a/drivers/infiniband/ulp/iser/Kconfig
+++ b/drivers/infiniband/ulp/iser/Kconfig
@@ -9,5 +9,5 @@ config INFINIBAND_ISER
 	  that speak iSCSI over iSER over InfiniBand.
 
 	  The iSER protocol is defined by IETF.
-	  See <http://www.ietf.org/rfc/rfc5046.txt>
+	  See <https://www.ietf.org/rfc/rfc5046.txt>
 	  and <http://members.infinibandta.org/kwspub/spec/Annex_iSER.PDF>
diff --git a/drivers/infiniband/ulp/srp/Kconfig b/drivers/infiniband/ulp/srp/Kconfig
index 67cd63d1399c..c33f4e5fa4d7 100644
--- a/drivers/infiniband/ulp/srp/Kconfig
+++ b/drivers/infiniband/ulp/srp/Kconfig
@@ -9,5 +9,5 @@ config INFINIBAND_SRP
 	  InfiniBand.
 
 	  The SRP protocol is defined by the INCITS T10 technical
-	  committee.  See <http://www.t10.org/>.
+	  committee.  See <https://www.t10.org/>.
 
diff --git a/drivers/infiniband/ulp/srpt/Kconfig b/drivers/infiniband/ulp/srpt/Kconfig
index 4b5d9b792cfa..f63b34d9ae32 100644
--- a/drivers/infiniband/ulp/srpt/Kconfig
+++ b/drivers/infiniband/ulp/srpt/Kconfig
@@ -10,4 +10,4 @@ config INFINIBAND_SRPT
 	  that supports the RDMA protocol. Currently the RDMA protocol is
 	  supported by InfiniBand and by iWarp network hardware. More
 	  information about the SRP protocol can be found on the website
-	  of the INCITS T10 technical committee (http://www.t10.org/).
+	  of the INCITS T10 technical committee (https://www.t10.org/).
-- 
2.27.0


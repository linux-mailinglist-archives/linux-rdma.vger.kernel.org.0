Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970A09CEAF
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Aug 2019 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfHZLye (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Aug 2019 07:54:34 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:13256 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfHZLye (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Aug 2019 07:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566820473; x=1598356473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E8Xo8buALtBniYsp15yu73NnEuEYrhXWuHF/Yxs14Jw=;
  b=IRNpM9Yq3/VNhOuKUUShm1h7FkFGBswouRgrc+IF7eu/jmwKINNmvQ3u
   QG8kDspOPmVZyBgVNwxfONzuPlLHDuRQj++WjUWJeYOdgO3vmLLlWd5Zy
   H5F8ntt0IaLD/Jwf9RwW/CCmz8xH2GGeglkxHoNK6LgFwiGfXLJlmcBPG
   c=;
X-IronPort-AV: E=Sophos;i="5.64,433,1559520000"; 
   d="scan'208";a="823767954"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 26 Aug 2019 11:54:31 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 7A8FF221F2C;
        Mon, 26 Aug 2019 11:54:31 +0000 (UTC)
Received: from EX13D22EUB001.ant.amazon.com (10.43.166.145) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 11:54:31 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D22EUB001.ant.amazon.com (10.43.166.145) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 26 Aug 2019 11:54:29 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.144) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Mon, 26 Aug 2019 11:54:26 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Daniel Kranzdorf" <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
Subject: [PATCH for-next 2/2] RDMA/efa: Use existing FIELD_SIZEOF macro
Date:   Mon, 26 Aug 2019 14:53:50 +0300
Message-ID: <20190826115350.21718-3-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826115350.21718-1-galpress@amazon.com>
References: <20190826115350.21718-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use FIELD_SIZEOF macro instead of hard coding it in field_avail macro.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 1e23c621a419..4edae89e8e3c 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -148,7 +148,7 @@ static inline struct efa_ah *to_eah(struct ib_ah *ibah)
 }
 
 #define field_avail(x, fld, sz) (offsetof(typeof(x), fld) + \
-				 sizeof(((typeof(x) *)0)->fld) <= (sz))
+				 FIELD_SIZEOF(typeof(x), fld) <= (sz))
 
 #define is_reserved_cleared(reserved) \
 	!memchr_inv(reserved, 0, sizeof(reserved))
-- 
2.22.0


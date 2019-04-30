Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2596F23C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 10:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbfD3ItA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 04:49:00 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56963 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3ItA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 04:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556614139; x=1588150139;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=yJJAX82qFb8Rq8GpQFkbkk6Mtw/LHe8vm19IN/lFYFY=;
  b=HjmI57UiZZ7asC4kH8dF2uHyG4V6lOR8KHe3Pvs8dj9Hl9DC/WcKesx7
   6IsoRcgnYxoyR0TN9QQMGHZsFdRqcAPqy/mtJ4YaSO0tYAVt4IvtH1DBH
   DGHVEPZ7ZV2vM0jt+BpyXRK098ZP1h8jBpIHQs2cJkV/hbRW8MsDTVVFX
   U=;
X-IronPort-AV: E=Sophos;i="5.60,413,1549929600"; 
   d="scan'208";a="802062775"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Apr 2019 08:47:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-74cf8b49.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x3U8lGZm057462
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 30 Apr 2019 08:47:18 GMT
Received: from EX13D19EUB002.ant.amazon.com (10.43.166.78) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Apr 2019 08:47:17 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D19EUB002.ant.amazon.com (10.43.166.78) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Apr 2019 08:47:16 +0000
Received: from galpress-VirtualBox.amazon.com (10.95.87.116) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 30 Apr 2019 08:47:14 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Gal Pressman <galpress@amazon.com>,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH for-next] RDMA/uverbs: Initialize udata struct on destroy flows
Date:   Tue, 30 Apr 2019 11:46:39 +0300
Message-ID: <1556613999-14823-1-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Cited commit introduced the udata parameter to different destroy flows
but the uapi method definition does not have udata (i.e has_udata flag
is not set). As a result, an uninitialized udata struct is being passed
down to the driver callbacks.

Fix that by clearing the driver udata even in cases where has_udata flag
is not set.

Fixes: c4367a26357b ("IB: Pass uverbs_attr_bundle down ib_x destroy path")
Cc: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 drivers/infiniband/core/uverbs_ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index cfbef25b3a73..829b0c6944d8 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -453,6 +453,8 @@ static int ib_uverbs_run_method(struct bundle_priv *pbundle,
 		uverbs_fill_udata(&pbundle->bundle,
 				  &pbundle->bundle.driver_udata,
 				  UVERBS_ATTR_UHW_IN, UVERBS_ATTR_UHW_OUT);
+	else
+		pbundle->bundle.driver_udata = (struct ib_udata){};
 
 	if (destroy_bkey != UVERBS_API_ATTR_BKEY_LEN) {
 		struct uverbs_obj_attr *destroy_attr =
-- 
2.7.4


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75F3EB82
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Apr 2019 22:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfD2UQJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Apr 2019 16:16:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37196 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbfD2UQI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Apr 2019 16:16:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id y5so918025wma.2
        for <linux-rdma@vger.kernel.org>; Mon, 29 Apr 2019 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3D2hgpqHMF7kzr2+nWYXGMvBMFX9zuYhDVKkxyQa+jY=;
        b=ZTXwB3qQ3O7GgJpoToBUHpQ/1MjEQUYs6ONq7YMdNVpznk/xHw0iTQZgXhtw4H5bzj
         OpteffM67ha2r2JufThqCE1IJdb2vlnl1HYfvU8Nh/T7d1wzyYZoQF64jz2jwpwhw89i
         QwrP3wAzWWOQ2n4ka4fbW0Ulv+5+mukpZEJiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3D2hgpqHMF7kzr2+nWYXGMvBMFX9zuYhDVKkxyQa+jY=;
        b=nhxFKMYYr2Vl75oQMZ1EbH1gx//WJyMz7SGtA4S2WEAuyYLnvAG796TnE7csa4h4h8
         /EgQf3L6FCfjFxVtDClorErr6kyBc/2IsJDteKLQoFgmeDRSC53O/7Aqk9F1IVkDeHHE
         /vie9Ywi+niT9hmHKTF/nl6fzuw3k5J5FZQhUOEU6WSmpGonEqqlLwuTlX2yoOkHqkSw
         R7io4M8F4Y2aMgLpRVO49qLis+vBI/gWPB2GAWLwoMEinCqZdjTZdXiurrva0gNVTufM
         6JdYyY9axNHAXGf7uhMAb3kmSGzfsK6BdaOf9rdbgbxBq5X1GqMqums2QYeA9hldQETp
         u+Rw==
X-Gm-Message-State: APjAAAVV/jjX5MBWmfDK5GZDTqs/NXwU0w0O69lF6ya7DqSpaqEuNf2P
        OmtlJA/+OdfBsQq1VjqDzFyDqw==
X-Google-Smtp-Source: APXvYqwVu1h/SWFMhK3gj/aqga6R6hNG9QoPKzFnGoYB3o3Vj5sVqISj0973gLaYlYbSFD7vEzOusw==
X-Received: by 2002:a1c:a384:: with SMTP id m126mr487272wme.99.1556568966933;
        Mon, 29 Apr 2019 13:16:06 -0700 (PDT)
Received: from localhost.localdomain (ip-93-97.sn2.clouditalia.com. [83.211.93.97])
        by smtp.gmail.com with ESMTPSA id k6sm22864019wrd.20.2019.04.29.13.16.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 13:16:06 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        stable@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 5/5] IB/hfi1: Fix improper uses of smp_mb__before_atomic()
Date:   Mon, 29 Apr 2019 22:15:01 +0200
Message-Id: <1556568902-12464-6-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1556568902-12464-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This barrier only applies to the read-modify-write operations; in
particular, it does not apply to the atomic_read() primitive.

Replace the barrier with an smp_mb().

Fixes: 856cc4c237add ("IB/hfi1: Add the capability for reserved operations")
Cc: stable@vger.kernel.org
Reported-by: "Paul E. McKenney" <paulmck@linux.ibm.com>
Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
---
 drivers/infiniband/sw/rdmavt/qp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index a34b9a2a32b60..b64fd151d31fb 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1863,11 +1863,11 @@ static inline int rvt_qp_is_avail(
 	u32 reserved_used;
 
 	/* see rvt_qp_wqe_unreserve() */
-	smp_mb__before_atomic();
+	smp_mb();
 	reserved_used = atomic_read(&qp->s_reserved_used);
 	if (unlikely(reserved_op)) {
 		/* see rvt_qp_wqe_unreserve() */
-		smp_mb__before_atomic();
+		smp_mb();
 		if (reserved_used >= rdi->dparms.reserved_operations)
 			return -ENOMEM;
 		return 0;
@@ -1882,7 +1882,7 @@ static inline int rvt_qp_is_avail(
 		avail = slast - qp->s_head;
 
 	/* see rvt_qp_wqe_unreserve() */
-	smp_mb__before_atomic();
+	smp_mb();
 	reserved_used = atomic_read(&qp->s_reserved_used);
 	avail =  avail - 1 -
 		(rdi->dparms.reserved_operations - reserved_used);
-- 
2.7.4


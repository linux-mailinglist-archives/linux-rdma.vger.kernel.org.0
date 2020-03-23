Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58F218FCF8
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2020 19:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgCWSqa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Mar 2020 14:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbgCWSqa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Mar 2020 14:46:30 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 018A0205ED;
        Mon, 23 Mar 2020 18:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584989188;
        bh=EwqtWD5ceSiULQFGAZzBuvuXmIaTIQkijVB3XLObgu8=;
        h=Date:From:To:Subject:From;
        b=pWVyi6cjWFFeAgEDSSIhaJrmMC8QmsKDPE+GnicylDKL0JB5Z6SrzSotXffJEEEAt
         bYu7cq+xo6IEUKfkTsTj4SM7ZqZay0fwscxZPJg2/46cMVjnMAn/vvvoB2WOimcVlR
         dQ1SvVu7H7EmerYlc9XlV0cj5yH9qEJrXAwezDGo=
Date:   Mon, 23 Mar 2020 11:46:27 -0700
From:   akpm@linux-foundation.org
To:     akpm@linux-foundation.org, bmt@zurich.ibm.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject:  [patch 1/1] drivers/infiniband/sw/siw/siw_qp_rx.c:
 suppress uninitialized var warning
Message-ID: <20200323184627.ZWPg91uin%akpm@linux-foundation.org>
User-Agent: s-nail v14.8.16
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Andrew Morton <akpm@linux-foundation.org>
Subject: drivers/infiniband/sw/siw/siw_qp_rx.c: suppress uninitialized var warning

drivers/infiniband/sw/siw/siw_qp_rx.c: In function siw_proc_send:
./include/linux/spinlock.h:288:3: warning: flags may be used uninitialized in this function [-Wmaybe-uninitialized]
   _raw_spin_unlock_irqrestore(lock, flags); \
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/sw/siw/siw_qp_rx.c:335:16: note: flags was declared here
  unsigned long flags;

Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/infiniband/sw/siw/siw_qp_rx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/sw/siw/siw_qp_rx.c~drivers-infiniband-sw-siw-siw_qp_rxc-suppress-uninitialized-var-warning
+++ a/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -332,7 +332,7 @@ static struct siw_wqe *siw_rqe_get(struc
 	struct siw_srq *srq;
 	struct siw_wqe *wqe = NULL;
 	bool srq_event = false;
-	unsigned long flags;
+	unsigned long uninitialized_var(flags);
 
 	srq = qp->srq;
 	if (srq) {
_

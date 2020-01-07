Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A42132F7C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 20:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgAGTax (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 14:30:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51318 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGTaw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 14:30:52 -0500
Received: by mail-pj1-f67.google.com with SMTP id j11so6449pjs.1;
        Tue, 07 Jan 2020 11:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ydzbsY0i6MRr67P6Q3t/fs+mF8B+uFgZNEmwYDqmlq4=;
        b=reG5fXVibdr1/s8/SEGRIYgTyVBxOrtDm7KwQso8puDhJZxksCbfim8QllpxbDifoQ
         mS3J0KTvMA6FXU4JkXC8Pysm+hTpffxlUDJgxr+ftSOjddhSdlLVP8IHRctJN5TpHJgF
         QDMhdwBxf8ghJ/wiA/r/okq4FOGA3eeT0GS9ddHnDva/+js7icy2YYSbidm70QuFZExR
         Tgs9j9vXOGz0Rqwd1fwr0l9Kc6Qazv4qoxowPYg4ob0QYkQ2iVBnq7ZU4Q7BNR61m5eC
         v9+kyXWuSjA8jZuAJqmT4AFBQdajI68kaPZQv7cFNLjTcJV9zLDBVDo5AQajmeBjsDRn
         eI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ydzbsY0i6MRr67P6Q3t/fs+mF8B+uFgZNEmwYDqmlq4=;
        b=Q1Mm6Eec6k3r9iqFezqJ8asJj4iTH0w89KpQPohGKBeA59nibXDU3IXGFpCTqtG/IJ
         XRSPmZ5A344tsGHTb2mWMhe8665jJzIwK8wsgjEoqml4g3cvUJyFQAytqFjXNq7s0FsL
         EOh53yvYYRCuY+6mZmgumqVjUYRDR5KOazLvFz2APLXfhSWF7jqOYoYogFuEDA2P7+/j
         hboz+CA3b7YM+4bSb0q7eLJYChRjjhjyAxJg1QJtcRgIBrXCOCmWASU2sUpcxs6AqC+w
         v7lqfBFjrDSm4UxDLL2GKqrjVdxM/qU22Z+5fxG+s+cHBWYso1SZ4sPvMVUFINap/7eO
         Jv/A==
X-Gm-Message-State: APjAAAWdPWHahM0B/ffT8EfSEDk3F+3j6lcEWRSut+9cx3zK4MBgGgCi
        +9cqM0am1uSibL41Zm3DMvg=
X-Google-Smtp-Source: APXvYqyT8DiyCXnAXgGXM1MjaexNfnV7NDyjZ9hYDYGqwl0OuJyFXQ/FDcVHv+tz7Sd8H+/yMOK1tQ==
X-Received: by 2002:a17:902:c509:: with SMTP id o9mr1305510plx.112.1578425451687;
        Tue, 07 Jan 2020 11:30:51 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee3:fd53:8500:6ea8:4ef2:c9be])
        by smtp.gmail.com with ESMTPSA id j9sm357775pff.6.2020.01.07.11.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:30:51 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org
Cc:     rcu@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 2/3] infiniband: hw: qib: qib_verbs: Use built-in RCU list checking
Date:   Wed,  8 Jan 2020 01:00:39 +0530
Message-Id: <20200107193039.22836-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Use built-in RCU and lock checking for list_for_each_entry_rcu
by passing cond argument to it.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 drivers/infiniband/hw/qib/qib_verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 33778d451b82..845ba888734e 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -329,7 +329,8 @@ void qib_ib_rcv(struct qib_ctxtdata *rcd, void *rhdr, void *data, u32 tlen)
 		if (mcast == NULL)
 			goto drop;
 		this_cpu_inc(ibp->pmastats->n_multicast_rcv);
-		list_for_each_entry_rcu(p, &mcast->qp_list, list)
+		list_for_each_entry_rcu(p, &mcast->qp_list, list,
+					lock_is_held(&(ibp->rvp.lock).dep_map))
 			qib_qp_rcv(rcd, hdr, 1, data, tlen, p->qp);
 		/*
 		 * Notify rvt_multicast_detach() if it is waiting for us
-- 
2.17.1


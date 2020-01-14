Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E6813AF42
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 17:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgANQZ2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 11:25:28 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50301 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANQZ2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 11:25:28 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so5915714pjb.0;
        Tue, 14 Jan 2020 08:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GPzrzY9F39Rp14jkQHqPK+Xq5V2Z3YersgLJxHHp4yg=;
        b=izTvq/7KiP2J2spCG7hAbuJSGJDDDjc4ReYE2M+qUMQ+pTxOEGpx7dJXtPxmsjB4jL
         0G+fzXhrLEVlfmOBVbMqpJ9oi7lVD5hpN0DpzMttJ4PEpXukzsPyJn2S1W7ytkptHlgc
         gav4InYivRXe4F8mY9sPsXclSGLh0pJEm97ZYvAgNjEkJWXTCe/HLeJUOE99xYoggcIz
         3ud/HTBl3xsd009nZDrRcsgBsnB6DDTTQPCQF45Vj90+wUqBGKngEG/KLaa0E/fmpBzj
         Wif8vqov0bk3vfv1M413NSs1xb2XPAncuWKfYdAzxXOoyNWHUeEhYrmRoDNL7oQxHmTp
         Wccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GPzrzY9F39Rp14jkQHqPK+Xq5V2Z3YersgLJxHHp4yg=;
        b=Wi3El/xUGtOAJZuOnWPu1kIi+jt4OXyUP2RUKFidpgRfiYV7YoPaGBFoJu0C2IMl5p
         qXMUNAldDz1AG9g+MiFcOj9xJPGTR3CBs2OUREmcXIGp+/zOlIyk2wtoBYF97psuVTH3
         khNPgbS4NTolvbnsrt9GzmDxzVD0ajRKr8ZyckTJF34/5Ac+GmrYRB+cyHfB6WyvFrrW
         V4b3n+lJ/Z+nE3fjufoSPKNLcMnOuVzFFxPONnIOXR8Fhi2BnI8QGhdv8AVe+MiYufBd
         EL/I/HQ6tRJW8fYjk6LR7a3xdlZl1Tzqi9Awnp+YWCYdSy0NcABINpirZ24ZNe4OFynU
         GWPw==
X-Gm-Message-State: APjAAAUNXW2u39k0wae4r2b8iMhnkmar37s5bRU5TtCe/SOnWqY7kzfZ
        zJhHKTwJEpk10puVr+z5shE=
X-Google-Smtp-Source: APXvYqx9Q8mYgC/vWsODDnktfF+o7uQM2Yy9FVhF+6HjsdMb4D7DCRFfMntMB9aRDbyFKkD+F9gWdw==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr21271321plo.57.1579019126949;
        Tue, 14 Jan 2020 08:25:26 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee7:f789:438:77e9:83ea:bb95])
        by smtp.gmail.com with ESMTPSA id v10sm17975379pgk.24.2020.01.14.08.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:25:26 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     mike.marciniszyn@intel.com, dennis.dalessandro@intel.com,
        jgg@ziepe.ca, paulmck@kernel.org
Cc:     joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 2/3] infiniband: hw: qib: qib_verbs: Use built-in RCU list checking
Date:   Tue, 14 Jan 2020 21:55:11 +0530
Message-Id: <20200114162511.20335-1-madhuparnabhowmik04@gmail.com>
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
 drivers/infiniband/hw/qib/qib_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 33778d451b82..df93fdc8a2fd 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -329,7 +329,7 @@ void qib_ib_rcv(struct qib_ctxtdata *rcd, void *rhdr, void *data, u32 tlen)
 		if (mcast == NULL)
 			goto drop;
 		this_cpu_inc(ibp->pmastats->n_multicast_rcv);
-		list_for_each_entry_rcu(p, &mcast->qp_list, list)
+		list_for_each_entry_rcu(p, &mcast->qp_list, list, lockdep_is_held(&(ibp->rvp.lock)))
 			qib_qp_rcv(rcd, hdr, 1, data, tlen, p->qp);
 		/*
 		 * Notify rvt_multicast_detach() if it is waiting for us
-- 
2.17.1


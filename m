Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954EA13AF3A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgANQY2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 11:24:28 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36373 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANQY2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 11:24:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so6828113pfb.3;
        Tue, 14 Jan 2020 08:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PDyuI6D5hJtH0+thVw4r/qR9DD4Csl28GlClVXYvOmo=;
        b=V2E6iTOF2PVQVslEQICUxmidoKU9xM7zyf01P1l8489cYNbLJV+ZZQtrMLKoe+T8eg
         +RvB47tw077vmFFz1SAkZawppGOeh5OaoMD9v2r5r1y94MTQOQ6ddLw8/VsovLd9ksgB
         NRfbzmyWdVy3/z1cel1683RKLbEehtnBUjZFDT9EgMVCocxLnMwj/o8KvPBRJEnJFrTE
         JkPCEEOTnwhprwu9BJGSmZVnaIEEWLsJ7amXbOu8f9YNbGqjmxFz/NVL57hroXB+ioMA
         3NljDF2X1l1v6dnYyjtA60qgRV+7ya0pidazHJ7gkZ7fLKb0XTCN8wyGHq696y0+STxM
         qqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PDyuI6D5hJtH0+thVw4r/qR9DD4Csl28GlClVXYvOmo=;
        b=U2rl4GuV9yk1zWnlb5QpZ+DPzKQo2AC9iRZ8kP4LG/i/u2zrb+oG31fFVoqrR5gouH
         o6lzB0pKFH+6cLm7rqKluX6Z1m58jsnLVa8zyQlrXTGbhrQXdMxoEWYxDgxERTPT2DFi
         mVzMrplsKKcd2bDe20mzvgMhDNDJ0650fke0pugNDQtodenu7aOQHCStwyE9jRaesiem
         3W9m4bEt5gMXYVyp9ksNbvZaFhf/HTAFbas7eYW0ntYyj2I/rygLIxfwcI3QOp1rxZ1z
         fdF2TvtW9Z0ejRQzFdc5DwJxGQr5NmzgiLnqVZufQx3c93UFogEZ4QBh+ZSrAfcY/goJ
         EavA==
X-Gm-Message-State: APjAAAVuljGlpVuAFnTlJY7ZHvyxkpkKguxmzuydeYN0XtOBRSEFP9xD
        uTNnOGKhpGulhYW1NtKL/sY=
X-Google-Smtp-Source: APXvYqz88bNIaPHzcim/6S/uUF9DpjERKnfgOQ8Qhg0gQstgjbriVUc2j5BW+2+pkvXrCW1t1Hmc0Q==
X-Received: by 2002:a65:56c6:: with SMTP id w6mr28444928pgs.167.1579019067136;
        Tue, 14 Jan 2020 08:24:27 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee7:f789:438:77e9:83ea:bb95])
        by smtp.gmail.com with ESMTPSA id s20sm17511918pjn.2.2020.01.14.08.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:24:26 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     mike.marciniszyn@intel.com, dennis.dalessandro@intel.com,
        jgg@ziepe.ca, paulmck@kernel.org
Cc:     joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list checking
Date:   Tue, 14 Jan 2020 21:53:45 +0530
Message-Id: <20200114162345.19995-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

list_for_each_entry_rcu has built-in RCU and lock checking.
Pass cond argument to list_for_each_entry_rcu.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 drivers/infiniband/hw/hfi1/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 089e201d7550..22f2d4fd2577 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -515,7 +515,7 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
 				       opa_get_lid(packet->dlid, 9B));
 		if (!mcast)
 			goto drop;
-		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
+		list_for_each_entry_rcu(p, &mcast->qp_list, list, lockdep_is_held(&(ibp->rvp.lock))) {
 			packet->qp = p->qp;
 			if (hfi1_do_pkey_check(packet))
 				goto drop;
-- 
2.17.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBC0132D2E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 18:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgAGRgs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 12:36:48 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55527 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgAGRgr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 12:36:47 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so80892pjz.5;
        Tue, 07 Jan 2020 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yEpRHlcDF4psUPPX8udaCtEP3gg4YAcBzZqIRmvDq4M=;
        b=O45qqj0aDDULssDuKLQcH16n+Zkv27jPGry9/wMjWy0wRqXphQim2gedId/p3u4n2Z
         MMcmLTugiChCJ7XpCS0cGoXvkAUaTZCdA68ICgGDyGESgXIrKDek3SK5U9jL9ggoBXKi
         /QVCQV+SXMbuh3h4lzYjs4AmZAXZ8R82e/Rz//ukbWs9tLnHy3FyBZsXgved9Bf6PNdH
         C47yCiHk9ag1bygHICUnu52JC3Q84XJSjP7qHGcrb+lh/8JLZruI1NBnArcirWoER96h
         gGhphUznyXUT6/c8h+3fjnCkTa5SD9fnFzBHJWF4xI2QScOkI0ZgDMhr/5m7UuWzj1Yw
         1aMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yEpRHlcDF4psUPPX8udaCtEP3gg4YAcBzZqIRmvDq4M=;
        b=N7K4mV9isj56J6iEg0jf4RJfp4szhOeDDU/o2malQ/LZ04+6wa1i6LGkxd0Xntx9TP
         960sZIz7FqvAUKZ0TPOf+WlUyyiDAGQYr7cw+9akg4rk2jCsqQR5vRLlZTUl7v9nWoby
         MnPWzE+1IIlxVf4aUyjU3gn85qtIGnXzeCDV6KNFClH9ABVC6q/eAvPUztem99K6f4AQ
         X1MdciW+EZvvRZ/PYzQMg3vVRXsCfBqe/7HTB87czANOZIRCCCrWoyQtmW3zboaRDQUJ
         ZY9qXIR9GDlf9uoKhf8truqM4Ldi5oLWcdTTuo4g2lQgERjkTt7bPqfcbc6FovRb7Lmd
         TA9w==
X-Gm-Message-State: APjAAAU4X//CUizQioTEXbhm+43dlK8fbgolWuYfbV7qqqBRqKh/+qmi
        tMkz1D3dfXHI6QxESfvkZ/U=
X-Google-Smtp-Source: APXvYqwlIMhhQqRk4XXts851ki2Ruxlx1uFIWb/XbuB0nNQEVcpwt/2clYA0lB6mVvUaefD7sNnXEw==
X-Received: by 2002:a17:902:c509:: with SMTP id o9mr822791plx.112.1578418607016;
        Tue, 07 Jan 2020 09:36:47 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee3:fd53:981d:523f:a647:bef8])
        by smtp.gmail.com with ESMTPSA id d3sm130091pfn.113.2020.01.07.09.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:36:46 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org
Cc:     rcu@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 3/3] infiniband: sw: rdmavt: mcast.c: Use built-in RCU list checking
Date:   Tue,  7 Jan 2020 23:05:10 +0530
Message-Id: <20200107173510.20320-3-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107173510.20320-1-madhuparnabhowmik04@gmail.com>
References: <20200107173510.20320-1-madhuparnabhowmik04@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Use built-in RCU and lock-checking for list_for_each_entry_rcu()
by passing the cond argument.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 drivers/infiniband/sw/rdmavt/mcast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
index dd11c6fcd060..5fce375f22f4 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.c
+++ b/drivers/infiniband/sw/rdmavt/mcast.c
@@ -224,7 +224,8 @@ static int rvt_mcast_add(struct rvt_dev_info *rdi, struct rvt_ibport *ibp,
 		}
 
 		/* Search the QP list to see if this is already there. */
-		list_for_each_entry_rcu(p, &tmcast->qp_list, list) {
+		list_for_each_entry_rcu(p, &tmcast->qp_list, list
+								lock_is_held(&(ibp->lock).dep_map)) {
 			if (p->qp == mqp->qp) {
 				ret = ESRCH;
 				goto bail;
-- 
2.17.1


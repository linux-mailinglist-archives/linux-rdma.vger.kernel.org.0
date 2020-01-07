Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37132132F89
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 20:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgAGTb3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 14:31:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32783 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgAGTb2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 14:31:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so356397pgk.0;
        Tue, 07 Jan 2020 11:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3ST/dj3po+BlNeYM5PMnB4Z+srpzBM2wonPJAfu44pg=;
        b=ayegAG88ic4ZMzTrQ5veoMKLjpAiwBmaJgBtFHY14G+/hkJWblccaas0os4TVCGKU0
         JGskHw2/EF9g9oqgXWRZsQu4bwEUv/mzKh0vtW8N5JbfoEpH5mc0iHPYBSMiPx+kQ2Ii
         UuR8zZmrVymnRwa0240MOFfMrmIM7RKUC65YyifibGP5k6UoAFQFrFilwcrjFwwEBxtx
         G+FprGREsEVGy+JsYmWUJV4/xv8NtSNKW/yHeoQktpOY5C/saZF2HMvWjOEQKzWmNd40
         +W24LHsjIQZ/DDnBiyXvFxhjBBjSMsYlbxPM5KLkvs/s/edJ/HDUCfqpw616E4/D+1Rq
         114g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3ST/dj3po+BlNeYM5PMnB4Z+srpzBM2wonPJAfu44pg=;
        b=eiM8jxS1sZV0LGCHkUP0NhJ7At+2L6Z3TgBUjjey4wYO4LdbkiDDmyk7hkhV9uER38
         Qot/y4vJf1HiMSzh+J67JvD5UJ4R5Y629lm1vY+3FOhqGCM2YeuuAolIlzsTedwGMCNs
         DL5eY4d2/e2LiETM/4Y5X917ui4smL/kEqYGPTz5lzbcDVdfOYdjxkpK4LauICbHVlT0
         zrbp1ZKOWiQ84EAv6DgmgpkCWJNNmfNDRlXCia+6dbcyNFoINePcu0kT9P82x/EhsPPE
         RzQVS1X2tQvRD1Dh1Vqw644Sgc9jaZ4wxAM7wcIf6jxiuaN+gOcGXojSge10yaktmivX
         1nWw==
X-Gm-Message-State: APjAAAUhRv5MsMqVHymJmE2+t39jQFYNTxSgsnC2t/4uENrGPc82i/hG
        445rNiPe4j44pzgOMnJHNDk=
X-Google-Smtp-Source: APXvYqwEJ4DGXraHQ+XTpgucybYYLANGWqLS0H5FRZ2LWC/vCHUIp2l5InPQcrZS3vIu3NDqkcJVHA==
X-Received: by 2002:a62:1548:: with SMTP id 69mr837034pfv.239.1578425487834;
        Tue, 07 Jan 2020 11:31:27 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee3:fd53:8500:6ea8:4ef2:c9be])
        by smtp.gmail.com with ESMTPSA id b4sm365817pfd.18.2020.01.07.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 11:31:26 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org
Cc:     rcu@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 3/3] infiniband: sw: rdmavt: mcast.c: Use built-in RCU list checking
Date:   Wed,  8 Jan 2020 01:01:19 +0530
Message-Id: <20200107193119.22915-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
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
index dd11c6fcd060..983cf6d06dfc 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.c
+++ b/drivers/infiniband/sw/rdmavt/mcast.c
@@ -224,7 +224,8 @@ static int rvt_mcast_add(struct rvt_dev_info *rdi, struct rvt_ibport *ibp,
 		}
 
 		/* Search the QP list to see if this is already there. */
-		list_for_each_entry_rcu(p, &tmcast->qp_list, list) {
+		list_for_each_entry_rcu(p, &tmcast->qp_list, list,
+					lock_is_held(&(ibp->lock).dep_map)) {
 			if (p->qp == mqp->qp) {
 				ret = ESRCH;
 				goto bail;
-- 
2.17.1


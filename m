Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905CE13AF45
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 17:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgANQZp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 11:25:45 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50323 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANQZp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 11:25:45 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so5916038pjb.0;
        Tue, 14 Jan 2020 08:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7jwlJAnIyJqxihW77uuy1REEn0k3bY6ojjoQKPqvEnc=;
        b=jSa39OLar/Fi32gqOEeLvW4p2KJj7cTCSWJihafTC4Hppz0jCfCy72OsknAnd4dOK9
         MT+LRI1ZmNPd8RBVMGGJcGAMAkSh+MwdPT5RfRo6kTPC93kD7PlpI7BrKZPimEHTdODe
         Hwt/0f7xhh55OR120i5bB9KnaOqzEvryZuhP1PPRZQ6ygaPVqItdRoLAak83TP+c/C63
         ad4t9a7e/iSaxFkBxVLJM0FcBdB3uprzQ6kubYq66lwixKRwgZ9h8MN+CarSpud6TsBf
         DlQtiYVqINRO+qiQrLvXgTRcWrzx7li4nJ+RTy9z9B8xslmqpOrTRhTjWbWEoVddkV8M
         LJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7jwlJAnIyJqxihW77uuy1REEn0k3bY6ojjoQKPqvEnc=;
        b=JHMo/cmHwBAGCWU2nO+0SCU8Vt5hgw/KyqH4LlKUXloYG4aJn1Uwn30GwBFEaHILBn
         SJqgj4ukwhFwcSHlkamNMAmnpQ9+d+Gh+PuJld3rGF5I66dBUT6y059EyLqLvLJwgVQb
         hDFnlnErypeMso/lDM9/Izaq1NUGDnjAcL4lbE7TAeby1F+5pgSlyIi4IttxFVq6xR4K
         CdZLHMszebKkPVV7CchlPsNEydFy3Nwxlh4vEJ2MO4SG4QtfiV7TSJUCUwaEBgYCp8ah
         G3D7JdhB2gHlcdJOJepVuFzyXzf0z5mqmJumQpGj6Eb+TmxNAELCOx0N4QeF/wjd+2vo
         g8jw==
X-Gm-Message-State: APjAAAXeDMGZKssiwtkBB305fkWISIKA4v4sCspADswaTPg9+pS+MtkS
        eHU8kRZmh8xl2Uzd9061Enk=
X-Google-Smtp-Source: APXvYqxrGnVakDKBqMasUm6BO3VJGLBeO4TD9RH57n1IJHxmeqqIWHb5RYsLLyH4vTfImZGgN5F89g==
X-Received: by 2002:a17:902:b103:: with SMTP id q3mr20545950plr.37.1579019144375;
        Tue, 14 Jan 2020 08:25:44 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee7:f789:438:77e9:83ea:bb95])
        by smtp.gmail.com with ESMTPSA id o98sm18142914pjb.15.2020.01.14.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:25:43 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     mike.marciniszyn@intel.com, dennis.dalessandro@intel.com,
        jgg@ziepe.ca, paulmck@kernel.org
Cc:     joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        rcu@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 3/3] infiniband: sw: rdmavt: mcast.c: Use built-in RCU list checking
Date:   Tue, 14 Jan 2020 21:55:36 +0530
Message-Id: <20200114162536.20388-1-madhuparnabhowmik04@gmail.com>
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
 drivers/infiniband/sw/rdmavt/mcast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/mcast.c b/drivers/infiniband/sw/rdmavt/mcast.c
index dd11c6fcd060..31c7f12c7665 100644
--- a/drivers/infiniband/sw/rdmavt/mcast.c
+++ b/drivers/infiniband/sw/rdmavt/mcast.c
@@ -224,7 +224,7 @@ static int rvt_mcast_add(struct rvt_dev_info *rdi, struct rvt_ibport *ibp,
 		}
 
 		/* Search the QP list to see if this is already there. */
-		list_for_each_entry_rcu(p, &tmcast->qp_list, list) {
+		list_for_each_entry_rcu(p, &tmcast->qp_list, list, lockdep_is_held(&(ibp->lock))) {
 			if (p->qp == mqp->qp) {
 				ret = ESRCH;
 				goto bail;
-- 
2.17.1


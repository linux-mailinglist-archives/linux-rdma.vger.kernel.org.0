Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54482132D22
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgAGRfX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 12:35:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34496 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbgAGRfX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 12:35:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id x17so9894pln.1;
        Tue, 07 Jan 2020 09:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SJ2X7WpLg0FrWfJBUWgKBYL6TqlxNNJeppsfwwD9mMQ=;
        b=fdk5/inRsxMjh8bZaDJiNZavvsDYMaz1z6Q+wBlSAg5iKy/QmC8eN/MI/tSXtPPCtL
         wX8rVuAW1NnotCHdQRlBfJY49oe15AO0lrC/dmW901u//sL4p+jkOL741iC6+IjfcHxA
         QlJXk3Kim3KbspQspAEmnxJOLp3/EL8kfzT1VAya63ai58/jnoRIfgbBXO2AnAUx6sGz
         mNitcp2SzJA0gvOERxLUAOzVQPfx20B0TQrWRf1uiPmtJNvb75XLSoJICJFoq/Heve8N
         PG4S70cGp2UxpdEDlTWbEwC+tLCRVIJt23Pwv5P85RXhlbbhtHRwsxMUA9Xroft2Tjwe
         OYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SJ2X7WpLg0FrWfJBUWgKBYL6TqlxNNJeppsfwwD9mMQ=;
        b=UGhR5rg14BjtSdWct59XNN4cP8MATXStZr6sAByFy5ZTk/tYrBt08EhVPt9ubOjxzh
         wzxML/BK4jPLz+oI+DQVvyRDtu0UvBrLSyijBa6ERkediNaQtYsfIN3ViZ9PsubVbrEB
         l9KDTKeG/8/B3HzxcGpvJ962Vd8gW75rXmeceETsfRgCczoL3muFTzhdSoXsKqbobIhf
         Lho3X6/jDLuzOvYflNlZYk8QYddHscMuC4saLZpCxUQf3PeRuzgCp0C3oypPaAJvUhVw
         oadBWuKz06An2GnTBLRFj+CGFQF+EE+SRYqAnYmG9+l8xoiAvEmd2e5gKVPf4PmMjV6G
         COCQ==
X-Gm-Message-State: APjAAAXTrCcL5vcCFTRyWMLLNnGnoly1G834iICIJWfU3Kvm1crfhKnB
        QUdjCuWpfH7bxSBr5ezet+I=
X-Google-Smtp-Source: APXvYqxIicyrXMpE6DtoTVEUGxByj1tKZgLrrAE+L6a1P/+ajmE1S+RY0vKL6wMwNYQj7M3UH/UUqA==
X-Received: by 2002:a17:90a:fb45:: with SMTP id iq5mr884671pjb.93.1578418522122;
        Tue, 07 Jan 2020 09:35:22 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee3:fd53:981d:523f:a647:bef8])
        by smtp.gmail.com with ESMTPSA id d3sm130091pfn.113.2020.01.07.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:35:21 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org
Cc:     rcu@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 1/3] infiniband: hw: hfi1: verbs.c: Use built-in RCU list checking
Date:   Tue,  7 Jan 2020 23:05:08 +0530
Message-Id: <20200107173510.20320-1-madhuparnabhowmik04@gmail.com>
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
 drivers/infiniband/hw/hfi1/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 089e201d7550..cab2ff185240 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -515,7 +515,8 @@ static inline void hfi1_handle_packet(struct hfi1_packet *packet,
 				       opa_get_lid(packet->dlid, 9B));
 		if (!mcast)
 			goto drop;
-		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
+		list_for_each_entry_rcu(p, &mcast->qp_list, list
+								lock_is_held(&(ibp->rvp.lock).dep_map)) {
 			packet->qp = p->qp;
 			if (hfi1_do_pkey_check(packet))
 				goto drop;
-- 
2.17.1


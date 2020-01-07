Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04EAF132D28
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 18:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgAGRgN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jan 2020 12:36:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33510 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgAGRgN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jan 2020 12:36:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id c13so12934pls.0;
        Tue, 07 Jan 2020 09:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=biLJqx330MZclQKessEfLfXglMmNrWIIv270QImnfKc=;
        b=DetI79OZZiQHKwD5ytiJKZTadN7iND/zQ69WntNloQLAuUnsnXLxQbxbT302EGkP0k
         JKVSpJJWgoVaIKkfSKz+E8+2ap8U3uS+flJoget1HgVrMlQpsqaoZBLe6WZnuiWBzFks
         qrrbwymrQDXDzQwOtRm47krEls20N/8pNSGrR2zjBPxaEPuoCIezIQY7wkRtH0ocALOW
         p5ouOZ4Ztu4Zd/d5CSrAo51KYnMc0otMcQN0SBhHB8YgL4yR1F1OvT8tRizdRtmKMgs3
         wZ97riPRtD5cQMMgmHYQoViL5wvfIBl51CHzszJHkWDCr9/36owjkqFCzcqn86Jc/ih+
         Hn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=biLJqx330MZclQKessEfLfXglMmNrWIIv270QImnfKc=;
        b=eks5SbcH6iI74sE0POda+4g1L4Af1iPPGxxZZ42tLYYNqjEapJLTB6HCiKOoErxM2K
         2GB1wmVtyQrvZRz0N+hgxu52xhsF2k1YH5ZPjb4Am/PkKlZ5+qU9e0m/wfNTxGxgO2/J
         uA41+u/Cca1fnKT/jKLrrzRFBIWf+WPmSAbka7HS5sDJ0+7ZOQuaER+vehrAbXhuS1pK
         xY314YUrF6Z8aOXPQbrodu0kr1/kSR8tqz8f9ZD9TZmUhZUlK6mdw8y4XtsenIMPA0OI
         R5dVx2hwvcuFqT1ZLZznULdKONl0hFE4cCSQjEXNxLF9mRquic1zJURXbiC6w5UnQ/Mq
         LupQ==
X-Gm-Message-State: APjAAAWiC3d8u/p9He21U2fboT2AMTu3Nh39zdP+kznaVMMK0KStYMTx
        9BjqJj5kmZlMnhf1AoiUGws=
X-Google-Smtp-Source: APXvYqwufFongLMRCZQI7krPgU64ZUrZqMS981mDC0wZjM39AA/2YeOgJm3A7rVk2a6ElDanPjotbw==
X-Received: by 2002:a17:90a:fb4f:: with SMTP id iq15mr961026pjb.86.1578418572370;
        Tue, 07 Jan 2020 09:36:12 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee3:fd53:981d:523f:a647:bef8])
        by smtp.gmail.com with ESMTPSA id d3sm130091pfn.113.2020.01.07.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:36:12 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, paulmck@kernel.org
Cc:     rcu@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 2/3] infiniband: hw: qib: qib_verbs: Use built-in RCU list checking
Date:   Tue,  7 Jan 2020 23:05:09 +0530
Message-Id: <20200107173510.20320-2-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107173510.20320-1-madhuparnabhowmik04@gmail.com>
References: <20200107173510.20320-1-madhuparnabhowmik04@gmail.com>
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
index 33778d451b82..4dc7514ce626 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -329,7 +329,8 @@ void qib_ib_rcv(struct qib_ctxtdata *rcd, void *rhdr, void *data, u32 tlen)
 		if (mcast == NULL)
 			goto drop;
 		this_cpu_inc(ibp->pmastats->n_multicast_rcv);
-		list_for_each_entry_rcu(p, &mcast->qp_list, list)
+		list_for_each_entry_rcu(p, &mcast->qp_list, list
+								lock_is_held(&(ibp->rvp.lock).dep_map))
 			qib_qp_rcv(rcd, hdr, 1, data, tlen, p->qp);
 		/*
 		 * Notify rvt_multicast_detach() if it is waiting for us
-- 
2.17.1


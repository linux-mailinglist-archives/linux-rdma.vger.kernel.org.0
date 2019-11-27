Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9FD10AE04
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Nov 2019 11:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfK0Knv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 05:43:51 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43982 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfK0Knv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Nov 2019 05:43:51 -0500
Received: by mail-pj1-f68.google.com with SMTP id a10so9747291pju.10
        for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2019 02:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DZCoBwLAg/vEwZ81LAit0N9P4J55qWF5BiXLh3lbRG8=;
        b=UN0J+RNJs2ENi84kWq1arWSsm7JvmU06SqOpsu/DYBK+Y1NC9klEgRk8UdrjHRtB05
         oDWYVcKAyEz3tALDGtAtKARZVlevWZb4W7e83fB2pDIs2gV0JZwGHmKtX6I97uIltK3t
         Cn3or9zZC56zdmTIZy7F+M3MmUETLCtYwOJqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DZCoBwLAg/vEwZ81LAit0N9P4J55qWF5BiXLh3lbRG8=;
        b=Qv2GJl49Kg3f1JOBs59Juv4mV6kOXs3C/Gz/rtBuFtZ65XhW0ZCMFXB2cus7sgsyFL
         dgGyHz0xh0qWFldCL8Elk0RIBPPYVjAj/cogROijo2ch2AbBIsg7MCpvA50WUjyeABco
         EEqYihuzhqWqaGzcwkRa2WiE3wX4Ryao57Adg+Mx3DkLyMMCQxRcc3LAcxYJjAIfXg9p
         9i19FzrGraMl5mRQtlKLLGyb+RavSdrqsUHJ8zebWWPxe+9E0AxEuCmemmyg+ryPbq+y
         WbYDmkG1zo2AFn7W78EFbBKIkGUxu1of3pNJvOBhGZ/LYM/bUGuJ0UQwlC7boykZLv1y
         fTMQ==
X-Gm-Message-State: APjAAAWtUCbu7i3dzUmwvyiciJwXIMIQC7jPHaXyaCD0w8TRcBCgz5jY
        +zHeZsJosbFFjCSTihlN+zoh0g==
X-Google-Smtp-Source: APXvYqyqg/99pzWPGS0WJM+femn56d0b2iua+1SBnefZ5vZe3w6sV0uEMB271PV+U5Fw1IflUFlgwA==
X-Received: by 2002:a17:90a:bb82:: with SMTP id v2mr5256663pjr.62.1574851429068;
        Wed, 27 Nov 2019 02:43:49 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id x190sm16104286pfc.89.2019.11.27.02.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 02:43:48 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     dledford@redhat.com, jgg@mellanox.com, leonro@mellanox.com
Cc:     nmoreychaisemartin@suse.com, linux-rdma@vger.kernel.org,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH rdma-core 1/2] bnxt_re/lib: Add remaining pci ids for gen P5 devices
Date:   Wed, 27 Nov 2019 05:43:34 -0500
Message-Id: <1574851415-4407-2-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574851415-4407-1-git-send-email-devesh.sharma@broadcom.com>
References: <1574851415-4407-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>

Making a change to add pci ids for VF and NPAR devices.

Signed-off-by: Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 providers/bnxt_re/main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/providers/bnxt_re/main.c b/providers/bnxt_re/main.c
index b1194db..e290a07 100644
--- a/providers/bnxt_re/main.c
+++ b/providers/bnxt_re/main.c
@@ -76,9 +76,15 @@ static const struct verbs_match_ent cna_table[] = {
 	CNA(BROADCOM, 0x16F0),  /* BCM58730 */
 	CNA(BROADCOM, 0x16F1),  /* BCM57452 */
 	CNA(BROADCOM, 0x1750),	/* BCM57500 */
+	CNA(BROADCOM, 0x1751),	/* BCM57504 */
+	CNA(BROADCOM, 0x1752),	/* BCM57502 */
+	CNA(BROADCOM, 0x1803),	/* BCM57508 NPAR */
+	CNA(BROADCOM, 0x1804),	/* BCM57504 NPAR */
+	CNA(BROADCOM, 0x1805),	/* BCM57502 NPAR */
+	CNA(BROADCOM, 0x1807),	/* BCM5750x VF */
 	CNA(BROADCOM, 0xD800),  /* BCM880xx VF */
 	CNA(BROADCOM, 0xD802),  /* BCM58802 */
-	CNA(BROADCOM, 0xD804),   /* BCM8804 SR */
+	CNA(BROADCOM, 0xD804),  /* BCM8804 SR */
 	{}
 };
 
-- 
1.8.3.1


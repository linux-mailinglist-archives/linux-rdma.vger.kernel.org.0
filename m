Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83936C0BC
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Apr 2021 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbhD0IXl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Apr 2021 04:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhD0IXk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Apr 2021 04:23:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7554C061756
        for <linux-rdma@vger.kernel.org>; Tue, 27 Apr 2021 01:22:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so2220334wmb.3
        for <linux-rdma@vger.kernel.org>; Tue, 27 Apr 2021 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lrBt3ch/Vh3UWzgzxjRJP6nL2F66EKKCAo1r45c0BKI=;
        b=WCYxeowZAj2pmX8as2tXgz1UVsRvQEhb1TQQXwPCqKXMZ/DDmSeDE4BYMtN+Ydb57c
         +GdFHudjjgSQwl8PwnY92INWNhW5AvqX8wzSlkONu1f+943L/PXQiXe+pBsbZnxTe+6u
         WcNoYtgYfYMWYsw3AcyRFGG2D4p3ZDARoaUM6TxC3/qiQlBpFCx24hnC2VWQVuCKCoa5
         UXZIYudsHIeCNCEswR1GXzkGx6QCdnEZwGFA1GNz2AUml/N0l9a9/x3m/7OQqrj4GqEe
         /TuttfIKYjSBiyXwLfDCmhFXtlxLDCZIHoc+B1/dLYzG9lpvkOAzdD05OX+/wmGxflmd
         tyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lrBt3ch/Vh3UWzgzxjRJP6nL2F66EKKCAo1r45c0BKI=;
        b=T0GxOZpjA8DWP1b7e5gB2Gdjz8iM32nC2kciHA2SJ80dLR16z+NmKjyaDbpSHZLZvp
         m3Uq3cm42w/XVss3XDWqmZNzR4QNvCXQ3F80C4GbXhU2pmNIHFHiquRZS49Dp7PIpWnq
         va6QXI5lSNoelJxN76Y3/GZSzOgl+66xOEEh3PRDKUXDSkaYmbnkaRFC7Hz0nOqckmJi
         G6ULpBYlGhYTiDplC8+y7+v0fHBa6llyZNQHKhTqRZq1WCaBpkdaAljbsKszt9v2+XlF
         YQEvtR/jeOJeACUd7tIJfleEjqHnYY+lifob2LAGUdDkV2EWW/tA6BfOqpN5pjKzZ/w9
         +txA==
X-Gm-Message-State: AOAM531Jb0OBUXKZVx1PGQTfYrzJ5VchFsK+53nY036Qaujg7YIgMk3M
        qSFc4VDSyGUWZK9ZJ+u4fvHFS/QzgBczLfBO
X-Google-Smtp-Source: ABdhPJw+hoWv5Aa+Vqaq1paUx2U+JjN4aVGPydN7bUbRVHi9Mz2F9GthdZQR2AsiJlMcfXDtn+2bTg==
X-Received: by 2002:a1c:b3c5:: with SMTP id c188mr23787767wmf.168.1619511776372;
        Tue, 27 Apr 2021 01:22:56 -0700 (PDT)
Received: from localhost (ip5b401b0e.dynamic.kabel-deutschland.de. [91.64.27.14])
        by smtp.gmail.com with ESMTPSA id d2sm2932768wrs.10.2021.04.27.01.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 01:22:56 -0700 (PDT)
From:   Benjamin Drung <benjamin.drung@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     Benjamin Drung <benjamin.drung@ionos.com>
Subject: [PATCH rdma-core 2/2] debian: Add Debian uploads up to version 33.1+git20210317-1
Date:   Tue, 27 Apr 2021 10:22:35 +0200
Message-Id: <20210427082235.706381-2-benjamin.drung@ionos.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210427082235.706381-1-benjamin.drung@ionos.com>
References: <20210427082235.706381-1-benjamin.drung@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rdma-core 27.0-2 up to 33.1+git20210317-1 were uploaded to Debian
unstable. Include the changelogs from these uploads and update the
timestamp from the top commit.

Signed-off-by: Benjamin Drung <benjamin.drung@ionos.com>
---
 debian/changelog | 74 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/debian/changelog b/debian/changelog
index 1f167717..17a04621 100644
--- a/debian/changelog
+++ b/debian/changelog
@@ -2,7 +2,79 @@ rdma-core (35.0-1) unstable; urgency=medium
 
   * New upstream release.
 
- -- Jason Gunthorpe <jgg@obsidianresearch.com>  Mon, 23 Dec 2019 13:36:56 +0100
+ -- Jason Gunthorpe <jgg@obsidianresearch.com>  Tue, 27 Apr 2021 10:20:08 +0200
+
+rdma-core (33.1+git20210317-1) unstable; urgency=medium
+
+  * New upstream bug-fix snapshot:
+    - mlx5: Fix uuars to have the 'uar_mmap_offset' data
+    - pyverbs: Fix Mlx5 QP constructor
+    - efa: Fix DV extension clear check
+    - verbs: Fix possible port loop overflow
+    - ibacm: Fix possible port loop overflow
+    - mlx5: DR, Check new cap for isolated VL TC QP
+    - kernel-boot: Fix VF lookup
+    - mlx5: DR, Force QP drain on table creation
+    - libhns: Avoid double release of a pointer
+    - libhns: Correct definition of DB_BYTE_4_TAG_M
+    - libhns: Remove assert to check whether a pointer is NULL
+    - libhns: Remove the unnecessary mask on QPN of CQE
+    - libhns: Remove unnecessary mask of ownerbit
+    - libhns: Remove unnecessary barrier when poll cq
+    - rdma-ndd: fix udev racy issue for system with multiple InfiniBand HCAs
+    - verbs: Fix create CQ comp_mask check
+  * Update my email address
+
+ -- Benjamin Drung <benjamin.drung@ionos.com>  Mon, 12 Apr 2021 11:28:57 +0200
+
+rdma-core (33.1-1) unstable; urgency=medium
+
+  * New upstream bugfix release.
+
+ -- Benjamin Drung <benjamin.drung@cloud.ionos.com>  Wed, 27 Jan 2021 14:32:48 +0100
+
+rdma-core (33.0-1) unstable; urgency=medium
+
+  * New upstream release.
+
+ -- Benjamin Drung <benjamin.drung@cloud.ionos.com>  Mon, 04 Jan 2021 16:41:27 +0100
+
+rdma-core (32.0-1) unstable; urgency=medium
+
+  * New upstream release.
+
+ -- Benjamin Drung <benjamin.drung@cloud.ionos.com>  Fri, 30 Oct 2020 10:01:11 +0100
+
+rdma-core (31.0-1) unstable; urgency=medium
+
+  * New upstream release.
+  * Switch to debhelper 13
+
+ -- Benjamin Drung <benjamin.drung@cloud.ionos.com>  Wed, 19 Aug 2020 09:36:17 +0200
+
+rdma-core (29.0-1) unstable; urgency=medium
+
+  * New upstream release.
+
+ -- Benjamin Drung <benjamin.drung@cloud.ionos.com>  Tue, 14 Apr 2020 16:15:54 +0200
+
+rdma-core (28.0-1) unstable; urgency=medium
+
+  * New upstream release.
+    - rxe: Remove rxe_cfg
+  * Bump Standards-Version to 4.5.0
+
+ -- Benjamin Drung <benjamin.drung@cloud.ionos.com>  Wed, 12 Feb 2020 17:21:38 +0100
+
+rdma-core (27.0-2) unstable; urgency=medium
+
+  [ Debian Janitor ]
+  * Set upstream metadata fields: Repository, Repository-Browse.
+
+  [ Benjamin Drung ]
+  * debian: Remove obsolete ibverbs-providers conffiles (Closes: #947307)
+
+ -- Benjamin Drung <benjamin.drung@cloud.ionos.com>  Mon, 06 Jan 2020 13:23:44 +0100
 
 rdma-core (27.0-1) unstable; urgency=medium
 
-- 
2.27.0


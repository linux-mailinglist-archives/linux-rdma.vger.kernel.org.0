Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F6436C0BB
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Apr 2021 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhD0IXa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Apr 2021 04:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhD0IXa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Apr 2021 04:23:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC4AC061574
        for <linux-rdma@vger.kernel.org>; Tue, 27 Apr 2021 01:22:47 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m5so4506867wmf.1
        for <linux-rdma@vger.kernel.org>; Tue, 27 Apr 2021 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N7u5EMmq9Q2hqKEDLeaJVTbKsGfpVATaqzxz9xSrw24=;
        b=JV/sqS8zabsu5rCp5awkJ2S/bLEIuVaq3LBsS/OyMHB94fHt6nsrLodFKnaUtWSdH6
         VwqDc+mGLMxRuYUNUTanzma6l6EUP8SF/UjfhXUCwgPm0y83SimZbcCHhYzRVHizqxND
         r/uJoE6F8ZKA4Obxh16RdGfsDDnLkd8UTkQ1ZjgUWLae176AchQXnhPoT198wdGiVRNv
         PwHZzSSv2wkcq6DUTUb8Uy48eW6qv+kNwswutLTAArwiFwPOoVCeJ8K0vVZ9mlDz4Fkt
         xkONP8Cznj5vmy6Iuh3/7qxY2a3Mob+G3qpyR1afKkg/VXJI9Qo6tTGvQyzh4OBLtHyK
         wgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N7u5EMmq9Q2hqKEDLeaJVTbKsGfpVATaqzxz9xSrw24=;
        b=V2UShjk1iFR+TowL7JqOygQeMUjx6Bh1+D5fbNQQD6RBrLS/+pGJYEsgkt7GYcCCVG
         BB6fpSHA1eG7GxwdKUeqxxBDfwBZ528IhoSSapLHto08vUNSjTFAsnTuJiBL/dYchJag
         Awm7gU3akdCeRMd/0guUed6Qo1iWySIuKQ4ljeMumwdy9w4FvLhaIu0uIjQMFh/1J5Y4
         8dDPNd0gqOG5MkprKLSB4BhAYmvjD1FLoMFYod+wacBvIqvNw1yPW9eKs2uHQEek0tMY
         FkLSSM78vx+z52ZLGzW73dn4z+nuoP5wrqbqeUp1/h9zGoMHBvNhXvzWB17L7DVPpKiS
         II6g==
X-Gm-Message-State: AOAM532IwfmfWHxX+MOLXcUByssHobv/jmginFLY8er6g+Mo3Kbz1BcF
        S3Iw4QODRN1r0ZMsJtOO1taPgQaxAtthrrOp
X-Google-Smtp-Source: ABdhPJwRnjHWvxsdEn53tXIyu1GhpqPCupmIAcAJ9Jtyjyfjg+U3GRz0MG4YjyiI3b1+YxP7i3cWig==
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr23079704wmk.25.1619511765760;
        Tue, 27 Apr 2021 01:22:45 -0700 (PDT)
Received: from localhost (ip5b401b0e.dynamic.kabel-deutschland.de. [91.64.27.14])
        by smtp.gmail.com with ESMTPSA id f8sm19813166wmc.8.2021.04.27.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 01:22:45 -0700 (PDT)
From:   Benjamin Drung <benjamin.drung@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     Benjamin Drung <benjamin.drung@cloud.ionos.com>
Subject: [PATCH rdma-core 1/2] debian: Drop unused lintian overrides (for examples)
Date:   Tue, 27 Apr 2021 10:22:34 +0200
Message-Id: <20210427082235.706381-1-benjamin.drung@ionos.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Benjamin Drung <benjamin.drung@cloud.ionos.com>

lintian 2.29.0 does not complain about package-does-not-install-examples
any more. Therefore this lintian override can be dropped.

Signed-off-by: Benjamin Drung <benjamin.drung@cloud.ionos.com>
---
 debian/source/lintian-overrides | 4 ----
 1 file changed, 4 deletions(-)
 delete mode 100644 debian/source/lintian-overrides

diff --git a/debian/source/lintian-overrides b/debian/source/lintian-overrides
deleted file mode 100644
index 65e5635f..00000000
--- a/debian/source/lintian-overrides
+++ /dev/null
@@ -1,4 +0,0 @@
-# The libibverbs examples are compiled and put in ibverbs-utils.
-rdma-core source: package-does-not-install-examples libibverbs/examples/
-# The librdmacm examples are compiled and put in rdmacm-utils.
-rdma-core source: package-does-not-install-examples librdmacm/examples/
-- 
2.27.0


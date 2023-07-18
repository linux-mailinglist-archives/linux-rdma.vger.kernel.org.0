Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521F07583FD
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjGRSAs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Jul 2023 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGRSAr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Jul 2023 14:00:47 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678B0A1
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 11:00:46 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a3fbfb616dso3718245b6e.3
        for <linux-rdma@vger.kernel.org>; Tue, 18 Jul 2023 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689703245; x=1692295245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tZotsESvq5CfH0eFP51mfkLjvVdlkxjqfD/baWDw1s=;
        b=sndcF4U9aXLLupQH2bLeriEdpjFSzneZPUkBmyKDunZJjs1lUQcFbR2HnBy8qg+cPE
         NdmEWTNNh2Ctj4dM7gDnvA1W+El8yON3VixdWa7cY5UFQ7VBZmrYNuB3A71GQczS0r+5
         xYlSw8Qk3bPKiUxOo2PcjmEUrucc4v+Kpff3xIxflXDY1xSYBWgeYPgiUoFdfwXPikrq
         QtzhvyrcFDmZ0GIpXZ7dy+opHUi5+uRVxqMPLyMhO8KUVxw2aZREyh3jy5CgcFW3Db6O
         IYy9j0sjaNO8aatDZvvizE7kOYjkiGEfcMBHfmokH2HbLsj7Fu5egrRpSPCe5qagoon2
         9Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703245; x=1692295245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tZotsESvq5CfH0eFP51mfkLjvVdlkxjqfD/baWDw1s=;
        b=CY8RR8xP9hWLuK9ga8apv1XdFZdHt9EeZNwfB+vN6z8q++cDqC/r9AdC52C8gwOQFP
         MGHLUWk2I617kuKnMxnsrHxkBr/vEKpaMuV+6VHiKUYBYB7E/7twXWh06esdIhCuLtJw
         4LkDDgtFzdvcR0vGKE0k7ub1ZxmPxvnE+SBHZxM8kpTFmcAu6t3NWTCiMRDZGw6SnJel
         9eeH3Oi0bMwo0RItzmjPhfTaYiXx9GoSSu6tMhJBp0KDUlkczLf/yMHDqgrGMb8saU6s
         47MjkHtvUmshM+2d3OfCqKur9tIbzFbt5ZcrHaFqGLiaExh4XSROc637ZgX5FwN1GbLx
         aIFA==
X-Gm-Message-State: ABy/qLagBQEp7k7MFRAobgDuKvZOT63sYyS3Qx/n/Re0citScyBcSzI3
        C8zCRTUIlUNBaiOj+8uJrPE=
X-Google-Smtp-Source: APBJJlEbup66BGg4JPNdB0fd8JhHaZt/aGMgqYI85s7SidW6IIvYwp5CgT1P8ctPBOynNKZ2cYgDBw==
X-Received: by 2002:a05:6808:2a4f:b0:3a4:7b16:35b0 with SMTP id fa15-20020a0568082a4f00b003a47b1635b0mr41184oib.2.1689703245672;
        Tue, 18 Jul 2023 11:00:45 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-407d-4821-8a8f-dae8.res6.spectrum.com. [2603:8081:140c:1a00:407d:4821:8a8f:dae8])
        by smtp.gmail.com with ESMTPSA id o3-20020a05680803c300b003a38df6284dsm1007954oie.11.2023.07.18.11.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:00:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/2] Enable rcu locking of verbs objects
Date:   Tue, 18 Jul 2023 12:59:42 -0500
Message-Id: <20230718175943.16734-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set consists of two patches. The first adds code to
rdma-core to optionally use kfree_rcu instead of kfree for three
of the verbs objects which are looked up by their indices in the
rxe driver and which are freed in the destroy verbs in rdma-core.
The second patch adds rcu_head to the private data in the rxe
driver and sets the offsets to these structs. This allows the
rxe driver to correctly use rcu locking on these objects.

Bob Pearson (2):
  RDMA/core: Support drivers use of rcu locking
  RDMA/rxe: Enable rcu locking of indexed objects

 drivers/infiniband/core/uverbs_main.c |  2 +-
 drivers/infiniband/core/verbs.c       |  6 +++---
 drivers/infiniband/sw/rxe/rxe_pool.h  |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c |  6 +++++-
 include/rdma/ib_verbs.h               | 24 ++++++++++++++++++++++++
 5 files changed, 34 insertions(+), 5 deletions(-)


base-commit: f877f22ac1e9bf1f9aded3765b0012851e1dc4c5
-- 
2.39.2


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C283010BB
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Jan 2021 00:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbhAVThj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jan 2021 14:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbhAVTap (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jan 2021 14:30:45 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F00C06174A
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:04 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id k8so6193660otr.8
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jan 2021 11:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=StE1txwZLwqU0WVkGzN91XKJ5XfkymFhHwtSz9OoWfs=;
        b=Jzg4NAlT1xhhe58tUmBeTj2qTbVVK1bsoML8+eNngqBnIrgH1upTDGVBUhBPrRwSqq
         OPQ9pKZFdCxaWL3ZQui0AwAG57lCb8DytbPvidmXePbBt89ESfDtd3GZoEWTRilzb/u5
         V2urFM8W8omoAepduu+gTF2fXiIfV5S/U22pfvn6iTrzoBzAveUUML48TTuqbTIIQ+uG
         6nBHu/KcWFkitP1oNxIRmv4hMbgWWnwiIWx2mehslcLKMAkwDgd+fFhVVPeXpu3iVcqb
         f6yMdH2iU55wD+vvwl+Jl6jGuY1DC77zQ66QCQsCdR3JFGbj58j9TPLLm3gSFY+hPR7D
         PZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=StE1txwZLwqU0WVkGzN91XKJ5XfkymFhHwtSz9OoWfs=;
        b=HEFXZo6JKCvytiPCPYXm4mivkiOwIzun6+4CkeqffLg6rA2RuJdWkQf8m+3jalrYgq
         DJHKNbO28P0tifXqYl8B0hru6YcFio0NdUUMtIcDRKgrOmrsZcMiJCXuLTG7q548JPlh
         9Ts+xCOs3p+laf3fDecdyLI9qcxlPAKB12Fo/vgOh2zAm+7kq5JohbCRloTN38E+w7UK
         3XvBKHQvOPoexwNS68epWlao6POCXhmXnh6+epVZtJ+Rijs5Nbm1wvvne6G9Ed9/5IQq
         ZC0VWqh55vUcYUK8XttsSHxk92zgkoIJnU7e437tsUbqO4zBkJrAajDR3wlUC/PzxUye
         p1WA==
X-Gm-Message-State: AOAM533WyvpKxEPhpB6W820XdWq6ZDVf/LoOGin0h+2tdgXa7DnPgFY3
        4VY9Xs3nyzrGVNFmR1DG2Tw=
X-Google-Smtp-Source: ABdhPJyIRHjHQ9T7eo+54LQf+C+fnC1N6NyzxO2nFEAF6Ti0XyblQS+9qo4xgfEGnP22QxhCbUZ5Og==
X-Received: by 2002:a9d:20a8:: with SMTP id x37mr4609307ota.62.1611343802356;
        Fri, 22 Jan 2021 11:30:02 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-7fcf-0a74-ddeb-d9b7.res6.spectrum.com. [2603:8081:140c:1a00:7fcf:a74:ddeb:d9b7])
        by smtp.gmail.com with ESMTPSA id 36sm1835546oty.62.2021.01.22.11.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:30:01 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 0/6] RDMA/rxe: Misc rxe_pool cleanups
Date:   Fri, 22 Jan 2021 13:29:37 -0600
Message-Id: <20210122192943.5538-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches corrects a bug introduced in rxe_pool.c
by a recent commit and then addresses several issues raised
during discussion of the bug and the proposed fix.

The first patch fixes a real bug but the other five are
stylistic and cleanup changes.

Signed-off-by: Bob Pearson <rpearson@hpe.com>

Bob Pearson (6):
  RDMA/rxe: Fix bug in rxe_alloc
  RDMA/rxe: Fix misleading comments and names
  RDMA/rxe: Remove RXE_POOL_ATOMIC
  RDMA/rxe: Remove references to ib_device and pool
  RDMA/rxe: Remove unneeded pool->state
  RDMA/rxe: Replace missing rxe_pool_get_index__

 drivers/infiniband/sw/rxe/rxe_mcast.c |   8 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 132 +++++++++-----------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  57 ++++++-----
 3 files changed, 76 insertions(+), 121 deletions(-)

-- 
2.27.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3704428433
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Oct 2021 01:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhJKABm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Oct 2021 20:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhJKABm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Oct 2021 20:01:42 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2831FC061570
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:43 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so1605904ott.2
        for <linux-rdma@vger.kernel.org>; Sun, 10 Oct 2021 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfzNNK+SA16X8YB8cikrXZEZk4xuDMqzUoAZhuLU3xA=;
        b=JYl8/xtSwJIA4f8ZGvvgrWVDjiTYi58rcsskTOApzwV1cZiMhX9cDgAdvIbIYMAu1G
         85+045RgtH4AciK9mzFggGUSQxRTzsXM7m1mCN9QI66xTAX5rPlzzV6bkshgNyGmH6eg
         rKr+3QT5LRhokdTjCzFFJK5bANG+hDONeIPwr7ZIemYbrCEipsRA8aQnRyOgOGppRELQ
         kpCLJofVaZE4Jo3YbM7MZ8W5ca+y/8hf0o8csEtkWKZmklvUcKt+t2efnmS9EaaSfJXc
         DRikOxAb86WY/BzHlC7KCyskAU5vuNkom/tKi1zd4Cmsq3B8T8L6DkvWojWhgrslLN8L
         akkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CfzNNK+SA16X8YB8cikrXZEZk4xuDMqzUoAZhuLU3xA=;
        b=dcJ1fhae45jMT/y9IlKld9QT2HvBgNIE4h003GFNC3RwtQQORUhbvWi11JYlRBDZ2B
         APEEKgD8w+Uz4kLsGBZkreY2Dmz5fg1ptS6baZyIWVsiMD6BL5JW61bCIyRS5fr8h7zj
         y+IoEiVDqWeeG/gMAhXKA/Aape3zeDd1KSHeobrhBTj/Gbjob9BgdiJnz3r7PDSR26qy
         YnlaV9ldrxQLGCHb85jEa/oZBmujMhdXIcycRR10KNgqbwA2zvWse2IOLpR6xwQIPyFy
         LQsrJPUWmVxYLPqT0Ic0vrnGtYZdBUJElcvRZp2Ozqz0MF9t0LGRU9/bXWYH2R76adZS
         niYw==
X-Gm-Message-State: AOAM5324j3bxiDap3f8WKXK4M9wdMSwvkLlrKXOTqG35fUaXQ5ojTUPf
        M3oRhAj7jZgt0weN4VMPyDA=
X-Google-Smtp-Source: ABdhPJxmdSH7iL8c4R+sAiQm9i9f5I9e0Ksv51tuzlq2ag+gpN5XLfA82foa5Ydi6vmlqrmdRmvjLQ==
X-Received: by 2002:a9d:715e:: with SMTP id y30mr18202433otj.104.1633910382187;
        Sun, 10 Oct 2021 16:59:42 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-f9d4-70f1-9065-ca26.res6.spectrum.com. [2603:8081:140c:1a00:f9d4:70f1:9065:ca26])
        by smtp.gmail.com with ESMTPSA id c21sm1375379oiy.18.2021.10.10.16.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 16:59:41 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/6] RDMA/rxe: Fix potential races
Date:   Sun, 10 Oct 2021 18:59:25 -0500
Message-Id: <20211010235931.24042-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are possible race conditions related to attempting to access
rxe pool objects at the same time as the pools or elements are being
freed. This series of patches addresses these races.

Bob Pearson (6):
  RDMA/rxe: Make rxe_alloc() take pool lock
  RDMA/rxe: Copy setup parameters into rxe_pool
  RDMA/rxe: Save object pointer in pool element
  RDMA/rxe: Combine rxe_add_index with rxe_alloc
  RDMA/rxe: Combine rxe_add_key with rxe_alloc
  RDMA/rxe: Fix potential race condition in rxe_pool

 drivers/infiniband/sw/rxe/rxe_mcast.c |   5 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
 drivers/infiniband/sw/rxe/rxe_mw.c    |   5 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 235 +++++++++++++-------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  67 +++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  10 --
 6 files changed, 140 insertions(+), 183 deletions(-)

-- 
2.30.2


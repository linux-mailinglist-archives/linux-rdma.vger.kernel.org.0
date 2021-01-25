Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC7E302D6C
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Jan 2021 22:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbhAYVRr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Jan 2021 16:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbhAYVRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Jan 2021 16:17:39 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFBDC0613D6
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:45 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id r189so16316388oih.4
        for <linux-rdma@vger.kernel.org>; Mon, 25 Jan 2021 13:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFh6Ix/PdTVqutumuHsClVSB5t4m9keuKTZxKXMeJ68=;
        b=TEp4IJa8VL+c97pH123IRyaRvVc/BI+ijdigVXzDDubwrFIF4/qBn7/En+t/7mBW8e
         dEsO9p0H6o+YD5E85CZm+0sfYvYzgJ0sGwIkRe4gazA4+YztcbjXV31EYy1JgNQB++9d
         s4QFJF3v8dDNQ40DM2XHoRExHiVaEOLtwIDvpqPA1N+C5jny49yT3XGmSVFktWq0hMC7
         z2zlAiSy4k6exN+hRz8RzQJIAotqQ+j/GwjiTN9hWM6YFzBGkZusTD80ZD4fubv+ajvi
         bA8Eq7p0LzOY9MNv1kI83uF7JoyN9A1jL7CpoTdrnvIaKMdUTYQ0KsvZqi6v+R5slG9c
         NIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iFh6Ix/PdTVqutumuHsClVSB5t4m9keuKTZxKXMeJ68=;
        b=IUH/+IeFuaqCqSXDqIrtqEUqPF74qWZigF0KzxClSJncxYE3lulqQvtnoTmFaG6xOk
         pFVJBYif1AUjF2kSpkCOSvgt9KWEbz9XmG0nh9025nT6z3pWLaV/DN8M/OmgAYhV2Da4
         SVB5f35GkLa+LvgD3Ko3xQedXosc2cTYf8cwjLVY7KJ16oRBnuqy3KJmKJF/w3qtVgPE
         qDFnpwG6F8N6g3gXRV2QpjO0UidvXCkAtrCNKx3YP1eYWMw0rtPL5F/PKax6DRgMs33H
         vPMpo347kirfxjMlScrWm3ch/BBjs61hoY3p2DwsVQ7MLWA8PVjMnu055sWneLF/7lo1
         N0Bw==
X-Gm-Message-State: AOAM531Gzoc2uG8/qQBVzSlVI9FcU/Evtz4QdhXpTrUTR9/3vXy5Q2VP
        iNVzNwu0i4C0hnCWEO7YFkQ=
X-Google-Smtp-Source: ABdhPJzWu7V5C5eJQ7/NwC05gmJTzzkMMIDoz9yIYWIcB/FTTeI+G3Cp218O56I77kKhmeugSli0qA==
X-Received: by 2002:aca:f40c:: with SMTP id s12mr1239173oih.105.1611609404738;
        Mon, 25 Jan 2021 13:16:44 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-8baa-bb83-cd49-4ca4.res6.spectrum.com. [2603:8081:140c:1a00:8baa:bb83:cd49:4ca4])
        by smtp.gmail.com with ESMTPSA id w11sm3722564otg.58.2021.01.25.13.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:16:44 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v3 0/6] RDMA/rxe: Misc rxe_pool cleanups
Date:   Mon, 25 Jan 2021 15:16:35 -0600
Message-Id: <20210125211641.2694-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[v3]
Fixed a spelling error suggested by zyjzyj2000@gmail.com
Changed the naming of APIs to xxx_locked suggested by jgg@nvidia.com

[v2]
This series of patches corrects a bug introduced in rxe_pool.c
by a recent commit and then addresses several issues raised
during discussion of the bug and the proposed fix.

The first patch fixes a real bug but the other five are
stylistic and cleanup changes.

Taken together these changes also improve the performance of
ib_write_bw (in software loopback) by about 6% by reducing
overhead in rxe_pool.c compared to current head of tree.

Signed-off-by: Bob Pearson <rpearson@hpe.com>

Bob Pearson (6):
  RDMA/rxe: Fix bug in rxe_alloc
  RDMA/rxe: Fix misleading comments and names
  RDMA/rxe: Remove RXE_POOL_ATOMIC
  RDMA/rxe: Remove references to ib_device and pool
  RDMA/rxe: Remove unneeded pool->state
  RDMA/rxe: Replace missing rxe_pool_get_index_locked

 drivers/infiniband/sw/rxe/rxe_mcast.c |   8 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 132 +++++++++-----------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  63 ++++++------
 3 files changed, 76 insertions(+), 127 deletions(-)
-- 
2.27.0


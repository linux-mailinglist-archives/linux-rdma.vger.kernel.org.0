Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F382FFBB4
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jan 2021 05:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhAVEYK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 23:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbhAVEYJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 23:24:09 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE49C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 20:23:28 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id r199so1114867oor.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 20:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ML8AMYKxdy5Jmbsz7C6basczmFsHgQHJojadn9muEEE=;
        b=bjU/hnumV+5OFzclN7/dE/AxxdP+zvhETzKCUd713vkhUPGfJDUK8E+zNOlHJVSa7v
         yY47r/x5KedLlgveXEyktKtltli6gzH6B/v8FmWCzsYubBZQV/ys3Rww8i69p/nFh4ft
         9z9MjkTQ1KSP+UOTWX890HZ/x+F3i8v6StPzzMKJdLdqexl2mmopqitKflFAwTlGBik9
         nmUfhsARHa0+Rp11nqAE7NyJ4ln+0th2ZOCinxwbkUBZk3p8KWlMfMeeYYKTFoZkUzgX
         se5rvHoDHlh1xKpKdJUxMENlvJt6bh5SfH0iSOeFZ/KqAushy1askWKanVXw+wO/ymjA
         AJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ML8AMYKxdy5Jmbsz7C6basczmFsHgQHJojadn9muEEE=;
        b=lcOIu4GTtu7uj2Y+H0GGYc82yFzqTsk4ZVuUqTJaUhri95uaJkI4v+xViTQ52EjZJw
         Mr5yHUFY722htggcBvcngGbWrUfO794Qo+dkkEmImGnIvL3TLAgwGWn+OycW6gC84oyz
         W/5bisPFrILwytg5YKLZqb7XWADKg5JwA4eFLH2lFhfNGkYtr646KVcUZRGgjnqch/Dz
         QGpSZhVxmJ12NNF5LxsCFmKyLyXRyBcdbgN/rvfa6qrP4YqfYgQyIRFKtWbDG6WxM1HX
         CeF/LOjLNeqHI8+q8lgHLU37GRcb82UwM5/f6gn4OYyTAW2PAdYEYk/80/WRgyhF/RFp
         dZFA==
X-Gm-Message-State: AOAM532mpEjTEd2WLS7w+9YGODrzNX3Z36uqVUIrvaUwp4DCjxBSuE7V
        3eU/ozE6Y1RH6YEEydLoaeQ=
X-Google-Smtp-Source: ABdhPJxLaBOg/FAOGnGx3KkOBXnO8jPiu2YHJn9m7qmPQk1R0VcbtmxtS4C56xPN/qheahmBuGm2WQ==
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr2424753oof.61.1611289408348;
        Thu, 21 Jan 2021 20:23:28 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-5689-5322-9983-137f.res6.spectrum.com. [2603:8081:140c:1a00:5689:5322:9983:137f])
        by smtp.gmail.com with ESMTPSA id q26sm14244otg.28.2021.01.21.20.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 20:23:27 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 0/5] RDMA/rxe: Fix rxe_alloc() bug
Date:   Thu, 21 Jan 2021 22:23:08 -0600
Message-Id: <20210122042313.3336-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This short series of patches corrects a bug introduced and
then addresses several issues raised during discussion
of the bug and the proposed fix.

The first patch fixes a real bug but the other four are
stylistic and cleanup changes.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
*** BLURB HERE ***

Bob Pearson (5):
  RDMA/rxe: Fix bug in rxe_alloc
  RDMA/rxe: Fix misleading comments and names
  RDMA/rxe: Remove RXE_POOL_ATOMIC
  RDMA/rxe: Remove calls to ib_device_try_get/put
  RDMA/rxe: Remove unneeded pool->flag

 drivers/infiniband/sw/rxe/rxe_mcast.c |  8 +--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 90 ++++++++++-----------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 62 ++++++++----------
 3 files changed, 63 insertions(+), 97 deletions(-)

-- 
2.27.0


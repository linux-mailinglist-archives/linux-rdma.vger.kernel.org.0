Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA17A27082B
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Sep 2020 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIRV0A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Sep 2020 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRV0A (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Sep 2020 17:26:00 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44521C0613CE
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:26:00 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id y5so6717054otg.5
        for <linux-rdma@vger.kernel.org>; Fri, 18 Sep 2020 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7awYh+QY55coYj7eF10l2HQHVbESJZBMxM5Q/rUGjG0=;
        b=gTksYyeSr2/0HL2HkdD0u5n3LapiwBmJelS9qmVmwbkqgQTyg+R8pCN0a9r+35mDwA
         o8e5KTjgFGYG+ZcQSsXi1ClKmIYYvll/+1OZXH/ICKq29btUxwbeFcnF4q1BEWFoI2N9
         cZWYtmg9qxyr8qu9Giytkp8PiOvQlkq7mYDgaDR834JCRC+UOzqj1/6HsyY6/76IRMrQ
         /CSi6jSLoIsDoH4c25SlR5Pam0MTF4E63gZanzmr+/LHrOUq/+IhupPwcIAG+GY1JQl5
         nMuy2BveVfX9N62aV6RUokxrIPvHv2YLLjofVdt9F09UzHxcHEhc5hVFlMgoNNMb6Kov
         dt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7awYh+QY55coYj7eF10l2HQHVbESJZBMxM5Q/rUGjG0=;
        b=gW/iEqV7Ueml0KhrD4VtC3PnkBvI+k8SoRx38wSWwXdx5JpvZEz+Wdbnygq3qtN8BP
         texmcBw/Nj3DvWrzxR8Y+UMw0VJ/zItWTV+e5+Mp2UeCdNA6PMT40NIkiHnL4u2cv2tN
         xPc9PeS1H7Xm+d6BuASd0O/D0cxe8XDqXFrII1np/RAE9kGK9Zg9dlMECzmjHgtuv8Pa
         lhTdgyLHSy3ncg4CtWaMpdZAsMgUJhMUcF3XR6hh8vql4yGqnQkS2x+eS3QcwVA2k75y
         bHck5ZLKKG1BT3TVGTpEA2Ynhyr77D8uOXRvtjGuzLAgtRFRhvsXkafH6iSpH8KGm5zq
         /IVw==
X-Gm-Message-State: AOAM531Mfw+1O9ghj4vdTBxX0Jlr9nbZODJQxKLs4+bvZUcYlWbC1n1l
        lcm2WPHX6vEGH9ZvFZz847/K9CG6THw=
X-Google-Smtp-Source: ABdhPJzBuiUIG5mwARkeIegtudg9gJVzRIdjjbwhHsXnJLt+p8ns14iz4K+CSno/S4MkVKdR/ghSpQ==
X-Received: by 2002:a9d:7084:: with SMTP id l4mr25182001otj.161.1600464359712;
        Fri, 18 Sep 2020 14:25:59 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:4725:6035:508:6d87])
        by smtp.gmail.com with ESMTPSA id v20sm3536635oiv.47.2020.09.18.14.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 14:25:59 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v5 0/4] rxe: API extensions
Date:   Fri, 18 Sep 2020 16:25:53 -0500
Message-Id: <20200918212557.5446-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series implements the user space changes matching the v5 kernel
extensions.

It is an extension of an earlier patch set (v4) that implemented memory
windows.

The current set (v5) also implements:
	ibv_device_query_ex
	ibv_create_cq_ex
	ibv_create_qp_ex

Bob Pearson (4):
  rdma-core/providers/rxe: Implement MW commands
  rxe: added extended query device verb
  rxe: added support for extended CQ operations
  rxe: added support for extended QP operations

 kernel-headers/rdma/rdma_user_rxe.h |  68 ++-
 providers/rxe/CMakeLists.txt        |   5 +
 providers/rxe/rxe-abi.h             |  16 +-
 providers/rxe/rxe.c                 | 624 ++++-----------------
 providers/rxe/rxe.h                 |  98 +++-
 providers/rxe/rxe_cq.c              | 449 +++++++++++++++
 providers/rxe/rxe_dev.c             | 146 +++++
 providers/rxe/rxe_mw.c              | 149 +++++
 providers/rxe/rxe_qp.c              | 810 ++++++++++++++++++++++++++++
 providers/rxe/rxe_queue.h           |  42 +-
 providers/rxe/rxe_sq.c              | 319 +++++++++++
 11 files changed, 2198 insertions(+), 528 deletions(-)
 create mode 100644 providers/rxe/rxe_cq.c
 create mode 100644 providers/rxe/rxe_dev.c
 create mode 100644 providers/rxe/rxe_mw.c
 create mode 100644 providers/rxe/rxe_qp.c
 create mode 100644 providers/rxe/rxe_sq.c

-- 
2.25.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6241E1AAE
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 07:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEZFU2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 01:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEZFU2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 May 2020 01:20:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D9DC061A0E
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 22:20:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v19so1936277wmj.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 22:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dUozln2vSI4BCFpTcaxnB9zos/FemdVzHzJQecxTlzM=;
        b=X12k5Dbqd1BbSLA5I/Ik+vwWvEE+dSSqnEepWapYJCJWEu89g4OipHhL4qWFckZsCg
         uCuCxqynK6mBp3cbg54TGSfAyrbynQyvadKCEHFywnxdSMysiB83TMQbilHKcFZ4LW/2
         pozbZuKqgHB7l1gIOScTfBjV/k3+h1BnbLad0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dUozln2vSI4BCFpTcaxnB9zos/FemdVzHzJQecxTlzM=;
        b=DfXv3zYA0jTdoq2hgZjf/Dormr536hM119nZA2INoVE7nupqkwotC9s8VMQv9GSD3U
         ZaFhzQjV7osAD3mhUr4S92GS5owoZn8QYlEUn/ciAd4YFVmaGvY2ZW+Z1su3Gnq5gEuA
         tIAGvROMtQMS1LxL9NrdXvbExz4dHAKzBSc9GfIsuq+GyB2obIW0/+L7msA2tffde8PW
         Fxbd6afv93G5HcAwsuDZVrYGmpGJQn8u72DPLyLzy+r4mNSj+rSq9m5YywZtlxh0f1/i
         +UUyXzsVkZaj9Nd1aXrr+r7ZDy4ulMa9X5clH5IHzgvgYZIARIEimOviSoJwRvQMVPKv
         AXrw==
X-Gm-Message-State: AOAM533bbx0X1KbwLRy73MeUMXCyIePPFv9VG5ZOM/pAXsibH0v3+SVy
        5NpIFj/7tfJNfAnsQ/0NCIuLan/qMFg8u1MsXJhqWdurQA8oeI1L5Gc1x3Mu6dYrn4Inber81Qr
        Lw5jEKh7LcCiqUAVaQoBa4DNxzwFDg+M6QZK/pDrXVjvKMbOJm+FgN7WyaGz9JXpBS7lkWeA/cm
        mD8TA=
X-Google-Smtp-Source: ABdhPJwjREelSn8N7bw4RSbIbAKd9dUWBsOy58g2T7YUBOa2ADEii9QpPGOBY4i6VO9VLQt1NnDwWg==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr9377154wml.188.1590470426182;
        Mon, 25 May 2020 22:20:26 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 40sm19807069wrc.15.2020.05.25.22.20.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 May 2020 22:20:25 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     devesh.sharma@broadcom.com, leon@kernel.org
Subject: [PATCH for-next 0/2]: Broadcom's driver update
Date:   Tue, 26 May 2020 01:20:00 -0400
Message-Id: <1590470402-32590-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series is mainly focused on adding driver fast path
changes to support variable sized wqe support. There are
two patches.

The first patch is a big patch and contain core changes to
support the feature. Since the change is related to fast
path, the patch is not splitted into multiple patches.
We want to push all related changes in one go.

The second patch is relatively few lines and changes the
ABI.

The corresponding library changes will follow short after
this patch series.

Devesh Sharma (2):
  RDMA/bnxt_re: change sq and rq to be indexed with 16B stride
  RDMA/bnxt_re: update ABI to pass wqe-mode to user space

 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 152 ++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   8 +-
 drivers/infiniband/hw/bnxt_re/main.c      |  23 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 746 +++++++++++++++++-------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  | 128 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  63 ++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  13 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  |   1 +
 include/uapi/rdma/bnxt_re-abi.h           |   5 +-
 9 files changed, 746 insertions(+), 393 deletions(-)

-- 
1.8.3.1


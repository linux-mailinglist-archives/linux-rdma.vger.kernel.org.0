Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4397519C88D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 20:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbgDBSMa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Apr 2020 14:12:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51646 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBSMa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Apr 2020 14:12:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id z7so4424581wmk.1
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2020 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BuS54i86OZjtzNJ9hWFXWHbLoPOzQ8Rmw2+DKdRU3Co=;
        b=M46a29jdeMMnW4ZL8H65rChTMh/XB9RjYD3P6lEWomy4Xp6R2KHoAafT4JAGmJ8MU5
         i2F7SGPJGHryZTD6JUApfhYXHFvOhGFj9i4i6UcegTg2L1S6S8/jAHfLxjffnm8ODhEc
         VMZFriD4GOCy1F9FmF4RVuy454OecRcDNFv6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BuS54i86OZjtzNJ9hWFXWHbLoPOzQ8Rmw2+DKdRU3Co=;
        b=Db9QjemZv/ysCEZQwC2OvZGtoxqNk1kZLLbqHrQ0ydpwCFaGjzL3uO3CXaC1XDimhM
         moU5XmvJDDvvXHe0sbPpoeX52G2DdrDkwzz4bb3m0QyZkFQYgXSFekaZZP8RcbYQ6T7T
         aXDVi+5Gu9LLFLLmisGSq42L6RSBfV6RIH7GD1TOWSN1r5bv37pzSkmp90Wr08+CZ3zk
         N9kLOZoaiJujRLWSSSoCc01p6k+tkhLx3jukxQt5DyJ41qXyrUZwp8emtAPqQs17YmYh
         KvPxIgkjKI5R3pLkYTnnFkETVWTa7Ebbi7xTH9z8PbvT4wIl1fRmpUoJVwcebsObh2Mz
         Dxvg==
X-Gm-Message-State: AGi0Puax/PsVTfmdCYKtjYVCjhPa+oY6yLZqsD/GsGwpU7WFoTlsYpWt
        fEie75M9SskFY9NThtba7AjprdcPLhtx/7y69yt6x+nvMI14vz+dR2BHzcYp8nrxgb51TyrD7we
        Ki3wphXnojzMxs76aj+aZ95TkyLEK15DBVsaPwMuhcAvcTayh17I8QKvQGFAnkSB6ZKKnCHAVXe
        RMopg=
X-Google-Smtp-Source: APiQypJ5QKC28AE8ZOgVljORpcZ7kbN8oSXjnGGJBwT2qio/Y3+h+XGSWZP1Mvtuj01VMdltlrXyYA==
X-Received: by 2002:a05:600c:2297:: with SMTP id 23mr4332583wmf.166.1585851147232;
        Thu, 02 Apr 2020 11:12:27 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k3sm8399351wro.39.2020.04.02.11.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:12:26 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 0/4] Further improvements to bnxt_re driver
Date:   Thu,  2 Apr 2020 14:12:11 -0400
Message-Id: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This short patch series is an extension to the previous
refactor series. The main pourpose of these patches is to
streamline the queue management code in slightly better
way.

Devesh Sharma (4):
  RDMA/bnxt_re: reduce device page size detection code
  RDMA/bnxt_re: Update missing hsi data structures
  RDMA/bnxt_re: simplify obtaining queue entry from hw ring
  RDMA/bnxt_re: Remove dead code from rcfw

 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  65 +++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   |  10 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 354 ++++++++++++-----------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  42 +---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  88 +++----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  91 --------
 drivers/infiniband/hw/bnxt_re/qplib_res.c  |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  53 +++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   | 106 +++++++++
 9 files changed, 385 insertions(+), 425 deletions(-)

-- 
1.8.3.1


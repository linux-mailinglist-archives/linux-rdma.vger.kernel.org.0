Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E547615FF68
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2020 18:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgBORLV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 15 Feb 2020 12:11:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42310 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgBORLV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 15 Feb 2020 12:11:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id e8so5051970plt.9
        for <linux-rdma@vger.kernel.org>; Sat, 15 Feb 2020 09:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=b52mpWSzxJxz51aDnL6OHP8/XV6qq/clzyRvjZumh80=;
        b=d2gwfmbI5JToup4cAZjVuTD+5eYeUxY5yGQaOArC3O+kAGGnaGJTNME+to2nkHKcQa
         uiV6XaxTHhJAsBYdgJoBEo8sPCbBwipud+KAcHO6SRj9mOAqKayuG7KMmtEbYWV3EkzQ
         Ky/bq54YwyXQ77JY3qeqkOljhDB5SIDeVsLXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=b52mpWSzxJxz51aDnL6OHP8/XV6qq/clzyRvjZumh80=;
        b=jHsd198MHJFGXcNX17LnKuF3K3GAb9cHgGxa709SCOcpsZgRHb3UdtFmwvAL1SBvPB
         aTcsHvx+AXaDxokiytBWIXoyqw3WoKfj5Ww/7H/zEMo2SNlLOOtOJAq0X56TLjwedHD2
         Svi2e2RprwOTmvKijfGo7SA2KpqVHVHlwK/zzvKr9BK459Ar9fvMGWsQ61Vhdg1hWqJt
         uSVbQT6t2dL2aRj1phb0czGroBfR5/uGs+lXcd6ka5cvf2btdj9PSu8zsfs6xqEHZHiA
         6Pv9vI4e1gHZrcGOHZsNUu6Wb5ZfOOsYZMdLSO+qoH5522QOANHKc7EJrMF1JzUjSk/m
         p8ng==
X-Gm-Message-State: APjAAAUbHqQBZsnY2a92p34/9fgnKijoB3p38L2N01GTnIBLVOo3jz7I
        +zaduNlmKebtFJGR2opW0QHTdU8LEaW69QHbejo2r7pqUe6u902wxmCHrlfCAVIo0cT2W710vRs
        stnyMG6JmOs0PbpLUHU0OZHc/SH/9KoOkKWk0eUNKm4sbuDqiPpIOi4wCv6PnnJyu3DcSma3Kzc
        qNnkA=
X-Google-Smtp-Source: APXvYqwbgGleqyqBivTyZ4O0J0dK/BkKWVEycSQomBcAq8hzsFU5sNvat0hkRnlPb1DaRedZ/qjNLA==
X-Received: by 2002:a17:902:758e:: with SMTP id j14mr9034611pll.18.1581786680651;
        Sat, 15 Feb 2020 09:11:20 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r198sm11755664pfr.54.2020.02.15.09.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Feb 2020 09:11:19 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH V3 for-next 0/8] Refactor control path of bnxt_re driver
Date:   Sat, 15 Feb 2020 12:10:57 -0500
Message-Id: <1581786665-23705-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the first series out of few more forthcoming series to refactor
Broadcom's RoCE driver. This series contains patches to refactor control
path. Since this is first series, there may be few code section which may
look redundant or overkill but those will be taken care in future patch
series.

These patches apply clean on tip of for-next branch.
Each patch in this series is tested against user and kernel functionality.

v2->v3
  -- Rebased the series on tip of for-nxt, linux-5.6-rc1

v1->v2
patch 0001
  -- removed unwind logic when qp destroy fails.
  -- removed atomic dec out of mutex lock
patch 0003
  -- saved memset by using default initializer for hwq_attr and sginfo
patch 0004
  -- saved memset by using default initializer for rattr.
patch 0008
  -- a new patch to remove dev_err/dbg/warn/info from driver.

Devesh Sharma (8):
  RDMA/bnxt_re: Refactor queue pair creation code
  RDMA/bnxt_re: Replace chip context structure with pointer
  RDMA/bnxt_re: Refactor hardware queue memory allocation
  RDMA/bnxt_re: Refactor net ring allocation function
  RDMA/bnxt_re: Refactor command queue management code
  RDMA/bnxt_re: Refactor notification queue management code
  RDMA/bnxt_re: Refactor doorbell management functions
  RDMA/bnxt_re: use ibdev based message printing functions

 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  24 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 900 ++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/main.c       | 264 +++++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 416 ++++++-------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  94 +--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 467 +++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  85 +--
 drivers/infiniband/hw/bnxt_re/qplib_res.c  | 470 +++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_res.h  | 145 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  48 +-
 10 files changed, 1737 insertions(+), 1176 deletions(-)

-- 
1.8.3.1


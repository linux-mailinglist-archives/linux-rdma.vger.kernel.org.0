Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C1214E094
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jan 2020 19:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgA3SNQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jan 2020 13:13:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38482 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgA3SNQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jan 2020 13:13:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so5305238wrh.5
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jan 2020 10:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xz1Ks2bXsAH4NtB5MQLIPE0XypLc86bjXMI5vwpNNzo=;
        b=geJX5A3VHmIaNKlzy5BpGRTswcUzrbTEjSu05hc/WrSkEhzLWuD+PCMoaCqt1DK1t8
         rb7fU24eoSTnE0e3dT6MgMQDQOTE7xsKCsM0tGm6TVVOwj9NWOyqBG87/j11OUEBBq/i
         /JIZValwnTZHUcstEGvbal1xQ7bJ54nuvp1/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xz1Ks2bXsAH4NtB5MQLIPE0XypLc86bjXMI5vwpNNzo=;
        b=R1upij5WxokekU9ZB/4zp6URdAPzh2OKLvssfck+cLQVV1NZSBoV+MDliEV+UIN/9L
         hv4HiqUCquuWd+XbClKE5t/GW30Q2d//nR1k63Urz2iWJDxsdR6BIHycj7Dq8wvLdXYy
         44hqkKNQOd7CVdPYkzipyIenGVpRkjJA3voHKHGmK6dm7dJnRJ733gb/0Xga7IaaQVkW
         kkQASA8vd4bUv7G7QGLkQmxTQkqbkDBpy6h+yB6i+i87R00buWQaWWEmY79iLv+TBpeJ
         x73QVZPf8q5VEB2td60qF35gWRuiQNyAHlC935z6jqSFUUXJckwPfmVQ7dc8C4PdOxnL
         r1hg==
X-Gm-Message-State: APjAAAVQe+2SE7MMyu3WxwgV/TlFkPFP7rSjkByODyEeHrOLEE078KZJ
        9fNsZvjXW16mY0a9izF0Mk4lB2+eij3aTj3K6Cq4s8nY28LauX+j96GGIo3QsSS4WfFRJobua4z
        coEtftutGuhk0iowKxxZVUGNtMQDGYYlr21H86UYIOjRuh28jtpadbZsNy5DGfhklW+b5IUJNzs
        4OZu0=
X-Google-Smtp-Source: APXvYqzGu58E8sbtsAUFLDU9jW1+5/oidY8RhRyr4Uwo+hiNWvVBCm7HDCXJtx0ZyYbEtUNdyiKPmg==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr6801961wrs.420.1580407992176;
        Thu, 30 Jan 2020 10:13:12 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d14sm8695060wru.9.2020.01.30.10.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 10:13:11 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH V2 for-next 0/8] Refactor control path of bnxt_re driver
Date:   Thu, 30 Jan 2020 13:12:54 -0500
Message-Id: <1580407982-882-1-git-send-email-devesh.sharma@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 415 ++++++-------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  94 +--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 472 +++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  85 +--
 drivers/infiniband/hw/bnxt_re/qplib_res.c  | 470 +++++++++------
 drivers/infiniband/hw/bnxt_re/qplib_res.h  | 145 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  48 +-
 10 files changed, 1739 insertions(+), 1178 deletions(-)

-- 
1.8.3.1


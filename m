Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9D25CDC2
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Sep 2020 00:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgICWlm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 18:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgICWll (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Sep 2020 18:41:41 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A77DC061244
        for <linux-rdma@vger.kernel.org>; Thu,  3 Sep 2020 15:41:40 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r64so4761292oib.6
        for <linux-rdma@vger.kernel.org>; Thu, 03 Sep 2020 15:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TrT5tNcSnpuQvriShdeGragXMYA3GnabOOF0tWydWY=;
        b=PRoM2LmmK/zBJI2jaPE0HwKu58KasWV9GObQKfxFNGJZ6hTHXMTYscTodqQQeskJGF
         2XkXFlV+1NlivRnIUPQU9KHmzAbk/u0dGdxQTlWy3qQkiMJgdqbud9RQT2WkXrCvVAld
         lE/teyPyxv3G59u5UWbO1U86RXyEHPvQounVy3zGpnnHsr7hjGXWlnnE2DvGOp7h23ZO
         3vQNS1hAfW7SIuETNM0+LnQX0vsdBTzHKSxQ7qti4f5D7gGUmKAQJER7BiojU8ylPSga
         7WVAosLb7gC6oXtpRMcQbfYo1N2oh+UP/R5S0urQczobLW/MhH+oQm8CrCe4M8c6w/Ta
         m5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TrT5tNcSnpuQvriShdeGragXMYA3GnabOOF0tWydWY=;
        b=tc4bHVxcdhLRtTuer5AP8XxCsQqlOAc26innVrUtucXiPP/dVReo/5cn9uBLpWO3a7
         QIPJo+5j2AnGDzsH9aVDj/u87q5KS0pT/AaiY2lSZc1BiVyhxChMAESP6j7fE2Apqo+K
         Avw/fr8JdwljE7TiO0TfpBZbBRo+RXL2gRas5CIKF5c1ZbKX+rck7iAyJgkgpbXJNsrp
         iPUC09QmqIQ5iyUwfnIFUFKOaq3nZy6vZoKNeBmWny/gsTI+n/4tBeHHrzYheGS36uMS
         OafQrb6kVJZqXT9RnV089kAmLlkEsjL01Bf6XkrwCoLXhvXdsxKvnzUfyzY0K097jt0e
         KAhw==
X-Gm-Message-State: AOAM532hbZMchivXhKS1b+kojOUdH9WV3UDkFPoq90cSFR6F0WBrhNQY
        O7FUURu0ZVragxaEYIZ3HoM=
X-Google-Smtp-Source: ABdhPJwCGNCYs1lBL37IZY4W3DlU1TccOoFd+t1og9UXTS1aWjdLEp7vUTUXSYS2mX6pdBq8eH/9dg==
X-Received: by 2002:a05:6808:194:: with SMTP id w20mr3580688oic.79.1599172900105;
        Thu, 03 Sep 2020 15:41:40 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:6a3a:fc5c:851c:306a])
        by smtp.gmail.com with ESMTPSA id b16sm822901otq.31.2020.09.03.15.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:41:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v4 for-next 0/7] rdma_rxe: add memory windows to rxe
Date:   Thu,  3 Sep 2020 17:40:33 -0500
Message-Id: <20200903224039.437391-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This set of patches adds support to rdma_rxe for:

	alloc_mw (type 1 and 2)
	dealloc_mw
	bind_mw as a user API (type 1)
	bind_mw as a local send queue operationa (type 2)
	invalidate mw as a local send queue operation
	invalidate mw as a remote send operation
	memory access to bound MRs via MWs with VA or ZB MWs

Changes in this version from the previous version:

	Dropped patches that have already been picked up in for-next
	rearranged the order to be more logical and avoid throw away
	code in stubs.
	This work is focused on MWs. There are some areas
	exposed in the existing driver that should be improved
	but that can be done later.

Bob Pearson (7):
  ib_user_verbs.h: Added missing WR and WC opcodes
  rdma_rxe: Separated MEM into MR and MW objects.
  rdma_rxe: enabled MW objects
  rdma_rxe: Let pools support both keys and indices
  rdma_rxe: Added alloc_mw and dealloc_mw verbs
  rdma_rxe: added bind_mw and invalidate_mw verbs
  rdma_rxe: add memory access through MWs

 drivers/infiniband/sw/rxe/Makefile     |   1 +
 drivers/infiniband/sw/rxe/rxe.c        |   1 +
 drivers/infiniband/sw/rxe/rxe_comp.c   |   5 +-
 drivers/infiniband/sw/rxe/rxe_loc.h    |  43 ++-
 drivers/infiniband/sw/rxe/rxe_mr.c     | 350 +++++++++++----------
 drivers/infiniband/sw/rxe/rxe_mw.c     | 414 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   1 -
 drivers/infiniband/sw/rxe/rxe_param.h  |  10 +-
 drivers/infiniband/sw/rxe/rxe_pool.c   | 114 +++----
 drivers/infiniband/sw/rxe/rxe_pool.h   |  34 +-
 drivers/infiniband/sw/rxe/rxe_req.c    | 113 ++++---
 drivers/infiniband/sw/rxe/rxe_resp.c   | 105 +++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c  |  72 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  61 ++--
 include/rdma/ib_verbs.h                |  16 +-
 include/uapi/rdma/ib_user_verbs.h      |  11 +
 include/uapi/rdma/rdma_user_rxe.h      |  44 ++-
 18 files changed, 1026 insertions(+), 380 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c

-- 
2.25.1


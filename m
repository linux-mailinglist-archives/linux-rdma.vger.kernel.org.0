Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D883636793F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 07:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhDVF3X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 01:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhDVF3X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 01:29:23 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26095C06174A
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so41093024otn.1
        for <linux-rdma@vger.kernel.org>; Wed, 21 Apr 2021 22:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FxzNvh8oC5YIbSKVm/1TWjVy7hhokhN9xZHrgkzT//I=;
        b=XmP9k/EtdXn+sR8UJtqSOo9zPGlrUDnhcNsuXMqqFVWAZRCP2QMwb1mzcB8zM6J9zj
         89EMg2S1SFtqN0OhbicuoPM9GBsPzq1n442Zr6T9DZzhv+O9ZRqfBLnLciLI35GDMfNk
         ZzhbFOtRehyhVwVoxOS+M5WwzpAbVhvhyfCd0+pCajC+d+/B+ST8SqI/9OluDPeU+RHV
         oTdV0wil44N3BC/ffOyKogXEaOSmgHIY+M4PR6f7+R9ZvQK/Xa6aXPzE5E9T0yEaGWFw
         jTCdC1yy1wABp0BY0oDHy6RPnG1VCI2DxrNRhAEC/RLBqi/62ypv45oD8ylfj0uV3eI/
         i4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FxzNvh8oC5YIbSKVm/1TWjVy7hhokhN9xZHrgkzT//I=;
        b=JVB7p9Y1K2lxF3vOstFZAjnRvAHUiXKczLi29oTdoMkn4Sa/q29RZ/eM8dgc5Cb1sQ
         SrEZUntKuV/Iji4p8nCIHWpiOoK5kL5dg/sCVb1dP4bj/rwY0cF3ulGKVS0NiWHUV6bj
         ukrUxCPhNrxHaLwPbtBOXrYlRGN93A9nXa1dCVwgGdQ3GI5CFGOFyMCBsDM8vvaNeNXW
         dPn8Y17dpmAmz1WnKL209V4I4bvlnk8k1PCbh1bWWuvlLqutTHfpwGV6lPo5w4CQcj7+
         mx4z0P623RFkmigcCokUCQdKDvOaUbSaoqHmmOElbxjPyhfQ6c6/d/1JbsFKIp09nyMC
         1ymw==
X-Gm-Message-State: AOAM530ro1VvHUj77+BckGs2xVzvuqu26JjjsYoexDHjd7ZiOSBA7a4B
        j3/is8BxXSqwCqAuIZrPikc=
X-Google-Smtp-Source: ABdhPJw0YU1HGbmvpK3xkTBKl2R+M9HBw37kMo/b2bTxqz5gpns1UXCveGBfOkRvrFQtbfRX88tP+w==
X-Received: by 2002:a9d:3423:: with SMTP id v32mr1427688otb.168.1619069328542;
        Wed, 21 Apr 2021 22:28:48 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id h28sm373946oof.47.2021.04.21.22.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 22:28:47 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v4 00/10] RDMA/rxe: Implement memory windows
Date:   Thu, 22 Apr 2021 00:28:13 -0500
Message-Id: <20210422052822.36527-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches implement memory windows for the rdma_rxe
driver. This is a shorter reimplementation of an earlier patch
set. They apply to and depend on the current for-next linux rdma
tree.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
v4:
  Added a 10th patch to check when MRs have bound MWs
  and disallow dereg and invalidate operations.
v3:
  cleaned up void return and lower case enums from
  Zhu's review.
v2:
  cleaned up an issue in rdma_user_rxe.h
  cleaned up a collision in rxe_resp.c

Bob Pearson (9):
  RDMA/rxe: Add bind MW fields to rxe_send_wr
  RDMA/rxe: Return errors for add index and key
  RDMA/rxe: Enable MW object pool
  RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
  RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
  RDMA/rxe: Move local ops to subroutine
  RDMA/rxe: Add support for bind MW work requests
  RDMA/rxe: Implement invalidate MW operations
  RDMA/rxe: Implement memory access through MWs

 drivers/infiniband/sw/rxe/Makefile     |   1 +
 drivers/infiniband/sw/rxe/rxe.c        |   1 +
 drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
 drivers/infiniband/sw/rxe/rxe_loc.h    |  29 +-
 drivers/infiniband/sw/rxe/rxe_mr.c     |  79 ++++--
 drivers/infiniband/sw/rxe/rxe_mw.c     | 356 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   3 +-
 drivers/infiniband/sw/rxe/rxe_param.h  |  19 +-
 drivers/infiniband/sw/rxe/rxe_pool.c   |  45 ++--
 drivers/infiniband/sw/rxe/rxe_pool.h   |   8 +-
 drivers/infiniband/sw/rxe/rxe_req.c    | 102 ++++---
 drivers/infiniband/sw/rxe/rxe_resp.c   | 110 +++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  38 ++-
 include/uapi/rdma/rdma_user_rxe.h      |  34 ++-
 16 files changed, 691 insertions(+), 151 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
-- 
2.27.0


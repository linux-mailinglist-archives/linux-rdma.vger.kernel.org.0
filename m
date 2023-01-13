Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD83668853
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 01:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjAMAWX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 19:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbjAMAVu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 19:21:50 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1028412A86
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:21:49 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id n8so16641583oih.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDT+nB5Gy9IsKkfXCiAMo8PuvN7K3eAYuMB37Z7whBo=;
        b=RJ0in4Fp57tpwfHjLMfaCOpkd+WJf7ZMY2HgdVVLSJl951l9yWd98t/D5CGROhKe5J
         IrJCIrNcGr6CFZnBWXr44HV/tu/I55VUWJoSidCqUPaqPVhv5Q4+BjPp1bprPUmrRcK9
         SWwyfQPL314mPmemTT6KTfWw3yI0Sifv9aLUbyeJqiN3d4mnPn54s7sj300SxT9p+XzZ
         vrsydGlSwFJ7dcbTs98wPPWA6jrNtbbAE15I0ZakVdKpWKlKG+Zz54V1Q90hufDqtF5o
         mz8ncRYYZy41bhAHKjOCkGC6LQWatOKMxqabVtlWAHiDKPVQqyTxNQ7mjBW4kVIqaVu/
         3vvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDT+nB5Gy9IsKkfXCiAMo8PuvN7K3eAYuMB37Z7whBo=;
        b=GcQ13lVkIRdwIypY9YGnL3WmModP+EqnhIKpfZmS5zxBZG9c9E89juwEJTrUqvmeR7
         xDRto8NINoykCsxEStIRjdL2uDoRfFFvBVT6rVlvA9iVFPuJQY+kHwTjDrNRgDYYPBj1
         jxngz0EMBhqm7h9BeV1kPfR4GxiFvyDgkPHGFur4vQMtqSx+ZOKhvIbrVfSqu543ufo7
         eAMCKCBPSTLE6/tCYHv2vxtM9Nj6OYu7Ltq1bPrNHZaFKgb1EXoIPZJrU81HJY8nkQNt
         M+k3yY+sjfIhweUd4nqCmu3ZHNQvzSobAJhKvHtrUYn9t+rHZF3Ruy9b6O2qWdTCCZZ5
         EyCQ==
X-Gm-Message-State: AFqh2kpF00WAn4rY5zs1Vyd9qud/WaXshWfXbIgVa5Z3FJT2SZOibyww
        +osVW0jqYv0bhhF9Yt90RNQY0VqrG/jDLA==
X-Google-Smtp-Source: AMrXdXuLm9EE3DByXuBHlY6sqKT3O9APGxMHuiGQVRRKT3GJtZvGu0ldCNzEkr2VhZc1zo41M5dYxw==
X-Received: by 2002:a05:6808:1408:b0:364:8b38:b4d3 with SMTP id w8-20020a056808140800b003648b38b4d3mr4057456oiv.26.1673569308277;
        Thu, 12 Jan 2023 16:21:48 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-550f-93bd-b210-47c2.res6.spectrum.com. [2603:8081:140c:1a00:550f:93bd:b210:47c2])
        by smtp.googlemail.com with ESMTPSA id z25-20020a056808049900b0035a9003b8edsm8480471oid.40.2023.01.12.16.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:21:47 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/6] RDMA/rxe: Replace mr page map with an xarray
Date:   Thu, 12 Jan 2023 18:21:10 -0600
Message-Id: <20230113002116.457324-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series replaces the page map carried in each memory region
with a struct xarray. It is based on a sketch developed by Jason
Gunthorpe. The first five patches are preparation that tries to
cleanly isolate all the mr specific code into rxe_mr.c. The sixth
patch is the actual change.

Bob Pearson (6):
  RDMA/rxe: Cleanup mr_check_range
  RDMA/rxe: Move rxe_map_mr_sg to rxe_mr.c
  RDMA-rxe: Isolate mr code from atomic_reply()
  RDMA-rxe: Isolate mr code from atomic_write_reply()
  RDMA/rxe: Cleanup page variables in rxe_mr.c
  RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray

 drivers/infiniband/sw/rxe/rxe_loc.h   |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 563 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 105 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  36 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  32 +-
 5 files changed, 362 insertions(+), 380 deletions(-)

v2:
  Rebased to 6.2.0-rc1+
  Minor cleanups
  Fixed error reported by Jason in 4/6 missing if after else.

base-commit: bd99ede8ef2dc03e29a181b755ba4f78da2644e6
-- 
2.37.2


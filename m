Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544C666E4F2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 18:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjAQRcV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 12:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbjAQR2S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 12:28:18 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B9249948
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:27:00 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-15027746720so32665757fac.13
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sZhFWAkuLurH9WC7XkXhPmHx7Rc6OYG+XDwLv3j+sw4=;
        b=np2at8H5ldR1XxVOoK6Q+NkE7CRmvZ8YSF3Mkgzgf/dtA/aRuB3XWd3WiFrgW5eRRj
         Q5rUbQd9roQqWZVyMHqGwA7nGod8EoT4mCtZsjRho9NudCFOeRF5EWZdcpg3iZIqd3uw
         vsywHWG3UKxfuXqCvNc6yTyuohRiw6yRkv+ZKMb+8WNZxKk0Fp39bUUNdcbPZxetFFbH
         8bRfbveFz5eNmhsnWNGKbnSDQmZvHEvtOkeHFU3jiNiwEvJdO9Wwa9HlAmw0hRYvoLGq
         T9EE/+ixwtscFfX38QbAqXZUEr4P3kqZUwkH1qvbsYJE4QIdvIJ4/Yuvrwnh/fiGD0+x
         zGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sZhFWAkuLurH9WC7XkXhPmHx7Rc6OYG+XDwLv3j+sw4=;
        b=AYL26TAU3D2u2EsfVcmGa4ATJxq6dDy+g5rBCoGus2Nfyo1xMGU0pvCeReMwTtxxTk
         XrC0Xvd9gmlGR957bJStAoH0I5bIFxDru7JPLJ8MiJMG2h7fDXm4cMZ5J/B+xFHawhvV
         nQeFFvbhN/8p/Swmy1HfsvD9T59KG3VLa8pvpvBV3Q70UsTPKJQ/AtqIA39TCvREKCtj
         S9OHdFTefSa3zuCb4OHJ5naSRdFRK3C5E7Ke9IQg9eatBYC12G9CYRABLBX64xTxQlHP
         y0ksbmCc0y3ZfsPo+b65UQzcrMZpjF4Wn1kHuW18GxUiRoMiTQHOB1XlhBIfSCO5yBLG
         E2ig==
X-Gm-Message-State: AFqh2kq/cgXHYCadbUyvvbIL7Zhd7qNh9XCWh2LApmSeVYSEu2aeIScB
        9AkFuLokWb2VWZKmuhFvREzgXSswcNYdEA==
X-Google-Smtp-Source: AMrXdXv5ag0fmb2WoqSxmNV8cAKhRa+1cXcV6QNfdEs3wCMqiZ8DC5l3/2oeV1pdMsRnYVQQuBg8FQ==
X-Received: by 2002:a05:6870:9d0a:b0:15f:32b:6e33 with SMTP id pp10-20020a0568709d0a00b0015f032b6e33mr2075583oab.39.1673976420239;
        Tue, 17 Jan 2023 09:27:00 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id l3-20020a056870218300b00152c52608dbsm16936489oae.34.2023.01.17.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:26:59 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 0/6] RDMA/rxe: Replace mr page map with an xarray
Date:   Tue, 17 Jan 2023 11:25:35 -0600
Message-Id: <20230117172540.33205-1-rpearsonhpe@gmail.com>
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

v6:
  Respond to a comment from Jason and moved the #if defined CONFIG_64BIT
  outside of the rxe_mr_do_atomic_write() function. I realized that
  the #else case isn't needed since it will never be called so if
  someone does try it will fail at compile/link time.
v5:
  Responded to a note from lizhijian@fujitsu.com and restored calls to
  is_pmem_page() which were accidentally dropped in earlier versions.
v4:
  Responded to a comment by Zhu and cleaned up error passing between
  rxe_mr.c and rxe_resp.c.
  Other various cleanups including more careful use of unsigned ints.
  Rebased to current for-next.
v3:
  Fixed an error reported by kernel test robot
v2:
  Rebased to 6.2.0-rc1+
  Minor cleanups
  Fixed error reported by Jason in 4/6 missing if after else.

Bob Pearson (6):
  RDMA/rxe: Cleanup mr_check_range
  RDMA/rxe: Move rxe_map_mr_sg to rxe_mr.c
  RDMA-rxe: Isolate mr code from atomic_reply()
  RDMA-rxe: Isolate mr code from atomic_write_reply()
  RDMA/rxe: Cleanup page variables in rxe_mr.c
  RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray

 drivers/infiniband/sw/rxe/rxe_loc.h   |  13 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 622 +++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 118 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  36 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  37 +-
 5 files changed, 422 insertions(+), 404 deletions(-)


base-commit: 1ec82317a1daac78c04b0c15af89018ccf9fa2b7
-- 
2.37.2


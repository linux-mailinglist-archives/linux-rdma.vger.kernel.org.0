Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571796747C1
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 01:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjATADu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 19:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjATADc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 19:03:32 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0032D9F3BA
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 16:02:49 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id i5so3100612oih.11
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 16:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNkaEimXcF+ccELJzzSA5cuYciEWkXXC2fBzz1UI4Yg=;
        b=nLhvnbVdKEL2rDnqQ6DtfSbYS6gmUdyNsdOQoEqqsWFm0AKeOBT7YlTOYpUQdmlbjC
         8BzVzNYeh/jNUG4pNLrEi7cbXhUVyeHG34xVPY7/J6IuofcqgOKLB0XC+wvH6D2gTH3M
         rnAuIzvCpcYYzF0ijekT3YQXa8MR4h/erVNR/SdxYVevm3bDQRqp8hN6y6EAEJpW2kGd
         UehsT0lAa+Tvu9mjPNHmIAouLikhgJeW7IOSrMl9SJ4xQx/gJPXUt8ra6cHKcZfhKJec
         dWItspCvQJ+1p7GiJrYUbJCGUtHuqPgCGIGrl0vVHOLHkJ70FxgQiOK2j7ElJoTzoa8D
         mxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNkaEimXcF+ccELJzzSA5cuYciEWkXXC2fBzz1UI4Yg=;
        b=tCjBUjb/BPPDKiU3LypDi0gVW8gXpJ2feTcON55pfIpcc/CZH5cIlI66yegnQfaoUL
         lcLx2BZwLabCioeuMr4pzV9uAjSAmvXhNYWC57TlVPUdWA6I4ojZDT8kuVHVbla5TDMN
         tJTDMgYmNIhVIp99RBWDIZtTVFoAqsL2ocqbHBKr9iIzTUgqSylBy6gHRTzHiejfm/wj
         o6+BiUE+CXjmBHUFMencJxAtPL/1YI9/Pbf4yMpPaVS2nHhtbaRBuzAS1atqZgyoBLdF
         bobhoOy/JUj1SpAZYaLDMNHGhzz/PERlWxr2W5tE5dMJwzBDTKR1s/7HsvF2GZyXpJX+
         5EYw==
X-Gm-Message-State: AFqh2krKD1G1pFWMsLiddJ4xH5WIWzGTwTd0eVDRMy67/gRfn1vOugg7
        QZwuyntPfbL+65LorbDD5v4QMm7E/vDEyQ==
X-Google-Smtp-Source: AMrXdXvZstCoQNcFVPMH7yXfkq+tYCBf35qQKgXoPc32RYLi3exBKQYKdlCSjSeSdF64jnTw2SzXIg==
X-Received: by 2002:aca:191a:0:b0:368:7897:cbd0 with SMTP id l26-20020aca191a000000b003687897cbd0mr5377582oii.12.1674172969218;
        Thu, 19 Jan 2023 16:02:49 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-d086-74d8-5274-c0f1.res6.spectrum.com. [2603:8081:140c:1a00:d086:74d8:5274:c0f1])
        by smtp.gmail.com with ESMTPSA id bj23-20020a056808199700b0036718f58b7esm6139394oib.15.2023.01.19.16.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:02:48 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 0/6] RDMA/rxe: Replace mr page map with an xarray
Date:   Thu, 19 Jan 2023 17:59:31 -0600
Message-Id: <20230119235936.19728-1-rpearsonhpe@gmail.com>
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

v7:
  Link: https://lore.kernel.org/linux-rdma/Y8f53jdDAN0B9qy7@nvidia.com/
  Made changes requested by Jason to return RESPST_ERR_XXX from rxe_mr.c
  to rxe_resp.c.
v6:
  Backed out.
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

 drivers/infiniband/sw/rxe/rxe.h       |  38 ++
 drivers/infiniband/sw/rxe/rxe_loc.h   |  12 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 605 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 143 ++----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  36 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  32 +-
 6 files changed, 425 insertions(+), 441 deletions(-)


base-commit: 1ec82317a1daac78c04b0c15af89018ccf9fa2b7
-- 
2.37.2


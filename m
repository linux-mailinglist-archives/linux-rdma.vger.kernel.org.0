Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD75B735E6A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jun 2023 22:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjFSUVo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Jun 2023 16:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFSUVn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Jun 2023 16:21:43 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F93199
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 13:21:41 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1a9f25f271dso2948459fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jun 2023 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687206100; x=1689798100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhnhIO6gxg+bu4wuaGePVl+lqTScxGBy1B6fHOtVRq4=;
        b=oKRyO2E4EsYRVgd43454V1uYYLhU/dgSkf3HIG+IzrzbB3NSSfWMRIuAgwVPFEgMA0
         RCj8REVtPiDyOZ7jUgs7AoJHRh62B4rIrKTn69ymzVsXmix/F1Z/0EO6ynYSFPPAMaSF
         3o2LYVdDPDfkyWe05RJfd1TSNlNPH2kQpIGllcUoMDX3uJHjXCAz40eiXGbyYPmyMYJQ
         0HmtGA92RaS/BriBJ5trkuh7eYja6KYEplK2N/hBuR9zTMPDELWABqguSmqD4L1wOWca
         KIqRBZRMFUOl8YYtPTNz74hSfEYNVTF3lAWM7poi23INdZwYuUoFeX/3EMXXTDi4oP8Q
         iddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206100; x=1689798100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhnhIO6gxg+bu4wuaGePVl+lqTScxGBy1B6fHOtVRq4=;
        b=jy1wxzrRRqJj8GuJm6zHrusI/0ncQDIXARNw9NmVMgedo6vrX+awyWK6uNlf+5uY2C
         FVTltc8qtIyNs1mks+fx6ax1AjhRi4V8nNHrEv8C/Gd67q7NiCaQ9gvkyjvjs36E/e4R
         NWi3W/fn2BKSvbJTZ878TavHFVhj8T8pvUzi/F8t+gvkQenuibu+s6oHO275bY/Tkvwa
         5hBWLLNd+FONNsbIUeNM6OjJD2WACwtvd6WEFgPOtmhHvqvyO5Pkw6i99oyAZKdtV2fJ
         64yqTUqIKbKHi4Asix0bXybukE8tWoc8WxUnccIAnGonzjs9qzd9IsV+STtjlFtylohU
         xshA==
X-Gm-Message-State: AC+VfDxq/NgjJCY1UxNTs0fu2iyff971jSQP5K5jq1fk+i/J4JmpHYQ6
        +H19CN3ilSf0p19/XydAaM4=
X-Google-Smtp-Source: ACHHUZ4amtfLAr5IKImAC8vyAa6KhSIaLeVOQ4ECIIpykc4PJIODxe0tW5imGPdOo0I5mzDtJWZHyQ==
X-Received: by 2002:a05:6870:e481:b0:19e:cdd1:a400 with SMTP id v1-20020a056870e48100b0019ecdd1a400mr1416490oag.45.1687206100347;
        Mon, 19 Jun 2023 13:21:40 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-773b-851f-3075-b82a.res6.spectrum.com. [2603:8081:140c:1a00:773b:851f:3075:b82a])
        by smtp.gmail.com with ESMTPSA id kw41-20020a056870ac2900b001a6a3f99691sm311368oab.27.2023.06.19.13.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:21:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
Subject: [PATCH for-next 0/3] RDMA/rxe: Fix error path code in rxe_create_qp
Date:   Mon, 19 Jun 2023 15:21:08 -0500
Message-Id: <20230619202110.45680-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If a call to rxe_create_qp() fails in rxe_qp_from_init()
rxe_cleanup(qp) will be called. This code currently does not correctly
handle cases where not all qp resources are allocated and can seg
fault as reported below. The first two patches cleanup cases where
this happens. The third patch corrects an error in rxe_srq.c where
if caller requests a change in the srq size the correct new value
is not returned to caller.

Reported-by: syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-rdma/00000000000012d89205fe7cfe00@google.com/raw
Fixes: 49dc9c1f0c7e ("RDMA/rxe: Cleanup reset state handling in rxe_resp.c")
Fixes: fbdeb828a21f ("RDMA/rxe: Cleanup error state handling in rxe_comp.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Bob Pearson (3):
  RDMA/rxe: Move work queue code to subroutines
  RDMA/rxe: Fix unsafe drain work queue code
  RDMA/rxe: Fix rxe_modify_srq

 drivers/infiniband/sw/rxe/rxe_comp.c |   4 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |   6 -
 drivers/infiniband/sw/rxe/rxe_qp.c   | 163 ++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_resp.c |   4 +
 drivers/infiniband/sw/rxe/rxe_srq.c  |  55 +++++----
 5 files changed, 150 insertions(+), 82 deletions(-)


base-commit: 830f93f47068b1632cc127871fbf27e918efdf46
-- 
2.39.2


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E813BE1B6
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 06:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhGGEEV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 00:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhGGEEU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jul 2021 00:04:20 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346BDC061574
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 21:01:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id s17so1973723oij.0
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 21:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8NYTW1JqPBq2AwIJusIk57j35tPs8TSSJgORbncvYk=;
        b=lzBn4D+7VFEkDRPMTgzuEM7si3pFEEC8u1OiGp//79JRCrl3zt8rUcaVMkA99GVlCr
         EwPVM3bXi2MvjJg5lzl5ExC27hWFW+Q3VQ39rtibRy5oQWnIw6XxC5CseVlY29Gl/yIR
         liupCOn0hJkWeM1LeaK94SKBN5b25j37IZDgCD389lawdeiKkMuq7NBGlGrfBmTNTP1u
         ei3Zu5VzJBj8QkmqRsU/hlpOjOnlNFktz+q7F/MX05tG7yr1BElVMMDq/zNGpwdl2cXu
         Yrnw3iKJGqX1wsFKtrkGO2zG/TuuumH6fzCQIA7WbQFtM0hg6TOdLf5t9eaRwu4zqE7T
         Ug3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8NYTW1JqPBq2AwIJusIk57j35tPs8TSSJgORbncvYk=;
        b=fNP3J5CprkH1vYYWS9NssgE9K4RQ5bqSDST5h1+c2MQ2dHrZVQ9hOOOqrH42zyGnvc
         QPuYSVKyrxBJPQS4AqTVnlUkh8gV5xNS+PLoG0jvCGNxA4j4BGVGlU6aXSXPyyh2mPzG
         glb+nYJ95iEcKhtfMTL5E4f4Hl46ojO6xgwU47Xz1C3muA+axWIRSFniLfyqH89gAN1+
         moMHHAgDw8+SJfoB5amjkd7XlksMECnQaxCcGhfdccmDoar5QF2ijGx00QsWkGGKs8UJ
         v+n2D2QQ/EyEVuwBrZhut0wVvLdqN6aUlXKOBSxBrQ0iWq+YwShMKsEpBbq/Qot+TGSp
         cmDQ==
X-Gm-Message-State: AOAM530eQWMWu46uO30k/erZRYtTnXuHr9Z6jMUEenw0YNN7HYseij/O
        NfPVqXrKt9nP/GGj3sXHtw4=
X-Google-Smtp-Source: ABdhPJzLcNMFIkjzuP0anUcg/ARPiP0yhntv+srRZzYiB5TdGZ8zKLPJ9PCwy++/vFCYVGNB7NEj9Q==
X-Received: by 2002:aca:d941:: with SMTP id q62mr3362366oig.166.1625630500414;
        Tue, 06 Jul 2021 21:01:40 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3e85-59b9-418d-5cfe.res6.spectrum.com. [2603:8081:140c:1a00:3e85:59b9:418d:5cfe])
        by smtp.gmail.com with ESMTPSA id 10sm71335oip.42.2021.07.06.21.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 21:01:39 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 0/9] ICRC cleanup
Date:   Tue,  6 Jul 2021 23:00:32 -0500
Message-Id: <20210707040040.15434-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches is a cleanup of the ICRC code in the rxe driver.
The end result is to collect all the ICRC focused code into rxe_icrc.c
with three APIs that are used by the rest of the driver. One to initialize
the crypto engine used to compute crc32, and one each to generate and
check the ICRC in a packet.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2:
  Split up the 5 patches in the first version into 9 patches which are
  each focused on a single change.
  Fixed sparse warnings in the first version.

Bob Pearson (9):
  RDMA/rxe: Move ICRC checking to a subroutine
  RDMA/rxe: Move rxe_xmit_packet to a subroutine
  RDMA/rxe: Fixup rxe_send and rxe_loopback
  RDMA/rxe: Move ICRC generation to a subroutine
  RDMA/rxe: Move rxe_crc32 to a subroutine
  RDMA/rxe: Fixup rxe_icrc_hdr
  RDMA/rxe: Move crc32 init code to rxe_icrc.c
  RDMA/rxe: Add kernel-doc comments to rxe_icrc.c
  RDMA/rxe: Fix types in rxe_icrc.c

 drivers/infiniband/sw/rxe/rxe.h       |  22 -----
 drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c  | 124 +++++++++++++++++++++++++-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  61 +++----------
 drivers/infiniband/sw/rxe/rxe_mr.c    |  22 +----
 drivers/infiniband/sw/rxe/rxe_net.c   |  59 ++++++++++--
 drivers/infiniband/sw/rxe/rxe_recv.c  |  23 +----
 drivers/infiniband/sw/rxe/rxe_req.c   |  13 +--
 drivers/infiniband/sw/rxe/rxe_resp.c  |  33 ++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  11 +--
 10 files changed, 202 insertions(+), 170 deletions(-)

-- 
2.30.2


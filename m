Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B663DAF7A
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhG2Wui (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbhG2Wuh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:37 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53E4C061765
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:33 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id u10so10526902oiw.4
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whnYyPEqBb047ujtDkv4jKyVvpC3toc9LD0M6GOkZdg=;
        b=vUl+5IK10iyYBiXnRolIsY7wKIbTuEB1ETxNGCwh7J4X3NqMtLkL6EdLqCA9fNyrWv
         B2JsyQ5pTXm/5nUoo5SN92K3oEa8vRzNSYXZIMj0NQ7s8d17wqmM83i++zL+WV+mvZZ3
         wSceujabYVVWuJLhAyQCde1VITdlnE7z+oI6JxEXcgd/KIqm8DxksLptCdJK/mogWg05
         ldv055jvAcxhuPkFC0ns9lTvEmJ/lCgXaXzGW9hb4ScNTJb5j4cewmL4lHArrvWNAf5k
         LjhsM36rzrZQ4RXEEfcq1LlBdmVLvrcK6zr3mjzCBPJpJesapYry/0dzFOQ8WyVneY7D
         j8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whnYyPEqBb047ujtDkv4jKyVvpC3toc9LD0M6GOkZdg=;
        b=RIyeRNJRgPaeA1szwUu6Hg0sDJmvquggnnL4+O9sHoNgKxLmmqOY4NEKmNYigafOav
         s2zi0/S0YnIluubNVnlSBxTJ95aZnuyTqu+n5B4d6IsQo4nNKS0XkL2nPMgUJs4w0dj3
         nsIl6HPEbv84VEZ8aQfH/8bv1uhw47vghY1ySHfwrokWaWLqbRUzsmhgc8qRNrRTmwBc
         dRyt0FfZ3MqRnHd+1rleiCgck4NzYi6ryTIautJ2Yw1FlPHg0bLJFI3IotcmGxv5dkMZ
         Q5e21LeNqp0im2nuLlKdm/YYhAuuZB1EMgCkGLL0H9AaDIoG1RIuZtueTN+cv9ct1BBk
         PxIg==
X-Gm-Message-State: AOAM5300cxFp9dMRiOuiGUHqxKF96FPWvdwLxU5WfIgrXf4tWzThjVc2
        jd4Y84PeX8+svef2413L9nI=
X-Google-Smtp-Source: ABdhPJyfjo4WIz6GNXKAH1G56+MuVCAiydMTbr24lKEo32T8ZsYOsxOxNgAx5lkTlwmQeA6jHJmrDQ==
X-Received: by 2002:aca:b9c6:: with SMTP id j189mr4752185oif.114.1627599033251;
        Thu, 29 Jul 2021 15:50:33 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id l11sm789095otf.1.2021.07.29.15.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 00/13] RDMA:rxe: Implement XRC for rxe
Date:   Thu, 29 Jul 2021 17:49:03 -0500
Message-Id: <20210729224915.38986-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches implements the XRC transport for the rxe driver.

These patches should be applied after the (v2) "Three rxe bug fixes",
(v3) "Replace AV by AH in UD sends", and "Let RDMA-core manage certain objects"
patches to the current for-next branch.

Bob Pearson (13):
  RDMA/rxe: Decouple rxe_pkt_info from sk_buff
  IB/core: Add xrc opcodes to ib_pack.h
  RDMA/rxe: Extend rxe_send_wr to support xrceth
  RDMA/rxe: Extend rxe_opcode.h to support xrc
  RDMA/rxe: Add XRC ETH to rxe_hdr.h
  RDMA/rxe: Add XRC QP type to rxe_wr_opcode_info
  RDMA/rxe: Add XRC opcodes to rxe_opcode_info
  RDMA/rxe: Support alloc/dealloc xrcd
  RDMA/rxe: Extend SRQs to support extensions
  RDMA/rxe: Compute next opcode for XRC
  RDMA/rxe: Extend rxe_verbs and rxe_qp to support XRC
  RDMA/rxe: Extend rxe send XRC packets
  RDMA/rxe: Enable receiving XRC packets

 drivers/infiniband/sw/rxe/rxe.c        |  39 ++-
 drivers/infiniband/sw/rxe/rxe_av.c     |   6 +-
 drivers/infiniband/sw/rxe/rxe_comp.c   |  47 +--
 drivers/infiniband/sw/rxe/rxe_hdr.h    |  58 +++-
 drivers/infiniband/sw/rxe/rxe_loc.h    |  15 +-
 drivers/infiniband/sw/rxe/rxe_mw.c     |   6 +-
 drivers/infiniband/sw/rxe/rxe_net.c    |  36 ++-
 drivers/infiniband/sw/rxe/rxe_opcode.c | 388 +++++++++++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_opcode.h |  38 +--
 drivers/infiniband/sw/rxe/rxe_param.h  |   1 +
 drivers/infiniband/sw/rxe/rxe_pool.c   |   6 +
 drivers/infiniband/sw/rxe/rxe_pool.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_qp.c     | 235 ++++++++-------
 drivers/infiniband/sw/rxe/rxe_recv.c   |  51 +++-
 drivers/infiniband/sw/rxe/rxe_req.c    |  91 +++++-
 drivers/infiniband/sw/rxe/rxe_resp.c   | 209 +++++++++----
 drivers/infiniband/sw/rxe/rxe_srq.c    |  71 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c  |  37 ++-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  42 ++-
 include/rdma/ib_pack.h                 |  28 +-
 include/uapi/rdma/rdma_user_rxe.h      |   4 +
 21 files changed, 1098 insertions(+), 311 deletions(-)

-- 
2.30.2


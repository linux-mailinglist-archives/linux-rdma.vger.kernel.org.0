Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F076185D3
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Nov 2022 18:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKCRLb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Nov 2022 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiKCRKp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Nov 2022 13:10:45 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077B121B0
        for <linux-rdma@vger.kernel.org>; Thu,  3 Nov 2022 10:10:33 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13c2cfd1126so2870369fac.10
        for <linux-rdma@vger.kernel.org>; Thu, 03 Nov 2022 10:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVif7Liia03JkOfMaHgoAp/sDtaj5agF8q6U9Bbc+9g=;
        b=olSMUqi/pn/eefLw/C7rRMCrZZZpzeUoW/FcPS/sxbtLdCpbfahgc6BdtCasQaFaz4
         DcK4cqzj30rAp4A8dkjVdOsFU6fCLHfla8HV0EFxXAOhzsl1xLaUrVoADGFM2i0bjsjD
         NnwmXX2NdGb59riwCW05PN5UdSNZAGTe7BOTmm+5++FYoOsY8O6iogeEkypn8vRTLrnG
         Vw3L1VFxBp3rV3jY8FFzyoT7YSlPTUWjsnrPQ7ytWt0h9KAqj2UC168xOqZMu8upvn/2
         +Z3UOs69JFu/UOJC15bZcPuO4irKNzVSNDa85Yojh4kydNDYagMaETXniluLoyU9h8Bn
         YHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zVif7Liia03JkOfMaHgoAp/sDtaj5agF8q6U9Bbc+9g=;
        b=SKrb7lisv+Uyy6/AWNKdFlE1JyRe//QVnBFSmceCObkaw1HkZAWUDjZP0BljIIzKF4
         K3KNXNUcsN9A1GdbheEw81zFV5sdxMIAfswkWXtv6uKqV44wIBC91fMFlPSoQmrfbfrm
         4hHyA5AB6tOEUGZyctX24GVMQnzMHwfyPKK7WKQNVIN/WYI8iBKJifjTutY9lQkcI8uL
         PyWOAKPwkAUK5+W0P1oO+X/kdGPavPqXzB0yv1JH4hLHl1j6Gz/uDdd06i9mgoDMq8hJ
         RDKJlj8feOAgf5TmCBdrzbvew/z/Zk5C8tr2OLfMfFFSre0kPtm+QNRP7qlHgkInnaSs
         8DuQ==
X-Gm-Message-State: ACrzQf2F4m1DY49jcjCZTys6KnwVaqagupGXHwaE/6QlOIRinUAZ/VQL
        YkOYw+z3wzpQU1GvPPJiB8s=
X-Google-Smtp-Source: AMsMyM481mTSz8YQZBdAh9mnTl5QDILSHcwG6W5Swexx8toByM00gSX46li36T7V9bZlI9uPEvCidg==
X-Received: by 2002:a05:6870:2109:b0:135:430c:baa5 with SMTP id f9-20020a056870210900b00135430cbaa5mr27495328oae.179.1667495432334;
        Thu, 03 Nov 2022 10:10:32 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-b254-769c-82c0-77a4.res6.spectrum.com. [2603:8081:140c:1a00:b254:769c:82c0:77a4])
        by smtp.googlemail.com with ESMTPSA id m1-20020a056870a10100b0012b298699dbsm624304oae.1.2022.11.03.10.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:10:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     leon@kernel.org, jgg@nvidia.com, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 00/16] Use ibdev_dbg instead of pr_xxx
Date:   Thu,  3 Nov 2022 12:09:58 -0500
Message-Id: <20221103171013.20659-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch series replaces calls to pr_xxx with calls to ibdev_dbg
using macros for rxe objects adapted from similar macros from siw,
except in situations where the rdma device is not in scope.

This patch series is based on the current for-next branch.

v2:
  Fixed a typo in 01/16 in rxe_dbg_uc().
  Made fixes to 01/16 from a comment by Jason Gunthorp to enclose
  macro parameters in parentheses.
  Fixed an error in 06/16 caught by the kernel test robot <lkp@intel.com> 

Bob Pearson (16):
  RDMA/rxe: Add ibdev_dbg macros for rxe
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_comp.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_cq.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mr.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mw.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_net.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_qp.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_req.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_resp.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_srq.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_verbs.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_av.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_task.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_icrc.c
  RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mmap.c

 drivers/infiniband/sw/rxe/rxe.c       |  4 +-
 drivers/infiniband/sw/rxe/rxe.h       | 19 ++++++++
 drivers/infiniband/sw/rxe/rxe_av.c    | 43 ++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_comp.c  | 12 ++---
 drivers/infiniband/sw/rxe/rxe_cq.c    |  8 ++--
 drivers/infiniband/sw/rxe/rxe_icrc.c  |  4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  8 +---
 drivers/infiniband/sw/rxe/rxe_mmap.c  |  6 +--
 drivers/infiniband/sw/rxe/rxe_mr.c    | 40 +++++++---------
 drivers/infiniband/sw/rxe/rxe_mw.c    | 20 ++++----
 drivers/infiniband/sw/rxe/rxe_net.c   | 38 ++++++++-------
 drivers/infiniband/sw/rxe/rxe_qp.c    | 69 +++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_req.c   | 10 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 17 +++----
 drivers/infiniband/sw/rxe/rxe_srq.c   | 20 ++++----
 drivers/infiniband/sw/rxe/rxe_task.c  |  7 +--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 18 ++++---
 17 files changed, 190 insertions(+), 153 deletions(-)


base-commit: 692373d186205dfb1b56f35f22702412d94d9420
-- 
2.34.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C465622A2
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbiF3TFL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiF3TFI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:05:08 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA60837A30
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:07 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-101ab23ff3fso535867fac.1
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWo0UqqJJiJfM9DI2SD2ix6CrU8nsJr9DMJlJnd5cwE=;
        b=OCYaVrR6xZ98xaz+Ow8idR8fFbW+4XAjckpbI5iZ/oKg3MLQIiQNPYW5hVVi4GEKyV
         yrByI1HkCvkjFXNCZFFvUTU5TOSeLlnVWx2s0Qnjrz3IALwnXgBaYd74kuVyfDhF/kQe
         2DAc3+yj+fNhcknpNaCJ6QNnWByiEY5JRlHJxNgcMPlOFX2IeMttRuyeNPo91vxWB6Z4
         K50jz1au/Oxnx1urMatKRIZYphFAiUltSZXRk1JAodIHjYGhRds/zx1Pms7vXTCqfMsG
         3W/zglfsSnMgTc0aP+VEXrJyUmjGUdSTvJtA9s2H7hcbHTRBtv3JZWiXsep0fFGiN/Ox
         mRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWo0UqqJJiJfM9DI2SD2ix6CrU8nsJr9DMJlJnd5cwE=;
        b=R6unT8EmmR5hYrWS69ysC6eILbbo0ui/6VX531NNbnuyZONFT8JZGcb78k8BeszqSW
         dWXnGUZS6szvjNfzTXLSSmk0Xs8WSWdp1Aw/01tV2nh0qGxqhfIXJ41OQa19846w47+o
         24/G+KlipclDBmC6BMxXY0vCuyGRNHH5M9NJzIZhka3VqLrMMY21DdAmM0gJcVBWGELm
         LTzRUdTJriDIBHXkBeNeFpAJeOhK1muYV3lSXKQ6KDrn6R/bDL/W4eu7lA8q8TkO5pL8
         +X2q7cnDmC4lbhSFf4rDTf+N2KM667MPveYJTPlUZa3FTschoZbo6r5OjOLwacKFK72t
         w76Q==
X-Gm-Message-State: AJIora+vmcyyrcgt6Zc2eHd0E1j9OwC6WqRlM3zH2NUK2JlNYESJ+F5E
        wbQVXy9xdVFoJP5An1otsl4=
X-Google-Smtp-Source: AGRyM1sqdmNb2qoolTEaytSumnYHUpq32edyz0tQkYz/cJAo4AEaFBx4RexxH/KKhtWiV67bn4Y2DA==
X-Received: by 2002:a05:6870:4308:b0:10b:8cbe:c945 with SMTP id w8-20020a056870430800b0010b8cbec945mr5344019oah.220.1656615906820;
        Thu, 30 Jun 2022 12:05:06 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm11756442ote.9.2022.06.30.12.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:05:06 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 0/9] RDMA/rxe: Various fixes
Date:   Thu, 30 Jun 2022 14:04:17 -0500
Message-Id: <20220630190425.2251-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch series is a collection of fixes to the rdma_rxe driver.
Some are new and some are replacements of eariler patches that are
rebased and improved.

These patches apply cleanly to current wip/jgg-for-next.

Bob Pearson (9):
  RDMA/rxe: Add rxe_is_fenced() subroutine
  RDMA/rxe: Convert pr_warn/err to pr_debug in pyverbs
  RDMA/rxe: Remove unnecessary include statement
  RDMA/rxe: Replace include statement
  RDMA/rxe: Fix rnr retry behavior
  RDMA/rxe: Fix deadlock in rxe_do_local_ops()
  RDMA/rxe: Make the tasklet exits the same
  RDMA/rxe: Limit the number of calls to each tasklet
  RDMA/rxe: Replace __rxe_do_task by rxe_run_task

 drivers/infiniband/sw/rxe/rxe_comp.c  |  43 ++++++----
 drivers/infiniband/sw/rxe/rxe_cq.c    |   8 +-
 drivers/infiniband/sw/rxe/rxe_param.h |   6 ++
 drivers/infiniband/sw/rxe/rxe_qp.c    |   1 +
 drivers/infiniband/sw/rxe/rxe_queue.h |   5 +-
 drivers/infiniband/sw/rxe/rxe_req.c   | 116 ++++++++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_resp.c  |  25 ++++--
 drivers/infiniband/sw/rxe/rxe_task.c  |  16 +++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |   2 +-
 9 files changed, 148 insertions(+), 74 deletions(-)


base-commit: e5d12406b94a4d0bb63cb4d78e568c6d9fadacfd
-- 
2.34.1


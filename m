Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3E6D7358
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Apr 2023 06:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbjDEEZv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Apr 2023 00:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDEEZv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Apr 2023 00:25:51 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D610CF
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 21:25:48 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-17ab3a48158so37105445fac.1
        for <linux-rdma@vger.kernel.org>; Tue, 04 Apr 2023 21:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680668747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lbLg9fBOd2KKkroXv53AgnCRe/FITu2rDVoE/voif18=;
        b=CRAvYQ/n1DRpWA0Qbn3MK7w1VoSPGyc8wrnmHKXWoSKVmgfcapnfsx9B0rQoVvYpjt
         hwLerIp/h986SnpgUxnczjyVoHdI/8VybTAoHMflQDKdkM1e7FWoIo4t/phZdniMk3eY
         9yHHwuEEbf2vPfptgafqrsGflD0vy5SQ2E+iLHk4vNXGDfXdLGtcPN+TAGdEtTpIb+Ld
         4aUlyizhCjAH/cFVFg+HqOKyHbSx+5cJ+fHsU6ts/Phm5O51FTDaTVrpbsxMKvAjwRHU
         4U25Wm37psNIFP+9xY8QrhseD3wlhQixspiykSU8pWUD6UeNNg2/lmVt6iSpSLrIKACH
         mxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680668747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbLg9fBOd2KKkroXv53AgnCRe/FITu2rDVoE/voif18=;
        b=AM6YWhfigesePdyiyynrTC8vPiKjBeqOodcg81E2cAtCB5gdAfawWsWB/meMtfBIO3
         URQ+PRnGLWTgYXFAmaSIyQkPJAtxjrilVpISCr7GhYPeSxN5WZRh1jF5IofTHCpVZeW9
         NsLV2LnqtvwmxbM7WEwVTjRoR+Aa6u32zy9lu1nilVqZtMNBUF/UBvsWjE5rZb+YmzWU
         GBt7+X3GXldJaY8cMJgjeZ0zDTtcBLMibXPAEehu4tXd0IsdOKZ4fejUv8LdqTNoX7Vr
         djDYuTGJTM9KFaogIl8lu4np6qWIEbQMLdekwUpQ82K5NJMiEYtAwqEQufCQYUdEILue
         XoaA==
X-Gm-Message-State: AAQBX9dZFBHyxQphNo8Hu6o5UkXIdvE6HDjpwtDmAP6eyourLjYIrChm
        TKTg5r9G+hbY+lOkPxW7oHk=
X-Google-Smtp-Source: AKy350a4XzGMmuPqdl3Nf7ZNt54T9GSDln6qH1ovLGaLnII27xki3lf5KYAXbKngpaQciqqfENr/ew==
X-Received: by 2002:a05:6870:701e:b0:17a:d7dd:aefa with SMTP id u30-20020a056870701e00b0017ad7ddaefamr3904187oae.6.1680668747322;
        Tue, 04 Apr 2023 21:25:47 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id yy36-20020a05687125a400b001728669a604sm5510375oab.5.2023.04.04.21.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 21:25:30 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/5] RDMA/rxe: Protect QP state with qp->state_lock
Date:   Tue,  4 Apr 2023 23:24:21 -0500
Message-Id: <20230405042425.6429-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series makes qp state chages atomic between the various
applicationa and IO threads. The rxe driver currently is very unsafe
as qp state changes made by application threads e.g. ib_modify_qp()
which changes the qp state are not protected against stale reads by
IO threads. This patch series cleans up qp state by reducing the
redundant state variables (qp->req.state, etc.) and then locking
code fragments that access or change the remaining qp state variables.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>

Bob Pearson (5):
  RDMA/rxe: Remove qp->resp.state
  RDMA/rxe: Remove qp->comp.state
  RDMA/rxe: Remove qp->req.state
  RDMA/rxe: Move code to check if drained to subroutine
  RDMA/rxe: Protect QP state with qp->state_lock

 drivers/infiniband/sw/rxe/rxe_comp.c  |  94 +++++-----
 drivers/infiniband/sw/rxe/rxe_net.c   |   7 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 188 +++++++++-----------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  15 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  94 ++++++----
 drivers/infiniband/sw/rxe/rxe_resp.c  |  18 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 242 +++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  12 --
 8 files changed, 367 insertions(+), 303 deletions(-)


base-commit: b6ba68555d75fd99f7daa9c5a5e476f8635cb155
prerequisite-patch-id: a6993e699da3603cc1d98d704434d467ab3f68f5
-- 
2.37.2


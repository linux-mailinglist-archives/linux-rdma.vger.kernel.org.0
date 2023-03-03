Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6F96AA444
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Mar 2023 23:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjCCWZj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Mar 2023 17:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbjCCWZY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 3 Mar 2023 17:25:24 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458825585
        for <linux-rdma@vger.kernel.org>; Fri,  3 Mar 2023 14:17:55 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-17683b570b8so1950834fac.13
        for <linux-rdma@vger.kernel.org>; Fri, 03 Mar 2023 14:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677881804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sL2d/A0r2oWMvLfJaEJiJjBKBMznxRekRWpsciiwxS0=;
        b=jh2yCMCSOQuZ+K37bCz6VSSGZg+b1Q0kkqZMMMypTZPSCpEhUo0uw739oviP/uazjl
         NtbI0Kh1qdTybilyQS/DgWNGfTO8/TGki5vnj3tjwOxyoNyDrl6e7rBE/QPSDUoyjQD2
         skkaromGiAeDJdCJRI/dK8yR8iJCQRjr2k3zkzFbpQB7NwY4dD+w2qLpO4G7I/HhInbC
         iFk4FkhbMNu4oS1kyKXeSg4nDNmbX+yhJJTNufVvuobOdAgJLvBMzvdQkd3rU9VmzJou
         c7crUcMTbkUZrmbkI9o2kCgn5sO0HBtFJQrIl+X65v6TqOPaGZFkWNpylI4IrnhGRAMQ
         5daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677881804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sL2d/A0r2oWMvLfJaEJiJjBKBMznxRekRWpsciiwxS0=;
        b=0uzeb8z6rQyyNIX+ViHkXbLzX7tB4M4XbrIRXNZv6ZfvSgPXETyFSpVmzRxHVuynhK
         WH2pVF+RbgwqXTQlX9kCGqXLNkYQ7vxc6VwNxDDDZGvQLF+y/B+fFoAZuuGiYBT8oKos
         bH+kQZQVprLH0TZyK3kkrSbDpfZpYUcr28lS7W3DedIqH7A9upNuKs2wCX1jQgFWuyXM
         vQ9l95mF+bCIGpNEUXeYIjktNAZXn1z6nzcw8dSeVQGqwodrblHVcF9r3IWa5rADsU/y
         kHCWTUCwVPXBBAr68OQdQKfIfyaJwFa9r72VjBo61xpr+Cqa/KrvN6gs2tue4jKi5FSr
         TnQg==
X-Gm-Message-State: AO0yUKU/F9BEqNif7/IbZp3aQX55TmM5EyCx+1jh0s2i+WCO5wkhtfNM
        E9ddh9oJtt4CWi7XklF1r0o=
X-Google-Smtp-Source: AK7set/SRGeX0CL4d7BRygE701whEFG74bTQYc1TM6DpZSS+kwknidOdO4+Zp09U197grKq4O/9cmw==
X-Received: by 2002:a05:6870:e2d1:b0:172:289a:b0b2 with SMTP id w17-20020a056870e2d100b00172289ab0b2mr2302701oad.30.1677881804370;
        Fri, 03 Mar 2023 14:16:44 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-de65-7c8e-0940-8c68.res6.spectrum.com. [2603:8081:140c:1a00:de65:7c8e:940:8c68])
        by smtp.gmail.com with ESMTPSA id zd34-20020a05687127a200b001730afaeb63sm1480740oab.19.2023.03.03.14.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 14:16:43 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next v4 0/4] Add error logging to rxe
Date:   Fri,  3 Mar 2023 16:16:20 -0600
Message-Id: <20230303221623.8053-1-rpearsonhpe@gmail.com>
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

Primarily to make debugging more efficient, log message types
are added and error logging messages are added to the verbs API
to rxe driver with the goal that each error reported up to
rdma-core will generate at least one message with additional
details and internal errors restricted to debug messages which can
be dynamically turned on.

v4:
  Removed a mistaken WARN_ON at line 750 in rxe_verbs.c. This was
  hidden by a later fix that covered the error.

v3:
  Corrected a debug message referring to err before err was set in
  patch 4/4.
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302250056.mgmG5a52-lkp@intel.com/

v2:
  This set of four patches was split off an earlier series called
  "RDMA/rxe: Correct qp reference counting" since it is not really
  related.

Bob Pearson (4):
  RDMA/rxe: Replace exists by rxe in rxe.c
  RDMA/rxe: Change rxe_dbg to rxe_dbg_dev
  RDMA/rxe: Extend dbg log messages to err and info
  RDMA/rxe: Add error messages

 drivers/infiniband/sw/rxe/rxe.c       |  16 +-
 drivers/infiniband/sw/rxe/rxe.h       |  45 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +
 drivers/infiniband/sw/rxe/rxe_cq.c    |   6 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   1 -
 drivers/infiniband/sw/rxe/rxe_mmap.c  |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  13 -
 drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  16 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |   4 +
 drivers/infiniband/sw/rxe/rxe_srq.c   |   6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 830 +++++++++++++++++++-------
 13 files changed, 684 insertions(+), 271 deletions(-)


base-commit: 66fb1d5df6ace316a4a6e2c31e13fc123ea2b644
-- 
2.37.2


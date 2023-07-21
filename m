Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90AA75D5F5
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 22:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGUUvH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 16:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGUUvH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 16:51:07 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7146430E2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:06 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a1e6022b93so1629741b6e.1
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 13:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689972665; x=1690577465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKaou6YzjklLO1zTRm62W3G4v6hXp49kpmpWftVjWgY=;
        b=p/iAgRSmgTJEO8tFT9S6dk5hCDw9dwiM7yU6DNUikYZImPFAnGxjZ7U1tJw9hXKgcZ
         MIQHgpiIb2secFn4tvNy/qMALfYVTNt5J+7W5slQvMBpVC2A/hcsfj3ttXUAMQFElswR
         jDoxzFTolPQmhGEH4r5OuNMYOjAGUZKi4MLqJIOtLx1xOsnYD0zEqidAJnwBDTS2zA9u
         PSjKck/92VeV2jLmWWGmCnZH84NFG7u1q9D809krs0TeImk9uCNSaY00Lj6faXEE0TMA
         M0cAJ4Mhx6lheifalMhx5jkvslQGK2tTDOPSAWPJYJi8u61D9jzDglbKV+Xz2ayrF+6+
         p59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689972665; x=1690577465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKaou6YzjklLO1zTRm62W3G4v6hXp49kpmpWftVjWgY=;
        b=ToButnvac+tA7Npo077STIuzSaN/nArR0zToWzx8lGn5CcTASV8XUSVpBHWPHZneco
         Qva7AaKbjZ1etxkYCTpybmHR4nFybNrt/kDB9Lc0mN/0XmjT1lYzSgNUAEMkZpBdxSZc
         1xX5FRMcaZqymxNUWTYOr0WieuFqEkIPqQERg7djL8Ci4WqTkOx/HXZ8UICjQnH8lsYp
         06qXWaNJxQ1aiaIPA6dHvT+rzlEHSjltyO7fU2NNI5FCMnGz2LSNbojATNWAUI9BMac3
         grMtzxc0wcTV1KVNeEYtz0QG1GFT5HSAwJHOfHXxcBoUIJb1OERo6rwqA2uoPWQ+sSDH
         bP9Q==
X-Gm-Message-State: ABy/qLZ5wX+SpGDoDDUibzGWgA5DkKN+nUwbZOrKgYld++wdOgTJu7ZH
        ijBLZfQ+osuhrJCmCzzgrCSCW7/XSVQ=
X-Google-Smtp-Source: APBJJlFt1zta3Q5ZX+ri4EoGbDTNUsnAwIU8+ExHD1kC3ynhgg/Gh3awKjj9YgH6kkK2ASxBWuIOeA==
X-Received: by 2002:a05:6808:144d:b0:3a3:6d2a:5c4a with SMTP id x13-20020a056808144d00b003a36d2a5c4amr4283961oiv.35.1689972665714;
        Fri, 21 Jul 2023 13:51:05 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3742-d596-b265-a511.res6.spectrum.com. [2603:8081:140c:1a00:3742:d596:b265:a511])
        by smtp.gmail.com with ESMTPSA id o188-20020acaf0c5000000b003a375c11aa5sm1909551oih.30.2023.07.21.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 13:51:05 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/9] RDMA/rxe: Misc fixes and cleanups
Date:   Fri, 21 Jul 2023 15:50:13 -0500
Message-Id: <20230721205021.5394-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch set includes several miscellaneous fixes and cleanups
developed while getting the rxe driver to pass a 24 hour simulated
cable pull fail-over fail-back stress test using Lustre on a 256 node
system. These patches apply over for-next with three recently submitted
patches as prerequisites:

	RDMA/rxe: Fix incomplete state save in rxe_requester
	RDMA/core: Support drivers use of rcu locking
	RDMA/rxe: Enable rcu locking of indexed objects

Bob Pearson (9):
  RDMA/rxe: Fix handling sleepable in rxe_pool.c
  RDMA/rxe: Fix xarray locking in rxe_pool.c
  RDMA/rxe: Fix freeing busy objects
  RDMA/rxe: Fix delayed send packet handling
  RDMA/rxe: Optimize rxe_init_packet in rxe_net.c
  RDMA/rxe: Delete unused field elem->list
  RDMA/rxe: Add elem->valid field
  RDMA/rxe: Report leaked objects
  RDMA/rxe: Protect pending send packets

 drivers/infiniband/sw/rxe/rxe.c       |  26 ++++++
 drivers/infiniband/sw/rxe/rxe.h       |   3 +
 drivers/infiniband/sw/rxe/rxe_net.c   | 119 +++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_pool.c  |  85 ++++++++++--------
 drivers/infiniband/sw/rxe/rxe_pool.h  |   9 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |   1 -
 drivers/infiniband/sw/rxe/rxe_verbs.c |  86 ++++++-------------
 7 files changed, 185 insertions(+), 144 deletions(-)


base-commit: b3d2b014b259ba758d72d7026685091bde1cf2d6
prerequisite-patch-id: c3994e7a93e37e0ce4f50e0c768f3c1a0059a02f
prerequisite-patch-id: 48e13f6ccb560fdeacbd20aaf6696782c23d1190
prerequisite-patch-id: da75fb8eaa863df840e7b392b5048fcc72b0bef3
-- 
2.39.2


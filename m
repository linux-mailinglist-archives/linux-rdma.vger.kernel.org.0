Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907936A6652
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Mar 2023 04:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjCADKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Feb 2023 22:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCADKu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Feb 2023 22:10:50 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600482E807
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 19:10:49 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id o4-20020a9d6d04000000b00694127788f4so2936221otp.6
        for <linux-rdma@vger.kernel.org>; Tue, 28 Feb 2023 19:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2m04tGdbkYnf0yeeUfD6L79N5NJTAfwmqc3JhLZLeA=;
        b=PVd3mvPdvCYxhWllIsopTsuMX86fovDWbRktGp0Z8BxXq9JxXijw6G/EvkBB5ymQXu
         IA+OtiUw8iLXfAoO1GPQFrkzxnHTfjyh7+hAxURBMJURyRBOGDN8oqr7aHfkyEFcIZOv
         mjaWvb9aVRJyEKwXYs9xzqexJVWUCtajWG57r1XvtRhYw9YcrG4KfbqV9BTLwSrOIK4y
         aBsRezdItsPIqF+Eef+HB/TMsK9AcRFE6ZBOqFxYboNB4MIpWyj2LsW+FFHWb2pC0Jlr
         KO3CW9qKF76xRpZ+APd1CPpxjuPL3mJWVGsVTMdTUAW0E+Tx2whp0zFwscrBJh0hfzbg
         Ha1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2m04tGdbkYnf0yeeUfD6L79N5NJTAfwmqc3JhLZLeA=;
        b=OrisXhR2jpzndI9HmP+MQZsgcTtVjwGptTp1VRA2mRjAYsLKiCLuwwOL060Z+qnIpR
         8xZvZ/0TaVd2nK9rOyvZ5TLzF5oSlGqBToOg7XfS/YDoA7OnIlrqcMRzfPMb7XLymEzn
         96ANmXyIzwhGHH2gpVYtMKW/j94p6bG5pTgV4EK1N9+Nvj+77UEo/y4+O02Rj/985ngZ
         xfZKhp/XhfPq68a+cd+f4f+9xspi33Y9yErrN4fYjac4fNcuMpBNWUtYFjc8rkafks76
         jf5EIPfnMsOrYNHSJzO4Yy3WYNCDxh4bsdDT0Ilapvb1QJOT+DR2ZhIIUWZghYYjjZMN
         hp0A==
X-Gm-Message-State: AO0yUKV4NMWozF7GXy0QgcuIygVlA2qr1yqidIOKLoNmNPXGvkxzJz9g
        Gq3e6hnlgg9O0gX015YVCY0=
X-Google-Smtp-Source: AK7set8PX9nUYQcu5nWMMoXL72IN+wbZ2wbgESBU0OFpIvOyMuvlZyYWyLWJj+EQe1JjCHtjyKqwwg==
X-Received: by 2002:a05:6830:440b:b0:68d:5bc9:7ac2 with SMTP id q11-20020a056830440b00b0068d5bc97ac2mr3090817otv.10.1677640248668;
        Tue, 28 Feb 2023 19:10:48 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-759b-a469-60fc-ba97.res6.spectrum.com. [2603:8081:140c:1a00:759b:a469:60fc:ba97])
        by smtp.gmail.com with ESMTPSA id e7-20020a05683013c700b00684152e9ff2sm4484942otq.0.2023.02.28.19.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 19:10:48 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH for-next v3 0/4] Add error logging to rxe
Date:   Tue, 28 Feb 2023 21:10:35 -0600
Message-Id: <20230301031038.10851-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_verbs.c | 831 +++++++++++++++++++-------
 13 files changed, 685 insertions(+), 271 deletions(-)


base-commit: 66fb1d5df6ace316a4a6e2c31e13fc123ea2b644
-- 
2.37.2


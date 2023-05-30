Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABECA71707C
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 00:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjE3WNw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 May 2023 18:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjE3WNv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 May 2023 18:13:51 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481F593
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:50 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-38ede2e0e69so3070280b6e.2
        for <linux-rdma@vger.kernel.org>; Tue, 30 May 2023 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685484829; x=1688076829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1HyGQVIAV0Vfi6Klq+FbdRDD4klsSu/Bfc/y/LFf/s=;
        b=rFTeBp1V4eRGIs9gJ/NbRxqYXrSY9HfH6O20nLo4kc5PNs/yaiC51TwcFGvcpJjY0f
         u3OhDLruwrls1h5ZK+IRAH4sfcD0tRglBSYRpUt9CeYe8BlF5pUdKIinK3tCp7ipDswB
         w2xLfklxYSI/r49gCUuBvcMTDcO3wt0ZqLINjjtdykvWPnEwzQjlwFDPi1NQX7nCHc7a
         3f+N2bgxNgc+LzQltU83WBu2sdW5W1TPh5XytZ9PRqBCBTqmFBqLKQWxHpzAsHfm04a8
         beziQgG/w3ewnt5AMySjXo8Xju29oBsBTT2oLGJouwHQfU1bbOB8nHL/DOmw/lLx6UxY
         8Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685484829; x=1688076829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1HyGQVIAV0Vfi6Klq+FbdRDD4klsSu/Bfc/y/LFf/s=;
        b=c5pndBIHUntFDh0s2Dt9vTU7+lEcRI64AbqBW6GeIKKr+GP4ZJHSOaFGpA99qHCli2
         9ygd6gZwyJ7E0Yogo/Af1K2yxMYPHLQSvqu+/JaoOWykloQdVJ8pCMUFC1OkatLZnf82
         EIObGXcZUldbsaaFueRrQmlmEm6+DmzhCB0CEUWZTguj+S8Ymxo3sXkQqUkaswlSFmTc
         IDttEOrcEK3msfzM/ro8mLl707TXLRnF0OovbY2UrP8/91qPu48Hn5rQYY35Z1mvwjRy
         +hYIAyf/ohHML2rOnbv5xo9ETst8YNpVVhtgwDg0mY35O7zZoL1lxrIuppN7TuW4JW6D
         kIkA==
X-Gm-Message-State: AC+VfDxq54OoLxqp0LVxLsoFAVp9G8GU9evavg5ave140ev8J2WF7AhU
        QS0RGxWj0GMgHOV37xcz2PJo04Y//pc=
X-Google-Smtp-Source: ACHHUZ6HTfv/EI15WSqg6YeRnMIM4UbeN3yra5ROiItVD4yVpZxJTjZdUMRqxK4ooX3M2ZpMgLSTlg==
X-Received: by 2002:a05:6808:14e:b0:396:22a9:5ed5 with SMTP id h14-20020a056808014e00b0039622a95ed5mr1962982oie.47.1685484829536;
        Tue, 30 May 2023 15:13:49 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-61e7-5a75-8a81-5bfc.res6.spectrum.com. [2603:8081:140c:1a00:61e7:5a75:8a81:5bfc])
        by smtp.gmail.com with ESMTPSA id r77-20020a4a3750000000b00541854ce607sm6156772oor.28.2023.05.30.15.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 15:13:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, edwards@nvidia.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/6] Misc cleanups and implement rereg_user_mr
Date:   Tue, 30 May 2023 17:13:29 -0500
Message-Id: <20230530221334.89432-1-rpearsonhpe@gmail.com>
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

This patch set does some preparatory cleanups and then implements the
two simple cases of ib_rereg_user_mr.

Bob Pearson (6):
  RDMA/rxe: Rename IB_ACCESS_REMOTE
  rdma/rxe: Optimize send path in rxe_resp.c
  RDMA/RXE: Fix access checks in rxe_check_bind_mw
  RDMA/RXE: Introduce rxe access supported flags
  RDMA/RXE: Let rkey == lkey for local access
  RDMA/RXE: Implement rereg_user_mr

 drivers/infiniband/sw/rxe/rxe_mr.c     | 21 ++++++-------
 drivers/infiniband/sw/rxe/rxe_mw.c     | 22 +++++++++-----
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
 drivers/infiniband/sw/rxe/rxe_qp.c     |  7 +++++
 drivers/infiniband/sw/rxe/rxe_resp.c   | 12 ++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c  | 41 ++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_verbs.h  | 20 +++++++++++++
 7 files changed, 104 insertions(+), 22 deletions(-)


base-commit: 8c1ee346da583718fb0a7791a1f84bdafb103caf
-- 
2.39.2


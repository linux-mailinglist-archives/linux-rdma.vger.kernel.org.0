Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C0766D379
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 00:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbjAPX7I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 18:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjAPX6p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 18:58:45 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427D9234D7
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:56:49 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id r9so453509oig.12
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YEgc0od9rpCy+3rFEMQNfaQbuOouCCwEQ+3E3BF+g6I=;
        b=REF0aPXZp+tzy+1KFCRUY9+XDDkJxdjUX4avmgmoG/TjssiAwpuZsAmxLvrTwabce+
         szkO2KmwTd4/iaP+MICm4JGlIy7W/4cDjXmIBdkYYAAtaNTgahjA7sB+sO5S0cYRcJwX
         x1fmRvdfL1z7JVS8Q4rv+zbhEgynY8CWKtz11RjpOtwi514WUtHjCz/PZ2ZgxitBSDDC
         es6ZraAc12jaA7EuMeMJyC7+3C1ey+Qdjv3tm9HYrv0pr7CYjesNFd92t8rEed3yRnLS
         a5QVJoF31svBQkSyw/5GUcrE+eKP7JIkX1L5/9fsa2UPyefdxvSv0TP7ykk2cemR/DSo
         qV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEgc0od9rpCy+3rFEMQNfaQbuOouCCwEQ+3E3BF+g6I=;
        b=lIDbf1gOfRyEkZipATFQFJEr8P98O1mQM6U7Zp1vRfOKNSH4FOSq3cH2LJokmA1TKZ
         8VRrJyO4QufVLUSBiLYKtPmyxQ/gMqjimweCtdXmsPApkkkPQI1F13t9KyRiNNq5wOdE
         th+RtzW07WREzLNpTTPZoQaTrCXWk6ttdHTbX3ZGGwghUOtAmpYuF/ckdxg7C/Axx5Yn
         /QuWbgRArpJtptbXGD/dqyASob9jb896+nNziKpnAvnrd3DpOlkPmsBPdRiyOlCzoO7c
         koI81xaWhvQk/6cFmszoRwYGKQM/9syvk507mTWvN2bAsFccOZ/Xk9wVy2ukWEgCgEVQ
         2zTA==
X-Gm-Message-State: AFqh2koLoDcQueTkoHOov8FTjrgQF7958PgzHB+kfjzZXigBf9Rigmk0
        gWFOlMxFG/YB2bzJ13lrJWw=
X-Google-Smtp-Source: AMrXdXsdHCHM1SI2QTxIMZ/QESd2UF4GOzyamOFbprrKGYZjUBSFuljOuxDcT9GlQahjtvJpeQd6rA==
X-Received: by 2002:a05:6808:1144:b0:35e:6a80:5e17 with SMTP id u4-20020a056808114400b0035e6a805e17mr695213oiu.56.1673913408581;
        Mon, 16 Jan 2023 15:56:48 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d77d1000000b00684e55f4541sm3540546otl.70.2023.01.16.15.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 15:56:48 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 0/6] RDMA/rxe: Replace mr page map with an xarray
Date:   Mon, 16 Jan 2023 17:55:57 -0600
Message-Id: <20230116235602.22899-1-rpearsonhpe@gmail.com>
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

This patch series replaces the page map carried in each memory region
with a struct xarray. It is based on a sketch developed by Jason
Gunthorpe. The first five patches are preparation that tries to
cleanly isolate all the mr specific code into rxe_mr.c. The sixth
patch is the actual change.

v5:
  Responded to a note from lizhijian@fujitsu.com and restored calls to
  is_pmem_page() which were accidentally dropped in earlier versions.
v4:
  Responded to a comment by Zhu and cleaned up error passing between
  rxe_mr.c and rxe_resp.c.
  Other various cleanups including more careful use of unsigned ints.
  Rebased to current for-next.
v3:
  Fixed an error reported by kernel test robot
v2:
  Rebased to 6.2.0-rc1+
  Minor cleanups
  Fixed error reported by Jason in 4/6 missing if after else.

Bob Pearson (6):
  RDMA/rxe: Cleanup mr_check_range
  RDMA/rxe: Move rxe_map_mr_sg to rxe_mr.c
  RDMA-rxe: Isolate mr code from atomic_reply()
  RDMA-rxe: Isolate mr code from atomic_write_reply()
  RDMA/rxe: Cleanup page variables in rxe_mr.c
  RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray

 drivers/infiniband/sw/rxe/rxe_loc.h   |  13 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 625 +++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 118 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  36 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  37 +-
 5 files changed, 425 insertions(+), 404 deletions(-)


base-commit: 1ec82317a1daac78c04b0c15af89018ccf9fa2b7
-- 
2.37.2


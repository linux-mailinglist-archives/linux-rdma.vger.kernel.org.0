Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165816477A2
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 22:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLHVGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 16:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLHVGR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 16:06:17 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6977E54362
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 13:06:16 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1443a16b71cso3268896fac.13
        for <linux-rdma@vger.kernel.org>; Thu, 08 Dec 2022 13:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7fP6Flg5tH384o5SL7VqaFTe6O2ILJ2skagZLiwYTc8=;
        b=Z9woCSedRyN6a7esocyxeeG3XuUfhHtMXxsDTsDmsxjIy7i/dbc+FWcK82pZfySi7w
         u85EbAxYp00ApJeyE/cdhBR/bI7VQfsqIGFfUcw/kOFyTZtGVCwWgjrLy8ZRx2W/22qu
         Qg6JeK9f5hfrcSFR+2TpGZAYvWQFwo4Wpbs9oOFBK484SqrsjgqnY5BEqBRBYdEbBaTg
         out/aw4GeeEBcLt+JSotcql2+4eYH4AX+s9Hm7MqzAJDVKt532r7EKGzwKLH5a8680eh
         HAC5BSYeMldgeYcg6mnTCJwd+w70qScF3fTJvGsVBQGJ5kGyZo4Zp9VMIARXHNwUO49Z
         SoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fP6Flg5tH384o5SL7VqaFTe6O2ILJ2skagZLiwYTc8=;
        b=rHr4A/WnRkO7m6CIygJ23pOHQHYGMEsEr9GamuwlTSfnhhQl8wQQlAB5S9wPw1Ww5o
         NwnbmnTALx/xk82Bd765GX83u/q1nXHrRhTFXkw1vO3hni+F5aH65i5qQ9Yc/4CWm/zi
         jtxUhlBCNPr6OS0Dg3+2dYKK5TKxwTRw4JJBQxnt7gVWLcyGHUY3lNUXWvjHqVHuJbne
         jhNxbJt7KBYABGHW1p1lxCXd5GODn6PxZ3DzO1zowy5RdM+ZBF06q1HuPGPlBxsJ7E8P
         eS+jT2LdLxCxZ7NxaQPcIw5J9PaXs5fCbxD3q4vOI2xro6AOWn+51kgpP1/4DhAfvvep
         jBPg==
X-Gm-Message-State: ANoB5pkCYveur2xBN0vRSwlnHINQpH3l/fuwh769wC8G8E27MEy6KkQx
        x2B/0Y5ugAmFapUcGhHed/Y=
X-Google-Smtp-Source: AA0mqf5T2y4n1zsvsmPfRcfrbuhb7Z7sDXPKGwGv8XdGMDKJX+tg8OHQBktMxPhuycS0DQDuCTkinA==
X-Received: by 2002:a05:6871:459a:b0:144:c908:69fc with SMTP id nl26-20020a056871459a00b00144c90869fcmr1820604oab.36.1670533575693;
        Thu, 08 Dec 2022 13:06:15 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a13f-9234-e395-548a.res6.spectrum.com. [2603:8081:140c:1a00:a13f:9234:e395:548a])
        by smtp.googlemail.com with ESMTPSA id t11-20020a056870e74b00b0012763819bcasm5739250oak.50.2022.12.08.13.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:06:15 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/6] RDMA/rxe: Replace mr page map with an xarray
Date:   Thu,  8 Dec 2022 15:05:42 -0600
Message-Id: <20221208210547.28562-1-rpearsonhpe@gmail.com>
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

Bob Pearson (6):
  RDMA/rxe: Cleanup mr_check_range
  RDMA/rxe: Move rxe_map_mr_sg to rxe_mr.c
  RDMA-rxe: Isolate mr code from atomic_reply()
  RDMA-rxe: Isolate mr code from atomic_write_reply()
  RDMA/rxe: Cleanup page variables in rxe_mr.c
  RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray

 drivers/infiniband/sw/rxe/rxe_loc.h   |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 518 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_resp.c  |  73 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  36 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  32 +-
 5 files changed, 327 insertions(+), 338 deletions(-)


base-commit: 6978837ce42f8bea85041fc08c854f4e28852b3e
-- 
2.37.2


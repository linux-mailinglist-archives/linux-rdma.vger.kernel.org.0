Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D795BB5DE
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIQDQD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIQDPx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:15:53 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3089AA2846
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:15:52 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11eab59db71so54677034fac.11
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Zyv5FDQnJC4sRYkZ5cYS5i5JDmAkzbPLDi4iGf12G40=;
        b=onsmseug1xBID6uNz5LfgDK4OObiGZadaUOEEFsUpaNsE+QnPTt+rMYJ1A0d2zrZQL
         pcV8lpFz3gmi7rsktAJmvmPS+drsyVFy1veSiOgVGvDO6Imw1+RcLbn5IHKZmiJ+8f0/
         hFru9Eqlce3JrW4xfvrRj8sK7tRU9MFIWY5GCoaZqXN9tH3iMdEmhzMtcGTxJr/+Ds8q
         QAElOZsJtGIpHqoghnt9sE0mDCrfc1GEpMiagNcbYbD1IQoi7On/iyBEK+zRlJG/ToPe
         ITqdRG6ib8eR3+WSBJuLwkNVbjtH/enSRo8dRONapBpR3J5oSE8f9YOC+ufL+F6nPiqN
         /LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Zyv5FDQnJC4sRYkZ5cYS5i5JDmAkzbPLDi4iGf12G40=;
        b=0Eys23vPL1GZK/n+F+hT+Wriv6bP6PzW9h5I65ekHApxvdvJZNF2xSuOwh4qwIIMFD
         lBGz7dQ770XrW5KCfCiQF3KHcYXl8uho6DyjdvxPifq/wkwCYuk8pBhhyvP+PBDzsw9z
         nrZ4NTyI2copQvg6bjXjjYlMmmgfE1Zte0WVwV9spQmVOBQdtEf+Nxoy84vrag4RX276
         btqPfQW/Ff4V5aFHsV/j+093Uxd+cy4omZNQnXTgE0rA6BkaWF23wlaWe2cSzIBT2ahs
         bppKFujvsbWsj+4ge0ryhFZ1jUwfyFPyyYVUl+sFGj7qV6bP/ptklkLI+oINisxPPcNe
         EgEw==
X-Gm-Message-State: ACgBeo173nvlS3N5XgKU69yR5Fia12knKWx9l+O7OY0/zikqRDJYxd5F
        mwuM6iedqpLMy7VwnIt/FUU=
X-Google-Smtp-Source: AA6agR7CQRZBWmPaaLea+cHdovBgdui47rzUFF1wQphgTYl8HOtI0cDDLqQHE59TutxPoTKfHQBjMg==
X-Received: by 2002:a05:6870:580c:b0:12a:f136:a8f5 with SMTP id r12-20020a056870580c00b0012af136a8f5mr9845079oap.269.1663384551567;
        Fri, 16 Sep 2022 20:15:51 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id y4-20020a056870428400b0010d5d5c3fc3sm4240314oah.8.2022.09.16.20.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:15:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 0/2] providers/rxe: Implement the xrc transport protocol
Date:   Fri, 16 Sep 2022 22:15:35 -0500
Message-Id: <20220917031536.21354-1-rpearsonhpe@gmail.com>
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

Make changes to implement the xrc transport protocol including
- Implement ibv_create_srq_ex
- Implement ibv_open/close_xrcd
- Implement ibv_get_srq_num
- Implement xrc support for qp_ex

The patch "providers/rxe: Remove redundant num_sge fields" is
a pre-requisite for this patch.

Bob Pearson (2):
  Update kernel headers
  providers/rxe: Implement the xrc transport protocol

 kernel-headers/rdma/ib_user_ioctl_verbs.h |   2 +
 kernel-headers/rdma/ib_user_verbs.h       |  16 +
 kernel-headers/rdma/rdma_user_rxe.h       |  14 +-
 providers/rxe/rxe-abi.h                   |   2 +
 providers/rxe/rxe.c                       | 387 +++++++++++++++-------
 providers/rxe/rxe.h                       |  21 +-
 6 files changed, 318 insertions(+), 124 deletions(-)


base-commit: 41c28b03d2b7cfc982eedd2e7491b01df984f5d7
-- 
2.34.1


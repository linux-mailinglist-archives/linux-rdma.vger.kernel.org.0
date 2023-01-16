Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897FA66D20C
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 23:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjAPWxn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 17:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjAPWxV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 17:53:21 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAC42CFE8
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 14:52:57 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id s124so7748882oif.1
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 14:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wS2QJiiyEkMO2gJl6NWYW/D1zG17H+Y4EKUKme3Ybio=;
        b=SO3wqfO86O3Qu4fzmjzlE8qj/kLvqClc413iss5McJ2Yz7OgYs3ftyZGemq3ll3avt
         LPZNJT22z7yxhcaKuSQeAm9KhIAMLfgEgxeTMqKIWRtDhPrcpUrkyzNKvAn9kc7VSj2W
         29lQlxV6n7dYWSE0A9xClV+lBg2Hm79RBHOymElJEKh/YTDXY+8Ip2me24XZgoA/MhHG
         Mk34PZzCw6/grxoq/N7GE1nTFTEi+I9emdjg5g1kc5332beu16R9rN3oRW/3TL65+VQK
         CILqP0OHU/M1dn0VQBqSKy7p0tZvJaJ6BYh595A916sosUPxicHQkd2uY3O922j1Bvry
         FaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wS2QJiiyEkMO2gJl6NWYW/D1zG17H+Y4EKUKme3Ybio=;
        b=XzG4PjTwM91PbBcwZjfLgNnNM9V5u5rrdqxYGoQo/Yk9b/nYMiP988XFaxBYPGQkIu
         vfYEouACpojaINg9DT3b6YKyDpcVSRy095rZ97BmSPQdCz7KbWyv/ZOj/xa1ydoC9fj9
         RdRc38Jsg3nxUUIYta482cJoDs4D308pb4TovDE7VawfBJSZs1DvDtOfbxi8xZ0kyolV
         HaiALPcfW8tMsoUq7oG+JTnfp1QShG8Hm5ukKPtIam/mJU9RPDyU9LUj4eUwuFHJz4gm
         ynvGdI9KF4poy4coU8IphHH5WVLrVFxW2eTJ9v3cMFwk/zS0spQF6cDDkwy4Crvpn7rJ
         zi7Q==
X-Gm-Message-State: AFqh2koSfqe4WZNP46HJtI8Fb6/S13ogzIYURfniW7A253/zmvEAkwg7
        PdAux8IOGzjI6cstXasNx0s=
X-Google-Smtp-Source: AMrXdXuZZUqFZFB3Ke2nMfOP1YLabrj17TsQI1sUT6gu+OM0175iWJQEEFRIdbSp7GMbzmQ0kTnoGg==
X-Received: by 2002:a54:4893:0:b0:35e:506e:4b3e with SMTP id r19-20020a544893000000b0035e506e4b3emr388208oic.37.1673909576122;
        Mon, 16 Jan 2023 14:52:56 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id s4-20020a056808008400b0035028730c90sm13651937oic.1.2023.01.16.14.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:52:55 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 0/6] RDMA/rxe: Replace mr page map with an xarray
Date:   Mon, 16 Jan 2023 16:52:22 -0600
Message-Id: <20230116225227.21163-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mr.c    | 610 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 118 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  36 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  37 +-
 5 files changed, 405 insertions(+), 409 deletions(-)


base-commit: 1ec82317a1daac78c04b0c15af89018ccf9fa2b7
-- 
2.37.2


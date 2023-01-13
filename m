Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB53A66A70A
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jan 2023 00:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjAMX11 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 18:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjAMX1W (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 18:27:22 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92428CD18
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:27:20 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id f88-20020a9d03e1000000b00684c4041ff1so3350927otf.8
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBeZxB8naJtceiPhRLaPpdCUQv4NQBKmN/c9IOjJN48=;
        b=IpOImF4xOyI0zm8C7g0k43JFjMKID8agAyctPcIeyNBA09q3qnTjD8hLADPdm99vj3
         W8tKql3/BVPtRwThXuKSwCdULRjiAZZYvJRurrDkr10eSyLBI23o9dzBMy5MkhJlNlBm
         aAigKP6Zw3PSGQTBHpDz4jBPw1eOSPwf8uQRt9mZg8kLySIYt/lxYi9kejQQ1QZ8p2zx
         Ib/d+svakARLMFzvFk+YFhf4ybetuiXtg24jDbeA2EVsQUxf343WSSPQQjLouR8stGUF
         VNc5YHGtdovE1MNYuRZQxFOTLdGd7MiylEoGiE2NpDBoO/8HCzurpd+zGgUgPaXibH9X
         Uyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBeZxB8naJtceiPhRLaPpdCUQv4NQBKmN/c9IOjJN48=;
        b=C+wtfTYQgMMcfatrAuXZ4nLbOomrr1JoTd74G2k4XRQruISb1qBzwf3OF7FXDWtcC1
         mmGiy28IboeDyUI3U48QtEncwVvS5gMKksuyKA/uQ+GocrhFnSm+67UImOl9PrO5NPQX
         aK+c2iq4I4YE4FmyBjn6Ogsg8Xir+08IpO0tzZDQj56mGej0GK4kuBJrKkygXn6/mUOq
         EL+wpprLRzROnlg45uBQbNZV6m3Bc2MQESzq8nej/jebuzHTGuCX+uuXQ5hrPvojj4US
         xLNBxDkDVLfV1rMU4Oe3CmYa6Zu8/Wvixc88Ot5U5wF7nLd1B2s3xSjLg6hKMUcZHOWe
         2uHw==
X-Gm-Message-State: AFqh2kpXbxTwNaIzKyVNxH8NwG5fQsqgp9yfw6l9ZPJZaKb/VIOQlh0F
        4TdOx3WN9jPwf1x5Mg+SWxc=
X-Google-Smtp-Source: AMrXdXsRa0Kp/hcHOJDgxl0QMKbxQqtzZfaYScB8vUqPAqHwlmynTQqmZkmlrE7tAEGa32eE85BHzw==
X-Received: by 2002:a9d:17cf:0:b0:670:64af:1a4b with SMTP id j73-20020a9d17cf000000b0067064af1a4bmr5414832otj.16.1673652440147;
        Fri, 13 Jan 2023 15:27:20 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3f47-8433-ec70-f475.res6.spectrum.com. [2603:8081:140c:1a00:3f47:8433:ec70:f475])
        by smtp.gmail.com with ESMTPSA id q13-20020a9d57cd000000b0066871c3adb3sm11297433oti.28.2023.01.13.15.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:27:19 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 0/6] RDMA/rxe: Replace mr page map with an xarray
Date:   Fri, 13 Jan 2023 17:26:59 -0600
Message-Id: <20230113232704.20072-1-rpearsonhpe@gmail.com>
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

 drivers/infiniband/sw/rxe/rxe_loc.h   |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 574 +++++++++++++++-----------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 107 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  36 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  32 +-
 5 files changed, 374 insertions(+), 381 deletions(-)


base-commit: bd99ede8ef2dc03e29a181b755ba4f78da2644e6
-- 
2.37.2


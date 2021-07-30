Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037123DBC24
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 17:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbhG3PXO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jul 2021 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbhG3PXO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jul 2021 11:23:14 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81701C061765
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:09 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so9842804ota.11
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jul 2021 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zxw53FG+XeqBG4lT1Ei76hQc8WUepspEW1QlVoaU4Ms=;
        b=LwPoKU4It2/sZbS03AMVZff28j0xa5rW8kFnKwRqak+gSjmwKhvI5R6GWby26BcEhX
         jf3I7BiR/ZBdsPDfgTRtJ6SKZ6XbpUzkQ/TV881CE9hwSVM5blS8mHTqbUGIWnM7keXG
         LK9uMdVal/mdGoxgyw/aETcqjLbqRT6M/8TzP92nwUpur+qhx4wXzbBH1kWzhklo4Shg
         d3xHtGQ+Pu2+7LrOECUxnuA6OhBHwh/22oFxo1IN5cU6UFbVte4sSNfOrPkv/ElumrvP
         RNmcLmSDJwuN24Wlz04N7iG1M/1F2A1JLMbep20wnQR/bvSGXbBgITKu0O5sFP7Ee/1y
         Od+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zxw53FG+XeqBG4lT1Ei76hQc8WUepspEW1QlVoaU4Ms=;
        b=o91w1ad6F2iulWA0xoAu4EJTTgF/RtO77gjQhocSOxCcpxH7sh0lyqKsDJcS1LFtH2
         Ra9mIpjjta3t1GUG9yoKlcdySDcUQgqbdwAEa9yWflW3mZDj+HpbXUDxQhFWvzFXplm0
         hY3lLPKG5Z48+9pKWeRm9HP3LVLQNaDrQ2vvJSR80TOWEt+LfsdPbiRf4kmAkCOhuIh3
         amq2qF+zr0u+irozWGxB1ZTqb4rQRjxI9PR18ke2Bp5UbGzP3Skyioz58UNa6xBY9lUk
         M9xAnuRhFZTHrCA8UPg1/+6mEDsXe3Ydpf+sP/d2qLKOcHlTWecGepBzTf3DHtTtn0Iu
         kSrQ==
X-Gm-Message-State: AOAM533wz4BoJ/YLw8AmlvD1swEul+3Ijk5RxPaIdgTCMeFOijVj7hU5
        LDigJuMirHCzLCEG5vdgPBc=
X-Google-Smtp-Source: ABdhPJxcfzPV2UY7+TObba5ZKTeHweUMGPM/GT+UhG4ioaigaKpADvaT4GN0nRhiHTyvKgi/oYcwag==
X-Received: by 2002:a05:6830:2154:: with SMTP id r20mr2513138otd.12.1627658588900;
        Fri, 30 Jul 2021 08:23:08 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id v5sm337560ota.33.2021.07.30.08.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 08:23:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, xyjxyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 0/5] Providers/rxe: Implement XRC transport for rxe
Date:   Fri, 30 Jul 2021 10:21:53 -0500
Message-Id: <20210730152157.67592-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This set of patches implements xrc transport and extended srq required for
xrc transport in the rxe provider. It matches a kernel rxe driver patch
set with a similar name.

This patch set should be applied to the current rdma-core with the
"Replace AV by AH for UD sends (v2)" patch set which is a prerequisite.

With this patch set 4 of the 5 xrc tests in the python tests pass for
both regular and extended QP create verbs. The XRC/ODP test does not
pass since rxe does not currently support ODP.

Bob Pearson (5):
  Update kernel headers
  Providers/rxe: Support alloc/dealloc xrcd
  Providers/rxe: Support extended create srq
  Providers/rxe: Support get srq number
  Providers/rxe: Support XRC traffic

 kernel-headers/rdma/rdma_user_rxe.h |   6 +-
 providers/rxe/rxe-abi.h             |   2 +
 providers/rxe/rxe.c                 | 235 ++++++++++++++++++++++------
 providers/rxe/rxe.h                 |   5 +-
 4 files changed, 200 insertions(+), 48 deletions(-)

-- 
2.30.2


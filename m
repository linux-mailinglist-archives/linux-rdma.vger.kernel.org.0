Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F92DC982
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Dec 2020 00:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgLPXQi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Dec 2020 18:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLPXQi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Dec 2020 18:16:38 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D3C061794
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:15:57 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id d20so7188064otl.3
        for <linux-rdma@vger.kernel.org>; Wed, 16 Dec 2020 15:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGwb6Vn+SQ80ten1rIk4ibrv0T3kz0SnWjWNA8WAoJ4=;
        b=cBbx7Wx2wgafA2d1mUOC3Ni4Khjdh28ZN4d8PIP3cMvxLR5m0u3FLBgUDxQwO6w0yU
         5wRQsZF991RcmH8mB/U/EAe6TCMGVuizoSqZLCSxAN8TQScR9dhiXeLhMlcD4MbrDmaF
         3jbC+WJoI8BCbg2SdjNx4f5m2LN27Kgo1O7p36H8RRi9kKWObCRCJP4nAQH+t4aaXn6F
         lCjUzizhBClS9tE11k11mkzkRJWK0ZxHd309w/2QTm0zp0CK9WX9o9d0n94wvdPaPi0+
         yZqSxOzI/FRHB3sH8MFWwpzMw89F9XyeRrpOm5hzCkJAZDDvmDPQDrDcdW+UY0p0qPvQ
         yEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rGwb6Vn+SQ80ten1rIk4ibrv0T3kz0SnWjWNA8WAoJ4=;
        b=pSS76X7AxnKv36cGxzK6q929mj2qwYlF0240qfYhfzR7zpgu8nKWkYIIqWgmsp5xsh
         FNhJPcSYVQSMHlPPooh5X52aIvA72t7ZH5yLxIPIXfhap/Y8VlfoRQlXq4FAcqTaOP3p
         IkQv1DfKVJSIky3vb9eJQyWgvCcrUJIiZB3t+EUZFlwPRz0zsLw+NYVLjZ/1B7kDuMok
         Xs97i0Zhiub2vZfBvUX+25UdLizNSx02BYe7IQ2eP38duS3Q4zOvlEc8dDVaQjfY9EIY
         SyKB+cDCMoSUX6ex4t52WpLaAJyKjrHNXg0r9LywCotcxLDe+ztCXNhoqxAtJeaJmqz8
         Y1Zg==
X-Gm-Message-State: AOAM532RzfCLMQcoNEArP+4twWteu1JCemiZDrhn8+Pd7EFemhvnYYQt
        nmbeThK3t0jKccLMMqpdTDoDsgFonTRPVA==
X-Google-Smtp-Source: ABdhPJzmGsT5948Tfxoqciq65aCejWqJPelB26MRqP5oQwBgSJkkbquZ9ECfhI2hc3RA17k8zFi1Gg==
X-Received: by 2002:a05:6830:1011:: with SMTP id a17mr27136095otp.97.1608160557354;
        Wed, 16 Dec 2020 15:15:57 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-6a03-8d89-0aec-a801.res6.spectrum.com. [2603:8081:140c:1a00:6a03:8d89:aec:a801])
        by smtp.gmail.com with ESMTPSA id f18sm793437otf.55.2020.12.16.15.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 15:15:56 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 0/7] RDMA/rxe: cleanup and extensions
Date:   Wed, 16 Dec 2020 17:15:43 -0600
Message-Id: <20201216231550.27224-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series makes various cleanups and extensions to the
object pool core in RDMA/rxe. They are mostly extracted from an
earlier patch set that implemented memory windows and extended
verbs APIs but are separated out since they stand on their own.

Bob Pearson (7):
  RDMA/rxe: Remove unneeded RXE_POOL_ATOMIC flag
  RDMA/rxe: Let pools support both keys and indices
  RDMA/rxe: Add elem_offset field to rxe_type_info
  RDMA/rxe: Make pool lookup and alloc APIs type safe
  RDMA/rxe: Make add/drop key/index APIs type safe
  RDMA/rxe: Add unlocked versions of pool APIs
  RDMA/rxe: Fix race in rxe_mcast.c

 drivers/infiniband/sw/rxe/rxe_mcast.c |  64 +++++---
 drivers/infiniband/sw/rxe/rxe_pool.c  | 226 +++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  94 ++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  16 +-
 4 files changed, 268 insertions(+), 132 deletions(-)

-- 
2.27.0


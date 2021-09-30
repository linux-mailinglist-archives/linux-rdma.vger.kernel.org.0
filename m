Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A8641D26A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 06:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhI3Eh6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 00:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhI3Eh6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 00:37:58 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE88C06161C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:36:16 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so5727689otv.4
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s33vfDTM3u/gg/OqVuHlVDVgfZH1xXj14XVqlhx0JUk=;
        b=JNGZj5FiM17g9txy0nIgpvYtzIYvbuZbPbXMTrvWT7A0X7sumBmTiooFGksjc9M3O3
         oF07isW/G8ToD0D97/D/D65DN570TUz665yfwCPOzNBhwNNABAjLVL7s0pDNURsAmD3r
         M2otxztbBl2X9YHzF74QUW2i17G6aYrUxP7KzxbIWyB0ZmexK4rixSqQR2/6R48MP4R6
         unES8e50mPxqWoa7XJ08XDaO7bd0f1HOvk9kHEybk9+0udNupKIaeBLsOVPVXxlc+eu/
         +yqguzsZIlXkRBzWMg7yPKrraGi2zsWX/cIX5OeBrXwK1QQv0irm2sADr3Frgyu40Z4Z
         F13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s33vfDTM3u/gg/OqVuHlVDVgfZH1xXj14XVqlhx0JUk=;
        b=bx6Ls/YHNMbJHNRcbBlAFpxedw7yOpxvJAZwJa5gKz3fIGMKJveh2sooj6Z7nYzQkw
         jd/5KZzqOsqQOimJoAWljovkKj0tf4jbXQTC9yYsFRJouUPuyllkyWLsSKvhTAuGdiBm
         YJqyvkR7eJ60jghaRWF2hTQeGSoKy/8bV3AKsMxiyO6rDE8D8KKXCFdgNTbUS1cz/XQt
         6+JNGpajzSubjrAxrbiBJ0C7S15iP8dq07KkciTam2GfT+R4Wegf/afnhSP9VXzVAzww
         5ruOpf8RF8+LKA+jDhnooOeUYvN2OmFRYspBMtNRQdCsDdclmUoUwoHprJmWnsW28gbI
         KNAg==
X-Gm-Message-State: AOAM530TrqBAoe9CIQqh7S2vcT7uPFaxyMXYlL2HywwyuIhUdsOyOrle
        ctVCB0YT3n6qsA7ad6g+xTd6PhtF1T+/lg==
X-Google-Smtp-Source: ABdhPJz7lln5wzvQhcqXx1BUACluZSf01k4HeDvlcyd/Rp9H9qDNBO+EVmN1SHrqG9ytteGnlXJ0lg==
X-Received: by 2002:a9d:12ec:: with SMTP id g99mr3271392otg.197.1632976575525;
        Wed, 29 Sep 2021 21:36:15 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-48b3-0edc-a395-cab0.res6.spectrum.com. [2603:8081:140c:1a00:48b3:edc:a395:cab0])
        by smtp.gmail.com with ESMTPSA id k15sm389427ooh.41.2021.09.29.21.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 21:36:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH resending v2 0/2] Providers/rxe: Replace AV by AH for UD sends
Date:   Wed, 29 Sep 2021 23:35:01 -0500
Message-Id: <20210930043502.4941-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These patches contains the changes to the rxe provider to match the
kernel patch series with a similar name.

This patch series is identical to the one sent with the v3 RDMA/rxe:
kernel patch set but still cleanly applied to the current rdma-core tree.

commit 0217e47de29c5429679c7ebf73d38a95623d2785 (master)

v2:
  As suggested by Jason Gunthorp moved the AV struct out of rxe_send_wqe
  and into rxe_wr in the ud struct in the wr union at the original offset.
  This maintains ABI compatibility with old kernels or rdma-core but
  simplifies the code.

Bob Pearson (2):
  Update kernel headers
  Providers/rxe: Replace AV by AH for UD sends

 kernel-headers/rdma/rdma_user_rxe.h |  16 +++-
 providers/rxe/rxe-abi.h             |   2 +
 providers/rxe/rxe.c                 | 117 ++++++++++++++++++----------
 providers/rxe/rxe.h                 |   8 +-
 4 files changed, 100 insertions(+), 43 deletions(-)

-- 
2.30.2


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7D01EDF1F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2020 10:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgFDIMg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Jun 2020 04:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgFDIMg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Jun 2020 04:12:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F46C03E96D
        for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2020 01:12:35 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so5030312wrc.7
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jun 2020 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ys1lEmo1OrglME8cWbIXSVFR7KWfyvCPNKiL9IEbmhc=;
        b=RUvuRoaAUx3zoTg0dekOOqbI1T8Sgso/qeY9AgIY+69YkzMVoxVd2zcJLUgcBipdk7
         bfLnFFHUCXlCtl7HOikMZEY9KbeA3ZJCmbGvpYaKPSFaizoR8g1G0iiiWixkm2fyo6ve
         uHh1ScOQIMEnMrZouE9W6fbm6RZuu2BrIaMFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ys1lEmo1OrglME8cWbIXSVFR7KWfyvCPNKiL9IEbmhc=;
        b=AsUOFm8CtJhP15NukdQxaxW2dKJiPDqS5KfQn2azMn7dhuW5YUdKYzHEWY3ys4Jvw5
         92OW22YJ5f4FUy2rgcDkc4bhe9+/pd0oDW5mX+tCts8P/dIuiLVhVNR2QcDVX7mrnTrO
         h8hyhgW0yLUSvLBidYN9maZMJzXlhmSakGWMkVe3qmDSJLYlKBXtnrtWZ4jBO0cbLjqe
         zCEKIIfoTNrs+cNOKIlv3Z3OXW4uBoecj6r0An+jwrqxYZJa3nBfx4C0njwvJut22V6n
         6tT1Ajzcv1u5mYxrZJMFBe5tcj65Dy0zcj2Z1hxaWiTY66st5hw8xmqoN/q3rOHlbHjh
         jRdQ==
X-Gm-Message-State: AOAM533wSoDjgIM4gqNri0ivPUETcqS/Zwkeq0i7E436FORE3GFThptk
        aw8Y4sMgdbKESFy1FdKN9baZil2u6eU=
X-Google-Smtp-Source: ABdhPJyMtbbr4YZr5XgYcavaaABocIWgVVWO+6bIVkLH86w/gWfWScj44NFGJ8WhcZD+YmTAw14Znw==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr3495849wrv.58.1591258354483;
        Thu, 04 Jun 2020 01:12:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f11sm6873305wrj.2.2020.06.04.01.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:12:33 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 02/18] dma-buf: minor doc touch-ups
Date:   Thu,  4 Jun 2020 10:12:08 +0200
Message-Id: <20200604081224.863494-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Just some tiny edits:
- fix link to struct dma_fence
- give slightly more meaningful title - the polling here is about
  implicit fences, explicit fences (in sync_file or drm_syncobj) also
  have their own polling

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/dma-buf/dma-buf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 01ce125f8e8d..e018ef80451e 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -161,11 +161,11 @@ static loff_t dma_buf_llseek(struct file *file, loff_t offset, int whence)
 }
 
 /**
- * DOC: fence polling
+ * DOC: implicit fence polling
  *
  * To support cross-device and cross-driver synchronization of buffer access
- * implicit fences (represented internally in the kernel with &struct fence) can
- * be attached to a &dma_buf. The glue for that and a few related things are
+ * implicit fences (represented internally in the kernel with &struct dma_fence)
+ * can be attached to a &dma_buf. The glue for that and a few related things are
  * provided in the &dma_resv structure.
  *
  * Userspace can query the state of these implicitly tracked fences using poll()
-- 
2.26.2


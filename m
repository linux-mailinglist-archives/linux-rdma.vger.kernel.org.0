Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4F32178BA
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgGGUMx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgGGUMw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:12:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E4CC061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so481155wmf.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eLBVqiQIsMtlYONLK2w+6GAazNNz+oaX8A8qo8Nlgow=;
        b=h8aTmKDumgx6uK3u1RBVVfOiqqCLYe0T9/bj69f9/X0ccNfTIXAmNn3Rg6ZXKJmB2w
         Fqh11hUx1o8VWrFql2F1WN5KSJ5pkx7hNX8LQoWTPt71oJyQRq22dMNefBPloJZbeTcp
         LrfOFV/DOPROglnZx10L3SEosAeq/TI99ybyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eLBVqiQIsMtlYONLK2w+6GAazNNz+oaX8A8qo8Nlgow=;
        b=rp35caKt7UeEHaeCUOnCvLc8rZww/fqUDTfmhBZUCtaGkwhxYc1AXo8TyiL0eS284T
         Y576hobu2/lVSkFpGK7/7D6LZ4PA8LTpaITlBgGMA0IkIf7T85HZtlOqqZYVkiiwzaGH
         iWUj9ZekhQV7lsQSw+tFZfNK21SEffp85qkMB2sXWfrBxQFNYWmPKk763W0eo4igzDNl
         +nXuFL76+HoU3QBZ+qp6iC1PRh+a6aiqAkfHhg57lwFeaaGYBggLNLw8kT3tRy47ge70
         ke2YGkPX3ZofWuMboRJNcgNGHiFQe4Qq0dlqQ+hDb3HCC/KwTJPeVupR3SRn9VgEqkDL
         5xVg==
X-Gm-Message-State: AOAM532pub/iGwVPleESNrqCn0AGOaq4rL5xLDkMjv8OnqYzHksTirJ2
        XfiFNOHTTAalSJ0cUXghRyK3Hg==
X-Google-Smtp-Source: ABdhPJwr5VodDUuWsEiTX9Us0Z+/3e4TMNgf3i7VpNciq6fTFlY5xqtBFVOJnix4uvw2QX/UJg2lfQ==
X-Received: by 2002:a1c:1bc6:: with SMTP id b189mr5582918wmb.166.1594152771107;
        Tue, 07 Jul 2020 13:12:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:50 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>
Subject: [PATCH 08/25] drm/malidp: Annotate dma-fence critical section in commit path
Date:   Tue,  7 Jul 2020 22:12:12 +0200
Message-Id: <20200707201229.472834-9-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Again needs to be put right after the call to
drm_atomic_helper_commit_hw_done(), since that's the last thing which
can hold up a subsequent atomic commit.

No surprises here.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: "James (Qian) Wang" <james.qian.wang@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mihail Atanassov <mihail.atanassov@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 69fee05c256c..26e60401a8e1 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -234,6 +234,7 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
 	int i;
+	bool fence_cookie = dma_fence_begin_signalling();
 
 	pm_runtime_get_sync(drm->dev);
 
@@ -260,6 +261,8 @@ static void malidp_atomic_commit_tail(struct drm_atomic_state *state)
 
 	malidp_atomic_commit_hw_done(state);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	pm_runtime_put(drm->dev);
 
 	drm_atomic_helper_cleanup_planes(drm, state);
-- 
2.27.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42992178BE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgGGUM6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbgGGUM5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:12:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA34C061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so38532398wrs.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWJo4Xms9xJyKH8uRObCjerwfD0/w2Bq7w9d1Tdqg68=;
        b=UOX4Dtrl9QRt0mnhEULXYaIhXEcwlQEl9dJZ6AKauST0v8/sueYjVcBr1H9gpshANp
         D7Leh7Gl+2NKEN7rDuk7xlozsQQmDcFZg1uLXs+bi5cvrSo2PcRAIgbCNAj4hEOLHs4E
         nH2oRdO8AAwxZVQ6SAlDyIBsQf7zFeXKTjhnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWJo4Xms9xJyKH8uRObCjerwfD0/w2Bq7w9d1Tdqg68=;
        b=bAAS3HXFYhp5BvpejPNI015337DYtfnJ/XIwiUC+PU1B6QEJwioWxK076GwKhUMFPY
         A7lH9YTCiZ3XrBvXQ8SfL987YYiEyFg0d0HMPL+IG5idc0D5inc/zjy19QhS98UlqCE5
         4R/FRD7BVDik7lrgt3CK0eGuScuOEWDBWZmxvD86S+JnK0zJZVve3Z1YDGskv6TpnE8+
         2OUsOB9on3v9HKlOnNsfgJ1jd2ZAdde74Kf+KQ+cALmqNcnbICpLZYtOUlSslcwynAg2
         eKV7ZpHFH4fnX46FG5RJrHc5zFX186tRdOau4uX0n5MyLj1z1sBkYdND2BmX1bvVHYZJ
         xQJg==
X-Gm-Message-State: AOAM533T7Gob2TsfmAPVbQOrUorLnL6cqcpZaU0INPKS94Mk07d54Ry/
        EoEweKej2EfrjFmHmOvqYCFBJQ==
X-Google-Smtp-Source: ABdhPJxDsyfr4zDexGLiiFYSg/7wzAGNH9tBkAAtd+Zc++yr8EV6rRAt45326uR5zE2Phg7PZ7uGVw==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr32057251wrs.345.1594152776092;
        Tue, 07 Jul 2020 13:12:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:55 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 12/25] drm/rcar-du: Annotate dma-fence critical section in commit path
Date:   Tue,  7 Jul 2020 22:12:16 +0200
Message-Id: <20200707201229.472834-13-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Ends right after drm_atomic_helper_commit_hw_done(), absolutely
nothing fancy going on here.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index 482329102f19..42c5dc588435 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -391,6 +391,7 @@ static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
 	struct drm_crtc_state *crtc_state;
 	struct drm_crtc *crtc;
 	unsigned int i;
+	bool fence_cookie = dma_fence_begin_signalling();
 
 	/*
 	 * Store RGB routing to DPAD0 and DPAD1, the hardware will be configured
@@ -417,6 +418,7 @@ static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
 
 	drm_atomic_helper_commit_hw_done(old_state);
+	dma_fence_end_signalling(fence_cookie);
 	drm_atomic_helper_wait_for_flip_done(dev, old_state);
 
 	drm_atomic_helper_cleanup_planes(dev, old_state);
-- 
2.27.0


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932FD2178B7
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 22:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgGGUMw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 16:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbgGGUMv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 16:12:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B7EC061755
        for <linux-rdma@vger.kernel.org>; Tue,  7 Jul 2020 13:12:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so35313645wrl.8
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jul 2020 13:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FSVZqSJcwRWybnSndKNbUfNNvpPl3BY3d6N/f/GeKA=;
        b=iQObijhNDZgQfMrr/kbpnXa9ZxoNeRb2jWrZDoJ8+CmPgTcWOx7Oz/V39ElFnc9h0F
         /r/CH4Lk1gXB3G+CDC+rvEZ/5KcWxG1Dv4lmt8HzclLQw7g2PegkLyWqc4+xDNtWsy0q
         WUhAjilaUBigQh9yDg9wUfTrZt/8nwZttfUvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FSVZqSJcwRWybnSndKNbUfNNvpPl3BY3d6N/f/GeKA=;
        b=EQPq5+dmhmr5enCEUDKY3K4SSb7IVfbqImE//iMBXdFd7mgNYSDOjHN5sCxjSILnvh
         UhV/P6vpnvFwIPIkYbgNurVSARwR0JiovnETvclfq4izc1R838UrRBi+feC5SdhVoBn2
         shIJDundJ76ReO6sJXuZuEkEVRGEUNcML82vmMAoiNsDzbIYkUmbVGXvU2zMZwuhAU6U
         EEtuozoW2uNZGNWxiN6D72tpTfzXEfoKDSG34NoyPATcymRq6o8WEZ5cM0XZBUbWg8U0
         UCpOzpfMk7r3tsp2yYpLSv+DfFw30rJItPXQKIlNnOARskVQpf0wJDNJSSPrCcdPzTLI
         NdaQ==
X-Gm-Message-State: AOAM5308KRKKXdjsenGeCVAX/eJBzvcjYosuPQyG3hZWylBRbfDWGvOu
        nVBCqUQnsTt5Uu2XGd0BFtnZCA==
X-Google-Smtp-Source: ABdhPJzFLolELbzMXu1omVdH3bnFD0mMnve//+cNMLXSBH/icZkkoks9YpeuTOOcWag3OhUrUnRozg==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr61242906wrn.157.1594152770054;
        Tue, 07 Jul 2020 13:12:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q7sm2515262wra.56.2020.07.07.13.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:12:49 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 07/25] drm/komdea: Annotate dma-fence critical section in commit path
Date:   Tue,  7 Jul 2020 22:12:11 +0200
Message-Id: <20200707201229.472834-8-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Like the helpers, nothing special. Well except not, because we the
critical section extends until after hw_done(), since that's the last
thing which could hold up a subsequent atomic commit. That means the
wait_for_flip_done is included, but that's not a problem, we're
allowed to call dma_fence_wait() from signalling critical sections.
Even on our own fence (which this does), it's just a bit confusing.
But in a way those last 2 function calls are already part of the fence
signalling critical section for the next atomic commit.

Reading this I'm wondering why komeda waits for flip_done() before
calling hw_done(), which is a bit backwards (but hey hw can be
special). Might be good to throw a comment in there that explains why,
because the original commit that added this just doesn't.

Cc: "James (Qian) Wang" <james.qian.wang@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
index 1f6682032ca4..cc5b5915bc5e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -73,6 +73,7 @@ static struct drm_driver komeda_kms_driver = {
 static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
+	bool fence_cookie = dma_fence_begin_signalling();
 
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
@@ -85,6 +86,8 @@ static void komeda_kms_commit_tail(struct drm_atomic_state *old_state)
 
 	drm_atomic_helper_commit_hw_done(old_state);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	drm_atomic_helper_cleanup_planes(dev, old_state);
 }
 
-- 
2.27.0


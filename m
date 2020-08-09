Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA1D23FCFA
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Aug 2020 08:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgHIGRz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Aug 2020 02:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHIGRy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Aug 2020 02:17:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E08C061756;
        Sat,  8 Aug 2020 23:17:54 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so6199742ejb.11;
        Sat, 08 Aug 2020 23:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8/WAyXxEK6f4eGf236GZbQc5j4me7n0Ad/X2a4kTwOE=;
        b=g0wkBOA3EmdhKYruxbUmwfZmyVVTTidomJP8brzeZl79rzKBdFEI8mraRU6x8pZqlf
         OMasWBFRtzBR+dXkmerWTSMGVErG+6gCap7t9JAqwsy7SZvwAyvDHYOh29Fo8hXC+C6N
         VkU+xRYgfagEmoUY8iuHEKYtB+GOmRNYTGb8sUJoktf4T6P530ou9X63PDraRWYODKHT
         FAt5M4KU4em8Ppf1hcOU4by0PYNgM66MkWOx+ZJSjqqgBHV6o648IG8e3c02PmV+OGm1
         YfwJ62JXegpiBF0rA1UZppSgk9lC+O1TqsAqx+1YSCbL+HyvK7xTt2+1tBDOnE/z94p6
         uR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8/WAyXxEK6f4eGf236GZbQc5j4me7n0Ad/X2a4kTwOE=;
        b=Rou7dn0c7K9YEUlbMPVgD5mVuUEFmx7s2TrxM4lRizT6Xir42p/j5d7ZA7Ij1GRL8n
         Md2fh2mgywN4f67afP8qKrwvZOCoPrxLavzTmrmAHZG+wtRmaceg1+8dmAW6TmwUkupy
         x9JYbotWXTZFU22rD2MKMBDLYqnMNNTVZ3d5IgUN7Ftm9KH4yfnBS5yHEQpV+19iUYVg
         n0GvyazyUC/graKLl2SY6CPYMBoyMqontZiFggNE2At+hK8CN02n3WGdNMv3dmKQhUbp
         tJlxCXt/h6QscJBXbfKiXdVPXHxZ3AzL7Rbi51ZcCSdnE0MrIEB3fg8gQKEwH5iLrvj7
         bqfw==
X-Gm-Message-State: AOAM5302EzutqDYNW6D71ebBB6A0IoA76hsvSSTAdYAXMKjhuXGlm4Xx
        QeHnryymwLIBbY5fSlhkDIuUZUM8cDE=
X-Google-Smtp-Source: ABdhPJzAWTtG0O3pCQAx7xu92rq1VP07wg1HoGT+dX5bPPDs3LBi5kspOwUUzgtQT2hF3gwlm3mvyA==
X-Received: by 2002:a17:906:24d0:: with SMTP id f16mr15910842ejb.325.1596953873009;
        Sat, 08 Aug 2020 23:17:53 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d48:c300:9164:4bc4:8f8b:2b7d])
        by smtp.gmail.com with ESMTPSA id j1sm5175454edq.58.2020.08.08.23.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 23:17:52 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] dma-buf.rst: repair length of title underline
Date:   Sun,  9 Aug 2020 08:17:39 +0200
Message-Id: <20200809061739.16803-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

With commit 72b6ede73623 ("dma-buf.rst: Document why indefinite fences are
a bad idea"), document generation warns:

  Documentation/driver-api/dma-buf.rst:182: \
  WARNING: Title underline too short.

Repair length of title underline to remove warning.

Fixes: 72b6ede73623 ("dma-buf.rst: Document why indefinite fences are a bad idea")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Daniel, please pick this minor non-urgent fix to your new documentation.

 Documentation/driver-api/dma-buf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index 100bfd227265..13ea0cc0a3fa 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -179,7 +179,7 @@ DMA Fence uABI/Sync File
    :internal:
 
 Indefinite DMA Fences
-~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~
 
 At various times &dma_fence with an indefinite time until dma_fence_wait()
 finishes have been proposed. Examples include:
-- 
2.17.1


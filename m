Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0212039EDB5
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhFHEaS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhFHEaR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:30:17 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01D0C061574
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 21:28:14 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso2863246otm.11
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/oFmAXiaUjeobuJ6dl/bTJOD/Qe4l9LQU91nEnThKm0=;
        b=RYFil5AMIs08oa3dPaioXnQOgn5xDmPT4Zvljo51B7GkLA8bWEvcncD3Cp3tNYTVe/
         a0bDrFTVV32BeV/OVR4buKlzHQqwxt0h9mt2ZaUTJATpiakLYU3O0YX15CSX0Wd71EPW
         s3bq2XjonwyXr+sZguDuXR0v/m9g3g9QD3wLxceqcFyJfuHgb2dCQsXPnjXIWYsn452P
         OKv+eMIQvLHUHLJfFuS74l6LCD1hfbdIk7RmpCySAHWkfGZiJy/bF6Lw7m8SipYNw3Zx
         H0SgeZHNBpNtxVHnokqR+mXZWnVi/BF72rqx3NyNk27B7N8/S2V4+P3++MRDAIR3011X
         e13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/oFmAXiaUjeobuJ6dl/bTJOD/Qe4l9LQU91nEnThKm0=;
        b=RS+t63jMkjWfKyd6AJOS9ynBcDUbRRQJ3Tz6nqNQBRkGALutcV0b3tljkInZJG3UN5
         HhG2GuUdTqpBRFKU7dmxXks71eF+uO1Sp9VkT3zomD2DAkkP768MfODWs6Cqfz8HfxNG
         XECRxTTiSsDIGelJcfGoO8GWYMZ8mfvq/LYvCw9bMFtZcCM+AE5AopSYoau5iOrO762i
         /Cr6tdqlMGsq3974kJCkezsL0WcFXwXVSBZQUhPcUrnQ7J9t2gcAvzBGldBsAvq60EaH
         MrETu1EkxDkwyHkziFT5TMth2QgAzuGaBlGRRu7A0epTdOgZ+hBkGj3QNm8soIDbeetJ
         XgGw==
X-Gm-Message-State: AOAM533GLpiO8mhEc5N2vndY+vx6nDryMzB2qdpC25aW8jImmYYFuN05
        77XZ0UW7zpmkJ3yAdHAmRbkYE8yuuBg=
X-Google-Smtp-Source: ABdhPJwH0GxVX7DmTurHKInmjtB+VnwiiC9FAQX4fdg6nnT5JGze/1V6IT+LuJrAjcnLIsZM9K8eJw==
X-Received: by 2002:a05:6830:18c2:: with SMTP id v2mr6032271ote.153.1623126494352;
        Mon, 07 Jun 2021 21:28:14 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id 21sm2242777otd.21.2021.06.07.21.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:28:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 0/2] Implement memory windows support for rxe
Date:   Mon,  7 Jun 2021 23:28:01 -0500
Message-Id: <20210608042802.33419-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These patches makes the required changes to the rxe provider and the
rxe ABI to support the kernel memory windows patches to the rxe driver.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---

Bob Pearson (2):
  Update kernel headers
  Providers/rxe: Implement memory windows

 kernel-headers/rdma/rdma_user_rxe.h |  10 ++
 providers/rxe/rxe.c                 | 157 +++++++++++++++++++++++++++-
 2 files changed, 165 insertions(+), 2 deletions(-)

-- 
2.30.2


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC412FE797
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 11:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbhAUK2q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 05:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbhAUJrX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:23 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC33C061385
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v15so1060596wrx.4
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4kMSsAHr6rPwePPe9GLokWhKQx3zqto7WVpZ/I6tzo=;
        b=fAM8b8n5WWLc5D9TMzPl5yev6ZUXT1KUpdBUyeatcBeABXWK/wVvW/XHTCmcN6T93+
         hslAQP9sDCW7uRl1EuF4vOSZaR9uXksbbpTUVkOm7+oTk+3vlSAsRHHcIWLp89WghyL7
         bKWoF+fLrnjoPAJYTfip5++bLkyurCIsDwpPug0WvmVQLUlJ+KnKozM+PYhcmGwOotCp
         55H3vtwrqMvoV1O75xsOg7W45E5fLPq8uzFgOXD9pYGCwve/9eo35FASq7QaS5kJwkuj
         bztRTszYbo8Z2EYZtm16+KmIdWpai+T5QrhcsChqkfH52y4gNrjJlfBR+FbSbid9yTWF
         GWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4kMSsAHr6rPwePPe9GLokWhKQx3zqto7WVpZ/I6tzo=;
        b=NYh17iPslwX0TvbdNYDfkuU5vW4Y2AIuWq7kEzqGkYxFauGPZucJ6DrbsvSO30s8/H
         2M1VQEZlEm22Vmng419nSKTJvyzB/oB3LDgVtzYKNRk2lP769+3xxjGoHjrloxGynv1z
         HlyrMfjQp0lZgYaWTKvg4LkaJHXTkcwomDSlgrzo5+q47D6bZkX4glqQCmHE8okPmUqs
         2MgpiSzk5P2pNHBULrGYsvTqKJvchjp5sWJtVynz/ZkbF63FCGy2L/2Mh+t0tUBfudQA
         Qv/xMFaszt83KChGxAxsA1iiSw5j2VTUPW2aB1C6B6MN5Pm6kJ4wSqadzLvxmpdUsvVS
         bkPw==
X-Gm-Message-State: AOAM533rzWvj9GttZ/aCJ1ynNDcQLz1UUUINjqEk+Y1lckGwxsQrQDN1
        AAR4tyt5FD0dWF30e8cx+/7DSA==
X-Google-Smtp-Source: ABdhPJzTTMwSDYFOzdJ/1Jrdc93C45YqhRaj0x+Mn3bYqzQ7mVNkSyBRiZwG3Y/p3e2Hq2Wnm+YPvA==
X-Received: by 2002:a5d:6749:: with SMTP id l9mr13439374wrw.395.1611222349332;
        Thu, 21 Jan 2021 01:45:49 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 21/30] RDMA/hw/qib/qib_user_pages: Demote non-conformant documentation header
Date:   Thu, 21 Jan 2021 09:45:10 +0000
Message-Id: <20210121094519.2044049-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_user_pages.c:60: warning: Function parameter or member 'hwdev' not described in 'qib_map_page'
 drivers/infiniband/hw/qib/qib_user_pages.c:60: warning: Function parameter or member 'page' not described in 'qib_map_page'
 drivers/infiniband/hw/qib/qib_user_pages.c:60: warning: Function parameter or member 'daddr' not described in 'qib_map_page'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_user_pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
index 4c24e83f31752..5d6cf7427431b 100644
--- a/drivers/infiniband/hw/qib/qib_user_pages.c
+++ b/drivers/infiniband/hw/qib/qib_user_pages.c
@@ -43,7 +43,7 @@ static void __qib_release_user_pages(struct page **p, size_t num_pages,
 	unpin_user_pages_dirty_lock(p, num_pages, dirty);
 }
 
-/**
+/*
  * qib_map_page - a safety wrapper around pci_map_page()
  *
  * A dma_addr of all 0's is interpreted by the chip as "disabled".
-- 
2.25.1


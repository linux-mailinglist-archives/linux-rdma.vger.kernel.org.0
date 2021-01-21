Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54822FF2E3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 19:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbhAUSIr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 13:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbhAUJrQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 04:47:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADF1C0617A4
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b5so1045015wrr.10
        for <linux-rdma@vger.kernel.org>; Thu, 21 Jan 2021 01:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+U4mrC++Zc7DzOaX+UA+V8TmeVUrNgtzJDFj+ktzZpk=;
        b=PpcpLUCI8JAqZ90E8GXMAq61yVjGvXox3pYJ+xZEdJvD8c57FtkSfToVQV8ZjeBQZV
         G19ZMGVHpTdvsHPqu6bdBFZKnTRYm6qUT5u+vziJ+EiHEr3ZtrAnzJajzrlh9JFJxA3E
         83tUcqhYNdMLkraUc8rTpU8VLToHUOufcfmK2ybgW1YKDU20QKZfuw8A8eZWBjEV/Toa
         x9pf4nqG1YBqxvxNkJpVghJnbAUcgCrz5h7hZYj5p/Z4ZPXb+soznPL7divA+S96jNL/
         PswucHZaAgffXgpU7FSw9K0Swzo4ogms0x4z8vSSkJ7WAE7E1tUcAvgf4uk6aAr41OFw
         m+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+U4mrC++Zc7DzOaX+UA+V8TmeVUrNgtzJDFj+ktzZpk=;
        b=f6mCIJQHhDic66eQ6CZVaIjMaEFtNuS3+E4TVeUkFUAvfrsf5LAKcLauxcWNVSe+bk
         G8pukmtw4Zr7DNIaAoX1IvJYW2v4SKeAskt4kFjSut2fo+ljlGz1+uQ+CL1yTC2mwT7a
         +yJXy2l7GlPubOt1j2y8yL0zZ+H5CRr7LecV3i/q9nws4GB7MQmaYTeB/zredcK25rHD
         pdpF9e2HgV0GWAErfDkx6BVQEcTW5SZmr48s0ahoU7P6caj8ioYysr0GAgCxiAfuKxGE
         xWl7a5jVtcsSdrtYszYc/S1+i1Ujdo6af5C8v4xZh0zU2hMcBtuZkV27ADk8atbxI5Yk
         D49A==
X-Gm-Message-State: AOAM531/9sbHotJiT+ZefPdVWKOu6L5NYEMBd3vA7flXSshY3+BitcG5
        GT58spO2S5O9DJlQ9ZR7lEmj6w==
X-Google-Smtp-Source: ABdhPJz+fQlPuqpwnk3hk0kAqFuHWbYZZm4MdB7twAYGtL9sNJfY0qTHF9sHJOtEFZosaTs+gsLqWw==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr13499186wrv.124.1611222335687;
        Thu, 21 Jan 2021 01:45:35 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id a17sm8185648wrs.20.2021.01.21.01.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 01:45:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [PATCH 11/30] RDMA/hw/qib/qib_pcie: Demote obvious kernel-doc abuse
Date:   Thu, 21 Jan 2021 09:45:00 +0000
Message-Id: <20210121094519.2044049-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210121094519.2044049-1-lee.jones@linaro.org>
References: <20210121094519.2044049-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/infiniband/hw/qib/qib_pcie.c:190: warning: Function parameter or member 'dd' not described in 'qib_cache_msi_info'
 drivers/infiniband/hw/qib/qib_pcie.c:190: warning: Function parameter or member 'pos' not described in 'qib_cache_msi_info'

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/infiniband/hw/qib/qib_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_pcie.c b/drivers/infiniband/hw/qib/qib_pcie.c
index 2e07b3749b880..cb2a02d671e2b 100644
--- a/drivers/infiniband/hw/qib/qib_pcie.c
+++ b/drivers/infiniband/hw/qib/qib_pcie.c
@@ -181,7 +181,7 @@ void qib_pcie_ddcleanup(struct qib_devdata *dd)
 	pci_set_drvdata(dd->pcidev, NULL);
 }
 
-/**
+/*
  * We save the msi lo and hi values, so we can restore them after
  * chip reset (the kernel PCI infrastructure doesn't yet handle that
  * correctly.
-- 
2.25.1


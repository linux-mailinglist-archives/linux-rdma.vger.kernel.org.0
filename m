Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA01E6B89
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391434AbgE1TrA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 May 2020 15:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgE1TqG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 May 2020 15:46:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE75DC08C5C6
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2020 12:46:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f18so116865qkh.1
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2020 12:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dQXPo0Swc/1tTSJbOo3DuP6wphJf39iwBm7uw0DHDUk=;
        b=Xiu/PtgPo126o8PBKuIJqMoH0BPrjAAkIgHKuBQAc9ErAMcJAgRcFs+vGbRIfgLrvz
         YPhU33kcyhR88zzeh6wimmu8Tdl4tzrn24M+iOLtr2wVgho/9ypoucas78SLSP/o7qF5
         13wZnEEtO1az9t1ENo56bJbZBFRu0rkHksox5bCbJCWgfB/+ccSFpXLqEzZbnqDGdaMd
         FBsmBaEHQ0frb93pUJgBjQWSlSwWJ6Gzo6cdYhbgOAIFcc15r7RJAfUHuAwToKc9+/Pn
         cdRs6yOB3RcNp6Vx25Jva8+bOM8PqlvyPxb+N+DkzhvgVz5If4nFS9e5WlVLnFr3qZZX
         4AKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dQXPo0Swc/1tTSJbOo3DuP6wphJf39iwBm7uw0DHDUk=;
        b=Tm+3YkKJBr5J4om6vdepYIWnvAJixMy0N4bcU/ajZcVoQPRFwRzyo8XuW7Ke91ajTM
         hc6R2zGLzRlgI8Wm9lYw99IY2k7q10OzPnoJHuUxZQw0soedZtAWeCd+p9cMv3m8Hcr+
         VkXh7OUiz1QIQN+FL1sWEa/1OXIEuRODzor9dTRqPf65S5gGZpwSY14G+1zq0Gc0Rrg6
         WF5QIVQ76tRFOt1dpZait6nuWo9zVAj8hhGyLDQ6IOf08vt5uYz4BXkxmeRMl22fR3Ba
         hb1RomPqnRHVw3c6kXvDF2hPz6Ey5mK1Y7wnPxE3qeAWQT3abdpurss+ZsaviW8uJ2O1
         Zfag==
X-Gm-Message-State: AOAM533qwyed5NXxHZDdhp9gCBeGF5f1PXrAq/clr3mxuxP5buR6JbTt
        EXjCbRhQvwCbcWLtII73NkjiSUNi5fM=
X-Google-Smtp-Source: ABdhPJxtIp6o4fzw8EKlSkOIPe2xgroughEKurTMJR5Duw0SdJkZheZMs6LBvvWGe8woYk9GLqfaHQ==
X-Received: by 2002:a37:4656:: with SMTP id t83mr4616853qka.126.1590695163627;
        Thu, 28 May 2020 12:46:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 185sm5756176qke.92.2020.05.28.12.45.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 May 2020 12:45:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jeOTU-0006hQ-9G; Thu, 28 May 2020 16:45:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>, oren@mellanox.com,
        Shiraz Saleem <shiraz.saleem@intel.com>, shlomin@mellanox.com,
        vladimirk@mellanox.com
Subject: [PATCH v3 07/13] RDMA/i40iw: Remove FMR leftovers
Date:   Thu, 28 May 2020 16:45:49 -0300
Message-Id: <7-v3-f58e6669d5d3+2cf-fmr_removal_jgg@mellanox.com>
In-Reply-To: <0-v3-f58e6669d5d3+2cf-fmr_removal_jgg@mellanox.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

The ibfmr member is never referenced, remove it.

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw.h       | 9 ---------
 drivers/infiniband/hw/i40iw/i40iw_verbs.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 3c62c9327a9c4c..49d92638e0dbbf 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -381,15 +381,6 @@ static inline struct i40iw_mr *to_iwmr(struct ib_mr *ibmr)
 	return container_of(ibmr, struct i40iw_mr, ibmr);
 }
 
-/**
- * to_iwmr_from_ibfmr - get device memory region
- * @ibfmr: ib fmr
- **/
-static inline struct i40iw_mr *to_iwmr_from_ibfmr(struct ib_fmr *ibfmr)
-{
-	return container_of(ibfmr, struct i40iw_mr, ibfmr);
-}
-
 /**
  * to_iwmw - get device memory window
  * @ibmw: ib memory window
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.h b/drivers/infiniband/hw/i40iw/i40iw_verbs.h
index 3a413752ccc38c..331bc21cbcc731 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.h
@@ -89,7 +89,6 @@ struct i40iw_mr {
 	union {
 		struct ib_mr ibmr;
 		struct ib_mw ibmw;
-		struct ib_fmr ibfmr;
 	};
 	struct ib_umem *region;
 	u16 type;
-- 
2.26.2


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193E334959C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 16:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhCYPdp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 11:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhCYPdQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Mar 2021 11:33:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B23C06175F
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a7so3631744ejs.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Mar 2021 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+YxuFEwtWmaVSrfs27UVahPrdcjIgQ83fS0W5T4MvGc=;
        b=S1inAlndY5Yq2ISOaLA1C64xjR3pZ8yLofhJzhEhvC++ISGRvw5p+NKnoaEj/9iTkJ
         TbiVepXK7HPwS7sXG/gAVeNDoqCvTgYfpiYoSTTBwJCm8tNuWaQp0kOhI2+278c/wcEY
         NqK73OgFLDKbLc+DglTbhNJyQP2Eil1XKMtvh0ccvYeJNoAvdSAfLdman8DVsaMrQX8u
         IY4YSIL0re4ny5PfYwuogcc1s2XR4wyLQ37xilOix5j4/4grsOmtB+7hNgv548wXnc5Z
         6FdfkE7EC16+KVI6Kq8n5v5RJQPdVeWmQWv3Q6tfHSYFRdrcsypOP7/Q+nzZ4G2spE3b
         pJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+YxuFEwtWmaVSrfs27UVahPrdcjIgQ83fS0W5T4MvGc=;
        b=pz0fTlZhnjtpIcGbVl3tOTWpdt8LoybhDJOgDM+F8rqtXlkP8OIRG46yIgEh4VZfje
         ekVhAl4a+DKotQUHmy4AGa/AkLwtLpZ/Loy5E4GxdSBG0S2vlQEMBlrrcfM3Ic8aR6PP
         0OEKr9ghbtaCrLF5mcaDV0YS9fAd+l5kwsCSf9vlBocL8uBmTO2BLBloot39R+38SD4C
         0d496WxS3G07dxEUz9h4lQc9vmsYcxeFGVp31MC9745sivB+YBiL1x8qi7RObADAhr+C
         KxRrB25gKLnpnLlztSTy/uTx6yiHPhCjgVHicaNgfiLPcwIrYpqp6xjUY0mKgmi3k4DM
         QucQ==
X-Gm-Message-State: AOAM530Nma5bVE0HdRtgPBCJmmceG3kYz0rCUPtGr2bI1hKW7Mac2Uk6
        CW0RJzhKz+nTJZ1YblrQX48cRv7mJJB9U2eM
X-Google-Smtp-Source: ABdhPJx3kHcFXP9SDubQOs1OZzbRBrDeb9HDQVUQOVNrVa2yeAiYvbcuSenmJ8IVEqt2jBhjGweqtA==
X-Received: by 2002:a17:906:9bc5:: with SMTP id de5mr10233453ejc.284.1616686394106;
        Thu, 25 Mar 2021 08:33:14 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id n26sm2854750eds.22.2021.03.25.08.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:33:13 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-next 01/22] MAINTAINERS: Change maintainer for rtrs module
Date:   Thu, 25 Mar 2021 16:32:47 +0100
Message-Id: <20210325153308.1214057-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Danil Kipnis <danil.kipnis@cloud.ionos.com>

Danil will step down, Haris will take over.
Also update to email address to ionos.com, cloud.ionos.com
will still work for sometime.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Acked-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e876927c60d..716221c9d689 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15541,8 +15541,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-deve
 F:	drivers/net/wireless/realtek/rtl8xxxu/
 
 RTRS TRANSPORT DRIVERS
-M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
-M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
+M:	Jack Wang <jinpu.wang@ionos.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
 F:	drivers/infiniband/ulp/rtrs/
-- 
2.25.1


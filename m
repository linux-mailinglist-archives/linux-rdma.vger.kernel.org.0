Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867583436A1
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 03:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhCVC2M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Mar 2021 22:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCVC2G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Mar 2021 22:28:06 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC32CC061574;
        Sun, 21 Mar 2021 19:28:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h7so11302677qtx.3;
        Sun, 21 Mar 2021 19:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=saO1mOhIf7L0oN3GcCDcaddpRVRVxtAOjyoGRRBRbWg=;
        b=sr4rb7/uxmlmTTIWwvTBGaxiSvfTfsLPfh0P6SxzHa17vJ4tBurONWh/Zpkh/kKsd1
         g9HyXpxeV/3Euo09m/W5YD3u2ByzG90Cet3ZzSNUlsvs5hsEiMo16josuQH2nUFsIH9T
         0XmwPp+No4L69rFBGatDZnleUPd6+1HpwyQoGT2yKW2zasWaAOH5simlk0xGjxs7jHc6
         P+JTrXDadyvY0Z2P6s0ie4getSyQnDCLZMZfsDaubgh9OBUWGe74w2KyhgBBQIufSroa
         1hd4jkvlvItmWizRBHGD/6FKNXuLQsV8Oq+pVF+FoeW87gGpttseeqG7Qb+6uSAPMnQ+
         C/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=saO1mOhIf7L0oN3GcCDcaddpRVRVxtAOjyoGRRBRbWg=;
        b=cc2N2hk0mfnhsIpvOfahEihv/06S/NUxP3dZBgJj9m3QgdCDS1f5UeXBeKhzgUSbAL
         KXJI3ywTIPFHwfQFbe+UxuGwduB01Pt4eLE+IDZRI21xirs9aFJcGa/Hx7nqqCBEKu9h
         GwhjvFn0SBaKnPq18okAMiRU3chTKXth47Z3W0HmRIaq/Tf3zMwPXCWAl4eg9n7FPbdg
         QpMA2pDcg0TVLtv1yUY1aXzSathmg0fvijofn65iYQH44JAO4XovboUbK2QBX9S1AFyE
         Kw4BW+gSskQ6hUO8CVdl8BpRMJIDOlvsPcGwFz9xeZzE5zKKis/eJtynPts7haEu50B+
         Imzw==
X-Gm-Message-State: AOAM530KOVror8VVFulYcYapVjl3qXyqCEPF505BeFyzL5a82ZsEM6j6
        ynOUFXIJMw8BIFsEEQN0AAY=
X-Google-Smtp-Source: ABdhPJytXRKIZll0Y4WeNmEdcOFGM51jGcRgmHPys8nM84CK4/HHLUHidrLXk8vXa59OhY+vKCyXMw==
X-Received: by 2002:ac8:6c4a:: with SMTP id z10mr3869118qtu.229.1616380084907;
        Sun, 21 Mar 2021 19:28:04 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.190])
        by smtp.gmail.com with ESMTPSA id z6sm8294293qto.70.2021.03.21.19.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 19:28:04 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     oulijun@huawei.com, huwei87@hisilicon.com, liweihang@huawei.com,
        dledford@redhat.com, jgg@ziepe.ca, dt@kernel.org,
        linux-rdma@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] IB/hns: Fix a spelling
Date:   Mon, 22 Mar 2021 07:57:51 +0530
Message-Id: <20210322022751.4137205-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


s/wubsytem/subsystem/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 .../devicetree/bindings/infiniband/hisilicon-hns-roce.txt       | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt b/Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
index 84f1a1b505d2..c57e09099bcb 100644
--- a/Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
+++ b/Documentation/devicetree/bindings/infiniband/hisilicon-hns-roce.txt
@@ -1,7 +1,7 @@
 Hisilicon RoCE DT description

 Hisilicon RoCE engine is a part of network subsystem.
-It works depending on other part of network wubsytem, such as, gmac and
+It works depending on other part of network subsystem, such as, gmac and
 dsa fabric.

 Additional properties are described here:
--
2.31.0


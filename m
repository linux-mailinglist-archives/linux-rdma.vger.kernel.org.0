Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2123D3EE8C4
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Aug 2021 10:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbhHQImj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Aug 2021 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbhHQImh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Aug 2021 04:42:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECCC0613CF;
        Tue, 17 Aug 2021 01:42:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so1293472wme.1;
        Tue, 17 Aug 2021 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qalcxJZSAoenJ2mSdG7qlNEBuHFgwiIsTwgVJuQxk0=;
        b=ht8yRhloawgIJiHlAISbi+RuwDm/dDfdDMeo57txgPIodpCpr5bxw1+irSjmlqsdYL
         9Srw7AqXvkPNAYLXJMThjIH6LN9cyFUJC8XDl2x0Uo6mN1w5fmxjvcrckYwG/R1h0Hcv
         ziIVnXo58gNhu/HbPH3ve7kcZslOBkKftdyHd+EOQOV1U/9wdnWPgSdWijxBRVMRzao2
         2rchP0+aVpA/IWSLv4YeLovGGlry6HYyxcFuFNcLW+TFPiURZCB7p4T+uub65uKgaYSr
         HoiC61f0M/A1jDRrKpSeQAi4uLBgOV7EszocmWCBvsb0lzQtjWiPnbIl9PaG+AeglhUW
         Gmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8qalcxJZSAoenJ2mSdG7qlNEBuHFgwiIsTwgVJuQxk0=;
        b=eiEMvVtoHhRBTx1ZDReIq7mM6czeuNUxmlDpCGMlOrfKbd+U7OXUTjzMp9HJKJuATF
         sZYFaDh0BlElbKMR4tzehH6FE0cuy4pm4cNt20ZY+yTeuS8FOWFe6lDUGmZBUYhFPToF
         SaI1JvTVk1QQAGhmZbAe1FstKj/YEwi7Ik1jCxG6mgp/y3+99ByxIl5zHVE0q/EOjNFj
         crKVAFb8qRJUSAWHGQCnk8YkWgR0sWAvyXnwndC8tyLB6CTbxj4CLFJ54vpjd5pXW2W1
         yzwbR6kfUaMZSENCIOit5faMJ1awayY4IHaKfLwMN8VP9/zqy7BKdwVwJy5cqwINDkv8
         kxnQ==
X-Gm-Message-State: AOAM531FVhciAYaY5YHZYW9HsiMhMMW1w5G8BPr7RF6xPGdkaWuULaSD
        fk1U1HCh6NcHnjUIlI1w8lU=
X-Google-Smtp-Source: ABdhPJyZKkIE+C84W/G4rSFiKHZjSSJjbiSqkmFeJcz2qchGApyeiFuGu9f6Rjs+C/BRMBzyTlgRcQ==
X-Received: by 2002:a05:600c:a08:: with SMTP id z8mr2123242wmp.52.1629189722426;
        Tue, 17 Aug 2021 01:42:02 -0700 (PDT)
Received: from localhost.localdomain (arl-84-90-178-246.netvisao.pt. [84.90.178.246])
        by smtp.gmail.com with ESMTPSA id o125sm1378907wme.15.2021.08.17.01.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:42:02 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] rdma: irdma: Rectify selection in config INFINIBAND_IRDMA
Date:   Tue, 17 Aug 2021 10:41:58 +0200
Message-Id: <20210817084158.10095-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In Kconfig, references to other config do not use the prefix "CONFIG_".

Commit fa0cf568fd76 ("RDMA/irdma: Add irdma Kconfig/Makefile and remove
i40iw") selects config CONFIG_AUXILIARY_BUS in config INFINIBAND_IRDMA,
but intended to select config AUXILIARY_BUS.

Rectify this selection in config INFINIBAND_IRDMA.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/infiniband/hw/irdma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/Kconfig b/drivers/infiniband/hw/irdma/Kconfig
index dab88286d549..b6f9c41bca51 100644
--- a/drivers/infiniband/hw/irdma/Kconfig
+++ b/drivers/infiniband/hw/irdma/Kconfig
@@ -6,7 +6,7 @@ config INFINIBAND_IRDMA
 	depends on PCI
 	depends on ICE && I40E
 	select GENERIC_ALLOCATOR
-	select CONFIG_AUXILIARY_BUS
+	select AUXILIARY_BUS
 	help
 	  This is an Intel(R) Ethernet Protocol Driver for RDMA driver
 	  that support E810 (iWARP/RoCE) and X722 (iWARP) network devices.
-- 
2.26.2


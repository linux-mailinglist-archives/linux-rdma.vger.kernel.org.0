Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5DB6FD4B3
	for <lists+linux-rdma@lfdr.de>; Wed, 10 May 2023 05:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjEJDzr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 May 2023 23:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbjEJDzE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 May 2023 23:55:04 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4CD449E;
        Tue,  9 May 2023 20:54:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643990c5319so4739981b3a.2;
        Tue, 09 May 2023 20:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683690875; x=1686282875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R13pX/DGcCdpBhTHhkY/bwvkemgqqVgL5MNqBdrIkZg=;
        b=N8pYwznN3q0/cFkfWSKza0gMaDhy49xdZcF4lJMjg7rhksfRPSi2RogyCuQ5AiszzL
         aXs0fdwIR1AgDPlA1pKhrSKC4CpeyjxvhGWOU9WSvgEciHjSrleoxDdpgkW/8eiPmZrT
         sbGO92hYspswPL7S0cQwhgy1+TBUWhq9++Mer52I9GdvG+Sq4Pl5bE4NMwrqNmk9hGow
         c4IaFtLN3DNPpe70tRVh35OXinZlmr1dEeDMYw6+nghqsjCyPYiLaAz/3w6z+wisn/Ih
         dbeoUxYZu7PVi8o0Sg0qc1vx9k1UNo3SgqY4qDak2+LgmnSTYNow7NwwYuXBItRXvFqG
         bsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683690875; x=1686282875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R13pX/DGcCdpBhTHhkY/bwvkemgqqVgL5MNqBdrIkZg=;
        b=c/2DB683SOWwmeuTko80jL3FRPO75R69p9sEujscVSI3o5TaHX7z5F9imc0R9ezrie
         fi8SuBw3271rno3OiXR/Nrie9dO4kKQ5YbUiMDFCt0pb7Ge7A11/FChwV5VAdZ8jfSde
         1gkpTePFelUgwayxEB1xTiUYk69Cw43flIf3rMF1LqWz0/9yfygWfapCSeLIO0wmo6Q3
         +l+vWituFzAmOn1eOrl5rwcVqYFgMctwSrhuishCpk/xbrZQy3AxZDY7jUU5FzqSntqn
         vjYeo6xFB5IN3RKWGoaqXNavTuXcOInoAZv/O/Fgp0bDGLUEku03KLVCvSwcBAhN/Ysw
         BfrA==
X-Gm-Message-State: AC+VfDwxYWgoNAO4izk9knClwFQeesUUVhCQlTMLIG7tz5n84TSa9Wkt
        fJvu+waKtazkZ4X2FjZmm1A8Vh5VGQY=
X-Google-Smtp-Source: ACHHUZ5W9wYsjCCZhsT/xp9lkRTManF2E6Q7o4gbGzsRoYrMq1jpzmmds9ChpKMC4gw4PwXdwR1hrg==
X-Received: by 2002:a05:6a21:6d9d:b0:102:31fc:918c with SMTP id wl29-20020a056a216d9d00b0010231fc918cmr1805754pzb.45.1683690874840;
        Tue, 09 May 2023 20:54:34 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-21.three.co.id. [116.206.28.21])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b0052c9998ec2asm2021286pgr.68.2023.05.09.20.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:54:34 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7FDD3106AA1; Wed, 10 May 2023 10:54:29 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Networking <netdev@vger.kernel.org>,
        Remote Direct Memory Access Kernel Subsystem 
        <linux-rdma@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Gal Pressman <gal@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net v2 4/4] Documentation: net/mlx5: Wrap notes in admonition blocks
Date:   Wed, 10 May 2023 10:54:15 +0700
Message-Id: <20230510035415.16956-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510035415.16956-1-bagasdotme@gmail.com>
References: <20230510035415.16956-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454; i=bagasdotme@gmail.com; h=from:subject; bh=amgu7llNkvOpANFlqUZo94YkdrbPN8Lwojtmp8pNSjY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCnRomkpYt8bNs16aM+88Tlf87e2tA7ZTfYrOd+kXTgcf Nz29o+yjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzEZz0jw9NZ0U8Ezz1vFlho mfhRz73oiPfuV0kWpbMn7VOyuW+o5MbwP/b/qfSbL+d7TV2YtvQnu/Mho+lThLh9Jffu2bzOmG2 VIxcA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wrap note paragraphs in note:: directive as it better fit for the
purpose of noting devlink commands.

Fixes: f2d51e579359b7 ("net/mlx5: Separate mlx5 driver documentation into multiple pages")
Fixes: cf14af140a5ad0 ("net/mlx5e: Add vnic devlink health reporter to representors")
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../ethernet/mellanox/mlx5/devlink.rst             | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst
index f962c0975d8428..3354ca3608ee67 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst
@@ -182,7 +182,8 @@ User commands examples:
 
     $ devlink health diagnose pci/0000:82:00.0 reporter tx
 
-NOTE: This command has valid output only when interface is up, otherwise the command has empty output.
+.. note::
+   This command has valid output only when interface is up, otherwise the command has empty output.
 
 - Show number of tx errors indicated, number of recover flows ended successfully,
   is autorecover enabled and graceful period from last recover::
@@ -234,8 +235,9 @@ User commands examples:
 
     $ devlink health dump show pci/0000:82:00.0 reporter fw
 
-NOTE: This command can run only on the PF which has fw tracer ownership,
-running it on other PF or any VF will return "Operation not permitted".
+.. note::
+   This command can run only on the PF which has fw tracer ownership,
+   running it on other PF or any VF will return "Operation not permitted".
 
 fw fatal reporter
 -----------------
@@ -258,7 +260,8 @@ User commands examples:
 
     $ devlink health dump show pci/0000:82:00.1 reporter fw_fatal
 
-NOTE: This command can run only on PF.
+.. note::
+   This command can run only on PF.
 
 vnic reporter
 -------------
@@ -299,4 +302,5 @@ User commands examples:
 
         $ devlink health diagnose pci/0000:82:00.1/65537 reporter vnic
 
-NOTE: This command can run over all interfaces such as PF/VF and representor ports.
+.. note::
+   This command can run over all interfaces such as PF/VF and representor ports.
-- 
An old man doll... just what I always wanted! - Clara


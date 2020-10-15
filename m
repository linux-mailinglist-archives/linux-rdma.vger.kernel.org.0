Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612EB28FA09
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392222AbgJOUST (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 16:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392221AbgJOUST (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 16:18:19 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7781C061755
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 13:18:18 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id t15so425009otk.0
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epjouaugheMTGEbm2mi2YSqkz8OYEQNad2qpBiFt+rQ=;
        b=uCp9iJ5SnAk06gUk4rkHhFryiZMv9hq2WpoBXn7wZaql1T3xS/bY+IxWfDP4VJJHq0
         rZ2ayLOGdOAxl1WVkrMvUWH/nrV7YVZ4L+glkMIAiOb2wwLF6Ai5C8O1WV0foTuf8eFJ
         D6Oenk752guHiqDYm68P9yx3/JU7PCI3OUrpUgWuPOhZ5+h1dk1Z8uXAXIK485z6EHHV
         m3In2iwseIF3NJpyCLWXQ2HbrPvA6599hTcpCdL4nK/t3NGvSDH3jo59ba8ADGckpdMZ
         Sc7nUuH2lyAZVLc2tCHBW+c0BVaxOhbsJs6ZQU/QAC2961Xl9oL27F2+YOVwVVxjODO/
         9SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=epjouaugheMTGEbm2mi2YSqkz8OYEQNad2qpBiFt+rQ=;
        b=V9nlwWIkRtu4C/3ppEjnkLBTBHDvT+FX2NLvPNkziDnlIv9Q51RisQhg5/fDmk+Caf
         ZEphL4qIZhsSn+TMx59PMEro1SptIL+aTlQRts8RcU/xCgT8gdp9nMG4gL1EjJGtudRd
         nAzrvDLHvMmdA0RnbdJ6x7qkEllb480nP4XrhNhhp8JPiul7PHDV1gI22DY+cDaWxGG4
         QnA3tNTZN35fXSU0hlsxrqOe7I0eSWMqO/ZcxKN7GHFdNejIQgEoAf11LjEv4Ir+Acaz
         UZdQQXQ56qVuYu9f4SEP/4VjSpt1cqmjLReaKzxR+bCj/VLfjB6+C3RHhH2qxLkA/Jyo
         De3g==
X-Gm-Message-State: AOAM532pnHuPkuPN7nB2QVhRi9MagyOn3dwWa5+RsSn89cAEa29Fjhyu
        5ki1rMVkHHc281TF0Hwv/uc=
X-Google-Smtp-Source: ABdhPJwPO0ZgJa0q7kw5gZHLaoTBqbyd9BLOaP7FedT07CA8yH+wOhVsFKEZkSIfhjCJjkMpFtvEtw==
X-Received: by 2002:a9d:6ea:: with SMTP id 97mr144489otx.255.1602793098116;
        Thu, 15 Oct 2020 13:18:18 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-4fdb-8393-d75b-2d46.res6.spectrum.com. [2603:8081:140c:1a00:4fdb:8393:d75b:2d46])
        by smtp.gmail.com with ESMTPSA id g124sm41592oia.58.2020.10.15.13.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 13:18:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH] Provider/rxe: Fix regression to UD traffic
Date:   Thu, 15 Oct 2020 15:17:51 -0500
Message-Id: <20201015201750.8336-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Update enum rdma_network_type copy to match kernel version.
Without this change provider/rxe will send incorrect
network types to the kernel in send WQEs.

This fix keeps rxe functional but should be replaced by a better
implementation.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 providers/rxe/rxe.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/providers/rxe/rxe.h b/providers/rxe/rxe.h
index 96f4ee9c..46e6ce72 100644
--- a/providers/rxe/rxe.h
+++ b/providers/rxe/rxe.h
@@ -44,6 +44,7 @@
 
 enum rdma_network_type {
 	RDMA_NETWORK_IB,
+	RDMA_NETWORK_ROCE_V1,
 	RDMA_NETWORK_IPV4,
 	RDMA_NETWORK_IPV6
 };
-- 
2.25.1


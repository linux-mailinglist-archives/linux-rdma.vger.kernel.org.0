Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE236643A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 06:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhDUECX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 00:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDUECW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 00:02:22 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C02C06174A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 21:01:50 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id i81so41197794oif.6
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 21:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lphX+5tViXsu7izfKXAm6/r0EOGr5NpSrKPjNpy4l8s=;
        b=bDmzkH+xFeOFikBg6FQGXqZHMJyELpGoPuHbYUgE+fWuGyg24ZzbDIA6NV+HXgJcIf
         fQtc0x7k2+le6awXaeY0DtTX68wUQBqiXeIQcXVDRu/rKViXwgZuixwRDrYuyjTgE97D
         xLfQoRz4RlazA0oztu43+8LBmE/yNS82EiLYH04CcEiWDqhvokJmoxqPI4OkVzrwsnY8
         wwjYNbFCxb4Jui/MZJYcZuPqwHzqk8jcMzWnywByGAEWkV7TBeOdfM7uyK+JFLzPFe/j
         YcHWb1wPhRcKI0f87WNJTIZla12PrR/+UJuES8ebSt7W0gg9SA4Pb+TfjR/v+pEOCHFe
         mtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lphX+5tViXsu7izfKXAm6/r0EOGr5NpSrKPjNpy4l8s=;
        b=Nq8bDT0eLGwSIxqBKkQcVGQXVYeTMX51j+kS0F5ElesH03OCMXH1DY91qNFspgV6tY
         xhmcKwQE0Yn0rdbqqZVK7O0Ptp4AGrVfYCI/UrWSOsQ6WEUDSecL/CbWDHDSqeAMosRa
         /ILeiwUDHUi6yoOK6orRkMF+6pvfOSyMOpzZIbeAhuEZmKaaboxaF8/kiikJmSAyq0w3
         +NS9Cd0QTeQp5jha6LkfeWNeFo9WotHM61lPLArTpMz8hH0f63lYlWmiCIPmZn/JB3MG
         SkyNC82QBL8ZaCGeUH3+/mvC8B52PHlPfFbw3V5wwA5XoL6Aek6UszYzKTbfaLeIv7sh
         9vmw==
X-Gm-Message-State: AOAM5320XIAjZlJVfQKv8nQCfw9MhJQPKI7u62aFbp/8wGpAkgdIymfX
        GIA2qJx4tSyPVaLXMQAmmaY=
X-Google-Smtp-Source: ABdhPJwOhEdsQ0Xqgk8ZJF6UZwi6mLOp6+VuV2ukNrqbmImWn3fhhHvzlpGQxH0hOyOIaeivZXOp1Q==
X-Received: by 2002:aca:49d2:: with SMTP id w201mr5755651oia.154.1618977709362;
        Tue, 20 Apr 2021 21:01:49 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-b446-281e-a20a-b0d2.res6.spectrum.com. [2603:8081:140c:1a00:b446:281e:a20a:b0d2])
        by smtp.gmail.com with ESMTPSA id d94sm266652otb.22.2021.04.20.21.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 21:01:48 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>, Frank Zago <frank.zago@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Fix a bug in rxe_fill_ip_info()
Date:   Tue, 20 Apr 2021 22:59:53 -0500
Message-Id: <20210421035952.4892-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix a bug in rxe_fill_ip_info() which was attempting to convert from
RDMA_NETWORK_XXX to RXE_NETWORK_XXX. .._IPV6 should have mapped to .._IPV6
not .._IPV4.

Fixes: edebc8407b88 ("RDMA/rxe: Fix small problem in network_type patch")
Suggested-by: Frank Zago <frank.zago@hpe.com>
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_av.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_av.c b/drivers/infiniband/sw/rxe/rxe_av.c
index df0d173d6acb..da2e867a1ed9 100644
--- a/drivers/infiniband/sw/rxe/rxe_av.c
+++ b/drivers/infiniband/sw/rxe/rxe_av.c
@@ -88,7 +88,7 @@ void rxe_av_fill_ip_info(struct rxe_av *av, struct rdma_ah_attr *attr)
 		type = RXE_NETWORK_TYPE_IPV4;
 		break;
 	case RDMA_NETWORK_IPV6:
-		type = RXE_NETWORK_TYPE_IPV4;
+		type = RXE_NETWORK_TYPE_IPV6;
 		break;
 	default:
 		/* not reached - checked in rxe_av_chk_attr */
-- 
2.27.0


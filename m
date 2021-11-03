Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3385A443C53
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhKCFGQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhKCFGP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:15 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C131C061205
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:39 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id bk26so812632oib.11
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KykkmDvKMbxz+zyAsBOw7kED0NlaW5Hbp5S9hypTqY=;
        b=aA8ABXvgeNuankcpkdwU+9RNCPJoZW0Ycng1+JX2qzexeHOS594a0E/Zb32CIAYuvd
         qJqFIdy3EwYnKhChkJcg2z4QPw7x75SEZJaoSyCAULbhXC2iQpH6e15MaQUJ5XWvwh5Q
         JPOnmZd8TneCOMBa9gs38CKxEttJSuOl4kc4hYEmGAj6VS8FXcfoEdjgbhePrXBqE1WN
         ahNAw+CYbwQXdB7DMyFGUCLm3pzrOtVXKWeflzSfNFsQBtJYMZCc72Fy2a3RkUWzr6V7
         YEqOxfNXcLklhdEdJdut3YPUR9eXCTDV1UzIkXAx09SmyPUMIYuk5sZjvhUSM9mlfs+8
         i+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KykkmDvKMbxz+zyAsBOw7kED0NlaW5Hbp5S9hypTqY=;
        b=zQ9g4aTsX2EsMXFRi4vjgl0ydwyp4f8t08cnbmuBHcBq+LPzyDBSyHx5lP1RD6C22r
         bj7VInc2R7oParFUxZiDFQFy7KJ+1NLg/TkMK09B9RXajgmUfQHmqTvYCyg462D4qaGM
         NshlYtE6RdHQwPf687vxWiM4t9XOstSTbrqzPoH6+Ff74ee7tfgy8BclmeBMyV0a1p2/
         AHRUSD5jOpj0aaUUEGk3dsnyOwOmCpYOXrI+5Uvt0siBIWe8D5jC239MtXmUMb67Uxlt
         MrBdz9cWUthqVuIu7x07R/pR4SnhUkxqrbamjcIVjSusArlUG3k/kw3B2gKTYo0HRdC7
         2PeQ==
X-Gm-Message-State: AOAM533W/2YSWfdPHsdm3iw8qZdidQlJkdV54j2mKEWyDwS8uJNzYECj
        FN1PxahbkmuFWfJa5p2NGfk=
X-Google-Smtp-Source: ABdhPJxIP+RjLzoeK0QRqVkoVrwK4wCOQSjYuErH7+M2Rae6YmNPIETH9h5M5RJ5cF0CzRVYKvWaaQ==
X-Received: by 2002:aca:bc55:: with SMTP id m82mr8798202oif.75.1635915818916;
        Tue, 02 Nov 2021 22:03:38 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 06/13] RDMA/rxe: Remove #include "rxe_loc.h" from rxe_pool.c
Date:   Wed,  3 Nov 2021 00:02:35 -0500
Message-Id: <20211103050241.61293-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103050241.61293-1-rpearsonhpe@gmail.com>
References: <20211103050241.61293-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_loc.h is already included in rxe.h so do not include it in rxe_pool.c

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_pool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index e54433b47365..ff3979807872 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -5,7 +5,6 @@
  */
 
 #include "rxe.h"
-#include "rxe_loc.h"
 
 static const struct rxe_type_info {
 	const char *name;
-- 
2.30.2


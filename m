Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114BD2D179F
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 18:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgLGRdp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 12:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgLGRdp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Dec 2020 12:33:45 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB9AC061749;
        Mon,  7 Dec 2020 09:33:04 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id g20so20692904ejb.1;
        Mon, 07 Dec 2020 09:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7jKGCmRFpSDqWM5j4V8mDvoPe7sGMFu/bi/rHpaJIiY=;
        b=dGcgH2D03mXSPltGOqajF1QUVQHPnz7K6EDNKuvfZsRVKw697VSl53N6im0f2dXp4i
         xyug9wUP4EX0BPLnJrpGd8J3mkDJ1Sd8tYNXiDWzqD/ON8X3vEkpnZK+sTYFS30usnCV
         PTDpeOW8d/4v1GfLMpxKXOgNJibqsngofmseqrfTZgjEQWvDP/oZUnOA2bqznqUXEPzq
         U0UuSUBs3pqBqWzxndVXAxI+/YQFp24+Dgwd2Lj16cwH352H0XvpoPsmwy00WJmO8lco
         kz7m1bCvOOlP/9JrjI+rSgQ2wPyw3mq5iTYTh1EoLztBhl244zFRi+mYqganI7sLHiXc
         2klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7jKGCmRFpSDqWM5j4V8mDvoPe7sGMFu/bi/rHpaJIiY=;
        b=BQQdJp/ePyGJSqS3SXctUh+3f3zrfukV1DGtCj/jWCx9qFC7UqJx5YH+rDxDc/HOS9
         QXDXUp0ToGIHHT2/6c0SoNJhBGyA4UtiuppJ7mdZAFFCUzDFdlLyPUaUXzxtX+7Mi5+h
         030CgzJm0LOdc1Js4X83mVJijwbcCNDm6elG20M/l/GiUKKyrlU/VZYJw7tDkLHSOb8S
         gApWzvHDGq82K/bHU5Z1HGjubuxXTmTUlfnTG7bZqpqauRUUiR2V60VFqDrK0HAJiBh3
         N4SQ9NlOIEKQTvRr5lqgrGQjpkBb5ML2XxoOy7xCWuvvXYzaY3eSqwoJCN/36DSLiq6n
         TXWQ==
X-Gm-Message-State: AOAM5322TjYdO+zdHzwZukH0O27oFD9Mi7iI105/Tkdbnd7ppwO9RIDF
        pnOaCPGh2MDRMh3s0OaNVlU=
X-Google-Smtp-Source: ABdhPJzGvuAuROG9mIe9RzlBkxu/okyID7XBPoXX7N7jshfPtrLaLaFPCNi6otgxsh3H+1jiwL86Gg==
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr6452455ejb.144.1607362383543;
        Mon, 07 Dec 2020 09:33:03 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4a:c600:a156:c2e7:428c:4f12])
        by smtp.gmail.com with ESMTPSA id oq7sm3205832ejb.63.2020.12.07.09.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 09:33:02 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] RDMA/restrack: update kernel documentation for ib_create_named_qp()
Date:   Mon,  7 Dec 2020 18:32:55 +0100
Message-Id: <20201207173255.13355-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Commit 66f57b871efc ("RDMA/restrack: Support all QP types") extends
ib_create_qp() to a named ib_create_named_qp(), which takes the caller's
name as argument, but it did not add the new argument description to the
function's kerneldoc.

make htmldocs warns:

  ./drivers/infiniband/core/verbs.c:1206: warning: Function parameter or
  member 'caller' not described in 'ib_create_named_qp'

Add a description for this new argument based on the description of the
same argument in other related functions.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies on next-20201207

Doug, Jason, Leon, please pick this minor doc fix on your -next tree.

 drivers/infiniband/core/verbs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 5d4c7c263665..57206fe1bad2 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1197,6 +1197,7 @@ static struct ib_qp *create_xrc_qp_user(struct ib_qp *qp,
  * @qp_init_attr: A list of initial attributes required to create the
  *   QP.  If QP creation succeeds, then the attributes are updated to
  *   the actual capabilities of the created QP.
+ * @caller: caller's build-time module name
  *
  * NOTE: for user qp use ib_create_qp_user with valid udata!
  */
-- 
2.17.1


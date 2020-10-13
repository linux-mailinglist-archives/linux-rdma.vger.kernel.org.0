Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D552A28D2D5
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 19:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgJMRJQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 13:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgJMRJQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 13:09:16 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C47C0613D0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 10:09:16 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x62so103419oix.11
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLocuD5wnm+drp+khVEwy/stL9jOkK9kiuwnxkxVzbo=;
        b=dAfNiqobwSfuZDN1ndWzrWiJ6OBjjWMq0qaZLxXiY2+75bAgg6m6YN6Q76KjJdOeMz
         8wD/y+wzbfpQrt7EUTiJyqXprwohkSImQJKqrSDusbTKR04RhwXRBT1/wDoi4HzSmPGH
         3vb/ffYch9UqzHaX172aANbOK3gXCjP3ladk70040z5uD9GnNgh8HZhyEGf+/Kn1GXbN
         h1w2vY9PTWgpNZykDQOPdaHIA4z+xvsPk1i/bddd7w5Qlp7z829IVdDw+d5n5tzVY/dt
         KAvwBj9XSwC2Rc/s1isib8FDtZ8NKX8pbX4viLNv0UUVU2v/MA2Z598E8tvIDlKctAgJ
         erYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLocuD5wnm+drp+khVEwy/stL9jOkK9kiuwnxkxVzbo=;
        b=niuxWd3mHu5pJ0UEpjUgGOmLXG1FSkwaANM2VO2Ud0sMWqu+ftbBm1+LuYPW0goJNB
         CXAx/V1JUNoHr6Ciz/Rm4MzPBsHD5g3jITZLXNYuPe5E7djZVPhXseTs+A8lI9/bZAza
         1gmVqNj4gilhYJd1ovZ7n4FM9o4fN7L+8lJNCwcDEEZqTiXfpo8BROVP00/OJwqdKUSe
         s9IW/VM8saZ8iagIHxUluqDlPIefPxoUp/Bx0HEB5BX0vc/blv3umTq3XlcxTTNXNKZe
         IDeA+z33EuzOor3JGi/8MgLTWsFqF1exrl49x9yGqYtp24Uyv2YhygHZcGpGkPCxLgyh
         nobA==
X-Gm-Message-State: AOAM533jPm69Jvu2Uwqx7B39hgHkRRvyizEkTAsP0k/UQLvQ7dbHYgIW
        sqIru7LTTeyTR1XZ21G1TiVmlZ9jmWg=
X-Google-Smtp-Source: ABdhPJy+snOG3Gc3FP0087hdENbqzyYuaS8WnaQKEIMu34sjhV7mhdURNzwEleBB9wFyctfbIBqCsg==
X-Received: by 2002:a05:6808:2c8:: with SMTP id a8mr443666oid.82.1602608955609;
        Tue, 13 Oct 2020 10:09:15 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-5ee5-86ef-4523-14d5.res6.spectrum.com. [2603:8081:140c:1a00:5ee5:86ef:4523:14d5])
        by smtp.gmail.com with ESMTPSA id h5sm123725otb.11.2020.10.13.10.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 10:09:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe fixed bug in rxe_requester
Date:   Tue, 13 Oct 2020 12:07:42 -0500
Message-Id: <20201013170741.3590-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The code which limited the number of unacknowledged PSNs was incorrect.
The PSNs are limited to 24 bits and wrap back to zero from 0x00ffffff.
The test was computing a 32 bit value which wraps at 32 bits so that
qp->req.psn can appear smaller than the limit when it is actually larger.

Replace '>' test with psn_compare which is used for other PSN comparisons
and correctly handles the 24 bit size.

Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index af3923bf0a36..d4917646641a 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -634,7 +634,8 @@ int rxe_requester(void *arg)
 	}
 
 	if (unlikely(qp_type(qp) == IB_QPT_RC &&
-		     qp->req.psn > (qp->comp.psn + RXE_MAX_UNACKED_PSNS))) {
+		psn_compare(qp->req.psn, (qp->comp.psn +
+				RXE_MAX_UNACKED_PSNS)) > 0)) {
 		qp->req.wait_psn = 1;
 		goto exit;
 	}
-- 
2.25.1


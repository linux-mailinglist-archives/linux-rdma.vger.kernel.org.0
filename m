Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C51D1E4BB7
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2020 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbgE0RSs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 13:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbgE0RSr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 13:18:47 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8436FC03E97D
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 10:18:47 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o5so26849042iow.8
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkIMmueQvxfVDWKIIM+bcxnthZ2wA6asQUxgcCg6uOU=;
        b=aKX2wIXig9+Ukrdbn/VhlV8kOoeIR4oCZ3d3dQ15YzobytKo4Qc/6j4fZDrZNg+hrA
         4G4HTVQZZsTMtIIQ5vzdr1EB0aRFyCg/0hJjD76OQG7ulwpupvOQO4EOt1okE0D038Fu
         jQ7d3yWneb9lNaJQAo7BpjXTS2P7Xxkkyt5HqE+2kq7aYegjTZDrbDSVIOnF6W8RHp6K
         fRB0tLtW5b8TKJ6YDO2vnYEgsZ//1LtvAh+NkygR/E9BcmJTtceJOuYqZ+QoaVHvTWgK
         GbB9h66dk2TnpFjajCFfg0BKregePOR266HtmAWOc6uH+rt4A1vNjFoYypRitSldgyec
         5NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WkIMmueQvxfVDWKIIM+bcxnthZ2wA6asQUxgcCg6uOU=;
        b=j1llK73/qADF0Wm9qMSm7OhuOtlP+WIpDCAvsWVvvDlrkMVutU6FWSZMJ0/1rA9Bn7
         LFfPhev8Ra7l2Rn1E/qigHTaDAlF7P4imoS9foW8t+XBwsv7NCA55ILjU+gG/rBxS2vu
         1YorZvqzHedVRmBd8XvhETZ8RXlHj+a6Jr3msbo+cYcMcEOL/SlLCu/6ToDVTrbOvPZ3
         jJRvjbe7irasKnQsBxE8kmiTQ5iCFFv0rGbrAOPMPrt0l2FfZsbINxp+z8TzCYslEx0F
         nXgdQHcokM6dLnAntYHo1PJbk+WE7PIef4t3t+nKPvOoYd1BvqSkNs5ts5wFcSAKdvC6
         ZU3Q==
X-Gm-Message-State: AOAM533lOrIBOVrAQvC622cl+ruc54tHnX8ZusOdzxP5Dij/Oaf0Htv6
        pHiiDUKoa6/hEUQA5yiCshGYH/k2iT4=
X-Google-Smtp-Source: ABdhPJys+cyjehCrCb3T2WQM6t+sY/1NN9PIVxMOcP+Xck8mc7pqGqCjsQqUhvPKoStrtPBGUMCVuQ==
X-Received: by 2002:a02:134a:: with SMTP id 71mr6585818jaz.118.1590599926816;
        Wed, 27 May 2020 10:18:46 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d29sm1883868ild.42.2020.05.27.10.18.46
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 10:18:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdzhV-0004Ij-JH
        for linux-rdma@vger.kernel.org; Wed, 27 May 2020 14:18:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA/core: Use offsetofend() instead of open coding
Date:   Wed, 27 May 2020 14:18:45 -0300
Message-Id: <0-v1-0bc346e08476+585-drop_offsetofend_jgg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

No reason to open code this.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/rdma/uverbs_ioctl.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index 0418d7bddf3e0c..86de10ea30afb1 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -491,8 +491,7 @@ struct uapi_definition {
  */
 #define UVERBS_ATTR_STRUCT(_type, _last)                                       \
 	.zero_trailing = 1,                                                    \
-	UVERBS_ATTR_SIZE(((uintptr_t)(&((_type *)0)->_last + 1)),              \
-			 sizeof(_type))
+	UVERBS_ATTR_SIZE(offsetofend(_type, _last), sizeof(_type))
 /*
  * Specifies at least min_len bytes must be passed in, but the amount can be
  * larger, up to the protocol maximum size. No check for zeroing is done.
-- 
2.26.2


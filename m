Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8167D3DAEE3
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhG2Wax (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhG2Wax (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:30:53 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1AC061765
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:30:48 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so7453845oth.7
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doEJHGuKKEWXnT34JPCu9iLUl2HHIXmAu0JUwCmoi60=;
        b=l8dw5QICffNbGnJjrbPxex9CKe7GAf+Ky678b6oPA2R0VSjElvoD4ivseK6O2wleIp
         uhvAboL/z/DB8Zug9TNY73xysMGj7GE8artc1M3NSeCY9n713XrkgiLFVPByGzvzqKxq
         bnPIWPY/YRmREGuNV2LUXV5RoJPApMLc5P+Mo8GVxgZPjZiIlzd9rT/aieaQgxU4N1hF
         cLfrwIHFT6O5Lk4IHjr0SqYdbV/MvvA+MAVIVShabU5LSXFjy2tb/Vmrt/VP4Mn9Yjn+
         l/vr5W529bHoyfns08qtntwPA/m+tV/7A7AmJL87CrmMqmD7UwkiFcMnSSlrz3gcScWy
         w7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doEJHGuKKEWXnT34JPCu9iLUl2HHIXmAu0JUwCmoi60=;
        b=EchbvMc/bubio/08bg2RqwDoSKwGjIsEbWBG+nGl/ZlP5+e7vIFVcwGaQQsJRofdsV
         tu3ev1jF4TT0JfB83MBC3JWuPcxxAxH4kwtBAj7VfeeZrHJg19FUyaM3rf4ElaM9VWZv
         KhB8T37TqT4eKlISq3jZrtoNuAYbkTPHNleSbtaJ/4m+GzbzoyFUKv6rb0Gy0gus+k5N
         EhVTMeNa+xmeJpVHQiYXvbC7z1GganaCDTl9TZ/nFfF9mHC9YYQu5FIBIHI0vFrwjvyk
         kaunKz58pz402c+6nh37M8srvYd62/i9Sv5pgss+UqIJf4KKNhLY7unEqwfh1xnzePZU
         b2cw==
X-Gm-Message-State: AOAM532y4w4kurcSiAHaNYvVdfM+psmsYgg2kAfxvYFxauIZ1jXuJuu0
        iJVQaJUZe5Yrdz4OSKgqUzQ=
X-Google-Smtp-Source: ABdhPJxQlQTAA8uBpfjewLmulyyLJWdv7eFjND4Gax2THS44r5jJh8EkxoXo96u/FJg45VsyyxmoBg==
X-Received: by 2002:a9d:174:: with SMTP id 107mr5026010otu.179.1627597848200;
        Thu, 29 Jul 2021 15:30:48 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id x8sm181074oof.27.2021.07.29.15.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:30:47 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 0/2] Let RDMA-core manage certain objects
Date:   Thu, 29 Jul 2021 17:30:09 -0500
Message-Id: <20210729223010.31007-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The rxe driver duplicates work already done by rdma core. These patches
simplify the rxe driver removing the duplicate effort. The first patch
was already released. Version 2 adds a second patch.

These two patches should be applied after V2 "Three rxe bug fixes"
patches and V3 "Replace AV by AH in UD sends" patches applied to
the current for-next branch.

Bob Pearson (2):
  RDMA/rxe: Let rdma-core manage PDs
  RDMA/rxe: Let rdma-core manage CQs and SRQs

 drivers/infiniband/sw/rxe/rxe_av.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  | 14 ++--
 drivers/infiniband/sw/rxe/rxe_loc.h   | 19 +-----
 drivers/infiniband/sw/rxe/rxe_mr.c    |  8 +--
 drivers/infiniband/sw/rxe/rxe_mw.c    | 31 ++++-----
 drivers/infiniband/sw/rxe/rxe_net.c   |  6 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    | 92 +++++++++------------------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  6 +-
 drivers/infiniband/sw/rxe/rxe_req.c   | 22 +++----
 drivers/infiniband/sw/rxe/rxe_resp.c  | 58 ++++++++---------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 44 +++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.h | 59 ++++++++++++++---
 12 files changed, 165 insertions(+), 196 deletions(-)

-- 
2.30.2


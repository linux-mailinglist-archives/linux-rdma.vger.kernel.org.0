Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B678F3439DB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 07:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCVGnu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 02:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhCVGne (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Mar 2021 02:43:34 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85262C061574;
        Sun, 21 Mar 2021 23:43:34 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id by2so8119435qvb.11;
        Sun, 21 Mar 2021 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSugutdgZSALIH5CXLgm4RzKdZBqE7drYLdKtUlGTdc=;
        b=OEh7YtQ7ca7NJM9Kw6C8aLfqsTZqo2EPrlPd7Utd3/C/Ln7hj5B8jksHQY4xNzlJpt
         T6EOU15x28Wve7i1xxg51NhCKETJ6e49YuJXysKe5NI7vBzKN8JK+QtLX2GGi/aS4o9v
         KwibY9wqwGpJNIjRfYTuuKEpCRaCMeSyWLNmK2Omz47+DB/YXQMXoIAPpSEanXkTb9ju
         kP8M+Vq+7NDELXFp3d4ECR1mPD6rauCGn/tsHdTw4IqgwtIKFc1MiayhSGpjxkJms0LR
         5q4U9tfXUnUZGqA7mMtEQxXju4iIdDi0QhDdPaCdo0YZqM2M99+ic/2xAi04rAbFuIQO
         YFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PSugutdgZSALIH5CXLgm4RzKdZBqE7drYLdKtUlGTdc=;
        b=Zi3SM7rc3m3VjGjqM9spobwqvcfs6Ec4eaKSoVhl4cAiwDv+uwGvpcAd3qBgG3quqs
         xdPiLpPYswYYUAXTLVtDdEefkDEWIct5OWPsrK26cSt2n+MGLUb1ejo1u+8WptDxWQPq
         MXYnp1HFpUZOGlbbHhRcLMbJjuArOeuj9kpRhYKg/oSClhpw0j/Fmy2ohqCuyksF5I1v
         Cy8IXG3aQaef8dO3tgq1WEyIz13qr5X7H8e16pmqLQ4WuHKaF9lp4SXyd1TNIP4u8ylR
         X+zl4vNd9U2bubBY+55/2MfhgG64e+oEQ0sjS5cIA+OpooXxGzbLwwQttMWBZqAQbYQH
         c7hA==
X-Gm-Message-State: AOAM532SWSS7zGEw0QcxfBtvgDJBsfgLV6Vd8XJGeULc4LgCEo8uWIWC
        N497Is6HlkQGX7zjxztpFpg=
X-Google-Smtp-Source: ABdhPJzzfrce7t/hOTCqeoYPb6NFotOX9qyOjdU/f1pMFXU/uZK4AvUEhCxBIzDsG0gBakT/uqml1Q==
X-Received: by 2002:a0c:8ec1:: with SMTP id y1mr19789157qvb.11.1616395413738;
        Sun, 21 Mar 2021 23:43:33 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.40])
        by smtp.gmail.com with ESMTPSA id t24sm8463192qto.23.2021.03.21.23.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 23:43:33 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] RDMA: Fix a typo
Date:   Mon, 22 Mar 2021 12:13:22 +0530
Message-Id: <20210322064322.3933985-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


s/struture/structure/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/rdma/rdma_vt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rdma/rdma_vt.h b/include/rdma/rdma_vt.h
index 9fd217b24916..d6611f2dd6a5 100644
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -245,7 +245,7 @@ struct rvt_driver_provided {
 	void * (*qp_priv_alloc)(struct rvt_dev_info *rdi, struct rvt_qp *qp);

 	/*
-	 * Init a struture allocated with qp_priv_alloc(). This should be
+	 * Init a structure allocated with qp_priv_alloc(). This should be
 	 * called after all qp fields have been initialized in rdmavt.
 	 */
 	int (*qp_priv_init)(struct rvt_dev_info *rdi, struct rvt_qp *qp,
--
2.31.0


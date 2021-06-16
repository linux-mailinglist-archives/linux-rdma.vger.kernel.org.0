Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9A3AA567
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jun 2021 22:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhFPUjz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Jun 2021 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhFPUjy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Jun 2021 16:39:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34438C061574
        for <linux-rdma@vger.kernel.org>; Wed, 16 Jun 2021 13:37:47 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so4732936pjz.3
        for <linux-rdma@vger.kernel.org>; Wed, 16 Jun 2021 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrtKJwOXcfXSraYG3l/8W3KAWUbCghKJ8Syne5pByVc=;
        b=iF+1pCLx6umkhmrOAcWineq6AgsZj+LTiUtKMdk9TLN9SbKTPUe6+gtiOsm5561erp
         cOe5L+aytGUt1/xGAYxg7IOudEnG3cC4eBl1WhXytVcUKktZjC5I8E50EEYozzjLhb+I
         LT+5dsi2BimMrns0/2UiAvjj7L32JD9QenGvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PrtKJwOXcfXSraYG3l/8W3KAWUbCghKJ8Syne5pByVc=;
        b=BAwfcQS38sf5TrEWQPgmmNcSXIjiCjmuiYO+zDQmxkozDpP44793dTlrVgcVk3FBcF
         26+4klAOuFfqqhUqVOOBeFCKXqtH4TJcsZfKtAZBmoU1BXFB6iC3HhfW9Sai6ip9PEV7
         J2gv1li8TLg/XPzueeFNRnG8YZgfZy8a3MOWeQUcWCcHhJZqNxdG0eaate2MdacIdufd
         Xoa2c2bkk6myXSr3FN7pHq3jbNFh1d3mpaLzdGLPQU4Z/eIwYPj34tZGtud1+bZ4M/lF
         B+5zlsFdMazb7cEhvD7uU0uV07AdNZwEtycPD4SgYWVpfa/3+gJyg8qBetykMpJ3hB63
         cShA==
X-Gm-Message-State: AOAM533QycJS0YgSgxb/nFmrommCGx/VWedM41E+OSrQ1U87JkibtBAT
        ClTilabCXoGSfzutxYxLKTzOZw==
X-Google-Smtp-Source: ABdhPJzllVr+3TM7LwFPMfdLpS02YpwPWbxeaC3ybvt6EQXrCac8flhKtnj3aq9ZkTt2eqWPbMRMfQ==
X-Received: by 2002:a17:90b:358b:: with SMTP id mm11mr1635406pjb.223.1623875866780;
        Wed, 16 Jun 2021 13:37:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p15sm6641206pjb.45.2021.06.16.13.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:37:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] IB/mlx4: Avoid field-overflowing memcpy()
Date:   Wed, 16 Jun 2021 13:37:44 -0700
Message-Id: <20210616203744.1248551-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=cd8ffb35e914232a0c080415b069a036911d3651; i=IU2NWQYKtuynzfrSLXaQGqkOftycINwXSwyl1Wa7yRs=; m=k4bOsoSdgGMwjhphTNjc12U6ACDoo0QRe0PbNbsxyVs=; p=SbdI3Bt6Us1lKDeHmv3nIAwGJSGvxehinrxYbH9Ls4U=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKYRcACgkQiXL039xtwCZSTg/+JGP byL2pf/2hEZdu+eUNionarfCtwpkJF6dD+x7eBbkFdCPcOZSyow7NtwN+157sD9N9gIoyhEFPxMag FaZ3i5Oqa0B4Nyvi/GC2gRK8RtJaQlKxuCSKtc9KsRKeePDUI90CnXiJBy/AmXvUEpVSnl7YCO05r ShMvNuQeW1yC3hWpjlqNNhynPfLImHL/OgmH+vNm8UMoL+6kR+5Z8irreC4y3kp1YtVCpyqWlyp9q UoymG5UMTzG9zUkKcbYcv5akzYFe9upHqU55xC7e/AFuK1dyZsaVGUJVhQLI8HHgJQ9VOs45cgTTl sIPP2rrWjPT3CfjihGNmttjcxM525hi39sWkQvfqOU8satDX+tX1ejxHd7UzXWEzILFkwAX6dzs55 UKwvsiq39Mf3srNxVB4nrlEOltkOtLZTtvMIU3pIgQfFt3O6lvZnZ2lgQ2fTA5nHJlI/EbfF1Dror DWUlkCn5C6oVXIStBIKC6Fx0hOfwLmz7aeri1C9RDP1bO3N3q/iWqhMjjWdRjMzZeK/4zNFdtEJOy HV+u0oPgM+fynHg/LqMWl5G750ogLAZ+AflR4+BI1/v4O+S0BSz3rmXpfA0K+5V0KNYLdh+ANpxV/ bxgJbAf1DNa67TzcNkVPWHsnmf6iLb6eFJHwf9+MhH4+v8zVtJa/z0NwX4VNbbIk=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring array fields.

Use the ether_addr_copy() helper instead, as already done for smac.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/infiniband/hw/mlx4/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 2ae22bf50016..4a2ef7daaded 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -3144,7 +3144,7 @@ static int build_mlx_header(struct mlx4_ib_qp *qp, const struct ib_ud_wr *wr,
 		mlx->sched_prio = cpu_to_be16(pcp);
 
 		ether_addr_copy(sqp->ud_header.eth.smac_h, ah->av.eth.s_mac);
-		memcpy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac, 6);
+		ether_addr_copy(sqp->ud_header.eth.dmac_h, ah->av.eth.mac);
 		memcpy(&ctrl->srcrb_flags16[0], ah->av.eth.mac, 2);
 		memcpy(&ctrl->imm, ah->av.eth.mac + 2, 4);
 
-- 
2.25.1


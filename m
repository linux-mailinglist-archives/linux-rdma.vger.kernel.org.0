Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF45C2AA0A8
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Nov 2020 00:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgKFXDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 18:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbgKFXDc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Nov 2020 18:03:32 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4CC0613CF
        for <linux-rdma@vger.kernel.org>; Fri,  6 Nov 2020 15:03:31 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id j7so3095366oie.12
        for <linux-rdma@vger.kernel.org>; Fri, 06 Nov 2020 15:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlNFT/rjAKkfWpn1aQcIjWfjsPx8ypZBPndEkye3Ikg=;
        b=k95SyFuDNMOHohB1Ex2B9KEk4obxnIFpxWennut3Jy4E3sRLI2suwgGjAGNJRM3S1F
         GqTc11a3Pvk48hhKQDjdAK6V/NTo94XUqn7TOhkv59XrGlDvE6VWnCmy34+aZOFUV1Vq
         XjkD1UydL9/OOyqqhqYbDlX1jOC8QDB3cQXNMDiztY3FVqlMErN08lg7OpkcGhswOldR
         Z18qt19tPZRWHIl8sTJLOaZN/Q/RqErB8I97XYFuYpj5P2Yf/lfLXvvbTPC4EQRcJUYI
         +0kpuF+qD5lejSSLcImYLNYDsnBvtYwSYhJZE8bnLTnxSiTCzGdCFuU19ME/frqUdd6q
         AsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlNFT/rjAKkfWpn1aQcIjWfjsPx8ypZBPndEkye3Ikg=;
        b=eXTHBNjZ7uhhWKGsQX/Obivvn+IyUMw6p99TouyovIC7+Q2uEl6/eNOwNb/LHsSRKd
         e8ZoRJcEbjkLb4VkQJ142Gu0XcQ1SrjPaXaOP295yPBhfEV+wkMctZicKogmy7iaf7JP
         bFcKFAh5fKJ9kpeSaJW3h97QVz90YVNjC9N7BWUp5DxWJyY+PZhTqgZjcoxLMbEeJPjp
         iEDZMVevJjHnuCRrRWItMe18LqGel5CmZx3YtEyoolQgkpvAT8A0JhGQkKU7Pbg9jXQt
         l7aMb0CIqjGZBtJQfEJpEYQrzqbhkFxSyJK0LKrv8I74NXjNUYWiqtWaXsBrDAs+qXu4
         Iv/A==
X-Gm-Message-State: AOAM532LntJW6m3N3zSM/o1YDq6/uHexAFFPwKUzZ5yG+96gkmR88j1J
        SzyZUN1OypDtBvUnElEdWTJ7mGrf/hU=
X-Google-Smtp-Source: ABdhPJwMZo+QCmIXMNAY2jEdzeLYh8/IvM+SeJIO42BLXIPukSHR+pjWeD9Tu3i3h8ECnC+1vqltfA==
X-Received: by 2002:aca:4c91:: with SMTP id z139mr2587389oia.117.1604703810716;
        Fri, 06 Nov 2020 15:03:30 -0800 (PST)
Received: from localhost (2603-8081-140c-1a00-f960-8e80-5b89-d06d.res6.spectrum.com. [2603:8081:140c:1a00:f960:8e80:5b89:d06d])
        by smtp.gmail.com with ESMTPSA id y35sm648994otb.5.2020.11.06.15.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 15:03:30 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH 0/2] RDMA/rxe: Implement extended verbs APIs
Date:   Fri,  6 Nov 2020 17:03:17 -0600
Message-Id: <20201106230319.17477-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series supports a matching user space patch set:

	Provider/rxe: Implement extended verbs APIs

Together these implement the following erxtended verbs APIs:
        ibv_query_device_ex
        ibv_create_cq_ex
        ibv_create_qp_ex

They also implement the field parse and set ops in struct ibv_cq and ibv_qp.

Introduce a pair of SW capability bit masks that are exchanged between
the user space provider and the kernel space driver during the
ibv_alloc_context verb to allow the provider and driver to adjust
shared data structures depending on which capabilities are supported.
This is an extensible mechanism to avoid changes to ABI version.

Bob Pearson (2):
  RDMA/rxe: Exchange capabilities with provider
  RDMA/rxe: implement create_cq_ex verb

 drivers/infiniband/sw/rxe/rxe.c       |  2 ++
 drivers/infiniband/sw/rxe/rxe.h       |  2 ++
 drivers/infiniband/sw/rxe/rxe_comp.c  |  9 +++++-
 drivers/infiniband/sw/rxe/rxe_cq.c    | 19 +++++++----
 drivers/infiniband/sw/rxe/rxe_resp.c  | 20 ++++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 46 ++++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 15 ++++++---
 include/uapi/rdma/rdma_user_rxe.h     | 43 +++++++++++++++++++++++++
 8 files changed, 132 insertions(+), 24 deletions(-)

Signed-off-by: Bob Pearson <rpearson@hpe.com>
-- 
2.27.0


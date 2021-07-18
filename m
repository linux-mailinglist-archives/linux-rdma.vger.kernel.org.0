Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F323CCAD4
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Jul 2021 23:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhGRVag (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Jul 2021 17:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhGRVag (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Jul 2021 17:30:36 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1051EC061762
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:38 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o72-20020a9d224e0000b02904bb9756274cso16195226ota.6
        for <linux-rdma@vger.kernel.org>; Sun, 18 Jul 2021 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YQacgArEqfF7a1jsdVI4PzVNx5cf51pLSMFO4emwAYc=;
        b=VlHcv8sJu57xk9XYIJ0/1s4RPmsJv0laPFCEFzSM9rJ8vQCKCphT7VZ3nKZXC7+f8T
         AE2r71uYq6jRVsrVhaSuWy4DFT/MB4IwIlmof9G0pIEo+8ewXsGTh0czTCJtL7TFccxu
         c1P+xJvwfrJino4os7NsIY2hMvfv+2uh+grHoOQyJFMIwY5Rthox6ywn40zPNsRbF5dL
         7XirBy6CfgNAbuJSl+sHnxFHFLov+y287HTSkqCwx/DN5xwrtEgEuo44LCUD6RWmDXFL
         czqu7kEWQ9wFCn93zwKAL+mQas51mo9IQTfX0SlK2KqKiBetnGbr+kIkGeEm9feGgEOi
         Eqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YQacgArEqfF7a1jsdVI4PzVNx5cf51pLSMFO4emwAYc=;
        b=tkxr+lxawfP54uDuAEW+rZs858P/dz5VfyIjeGIqDM+4pZX2n6EOU0DU+TxUb8q0pl
         d2A5uYXJxQOfbayv6xFojlZgNcWZ8oXn3dFcg86rTlL6gMHurZQXR5vQhXrnkK6Rzblb
         OBw7zIxTS4EB0bi33/tVB9sjTvg0oFbJkJHBm2krtsya+Oa7MKbaLc2826g4d3C3BSEe
         iNREknHt7qNeUmKMy2YtbIRcQQHbct1f1xdxVhHzVWmpK7NEI8MHhqdmzZuhrYyMz3CP
         bO6ntKmka1z0ogS9yS0TE2pxn4KOUihE+ojGJ0pyyex0RGg7prDX5i2m/sIodElShgw8
         4x0g==
X-Gm-Message-State: AOAM530geq3wM3X3+hN65Hx4nWFaPYRdejHRq61iOmR7RuXTgBUIC0le
        Vk5G4K2fF97zFdzXUMRmiW4=
X-Google-Smtp-Source: ABdhPJx9E7Ba2N7JakZAO+t4WHi/kZgl+CAMo07TYNUlwrrhp+AJV3JVld5jmpyCVGef6iMKqDfjKg==
X-Received: by 2002:a05:6830:1141:: with SMTP id x1mr17238605otq.104.1626643657446;
        Sun, 18 Jul 2021 14:27:37 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-0284-9a3c-0f8a-4ac7.res6.spectrum.com. [2603:8081:140c:1a00:284:9a3c:f8a:4ac7])
        by smtp.gmail.com with ESMTPSA id t10sm3242900otd.73.2021.07.18.14.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 14:27:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 0/5] Replace AV by AH in UD sends
Date:   Sun, 18 Jul 2021 16:26:59 -0500
Message-Id: <20210718212703.21471-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rdma_rxe driver and its user space provider exchange
addressing information for UD sends by having the provider compute an
address vector (AV) and send it with each WQE. This is not the way
that the RDMA verbs API was intended to operate.

This series of patches modifies the way UD send WQEs work by exchanging
an index identifying the AH replacing the 88 byte AV by a 4 byte AH
index. In order to not break compatibility with the existing API the
rdma_rxe driver will recognise when an older version of the provider
is not sending an index (i.e. it is 0) and will use the AV instead.

v2:
  Rearranged AV in rxe_send_wqe to be in the ud struct but padded to the
  same offset as the original preserving ABI compatibility.

Bob Pearson (5):
  RDMA/rxe: Change user/kernel API to allow indexing AH
  RDMA/rxe: Change AH objects to indexed
  RDMA/rxe: Create AH index and return to user space
  RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
  RDMA/rxe: Convert kernel UD post send to use ah_num

 drivers/infiniband/sw/rxe/rxe_av.c    | 20 +++++++++++++-
 drivers/infiniband/sw/rxe/rxe_param.h |  4 ++-
 drivers/infiniband/sw/rxe/rxe_pool.c  |  4 ++-
 drivers/infiniband/sw/rxe/rxe_req.c   |  8 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 39 ++++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |  8 +++++-
 include/uapi/rdma/rdma_user_rxe.h     | 14 +++++++++-
 7 files changed, 83 insertions(+), 14 deletions(-)

-- 
2.30.2


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0A13D2F08
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 23:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhGVUnF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 16:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhGVUnE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jul 2021 16:43:04 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DD4C061575
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:38 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so101898ott.9
        for <linux-rdma@vger.kernel.org>; Thu, 22 Jul 2021 14:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vjrKEVbgCZ0aezxH2+LG9GQm+EQJL38sfPP0A5OvlI=;
        b=uw2nc6tZAPYV1ZRKRSCfq2OOGg+UGZw6EptoW9eNJaoqh3isS2Sg0OBNU3E5N3zbx6
         NHKWzDQNSLImoAMx+9o0Jxr4QBr5BUX24taPa52Oz0i3mdSVjntnpfjWDdPrZLcR47N8
         6SNSSg3z7FGsGYO5DaMmqSTtYe1rR65kjJEiXqaLqJXyBO8rHe2x9AffZnIL6Mn+KdLk
         2Bq/5gU7VQq4cFn9hjqou+FQDtuP7d6uMl88nWU52Xh54djo5bT1KKaB+9HIoPYeDdmY
         E0oPa/Umava0wKPX8fSCKV95tYRsYymCkH6wL3zAv5b+3xKENT1JpNcxl+VZCY7jeBvH
         dDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vjrKEVbgCZ0aezxH2+LG9GQm+EQJL38sfPP0A5OvlI=;
        b=DqnXqi1MsWdwKACOVYKa9n4xy2jVvqjkkqeK7Y4sBhmm+HQ4mbpWFCjPFCZhDHk3Vz
         K5R/NirTEBZlmKvgbLOjcNPojoRvEgvtZhkd+963y8A3X56d+puWJ3qxWKyJKiF6SsWf
         As1BfajpUOBkdWFVCUcpvAfyy22y29PaDeTt+O2HgjGxoa616OqwiDbIyqZMgKPVVmaE
         nXrl1p2yJdnMbe2Q2310HDNziLbB0guOjzg4x1SYaCSIFoDrmQk9wYLKn5qFGiYnoEbW
         eIvOL/dh/M3vhfkWwKLVOJ5auyClveZmDcs4iInnFoPjJK58yDa4M0tuWsYte5NguDKq
         swPw==
X-Gm-Message-State: AOAM531XSk+2LbE4HzUIlxJZ++hFCQTmedvGo7o8iYWcMh+HHw4RxADi
        6t8nR3uYRnEbVQvihNq0LZQ=
X-Google-Smtp-Source: ABdhPJy/4NNnXY1t66c4H/8QfzcX5D8DsNfpS7xaLAQHOSJlaID6tLzNiojp2TphsTQALxTHuc9QgQ==
X-Received: by 2002:a9d:4813:: with SMTP id c19mr1147021otf.208.1626989017731;
        Thu, 22 Jul 2021 14:23:37 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-d50d-298a-08dc-a5ed.res6.spectrum.com. [2603:8081:140c:1a00:d50d:298a:8dc:a5ed])
        by smtp.gmail.com with ESMTPSA id z18sm2714872oto.71.2021.07.22.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:23:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 0/5] Replace AV by AH in UD sends
Date:   Thu, 22 Jul 2021 16:22:39 -0500
Message-Id: <20210722212244.412157-1-rpearsonhpe@gmail.com>
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

v3:
  Split up commits into smaller steps.

v2:
  Rearranged AV in rxe_send_wqe to be in the ud struct but padded to the
  same offset as the original preserving ABI compatibility.

Bob Pearson (6):
  RDMA/rxe: Move AV from rxe_send_wqe to rxe_send_wr
  RDMA/rxe: Change AH objects to indexed
  RDMA/rxe: Create AH index and return to user space
  RDMA/rxe: Replace ah->pd by ah->ibah.pd
  RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
  RDMA/rxe: Convert kernel UD post send to use ah_num

 drivers/infiniband/sw/rxe/rxe_av.c    | 20 +++++++++++++-
 drivers/infiniband/sw/rxe/rxe_param.h |  4 ++-
 drivers/infiniband/sw/rxe/rxe_pool.c  |  4 ++-
 drivers/infiniband/sw/rxe/rxe_req.c   |  8 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 39 ++++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |  8 +++++-
 include/uapi/rdma/rdma_user_rxe.h     | 10 ++++++-
 7 files changed, 79 insertions(+), 14 deletions(-)

-- 
2.30.2


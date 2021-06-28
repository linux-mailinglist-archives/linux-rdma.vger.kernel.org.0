Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63D83B6ABD
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 00:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbhF1WEw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Jun 2021 18:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbhF1WEA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Jun 2021 18:04:00 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7560C0617A8
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:32 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s17so23881686oij.0
        for <linux-rdma@vger.kernel.org>; Mon, 28 Jun 2021 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hy9697HPZ2wYUVMnDYQblXf0pkIdhFnEYN5UKpG/ahI=;
        b=iJBy71mNQNK68zNoX2urAA1YvQzxbtXD9q8tZsaaoWhZQjqg484Ba9pwV47sPiR1sQ
         QgLSAfOPJ/HMZmlkcl48bQ93wgJ2evVMC2vhBOV0e/mf/83uEolrdARv0bjwUGmJZVhW
         Y4tlAGzSeyirQba/sh8IUsXUiwt6KKIqiOHXCDUaIb7ykOJZ0hDnI9V7DLSGmgJ0EfIn
         05fwoI4X/A3lokRFLslJnkfBMsgK6DIDnIGPrCMwQUBh4FeNc7E9opOnbA3B7kHd9g9+
         XmeRoodzK/q7q50QmRlfi2IwUECTCpO5kdMFn03C+vwooAmOFewjPn/akS9tjWpz7Ib1
         Oymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hy9697HPZ2wYUVMnDYQblXf0pkIdhFnEYN5UKpG/ahI=;
        b=XX5MQcNjlpQ0lMgIV85ruRggVby7xnb6jOkySo0bTSU+9STpx8JlRyhPsitdE+M/gZ
         mIi46KIJdU8oE2unm8AEjeAQ+Ry7n26GatHhxQ++mVBliBNnbm0QwODudWaFOi1l9vVZ
         lAvrRMVVybAIUrfQWawM/RtQM3XPTazCjzGwOZHVDkMbL1qUiG75spR+vM9brseOh4QD
         PumaxZRin9AtowgcPXilNzcLn/0Q//VDaNAnmfl27ZUL8x4O1r/Woz9/6qn0jv4ixQ3j
         Fj3K5PD6gkqYMYZQipYufANUA17Mwxk68rl0JN5VIVscwttCY7yJRuptmF5xWml/20gp
         ShOg==
X-Gm-Message-State: AOAM5302yo8E3Z34hKohXLfCnDeko245BPUxhyzhLjTQ8tKoLE/9RKG0
        tjPYJgNLXaroDRQhBC/UJ4Ms9MOXQfk=
X-Google-Smtp-Source: ABdhPJzDFSfwR3sEc1Hm+q6J5HrxeoqR+We7o94zFuI9UIv55XKkdIRfIc0yg19sCEe8e+0UCifEZg==
X-Received: by 2002:a54:440d:: with SMTP id k13mr3547261oiw.178.1624917692319;
        Mon, 28 Jun 2021 15:01:32 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id s187sm3507195oig.6.2021.06.28.15.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 15:01:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/5] Replace AV by AH in UD sends
Date:   Mon, 28 Jun 2021 17:00:39 -0500
Message-Id: <20210628220043.9851-1-rpearsonhpe@gmail.com>
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


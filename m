Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B413DAE9A
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhG2WBU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhG2WBU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:01:20 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B62C061765
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:01:16 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id c2-20020a0568303482b029048bcf4c6bd9so7383759otu.8
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ez1xWTFaNoHNdEfXpsQ4GPt1UScCtC7KmrJ9EeJ1psQ=;
        b=OvDYLTXLSH4hwwgT9n2UFLudJEttd0VB1jJA1bWpUEtvYhuFFBSL7LLWYxm4/SRIZw
         R2v4TxOrc9+h1pZPk8Year3XRMTZEwL206UCGzIYECQEcWPz0s5vRgdQmFmdLId38p3j
         TfI+/X3uFLatVsSrXbWEjEsQaOwh3yibe+hfHZ5bdJ6SArsCkayO4vUXww+eLuBu/SNQ
         qqg9VeuU9LS5+dKWGgNw0PFoJ5y4vxAb8ZBBmseSDA2g40X54GiabEMLzrZzgjfOxyNd
         5GrYK//b6UkP5tO+QPQ1Nq7FNBodQEDvRbiaBqxqiMXSWZVNcacRG3uk/HczDjXfsnSu
         svXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ez1xWTFaNoHNdEfXpsQ4GPt1UScCtC7KmrJ9EeJ1psQ=;
        b=KMuqYnKj886s6lZMNKgwyXrGHeWiTwzsIS4En4VTv6OyK/jPtZYMZdSMdooJgZrw4i
         wqQf5YAiQUs2OFgY12oWqMe2jXK/7QCkC9WRGqvWwKqfMleA8xPo+a76LDxw5x7X9jjq
         xIBw6qgHuhFDXJj1lnHqXoz1nquY1ff/OacfG1OLJy8oZHHmNkjH+Y/wzoiQPasxjz9i
         ZG3L9ay0jxNDXJ7fBlwvgk2Sv/DdaOBT5/PqMvWpvaA3Jn1kXj5XFMRmBDK2TMsCzdDT
         gHqCpiU3cZzofqtEwY/brArE7agoCgmJ4+VyDdk5f/zOumKaxL+WzS434aZmCCcBYNpu
         XX8A==
X-Gm-Message-State: AOAM531lta+cPLpAH+T+bO7fC6Ia8jzy1GhAsW1pKnRrJtwV6qQkPJtX
        WrGem1lNodN6nG1SiyF/2JU=
X-Google-Smtp-Source: ABdhPJxA+zSLt584hL0kVXz4xXGPGSJyJNGc58JsfjnI9b3wigP5DA9dwGXX/mEXIhcFFvrlUxvJHg==
X-Received: by 2002:a05:6830:440f:: with SMTP id q15mr4984327otv.349.1627596076130;
        Thu, 29 Jul 2021 15:01:16 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id x16sm716628ooj.1.2021.07.29.15.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:01:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 0/3] Three rxe bug fixes
Date:   Thu, 29 Jul 2021 17:00:37 -0500
Message-Id: <20210729220039.18549-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These patches fix three bugs currently in the rxe driver.
One of these was released earlier. In this v2 version two other bug
fixes are added.

Bob Pearson (3):
  RDMA/rxe: Fix bug in get_srq_wqe() in rxe_resp.c
  RDMA/rxe: Fix bug in rxe_net.c
  RDMA/rxe: Add memory barriers to kernel queues

 drivers/infiniband/sw/rxe/rxe_comp.c  | 10 +---
 drivers/infiniband/sw/rxe/rxe_cq.c    | 25 ++-------
 drivers/infiniband/sw/rxe/rxe_net.c   |  1 +
 drivers/infiniband/sw/rxe/rxe_qp.c    | 10 ++--
 drivers/infiniband/sw/rxe/rxe_queue.h | 73 ++++++++-------------------
 drivers/infiniband/sw/rxe/rxe_req.c   | 21 ++------
 drivers/infiniband/sw/rxe/rxe_resp.c  | 40 ++++-----------
 drivers/infiniband/sw/rxe/rxe_srq.c   |  2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 53 ++++---------------
 9 files changed, 57 insertions(+), 178 deletions(-)

-- 
2.30.2


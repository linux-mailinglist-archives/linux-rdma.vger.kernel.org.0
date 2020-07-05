Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AABB214BDC
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2020 12:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgGEKna (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 5 Jul 2020 06:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgGEKn3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 5 Jul 2020 06:43:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE1C061794
        for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2020 03:43:29 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so37692021wrv.9
        for <linux-rdma@vger.kernel.org>; Sun, 05 Jul 2020 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAnSE69HLKvVrZ8tNK1c4+7mpfBblUkvb2Hz/mNWCDE=;
        b=OLpqqu0aFJBWI89ThdokpW0NS+1BSPQQP+8d1a6iDj4q5we5HUXc6TPffQHt2y/Y1g
         m/c/5UyeJlMFSHoTpZAn8T2DJf44mdjH8OPHHAgQY0Ws9cIbk9JoQXeqFC/wbkSt+i5y
         86m+HDUUXqwGbx4bIy5/o1bfL296IulSBjRn8/4QgDrxAvYSpoRnFY1xyvoBWaQtD+to
         slwQTq8Pf2dl20LP20scL1hqM0Ka7vZXsTPdNL3DqNE7QTMaEnRvvfJBZDUlqsclHvBJ
         M+Au51RO3OCduv4P87twBkbVu/uKHD6/JFU3ZtONYLxRSAsOsmfZXeGehbj8G0z94fQn
         jrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sAnSE69HLKvVrZ8tNK1c4+7mpfBblUkvb2Hz/mNWCDE=;
        b=fppPisx2YzstdK6JneXQJQzPbbf6CLuwoO0fbfVha/0Wqn9fp2cdpjvSinyyD7rziG
         oBJBXiqWNEydcQa1YAGyEeT2bJ/1T4uMZ8TF1Yl977YugEjR7PRwgB3sBSjPMTdcSShO
         ywt6sDK087GneUHLDTwhPXQ9LaQ/ucaO0VB37G3W5u7dnY/fixvGQtkO4+tPo9faovfE
         SLtKrhL5gfY/BnOx2lCqpU1AAYfTdGERsgoLJ63+tFePclk3+2YteLIVm1L8a87MSH+e
         bKqfPBvbc/L9ZSRKWTbRKxxAJam0iEaMZJdoKDqoyEpDhFjeBMtW6t5PJ95l1xQxqFfg
         /rKA==
X-Gm-Message-State: AOAM532Xr0zPMzYS2Y6hnedoDvNLwZUguN4XzQm46NdgtbdMeZ6oedkj
        xvvVf9SAcecXvbn93ab3uCJ9im/DfxQ=
X-Google-Smtp-Source: ABdhPJwapyx4TOaSxTqhsbdxcy4J0iCwvndR5ZIjC5fOo546ksYHpUVAwH5yofLgIIXgj0J363fUrA==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr43477707wra.165.1593945807648;
        Sun, 05 Jul 2020 03:43:27 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.100])
        by smtp.gmail.com with ESMTPSA id 51sm14828083wrc.44.2020.07.05.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 03:43:27 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next v1 0/4] RDMA/rxe: Cleanups and improvements
Date:   Sun,  5 Jul 2020 13:43:09 +0300
Message-Id: <20200705104313.283034-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These series include few cleanup patches to the rxe driver.

V1:
- patch #4: Fix commit message.

Kamal Heib (4):
  RDMA/rxe: Drop pointless checks in rxe_init_ports
  RDMA/rxe: Return void from rxe_init_port_param()
  RDMA/rxe: Return void from rxe_mem_init_dma()
  RDMA/rxe: Remove rxe_link_layer()

 drivers/infiniband/sw/rxe/rxe.c       |  7 +------
 drivers/infiniband/sw/rxe/rxe_loc.h   |  5 ++---
 drivers/infiniband/sw/rxe/rxe_mr.c    |  6 ++----
 drivers/infiniband/sw/rxe/rxe_net.c   |  5 -----
 drivers/infiniband/sw/rxe/rxe_verbs.c | 24 ++++--------------------
 5 files changed, 9 insertions(+), 38 deletions(-)

-- 
2.25.4


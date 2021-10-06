Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5097342359F
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Oct 2021 03:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhJFCAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Oct 2021 22:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhJFCAO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Oct 2021 22:00:14 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3FC061749
        for <linux-rdma@vger.kernel.org>; Tue,  5 Oct 2021 18:58:23 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id x124so1859622oix.9
        for <linux-rdma@vger.kernel.org>; Tue, 05 Oct 2021 18:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UwC57tZE/bEDnlouylKeU3XMtZXNne/yoduPsEd/MZQ=;
        b=Klcog+jONy42C+mijUNDNDGxywc7vLebZdjW+7Zvo299VspXFYf2t1cVncW1p6U0+k
         NsBId3DdYP0O+bAO4lIWwKMt9Yn02WPz+ndeu4NNcMIkdFuCstdqorQqmPFrtgIwQYzS
         QK7OiMHVTMgxJvwpxgYqTRAG5EZpVs3uYg7HaLA0CCZLZ0YjwNbQ1utW70VBC7a4QKK+
         bkJED6mrsN5XbYwXHhvBsccmuS4H28/Y5dO4kKkNqWa2xN4yJJGLyyORsvFunNpwYoVS
         T0HNhCkmDZ8KEO6dTIG5JodyiBIClGpA6P3AEv/6X/idHyT+j7UJsem1+IDJDZ3kVEWF
         l7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UwC57tZE/bEDnlouylKeU3XMtZXNne/yoduPsEd/MZQ=;
        b=hgBx7Sm70KqRcNfv9VdECXNv/kYlKrbAfWQOYRLKsoJiELdkLCeiOpt39wFficGNlN
         gl5YVxsvQgpEAckwZq146uFHbthFsIBBoSj1SzGyVebjyEJ06ok0dvEZtDspvvNWgzTC
         IogWQ+d5pE0Z2SPS1l7w8NSHN0qy8+dVFoNGESzRaBcRIo1UqQabWSALfzgQg3vq/mkg
         PZslywMs6WBtkPXH1NK28TZwBRNlhIknkUjzt4/iYbGUwgXmojXfzyLYjTcyXVZiRhfX
         fwBgxZzwLMB1cuyF67KkM8snDYzAkV8aPh0iboNGAxajZpeE8cVA1U02WiZsXD2nquOh
         n0tQ==
X-Gm-Message-State: AOAM5320UwAZGSTjD9BtpRpo0MEXdJf7cP5DKwcCd86p8RA2lOXgt75M
        qFSRsbl4LaaM6iUYCd1FdLM0PH+Snb1UFA==
X-Google-Smtp-Source: ABdhPJz4WQDBFIvMe5V0YycKXzzI3QtNW1o35vgIDcsJ4tuskFP0QxxUqp/0nXPH0x3TY/b51HdZhA==
X-Received: by 2002:aca:dec4:: with SMTP id v187mr5147646oig.5.1633485502546;
        Tue, 05 Oct 2021 18:58:22 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-2b16-c5f3-6fcc-9065.res6.spectrum.com. [2603:8081:140c:1a00:2b16:c5f3:6fcc:9065])
        by smtp.gmail.com with ESMTPSA id e2sm4016057otk.46.2021.10.05.18.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:58:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 0/6] Replace AV by AH in UD sends
Date:   Tue,  5 Oct 2021 20:58:09 -0500
Message-Id: <20211006015815.28350-1-rpearsonhpe@gmail.com>
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

This series of patches is identical to the previous version
but rebased to 5.15.0-rc2+. It applies cleanly to

    commit: d30ef6d5c013c19e907f2a3a3d6eee04fcd3de0d (for-next)

---
v5:
  Rebase to 5.15.0-rc2+

v4:
  Rebase to 5.15.0-rc1+

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


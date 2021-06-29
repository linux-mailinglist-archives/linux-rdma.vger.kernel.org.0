Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964793B7953
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 22:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbhF2Uau (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 16:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbhF2Uas (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 16:30:48 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C2DC061760
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:28:19 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id a5-20020a05683012c5b029046700014863so109378otq.5
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfod7HpNKKoBqyzUJR00texQLqumkDgWlD1JrHw5r/c=;
        b=Wt8jXJlhQgsC+0on5Bl8Su8M8wk8edKphn8ejxiGintnGEAXuI1OcQsTwjgWoxjtTT
         QfjwnXq9UhkBNvlqb4cxc5wOD1Ds/qmQxLcdxjQgVCGS3vy1bpRS1KFWldCXS6NK05fA
         ELThr+2hiCx9Q4Tlnn+T5GAW6NwRPCuOdROyI2JoUrjg3qb/+8JyRlcgcxF+grAXHLAV
         WNjkMpFJZlZOe70RetJhbraTemsr/JOvouoRLADFFtl8x8KBuMfzNpkUHyhwjXLIxp8u
         sbMwpepXY4+Z1Mx2QQUdKBh7ssNGv/4Vo9mRf//ERZ8ZmWkDyWwTSQI061SxgRMNPQWg
         gsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfod7HpNKKoBqyzUJR00texQLqumkDgWlD1JrHw5r/c=;
        b=JGoIzYBTdrbHkKO/2YZK7r+iLHwh+POPuR4Br+aXFhV3iQLOn0yttqamSE1x21S0C2
         zxFyUhcDDJeFILgHrS6M1JDrPZy5sRLNWVcm3cKhzWPaSH3xDcNWqVMir1Pb6bYmsgQ3
         2SmxlECVytFZkcXkKhNZNO1ddrzdG7KrVFQQBDHZACjJmLQCO1kprImrzKMf228szYtG
         wI2XN4+BXbWMQU2XNPtvu1VvRoOUQ7Sxx4N32aVAJIYtHAsNyMzz+4DEHiUQxjfGb54I
         QwoHL9fP9qjIkh2eg57oOfUroiIbg1qp8Vzu+WH6uTxd83OEx/8KHtTz2uW439YPwkMv
         0Wfg==
X-Gm-Message-State: AOAM530qV2JXgO9KZI8Xs/WtU4c18LG38GpOarigB8zyTcEHT1rdu7X6
        9LfMuqzOAoWEIzz3by9PKkg=
X-Google-Smtp-Source: ABdhPJz9DdkEZDZooOU1db712qKrz5qJoalica8Fkh748IgeogSYcIk7PtKwNp+IGR2PZLZ2g9f22Q==
X-Received: by 2002:a05:6830:1e83:: with SMTP id n3mr6106967otr.49.1624998498743;
        Tue, 29 Jun 2021 13:28:18 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-2b92-ca20-93cc-e890.res6.spectrum.com. [2603:8081:140c:1a00:2b92:ca20:93cc:e890])
        by smtp.gmail.com with ESMTPSA id m8sm3576866oie.33.2021.06.29.13.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:28:18 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next resending 0/5] RDMA/rxe: Cleanup ICRC
Date:   Tue, 29 Jun 2021 15:28:00 -0500
Message-Id: <20210629202804.29403-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches cleans up the code in the rdma_rxe driver that
handles computing and checking of the ICRC checksum in RoCE packets.
All the ICRC related code is isolated in the file rxe_icrc.c.
The overall performance is modestly improved. (ib_write_bw loopback
performance is increased from 2.7GB/sec to 2.8GB/sec.) There is no
change required to the user space provider.

Bob Pearson (5):
  RDMA/rxe: Move ICRC checking to a subroutine
  RDMA/rxe: Move rxe_xmit_packet to a subroutine
  RDMA/rxe: Move ICRC generation to a subroutine
  RDMA/rxe: Move rxe_crc32 to a subroutine
  RDMA/rxe: Move crc32 init code to rxe_icrc.c

 drivers/infiniband/sw/rxe/rxe.h       |  22 -----
 drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c  | 136 +++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_loc.h   |  61 ++----------
 drivers/infiniband/sw/rxe/rxe_mr.c    |  47 ++++-----
 drivers/infiniband/sw/rxe/rxe_net.c   |  62 ++++++++++--
 drivers/infiniband/sw/rxe/rxe_recv.c  |  23 +----
 drivers/infiniband/sw/rxe/rxe_req.c   |  13 +--
 drivers/infiniband/sw/rxe/rxe_resp.c  |  33 ++-----
 drivers/infiniband/sw/rxe/rxe_verbs.c |  11 +--
 10 files changed, 225 insertions(+), 187 deletions(-)

-- 
2.30.2


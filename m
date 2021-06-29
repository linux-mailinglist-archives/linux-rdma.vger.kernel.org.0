Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA9E3B7928
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 22:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhF2UQo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 16:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbhF2UQn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 16:16:43 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5F7C061760
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:16 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so53179otk.7
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfod7HpNKKoBqyzUJR00texQLqumkDgWlD1JrHw5r/c=;
        b=PHfg/1QLUCBk0aJtXQKkKtlBauY5xcCHmp5KkzxlISWO/+T2Dn4UdleBLuvjOYtN0G
         +4vT4e3wORHZ05PQnVZ3fS21g6YYO4YwqZoyOGibM+5rLP+AyciwAtw/m2O9VwCpwrvH
         FVGiAhi0uwfEzZdnAwnNIVX5ipx5+sdXyD0elHh4vjiwvtnCu4S+6n23EtAre+ArhD95
         HoHlb7LAiiTMaDpGG0XtSAsC+KUCvauik3y++fYYsbBEZGFsBgSZh0/mweShoKwAZv6B
         +mRn81h+NOa45LoR2kGfQcY+iv8IXint48pmgKRxa+R0IGW8j5hBGUP+ufMZ/qyob+oK
         GiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yfod7HpNKKoBqyzUJR00texQLqumkDgWlD1JrHw5r/c=;
        b=sFsH1qepnOOROUjxbLZH7ld36VD+KWAovgtOrTwGpdGNwedHAkW+HSrsXZDup7odLh
         +acZIrF7RwKk0GiSAVESzdBTX5QakNL8A1DyA7sZa7zAeEPrDdoLHoZylq+YcrNGbJCX
         wic4W7g9ZmdUW4SssoQN6LffyZ9UVf5zWskDplG0cv7NUpPCMxbLaXcdHddOaQXOHTjy
         /h38fDsJ9sMJrrpnew56DdJI/Q/RXKE3xJLngwfHLk5h4qoK6kSQd8WL6YkZwoDRKTwa
         gxZlePhY/+5QQiGVSNCbWF8MZ0/nlYJGks4EMq6SPSqGkOrLAXyuX61muj12E7M4sgI7
         k89A==
X-Gm-Message-State: AOAM531eQxoPgocl7HOWZ2ZqozO7pFMW9ccb5r4al0RBA4Dv+B2jjc39
        29Oa05FYKmg75OfoMjlKKhw=
X-Google-Smtp-Source: ABdhPJx/J0P8Fs0fW7pgyZTyfDzW7YlQBnZLYzopL3Qkw5iXt4m/+3Y3PTct1YBpqt8OOEL2n69bpA==
X-Received: by 2002:a9d:7102:: with SMTP id n2mr6108321otj.87.1624997655758;
        Tue, 29 Jun 2021 13:14:15 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id 59sm4399689oto.3.2021.06.29.13.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:14:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 0/7] RDMA/rxe: Cleanup ICRC
Date:   Tue, 29 Jun 2021 15:14:05 -0500
Message-Id: <20210629201412.28306-1-rpearsonhpe@gmail.com>
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


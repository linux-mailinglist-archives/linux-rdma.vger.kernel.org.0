Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E257AF4B0
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Sep 2023 22:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbjIZUFS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Sep 2023 16:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjIZUFS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Sep 2023 16:05:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9CF136
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 13:05:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d8141d6fbe3so14776298276.3
        for <linux-rdma@vger.kernel.org>; Tue, 26 Sep 2023 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695758709; x=1696363509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LUHQqKLA03cvxOqIb9LV+319kkd0FdCrPANHPM/IRTw=;
        b=atLFwbr8blVejomJeCh4lmIxX20DbV2RNAqifweKxAWRvnZExZjZrAw4c31yp0sInI
         k2Hxy3zQagyqWF2rNcnY093lwRXKqSU94jdl1tb/lHJNSgc6KJZCVmEDBtACX+3RtX5G
         Y6t8S3aIZJ0R1KvnNPmlwJJ4XmU+XFr25Wy2y3xy6l0SNA1QIT0X5LaFaZRqfOr9Bcbi
         hAxZPer1LDuotdMLhHuR4h+7lWENJyHmJ5RQ+nCamGDs/YI0eFAAMg3ner6O1UseAx77
         hwR9F7FEDxieu6VbJniVZ9nA/XvlLgwVHTtpwGBV19bLXmn+bTnETagjXvy+tlbgBUIp
         RkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695758709; x=1696363509;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUHQqKLA03cvxOqIb9LV+319kkd0FdCrPANHPM/IRTw=;
        b=YUrfssnRpE25xc9913MAcMq9OVLex+K9QA+HCPDXMR/0LVPKWfBfmC7TzwzlzHDCgH
         17VtFsFKqkVNK27SC4mb2iL6Bj1ho9RUGWG6L58L2ds6b5gtCl3zJqdVzq3sjFsBu3OC
         43LIoiFSiiyCZUT6C6CQZg+6yBKfSRn6AE/BWBgCU47njx3oHjQY18Nf7pN6PXauISf3
         PBCiP2Nz85cBvm5HmSj+IDqi1EZEh9RGc0thSOjeEmhOvBIGYvkSoE+j2NcVH0IPFhPC
         IDx4rcs1g7NZs1MOBz4XqdaqjcOGbO2xR1dCk5a2W9V1y1nSqWHrAMFO2+lieBKDyAk/
         oGcw==
X-Gm-Message-State: AOJu0YyUErCkE0KhYo97rAGIHWesiJj7O2SCx5/GhM2YSO2sHuEeFUpI
        gcydoRbJwHkzx14yOgD7By0UD2vaHw==
X-Google-Smtp-Source: AGHT+IHiar7acMg7OZkqRteQy8u+g7Q3fC4ZlZH6+0avyWJDsbyt98fkghdeToG/rJkXrrHt5fTNug6bGg==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a5b:752:0:b0:d89:4d2c:d846 with SMTP id
 s18-20020a5b0752000000b00d894d2cd846mr52999ybq.12.1695758709189; Tue, 26 Sep
 2023 13:05:09 -0700 (PDT)
Date:   Tue, 26 Sep 2023 15:05:02 -0500
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230926200505.2804266-1-jrife@google.com>
Subject: [PATCH net v6 0/3] Insulate Kernel Space From SOCK_ADDR Hooks
From:   Jordan Rife <jrife@google.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        netdev@vger.kernel.org
Cc:     dborkman@kernel.org, horms@verge.net.au, pablo@netfilter.org,
        kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
        ast@kernel.org, rdna@fb.com, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, coreteam@netfilter.org,
        netfilter-devel@vger.kernel.org, ja@ssi.bg,
        lvs-devel@vger.kernel.org, kafai@fb.com, daniel@iogearbox.net,
        daan.j.demeyer@gmail.com, Jordan Rife <jrife@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

==OVERVIEW==

The sock_sendmsg(), kernel_connect(), and kernel_bind() functions
provide kernel space equivalents to the sendmsg(), connect(), and bind()
system calls.

When used in conjunction with BPF SOCK_ADDR hooks that rewrite the send,
connect, or bind address, callers may observe that the address passed to
the call is modified. This is a problem not just in theory, but in
practice, with uninsulated calls to kernel_connect() causing issues with
broken NFS and CIFS mounts.

commit 0bdf399342c5 ("net: Avoid address overwrite in kernel_connect")
ensured that callers to kernel_connect() are insulated from such effects
by passing a copy of the address parameter down the stack, but did not
go far enough:

- There remain many instances of direct calls to sock->ops->connect()
  throughout the kernel which do not benefit from the change to
  kernel_connect().
- sock_sendmsg() and kernel_bind() remain uninsulated from address
  rewrites and there exist many direct calls to sock->ops->bind()
  throughout the kernel.

This patch series is the first step to ensuring all socket operations in
kernel space are safe to use with BPF SOCK_ADDR hooks. It

1) Wraps direct calls to sock->ops->connect() with kernel_connect() to
   insulate them.
2) Introduces an address copy to sock_sendmsg() to insulate both calls
   to kernel_sendmsg() and sock_sendmsg() in kernel space.
3) Introduces an address copy to kernel_bind() and wraps direct calls to
   sock->ops->bind() to insulate them.

Earlier versions of this patch series wrapped all calls to
sock->ops->conect() and sock->ops->bind() throughout the kernel, but
this was pared down to instances occuring only in net to avoid merge
conflicts. A set of patches to various trees will be made as a follow up
to this series to address this gap.

==CHANGELOG==

V5->V6
------
- Preserve original value of msg->msg_namelen in sock_sendmsg() in
  anticipation of this patch that adds support for SOCK_ADDR hooks to
  Unix sockets and the ability to modify msg->msg_namelen:
  - https://lore.kernel.org/bpf/202309231339.L2O0CrMU-lkp@intel.com/T/#m181770af51156bdaa70fd4a4cb013ba11f28e101

V4->V5
------
- Removed non-net changes to avoid potential merge conflicts.

V3->V4
------
- Removed address length precondition checks from kernel_connect() and
  kernel_bind().
- Reordered variable declarations in sock_sendmsg() to maintain reverse
  xmas tree order.

V2->V3
------
- Added "Fixes" tags
- Added address length precondition checks to kernel_connect() and
  kernel_bind().

V1->V2
------
- Split up single patch into patch series.
- Wrapped all direct calls to sock->ops->connect() with kernel_connect()
  instead of pushing the address deeper into the stack to avoid
  duplication of address copy logic and to encourage a consistent
  interface.
- Moved address copy up the stack to sock_sendmsg() to avoid duplication
  of address copy logic.
- Introduced address copy to kernel_bind() and insulated direct calls to
  sock->ops->bind().

Jordan Rife (3):
  net: replace calls to sock->ops->connect() with kernel_connect()
  net: prevent rewrite of msg_name and msg_namelen in sock_sendmsg()
  net: prevent address rewrite in kernel_bind()

 net/netfilter/ipvs/ip_vs_sync.c |  8 ++++----
 net/rds/tcp_connect.c           |  4 ++--
 net/rds/tcp_listen.c            |  2 +-
 net/socket.c                    | 36 ++++++++++++++++++++++++++-------
 4 files changed, 36 insertions(+), 14 deletions(-)

-- 
2.42.0.515.g380fc7ccd1-goog


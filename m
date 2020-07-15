Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C0C220F02
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 16:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgGOORL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOORL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 10:17:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E36C061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls15so3138316pjb.1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BUujrJp/fLBUqdhVh6MGt9MqY3XGPAqH8rPeP0da008=;
        b=DsXRNbpINrw5epzvR1DU/pqGz5fzG+bfHXbe89aQ35SpMpihdIwC2mgXE86HWeZPWQ
         juei1X/6BUIjxW4mV/XX6yi4/yKrRsDqfCsqaNTNG8xLjjMvl6E/VE4yTM/sxsN9cXZU
         QEGnsDjqkci7YNUJeYAGIDj3itxxRUwBZ7xz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BUujrJp/fLBUqdhVh6MGt9MqY3XGPAqH8rPeP0da008=;
        b=j3Y+vCxEF7STKLdm/kK9rNAUr9T9yLvuna3p2830p4c7U80VCQAZW33lL3gKwKkdzy
         0a5JxALFMUnao+Z6s0LSksD108w+UW+IyHqW2X1E019GCUn5gOeamqzJu7BDSxlF1GU4
         RyF8hLQuRokiqdHaCUFkjBweIpY92llC5cB2ruzvn8207tGAU01zPY7fgXC3/cPqQ4H8
         /ong3E30R5RoJdM74wZYAS4s6qFMkXhbnfvp3buEqsJIODigWLgaEATeEljUr+1HMyzv
         FA+7yrCHUXv8+WQ07Lmqz5MGCqe22P7UzPr+zEoJuQmZZEl/LayTT7hfZhbJIH+F59Ov
         H06A==
X-Gm-Message-State: AOAM532l91zt1BoIojO/4eO7V7Oc7FwsXuR8WKvPSFit4bbWn1AvxKRv
        /X4bUGcTBbCj1Ya4AMoF0DMzmFe1Qr9UJ8umRSR09LEhJk11Oo4mzRSwJIQZCHFMyWZ5mqd5812
        LmxeOHbmkbQegJSk41+lgxsID8teC0gE6C5BrPERQ6u6RYN/1R/AEpOHtywLrMb2ecNi26wTGLa
        vTTwQ=
X-Google-Smtp-Source: ABdhPJwjSITtu3T6XVyFe1xvVR+yxi+LdNUs0Vk4aRO8gC+mU1BHl/B2VnWEGuycecvSxVjaDhsKqQ==
X-Received: by 2002:a17:902:c142:: with SMTP id 2mr8746237plj.222.1594822630191;
        Wed, 15 Jul 2020 07:17:10 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k92sm2399254pje.30.2020.07.15.07.17.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:17:09 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     devesh.sharma@broadcom.com, leon@kernel.org
Subject: [PATCH V2 for-next 0/6] Broadcom's driver update
Date:   Wed, 15 Jul 2020 10:16:53 -0400
Message-Id: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series is mainly focused on adding driver fast path
changes to support variable sized wqe support. There are
five patches in this series.

The first patch is taking care of passing wqe mode through
driver load sequence. The second patch is moving cqe polling
logic on shadow queue indicies. Patch 0003 0004 and 0005 deal
with changing post-send/post-recv to accomodate changes.

The last patch 0006, adds a new co-maintainer's name.

link to v1 series:
https://www.spinics.net/lists/linux-rdma/msg92678.html

Changes V1 -> V2:
 -- Splitted the first big patch in 5 smaller patches
 -- Dropped ABI related patch to address the review
    comment from Jason and Leon.
 -- added new patch to update maintainer's list


Devesh Sharma (6):
  RDMA/bnxt_re: introduce wqe mode to select execution path
  RDMA/bnxt_re: introduce a function to allocate swq
  RDMA/bnxt_re: Pull psn buffer dynamically based on prod
  RDMA/bnxt_re: Add helper data structures
  RDMA/bnxt_re: Change wr posting logic to accommodate variable wqes
  RDMA/bnxt_re: Update maintainers for Broadcom rdma driver

 MAINTAINERS                               |   1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 168 +++++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   8 +-
 drivers/infiniband/hw/bnxt_re/main.c      |  23 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  | 751 +++++++++++++++++-------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  | 127 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  58 ++-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h  |   1 +
 8 files changed, 743 insertions(+), 394 deletions(-)

-- 
1.8.3.1


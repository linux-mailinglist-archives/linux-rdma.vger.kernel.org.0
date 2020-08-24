Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F808250735
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 20:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgHXSOs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHXSOs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 14:14:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1911C061573
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:14:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ep8so4625294pjb.3
        for <linux-rdma@vger.kernel.org>; Mon, 24 Aug 2020 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Yo5fgoL38qY9ld0NVn+tJEbRCPqpNMYxzV8wWL0RZ/A=;
        b=R2qzYjolSvBEgJYRo5itH2W627FpbWFy/lYNNVX7FZR6MfAh9BKKTRfMQ1Kn7cJxpu
         JJkxvj0PlBD4+z5iJfNAhY4X+1BjdPlddDitntJkKsj8Sm6NyZYn8GGcdm7rdC5bHGNu
         dtcmtZs8adHDLv2QVGRMdePyIes5fSr+tftL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yo5fgoL38qY9ld0NVn+tJEbRCPqpNMYxzV8wWL0RZ/A=;
        b=kHqK34X4j8Jd4tC1IAwwTDRZwq4a2NpJC42RvdvpHKPPCRWvGnt5dKiLYP05mObwjB
         I9EowZEk5M8IfsrvjElTX4FmQKhbfAiQF2YPeLl6xmpYCqBiqFWgl76PmzlCGDgdssTW
         9ppsZZwx9Wz+zoV5EuDHXqgkHNNYHIZD/jMDIuUL+n/wCZFkT0MnvOvcKPQ4IYfl9NTe
         Sd71Hc7wzvGFxJY8I1cin2GZGjfS9rRKnn1/7vLV3efpAbZJucU0eVnfsXJhs3yiVX9x
         fjg/ef2e25bp43shawPCJiCMRjqlPs++wO8S8TRQvosmdc5TZIncEcIANV4TIZcVFggg
         1Eww==
X-Gm-Message-State: AOAM531wR3gBr0qYGNguYi57ya/8tnmgU7XH+slf/wwbX3afwDMWkXCT
        61tMB0AOORLV7hLfZ0S9tEzjCw==
X-Google-Smtp-Source: ABdhPJzpPaEBuZSeVoVxOizoKUpWu8UtCv36yJMGXC9bYbxVm8ETM/kA8YNznUWFKE72FdDhLqd/WQ==
X-Received: by 2002:a17:90a:8817:: with SMTP id s23mr434406pjn.158.1598292886986;
        Mon, 24 Aug 2020 11:14:46 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q5sm5027811pfu.16.2020.08.24.11.14.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:14:45 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc 0/6] RDMA/bnxt_re: Bug fixes
Date:   Mon, 24 Aug 2020 11:14:30 -0700
Message-Id: <1598292876-26529-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Includes few important bug fixes for rc cycle.
Please apply.

Thanks,
Selvin

Naresh Kumar PBS (3):
  RDMA/bnxt_re: Static NQ depth allocation
  RDMA/bnxt_re: Restrict the max_gids to 256
  RDMA/bnxt_re: Fix driver crash on unaligned PSN entry address

Selvin Xavier (3):
  RDMA/bnxt_re: Remove the qp from list only if the qp destroy succeeds
  RDMA/bnxt_re: Do not report transparent vlan from QP1
  RDMA/bnxt_re: Fix the qp table indexing

 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 44 ++++++++++++++++++++----------
 drivers/infiniband/hw/bnxt_re/main.c       |  3 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 26 +++++++++++-------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 10 ++++---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  5 ++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  2 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h   |  1 +
 7 files changed, 60 insertions(+), 31 deletions(-)

-- 
2.5.5


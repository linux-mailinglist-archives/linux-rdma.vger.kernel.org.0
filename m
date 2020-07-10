Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B5F21B7C8
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 16:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGJOGF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 10:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGJOGE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jul 2020 10:06:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8874DC08C5CE
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 07:06:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e11so5301961qkm.3
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pvmdFI2AGfZJlO6x/TXlOljUa8Gk5ZnU6HDh2u7HTNM=;
        b=hVbbexFfEQdDHQ2wmL3Ky4bvfutu4muDfwl8sObPRB9aUxjWlYW7SQxBDQCw3k9ThX
         +zeexdyJKExi59xyjUXwvEwxF9llCe0oXO0va3P0RUB81z4EzCcCBGVNlB2jWQZ5bAH+
         GPCSMTGIAZ3Lsjq8fpHbWuL4peWguEPHQ5QHFfQA04bTRUV4CzLzXW5M7x6Wgj1ckdcF
         ejq+9z7u1ngtjC12tRsxWUxl6p0Q1+qJS/ft+85aC5Jph6Edl1MVxrmK5cvLke+fSGyD
         zeF17o/6JjDIsqVuB5NNjNsYA7nN9HPy5UKEHsmWciwyQN8LyppEZKm9zHE71DKk/hcx
         BVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pvmdFI2AGfZJlO6x/TXlOljUa8Gk5ZnU6HDh2u7HTNM=;
        b=J+FCn0opDuNPdhM+loB3Oe2Agb3f4xzovwDVdH/nG7IbfRhXYvDfZRYYHEuvJcArNN
         wpE6Siz6yDkTpEpKja8Xzls+bjk3N7CYay8mqB7l795K4QTrGtLm+Iz+udlK0VsjMGnv
         r1J8YFl+/P6BK8xBvffEjyrGX+xIFo9YjEAr9UKSmviAGX0tNL03kDTa7nMXJORGmaGU
         3KhwBxnIac4Vs65Mf/9Va0qv0xkHysdJifaSZyj7gyylaFKNCKXLDAbkZ6vjbqJF5L8v
         ntCZuGXtVJ7bbr9ltJ/Oa3iMOLvFWuLjjgxfa0ULrfIN0sj2jpGzxM8RtV8lYh3F4nyO
         pzGg==
X-Gm-Message-State: AOAM530VCNj2ZMTm2p3sLLPZtS7MUo1brTUN4QOFUYm4i1UJL/h26Nmr
        WMdr4ufzZVlyGaqdjjmx710=
X-Google-Smtp-Source: ABdhPJxG942/WNkp1Lqix5hR5mlaH61GYK21Kzj5rcS/qjR28uB9acI9bClgdZPtPhjKW9i2r/+FGQ==
X-Received: by 2002:a05:620a:571:: with SMTP id p17mr54520422qkp.482.1594389963752;
        Fri, 10 Jul 2020 07:06:03 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j45sm7112380qtk.31.2020.07.10.07.06.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:06:03 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06AE61dt012314;
        Fri, 10 Jul 2020 14:06:02 GMT
Subject: [PATCH RFC 0/3] IB CM tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     aron.silverton@oracle.com
Date:   Fri, 10 Jul 2020 10:06:01 -0400
Message-ID: <20200710135812.14749.4630.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi-

This is a Request For Comments.

Oracle has an interest in a common observability infrastructure in
the RDMA core and ULPs. One alternative for this infrastructure is
to introduce static tracepoints that can also be used as hooks for
eBPF scripts, replacing infrastructure that is based on printk.

As an addendum to tracepoints already in NFS/RDMA and parts of the
RDMA core, this series takes that approach as a strawman. Feedback
is welcome!

---

Chuck Lever (3):
      RDMA/core: Move the rdma_show_ib_cm_event() macro
      RDMA/cm: Replace pr_debug() call sites with tracepoints
      RDMA/cm: Add tracepoints to track MAD send operations


 drivers/infiniband/core/Makefile   |   2 +-
 drivers/infiniband/core/cm.c       | 102 ++++---
 drivers/infiniband/core/cm_trace.c |  15 ++
 drivers/infiniband/core/cm_trace.h | 414 +++++++++++++++++++++++++++++
 4 files changed, 476 insertions(+), 57 deletions(-)
 create mode 100644 drivers/infiniband/core/cm_trace.c
 create mode 100644 drivers/infiniband/core/cm_trace.h

--
Chuck Lever

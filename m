Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642EB2467BA
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 15:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgHQNxO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 09:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgHQNxJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Aug 2020 09:53:09 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08EFC061389
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 06:53:08 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j9so14513580ilc.11
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 06:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=COmI+0uVYCIdlmlrlWbAetby5K/wKl5uT12kuaBhEFI=;
        b=LF4dl/AZEQP9+tSyuhqaoOopPF0mnRVoJS60xEeRDurAUtKi5W3s4HOWeXQEALz7pl
         gH/OOgIPrBIJ/eHBIr/R231Hadk98hX1uNMUvYBIhKKeui5gjKlTsenBxHpcAY8ucYd2
         wme3vSCBsFdt0HXw33gtsAqUuq/Hcg0JBDjZpokkeprqSTQST6Bq9ujw66NSf5Yu3H72
         j+RneK61FB5E2dHyYwq2EdjaitYFo9MfsYd0j7JOwVIjYIkEwq6yBLpESGkRYFWHSq+R
         sH1kgUMWprE76KwC8ppQzop/86MSdCKrokcV+u+qMOz8nHUgIcNd9Cq/CMSZd4WTmIfC
         hdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=COmI+0uVYCIdlmlrlWbAetby5K/wKl5uT12kuaBhEFI=;
        b=Am/jNGHsTRI4DKjPGoI/KQvtmmBLDAgyq02l47i2xtKlNI4OhdGUJ/RmlGJaFl5CJP
         5/MWUhPyKW6bmuFZLZkDnxw2TuwV7uU9I9G6Y8TojB2zkblgzj77INlOv8oV819Uv0Oa
         pCwHZdYzvkFcMiTP9tLCZ41mOdisE0emcBCytqbORcGtyWHm9D/uSJSmM59evvIkc7wT
         un6LrddGH/um4WqpNYvPEf+dueb4vIaCt2AVjzHo5SKnueRngeIEh4We7gRLofq7HXsy
         FTPyi2iwHw1A68TQVyiu9IVQFcIROuiS5+zFZQpFOBX7Hghu5y9J6v5QUboj9Zdw/UBe
         Qpaw==
X-Gm-Message-State: AOAM533E3pissnyPLn/yahbaF5DC4oM5p5hd0HPb87l8PIecwo9SUIwo
        kUmQnRqAKRn1magQRCOnCmNpTsCPhxxGjA==
X-Google-Smtp-Source: ABdhPJzvw8RLTBeqO2ZG4dSk8Ddnkpths9QP3sS/eeoUKPekGlWgoBwiKpyL5u3TNToFTUOjRLbmtg==
X-Received: by 2002:a92:9145:: with SMTP id t66mr2989954ild.305.1597672388001;
        Mon, 17 Aug 2020 06:53:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p18sm8930724iog.1.2020.08.17.06.53.06
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 06:53:07 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 07HDr56x004678
        for <linux-rdma@vger.kernel.org>; Mon, 17 Aug 2020 13:53:06 GMT
Subject: [PATCH v3 0/3] IB CM tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 17 Aug 2020 09:53:05 -0400
Message-ID: <159767229823.2968.6482101365744305238.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Oracle has an interest in a common observability infrastructure in
the RDMA core and ULPs. Introduce static tracepoints that can also
be used as hooks for eBPF scripts, replacing infrastructure that
is based on printk. This takes the same approach as tracepoints
added recently in the RDMA CM.

Change since v2:
* Rebase on v5.9-rc1

Changes since RFC:
* Correct spelling of example tracepoint in patch description
* Newer tool chains don't care for tracepoints with the same name
 in different subsystems
* Display ib_cm_events, not ib_events

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


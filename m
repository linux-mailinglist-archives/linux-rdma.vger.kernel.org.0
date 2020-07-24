Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07C222C432
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 13:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgGXLPS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXLPR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jul 2020 07:15:17 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB6EC0619D3
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 04:15:16 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so5057268pjc.4
        for <linux-rdma@vger.kernel.org>; Fri, 24 Jul 2020 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/oKrDIDPZyvXhYv2Z3Ye/gPNMoaJVZ1pUP6p08ISQGg=;
        b=S072VyD5Rugm+i2wmN2lfW7iUHCo7lZEh+Z6K5pMdWs2C1u/1eZzDk0Kni96shlPt0
         pPgSr7/fRwj92uL8G/LJ6wGW+tRKsIyH1kJwDzxUK27b8+c+nNfbB6Lv4TY9LXeQg9rX
         iikb9mTilpfg6SJhDKLjf910ZQPbGMQc+db8LKvhey5nNkr7UZtetqBAET75wSOoRxkM
         boaf188VXjIx6kFUSyVP6L9LkE8YaXQtQUuzfk2mnuuRCdkD3aUZ3dbp/X81QU2E7GcF
         6/0xE+A7SDgYZYX8/cht7W1BaCrhD0GHLaNVVuUYVbnivPq6W0CTtNy9UPBjlkOeVntV
         QHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/oKrDIDPZyvXhYv2Z3Ye/gPNMoaJVZ1pUP6p08ISQGg=;
        b=O7MvbEYd0o/4yHG8g/p4L6yVU2XZYmP/gzs+z5fqOxiX8DZiLcYlnSCh8A85E4e70m
         AsSiSK2qKIlEenSZLD14fVSqp0CdEOpXS3nC5sKqU+LT14GU2H2EO7/4QUOc0DqIJgz7
         qE6fwWUhm8kQRD9ZJwTux2Kb/6eMQ5hDxef0Ao+a/bSQ+PVpTKcZ+KJODzxjEG1XN2EU
         oYtZDv2TX/YbxFqq9MK2EEv9ufALGLq0F28TJ9joRFC2Yp9jyNKb1NX51MBM5UWsjPba
         zCwrgYDdV51NzUqo0L9lY8m0A45eR2ZJRNO5i2Lkf1jA179FyYMglEPWTWXIQI7BnKbK
         h/hg==
X-Gm-Message-State: AOAM53017n+2tYi/AGE//xucPXCPSfZ2/uil+pBVN1+IvEL0BRRKKrsL
        ojPR55OVF7As0Deu50uCiqhLYg==
X-Google-Smtp-Source: ABdhPJzlO0fYKAvQ8WcYg/kKcR/xoPnUf06JFl1y5ItahsGbwF7oMamKLj9dWApU6Lv2gWOO0P6iBA==
X-Received: by 2002:a17:902:c38b:: with SMTP id g11mr7578889plg.340.1595589314415;
        Fri, 24 Jul 2020 04:15:14 -0700 (PDT)
Received: from dragon-master.domain.name ([43.224.130.248])
        by smtp.gmail.com with ESMTPSA id y7sm5569643pgk.93.2020.07.24.04.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:15:13 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, bvanassche@acm.org
Cc:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Subject: [PATCH 0/3] Number of fixes for rtrs
Date:   Fri, 24 Jul 2020 16:45:05 +0530
Message-Id: <20200724111508.15734-1-haris.iqbal@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series fixes a number of issues discovered while testing

1) RDMA/rtrs: remove WQ_MEM_RECLAIM for rtrs_wq
2) RDMA/rtrs-srv: only call put_device when it's in sysfs
3) RDMA/rtrs-clt: add an additional random 8 seconds before reconnecting

Regards
Md Haris Iqbal


Jack Wang (2):
  RDMA/rtrs-srv: only call put_device when it's in sysfs
  RDMA/rtrs: remove WQ_MEM_RECLAIM for rtrs_wq

Danil Kipnis (1):
  RDMA/rtrs-clt: add an additional random 8 seconds before reconnecting


 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 16 +++++++++++++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c |  7 +++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.25.1


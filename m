Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36A024C7FC
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgHTWsG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbgHTWr5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:57 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D79AC061386
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id a24so3330256oia.6
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rzR9cHIhazX55fFFxlkjzQIMVS8rN7XKrhxxI7S8ck=;
        b=CY0KWpli6U5Lhn97CuUit885GanBd8iDYBH3NDlCD7sISls/n3H2KNXWccYaelzmTD
         i/B49TGVhCJAuHn6UdGMpFtEa7z3QHC87uJd5CvjmctusYL1ZUCazyxZogI0POHSccfv
         HSpPnE7mr/baM306465Fr/o/XSU5ODb9GVphW4xd4UoLRFHLJd0pEmGFIJ8CNyEPwFLf
         rvs8PSwTt5xZeegibzaB18XiWVEiq2Bv6rq06sXw2dlzE9j62VU9s5pohlw5hUnK12Ub
         Kcb3mfw9EdFKd6PaZ/w3X8NXHtQkgFinAdh3dr0ARhUeBXluhL5rDq/Dyj4QexzrQY6i
         q2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/rzR9cHIhazX55fFFxlkjzQIMVS8rN7XKrhxxI7S8ck=;
        b=cQMXwaf83V4BlfkCiZlbaNRE6FxLnwNEkKe4v2OtT4vDiTdOIBKkwf1QPjYygIJYW+
         jttA6MmIujh0oxqPR4ANyW+d1xPOdyn1hXrYjaKBLesyAS8GA56LLBXB4adOXfpwTjSk
         nU2C+BkO2xJcXLNIwBMZQChrB5vuvTfoQnPaiqUhJn98eBNiCFooG1csLTm7RQv8Gyoj
         H9HFY8K5wSxeRRl/e23Vyoet3VW08l0PlzONbcztqn+6i8TrNrXjzd8R9TH+c0KERru2
         qsagZXMinG1fgCM6IqNBeXOH2HX1LleCbeoDkRcOL7wCDQBMwvO/DhnmAUSDTAMHLLgi
         T3kw==
X-Gm-Message-State: AOAM533Tomg6YAuA1VN2OLLpRzJhj5Hh0RgyJUknzcWNUhDJooxFSf/b
        Ug3x1Q9zZGixv9MTE2rdGiw2HPyYBXaTOQ==
X-Google-Smtp-Source: ABdhPJyxEQGCMygwesZt+c+rReICtmwYlGrW/RjthirAby4CkZd/LlM1gs4w/qIzQ2wnGXJ/e6wdDw==
X-Received: by 2002:aca:504f:: with SMTP id e76mr16012oib.87.1597963675987;
        Thu, 20 Aug 2020 15:47:55 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id 63sm11860ooj.32.2020.08.20.15.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:55 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 0/1] User library support for memory windows on rxe
Date:   Thu, 20 Aug 2020 17:47:50 -0500
Message-Id: <20200820224751.3286-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch extends providers/rxe to support memory windows
operations implemented by the matching kernel patch set.

The only difference between v3 and the previous version is the use of
--cover-letter in git.

Bob Pearson (1):
  rdma-core/providers/rxe: Implement MW commands

 kernel-headers/rdma/rdma_user_rxe.h |  38 +++-
 providers/rxe/CMakeLists.txt        |   2 +
 providers/rxe/rxe-abi.h             |   4 +
 providers/rxe/rxe.c                 | 293 +++++--------------------
 providers/rxe/rxe.h                 |  44 ++++
 providers/rxe/rxe_mw.c              | 149 +++++++++++++
 providers/rxe/rxe_sq.c              | 319 ++++++++++++++++++++++++++++
 7 files changed, 613 insertions(+), 236 deletions(-)
 create mode 100644 providers/rxe/rxe_mw.c
 create mode 100644 providers/rxe/rxe_sq.c

-- 
2.25.1


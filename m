Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE248616E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jan 2022 09:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiAFI2C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jan 2022 03:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiAFI2C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Jan 2022 03:28:02 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38113C061245;
        Thu,  6 Jan 2022 00:28:02 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h6so2012195plf.6;
        Thu, 06 Jan 2022 00:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ovdWEOIwOQl7tDC0VgvgzUNl9Susr9y8QnlWeCAszQ=;
        b=H6QvabZCAGMlTJT2sjTh2fqTtOEWhoOLYea+6fezZt+TYF/KaPnaQJzu3KAZPsG0eC
         8hlQI4t1lNen+B34oo52/uUtjLbVBMOQF35fS/U195Wu4V8u5XHCt23pQat7Vbh/Xb92
         Pf+iNL0Lv2G9oYWTRvRMsqYNrDgXy6MvuJDD2gccpyvQ0Nld2pHC7aMO9s7UyNu7CjmS
         3RRlA/bBOZsBJl+dQLJjLQMYPGJ1SH8qrPMo8fBU1LZK3ROS3NyPbKhViusUJg6I0zhj
         hdPNlID0BJNjVj6UM4sptDGoTHl5nawFpQN7URa5Y5AYWPwlQS13l2+/TgIUbCgZ6hQy
         Fs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ovdWEOIwOQl7tDC0VgvgzUNl9Susr9y8QnlWeCAszQ=;
        b=juA2SOUmxBBICjDCfZQMHPfc9QMmBg4tk9xztrSZGj3KvUmlr3aZ/tW32878DnBjJ9
         7p9ycR3DjdOudP69dOs09d6NMhtHpZwL3N2FX9YOeBrjTRss6gQ27Bhbk2JMOvH8OpjR
         qyVrNo+I/ALibDUOeIu1WOo+xiTOhWCxJJAcQk2LLIJCZyymk7b8zxz3vxZwUrGJM+qg
         dndsXHDYY/HpQS8Xr2g+U/b6HFD4zwCRhSJpACi783cQ9w1W8SYgneUrmOAS/vWU6MP+
         BDfncUO6Kj9yNq72i3m+VBJ3DybpA0wrxb4ZGYft69WJDvd6NZRSj2jq+AeWzKpeg7GD
         wezA==
X-Gm-Message-State: AOAM5310X619gdnZbQZU1C4WrW0QX4n52Q/f1r59DsfiOidpa4hlm3dD
        ag9b1eNnOT3hugtLXlLstXpmasDKSPbVMA==
X-Google-Smtp-Source: ABdhPJzKufMkr7XgSVUGeY4g/Yn+9Eo4frLHqaG95/TL+4XALyN9YEqG8PmXxMedzxLO8xoIRu3BNg==
X-Received: by 2002:a17:902:b082:b0:149:f81f:a29c with SMTP id p2-20020a170902b08200b00149f81fa29cmr539964plr.39.1641457681751;
        Thu, 06 Jan 2022 00:28:01 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.151])
        by smtp.googlemail.com with ESMTPSA id k3sm1230817pgq.54.2022.01.06.00.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 00:28:01 -0800 (PST)
From:   Qinghua Jin <qhjin.dev@gmail.com>
Cc:     qhjin.dev@gmail.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IB/qib: Fix typos
Date:   Thu,  6 Jan 2022 16:27:22 +0800
Message-Id: <20220106082722.354680-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

change 'postion' to 'position'

Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
---
 drivers/infiniband/hw/qib/qib_iba6120.c | 2 +-
 drivers/infiniband/hw/qib/qib_iba7220.c | 2 +-
 drivers/infiniband/hw/qib/qib_iba7322.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba6120.c b/drivers/infiniband/hw/qib/qib_iba6120.c
index a9b83bc13f4a..aea571943768 100644
--- a/drivers/infiniband/hw/qib/qib_iba6120.c
+++ b/drivers/infiniband/hw/qib/qib_iba6120.c
@@ -3030,7 +3030,7 @@ static int qib_6120_ib_updown(struct qib_pportdata *ppd, int ibup, u64 ibcs)
 
 /* Does read/modify/write to appropriate registers to
  * set output and direction bits selected by mask.
- * these are in their canonical postions (e.g. lsb of
+ * these are in their canonical positions (e.g. lsb of
  * dir will end up in D48 of extctrl on existing chips).
  * returns contents of GP Inputs.
  */
diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
index d1c0bc31869f..80a8dd6c7814 100644
--- a/drivers/infiniband/hw/qib/qib_iba7220.c
+++ b/drivers/infiniband/hw/qib/qib_iba7220.c
@@ -3742,7 +3742,7 @@ static int qib_7220_ib_updown(struct qib_pportdata *ppd, int ibup, u64 ibcs)
 /*
  * Does read/modify/write to appropriate registers to
  * set output and direction bits selected by mask.
- * these are in their canonical postions (e.g. lsb of
+ * these are in their canonical positions (e.g. lsb of
  * dir will end up in D48 of extctrl on existing chips).
  * returns contents of GP Inputs.
  */
diff --git a/drivers/infiniband/hw/qib/qib_iba7322.c b/drivers/infiniband/hw/qib/qib_iba7322.c
index ab98b6a3ae1e..ceed302cf6a0 100644
--- a/drivers/infiniband/hw/qib/qib_iba7322.c
+++ b/drivers/infiniband/hw/qib/qib_iba7322.c
@@ -5665,7 +5665,7 @@ static int qib_7322_ib_updown(struct qib_pportdata *ppd, int ibup, u64 ibcs)
 /*
  * Does read/modify/write to appropriate registers to
  * set output and direction bits selected by mask.
- * these are in their canonical postions (e.g. lsb of
+ * these are in their canonical positions (e.g. lsb of
  * dir will end up in D48 of extctrl on existing chips).
  * returns contents of GP Inputs.
  */
-- 
2.30.2


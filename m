Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8155B27F541
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Oct 2020 00:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgI3WkQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 18:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731626AbgI3WkO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Sep 2020 18:40:14 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC755C061755;
        Wed, 30 Sep 2020 15:40:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y2so4110990lfy.10;
        Wed, 30 Sep 2020 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhguRjsSra4b6VMADMN4Bq2qFVo39QWAkrhmzvwpUaA=;
        b=CFnQglcs/Z1su3Utv5EXgbcfEYrZDalZ3IGmkW7hkq30GpndkeHRRDMnAU10rXjfz2
         Fj6us1l6odsNXUG/V/ZRMEcdpSSUE6pL8k1kp25WreaiN0xjm/inbiAJnlMpLByL4vwv
         BHb/0dzyoo4Wj2pORhhQxkGB2/IoMlTn3NnTg82idEFYEUXVPa1mBptovw3amUL6LqAp
         CQNbFbtFBi4NuuTEN1nSjfrvpJKfbWthdYWN9gq1/p9tGUujBKklwb7fJX/jLgRjm5wz
         QzA/VkszVtMhSpDvBthWzrpan2CMNze0uzuQxCZZlUanQvqEgkPiXdSkkrXDtGGkz9LQ
         8wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhguRjsSra4b6VMADMN4Bq2qFVo39QWAkrhmzvwpUaA=;
        b=PmQRrPaedvHUgNWxTRrnTxkj0q0BI6A8yhhBZRvDYe8QlVgtRjPQwoWTEY+8aQLgK5
         /34KcmFfVvwX+MQ4ta03aviTkGfptLWr2WlzbKN4tLO/y/p3iZIETFCIqmD02/mo86zy
         giNcEPXrpCwzhVAS5fW4+FqVnTfpwnx/jwKvr0snzMprgR01xkUGvDnI56XxN5kweNrA
         kpZPDBmpz59fuClsfw6l5uHpXbnnXQnsKrAKTVpavzzxWrMebTQ7Y9r6xyVXX5XgtQU0
         H4yYhQcAqMB+LG/GBYqVoVnKtcxX2K8OkkkG2m+/xx52x00kwmA6c2Nqa84BnrilfSQQ
         v1yQ==
X-Gm-Message-State: AOAM532aZXXW7glk2OE/U+DGzOV0FoRry5npprDXVC/u+jQBwtly6DBW
        8Yo7QTSUrbj2gN/M5a5QMJsqufmP5ajczw==
X-Google-Smtp-Source: ABdhPJwn1qnRwJji9C5YeuhSI2002gLg6kmoHyzk4EnHLffc8zr6OOxrpc09FmGqZZA90Qjcvjz0Hw==
X-Received: by 2002:ac2:485c:: with SMTP id 28mr1755607lfy.584.1601505612334;
        Wed, 30 Sep 2020 15:40:12 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-229-94.NA.cust.bahnhof.se. [98.128.229.94])
        by smtp.gmail.com with ESMTPSA id p10sm330893lfh.294.2020.09.30.15.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 15:40:11 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>, Qiushi Wu <wu000273@umn.edu>
Subject: [PATCH rdma-next 1/2] RDMA/core: Constify struct attribute_group
Date:   Thu,  1 Oct 2020 00:40:03 +0200
Message-Id: <20200930224004.24279-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930224004.24279-1-rikard.falkeborn@gmail.com>
References: <20200930224004.24279-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The only usage of the pma_table field in the ib_port struct is to pass
its address to sysfs_create_group() and sysfs_remove_group(). Make it
const to make it possible to constify a couple of static struct
attribute_group. This allows the compiler to put them in read-only
memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/infiniband/core/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index c11e50510e49..453d1c451ed5 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -59,7 +59,7 @@ struct ib_port {
 	struct gid_attr_group *gid_attr_group;
 	struct attribute_group gid_group;
 	struct attribute_group *pkey_group;
-	struct attribute_group *pma_table;
+	const struct attribute_group *pma_table;
 	struct attribute_group *hw_stats_ag;
 	struct rdma_hw_stats   *hw_stats;
 	u8                     port_num;
@@ -653,17 +653,17 @@ static struct attribute *pma_attrs_noietf[] = {
 	NULL
 };
 
-static struct attribute_group pma_group = {
+static const struct attribute_group pma_group = {
 	.name  = "counters",
 	.attrs  = pma_attrs
 };
 
-static struct attribute_group pma_group_ext = {
+static const struct attribute_group pma_group_ext = {
 	.name  = "counters",
 	.attrs  = pma_attrs_ext
 };
 
-static struct attribute_group pma_group_noietf = {
+static const struct attribute_group pma_group_noietf = {
 	.name  = "counters",
 	.attrs  = pma_attrs_noietf
 };
@@ -778,8 +778,8 @@ alloc_group_attrs(ssize_t (*show)(struct ib_port *,
  * Figure out which counter table to use depending on
  * the device capabilities.
  */
-static struct attribute_group *get_counter_table(struct ib_device *dev,
-						 int port_num)
+static const struct attribute_group *get_counter_table(struct ib_device *dev,
+						       int port_num)
 {
 	struct ib_class_port_info cpi;
 
-- 
2.28.0


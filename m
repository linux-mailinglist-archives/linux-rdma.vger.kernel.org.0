Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FEF7E4502
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Nov 2023 17:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbjKGQAW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Nov 2023 11:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344852AbjKGP7p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Nov 2023 10:59:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BAA8247;
        Tue,  7 Nov 2023 07:52:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D107C433C8;
        Tue,  7 Nov 2023 15:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372376;
        bh=qN3rItjyznkYkiw5CfwOeNetUMQmDaNY0SggpPaoW9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKFkASHfi1keaNAMIGdnAPT+If2tXoSwsJbEMqAOFyrJlUbFLQ5np60JEyHq3mUIc
         k49BYLoBvL1hGlN2LVnSzqWPvghsz0TSQ/PIslPvtz2ArCBhoroByrL7y7Ou5chQOn
         3KW36HHSpm8O5SvcJQc9Xd3+6/87iyIqNX4BoCgpOtjnoeQpXmq9deeiQZn8lY/8H6
         GrR4XvL/OdblC2+u1Vnz1bH5bwEHZxnoFpRiaxheTNYD/S6xaDt2aA8Dnw6p5OZcym
         J10IAs3Xs030w4V2eiSrKwWnlYjUfPuq7jUBSGU3qITr9cTRMGtJC6wzCZo0UZbVww
         n3bBN37T50Ezw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        dennis.dalessandro@cornelisnetworks.com, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/16] RDMA/hfi1: Use FIELD_GET() to extract Link Width
Date:   Tue,  7 Nov 2023 10:52:22 -0500
Message-ID: <20231107155249.3768098-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155249.3768098-1-sashal@kernel.org>
References: <20231107155249.3768098-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 8bf7187d978610b9e327a3d92728c8864a575ebd ]

Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
custom masking and shifting, and remove extract_width() which only
wraps that FIELD_GET().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20230919125648.1920-2-ilpo.jarvinen@linux.intel.com
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/pcie.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/pcie.c b/drivers/infiniband/hw/hfi1/pcie.c
index 18d32f053d26e..3aa0215fca419 100644
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -45,6 +45,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <linux/delay.h>
@@ -261,12 +262,6 @@ static u32 extract_speed(u16 linkstat)
 	return speed;
 }
 
-/* return the PCIe link speed from the given link status */
-static u32 extract_width(u16 linkstat)
-{
-	return (linkstat & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
-}
-
 /* read the link status and set dd->{lbus_width,lbus_speed,lbus_info} */
 static void update_lbus_info(struct hfi1_devdata *dd)
 {
@@ -279,7 +274,7 @@ static void update_lbus_info(struct hfi1_devdata *dd)
 		return;
 	}
 
-	dd->lbus_width = extract_width(linkstat);
+	dd->lbus_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat);
 	dd->lbus_speed = extract_speed(linkstat);
 	snprintf(dd->lbus_info, sizeof(dd->lbus_info),
 		 "PCIe,%uMHz,x%u", dd->lbus_speed, dd->lbus_width);
-- 
2.42.0


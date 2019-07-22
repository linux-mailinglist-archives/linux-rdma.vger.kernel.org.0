Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8FFE6F9E8
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jul 2019 09:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfGVHGY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jul 2019 03:06:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51152 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfGVHGY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jul 2019 03:06:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so34008785wml.0
        for <linux-rdma@vger.kernel.org>; Mon, 22 Jul 2019 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g2rNmp3b6nRPP1Tf/VlEY1KtJQoFPWoHmhuhzTL9Gbk=;
        b=lh1Qee0waWxiAw9Ix8Kp0p7TKDxu3/hAwekDanj4o6DMdt9CY9eAeVnFsmUvOEnKa8
         u1cK4umG72N9os1Uft03DQmW78JSRwiMvi8o7y48TlYZPePwGvsag85y3Km6i278iymd
         PdqgNmufg/1EyyO4sRNZV4i3Csm1naMKIqwxDY6vFRNJYvZ4mJ1C3liju2lzSS6JghUH
         KYsPxDvEsl3SY8YlvyuijsxkG6P9WJ0HAixu7uzJAaLUEwteapYSEKFhUhtEubHXrIar
         E6Ws6+XN6X83X7BNrZMD8YD0CvotEp4pYLwXXCEkQhsziBO7AdtICVWTKlmTOteUPZA3
         GrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g2rNmp3b6nRPP1Tf/VlEY1KtJQoFPWoHmhuhzTL9Gbk=;
        b=Xm6Xs5cumqTIaHXS1kHQ8g4oiX0IzlAYds7tPaSMCANzuruD0z0QuLl54c/haeD/tC
         zdr7XhEQleiSG4yg7OJHCRRunKAtKw1xqyCcSpmE6hZFy2+uQj4wZmvAffmToYxVLRsx
         Y2+/34jPV5ky6TqQk+u8otIOxLUEg2vZAz1ksEiqTLGTHNZJtfsjO4XKsCxZoKWhFExT
         YMmwI1e6vTlaeLQiJ26FcCOgDwlqfJOMaRk89l9P97ZvKf85FUC9V/ESuWEoiGO1OASL
         cbDg+elrUD7oAw1Pz/Pkbc7LZxo8OFZhgslZzMDbfHfEFifLv6UfZqeOjxJ21CZB9gd/
         omuQ==
X-Gm-Message-State: APjAAAUUGGG20xQYiIRxJeJcqkMwy9v++Xg1yo8yxUB09YDm97JyYv71
        V+bP4eh+oO4xuiEmyt2fZ+CJVOuj
X-Google-Smtp-Source: APXvYqw+pawjsLG7KkSNDPo4wnRaxghMa+hW+1Eq67MVR1T+rysM2vOHEVyWXty6FH5PKPiDplWr7g==
X-Received: by 2002:a1c:7fc3:: with SMTP id a186mr10761071wmd.151.1563779182136;
        Mon, 22 Jul 2019 00:06:22 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-178-23-200.red.bezeqint.net. [79.178.23.200])
        by smtp.gmail.com with ESMTPSA id y18sm37360991wmi.23.2019.07.22.00.06.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 00:06:21 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next 3/3] RDMA/i40iw: Report phys_state in query_port
Date:   Mon, 22 Jul 2019 10:05:50 +0300
Message-Id: <20190722070550.25395-4-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722070550.25395-1-kamalheib1@gmail.com>
References: <20190722070550.25395-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for reporting physical state when calling query_port() via
the sysfs interface.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index d169a8031375..c678b05bb829 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -105,10 +105,13 @@ static int i40iw_query_port(struct ib_device *ibdev,
 	props->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
 
 	props->lid = 1;
-	if (netif_carrier_ok(iwdev->netdev))
+	if (netif_carrier_ok(iwdev->netdev)) {
 		props->state = IB_PORT_ACTIVE;
-	else
+		props->phys_state = 5;
+	} else {
 		props->state = IB_PORT_DOWN;
+		props->phys_state = 3;
+	}
 	props->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_REINIT_SUP |
 		IB_PORT_VENDOR_CLASS_SUP | IB_PORT_BOOT_MGMT_SUP;
 	props->gid_tbl_len = 1;
-- 
2.20.1


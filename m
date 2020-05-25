Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824301E06A4
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 08:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgEYGHG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 02:07:06 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:56548 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgEYGHF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 May 2020 02:07:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49Vmp11VfDz9vYW0
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 06:07:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id djbIZxvj5w9r for <linux-rdma@vger.kernel.org>;
        Mon, 25 May 2020 01:07:05 -0500 (CDT)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49Vmp06zdKz9vYVk
        for <linux-rdma@vger.kernel.org>; Mon, 25 May 2020 01:07:04 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49Vmp06zdKz9vYVk
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49Vmp06zdKz9vYVk
Received: by mail-il1-f197.google.com with SMTP id b8so14425280ilr.11
        for <linux-rdma@vger.kernel.org>; Sun, 24 May 2020 23:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jjGsOnu1ZjgFIvFRXq2dOPsn0xQlqdEv9AzQSBptdx8=;
        b=QW63tyJNQvRmNDXJUnWBiiF5tgN++NOy/cpqOBTcXh1TNFpVs5Tf/XQ3J7NjZS9Hrv
         o/mizuZLq77AHeEwLrWH5HjwcxB0z1Wj/JsHi8OVMH9lpY3j+PKN1tay6acd8cpa+O9d
         NEY4K4ZjbDd1mlRicS9bJoM5wTWmeVRhnuOYNtRgdLy+LO6h1Dqq9i4XFxuqw8IOrVBT
         nB2ADoLToFRnLNmXGsizWOL3sL/8jcazct7ig5DLopUWyDAKqNofTpxNJq/24m6FAe8b
         TP693U3B6swbcE/e0dPM3NQ/PndjFNMVkm+fMC+Kav3KfXBSdO04Szj7CU3yoPmZYzel
         KaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jjGsOnu1ZjgFIvFRXq2dOPsn0xQlqdEv9AzQSBptdx8=;
        b=YC2ZcdgpWjZUtfszFDx7QJ6ohTYJaJotpXEqmuiD2JBNhWKmkbzHUxzJYHt6981FzU
         VcJye5dgmwdyHwArEtMUGrhdC6QW3cKGkrPOnfMOM+cXUV3hmfVO3C+jvqxomVRD6Awd
         Gu4IvAhmjrBYCjdhBOYxujaKPralRFLqb17toUyFWIQ+MJUWkydipENeAEdgT0A8wxb7
         FDI3C+4EB5hHvfu9PF6lE638RNQ/fXuIY5Sy/aHsPBly3VPI40SEzV12j2JAxwB6U/Yy
         VOm/Jyf4LNYQ7aOuwC3C/vv3WxkuepWTn7ihOZvVezxuT6RGpOLQPvj9efBVTyIKTUyR
         hotA==
X-Gm-Message-State: AOAM533GZ8IeB/zltf5WkPlLglFwG3gxDlAY27E9pJqBXgGEpmG6zElW
        5uheWadb2B+Ulcr6SHV6uS3ZRMWCfDGx0AO5kW03upigD8GX8BtV23kCbp20puJtRZtlspQziA+
        4J/UDySPxj6vUsw6tMPZj2Wib/w==
X-Received: by 2002:a92:c609:: with SMTP id p9mr23541465ilm.243.1590386824558;
        Sun, 24 May 2020 23:07:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyecTG+zzDarmVarZgvCIsIzQrqhEsFq+h2Ch+VoSyrxcuTA2gmgrIjR4q3Y2rcA62/pamI/g==
X-Received: by 2002:a92:c609:: with SMTP id p9mr23541447ilm.243.1590386824207;
        Sun, 24 May 2020 23:07:04 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id w70sm9062759ili.78.2020.05.24.23.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 23:07:02 -0700 (PDT)
From:   wu000273@umn.edu
To:     dledford@redhat.com
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] RDMA/core: fix missing release in add_port.
Date:   Mon, 25 May 2020 01:06:56 -0500
Message-Id: <20200525060656.2478-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function add_port(), pointer p is not released in error paths.
Fix this issue by adding a kfree(p) into the end of error path.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/infiniband/core/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 087682e6969e..04a003378dfc 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1202,6 +1202,7 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 
 err_put:
 	kobject_put(&p->kobj);
+	kfree(p);
 	return ret;
 }
 
-- 
2.17.1


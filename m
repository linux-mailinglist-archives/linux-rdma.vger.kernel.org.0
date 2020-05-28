Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EC91E5453
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2020 05:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgE1DCn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 May 2020 23:02:43 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50364 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgE1DCk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 May 2020 23:02:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49XXYq54t1z9vLH5
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2020 03:02:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VPR2sIIhHkck for <linux-rdma@vger.kernel.org>;
        Wed, 27 May 2020 22:02:39 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49XXYq3F5qz9vKTZ
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 22:02:39 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49XXYq3F5qz9vKTZ
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49XXYq3F5qz9vKTZ
Received: by mail-il1-f200.google.com with SMTP id w65so22200800ilk.14
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2020 20:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zDbEEaAjMrlok9kovXjA7HADeufiZv6s5fCM6rPhTNE=;
        b=cQls/vAkDYsaKCcQ5fF09vb9OQQLlfV/Qtzb9veCmOsHKvwc00m8cZHlpzGyi+6YFF
         2Vi4WCn/ZRE7mCZ1EM6kISFBsaiUV/m42GAQO5IL0ntAzjW3pL9Mau6cHZk2063gzhKk
         +q3vUDnThw52Mx9rKuSkpsPqny4WEq4frIg7jI9O2bxue+ISe2mUTXP8Q2jdWoX1uBuX
         k+kggq3VU4C3/5Axm2Kk6bUnr7KWMPmg2L5kLruh7uGPlgi3Yr16RI+b7owqjtpEdGWU
         DvMlnvfPrnd9nph8I4bMBeMvN8zXs/OWjQhWaY6LUPUrSGZuJtpd34wO66s/73Xe5oE3
         BEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zDbEEaAjMrlok9kovXjA7HADeufiZv6s5fCM6rPhTNE=;
        b=E5zIKcYN5jG4Umc5XwmcsO++zK8Aq83g4P5kgb+8CeAwAtw3+DMvqflsCAzI3ZsY8O
         rtQ16z334g0tI/5WC2RY/airS9EszXp2/k4o+ql6cZRbWwmQKMD3bBsyEz7GHyWZVvcs
         c27Xzwupp93bFNNczWjTIX0Rz+W6DWybr55dgprT3EEqx+9zG9FdAhjOlc6CW2J/kjUi
         DCv0ZWflN/f9dDBtZOc77EHGlDj12y0GFJDxC63RuYfFA+dgA/p6e8KP/MMGkYHuzQfX
         +J8vr9fN8WuP7kJEovCEPjnABvx/EJWYzCtzoWwiwEWlmaT6djlHiyNZ5DoZV+M2Fhd8
         mQ/w==
X-Gm-Message-State: AOAM532lsAcDVmq2fHxaPkOWQzI5dPXVKJw+7TzvRqiUdhMzZzf6V0nF
        Dm+O4RqCgsXifIQylYKv2gWDS2P5+8VWZ9/yFE+AvUldHzNHfP+9HY5wKKCUXT4HCtQuSuTHsil
        tjIAzCAcc3eWBExPhg1p1lKJtiA==
X-Received: by 2002:a92:c983:: with SMTP id y3mr1132660iln.233.1590634958922;
        Wed, 27 May 2020 20:02:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylg9xy6KzuUK4W37Ofn09MZE8XCdPSxAnYmoeX2c320eu4pXlCN34WKO3UaNKrjFcdS6btvA==
X-Received: by 2002:a92:c983:: with SMTP id y3mr1132642iln.233.1590634958600;
        Wed, 27 May 2020 20:02:38 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id w70sm2605706ili.78.2020.05.27.20.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 20:02:37 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Mark Zhang <markz@mellanox.com>,
        Majd Dibbiny <majd@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/core: Fix several reference count leaks.
Date:   Wed, 27 May 2020 22:02:30 -0500
Message-Id: <20200528030231.9082-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/infiniband/core/sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index 087682e6969e..defe9cd4c5ee 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -1058,8 +1058,7 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 				   coredev->ports_kobj,
 				   "%d", port_num);
 	if (ret) {
-		kfree(p);
-		return ret;
+		goto err_put;
 	}
 
 	p->gid_attr_group = kzalloc(sizeof(*p->gid_attr_group), GFP_KERNEL);
@@ -1072,8 +1071,7 @@ static int add_port(struct ib_core_device *coredev, int port_num)
 	ret = kobject_init_and_add(&p->gid_attr_group->kobj, &gid_attr_type,
 				   &p->kobj, "gid_attrs");
 	if (ret) {
-		kfree(p->gid_attr_group);
-		goto err_put;
+		goto err_put_gid_attrs;
 	}
 
 	if (device->ops.process_mad && is_full_dev) {
@@ -1404,8 +1402,10 @@ int ib_port_register_module_stat(struct ib_device *device, u8 port_num,
 
 		ret = kobject_init_and_add(kobj, ktype, &port->kobj, "%s",
 					   name);
-		if (ret)
+		if (ret) {
+			kobject_put(kobj);
 			return ret;
+		}
 	}
 
 	return 0;
-- 
2.17.1


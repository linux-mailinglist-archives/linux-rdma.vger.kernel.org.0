Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02AB991912
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2019 20:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfHRSzC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Aug 2019 14:55:02 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33591 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfHRSzC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Aug 2019 14:55:02 -0400
Received: by mail-yw1-f68.google.com with SMTP id e65so3458576ywh.0;
        Sun, 18 Aug 2019 11:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T2TPSGOVqg4dOeSqwdBHE96Y8bPuE69JW6C1DCSqOqw=;
        b=EIxqEo0k+0lmgpU1QfjyxMHfbzDgLtQumdWi9DibOfSN7HQSdzqJHjyHswHqAlG0vn
         EpzO2NBsbmlbckPWgxamWpJw3Sa+xojXlyx8ltQd31axt2jahhP6eiY1JMFX+P+/yedm
         yz7hcSSDPgi+pv91BU96EOpHFK25RjgGyedTt+6CzcEWUu5qwu+YnjUWUXDWSSDHXqWJ
         BzsCTBdOjKbZOZ66weLLwp9pvjWwcwayWj5NzFy7J3HQjGz4oZBRjSPpadx3P2gJoal1
         i8fBzh79Y5MUPwK3cPaGNURDKbFXcGUEpXQOdVNCvPpash5G7RfP3aUyHCFyHuF4viFd
         MoUQ==
X-Gm-Message-State: APjAAAXPQtgkwflSzFzC05bPIuoI3WKB+8qjnfDhPZZYdlbOvgQgXK91
        6fJ5l1EhQBPBPNfe4r+Hjgk=
X-Google-Smtp-Source: APXvYqx2ah5tAKkcFHvc4tNEDYu1wsBEXftIZ3xVI4mbUGkD2Ngh09TwsH5gGBc3yYCe0JD7ZF2TJw==
X-Received: by 2002:a81:280e:: with SMTP id o14mr14078157ywo.206.1566154501551;
        Sun, 18 Aug 2019 11:55:01 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id z6sm2994720ywg.40.2019.08.18.11.55.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 11:55:00 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] infiniband: hfi1: fix memory leaks
Date:   Sun, 18 Aug 2019 13:54:46 -0500
Message-Id: <1566154486-3713-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In fault_opcodes_write(), 'data' is allocated through kcalloc(). However,
it is not deallocated in the following execution if an error occurs,
leading to memory leaks. To fix this issue, introduce the 'free_data' label
to free 'data' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/infiniband/hw/hfi1/fault.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index 93613e5..a999183 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -141,12 +141,14 @@ static ssize_t fault_opcodes_write(struct file *file, const char __user *buf,
 	if (!data)
 		return -ENOMEM;
 	copy = min(len, datalen - 1);
-	if (copy_from_user(data, buf, copy))
-		return -EFAULT;
+	if (copy_from_user(data, buf, copy)) {
+		ret = -EFAULT;
+		goto free_data;
+	}
 
 	ret = debugfs_file_get(file->f_path.dentry);
 	if (unlikely(ret))
-		return ret;
+		goto free_data;
 	ptr = data;
 	token = ptr;
 	for (ptr = data; *ptr; ptr = end + 1, token = ptr) {
@@ -195,6 +197,7 @@ static ssize_t fault_opcodes_write(struct file *file, const char __user *buf,
 	ret = len;
 
 	debugfs_file_put(file->f_path.dentry);
+free_data:
 	kfree(data);
 	return ret;
 }
-- 
2.7.4


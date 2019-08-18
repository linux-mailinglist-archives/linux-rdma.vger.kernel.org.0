Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4031F91944
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Aug 2019 21:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHRT3h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Aug 2019 15:29:37 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40134 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRT3h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Aug 2019 15:29:37 -0400
Received: by mail-yw1-f67.google.com with SMTP id z64so3462416ywe.7;
        Sun, 18 Aug 2019 12:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WwJ07zoBP7ifoIvwMolWLi9zDNgesbiXAJZqIP13xyU=;
        b=f3OrpmCVjToQIiJVkJzZPIYoowm/mu20eWCPYW3rM/fsfKc6sys6dVlwFrac6helcD
         MoivDJhgZBdnqdvV5MpggRnaSmD7tgitBEwqfBS2sNzqkj8A4xs2b0OCPWJK2pAC9ouA
         A3ASy94U/LDkJMxbviR0yUUMXdSxkYR6kebJ7IBGWJiaJvePBzcewUzJHBUARjFgnTGX
         lmW0TRRmUoUAVKU/rCTUmZG9Y3dpk1iAhLEdVPs6071Fo3UFNdn9YYloeNc9qt0agzEN
         on0B2sXQHGl+nnXfsKKWps1kn3IYUAmWf55Nyz61NEpiJfg9/4lohsyzFns/3NPmD5GL
         5m4g==
X-Gm-Message-State: APjAAAUSni5d7EsO2PdXnXnOo/bDEATtz0FKMuhdJoK4OB1MlC+MYJwy
        hzAklA2hbPmI1/onzDlkaM8=
X-Google-Smtp-Source: APXvYqzyeM0q6fyomTCruqGdw+iqgZbRg/gExb0L1NQW0tyXOSavUrrVXjH2ItBgv0x55PG5faMXsw==
X-Received: by 2002:a81:18d5:: with SMTP id 204mr13989252ywy.165.1566156576681;
        Sun, 18 Aug 2019 12:29:36 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id s188sm2633931ywd.7.2019.08.18.12.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 12:29:35 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] infiniband: hfi1: fix a memory leak bug
Date:   Sun, 18 Aug 2019 14:29:31 -0500
Message-Id: <1566156571-4335-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In fault_opcodes_read(), 'data' is not deallocated if debugfs_file_get()
fails, leading to a memory leak. To fix this bug, introduce the 'free_data'
label to free 'data' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/infiniband/hw/hfi1/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/fault.c b/drivers/infiniband/hw/hfi1/fault.c
index 93613e5..814324d 100644
--- a/drivers/infiniband/hw/hfi1/fault.c
+++ b/drivers/infiniband/hw/hfi1/fault.c
@@ -214,7 +214,7 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
 		return -ENOMEM;
 	ret = debugfs_file_get(file->f_path.dentry);
 	if (unlikely(ret))
-		return ret;
+		goto free_data;
 	bit = find_first_bit(fault->opcodes, bitsize);
 	while (bit < bitsize) {
 		zero = find_next_zero_bit(fault->opcodes, bitsize, bit);
@@ -232,6 +232,7 @@ static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
 	data[size - 1] = '\n';
 	data[size] = '\0';
 	ret = simple_read_from_buffer(buf, len, pos, data, size);
+free_data:
 	kfree(data);
 	return ret;
 }
-- 
2.7.4


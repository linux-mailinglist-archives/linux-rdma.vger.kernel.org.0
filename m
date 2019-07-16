Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4086ADA6
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 19:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfGPR3c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 13:29:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34174 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbfGPR3c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 13:29:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so3553539pgc.1;
        Tue, 16 Jul 2019 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=iFsg7zgErG7qPu+qK+vn8Dl0lcUvmaJEqbe5euJxvQo=;
        b=bJHmxF/wDfkcxpPQa+kixCbcwLFC9m1Q3qpzVmgxC8udYiSLJj52BTGIr0ZXNeboyN
         xj4s6+vyb7pdmf/KK6TQavUzo3NETbx1pcKYtwAUT9dHYJBqNGkbF+GDQuEnTqfu3OLv
         MsluebH82XPNZXjEndd+cdnzdTY2ah4P+XBeolGYmPbVOtxsD6NrcE9A63BUVkI7ji8M
         SjroM3A19LR+xnW8TKP6rXsih7kc0MF6HYSqsx4K4QZp+AvIQTRVitWulFVxRPmhKQjZ
         aNlsJFhiCMlODaiRKO3e1BC5WH3rZgO6+AHNcD3w62zrKd9U3ksy9Enwby29DrtwpD/y
         AyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=iFsg7zgErG7qPu+qK+vn8Dl0lcUvmaJEqbe5euJxvQo=;
        b=FP8eGvjxPUt2IkNvBpFTJA6ec0SKIFCPMpABaYUBKJKkjPVG3YEYDGDmYf0sVWfT2D
         IMh9dVaY7je7jGfYDP5cjjDpAjMdmb67kPRrUVxjKNTLgRBwOwIU9Fe06R6sG1kCIY4q
         KEkmv+4xku4sZltAlvmAEitGYB+5Lh/czsqfjzgutwbxNGTJpr2DMhNYhD6PCZyaLJqH
         fFHT9NqwDT8XHRmzjslHN0l25TYpeh7wlS6QzFlilDjcwIkMSzeOh5m6tdetJ+52t6KP
         whdftzmDUpuOqimKZOu/+LZ2YHn9EPWEO5gZMtfmy7Cma2d8BkNZ1HLg5o4GeaPWG66D
         5hnQ==
X-Gm-Message-State: APjAAAU/xRdfGma7JyCXaqF2qa8ycnetjBM8Ho9mprE6KXAe8BD4nhYP
        iDXbfVq0/yhjPVEi2YAqEDo=
X-Google-Smtp-Source: APXvYqxBKqWUm1cOx4GABfPPUq2U6TC9lPoGvk2pRh0AJkgEWJlinxI/cvKvypfJ1dyLvzBkaRC9WA==
X-Received: by 2002:a17:90a:80c4:: with SMTP id k4mr38638700pjw.74.1563298171637;
        Tue, 16 Jul 2019 10:29:31 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id 21sm10104389pfj.76.2019.07.16.10.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 10:29:30 -0700 (PDT)
Date:   Tue, 16 Jul 2019 22:59:25 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: hw: qib: Unneeded variable ret
Message-ID: <20190716172924.GA12241@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

fix below issue reported by coccicheck
drivers/infiniband/hw/qib/qib_file_ops.c:1792:5-8: Unneeded variable:
"ret". Return "0" on line 1876

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/infiniband/hw/qib/qib_file_ops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 27b6e66..b014422 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -1789,7 +1789,6 @@ static void unlock_expected_tids(struct qib_ctxtdata *rcd)
 
 static int qib_close(struct inode *in, struct file *fp)
 {
-	int ret = 0;
 	struct qib_filedata *fd;
 	struct qib_ctxtdata *rcd;
 	struct qib_devdata *dd;
@@ -1873,7 +1872,7 @@ static int qib_close(struct inode *in, struct file *fp)
 
 bail:
 	kfree(fd);
-	return ret;
+	return 0;
 }
 
 static int qib_ctxt_info(struct file *fp, struct qib_ctxt_info __user *uinfo)
-- 
2.7.4


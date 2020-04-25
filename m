Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E1B1B8A08
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2020 01:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDYXft (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Apr 2020 19:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDYXft (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Apr 2020 19:35:49 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26714C061A0C;
        Sat, 25 Apr 2020 16:35:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so16131910wrt.1;
        Sat, 25 Apr 2020 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gCF6xgbqYSz+54ZxWOLptTQH8ldDtaIZB0EHa3I8s7g=;
        b=T8aoYfsWg4JVLALRHi9Z04fd1eCSeHhYbpQ11yQhS+812OR5im0BVC/ZHDMc4iKdNy
         guToyYkT4SnuPjJ2AbTiifPqgR6fK7oagu426nzKNSWCB/B6v6WY7pcwVGcOU3PzAqbT
         LqJFAjwdnpeknVGGBeqoyhTfs9E5hJ77ejLgjofD7hDiRp8nWW4C539x6pQPJVmKPPrk
         t3ByUzTvqVSkwC1sU9Xi7b+9M8lxQuyxDy6HDcEn3K53cZc8Of1iO9tw5CDq9cGikuo2
         4fXc1tb8lG2il+c1GyBrMOKLKcC64LNCWqceDtPtOVanraLMs+cRXJHPWOKsHzNdJhET
         Ho0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gCF6xgbqYSz+54ZxWOLptTQH8ldDtaIZB0EHa3I8s7g=;
        b=S6b7Acsh0pmWoJzReA3DHhxyooLJzbxfflqtEMsko9jCqapxx5MIq61Z6CJkTBjAzI
         6qLPyPBpmZfa9ieoCcnEigGJa3Lj28MoZXVMDgRL3+9oyZSEPLwU3T39MCdtCZUG+kHu
         /G5XL0agBosAQVI5DbtYydmgSDQFmN4SjVCJX9Fq++c4HKZjGkHAF+Zox2saR74s4WoO
         mMx88RzX9XcgkH7O8CrHk1hdhBlpb+gsclFOsR+bUgOTHsrHmaIk4p0Rt6kTtWJKaXab
         OGkZRbmzkcgrQ1XgAS66bgcsAlIrEGiFe8PttdkArZB5LzZvnbnynwnAKpP0UcEv1jmQ
         sKgw==
X-Gm-Message-State: AGi0PuZb2sE/KlduDX1WOVkBKB2iUiJZz/33roCYFc9maBN0u182lH+Q
        TjLF3XobT64MQYEFbRLgCjI=
X-Google-Smtp-Source: APiQypLDE+3FtAtDjztwiZj+kKl3kGDNakv/8cg+KE2bpgvqjMexpyw4TnOCpkYf59tkesFOXdntIA==
X-Received: by 2002:a5d:498b:: with SMTP id r11mr19106371wrq.368.1587857747844;
        Sat, 25 Apr 2020 16:35:47 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id l16sm14443865wrp.91.2020.04.25.16.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 16:35:47 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Zhu Yanjun <yanjunz@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2] RDMA/rxe: check for error
Date:   Sun, 26 Apr 2020 00:35:45 +0100
Message-Id: <20200425233545.17210-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The commit 'ff23dfa13457' modified rxe_create_mmap_info() to return
error code and also NULL but missed fixing codes which called
rxe_create_mmap_info(). Modify rxe_create_mmap_info() to only return
errorcode and fix error checking after rxe_create_mmap_info() was
called.

Fixes: ff23dfa13457 ("IB: Pass only ib_udata in function prototypes")
Cc: stable@vger.kernel.org [5.4+]
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mmap.c  | 2 +-
 drivers/infiniband/sw/rxe/rxe_queue.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mmap.c b/drivers/infiniband/sw/rxe/rxe_mmap.c
index 48f48122ddcb..6a413d73b95d 100644
--- a/drivers/infiniband/sw/rxe/rxe_mmap.c
+++ b/drivers/infiniband/sw/rxe/rxe_mmap.c
@@ -151,7 +151,7 @@ struct rxe_mmap_info *rxe_create_mmap_info(struct rxe_dev *rxe, u32 size,
 
 	ip = kmalloc(sizeof(*ip), GFP_KERNEL);
 	if (!ip)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	size = PAGE_ALIGN(size);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
index ff92704de32f..fef2ab5112de 100644
--- a/drivers/infiniband/sw/rxe/rxe_queue.c
+++ b/drivers/infiniband/sw/rxe/rxe_queue.c
@@ -45,8 +45,10 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
 
 	if (outbuf) {
 		ip = rxe_create_mmap_info(rxe, buf_size, udata, buf);
-		if (!ip)
+		if (IS_ERR(ip)) {
+			err = PTR_ERR(ip);
 			goto err1;
+		}
 
 		err = copy_to_user(outbuf, &ip->info, sizeof(ip->info));
 		if (err)
@@ -64,7 +66,7 @@ int do_mmap_info(struct rxe_dev *rxe, struct mminfo __user *outbuf,
 err2:
 	kfree(ip);
 err1:
-	return -EINVAL;
+	return err;
 }
 
 inline void rxe_queue_reset(struct rxe_queue *q)
-- 
2.11.0


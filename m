Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D71BA5BB
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 16:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgD0OLM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgD0OLL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Apr 2020 10:11:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC959C0610D5
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 07:11:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so20763049wrx.4
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 07:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=bAHQyR+2H/NT4ao1Xoqb0ve9bvBgahVQhsQG5LSWK1DAXQYhtdVnqI3RX0dPBtsDNm
         ZwAMhxkrV0oTCnGPizYLnCjimAuEtU4QPhMFy5lquTKUod1H7i16YRRtvGboI3VM9VPT
         aj7JTeBhw3oHjb3e/3dmRv98h2YU8Mlqex6FfUGMFRCOLoKxtWyFvVtKV7xVzO+HyDlj
         /n/ngBxN++bGUpzLQtCdn96ktXsHDdXtGMx8gc30dsbAfrtG4jzYvpV/TykcyviJ1MGO
         tqsRhtWTDwmiREzQalYaF3t6mH/OVb9yqw3WMOWzPafa3iiSspasH2wfqIKJg3imzAYA
         QNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=Y8PA68xHPhEJQ6LyW3xE/UpX3W/EZVKbbLRKEVIv4zJAU6l1+8u86jluqn0wXddLQF
         8VQB8kCSKTExKmYnztewb2+74TSDy5Vp1P73Puu4M2JX0lWDXS0pgcA2fSL9sNVOaHFo
         0SaZzhgKmwUa5xBUJ2/JXBvEHLct4HJG35VG2HW9ieEFZrUbR5tqA81cotDE4/jM3Y+D
         w5y+10BWggFnYifYvQvr+r8rDoGbdg6GXvy8cRXs1aI2IMiHgBsEYX9Udt6g329fzWbQ
         itb988wMLZqvR+ZUG7S6buFrUAI1ef/u90cCltJEX4XT1PwC0xgcGlxmQGWV9pwsVacN
         ioAg==
X-Gm-Message-State: AGi0Pub6JShYYPBna0/N0xpKIl85s19rFazClPPZcuwPlJv3acp4fpi+
        tm8gbP2r+ahjs0Jo1/ZEUqBJ8b6IbC9/wEQ=
X-Google-Smtp-Source: APiQypIdxbPq0Ip/4hH9CimyOIVNg8ufwRVZbjlJSM8QoQPnqNM+moQJCpFRUWi9Z4DN1ONvw4LiLg==
X-Received: by 2002:adf:df8d:: with SMTP id z13mr27551882wrl.304.1587996668573;
        Mon, 27 Apr 2020 07:11:08 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-227-207.002.204.pools.vodafone-ip.de. [2.204.227.207])
        by smtp.gmail.com with ESMTPSA id o3sm21499756wru.68.2020.04.27.07.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 07:11:07 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v13 01/25] sysfs: export sysfs_remove_file_self()
Date:   Mon, 27 Apr 2020 16:09:56 +0200
Message-Id: <20200427141020.655-2-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Function is going to be used in transport over RDMA module
in subsequent patches, so export it to GPL modules.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
[jwang: extend the commit message]
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/sysfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 26bbf960e2a2..d81f9f974a35 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -492,6 +492,7 @@ bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *attr)
 	kernfs_put(kn);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sysfs_remove_file_self);
 
 void sysfs_remove_files(struct kobject *kobj, const struct attribute * const *ptr)
 {
-- 
2.20.1


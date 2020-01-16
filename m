Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8A13DAC3
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 14:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgAPM7W (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 07:59:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39765 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgAPM7V (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 07:59:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id t17so18825612eds.6;
        Thu, 16 Jan 2020 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JU7gxEFwqK+Oxre///Ayp0+fP1f8xI82V+ZomELLvp4=;
        b=uvRrgWRu7I86qKQ0Eh/qfeUUD9OLgTi++Ou/RhfFmXQjCXrOX8QDv22J1TqxwM/Wlp
         niVoBjPZRgj8tNLCdLAJpQ2iVfWF/llODq/ZeOrv/cfXCwIIVUzHhsSEkBDS2K475/ho
         9TSVe8mCOB8Bidp0Pvt3wJFnPSbjdSxSQqjN6Li313HIOOxImQy8pP3waJdKs8htJSG9
         DnaoqS9TYiv7GxyqD4tDYM3AU9Tmh2oTBFtJ6w4VdfznHWqX0czUlLtCBaw1MHjijrfg
         Ta3EB3PL6V0llGOgmQrSDOysAnbQJmkKVHXkKOQcFSBRTlDCg2hP7NPFVH8KPPlWJLds
         IqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JU7gxEFwqK+Oxre///Ayp0+fP1f8xI82V+ZomELLvp4=;
        b=DoVPCpQal6hg7tyOXz9ROX2D9plM6l//1BGWX5HQnuUjeCFmwt0GH3Ry18Q/o7biDg
         QrgdCq7LdF8lK6MUMEawHc37FuaO6H7K+wBhKqaI8RfwGPbu2kZFvHmIPOAofKDvFHzi
         5gHE6HRgRgUXxFOq9yQYCf0LkFNZZGlJGxXq9MySB1xFfzCveBBG859mUqJWxZd1oCFK
         8iDkidGmw0QNqfvJUHVU5aGzwFYHQdWIGx7REsoZrU2FkQ6rh4Y3jMTtueqIUB/WuDOT
         ZjN5ALKUjggckgtmtF4kbdtZYTscmB8NL5IpAt94zi+e7v0yPU6/aiDXphS2kWTFgMCp
         MNlA==
X-Gm-Message-State: APjAAAWaBOTv7gY18TphmUQoI04kJQItdRaZPNbdCzzM3SOVhD6kZLf+
        mqzJJthP6ezx5P9lz4Ltcm8dA9lo
X-Google-Smtp-Source: APXvYqyfBsE5jck3bw/VdTRhjo4kKjLHjrj51wfpyyBP+3PS7KhsSZxgaEYUA5oUGV8GEx8FoPdYIg==
X-Received: by 2002:a17:906:86d7:: with SMTP id j23mr2843204ejy.89.1579179559263;
        Thu, 16 Jan 2020 04:59:19 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4956:1800:d464:b0ea:3ef4:abbb])
        by smtp.gmail.com with ESMTPSA id b13sm697289ejl.5.2020.01.16.04.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 04:59:18 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 01/25] sysfs: export sysfs_remove_file_self()
Date:   Thu, 16 Jan 2020 13:58:51 +0100
Message-Id: <20200116125915.14815-2-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200116125915.14815-1-jinpuwang@gmail.com>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
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
---
 fs/sysfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 130fc6fbcc03..1ff4672d7746 100644
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
2.17.1


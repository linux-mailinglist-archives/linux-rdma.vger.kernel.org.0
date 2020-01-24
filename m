Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A2B148F94
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 21:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgAXUr7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 15:47:59 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35456 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgAXUr7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 15:47:59 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so3978257edv.2;
        Fri, 24 Jan 2020 12:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JU7gxEFwqK+Oxre///Ayp0+fP1f8xI82V+ZomELLvp4=;
        b=eRu+xQmFlMp1p123ro0L8uEz6rLywSSxjfCP//d3n5T5sSVRI9vgFDwkWZaYhPDb01
         AA1TJ+Cu5TAUm6Ts+9sl0p5o1u5fY4dXUzQmsa1PbeakWDjkncijtz3uljdd77xRBmHD
         TbNTGMIu8npkRA0YNARxdeYcH3draPkudVWEBhsW6ngSiUi5oREnoj3bxO1xA7aNaV+i
         QDTcwmKM5cu16LaK3KZvHqJYHhks70rumEqDcyfoAQIKvP3r/DvlmKikNKqsMS4j0Anl
         dvbBuud/ZKUP2bTHB4YhlsE5mulb2xDVwXlp0U1S+CtRyKwgjzZXYE2OMC0M0UTYfH0L
         KQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JU7gxEFwqK+Oxre///Ayp0+fP1f8xI82V+ZomELLvp4=;
        b=iYgzcyXwLXUYHziNksT0ckDvK0V2sDsSRmOF4lrxqgik2gfOvE3OEw+QhTUDzKjd/W
         61To+EqDUKuG+TuyrDOwf3hQaUfTrLchejzIlrovdlxkJtldbto4N+p0hOo1g68Zrhu/
         1FwJ5kjlQTm8Tnvy5JnyCPnltmueq36K9JwYQeckJTv5UGOSLFNbYqoy4b7mSYB53hkH
         0QsWknG2iTNvX8LWnWJSwNbjaCADs9furjzkDtSJJl6JfwWf/xEbpYMZ/iRKOtKxgDJM
         +CJE9PvnuQVMNC4f5BmQ3eXAHPrkaCIVUUEz4Q0WIJSzMZhfFTrERoE6ZFO1CqMXFocN
         uQFA==
X-Gm-Message-State: APjAAAWPbYb6vX1cVeTPIX7nCDnWZY55E2yWgfTsH8PpcSrQrjIdwMZy
        8f+n4ofGg2ftuLC0UWSkUmL5h16i
X-Google-Smtp-Source: APXvYqxnina41SA8+MgC1xi6wgEfub21FhhEpsBWu5i6V9WtJ/iIpEmyMw1/fN294AV9Djv5FKmk2g==
X-Received: by 2002:a17:907:104e:: with SMTP id oy14mr3769362ejb.82.1579898877190;
        Fri, 24 Jan 2020 12:47:57 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4965:9a00:596f:3f84:9af0:9e48])
        by smtp.gmail.com with ESMTPSA id b17sm53830edt.5.2020.01.24.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:47:56 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/25] sysfs: export sysfs_remove_file_self()
Date:   Fri, 24 Jan 2020 21:47:29 +0100
Message-Id: <20200124204753.13154-2-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124204753.13154-1-jinpuwang@gmail.com>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
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


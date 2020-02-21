Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2020A167B55
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2020 11:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBUKr0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Feb 2020 05:47:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33664 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgBUKr0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Feb 2020 05:47:26 -0500
Received: by mail-ed1-f67.google.com with SMTP id r21so1809018edq.0;
        Fri, 21 Feb 2020 02:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JU7gxEFwqK+Oxre///Ayp0+fP1f8xI82V+ZomELLvp4=;
        b=R2ZUvr3ZuLAjFgvdrwOgxABTV1rb54T8Yot4G6CZhY33nraY/yTW8WHI8KSWs4LuhZ
         MJG1OoU2i7KsKlydCYMqvmQMP60uFvKbgt9yOlPGdHqQ8Ybx9L0r3yLtP+0aPJH/zZ55
         +ybM0KR/6kxsvD8HjL02eLeotMe1NdDyVlpGi02Hi3yVDLB+AyoT4iMLw2HH4Egtic9F
         ObS5a/tP7Iiau+EyL5ukYMjYxkMQvWOJheMcHAl1dLj5f5iP9E5vz0mZJ2D6I6NH9W/l
         ln3xH+q5H4ZxJPfPkmbBgUUY40SnPIk5fDsGyeAhYA3HqOBC/rCv5vMledURFHpv4aNj
         Ru5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JU7gxEFwqK+Oxre///Ayp0+fP1f8xI82V+ZomELLvp4=;
        b=bv+FIYbT8VczK/Xtl4PvcNQbuLoO7cF8mA1ceGtl0v4llpyToTmhxTUE/STTgOR9CW
         NC4m7EVNoicehgdTAw4qqCGU5q5w+/7PodkYXfxmXeaLlknUCAFX6qnHi/SJ6pe9FrJg
         RRPf3wULaImzZRWPFScZxyePtN9GpVJsPA/HpYHP3oqtm1R3KdzHE2n9lqqCqUxH11rP
         oPBSMP8CTBOglniX0e8wNvbVA7XhKp+iifkZRu4/wjP5OnXhfo30uByQ0mMOmI1C9mMd
         LVZ1dytjuDZ9SZvHnZWM3tf+i7eGeVh5wksIvdwd8YugynoX7EEp7h8dCRLqjRoUGUfL
         AXfw==
X-Gm-Message-State: APjAAAWYa2vSJK9csjzqzXuG4MmlCf80NOMzHcZqebbtaQnYEO5cYdlF
        UWXFP2IZ5Y2+9WiMjmEo5H1UXu8v
X-Google-Smtp-Source: APXvYqxFpO/dJx50hzO5j6R0vnqEpN2UskYHsdUTUvY8vTeSxERiuoJAxTUjAKW6VvKZDkKTFqxcCw==
X-Received: by 2002:a17:906:ccdd:: with SMTP id ot29mr33226021ejb.204.1582282044212;
        Fri, 21 Feb 2020 02:47:24 -0800 (PST)
Received: from jwang-Latitude-5491.pb.local ([2001:1438:4010:2558:d8ec:cf8e:d7de:fb22])
        by smtp.gmail.com with ESMTPSA id 2sm270594edv.87.2020.02.21.02.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:47:23 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 01/25] sysfs: export sysfs_remove_file_self()
Date:   Fri, 21 Feb 2020 11:46:57 +0100
Message-Id: <20200221104721.350-2-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200221104721.350-1-jinpuwang@gmail.com>
References: <20200221104721.350-1-jinpuwang@gmail.com>
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


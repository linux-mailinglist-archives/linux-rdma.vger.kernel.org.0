Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F61A9879
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2020 11:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408428AbgDOJV6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Apr 2020 05:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405297AbgDOJV4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Apr 2020 05:21:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5FEC061A0C
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:21:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k1so11010146wrx.4
        for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2020 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=AP01Fz+J3iar2E8zAzRwSbGq6J5btXocj1naiyK6aV6oO2naqSE3EQZ3ZRr6JeqT0C
         YNfSOjiXOgYT030rl1G8vLdrb5iVUsISZkvKL2AvDIWK6hWPglbg3jDKoYveRo2xTlSU
         sHXOrYhBuMqfXbIPABFtsM6AOu7xVsX1pBW15pI0mEXvvNLYD48d0yYZMWkhjL8NyTOJ
         NAHwRZlhKQ36mSBqQ2QMV4DyfczF0Fb8asvbogbkytqebyvo+omP3WqWQX/XuosNxkIe
         kIIzu1c8XrcOeltLaJ53JvMlTgtvlQfWdacIaPTkN1hlotbcOaUUwOCbiL2MELj+BK3k
         2D8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lsw/Iaiux+MLh4zGmzRDP0c55QH0mpEc78oqXzNiG98=;
        b=kx0/wCtFq76Dozr8S1MrT+tmbe+kKCTigcV1/xsn6vuB1YMSQROV3x1ofw6S4nGJqL
         Js881KSVPx+nSndwZfm50aeQ5yVofriNm+sbcmdnH2usOf6uUZkJyJtVsQjedqNqwMWG
         xxj5TjWlnGFFaC/c4rrUqtJ2FJPb8ZGz2cn6RJqKRfjabgd4XoeiY9kckva31uWK3ooU
         TQgQyGez9nS3LrtEMYvVEr9F7tNpFDzuCwu+tNl1wUp7q1+h1GlP2v/GYrFKE0T04fCo
         gnVWaVNUdV7beKcu1Rx+TGyVwPIPvHvwcI4QDlkIWCkg4R37OF8qyJ5pZrAZy7AresDM
         kepQ==
X-Gm-Message-State: AGi0Pubm0Bd0UZZqANWo9s4PzCqoqBki9opeN8dvLBqXbodNUuk2JvZw
        Xx3HV7KvTYiLw/OAYrLdvsKz
X-Google-Smtp-Source: APiQypLsqG22QZWeFoVMXZG8q5JrTXXNY5wde4LPzpchrO/6FZiARk3OSMxWx53p8sQ3RQF2n6+qAw==
X-Received: by 2002:adf:e3ca:: with SMTP id k10mr11353040wrm.53.1586942514244;
        Wed, 15 Apr 2020 02:21:54 -0700 (PDT)
Received: from dkxps.fkb.profitbricks.net (dslb-002-204-231-072.002.204.pools.vodafone-ip.de. [2.204.231.72])
        by smtp.gmail.com with ESMTPSA id v7sm22534615wmg.3.2020.04.15.02.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:21:53 -0700 (PDT)
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v12 01/25] sysfs: export sysfs_remove_file_self()
Date:   Wed, 15 Apr 2020 11:20:21 +0200
Message-Id: <20200415092045.4729-2-danil.kipnis@cloud.ionos.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
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


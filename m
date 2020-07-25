Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE04922DA21
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jul 2020 00:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgGYWFB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jul 2020 18:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgGYWFA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 25 Jul 2020 18:05:00 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6169CC08C5C0;
        Sat, 25 Jul 2020 15:04:59 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v22so3665638qtq.8;
        Sat, 25 Jul 2020 15:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORj8ts7tAGRiEo5hGbERimOD2nuQgJZB1dWj3IpTlc4=;
        b=TA5BzKw5Fy2VrqhNGS5adDNkjAMk2Ozonbl6X+CNDcQBSjU8dH70YBm/mgJxQZDeEU
         mTtYJLs0Wi3OI/09FXhe4itg8dg0Z8VtmBfOqAsjmvGp8zzObsoVApdHkEHyqiT1oKDI
         CYA3m4GEkeQJ/yopNwx8cyY94qFAA7u7PKi4L2Q8lZYogQRe8oealTjJgZHj8DQRGCiY
         +L61pUqPA7g09eha1VNdn63zV8SdKUBgOYSwLfSJ5uAtJxXKRZ7aSbpuGQJmkeEtPUwh
         CVgK7Kof7xEC4UD9/yJMgTCKRt2TQ1UxuYAwezs8EBkoMIea43Fgh1bj2MQTVlSlrn52
         lQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORj8ts7tAGRiEo5hGbERimOD2nuQgJZB1dWj3IpTlc4=;
        b=J6yzedAS+4IVrp61vlyIOI/Axvh1YM23BgyZUt4UyL2qLs0oBl1mp9lezqFaNsXs1L
         FWfvPKQUl/HtV1v+ubDCGlDNbJKNmyOz84W4KbTvKagXkGKRCYUqynxV9xTImxZQXAx6
         U05AL+YvLK1jPG9qXK8HNkoUN08J7N4Urq7zbWTmSifUMyVkLj6XdzHA7mWi6YERLJMn
         NPylvbf/lN3qyti8monwXewhPoi4B+K8uBNkArBI8voNhG23RkJDc5JHpjfqHuZt9Zmh
         aLQ+Gv7xJTplc7cbIBrlY3/7/+Cq/9Cirf1UdVpf4Od+nKFqwK8aGeFlL8yk6g/qdE3I
         f0Bw==
X-Gm-Message-State: AOAM532/yF5ui7UQsa8gUqi/WmRmuwxC3cen7fDGPRSZU6PUBzjrIGqT
        U/OP6NnN54748fB4+bxnVOKi8wDjqg==
X-Google-Smtp-Source: ABdhPJz7E+iPwoBo/pvoBW9iN5HOxLTbBllS4XSHUeC2hqrK35sLHRmkovlHKJAn8ey4pn3T5jsLlA==
X-Received: by 2002:ac8:4e2f:: with SMTP id d15mr15620334qtw.125.1595714698435;
        Sat, 25 Jul 2020 15:04:58 -0700 (PDT)
Received: from localhost.localdomain (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id 8sm12306554qkh.77.2020.07.25.15.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 15:04:57 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzkaller-bugs@googlegroups.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] infiniband: Prevent uninit-value in ucma_accept()
Date:   Sat, 25 Jul 2020 18:02:03 -0400
Message-Id: <20200725220203.624557-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200725194839.623653-1-yepeilin.cs@gmail.com>
References: <20200725194839.623653-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ucma_accept() is reading uninitialized memory when `in_len` is
less than `offsetof(struct rdma_ucm_accept, ece)`. Fix it.

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 drivers/infiniband/core/ucma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index a591fdccdce0..842d297903c0 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1134,7 +1134,7 @@ static ssize_t ucma_listen(struct ucma_file *file, const char __user *inbuf,
 static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
 			   int in_len, int out_len)
 {
-	struct rdma_ucm_accept cmd;
+	struct rdma_ucm_accept cmd = {};
 	struct rdma_conn_param conn_param;
 	struct rdma_ucm_ece ece = {};
 	struct ucma_context *ctx;
-- 
2.25.1


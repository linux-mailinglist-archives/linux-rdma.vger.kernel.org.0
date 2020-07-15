Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CEC220F09
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jul 2020 16:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGOORZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jul 2020 10:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgGOORZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 15 Jul 2020 10:17:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6D3C061755
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:25 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id md7so3040757pjb.1
        for <linux-rdma@vger.kernel.org>; Wed, 15 Jul 2020 07:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oi7/bEOrEVU9g85zBQqhG+l8VA1lhBsGmRB6d5f1QDg=;
        b=XvEhM4vrVo1HRLQnWho3wlsmFi13GsE2WHPxWHBTUoi4syTUSF8njVcE/UdFQfiWp+
         Joc42QchHx9tk74EGnww6l9JbvkQNqbCI+WNt/c+nkviCWS8gtsPwFUnPnXBXKjLhfZe
         5w3hZHw1lzeC3qaagnRxl+zy4lp4Ys1SQkiRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oi7/bEOrEVU9g85zBQqhG+l8VA1lhBsGmRB6d5f1QDg=;
        b=BrUAu7VcOC7ZX2GwslzIW41zCRLn2mHEKTz4zurt6JhVrsWUqmnVrSpXnxEeq2WSGm
         nzS8D88tFc6ntlJWwtqguBTyGOtMf+wdnK9+eV+WtXn5k6HGPEFfu/t7/d4i73DJzwrK
         ixcO1Ws3HA50hklwNh7hhzCHE8OOOU4kSnmUqsPRH5Lcqxgm3Td1NeQKgOoIWvG84N9v
         KKQGgs6b4mEDMOngzzMRzkAbfDa3cxiWk7h1kG1TmVasyQmBP83PIOtW1AQP6/GDIS43
         Rtm4eHNQ8k4Oxf0oRzoci4bi0BI5DzIuhWpmxL6UOl1CqEdJPc9HiLbzyRDP7iHJLyiM
         HiLA==
X-Gm-Message-State: AOAM533/FMoo1ZOPqOOQ2w9hGYOcjWjxXCTIz7LFu4SUhT/c3UFlN9Vf
        m3uCgg1xki14Oal/jF3KVbxtKSetnMBD3N1t5LkvXTJ2wZcZh1B/ZmOeZ/QxYyrAGN41AsR6abE
        QCPFYOTP1PrjXHGSOBcgBjXzcycfLyKWxBekti49KUVMwBhlIiwzrDIwBxDDuxVR0g9S7P08EuO
        hbC6Q=
X-Google-Smtp-Source: ABdhPJzJQljQhvb4W830qHbf1COmkZw6gFq2dQrFGMvOSxlHdVN7R+qcw9s3BdCU5/UqmVXQacMahw==
X-Received: by 2002:a17:902:76c4:: with SMTP id j4mr8421239plt.131.1594822644094;
        Wed, 15 Jul 2020 07:17:24 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k92sm2399254pje.30.2020.07.15.07.17.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:17:23 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org, jgg@mellanox.com, dledford@redhat.com
Cc:     devesh.sharma@broadcom.com, leon@kernel.org
Subject: [PATCH V2 for-next 6/6] RDMA/bnxt_re: Update maintainers for Broadcom rdma driver
Date:   Wed, 15 Jul 2020 10:16:59 -0400
Message-Id: <1594822619-4098-7-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
References: <1594822619-4098-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Adding a new co-maintainer for Broadcom's RDMA driver.

Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b5ffd6..96d6405 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3582,6 +3582,7 @@ M:	Selvin Xavier <selvin.xavier@broadcom.com>
 M:	Devesh Sharma <devesh.sharma@broadcom.com>
 M:	Somnath Kotur <somnath.kotur@broadcom.com>
 M:	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
+M:	Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 W:	http://www.broadcom.com
-- 
1.8.3.1


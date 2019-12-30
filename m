Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4546412CEC0
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2019 11:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfL3K3s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Dec 2019 05:29:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32970 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfL3K3r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 30 Dec 2019 05:29:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id r21so32188057edq.0;
        Mon, 30 Dec 2019 02:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JU7gxEFwqK+Oxre///Ayp0+fP1f8xI82V+ZomELLvp4=;
        b=pH8IAXIfMXj9Y1aiSFl414+YQSO5L0upzqDFAYFYOzw9cNmemAC/Hq+8mrRuIZ6quH
         doqZiRYCdbj0CB3hiUUCF1bzO6j4uhH40Kf8+xBRb46ciH2VQNzM2QR1VzVV0SBFrqUi
         ml+DyE9/KE4mkdsV3JuEElcejuX0IkGVFdlopVtUYtBuHy/lISNCjP6hCb67zmaSYWzq
         0qBL9wWc2q7WdVChhSvLcBcnjC0hdbtHp9YSwhfYqryXBB86qfsYAiXua3+78jjUoSLg
         pPw9cmqSRLAqKuZxP4poHVBDMZGmFCoHA0ERrQWtkXAZMylPBNxXS50y74LUCO1y2DdG
         mG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JU7gxEFwqK+Oxre///Ayp0+fP1f8xI82V+ZomELLvp4=;
        b=R2HubJPYomzPxOMJIEGfymatx1QY2P+S78ttWk3ZMTCTIfQde4QcQnFNhbCqc3kiNM
         DNYzxuOQjmYGBj4j28JRVvz0l/EtadEutw7q6mSR9Hn0AaBFmXH6RlknE27UawLmde8S
         JRlLmp6tRIxgypa/BF70RA1bgn4H+fXp0IdJSyfN4xDvrUX32xH8gp4yxcapNy9V/3ef
         +W26nTesVmdwA7rx4crR1o6yK1PAkz782ZTnOOxr6ozRuXHF+d9Xw9zOf4l6MaZTJ8T8
         1phDMUsgU64S1qIdJqrd8pC3feCZ03uO37VlTQKw571QFJNwox9frWk7qMG0yMLv0X2U
         O02g==
X-Gm-Message-State: APjAAAXJQP5AMa4G6ejcqhoQXSTp7BzFxYltDy4I36TWzcLFovn9J6E8
        S4aspFwv6RyZyNMsJRP7OFvy9ZXO
X-Google-Smtp-Source: APXvYqxp1zS616sBDPUF7qtXJb62R8kaHIbpnARiTA62Gh0GRwiYekExzm0+rK+5bX+nxzyqBWL+Pw==
X-Received: by 2002:a17:906:b88c:: with SMTP id hb12mr45678897ejb.150.1577701785664;
        Mon, 30 Dec 2019 02:29:45 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4955:5100:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id v8sm5246630edw.21.2019.12.30.02.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 02:29:45 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/25] sysfs: export sysfs_remove_file_self()
Date:   Mon, 30 Dec 2019 11:29:18 +0100
Message-Id: <20191230102942.18395-2-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191230102942.18395-1-jinpuwang@gmail.com>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
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


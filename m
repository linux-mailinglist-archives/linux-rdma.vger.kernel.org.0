Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFAB6127FD7
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfLTPvQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55643 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTPvP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so9422269wmj.5;
        Fri, 20 Dec 2019 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FBGFHijkhBj8M8ct4LxcxlGMdgTinywxn+ZNcqtzm4E=;
        b=MWRgizaWZzKENAU+jjYV2UrApTSuNpS0c3Nnkq2jKK6gcb4XbP+ml31aRay2V9Dkmj
         ct1Zs2JoimGE4568wzb2dday18ftEgu1IlEedu/rCymy0rFerCuL4mZbL76UC+65Q0Qm
         doe1V3gFCFf8q/stalROUIu3KHnJJFxlISApJWj53xAQXr1UcpfcpC9KsADR78puWGBN
         ZYspBJ1kmWhfyZXZ/zQlx9jwk3iEzGcARmRPEgavKCWQN/RjLERVa0BRY6F774HnPeVY
         tYn2KF1BIGZxyyKmYFSDsL0rpA4epS8Ndah8jLTcmxiR9PLRGlKtqgj99irueHrqilBe
         VQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBGFHijkhBj8M8ct4LxcxlGMdgTinywxn+ZNcqtzm4E=;
        b=OC7ogm9c3orScSWSfQ6IkdjILbipTeHgqXtNl25dMBkSzmwnx8fWBWCDHjz9n70ydb
         /ljLcbSHlGDRvI215oLIUg6tfHKhw+gDjpxhLx/PXBN51/KtDhw41QSVNx8ojFq+U0AH
         I2xKfE7y+vf5Az+9ekS4DdoF/488aKp3PpqhOaFcJAYoHwupfNpCGEf8/2gPIddC54uO
         44/ztY+qWlM6BcgEbY/L7AEyAAj25AcCEace6hZc1OrdVMtLM7Ghyd9hyXgrTIGPcS80
         QYlcXgui9v3SWL5j6Ug+ASK3+JsNZMLGJ6DPtn4c7214lluu1v4Z8JV+f7xKjPw4LSmT
         OFXQ==
X-Gm-Message-State: APjAAAU9nQ4vk2xOxLIk0wCWMSmRnrbTEzBYtSkV+X7vwF+kl0Lh8ibq
        7+Kp8qixx6vlrKtjm7Xz9+riqXvnAks=
X-Google-Smtp-Source: APXvYqzrHGMJgV2ucmBoCK8NwW3h6j8TxTWzJ5fzXyW4p8wJCyhoGnLEMNNzPGhH+tQUTKoUUhgUEw==
X-Received: by 2002:a05:600c:24d1:: with SMTP id 17mr16885255wmu.136.1576857072864;
        Fri, 20 Dec 2019 07:51:12 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:12 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de, Jack Wang <jinpu.wang@cloud.iono.com>,
        Roman Pen <roman.penyaev@profitbricks.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/25] sysfs: export sysfs_remove_file_self()
Date:   Fri, 20 Dec 2019 16:50:45 +0100
Message-Id: <20191220155109.8959-2-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.iono.com>

Function is going to be used in transport over RDMA module
in subsequent patches, so export it to GPL modules.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
[jwang: extend the commit message]
Signed-off-by: Jack Wang <jinpu.wang@cloud.iono.com>
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


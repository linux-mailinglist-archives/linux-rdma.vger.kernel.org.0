Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A692D4707
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 17:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgLIQqc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 11:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgLIQqb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 11:46:31 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4103DC06179C
        for <linux-rdma@vger.kernel.org>; Wed,  9 Dec 2020 08:45:51 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id jx16so3049095ejb.10
        for <linux-rdma@vger.kernel.org>; Wed, 09 Dec 2020 08:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JknM2yxNHMOxu0rXy2XeTPqfIzGYyAoGhyRH8bfhhfU=;
        b=Et3rKt+v8wo4CAM2IKXW2yYEaI7WcN0ADv7kqeFNFgPSgFEr4uQoH0xaGqrnjhis4R
         TsFgs0CcdTzmcGED77HIaaJ9LnGWq+lmc7IwxGWjlfNhtuCQIQ8BrGfcGhVbBg4dxjDP
         FkHS+Rb9JCYoezFhbxkxNWCLE5vIxmv/0bl/YnT0w5Y1TJsfk98WhZ8oBxKlZ7YyTmJo
         Y75Gfqe19NVczuHpV/HBc3VlAKWH7h8Z0L0d6MCb+uP+U1Can/KdTyxUgdg3SCZzPhc+
         xpMMnrrdgCc6M8cMueZODXNOUN3e9SuIcjUuaZhGJdusl7V6jRZ1JosBBzzLFY+1xXhD
         cvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JknM2yxNHMOxu0rXy2XeTPqfIzGYyAoGhyRH8bfhhfU=;
        b=JyDvb+6UJrjRmK5BABc+b8NztyeLUwC6KFAMVa/oduRqokuf2I/9kVo6DmmvozhK1W
         osJWIOVXsJGcbd77SsJ4kGPcINng0NjPt3p6hBkpllyGqcV0wAEWTbRAnjV6qnGd5Ri2
         Gp8fCgQ6fuQGnDPOHGs862tLUa4JF9dvwCFcecco/YH+2cSfkfLMG3CfleSDrNc+VBE9
         QrzkZTgx3JVrx5PpH+32Eg5ve9LOCofy5OG9ur9tNM4cr5WDdtC8b/23Syezp4g1CH2/
         o6hl7oATX0ocsf4dAkeONHvO3yu8pDzlVffx2n9U5OIMOhDMpPid6JH9L8oamIQN0cH7
         Orfw==
X-Gm-Message-State: AOAM533YXszMsHJWKLAwh1ezVeFQGMsE0sCWfC5F1aB0geVpimQaIoWJ
        z+7HvsTEZI4TG12n+N2q1W5kyPUZbEY3vw==
X-Google-Smtp-Source: ABdhPJwto7PuDjvkT0v6oBggsjglb1shWfc/zdUX0z8j8uuACraunI0ugJScRIlPzEq3EhzHGrIU+A==
X-Received: by 2002:a17:906:e093:: with SMTP id gh19mr2819101ejb.510.1607532349719;
        Wed, 09 Dec 2020 08:45:49 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:49e0:2500:1d14:118d:b29c:98ec])
        by smtp.gmail.com with ESMTPSA id h16sm1977915eji.110.2020.12.09.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 08:45:49 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Subject: [PATCH for-next 04/18] RDMA/rtrs-srv: Use sysfs_remove_file_self for disconnect
Date:   Wed,  9 Dec 2020 17:45:28 +0100
Message-Id: <20201209164542.61387-5-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
References: <20201209164542.61387-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove self first to avoid deadlock, we don't want to
use close_work to remove sess sysfs.

Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Tested-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index d2edff3b8f0d..cca3a0acbabc 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -51,6 +51,8 @@ static ssize_t rtrs_srv_disconnect_store(struct kobject *kobj,
 	sockaddr_to_str((struct sockaddr *)&sess->s.dst_addr, str, sizeof(str));
 
 	rtrs_info(s, "disconnect for path %s requested\n", str);
+	/* first remove sysfs itself to avoid deadlock */
+	sysfs_remove_file_self(&sess->kobj, &attr->attr);
 	close_sess(sess);
 
 	return count;
-- 
2.25.1


Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C232A17F6
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Oct 2020 14:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgJaNqq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 31 Oct 2020 09:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727401AbgJaNqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 31 Oct 2020 09:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604152005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=c8vUJq07yKW3wKxpozeAM0ASxuZkYbMJQ+/1NWKmFkQ=;
        b=fyGMkj/71VzCPsuhuvAS+T34KW8eE29BSU+8dtNvKOR+n+2BDIwfSIPDQ7Dle1i1FGj19R
        IBs9eCTmpMniAtWTEvAlHuL+ijuduXHL4TzY6GGurSydcbsZXsuuZUCz17WhZ5WMnu1DWr
        k8kDIlF0SAzTyjR7lCu3l1YMLZs18wY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-4ZJCA0yFPUGxbTimTb38mw-1; Sat, 31 Oct 2020 09:46:43 -0400
X-MC-Unique: 4ZJCA0yFPUGxbTimTb38mw-1
Received: by mail-oi1-f197.google.com with SMTP id 17so3795870oie.4
        for <linux-rdma@vger.kernel.org>; Sat, 31 Oct 2020 06:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c8vUJq07yKW3wKxpozeAM0ASxuZkYbMJQ+/1NWKmFkQ=;
        b=WbuxPq7Dc3G0genlxk9t/vcnHdwIRakGAPJXbjLf0MOl0MqW69qSBbARS43soNzk3W
         sDX6jdJh5Fw70vdeLpk80p6TFlD8fpRfk+FXS9N7Ib0LKRpoTNAwMH3nHtTb1C1ODy14
         pvd6rHlu26JpPP3DGGIf5coCLCxF+9lvtFZE5PAJm0XtWvSgTvnnZm0G5k3fAtI2L0Id
         RG5dGXoqRe7joUsOAIAoyA4duQxC0Et41pAuZcJfjXwpPuRrUWQpNV02nViWhqNnk7Ql
         EQd+M5nSt2E5vBslV4EMHQkCShEb6q72FKfMyZ/844HzL74ZZwPHx0xm6rVdOjygcNpo
         qLRQ==
X-Gm-Message-State: AOAM531OB7UZX0g+uFfOm9K3sDCeWJ9FLzAMAy0U+a3bYnecGRajPKVZ
        npEHpFlRueutiObkLcps28q3SY066M8cKP2dMhPo19zp3s+DnMan85klBCNI2VPJWwV35faeDXs
        /e8xOCUC+VRIxXG7ZOTI9lA==
X-Received: by 2002:aca:b246:: with SMTP id b67mr4934668oif.17.1604152002972;
        Sat, 31 Oct 2020 06:46:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxopvD8vKGdwcJHbit8rJ6oaoG7N/GbA7LoGBxGOsGWH/5rX7ILmNkVtIMI+aFETQPIsKWlkQ==
X-Received: by 2002:aca:b246:: with SMTP id b67mr4934660oif.17.1604152002826;
        Sat, 31 Oct 2020 06:46:42 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h7sm2064262ool.34.2020.10.31.06.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 06:46:42 -0700 (PDT)
From:   trix@redhat.com
To:     leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] RDMA/mlx5: remove unneeded semicolon
Date:   Sat, 31 Oct 2020 06:46:38 -0700
Message-Id: <20201031134638.2135060-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 600e056798c0..6aad0f39c50c 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3102,7 +3102,7 @@ static int ib_to_mlx5_rate_map(u8 rate)
 		return 5;
 	default:
 		return rate + MLX5_STAT_RATE_OFFSET;
-	};
+	}
 
 	return 0;
 }
-- 
2.18.1


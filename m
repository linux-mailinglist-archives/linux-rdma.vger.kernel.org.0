Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4A524C251
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 17:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgHTPhJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 11:37:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33764 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729187AbgHTPhG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 11:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597937825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8WVuvSaXvXDG6ADiUEewIuVlyBcC/65YPJpThQ3IvVg=;
        b=PVtYV4q1JIijLC3tTS8c20lAV2xfqNqyAH3lrR0iCOxgTf1wWQ6Kw+xQSFms17yiCOD6BP
        EJTC7Z41WVNXTE5neH5Q1f+9GfWARWqn/qZ4UmRgIai1dztnxoRAU6sCI9sl7pwqvrzU11
        ADTmYhoNPlObuYWf0HSDKVDddtD+dlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-ttlpU9RtOn6_AVKNSxGcPw-1; Thu, 20 Aug 2020 11:37:03 -0400
X-MC-Unique: ttlpU9RtOn6_AVKNSxGcPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C083801AE5;
        Thu, 20 Aug 2020 15:37:02 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (dhcp-12-105.nay.redhat.com [10.66.12.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7744A19C78;
        Thu, 20 Aug 2020 15:37:00 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-rdma@vger.kernel.org, jgg@nvidia.com
Cc:     bvanassche@acm.org, kamalheib1@gmail.com, yanjunz@mellanox.com
Subject: [PATCH v2] RDMA/rxe: fix the parent sysfs read when the interface has 15 chars
Date:   Thu, 20 Aug 2020 23:36:46 +0800
Message-Id: <20200820153646.31316-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

parent sysfs reads will yield '\0' bytes when the interface name
has 15 chars, and there will no "\n" output.

reproducer:
Create one interface with 15 chars
[root@test ~]# ip a s enp0s29u1u7u3c2
2: enp0s29u1u7u3c2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UNKNOWN group default qlen 1000
    link/ether 02:21:28:57:47:17 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::ac41:338f:5bcd:c222/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
[root@test ~]# modprobe rdma_rxe
[root@test ~]# echo enp0s29u1u7u3c2 > /sys/module/rdma_rxe/parameters/add
[root@test ~]# cat /sys/class/infiniband/rxe0/parent
enp0s29u1u7u3c2[root@test ~]#
[root@test ~]# f="/sys/class/infiniband/rxe0/parent"
[root@test ~]# echo "$(<"$f")"
-bash: warning: command substitution: ignored null byte in input
enp0s29u1u7u3c2

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index bb61e534e468..756980f79951 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1056,7 +1056,7 @@ static ssize_t parent_show(struct device *device,
 	struct rxe_dev *rxe =
 		rdma_device_to_drv_device(device, struct rxe_dev, ib_dev);
 
-	return snprintf(buf, 16, "%s\n", rxe_parent_name(rxe, 1));
+	return scnprintf(buf, PAGE_SIZE, "%s\n", rxe_parent_name(rxe, 1));
 }
 
 static DEVICE_ATTR_RO(parent);
-- 
2.21.0


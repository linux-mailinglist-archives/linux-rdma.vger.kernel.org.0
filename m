Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476EB45968E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 22:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhKVV0J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 16:26:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229502AbhKVV0J (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Nov 2021 16:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637616181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u0jYzxh/bl3enkYGRKKDtDDzWLh1bvgX2liKJ9/7ldw=;
        b=B/yqKZCaYtIZKPGpgvHipAMu0BUZ4XYu9p1ACp5glIOMo+MGMk/YKRSLYEDQIZin4/xdUc
        d/4oOQjLRB3qrobCFh+iBshwMv133tM00jwPV5TGmDXnPLdHicuFps1H7IFgsCT7Nwxt5S
        9JBV/b39M50vOaZvDzVLjhiWGjLeiOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-5TcXBCvjO0e-tUldz58tNA-1; Mon, 22 Nov 2021 16:22:50 -0500
X-MC-Unique: 5TcXBCvjO0e-tUldz58tNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A743187511E;
        Mon, 22 Nov 2021 21:22:49 +0000 (UTC)
Received: from linux-ws.nc.xsintricity.com.com (unknown [10.10.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15A3856A9B;
        Mon, 22 Nov 2021 21:22:48 +0000 (UTC)
From:   Doug Ledford <dledford@redhat.com>
To:     linux-rdma@vger.kernel.org, jgg@nvidia.com
Cc:     dledford@redhat.com
Subject: [PATCH] Remove Doug Ledford from MAINTAINERS
Date:   Mon, 22 Nov 2021 16:22:19 -0500
Message-Id: <12fe41e3d0a515e4fcf5c9e62ac88c39e09c1639.1637616139.git.dledford@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Signed-off-by: Doug Ledford <dledford@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ecf376f8f82e..9b34a03b6cbc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9318,7 +9318,6 @@ S:	Maintained
 F:	drivers/iio/pressure/dps310.c
 
 INFINIBAND SUBSYSTEM
-M:	Doug Ledford <dledford@redhat.com>
 M:	Jason Gunthorpe <jgg@nvidia.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
-- 
2.31.1


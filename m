Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F373D1955
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 23:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhGUVBZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 17:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGUVBY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Jul 2021 17:01:24 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EACC061575
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 14:42:00 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t143so4421580oie.8
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jul 2021 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zm6djJrwh5iWBFtFToqv2yEzVAqAM30+mKuHw73SS3E=;
        b=uJoJuwvzChkphbfLeJ6oigxGmcpij8CYf3EWIBZg2b34aipNQDXXuUXcGg/Fb6y8TI
         PKm1wanOjas4hysx8uqmuRtkkWSG/T75bdUjEAnQmB5m2LB3SZ3Btev4zmA/toClfFGc
         I1DUcbvYIYwS82baTSZ2o5OmxssoBzny+d4nf86AM45qvVpYj+1Jd/0TI/z35R/Aj46T
         gA+Q/b7Q9I/vIoYBReC0eilvMn+YSnSgMTsFi/4WocOvZtDUKcLon/1Kir6Z975oHNH7
         uO/r7lYKyncrZ2XiMcH37Jyi95Hvh28Sf4iKK8HJ6TQppds230RmoWxRhAum7cOT70tg
         +Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zm6djJrwh5iWBFtFToqv2yEzVAqAM30+mKuHw73SS3E=;
        b=hfG3OvbE0RCSBDy1HXCK2jP6v7vlEMcF762YbXt8qtp/iknxx14c25Hynr+BV6971K
         fBI4q30w2WSmJWGbf1g9OhJW4LT8ZblyTj4hOLYU9eGqN6zguyHcMxZRevyPipPJpYpE
         1KwoOszShVjGQpuwp99Kn/5gc3wDGvY9di2GEEm0a/i0kB9LXDWPSd76K2i9lkgg0fFv
         PJ6rjlDY90n/pexONd+0v5HviYdRCEOW7dQLefnlrm67cnIjqp62F50lRs17F/x70UyS
         WNshHk0J/FqnoHEJRXGBXInQAB6GqPbGO0S6gLf2JD3D5jVaV0hFpFjlRMHyf4MCmZQk
         lopw==
X-Gm-Message-State: AOAM531ywIu+POrzZJBHqiuNSvoYx4h2kQnrbt/VpcJjW0e4mN0jS21f
        34ax2b2HNlChl+zBm5f9UC0=
X-Google-Smtp-Source: ABdhPJyGIKms0efYAIkXL7ESd1HEk4ZLjXUgS05H2unLYuO9YfYalcxmiftFeQdirromfrspN4v0bw==
X-Received: by 2002:aca:e108:: with SMTP id y8mr9294219oig.43.1626903719535;
        Wed, 21 Jul 2021 14:41:59 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-f09d-c26a-c3f3-d2e6.res6.spectrum.com. [2603:8081:140c:1a00:f09d:c26a:c3f3:d2e6])
        by smtp.gmail.com with ESMTPSA id i188sm5254512oih.7.2021.07.21.14.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:41:59 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, aglo@umich.edu,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next] RDMA/rxe: Fix bug in rxe_net.c
Date:   Wed, 21 Jul 2021 16:41:06 -0500
Message-Id: <20210721214105.8099-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

An earlier patch removed setting of tot_len in IPV4 headers because it
was also set in ip_local_out. However, this change resulted in an incorrect
ICRC being computed because the tot_len field is not masked out. This
patch restores that line. This fixes the bug reported by Zhu Yanjun.
This bug would have also affected anyone using rxe.

Fixes: 230bb836ee88 ("RDMA/rxe: Fix redundant call to ip_send_check")
Reported_by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index dec92928a1cd..5ac27f28ace1 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -259,6 +259,7 @@ static void prepare_ipv4_hdr(struct dst_entry *dst, struct sk_buff *skb,
 
 	iph->version	=	IPVERSION;
 	iph->ihl	=	sizeof(struct iphdr) >> 2;
+	iph->tot_len	=	htons(skb->len);
 	iph->frag_off	=	df;
 	iph->protocol	=	proto;
 	iph->tos	=	tos;
-- 
2.30.2


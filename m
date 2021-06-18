Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435C73AC2B2
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 07:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhFRFCi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 01:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbhFRFCg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 01:02:36 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C39C061760
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:27 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k10-20020a056830168ab029044d922f6a45so122531otr.7
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHyRPNmnY9tc7MF1DY/Q9A2317r2YzuU0HtMnbgTbQc=;
        b=pb91xz6VrB7i+ewLrH1DXQWc6i0qDfu/kw4SQes9TzggKB4ms9lpvVS43xCREXg+6M
         0tsLzADjQCLSXZt/FcE9qdBjFHxB8LDe4P9iyDHdS9sqk3xC0HTphore+LyjesVyFFRq
         lJKiMvCN5CJ46LCK99ZER4kw4XrdjjwGMvvDhTbpERUcIEknt50MQh/OpFpu3Q5Fegh7
         QUNVoqeDmugZw8o9Csf3nE1Ti8MGVG31fUvc78xjYyd5rkNKJFXCynxDfn2NFL8K7UQ4
         2qb+6FtCGeaoPcqlhU3K6VEISh8NccpVhxcKLEDPnJz+lRb6Qxc+A/yBylOsMmT9D5L+
         HvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHyRPNmnY9tc7MF1DY/Q9A2317r2YzuU0HtMnbgTbQc=;
        b=dEo3hJTooiwaHQ3JKkpGG/pbBYExRMpYV3W3HGtCAK/dK/LVNVsuEoYxs0TtCzl8zd
         BnsyuOsBIPkaxjTCcgHCkc3jkk427Huf6iS2mREhnS4UbFSOyt6R4FJrD0c/56auN+j9
         S0CyISy1X7XqF+CBUWs1xr1dyhg6hCN1MTYPoAloe9s7mzmoCxWEyo0mu9Ok77XRRKMP
         gipGIw+cgfpaWv7Y45jNJv10DjpKyPjYJgiQyyXP1SUgKfX7BuDCqrHq9pt2iPc4XtnI
         xnA6q8k8h1Ddo3JXf5MGVjpx2M7+4du6ruQk1Gp+MOIBOqvX/jYo/AVkX+htXtLbDytw
         zdHA==
X-Gm-Message-State: AOAM5329zm3nACn/t8sYiGzuqpJArmWJH0dylLh5T2isYW4bfi7wMUol
        X4+si76cw+Dfyk9fUM617fg=
X-Google-Smtp-Source: ABdhPJyrOXfH5Bwyg/MtgoqvZ7fG0BTlBS3zbBSBhZ/uN+kbALZwkYSeFNuX44KF+t4MyEpREbHYrA==
X-Received: by 2002:a9d:226c:: with SMTP id o99mr7326575ota.134.1623992426559;
        Thu, 17 Jun 2021 22:00:26 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id p10sm1895736otf.45.2021.06.17.22.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 22:00:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 2/6] RDMA/rxe: Fix redundant call to ip_send_check
Date:   Thu, 17 Jun 2021 23:57:39 -0500
Message-Id: <20210618045742.204195-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618045742.204195-1-rpearsonhpe@gmail.com>
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For IPV4 packets sent on the wire the rxe driver calls ip_local_out()
which immediately calls __ip_local_out() which sets iph->tot_len and
calls ip_send_check(). This code is duplicated in prepare4(). On the
loopback path the IP header checksum and tot_len fields are not used so
they do not need to be set.

Remove this redundant code.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-of-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 01662727dca0..178a66a45312 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -269,8 +269,6 @@ static void prepare_ipv4_hdr(struct dst_entry *dst, struct sk_buff *skb,
 	iph->ttl	=	ttl;
 	__ip_select_ident(dev_net(dst->dev), iph,
 			  skb_shinfo(skb)->gso_segs ?: 1);
-	iph->tot_len = htons(skb->len);
-	ip_send_check(iph);
 }
 
 static void prepare_ipv6_hdr(struct dst_entry *dst, struct sk_buff *skb,
-- 
2.30.2


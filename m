Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8303AC2B4
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 07:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhFRFCm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 01:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhFRFCm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Jun 2021 01:02:42 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9929C06175F
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:29 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s17so438404oij.11
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m9KOW+bSN5MP4u2smbR76Tg9GFArQ6my58IXPLBIaeQ=;
        b=JOx9JCEoUBoFe4WPdWJlvG7HqDSBEzJfWR0u8dD5/92A5IKcuGpOVgixJRfGepZ9Vc
         S+PLa8Ikvl0bfttDlie3LuGidTUAl2VQCwTT0JBO8mfmgjtpCV1w3buWIjXssqIg7Ped
         r8kATz6g23xgXIxSz8JF52M6XM8LMQfscjYPYnCQyxpDuRtWs+MQ1ninjE6ZdyPcdUj8
         GAG3sHGqaZ4Gqwx+l5bq3D9/dxsg2KR4lm7o1SAw7vL/UxZoGU0Bgs0dmhqG2JW0HTik
         JRzGmI8tZSCCjEMOzLJPhztR/QyfmeE8DY8cex1ceV8SNRJpF1skdIxOWOKQ8gVXfdNU
         vb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9KOW+bSN5MP4u2smbR76Tg9GFArQ6my58IXPLBIaeQ=;
        b=onYS3UrSrJ6gy2Vk2B1W/zLIQK2r20e9XrIgNu6CjDoJ2tVBtFPkrQRhg+p//wWSut
         ZnXKf2B6wdKd6E9utSkXFnFXGxyxkEO+HULKa5rhsiyVrWm3BsP9Q6uRHw3/Lrmiu1Yr
         NdvHveMi1U4syNi3jjDzHjm7qSAdH/g8U33kpCFMBwYWrOmIlvLXWU1isDl10HivjHO7
         M/XGBH4WSMOYaCap9cXUi/+pGVp/GgJxXd7ViWqiWHw5EHfsnGGSRpJdJkYkUtRA77ih
         AyTa9B3cqYXsr7+6QxNf7iUGG6Jk5EMTkw7H1azXqDe9ODPiCTDQpoE4P4IS3xhpcrf2
         /9mQ==
X-Gm-Message-State: AOAM531aBaLT8YKLAAIuZtMrAZEKhPLNxti9dvwdjgTsBbo7BF6Tjl1H
        eArp5cSXjUHJuhVM4twjmQc=
X-Google-Smtp-Source: ABdhPJw2NyWsau60ODDreXpWNNg2xASkDPu3g8/Auo5u7UK0xrIN7x/4vQM6zCgmg/t/syONrKBFFg==
X-Received: by 2002:aca:d941:: with SMTP id q62mr13959751oig.166.1623992429316;
        Thu, 17 Jun 2021 22:00:29 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-2fce-3453-431e-5204.res6.spectrum.com. [2603:8081:140c:1a00:2fce:3453:431e:5204])
        by smtp.gmail.com with ESMTPSA id 30sm1788754ott.78.2021.06.17.22.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 22:00:29 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 6/6] RDMA/rxe: Fix redundant skb_put_zero
Date:   Thu, 17 Jun 2021 23:57:43 -0500
Message-Id: <20210618045742.204195-7-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618045742.204195-1-rpearsonhpe@gmail.com>
References: <20210618045742.204195-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_init_packet() in rxe_net.c calls skb_put_zero() to reserve space
for the payload and zero it out. All these bytes are then re-written
with RoCE headers and payload. Remove this useless extra copy.

Fixes: ecb238f6a7f3 ("IB/cxgb4: use skb_put_zero()/__skb_put_zero")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 178a66a45312..6605ee777667 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -470,7 +470,7 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 
 	pkt->rxe	= rxe;
 	pkt->port_num	= port_num;
-	pkt->hdr	= skb_put_zero(skb, paylen);
+	pkt->hdr	= skb_put(skb, paylen);
 	pkt->mask	|= RXE_GRH_MASK;
 
 out:
-- 
2.30.2


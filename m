Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B470C3DAE9B
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhG2WBW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhG2WBW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:01:22 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1F9C0613C1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:01:18 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so7369881oto.12
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ujbUpXCytEX4QfIpMH86Z619ZHoSG8BzpdB9NbKWoV8=;
        b=QyNhsgLZz60sI9dB+VrTIadXWVpSXxmqjwr2lL47SUpQGKBGZZlzzrRz+ncB6x1deO
         sgu0fat0dMGLGwvse+zoZlK+esLiz+kPXOevvJoZT3xrBGhGDXSpFi+pZEgWwD16ZmM1
         jY1QeqvtNnwkvxY2LcOYazfeY5lk7ftWdc2UjOvsCou93p0zlt99MkmXW7ZqCosn7JyR
         45acY1Cf3vKEBSzE6nW5rtlkPsq4uWRT/RHQcLW/l8uy2hoqCjFOTV9sAajCnNfwfIi6
         pq+YQcmfnS9sFU58pt4vXxZeBk5g9ddrCFyTnXunH6Xoh3WXRp/jDQvlnBWVo4hpvs62
         RWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ujbUpXCytEX4QfIpMH86Z619ZHoSG8BzpdB9NbKWoV8=;
        b=gwy6JwwAI068R0tnCv0xl60NRjaPd2S+ujfRby8upOXKK2T475HqlDO/3+8tb/n8g8
         p1g81fLRVl1YH9iXQrqBRbe177eegcLYuRuamCt0W10q8+WkIVTheQjolSKINObjLGgk
         L11fhemCqfEeQBd9h5hrwu6MLqH2L1h4cB27EIGK/J/2uHKMmM2K4Qdb2lhhVqMSkJdo
         T3euBBlnqPIJ/fXsxp/xapsDIVQ3Et7y7/b+FO9HFNond11fkGgvIdPCajgmLAhWZ5tC
         Wlds59O9CxRe2XpRpPkJjQp4boZcnrRkItusgQV1fpBjxmp4Fw4X9JPiHWoKuv2HEXqw
         9DDw==
X-Gm-Message-State: AOAM530Baxk7ZoM/CUVwBpL6IvJZ8bfxAnpPSM4zQZYiD1Rq0fNJTtRn
        vXaFP4uaQZUMZApKOOt/5Yk=
X-Google-Smtp-Source: ABdhPJxZdGf3gG9DbArpUbDbW3yhlJ0siwp+BLScAZ0WrQCQbxREJBtnah1cgk9byizMsM0k4nOjAg==
X-Received: by 2002:a9d:4f02:: with SMTP id d2mr4832291otl.254.1627596077930;
        Thu, 29 Jul 2021 15:01:17 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id a24sm760833otq.72.2021.07.29.15.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:01:17 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 2/3] RDMA/rxe: Fix bug in rxe_net.c
Date:   Thu, 29 Jul 2021 17:00:39 -0500
Message-Id: <20210729220039.18549-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729220039.18549-1-rpearsonhpe@gmail.com>
References: <20210729220039.18549-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

An earlier patch removed setting of tot_len in IPV4 headers because it
was also set in ip_local_out. However, this change resulted in an incorrect
ICRC being computed because the tot_len field is not masked out. This
patch restores that line. This fixes the bug reported by Zhu Yanjun.
This bug affects anyone using rxe which is currently broken.

Fixes: 230bb836ee88 ("RDMA/rxe: Fix redundant call to ip_send_check")
Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 10c13dfebcbc..2cb810cb890a 100644
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


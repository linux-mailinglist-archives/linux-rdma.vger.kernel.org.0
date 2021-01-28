Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C32307DE9
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 19:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhA1S1R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 13:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhA1SYr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 13:24:47 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A7FC06178B
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 10:24:07 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id h14so6114278otr.4
        for <linux-rdma@vger.kernel.org>; Thu, 28 Jan 2021 10:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JGsahaa+eoKjug/TEW3KdLs7ikERuvJbeLTNXm/m+g=;
        b=olIpv3V7UfA3qDpBV2G4nr7F5OODoUQ+UpG1d8kIperGN8a67T63luhfOKtDLmiEpl
         WGOld26wJ9S4YhkGryzhNLE0mtcss2VK4weCCxF9bkM2v9uLcWttufjlrmzYHHrbbmen
         Qnv2nsvnpnAndCSopU0iQE1qSdxqLiLV8n88tJ7xYnhCBZwI4gG61gLN/cEdEuk2iq/n
         aZU6bPGX19Ex/oqwaNXYEkXvTOc1Fa5UkDXwMwn3r+w1gNxt8avrKvok8JAcsjb1eMP7
         EpQR1hjEu6j7NUmLdgQH79mg+cQ9lnK0cj4Z8mxrGbVztAi/tn7mkAE5FCegGavClrHn
         AVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0JGsahaa+eoKjug/TEW3KdLs7ikERuvJbeLTNXm/m+g=;
        b=VSzrKYrWtN/no5EwLKw8jSFehv29f417YQ3l7w0eWBwe0r1suJ8iO2ZM9zEOrcixWv
         3LYP9ZFpwDdei5xduZZUkuHuQ9exow2koUWh1jkOZMqb15thexNik3AxjYuqW7PA7HfL
         GnaiAWkxVH2Ip6GKVWqKPZg3/zWwIHNpAP2iDck9/magkRpK6DfIJMUgfjDIz0ldvJjW
         06ZWqB9kEITCLriz3S9Y9wRePZSmNIykupwaDkRgIO2LvQjPvry5G4KMW5qFkSxUZCdT
         NY/3ktoft2QI17ojMmxyIPeidf9rDxZkwSqRMFpiz8xO8QcB+VgSOyOCtXY+EHkygP0j
         YUaw==
X-Gm-Message-State: AOAM532b8gZyeP4CqFv7x3wnIv8JusTke5/48XkYh5Km2UIPxbLSYvu8
        Z6+QYFyI1U5cfIfQuZa8dZE=
X-Google-Smtp-Source: ABdhPJxHCLBv0xbyFEtf4r7PX9wAK9VoR9Ttxs6aQaRBw5u22A/SChakgvUda2XpuIb4u4mt1rQ9XA==
X-Received: by 2002:a9d:6e98:: with SMTP id a24mr480876otr.351.1611858247234;
        Thu, 28 Jan 2021 10:24:07 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ed32-ab84-718a-cacc.res6.spectrum.com. [2603:8081:140c:1a00:ed32:ab84:718a:cacc])
        by smtp.gmail.com with ESMTPSA id 94sm141948otf.41.2021.01.28.10.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 10:24:06 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next] RDMA/rxe: Correct skb on loopback path
Date:   Thu, 28 Jan 2021 12:23:02 -0600
Message-Id: <20210128182301.16859-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rxe_net.c sends packets at the IP layer with skb->data
pointing at the IP header but receives packets from
a UDP tunnel with skb->data pointing at the UDP header.
On the loopback path this was not correctly accounted for.
This patch corrects for this by using sbk_pull() to
strip the IP header from the skb on received packets.

Fixes: 8700e3e7c4857 ("Soft RoCE driver")
Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index c4b06ced30a7..0d4125b867b7 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -408,6 +408,11 @@ int rxe_send(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 
 void rxe_loopback(struct sk_buff *skb)
 {
+	if (skb->protocol == htons(ETH_P_IP))
+		skb_pull(skb, sizeof(struct iphdr));
+	else
+		skb_pull(skb, sizeof(struct ipv6hdr));
+
 	rxe_rcv(skb);
 }
 
-- 
2.27.0


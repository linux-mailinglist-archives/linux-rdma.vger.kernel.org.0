Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371953BE1BF
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 06:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhGGEEc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 00:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhGGEE3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jul 2021 00:04:29 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807F4C06175F
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 21:01:49 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso965893otu.10
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 21:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZW62XsamrXQDM8qOOE9QxYBZaa7HOU2EbGz8Tu41ogw=;
        b=R60jA6dCY0BocyND5JS8Hq4ZCK4NV0yhOFGqC/j/PKHL5C3YlnrbuFI3bh8yg6rlnp
         Ifz3lo7ibMSLvb/rn0KEiMFnOLpQYBr+N7WMcdzzsPa6oPA6bsm/472xsurQXsQALSjj
         xbuTMG/xiPfXa2BTnpw+70Q+UqujsMh2HmVbYqNSckF/HS9pdqQLocubKp6VwqqwV2fQ
         v2yfg1U7rgNKA1IhbPlpoADfkMMVVcIS5ahk8AcF3C8NV/9ZoLo9WYsfeYGO/a84LJJp
         3k/LWAO3wzgewNJnVBmdBEr6+Bq8S/KLtY3jWmk1IgfNSQ/DsLIl67qNZ1sPAJNrBnvw
         YfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZW62XsamrXQDM8qOOE9QxYBZaa7HOU2EbGz8Tu41ogw=;
        b=Y4SlLOEie8KB5KOoSc2LORJ9z9Wy6zi2dcp/ARwuoGa7HPKGSU9Gr0MYkF/sffwpZF
         LTJG2fW+LneJsvWfLdV0Z8Sw58VmVWhscz5sh0efiq2veSS5GQYSyj6mXFXOX3XW8KwQ
         T5p04yu0X5h+SjAxig9gzC5Z8B5TA10z+BcGu2zZ6sRAujPQNvKuVSs/JUM3eyCtHH82
         axFZ/PUwQvEmC19ln9cxWVip099CVTC3Y73QDfNu4snKU4Sy1XgfkZRBeR4vijeGHX55
         fbpAN3I3tEBOwpCpvxpmoWJ3JH2K2EdGBm7nXUWjpsGKD/hoPPS6dcODVIhJDxCDjVmA
         fmUQ==
X-Gm-Message-State: AOAM532F2ej1e6kDl7V9oP2SR02ec0e2dRRYjFFiCDG419Rvkeb6mWa0
        F9yiE096PRpmtixPQfEw6HA=
X-Google-Smtp-Source: ABdhPJy6c9E5ctS8DjFcXFCtRPk4X3Aeb+nbPU9n27gyjDqCm5PZgpNLMA62tx5ObZXlEVTL9bshZQ==
X-Received: by 2002:a05:6830:34a2:: with SMTP id c34mr17709093otu.59.1625630508983;
        Tue, 06 Jul 2021 21:01:48 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3e85-59b9-418d-5cfe.res6.spectrum.com. [2603:8081:140c:1a00:3e85:59b9:418d:5cfe])
        by smtp.gmail.com with ESMTPSA id r25sm3762122otp.21.2021.07.06.21.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 21:01:48 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 8/9] RDMA/rxe: Add kernel-doc comments to rxe_icrc.c
Date:   Tue,  6 Jul 2021 23:00:40 -0500
Message-Id: <20210707040040.15434-9-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707040040.15434-1-rpearsonhpe@gmail.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch adds kernel-doc style comments to rxe_icrc.c

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_icrc.c | 32 +++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 62bcdfc8e96a..4473d38c171f 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -9,6 +9,12 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
+/**
+ * rxe_icrc_init() - Initialize crypto function for computing crc32
+ * @rxe: rdma_rxe device object
+ *
+ * Return: 0 on success else an error
+ */
 int rxe_icrc_init(struct rxe_dev *rxe)
 {
 	struct crypto_shash *tfm;
@@ -25,6 +31,15 @@ int rxe_icrc_init(struct rxe_dev *rxe)
 	return 0;
 }
 
+/**
+ * rxe_crc32() - Compute cumulative crc32 for a contiguous segment
+ * @rxe: rdma_rxe device object
+ * @crc: starting crc32 value from previous segments
+ * @next: starting address of current segment
+ * @len: length of current segment
+ *
+ * Return: the cumulative crc32 checksum
+ */
 static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
 {
 	u32 icrc;
@@ -46,7 +61,14 @@ static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
 	return icrc;
 }
 
-/* Compute a partial ICRC for all the IB transport headers. */
+/**
+ * rxe_icrc_hdr() - Compute the partial ICRC for the network and transport
+ *		  headers of a packet.
+ * @skb: packet buffer
+ * @pkt: packet information
+ *
+ * Return: the partial ICRC
+ */
 static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	unsigned int bth_offset = 0;
@@ -111,7 +133,7 @@ static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
  * rxe_icrc_check() - Compute ICRC for a packet and compare to the ICRC
  *		      delivered in the packet.
  * @skb: packet buffer
- * @pkt: packet info
+ * @pkt: packet information
  *
  * Return: 0 if the values match else an error
  */
@@ -145,7 +167,11 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	return 0;
 }
 
-/* rxe_icrc_generate- compute ICRC for a packet. */
+/**
+ * rxe_icrc_generate() - compute ICRC for a packet.
+ * @skb: packet buffer
+ * @pkt: packet information
+ */
 void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	__be32 *icrcp;
-- 
2.30.2


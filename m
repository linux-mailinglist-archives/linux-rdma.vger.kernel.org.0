Return-Path: <linux-rdma+bounces-1678-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47C89201C
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D801F266D6
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E21114BF93;
	Fri, 29 Mar 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXSemJYJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311814BF8C
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724163; cv=none; b=os50ad3ADte3E45c9vm9ceDzZ2bqYbD2ydFcfe0H5psfYvIomRiF6E/WGZ3v3S6I4Y86nX+EPt628P3+wjfzPhFYuSh+BaTKbDHQtEf2BFTrtgKUVN3oMiyuQMBxSFTQWPf0Oq941Papd6jF+u9LUn9RVgNm1kcAUt8TcBGlmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724163; c=relaxed/simple;
	bh=0Pa2bP02dZ3ETe2IeoQTHbmUTpw9EjmdiMWm3SVmSbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kF7EQQDmnTUDzimB1CjpMXaf7Qsk0dkKflRcRNZnYfl8xIwDgwuYt/ZdlX3ZJwb/QZjfIezYcC1yTzC6kzVQ65iFwS97fOu6plcN0S8bQcbwOf7p4R5kUs/ZYds3dOYVmlBmSXCUGG+BNDglO6ncQCRNhEU/otfBKzwRhBOvQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXSemJYJ; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22215ccbafeso1122916fac.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724161; x=1712328961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbUgPeO40G8+rE2YU4GHNiFgO5GLJpSIYCgoppaAmmA=;
        b=ZXSemJYJ3Qfj9og33SdtJy0gWN1WWX4UtGAchGwiIlGkfJJrt0pxQH6pj7jfp8jjmr
         J2V8SJu5t7WLuEt5S4JbNUqRUx5pI0BkstnbBuHcYIMjr/NrQwMNYsR4afb50hRD3EGl
         ZOgTn/+aoWCH0sARJxWCr0qtVXjqnuFm9e/hU9YCUY0k3Y5oTDEwc6EjrBqXZu3rZULO
         1ELgqrwNXK5F3zx+UNloN4/ocw6KWKV6Pxl+xUl2ZXCJfF+Qi7vpK6nbIFSubieSBrHj
         66mQDYZ/WumDNH7DIvaMxaTe7TJeym6N4Kby1uLOz+DNM/D35y+cU4hGO5L/0z5kkqf6
         +KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724161; x=1712328961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbUgPeO40G8+rE2YU4GHNiFgO5GLJpSIYCgoppaAmmA=;
        b=q4jEZWgY97x8jTOSOkqI5H72u49+Q2dIeqDX7FEB52+Js4IowQULp/Yij0onOKYelp
         YLmNWUnL/rQtW87MIF4lAF6bhkCgXxUvpYHvy0yy2PTmWLd9APyZsqzwT2wsmKuxOyDg
         B9D3S7lduGWjyrRMhKsGMuOZpLQDXkwI6Q/5oNvRYPTn1G9FaLYvg5Mj0WjbatK5S4oq
         K4tqz9rHYtGc2NhKoPf+VqzMelLk+T2Y/tlqm7xOH61Abv39Tla0KiRrgCDqkK4mJ25J
         Yi1lHbcs80KWNRUryVN8wKJ5fyUFyz7kSn6TmgqFnz8QNL6/jIYftbcwrcch1QfjdciB
         XAGA==
X-Forwarded-Encrypted: i=1; AJvYcCVlcjLIEcMZ/n/KBpf7y7QKBxdbDfyRrSshuCMl0VwdruZeMIWNhjTyXlhk+XNU7xI77wm62jNR+frdJDhT8DpCEtncUc5lPY4FHA==
X-Gm-Message-State: AOJu0YzTcrC/CyXWnp+8/0TzryniiuYoMh2yzoOxNJuVnJUevp270Skw
	QgOR27Np7AnNxCC1V9Z7ZXYTj3tK4I8OR3+Fo9Fe2cXaeDgojzos
X-Google-Smtp-Source: AGHT+IGa4Q9TTSkvmHQ2j5eVYxopkhfURKKtGAC47IaVqLhOIu/axe0aQd5VgU/tCGIgF6RCKMVU2g==
X-Received: by 2002:a05:6871:8789:b0:22a:4c05:2efd with SMTP id td9-20020a056871878900b0022a4c052efdmr2593691oab.10.1711724160987;
        Fri, 29 Mar 2024 07:56:00 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:56:00 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 09/12] RDMA/rxe: Fix incorrect rxe_put in error path
Date: Fri, 29 Mar 2024 09:55:12 -0500
Message-ID: <20240329145513.35381-12-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329145513.35381-2-rpearsonhpe@gmail.com>
References: <20240329145513.35381-2-rpearsonhpe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rxe_send() a ref is taken on the qp to keep it alive until the
kfree_skb() has a chance to call the skb destructor rxe_skb_tx_dtor()
which drops the reference. If the packet has an incorrect protocol
the error path just calls kfree_skb() which will call the destructor
which will drop the ref. Currently the driver also calls rxe_put()
which is incorrect. Additionally since the packets sent to rxe_send()
are under the control of the driver and it only ever produces
IPV4 or IPV6 packets the simplest fix is to remove all the code in
this block.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
Fixes: 9eb7f8e44d13 ("IB/rxe: Move refcounting earlier in rxe_send()")
---
 drivers/infiniband/sw/rxe/rxe_net.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index a2fc118e7ec1..d81440038f91 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -366,18 +366,10 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
-	if (skb->protocol == htons(ETH_P_IP)) {
+	if (skb->protocol == htons(ETH_P_IP))
 		err = ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+	else
 		err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
-	} else {
-		rxe_dbg_qp(pkt->qp, "Unknown layer 3 protocol: %d\n",
-				skb->protocol);
-		atomic_dec(&pkt->qp->skb_out);
-		rxe_put(pkt->qp);
-		kfree_skb(skb);
-		return -EINVAL;
-	}
 
 	if (unlikely(net_xmit_eval(err))) {
 		rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
-- 
2.43.0



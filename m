Return-Path: <linux-rdma+bounces-1679-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238EC89201D
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 16:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10372880CE
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Mar 2024 15:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B2614BF86;
	Fri, 29 Mar 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckGqu6fQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46D14BF94
	for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724164; cv=none; b=GgsOAuaUIo8kCwE80/oySjuV58VxtfEjog2QM338tKpmYMTfO5pdRzfc5EkxovupWpFc/F4EcCb6+woQ2PffhE4U5U5guFgCtM3wXJtNfHAnJ06utFO79V0qQVuIel5mGvvyiPC6KMye8vqjDw0/YKikkMY7j+4agMebWwpUmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724164; c=relaxed/simple;
	bh=X2q6wbjrbnUuC0airwdkQF2e6eqr3hWQJS/qlRR1dXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DslGcoPP13m/vDRUPcpFKMTCO9hXj3GpIfMBwxGA2VSKqbrJt6BnLPBIFI0Ut8Q8e1eIWnYGL41TFEDAyc71AjQprwNrywXHtz9yz/KMNagmbi1in40Cyjza8iAkEeNkZzkUPNSpvPLF+zAq/arQxPl9mBmciKJ09Xp8CrwUeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckGqu6fQ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c36ecdb8cdso949326b6e.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Mar 2024 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711724162; x=1712328962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWAslbWFX1XOSWwHcgJy6hHbIvWl+oqLgvo/gLbrYpc=;
        b=ckGqu6fQx3FUN1zvLYFK8t1Fn9L+e7MGxb/qQZRo+ncyaNWWhtF7j/eUY8S4cSuUOE
         FaTYb2W+ZcJGVJOKdNOWz1n0jIpGMqnhPhmvKf4ESzqvqlovm5Xm0GSUBzsQn3K/Kqb/
         /S39RFE3XTJl/4K6hoo8WefbOTGViN/vbWPFnjQXkrAVogLdDEe7G7FnbhT7n14aEkml
         w1TYXj0qNlmKwMHD4ylJL71zOGAtfzdXHuLpC+xWe7A0Rv5zoSFQTorzeglzVwaG6vos
         HMGDtXZOt3ta+G/20D5JObxkPPBUVdHSx96Z5xFNMdV7wZq7A919qlbez/xVB0Kd3AzX
         pyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711724162; x=1712328962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWAslbWFX1XOSWwHcgJy6hHbIvWl+oqLgvo/gLbrYpc=;
        b=gQ35PKmgHN0NUZAl/MyB77QDXAhjTnoD5/LUViYP6ddJgoKP/AL7QsbOuYkvMQrPFO
         ZIPF/bXxafHTAMx8KsvDg++HNjN+8lZVfSmirBK49EswTgruSWoMLhQds2U3dRrHHmFx
         15a1nQIc9fSNnBzBOsBFsJUtouoTi7x8ji1elXyH2j/pGP9l3lIDlTJcACPooM4KIUak
         88a0lUxdNlurf9YmUFEEUU3TaYOcjattLyK9M/9cg03sMUzby7gKjSNqnRDjl+ODz9tT
         ikTZ/D3IkQ+icY4u2Hk29e4DOexPUeICSROegU2hzpXYZ7lM15lO5tIj6NKK43MMpXU9
         7h0w==
X-Forwarded-Encrypted: i=1; AJvYcCX+/CJYSMdqlkr2lHTHn8CUV9PAZcwlR6n3hYAprhpo9URGrxFD0hw29ADSWMqb/WXdTbyIoqVmOt3bCo73HpCu3dw5leIf2sxX9w==
X-Gm-Message-State: AOJu0YyFANH3NtZCSWdadrS3gYHnMd1Y6qsCSNWlR1VRnG2yh6TsIl+H
	RxaynkmRQewUGAwyjNUKwYcLVr1T7YLgxYWdgG1hE7j+7rkXgGvRQj9GnJ+a2TE=
X-Google-Smtp-Source: AGHT+IH3veVs052UIhJr4dJDUoTEIxFQkrfv/VgLCS6TELAJe1B8dDdjeXwiWLRSKckLG9TPxHy4kQ==
X-Received: by 2002:a05:6871:60b:b0:22c:ba27:7a4d with SMTP id w11-20020a056871060b00b0022cba277a4dmr2476249oan.47.1711724162056;
        Fri, 29 Mar 2024 07:56:02 -0700 (PDT)
Received: from bob-pearson-dev.lan (2603-8081-1405-679b-75b6-1a40-9b4e-0264.res6.spectrum.com. [2603:8081:1405:679b:75b6:1a40:9b4e:264])
        by smtp.gmail.com with ESMTPSA id fl9-20020a056870494900b0022a58ffa4a3sm1006249oab.23.2024.03.29.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 07:56:01 -0700 (PDT)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: yanjun.zhu@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	jhack@hpe.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 10/12] RDMA/rxe: Make rxe_loopback match rxe_send behavior
Date: Fri, 29 Mar 2024 09:55:13 -0500
Message-ID: <20240329145513.35381-13-rpearsonhpe@gmail.com>
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

The rxe send path currently counts the number of skbs outstanding
between the rxe driver and the ethernet driver to prevent too many
packets to accumulate waiting to send. This patch makes the local
loopback path behave the same way. The loopback path forwards the
packets to the receive path which will eventually call kfree_skb
on all packets and drop the qp references. This makes the loopback
path more useful for software testing.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index d81440038f91..d081409450a4 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -386,6 +386,12 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
 
+	skb->destructor = rxe_skb_tx_dtor;
+	skb->sk = pkt->qp->sk->sk;
+
+	rxe_get(pkt->qp);
+	atomic_inc(&pkt->qp->skb_out);
+
 	if (skb->protocol == htons(ETH_P_IP))
 		skb_pull(skb, sizeof(struct iphdr));
 	else
-- 
2.43.0



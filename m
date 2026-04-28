Return-Path: <linux-rdma+bounces-19706-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBkCJ6Y48Wm/egEAu9opvQ
	(envelope-from <linux-rdma+bounces-19706-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:45:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2616548CC4F
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AACB3308BD73
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6298A39DBE8;
	Tue, 28 Apr 2026 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbVIyxpM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1070396D29
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416141; cv=none; b=OyGy/vLhJzWeanDoM1skfUgasa+lX6rO6nI+AsZe50h7i7vU2pv/0d0OA7JvMLziUTAgzU8odOqEnGsfJzXMp4TCYcSE61rG3qNQeSzS2mQjNSYGhFisfskC07+4ymKprib//Ud9nOrs0Oy5PxrAnN6GGFDfOolIkbjH1zE4yf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416141; c=relaxed/simple;
	bh=w8Q7fwzhxuNDsmhOs8CU1x0IUrDfpFLHCoe3mI0Gkkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJtdZ3tu+44nbE2g2d4sM/K+fJezglIiVQcT8iZqjxM+tkVaou+F3wmlEhzvM7C0CLVNRxZ0AZhHiTPkiapMImcq9V3fe8uVN/QXdoFZkRJP4T8NZeo8ugBpjRRxn58urcnBqIT9ivsbVRXjtvsqaji2qbfvyXMcBOlsaNU0zTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbVIyxpM; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7986e538decso122604827b3.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416138; x=1778020938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yf9C9Vs78X6Tori5C+6AMAUG6Jc3jDAPqdDnnefTEsY=;
        b=ZbVIyxpMWHXCvIrzJgV9mWyOvTaIOnoNxuTsNhnHC1iCMZzlOc7dDg7p817Hl4FHQM
         xFjWwCuJg7TPW6uQrJ8S6INB3wj7NwfhuCwyuVaXu5tJ4x8Gt0iSiiepFaSOY9pqS1HJ
         clIsEXhAZa7t5C6o7WWyaMppBRkUYtE9JaSGxz67lMgvXOOpqPmzfQkKrgcEcCHqckVx
         oPwNbFsY5GAkerbDc7GwNF3cT8PbV3TC+bEFEa1Dp7y7PldcbLlAk5w0SEFTdfKCrHNP
         xwqHwR8t07skJuRzFtJrlVTeiLLGgnBsizsHNM0/d5pPhVgD8qr80f7VPRoKuhjybJ6D
         SI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416138; x=1778020938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yf9C9Vs78X6Tori5C+6AMAUG6Jc3jDAPqdDnnefTEsY=;
        b=S4U8YtHgBPv/jwaSGy4CgQdpbCsoTRGEzrOCc9eL/FkPpG8+jHs/ketcFfXfI0vfgq
         +eqloaDFnV10XIgjou+4jA5mfrssk2HqXsTOFBDFoiG0Rcf0Af5RTELeIKuwQbHobgjQ
         R2H+Ze4rOFHh7wabBmLDGhsDszlZOlwxIQmAg1XnpDT/ZfEVADb6X2DGGAeN/hLylmHK
         PI8sxjMXs0q3R/HNECcVR3Tx2lybmxV2Vtxrs2S2szJrdgVe2DmjpsNeD1cbDN7xYA3t
         37YFaWh55kT+LP8YHVF43ypYOT/nHQWrVXtjPbCz3ng9dHDXnCi79D25TqHwwdo8mv/9
         qAZg==
X-Forwarded-Encrypted: i=1; AFNElJ8k6gje6Ue2IUQmq/JcFYF/5OAIluGY2Lh3ZHqsepOBGfswjGRAsqkN+FtbvjN66dYDnRtTANGlrl1A@vger.kernel.org
X-Gm-Message-State: AOJu0YyCU9kb4RMG2oM9Sb8FJ+nD8nKd3NBXPLGQTwnAjwhwlJWu5iel
	Uy4K3MxOWZY4GQ/l3MprpGoZB/qYVLgncnToblJ1BeFSj7Dj7CcG0+Cz
X-Gm-Gg: AeBDietL0bBLnFBCG+Lf4V1JIgkWGlYVfP84FiJXM1YWHq3ZsrjFWbtS2nNavNoimJ9
	KuFszAHJSavqhUCvkewTB6aaQPiYD3SiDinA7dPVCZWL0OYc8dHZIGgV7arxS3gThdHGlG3b3xW
	qPdXZuQ9I+T3m3wDSR/gtOk/Yml5o0elbV1ciaTBCq9wl448N4b+yhZIlXC7737K+qM81WCc2Uk
	5OLS8e7QJ61Y+QZRKMzOOR2AEE8wsl0YOPBU54Hg5TfAqpgcPUGWEa1Ey0euSi608NbrlQIDfs4
	qpe1x2989bMcjG4NR7FDF5NQit1kTEafc85mw7cPtGWIQ1Nt/9qTz/+v3hL8bV5otT+4p0VyO0A
	LoL7SOLeRIazejAZScfDvy4KcF7N43r3/8s6Rfex6Jtbf6lvxWipKCv8+eiL2H1+whf5eao0vOJ
	8lOm+d9NT2dgQnb+TIDf1uwpDzW6bVV8U=
X-Received: by 2002:a05:690c:6:b0:7b8:338d:7d78 with SMTP id 00721157ae682-7bcf579a631mr48995027b3.41.1777416137774;
        Tue, 28 Apr 2026 15:42:17 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd24b8a86dsm5096607b3.0.2026.04.28.15.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:17 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:02 -0700
Subject: [PATCH net-next 05/11] eth: fbnic: convert netmem_tx from bool to
 NETMEM_TX_DMA enum
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-5-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 2616548CC4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19706-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Now that netmem_tx is a multi-mode enum (NETMEM_TX_NONE, NETMEM_TX_DMA,
NETMEM_TX_NO_DMA), set it to NETMEM_TX_DMA to indicate this driver
supports DMA-capable netmem TX.

No functional change.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index c406a3b56b37..138e522ef9b9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -752,7 +752,7 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
 	netdev->netdev_ops = &fbnic_netdev_ops;
 	netdev->stat_ops = &fbnic_stat_ops;
 	netdev->queue_mgmt_ops = &fbnic_queue_mgmt_ops;
-	netdev->netmem_tx = true;
+	netdev->netmem_tx = NETMEM_TX_DMA;
 
 	fbnic_set_ethtool_ops(netdev);
 

-- 
2.52.0



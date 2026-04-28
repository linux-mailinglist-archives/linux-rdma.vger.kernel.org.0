Return-Path: <linux-rdma+bounces-19705-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDuAD2w48Wn4egEAu9opvQ
	(envelope-from <linux-rdma+bounces-19705-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:45:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C02A148CBF7
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5BDE305BDC1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A071396B65;
	Tue, 28 Apr 2026 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeNEkbSt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D76038B7C3
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416138; cv=none; b=PwHG/mkMSLQYlQXPKowzoEtn9u+Mlx5cIe/y8JgddCXA2IUhZOpodZuj04qBG7+579hoOJKGnPSGQ7vIqb+Mgnqe8abjIJYuQ/EjN+eGoR9GbNpG0FthfWtTy2UsgARq+chs2XwVrZ4WDwor3Th2X0yGgMZo3fUy9K1tQMgpHnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416138; c=relaxed/simple;
	bh=KFECSS4aB7ebsKhc9cQ+oy1mgcCmosbiDCQwtAwfgmA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ac2HDiKPnAgi31+h4ulc/ihgrerr69g8wE30D+iVhOrODFTerAKnpRM9+zM0GVlK3nuU61R9YCaMXI3ytcuZil89fq22kH1LYtiqTCbPkxStfXeTnzUgKQWm2LgfVVcXu3yvJ2/sHfRaDeNLxuT+DwsxGLwmbKr7lalCGr8vU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeNEkbSt; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-794719afcd4so127549867b3.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416136; x=1778020936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ecnzl0rAEZ1GRn0EllrW0hRzekmmc0UPEYdKJcAYG5Y=;
        b=oeNEkbStlmLUtV+R1Lb0dnvKyG3mYrR68OwGidORtt/N/kbaWolnqjT7+XPgPKPKUI
         iiKDBigsqLDbvI6K8vt3weq05Pw1JAWlKOgrDsybRs/Ges7lV0lTxOObUWBebGxDzLQT
         AI6vHZmcqH63UOukMICr/4BaB7IP/dRDkcekfYwAmQNxAFP94lyKJ2QCxdFIE6A4kOtw
         NUdA25YMiuzmZ2BUEglA8vm4HQqjnqrNFOhYAU6pGlZ3bbDPlNfKpqLLd5Glxt5dNWQo
         3Z1/GL0c3wkXEBY4b07wQML3Yi0XIzEJu6t1if5fn55y2DSF98evS8114FIyJktkaGD3
         8EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416136; x=1778020936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ecnzl0rAEZ1GRn0EllrW0hRzekmmc0UPEYdKJcAYG5Y=;
        b=Su4HmoqB81sZXl1+VhaB+ybAimYiZvSH5F2Rq6SbuiHwkSucC2H+4MKi1AqPYkT0U6
         6+eJJfxZctfRwCRzbdfGZDIVQn2SI8HXcJJxKG796fgUosYWEBZ6lAzAGL8dA8ZRRCk+
         1DYzWQI3UoExejIh4ScW+oG/Tg8xOYvf28TuQrmnd4Z83nVdasfXHP8pxLi5gV0lvFvh
         xFyolYzCR5+oD4fvnT0VSyold1qUaKwU6FXpDFfzx2N4un0SxRv9bav1fEY8f22Udl1k
         hjWN9o2LZMm/6vhDSoY/UDrtY3f1mE12LAyQeC9oGQc0zspZzCgBPSxPOQe+SSka1eSq
         IVdw==
X-Forwarded-Encrypted: i=1; AFNElJ8P0VOIgRtOHRvuVQ/3bl5ggxUM5X1tyYv1QHKMuMloDp3GxRmk5jSJz5gd+76/JrP2yG2mg21vrxIP@vger.kernel.org
X-Gm-Message-State: AOJu0YwLt15rlW+cNj4y2kEA51z0p6bsaKFyjAQja0ZHqM6XDdgb7SR1
	nHMuOYewiKzeiPYLlB5905sLdNOb/A0EGUx57pY3RyjcLEoal83BYQUE
X-Gm-Gg: AeBDieuNXvKNKCCk0zGawnu7JZyD+LY4M5VQA6lU0+C8yOshfSjBXDj5Ack87BavRmG
	x1easbjHMNoRpZ+eO646731j21BKzQApJD1nbcUL4igQS9EArWUDh2VgDAOJcsWkZ1EZgeSlQWO
	qiKq936THY703Q2uqL4HSSmqMHk5PcNEKGNyNreZgLJJ2077F37UXEIIV2CpVzQNDkKiJ1727mX
	wZhvrV8lglLq5dNrhjYu8GFHhtHr3Oyw9JzWv72TzgKlr+m+z3oxQUbsQHVVp0Huxt610I/XtbD
	AhlOuUtbPPfqBCTkRXhtBoGCRfgzxza6rBwAwxGwN70kTnyc/lK93MfHeLAjgxPO9qrJAWSTduj
	iVIT6ejQXTk6/IqAh9jtuNnqXOEIaC77z/f1GFj0B/8pmAQr2fKWXK0cTcR2+1HamYDRvhpluTH
	RnniguwTY3wdARY5/Z04O0P17qcMK5CHEX
X-Received: by 2002:a05:690c:6987:b0:79b:cd3a:a5c7 with SMTP id 00721157ae682-7bcf50cba57mr49522287b3.11.1777416136081;
        Tue, 28 Apr 2026 15:42:16 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:12::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd25183ff8sm4798037b3.10.2026.04.28.15.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:15 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:01 -0700
Subject: [PATCH net-next 04/11] net/mlx5e: convert netmem_tx from bool to
 NETMEM_TX_DMA enum
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-4-719280eba4d2@meta.com>
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
X-Rspamd-Queue-Id: C02A148CBF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19705-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:email]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Now that netmem_tx is a multi-mode enum (NETMEM_TX_NONE, NETMEM_TX_DMA,
NETMEM_TX_NO_DMA), set it to NETMEM_TX_DMA to indicate this driver
supports DMA-capable netmem TX.

No functional change.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5a46870c4b74..fc49aae38807 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5924,7 +5924,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->priv_flags       |= IFF_UNICAST_FLT;
 
-	netdev->netmem_tx = true;
+	netdev->netmem_tx = NETMEM_TX_DMA;
 
 	netif_set_tso_max_size(netdev, GSO_MAX_SIZE);
 	mlx5e_set_xdp_feature(priv);

-- 
2.52.0



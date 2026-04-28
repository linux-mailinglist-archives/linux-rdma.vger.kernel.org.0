Return-Path: <linux-rdma+bounces-19704-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNu1Gzk48Wn4egEAu9opvQ
	(envelope-from <linux-rdma+bounces-19704-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:44:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1311C48CBC9
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35D103072F16
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46A33822A1;
	Tue, 28 Apr 2026 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9zpQ80s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3638AC9C
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416137; cv=none; b=b7eon+qLUz2WiReLXOSvgl5G2BHT9mSc4qggVsSyVKZMvzou54HudS5pyiKWOVRbynn6S9/TvOqM9lyO/Bd581/hpvT4Q6kXpzJbQ4XuBN7HKZGuLebyKi+YCFt2DAS+h2G5Y6VacG5LvBgn91Tq1apu7bz1EQmwJdDUjFlstc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416137; c=relaxed/simple;
	bh=vzUUg5dUyzpvG2rKRSov0XZCUJEJWBan5Kd7XHmSVMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0tZr8iLae123pSSHWOF3CefwHpyQ4KbEc83KSkbxguRc+CiG+PKz68n4+0c48MO+0QyWxE7oNGMn62UkdDAWtyCniPrxkw08X4Kf3V7DDw6A0Y7CtWL3IwJumHSdymvoYnZ3p3IuhetOue6ylmI+PEFWjCKPRzRrABTl+C2OPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9zpQ80s; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7b186dfc1d0so5639827b3.1
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416134; x=1778020934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LWnUfnbOgtmJXE6gI2zxE0u23Zp9z86buEnIjkZCpw=;
        b=i9zpQ80se0Jlxr9Ek7vx74wnKI3t49CkgH9GRtaRn61bW/xP4d0r3b8BP0dtNHh9UJ
         0t1ZLXuzCeY/o/6tIKtYh6BJfydOT9oHLHeJMhTkERl14A7yZ1oiRKbzUtdlFAYY6oD2
         7CGfmY9EP+PxdfnX4SBNfc2EmprinvWNN7sZzWKAg7EeDGI2nlMoLhKLH2K9XxweuLSo
         O0zusU2GY+Xh+xDyR3qdLwA/MFuYGT6OLH+P6QcS7XVfVIdiqjteEYX6HpDAX+7nBAgC
         2GLsscizSa53j1jAZ9GcVwvOdAR9AGW2sBQgkoUUdeoLHjEgOeXidFuSW88JOxZir5NF
         i3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416134; x=1778020934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7LWnUfnbOgtmJXE6gI2zxE0u23Zp9z86buEnIjkZCpw=;
        b=NZ5+vngvGvC5dRJOUCav0XWYB2TlEnWcU6TKFgCjb2di34FyuAtYVdCh0Whz/Nk+VO
         RUMwtsQSK+W2WO4LO2nC8GD+8Ghme5Mr3BW0qhsJppZgVnHm3QgRxAdDXlcy70+7f1Z1
         uUMRtm22ftfqBpXXxvegUdDrFR5dWlamIjquvbOT8hzqW4SWDxPXH95Zu8zqI1a71Xdg
         J6Qa9slMYeVvWbmZHrqU5ik32XlGB2k6P1NdeAbFFdBtmq49MjIAymSuAC6A4lCKISPD
         IVlg1/YwGxNzjrejqDFy+grTmvpKwyHxgyTnUM8Mbe8yrOFATQGwpnciPX9CsC9O7Yl6
         EM2A==
X-Forwarded-Encrypted: i=1; AFNElJ9yzwU59errI4TbZxJzIl1vbIyUqRltz4B6IeV/IzKAOle6Ywbm3vGwmmvwnsw5xj4YPa+aIVyA3fT/@vger.kernel.org
X-Gm-Message-State: AOJu0YxOIP7FQYdvpl6ty7FJy1YaPaz1ZZQ396hqhGNGbmTbwvo4+iaA
	uR7OiNlKc8Ve8XEzodzzs/Taj9Mlk7Yqv/AVoAPXUxfJew2gIMEPCifJ
X-Gm-Gg: AeBDietaxl8vixTu3ngXnYiyaKT6gFBw53p0fH01TNCX06L3ikx+Apq22/+z4pWDP+w
	lFr47lnkRm75ahNLWwxKri3FQe98jC0QVQd45TAPeHLDa5WURGywIxzpAvDcQr5C6AnqyfZTmR/
	u2D2uucpdC7YB2851b7WsLlJNFt2C+WAnRNAGf/ho/yuupm+Xyxgc6tZaqx6xVUJkTodlKJlDoV
	8M57CKl6/meznC9SBU2jwOPL9KWmLRHLN38tBFO6FiA1nIslEcvg5YhG4hl2f1pmeT2DtSwhOP4
	HRIBEyI8qbmMTGTLAuyZAT+0ZBxCB82X+1eJzTx6rXOCqqNet63mzNNgY3LoDysRQmSl9VHXUEW
	VJL5YWYgm4cqL+RN7BLLT5qLxbUfdOqXWpRmmxFShQWEwGU9hZp28v1hfHdtEGpY0rZUBN0IJnz
	acL/YcpCKQN4Vg5p78c5uQMFHL4/SuUcEy
X-Received: by 2002:a05:690c:6d84:b0:7b3:b0a6:2c6b with SMTP id 00721157ae682-7bd241aec69mr6798867b3.20.1777416134516;
        Tue, 28 Apr 2026 15:42:14 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:19::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd252ca6b9sm4764757b3.19.2026.04.28.15.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:00 -0700
Subject: [PATCH net-next 03/11] gve: convert netmem_tx from bool to
 NETMEM_TX_DMA enum
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-3-719280eba4d2@meta.com>
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
X-Rspamd-Queue-Id: 1311C48CBC9
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
	TAGGED_FROM(0.00)[bounces-19704-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Now that netmem_tx is a multi-mode enum (NETMEM_TX_NONE, NETMEM_TX_DMA,
NETMEM_TX_NO_DMA), set it to NETMEM_TX_DMA to indicate this driver
supports DMA-capable netmem TX.

No functional change.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 424d973c97f2..dd2b8f087163 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2894,7 +2894,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto abort_with_wq;
 
 	if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
-		dev->netmem_tx = true;
+		dev->netmem_tx = NETMEM_TX_DMA;
 
 	err = register_netdev(dev);
 	if (err)

-- 
2.52.0



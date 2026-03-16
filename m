Return-Path: <linux-rdma+bounces-18170-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJseL1pit2m4QgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18170-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 02:52:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCC9293ACC
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 02:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EF9D3009B24
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 01:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A3226560B;
	Mon, 16 Mar 2026 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhncS5Oy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D45C188735
	for <linux-rdma@vger.kernel.org>; Mon, 16 Mar 2026 01:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625939; cv=none; b=neCmIaLQx2qNkjPCSzovhUGMaPoXJxvfrtcbq8LtUo5inxQbPtiA5mtb3vn/z95iu7UoxxjuBJG26h4NUtnHOtJbssA8Gl04n95c3rdSWOnXGr9bzpUwQZm4wCVsWckx4T3WwX8QYGm0C3lX/n28RrHGb+kMwsb/jk3X30I9/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625939; c=relaxed/simple;
	bh=HqjORkXyUAJZ5t09djKo2B+llLHFZYN3T2zYVJKoFPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jP8v4KXcK9Q29FeMgrQFLxmTFvZXD//Lnv1mmeC8YZoxnjSfYM/0GqeynyA8yg5xf0tPvrucVYOzNJVjFzPfnBK3DLsVPQZxNI0Jf3uZ1/T0AMOhpK0big1XY2YZUJx9DdlkaMDVxw/0ul/hfZ+OACe1wr5GHrj/6TZxO+HqFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhncS5Oy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35b905e9dc0so644233a91.3
        for <linux-rdma@vger.kernel.org>; Sun, 15 Mar 2026 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773625938; x=1774230738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPA/F/DsU0PSQq3nz65hqH1FDo0PeiWks4BdWpvXxQc=;
        b=jhncS5Oy3v7pjuYVGPtZEjRJz2ksp+Iaa9xcxVUtNHgdDDOg4DAWVfHn8hN2sgGfXy
         ukJC7t1voPCTpfgLncXLxPlhssWqqRf1g+/zhOej4vZ4Z+1uqYByAvgEE1+Nkkn/CGg7
         XoiYzRHBJPKuFukJOs5HRq8++V5yea3ad6m+7yElGRDSAuydElvenBdi15xSfbG1uinh
         c1LcQcLzENeFcoB/Su9yhqiYgQhnv8qpSHutj2/NVk8PfHj/7LHGkLORI/l4/asGva9F
         oiCpxGFT6F5hknX4vEm2ac2DWNyySD6P4OvLJquA1HkgZJj19UhY1ABv0EbsF9GRoXv5
         IvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773625938; x=1774230738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPA/F/DsU0PSQq3nz65hqH1FDo0PeiWks4BdWpvXxQc=;
        b=YeS/UlH6RZoVxVR/7kudUiNy3GnWrlkmPaj2I0p4Pwv47hTe566PopnMDqOLCtUlSg
         gs3cgRnXODz1lltbE9Xsce2cXKiJe96y0BufY70J8zZWJ+CHaEayDQ2E4my8OWvvxjJS
         oT/idKZi+WQhH6MDH75e6XvZI6wR1BKotJYWG1ASQqJTIUrA47OzLomdpr57p89wYVZt
         Vo15DC9Q56BgEkPAxEMuKaZTIpbwrvAiXJQJW0W0x23TYu5DwtIc47L7u73Rm8QOfRjK
         pO0KfWBVdQH0Nb5Y9h0VVhtOTxwD5HHZ1jc20tBHsgxDNN7XIoVuk6vHV2Y+NU5L+EHf
         LCHA==
X-Forwarded-Encrypted: i=1; AJvYcCUGFiJDY7y3LbXU3t9gZRM3OA4s/wZNuXycBz0HLQSmaZ0Ar7oP8cBtZTz6tMif3GDU6ylvHv36B5x8@vger.kernel.org
X-Gm-Message-State: AOJu0YzXK6BZFQu2RYN6D4S9hnatZskvI6yaaD+/8s4jqYJnrKP0IioM
	kNYw355tJMVutDaNU7YHeYujUVF7NmO594z3xzJy/62Hm1jFAY9wtWGz
X-Gm-Gg: ATEYQzwj5Dz8A+USgvNw/GcIs924ILAvqY81e1eqMCUioghauObIhBfouUHZ0iwVcnQ
	oAihsJaKx9e6dAjCFL2qN7vUDweqX8LFlYxvnTZ21BJZDyPPevaVbxTOznSAX0OpXHgefqcijFf
	xOVlkMjA9BmgvSvRqEjEsgoRJyzU+3NfEbOm+0eH2tFkKQ3kkpJoQL+sG33f3IGl+vkWA9BXTHP
	BMdw3sTzv+6r9lVXJiGple9txiKUk9UWdh711sMATT9x+Fq38IO9YmUlwKar/AAlU0JPCf1g7o9
	cbRGEC80v+TfO1zzmANkbV3MBV6Txfh01MgUAhwDNtIJoIjbXnI6I7MN4PnVxHpREKZvC+Jwwoq
	MOM++dVuRazhNCEmhoMvlBmHknzr49I1utTpUwDO9m9cYiQ2wAXiW0tdJdZPBaPe4/nt2GqPhc+
	3+2pdrK13pRwSApg+l98euNy0qjJFxb8IJx+B3OsLA
X-Received: by 2002:a17:90b:574f:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-35a21fdd3b7mr10281855a91.21.1773625937953;
        Sun, 15 Mar 2026 18:52:17 -0700 (PDT)
Received: from localhost.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9d6fe68asm725329a91.6.2026.03.15.18.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 18:52:17 -0700 (PDT)
From: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
To: rrameshbabu@nvidia.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs/mlx5: Fix typo subfuction
Date: Mon, 16 Mar 2026 10:56:14 +0900
Message-ID: <20260316015621.41630-1-ryohei.kinugawa@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18170-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryoheikinugawa@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CCC9293ACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

'subfuction' should be 'subfunction'

Signed-off-by: Ryohei Kinugawa <ryohei.kinugawa@gmail.com>
---
 .../device_drivers/ethernet/mellanox/mlx5/kconfig.rst           | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
index 34e911480108..d549b43e00fa 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/kconfig.rst
@@ -120,7 +120,7 @@ Enabling the driver and kconfig options
 
 **CONFIG_MLX5_SF_MANAGER=(y/n)**
 
-|    Build support for subfuction port in the NIC. A Mellanox subfunction
+|    Build support for subfunction port in the NIC. A Mellanox subfunction
 |    port is managed through devlink.  A subfunction supports RDMA, netdevice
 |    and vdpa device. It is similar to a SRIOV VF but it doesn't require
 |    SRIOV support.
-- 
2.47.3



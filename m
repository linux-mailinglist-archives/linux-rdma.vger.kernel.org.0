Return-Path: <linux-rdma+bounces-19707-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJnFCho48Wm/egEAu9opvQ
	(envelope-from <linux-rdma+bounces-19707-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:43:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB3548CB80
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 00:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A48C3021C12
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 22:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D48F390223;
	Tue, 28 Apr 2026 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLUW9mg1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D5B39D6C6
	for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416142; cv=none; b=CuGUTog8HY2H4CFx8vom6slCVNvFiTaxqPXCMGQJ3URM3bqolUsHBSntJnM0fqMKu0RJHP39OuSVYawFFPg54sjf98dOeGNJbA7ResJ4kYhb+1azQwkk2PxCykdo2VdmIIXxYgtK/49rxZNbKV9uToFh4irlCE9eBhLBROxrZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416142; c=relaxed/simple;
	bh=9rMrowd4DVlTSZTRzu+MOaL2ai5oyk/Qc8U11XRdSsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b35ERszs1VMFkHlU01bUPCrOu5+GEnE2dD4dKLsiMiCejAu/FVA1C6bJD77IwE/GdR+8yUd2G5dLhmJfJDPQJMAiEq3ZTEwjdiO4HTUQFGklyCIHu4DcBofPZb7ZNDAykFGCCcRDv3lspfJgxYK9e7sYZvYznbwIjc7pKSdAWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLUW9mg1; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7982c3b7dfcso116811257b3.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Apr 2026 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416139; x=1778020939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swVw0BUMWcHYIT0edkHEsupdygicB+ZrJq18bYWTlfU=;
        b=ZLUW9mg1U/HHKV2/DFvHg0X72OJiuhxv/slw72/cdBmQxGv+Lqnf5MBSE3aUxfsgyS
         iDGocZMHgqBNxH0GpXFniByUA2gPoPdsrwRgWq16ZJWYw9/n1NVJY17Da5vMgY4k33kF
         Pe2EkVcso0St6nOv6akONh4gR+f5MHFzwtCbNck7Kv+GM6VLfBir1+9SaDIU1/9uifz7
         TahPTcPjm9V4yxBkVdCvKIqhN/VyPEz2GdNk0+5ef3RDEMSpPYiUvdoD/6S/gwE/g41e
         rsI+NwiOJYX8sbozFo8rUOfqId8pSAUFtEXhc9g2qxGLA7/ZHDidRqKdRHZSw8AZQv4R
         50hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416139; x=1778020939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=swVw0BUMWcHYIT0edkHEsupdygicB+ZrJq18bYWTlfU=;
        b=cVXEESbHjJia4vaY/66xjAHypHTPzo4qJUlryPkX6N/FfOweMjNdPopkNPRGYz0Tro
         xQjc2mrsDwjLoGd3U0Uj4fDn+U5UEAfAuKkzQ05UN9AN+EclNsrPXBuo7Zw+0DmOXT5a
         gIZidlotcO2jJp+kL0WcHS9TZ39uvDW20bz7Hy825N6spUpQ2IgRaA4lMBIoJFoT5kci
         ZK5cOb64CyMU+cutx4gEk3cbV0q2AbvlAP1qiXyzzva5JlMyom8ulCj4ClejENqfP14T
         aEex7kx/pFsYNV6MukkCWhn/KFS9ld2+8/20YjT68Hv+xVPdvKqSPbjr77XY2oJ5Ew4c
         6fSA==
X-Forwarded-Encrypted: i=1; AFNElJ9GLEsL4nOQ3TPiTzv09ws24apFrDK763+OXeEbxQnzLCnJM6MysaJ9xouNleylrRbzPmStGCZtexp9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/OhdjWSgsjsLSbKy8aUNAMeB9o9mZ7CNBni1UwLnhdly+wQns
	e/sHTwZWAzJvATww9x61z8JqCL1t4/RY717vXsrWmasbtrcj96AdqA2x
X-Gm-Gg: AeBDietLcLDRve1lviY0u5pidIzcnw+VSq6E5K9fUQHXDoWVAt5L3m9eujzngJBHYr1
	p1K/46I/PQ67ZIzwZJ6bocWK78eXoeGOS38Gs/Em3W0lcsQ06GLcbN+2f/wPmRpicMrrvOfArjK
	h0ahgVKA4ETl54VvSyJ/HoQzx8HGQU5lsMbgaJf08UN+AGHn/ZKqS96Fdotlhi1x0Zp/OOhR6jE
	RApbL29m23Gno8h0vvxhWqx0cPudN4RzXMGYpFx3YGvWGGc+fbefRNK7XwhXYs/2QCaA5jSRz86
	25/5duRdILlKlCs1hWXdtNeJD+xsOlDEdkG3V0aBOKmVUDyILlERRU6+37em+XCKtOtqgFJV1vZ
	GVeFUF3zE8sFWZ4gEnBJ371fFd/G+2apFAtEze1HV067jBsezJQ1Yse8yJpZ/tCmf9UBdyJiZmE
	Sdoz64JROeM1VGCh6L8978j2PiPN2Z8vyX
X-Received: by 2002:a05:690c:7301:b0:79a:8f2f:cb3 with SMTP id 00721157ae682-7bcf57a4bfdmr54296357b3.44.1777416139391;
        Tue, 28 Apr 2026 15:42:19 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:16::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd258a2761sm4454877b3.30.2026.04.28.15.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:19 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:03 -0700
Subject: [PATCH net-next 06/11] netkit: set NETMEM_TX_NO_DMA for unreadable
 skb passthrough
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-6-719280eba4d2@meta.com>
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
X-Rspamd-Queue-Id: EDB3548CB80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19707-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Bobby Eshleman <bobbyeshleman@meta.com>

Netkit never DMAs and it does not break netmem (it never touches frag
contents, it just forwards skbs between peers). Mark it as
NETMEM_TX_NO_DMA so unreadable (dmabuf-backed) skbs can pass through
without being dropped by validate_xmit_unreadable_skb().

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 drivers/net/netkit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 5e2eecc3165d..0ad6a806d7d5 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -466,6 +466,7 @@ static void netkit_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 	dev->lltx = true;
+	dev->netmem_tx = NETMEM_TX_NO_DMA;
 
 	dev->netdev_ops     = &netkit_netdev_ops;
 	dev->ethtool_ops    = &netkit_ethtool_ops;

-- 
2.52.0



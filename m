Return-Path: <linux-rdma+bounces-19815-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ4WKG7782mY9QEAu9opvQ
	(envelope-from <linux-rdma+bounces-19815-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 03:01:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 437CC4A96FD
	for <lists+linux-rdma@lfdr.de>; Fri, 01 May 2026 03:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54B8E301F5CC
	for <lists+linux-rdma@lfdr.de>; Fri,  1 May 2026 00:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD8C2857EA;
	Fri,  1 May 2026 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmfxkNGm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E81DE4EF;
	Fri,  1 May 2026 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597188; cv=none; b=HKOoBRCaVNk5T0TXuDblAyfSC61tu5Es4AwCrF2rHoTP41D0vFEgX0TEzmagxez/xj/6QtutuZzMaEfvSdeqE/yMfa6nsgZLx5JqEhZI6sNr+g0M0nFprj+32Ma8PyrJl/hU1FntnZHBhaauyznXDiW9VQ8NZSfVibU0qGo/j8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597188; c=relaxed/simple;
	bh=YW/4yuQ6/5Cle0pEbg+zkbBo3GeqgoK5U8Q6OCextFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6s7quWVBwLyLl8prfUEKqQaaz7ItxPIO3v+MoBpMmg2Y0n3L1OnkD/N4DbbL5pV3UOmL968IQSQ1k79fV7o7SdZ2VvKMPB2TAEIhs05/JQ870QFjD11VPQczL7R7XJ4rhdTADFoYfQ0O/0Wc3aJSnHRXlpbNvuMcJU0JuzN9fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmfxkNGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46324C2BCB3;
	Fri,  1 May 2026 00:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777597187;
	bh=YW/4yuQ6/5Cle0pEbg+zkbBo3GeqgoK5U8Q6OCextFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nmfxkNGm2r9Krz5Ob+1cT7UfS4f9OwLzrtqLoIZHcydQJRKKyeNa4zoHSpU7LJ377
	 Znmdpw0EiGbIs5BKLmAtkRPtPtFHDBRke4rphx9R3lWYSD8NXGSCSvJWXN+mNJElQ8
	 JMmNwNmJ4ekRxyb5k6uXINV6wjd65+0TUER/5quO/ElS+04uqBCmIgGySzOhtJi/cn
	 XyeWQ1pGaPS0cvspJM/gJrXKkI2YpLCBmkxs3t2bpKRGBT8jGusQMvUYPQpQhHVZW8
	 iDSryEqVSHqX3S+e/bSs7vjqnf9n8XjzcWom5xiBxnVAoSZCAp/EnvMjlJq9BMq2qu
	 IaEgUbzF40uoQ==
Date: Thu, 30 Apr 2026 17:59:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Alex Shi
 <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu
 <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Alexander Duyck
 <alexanderduyck@fb.com>, kernel-team@meta.com, Daniel Borkmann
 <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah
 Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, Stanislav Fomichev
 <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 00/11] net: devmem: support devmem with netkit
 devices
Message-ID: <20260430175945.476734ca@kernel.org>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 437CC4A96FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19815-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 15:41:57 -0700 Bobby Eshleman wrote:
>       net: add netmem_tx modes that indicate dma capability
>       net: bnxt: convert netmem_tx from bool to NETMEM_TX_DMA enum
>       gve: convert netmem_tx from bool to NETMEM_TX_DMA enum
>       net/mlx5e: convert netmem_tx from bool to NETMEM_TX_DMA enum
>       eth: fbnic: convert netmem_tx from bool to NETMEM_TX_DMA enum
>       netkit: set NETMEM_TX_NO_DMA for unreadable skb passthrough
>       net: devmem: support TX over NETMEM_TX_NO_DMA devices

I think it looks reasonable over all, but the assumption that rx lease
implies tx queue does not seem great. Sounds like Daniel has that part
covered tho :)

When you post v2 - you can squash the driver patches into patch 1.


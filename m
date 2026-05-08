Return-Path: <linux-rdma+bounces-20265-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PBmNuNL/mllowAAu9opvQ
	(envelope-from <linux-rdma+bounces-20265-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 22:47:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8EC4FB9EF
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 22:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AFF33037145
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BFD3D565B;
	Fri,  8 May 2026 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqNFQ/NL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D6C31355D;
	Fri,  8 May 2026 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273240; cv=none; b=e30e13rlD71lRO3YrLqlKw62xho1y1nWMiWNZkY2wyZALLOgLE7GWDY361+YnQM08Zp7h6l1yxOkh/0pJaItBnHRZgMGa/FrNwEDBYKDe/Dv1/XwTTEcDDljslwNTKqXkpE7b1rX2o4btQvgyFKvnYAgFxieFDAzMO5RASnknAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273240; c=relaxed/simple;
	bh=joSQS8mvp1Pdc83wykIvr6y2MmJNBUJLd38AS4iXpr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLENWM97Brpojd96v21T9/veVrtisqD/GxMsHEN7w2NqvyMhB5zyfiK3ocrorkte3xnKBzTcOFqrf/am3DXRGLnXgoGWjBPYWqW8rWDyENnwJC4EV1zW0Oxrdi0+Fa8pKUUbbRa47ztqqyPo2vG0ac6WbIHrVGAAB1FY8a/jDqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqNFQ/NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D89C2BCB0;
	Fri,  8 May 2026 20:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778273240;
	bh=joSQS8mvp1Pdc83wykIvr6y2MmJNBUJLd38AS4iXpr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QqNFQ/NLC07IFxAzovH4Xwn4Kjhc1ThxJRYmVqYCltwjL89FUWkxlm/mKlGl7i0Xl
	 U2e8Y5wizCsLwbBM7MTB4EssWdJcoPVNE9uqgFOzcdqLrJktJE/SDnCscAu0Hm9u4n
	 zBE3J4kOVWKEc6jwwxwMuDziSargFVvsbfumqDHNSfuWDCdLgPSPDavTNPTr7nrodM
	 Qpuz718DEztfoz5l6SGhBdkpJdBXbt+LJF1RzVAL/gss/bpKzWOePPlI5xrD/7TVOc
	 eK0rtlqNzgPExyN+FslcnUdJiH2MTY3jce9aYjIaY+PUHBLAgOPQLknHT59haMmu71
	 ThfYEPUlqkEEA==
Date: Fri, 8 May 2026 13:47:17 -0700
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
 Khan <shuah@kernel.org>, dw@davidwei.uk, sdf.kernel@gmail.com,
 mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
 xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, Mina
 Almasry <almasrymina@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <20260508134717.4ef87ab6@kernel.org>
In-Reply-To: <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
	<20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7E8EC4FB9EF
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
	TAGGED_FROM(0.00)[bounces-20265-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 07 May 2026 19:27:48 -0700 Bobby Eshleman wrote:
> +	/* Virtual device (e.g. netkit) the user called bind-tx on. Must be
> +	 * NETMEM_TX_NO_DMA.
> +	 */
> +	struct net_device *vdev;

AI keeps complaining that we don't hold a reference to this dev which 
I think is fine, we're just comparing pointers. Could we maybe make this
a void pointer and mention in the comment that we treat it as "best
effort cookie" (better phrasing welcome).

Or we should wipe these vdev pointers when vdevs disappear, not sure
how hard that'd be (or whether it's worth the extra state).


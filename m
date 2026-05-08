Return-Path: <linux-rdma+bounces-20248-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ4tBsX9/Wl2lgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20248-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:14:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD7A4F873D
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46D1630F44EB
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECD63F9F2D;
	Fri,  8 May 2026 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0GSFJJr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5F3624B3
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252488; cv=none; b=LDkF+v7/PVmdNkXl1h7B6otemezEiDQkEpGq13qo934/f1K4O5zEC/nSnMdWQ/I7rZHlxmilFrGtw7VBXzjDqHbjzbjEAxr0Z4CHX5jPo03c695CYBM1TgWqyiSJDA9e7Lye+OxD8uttzTqxYkQC+VCKAXCu9qI+ThbJM4SxdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252488; c=relaxed/simple;
	bh=C4KEQYKYMt+jPGupFXeYgtyzFlnYTdxDs0//Owq2PWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjRY9ouFS9r7DpuvbMbbRNkn/ly5QAg4CArPkTkCccaL6eEg88oOxRo/dl6fE87J4YOkt0/uh26ssTQ8IMHa1pBnnU9WvJ/UO7tL8H2AkFnmtWUnAAKUFJLm0OkCxZ7nxr8UDEBYaYoYZJow3WVbPeOVkkWNPoYPstTq90YI8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0GSFJJr; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-3664df32e91so658391a91.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252480; x=1778857280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVsAIDWuXutjxalCznuSZJzmb8d2/FmjsiE/YFxHP1o=;
        b=k0GSFJJrD1to0PbG8ZmvC0Y9LJNb3QkjjoZtb7wK/ZDczTYm3uWjZBFFtRLsX9t/eq
         +s8uZdFUFfdJz/tkhb9zkkihV4X9ZiK+TI0oRe16kpl8iYbUDquIXDqeqzOGTwJS2vVI
         5S1Jl/u0MS862SupdkPlckRMaUYyuej8xckw5Vm/alUJ3RY3tQms3rPS9lmbi1bxzblN
         KPr74+xMjODE1ognAQZHD2wDXQhDTyidKirrffNRx4FR9wX9o2Q/hxjbNO32U1L9fLgQ
         mbMr5b6mg/4oZBUt1XgFSBaygNFogyF3lxCq9TVhNSwvfPFBQV8mvBlj1bS7NjnNqhLa
         r0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252480; x=1778857280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVsAIDWuXutjxalCznuSZJzmb8d2/FmjsiE/YFxHP1o=;
        b=KFQ3yML7hbSd7CQIJIROOcezdduzElB/mPnpGmnkFO+nWVFFOvnufBZ2p22j91S5eR
         pl7MEhzdt6BjMY+JBtPeWo+inhUn7fy+VF0gpPORiQfzZeiODiG37jS6DFAvPdFZt5vt
         a9QYZ+1PicMZ2UQLoPyJE/uyZJcfAHAVhlSkpT7dswTZjc3UYNR0CY7/Mid+yNGyXxQc
         c4lHmkZ7kzXQZp9i7hrz13sEJ38ZTyW6lRGDuB+DANfwfxwfDJMAGxVyFxuLo8tGtatJ
         PHe24JnEfcTOoxvtY9orh/J65OQZZmEX7pQcnF/Z6oNMDOvemcsjIrtHK6dA6MGbON2c
         0Cbw==
X-Forwarded-Encrypted: i=1; AFNElJ/IS9tR6/ZYUmMJccAyqAS6xBunZXBT0Ej83l+B6zZ6EBP5n1jr18KndkP03zEBMSqQk+lrjH0WM0oP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9XksGO4XOLLgNxp6pudcbQzLj0sQ0BVADSo8kyWIsXljJwYFz
	gYEIE7qYUhNEcE5hchJyS/plVLTWtOgnpuRm8WNw5hSlCHl3SbVQf8SJ
X-Gm-Gg: Acq92OGBBQ/gy88UlbQee+dmHq91/d7SLwkJPMLLe7c5jbmdTHdAml2ge36WdrhaGz0
	apNKmHtzMppdum84lmVQ9tHs4DKQL39brl//Ip6YqnS+yv5mB+2bKx6fvgh+M2jh0AxSUZ4hjWu
	vCmGQrJuJ67zZmKXMaPrcbFo1j8780oFN2df8a/x7rP5rMNNM70BYObg4b5PyNl5ggOVZXPdMmu
	q3Ph5JK5iACkjxIiiRyPPtuQFjyMTgsaPDzIiKmBWQ5IRyIpk9M5CnrQgJClyy+RzLh1se789q3
	GRTkUqx2UZnjDit2eGEpVXafuJJK0/0PBx5SvnfrF13QmU3s5oRFTId5AMYyNk6Jl1cWTMiJjWg
	ajAsffJ76XOaVNdV2N70moPBh39zR95QodIvwlxPFEzO9axeuqtf++z9MPRHUBWd/R1h/9UNJqg
	h7NXAVQR4WsH04DmH5zgcVX5Fh4a40U5c0uOH0
X-Received: by 2002:a17:90a:710:b0:366:159a:c228 with SMTP id 98e67ed59e1d1-36615b96cf0mr4284277a91.6.1778252479571;
        Fri, 08 May 2026 08:01:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367c119f372sm61912a91.2.2026.05.08.08.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:01:18 -0700 (PDT)
Date: Fri, 8 May 2026 08:01:17 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <af3593dYeiEeMzC2@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
X-Rspamd-Queue-Id: 7AD7A4F873D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20248-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,devvm7509.cco0.facebook.com:mid]
X-Rspamd-Action: no action

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> When a netkit virtual device leases queues from a physical NIC, devmem
> TX bindings created on the netkit device must still result in the dmabuf
> being mapped for dma by the physical device. This patch accomplishes
> this by teaching the bind handler to search for the underlying
> DMA-capable device by looking it up via leased rx queues. The function
> netdev_find_netmem_tx_dev(), used for finding the underlying DMA-capable
> device, can be extended to support other non-netkit NETMEM_TX_NO_DMA
> devices in the future if needed.
> 
> Additionally, this patch extends validate_xmit_unreadable_skb() to
> support the netkit case, where the skb is validated twice: once on the
> netkit guest device and again on the physical NIC after BPF redirect or
> ip forwarding.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v3:
> - Fix validate_xmit_unreadable_skb() bug for non-devmem
>   unreadable niovs (should not be dropped)
> - Major simplification of validate_xmit_unreadable_skb()
> - Fix prematurely released lock in bind-tx handler (Jakub)
> 
> Changes in v2:
> - In validate_xmit_unreadable_skb() to check netmem_tx mode before
>   inspecting frags (Jakub)
> - Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev !=
>   netdev to fix lockdep (Sashiko)
> ---
>  net/core/dev.c         |  3 +++
>  net/core/devmem.c      |  6 +++--
>  net/core/devmem.h      |  9 ++++++--
>  net/core/netdev-genl.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 72 insertions(+), 9 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index fbe4c328a367..268417c9ef22 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3999,6 +3999,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
>  	if (dev->netmem_tx == NETMEM_TX_NONE)
>  		goto out_free;
>  
> +	if (dev->netmem_tx == NETMEM_TX_NO_DMA)
> +		goto out;
> +

Since this is a good case, maybe fold it into skb_frags_readable check above?

	if (likely(skb_frags_readable() || netmem_tx == NETMEM_TX_NO_DMA))

Otherwise it's a bit confusing to have:

if (xxx)
	goto out;
if (yyy)
	goto out_free;
if (zzz)
	goto out;

(or, reorder to be out/out/out_free)

Acked-by: Stanislav Fomichev <sdf@fomichev.me>


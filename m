Return-Path: <linux-rdma+bounces-7187-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDBFA19BEF
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 01:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82333A2A80
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 00:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD36DDD3;
	Thu, 23 Jan 2025 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YB6cDL9e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB08A934
	for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2025 00:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737593190; cv=none; b=GcT5RB8ve3g8tK3fCmEKk7IWK1XHr7junDUcjCtfidFM5++wSNDighjhdA4BaXX+gjJzlcuk45e8/DYm3HSay8G3nkt0Zu73cf1XGifiL3na0/cB0hcP3OQ7f0MCWPW9IXJu1mh5YbQ33bRGBKsKqzRbEhmm4pYgZHL9BhL/V/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737593190; c=relaxed/simple;
	bh=U1o0uJbluqbirKA9JKFb2rUwcgzv9vB6gtfSG3Rf2uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Npj+dz1XRo8YlUYELXf4kubJWV7kSYKCk6MCQX0z+zl/O3q0Z/XHiB1iygSpBPTrUAy0kdnnzRzC/Rn8KHJl36OUd3RuAVhxeA48XzAwG+VQknxgPU86KyUEIZMFbq2jim/xFjzWU9zEQXjfD+DsqnNwZGofIsztRZYhNG/WlWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YB6cDL9e; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21634338cfdso6427125ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jan 2025 16:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1737593188; x=1738197988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9FimL65AT95FTsXLJ1JBaWHHfWY8mNzbtvVRi654Bs=;
        b=YB6cDL9eSsZCOvlHWxo10quQ9JrE8f9/SR9sMeI/asc4h6QrZn+FUPFfAUj8LS5erB
         jMtmKNe1EhzW7cGaGtAZcbCN6zfR81pIGyq9Y2vLxrso7yp7ctKiQORruYUJoISSu06R
         LT+W2VFf29z7nBgvG6Q3NP0nh2rPpeYbh97kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737593188; x=1738197988;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9FimL65AT95FTsXLJ1JBaWHHfWY8mNzbtvVRi654Bs=;
        b=pcSOrrEGqh/Vhp3DzvwHPWTTxoMMw60+RH2YHXSEPaXZ69b9AxCHHPyQGdPkohtAww
         JXN/W5/zGT3MK/9+K/S2be5+1BHtTB3xlLOMk6N6sVkKxWKmE47ZJjuu2asGYdTZaaMg
         cryhyeXjyYtJ4RTiN1Yie52/fV8EkTWtaroGE2t2vPItplmxdl/2unxa/sCZf68XBw7a
         qw0E3PyXtTmq7SPZOnWxaJrXbFxq45VFGWbfSRZ2Wl42dzkass9j4OjJT8vdTW8/V94u
         fGHlBheUiahzqKcKYYCEh4j9TBlbvAjaa4+MxTCWrWHu6Ne99Phcg3re/Dxw3OYpXlbn
         ul0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/lW4vYoa3X8qeW6P2xitJhy9Z7r7Bo5eXycYRTxby018gbk2bHsy4q+5cFuT5xjLdpwnT7RA3MVIE@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3YtYiYk+/WuDARx5IEeOJ3aEaFdMZbkrl1xgR2nkdb6IKCI3
	m9Og3ACqitrf09zdH1El1uylCHuZhvaqESRefqG5KCCQFIf6DKk4/KQYGXLdeHU=
X-Gm-Gg: ASbGncuUOfeu4YlOHYMuEbzkV/bydN3bq2bT/550AMadQrbYC0sv4ElFo5xubmaVTHi
	lekUBwYNW0c0fpjyjNk6txOaSQgKWN7PvVlkcsovnQOKTkSV0Al6+UwEjjXjwBCc5X04LRBgrBI
	o22RghTM33KIVfditOVssgHQ+Bc8gFpWo7ES4JQWAEocfShF/FRZvM4+sY2PrXPtXnu/r921yc+
	ut4xO8EFFEvEHi4N98rR2GrjwoSV2V4e8lTDQqVwZOaYin7U+Nar+DfjGRA7UPmPn5os5kL2XIR
	eaBasW9S+l4/Npu2jhUdpkJSM4DYUtvcu1Ct
X-Google-Smtp-Source: AGHT+IGjgpeDWAuLmxBo55PskWfOqvJ4s5qAK5gXG4aCdoCgfrNfYdWdQdBEfR8FsY9FCrj0uaA5vg==
X-Received: by 2002:a17:902:ea11:b0:215:b5d6:5fa8 with SMTP id d9443c01a7336-21c355c84a9mr344603415ad.22.1737593188352;
        Wed, 22 Jan 2025 16:46:28 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e088bsm100989905ad.173.2025.01.22.16.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 16:46:27 -0800 (PST)
Date: Wed, 22 Jan 2025 16:46:24 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
	andrew+netdev@lunn.ch, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, witu@nvidia.com,
	parav@nvidia.com
Subject: Re: [PATCH net] net/mlx5e: add missing cpu_to_node to kvzalloc_node
 in mlx5e_open_xdpredirect_sq
Message-ID: <Z5GRYMB8dIJXKGxD@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
	andrew+netdev@lunn.ch, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, witu@nvidia.com,
	parav@nvidia.com
References: <20250123000407.3464715-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123000407.3464715-1-sdf@fomichev.me>

On Wed, Jan 22, 2025 at 04:04:07PM -0800, Stanislav Fomichev wrote:
> kvzalloc_node is not doing a runtime check on the node argument
> (__alloc_pages_node_noprof does have a VM_BUG_ON, but it expands to
> nothing on !CONFIG_DEBUG_VM builds), so doing any ethtool/netlink
> operation that calls mlx5e_open on a CPU that's larger that MAX_NUMNODES
> triggers OOB access and panic (see the trace below).
> 
> Add missing cpu_to_node call to convert cpu id to node id.
> 
> [  165.427394] mlx5_core 0000:5c:00.0 beth1: Link up
> [  166.479327] BUG: unable to handle page fault for address: 0000000800000010
> [  166.494592] #PF: supervisor read access in kernel mode
> [  166.505995] #PF: error_code(0x0000) - not-present page
> ...
> [  166.816958] Call Trace:
> [  166.822380]  <TASK>
> [  166.827034]  ? __die_body+0x64/0xb0
> [  166.834774]  ? page_fault_oops+0x2cd/0x3f0
> [  166.843862]  ? exc_page_fault+0x63/0x130
> [  166.852564]  ? asm_exc_page_fault+0x22/0x30
> [  166.861843]  ? __kvmalloc_node_noprof+0x43/0xd0
> [  166.871897]  ? get_partial_node+0x1c/0x320
> [  166.880983]  ? deactivate_slab+0x269/0x2b0
> [  166.890069]  ___slab_alloc+0x521/0xa90
> [  166.898389]  ? __kvmalloc_node_noprof+0x43/0xd0
> [  166.908442]  __kmalloc_node_noprof+0x216/0x3f0
> [  166.918302]  ? __kvmalloc_node_noprof+0x43/0xd0
> [  166.928354]  __kvmalloc_node_noprof+0x43/0xd0
> [  166.938021]  mlx5e_open_channels+0x5e2/0xc00
> [  166.947496]  mlx5e_open_locked+0x3e/0xf0
> [  166.956201]  mlx5e_open+0x23/0x50
> [  166.963551]  __dev_open+0x114/0x1c0
> [  166.971292]  __dev_change_flags+0xa2/0x1b0
> [  166.980378]  dev_change_flags+0x21/0x60
> [  166.988887]  do_setlink+0x38d/0xf20
> [  166.996628]  ? ep_poll_callback+0x1b9/0x240
> [  167.005910]  ? __nla_validate_parse.llvm.10713395753544950386+0x80/0xd70
> [  167.020782]  ? __wake_up_sync_key+0x52/0x80
> [  167.030066]  ? __mutex_lock+0xff/0x550
> [  167.038382]  ? security_capable+0x50/0x90
> [  167.047279]  rtnl_setlink+0x1c9/0x210
> [  167.055403]  ? ep_poll_callback+0x1b9/0x240
> [  167.064684]  ? security_capable+0x50/0x90
> [  167.073579]  rtnetlink_rcv_msg+0x2f9/0x310
> [  167.082667]  ? rtnetlink_bind+0x30/0x30
> [  167.091173]  netlink_rcv_skb+0xb1/0xe0
> [  167.099492]  netlink_unicast+0x20f/0x2e0
> [  167.108191]  netlink_sendmsg+0x389/0x420
> [  167.116896]  __sys_sendto+0x158/0x1c0
> [  167.125024]  __x64_sys_sendto+0x22/0x30
> [  167.133534]  do_syscall_64+0x63/0x130
> [  167.141657]  ? __irq_exit_rcu.llvm.17843942359718260576+0x52/0xd0
> [  167.155181]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> Fixes: bb135e40129d ("net/mlx5e: move XDP_REDIRECT sq to dynamic allocation")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index bd41b75d246e..a814b63ed97e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -2087,7 +2087,7 @@ static struct mlx5e_xdpsq *mlx5e_open_xdpredirect_sq(struct mlx5e_channel *c,
>  	struct mlx5e_xdpsq *xdpsq;
>  	int err;
>  
> -	xdpsq = kvzalloc_node(sizeof(*xdpsq), GFP_KERNEL, c->cpu);
> +	xdpsq = kvzalloc_node(sizeof(*xdpsq), GFP_KERNEL, cpu_to_node(c->cpu));
>  	if (!xdpsq)
>  		return ERR_PTR(-ENOMEM);

Nice catch!

Just out of curiosity, I looked at the other calls to kvzalloc_node
in mlx5 and they seem fine, as far as I can tell.

Reviewed-by: Joe Damato <jdamato@fastly.com>


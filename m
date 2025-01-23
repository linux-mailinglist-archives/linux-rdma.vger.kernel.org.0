Return-Path: <linux-rdma+bounces-7209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82CA19E76
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 07:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4581B7A6BEB
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 06:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D841C5D49;
	Thu, 23 Jan 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNBzGHWi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D531C2DB2;
	Thu, 23 Jan 2025 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613523; cv=none; b=trn2em9aNGss3cCmSZkjGEzSTKIEMN3Fj+HbaijnNaGzWH+K4F8xDccQ4rVDq1JdAVmwv7VlNF1KN01A+rpQsvpHmVAA1TlZ4GBidao0sLzMB09nRuMatXesN0PW4oXUN82OygcloMFHNirZXXAP0+3rSCV2KkKiC/9oaEqhtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613523; c=relaxed/simple;
	bh=MoJKo2TD6DB0+hKk7XbyvBjNCR9ExSuHVb/uimVpbFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAijVbrpA74nC1P0bvK50mSttgKg2g9CJmNlF30HKd1JBEhkN0wPhGGjvDQhvEPb++ilf96+PGZouv9FjzRKwFsiiXbBH6T6K7hFFsMLJX6NDCoTXYjeBHLW0+PT4KXyPJAL+oZifLsHbFIh11A43HqEV1GHMqc3Dcv6ycd34AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNBzGHWi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so986811a12.1;
        Wed, 22 Jan 2025 22:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737613520; x=1738218320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TqaS9GGZm23RZfZAEY9Vl7ozP598AZjc6tLzI298NqM=;
        b=YNBzGHWieT/EbU/Wigul4pN4C3CPfwwGIaLMDnAkklU6ymNhVkBR4fperPheDmHuTJ
         SGZQ9lWb6G4s/WzOkCfxODrm00aVa7Re9RU1La4srwne2mdZ6/nIBjt7GRkV9Wj/Jr10
         kbymLxSYEZTK7DRa+KkFa4VptyMw1LhR7sgpiK3hepicrYvvsJmjp05eF/qcn7a3ZSkQ
         A7r7RxY/aEoKakRodvJpjgFzMCKxvtdPSp3PiaUyMJBth/zwCdZWusPJCdUgqcl/f7Uj
         yguTbM9DT43DFeg9/cr8hFfCyzzJq1CiEZbUfmrkqBNvcMQDKMCkbi7UtQ55XMRJa1Mc
         k3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737613520; x=1738218320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqaS9GGZm23RZfZAEY9Vl7ozP598AZjc6tLzI298NqM=;
        b=mIhk0ryQ9jedMlaQ1awvD1GFz+noclVe9pUyf9Hxre6/D9HuoKIXaSh2ExC8eZ/3/7
         YSMNqKNOb7ak8s9f0fBx10iJsxaiu8aQxP2BkJWs0mREeCB6RM1dy7bzPaQUwHCtBTDg
         8yr6E/o7KT5UzlhviECPaJ/2LyRst8z+JV5VMiWxFONvIkh0/vN7rYFsnSerH9nJWCHN
         EexlF7w5b62zsCoqupilvhmrUsIGeDv68a2UeXXH1z/JKXy1+/KwWrzl0jDezZMSsN/C
         04tcqFQVySQgVYLjUki1plGXMol7EiHJIz+GbZpN/pC0/boe/QUCD3QW3/Bs+nEZ1QzV
         uGMw==
X-Forwarded-Encrypted: i=1; AJvYcCU6o6bnni0Fx6lC45Xx9U2qRqJ2LxteLyZ1tE9MvlcDFzpUi1FbucHfHp6fJvUYISqBhBnS1hTL@vger.kernel.org, AJvYcCV7YnmZlU6tihP+0GFbS880lbbEXyCMtpi6ehcgVKglYkH17ITxG0ppuVbfUa4Nuq4mnPqS74azS71U0Dw=@vger.kernel.org, AJvYcCXmUiCDp8ijqCbssGKnwPQGhxwrNuBS+QUciCSZYSvD5vC5cbFAqej9dBMLuf6FbYJ5LTliWTQzBJl0tA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztQgy2+o9Ejf5IjZ/eZTdXrHUxT7hYwkR59vhotzsN/MTqHXv/
	GPb/q4CgST2bbyT5baBN15aFJee4SdnWp8C9qZto+Ickb2NkyBFaX+v1LA==
X-Gm-Gg: ASbGnct2T9wCxKWeueuSa1kWvzMUxMG63T2cHVgiS+On/TjniDoqIJm540suTTk5auA
	X8KvCFBkhXvxZmaoWHUCSuJ9gu22uPnKyUxnv+EvK92/yebQwvNbQllN5kXwcu7oigAcTM5Zv6e
	Op6aC3dhkXpzT8VN4dAgNSAgBGIX5KFe2K3Nf/UpAhw4xyQui+yjLM1Wbuq+8AAd/eLRdqscrjP
	/A56UOdGHSNmlzNXej/vn76UtX2phJX5IP+WTpqC1mcfPdBlrhoDNFjoakcoVK/As6PHvNnMNmd
	JvBcAV97tteVF3Bo4aj7wA==
X-Google-Smtp-Source: AGHT+IGccmOYDrSy3PczETUNF3V7Uq9oBwl4zX4UB0O8TKRibKqCfK+yBMEaF63Il+3/ZINyNgZK/w==
X-Received: by 2002:a05:600c:218b:b0:436:e751:e417 with SMTP id 5b1f17b1804b1-43891919404mr233512265e9.7.1737613121882;
        Wed, 22 Jan 2025 22:18:41 -0800 (PST)
Received: from [10.80.1.87] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31c8764sm49307655e9.38.2025.01.22.22.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 22:18:41 -0800 (PST)
Message-ID: <c2f199f8-c9c9-4184-92cf-b179e162ece6@gmail.com>
Date: Thu, 23 Jan 2025 08:18:37 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: add missing cpu_to_node to kvzalloc_node
 in mlx5e_open_xdpredirect_sq
To: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 andrew+netdev@lunn.ch, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, witu@nvidia.com, parav@nvidia.com
References: <20250123000407.3464715-1-sdf@fomichev.me>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250123000407.3464715-1-sdf@fomichev.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/01/2025 2:04, Stanislav Fomichev wrote:
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
>   drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index bd41b75d246e..a814b63ed97e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -2087,7 +2087,7 @@ static struct mlx5e_xdpsq *mlx5e_open_xdpredirect_sq(struct mlx5e_channel *c,
>   	struct mlx5e_xdpsq *xdpsq;
>   	int err;
>   
> -	xdpsq = kvzalloc_node(sizeof(*xdpsq), GFP_KERNEL, c->cpu);
> +	xdpsq = kvzalloc_node(sizeof(*xdpsq), GFP_KERNEL, cpu_to_node(c->cpu));
>   	if (!xdpsq)
>   		return ERR_PTR(-ENOMEM);
>   

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Thanks for your patch.

Regards,
Tariq


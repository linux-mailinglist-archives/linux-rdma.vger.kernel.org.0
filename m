Return-Path: <linux-rdma+bounces-11013-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C3EACECB5
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D966D3ABDCD
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Jun 2025 09:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26A0207A0C;
	Thu,  5 Jun 2025 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHWeiys4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1538E7E792
	for <linux-rdma@vger.kernel.org>; Thu,  5 Jun 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749115183; cv=none; b=uBdAQKoMdZj7hTd4GVyAkL7jmsJiLw96/n0WlWHK+aNkrTSYebeuxPtiIIBHqPJ7DucxN63CfvczsZqiBdfV4vGzAo5AjcYnZBmveIxG80EoOaA6itKugFI7KB9Ps9E1CGhKw7mJsuvV83k9Qv+X26M3CkjRm2jKsSCLnD3mPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749115183; c=relaxed/simple;
	bh=Jna34DJuIz4lYrqaZp7xKG5CCFB0I/HmBOSFfw1c+x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkYk1jvN7Fe6hdM13mB0yd8kNMMHNMjm+WW3A5jcqtvQKVEa3XxFMRUl+cPq5MSF1IHtctnIkPFXPJFO1hxUqzufLUesUEnD16nrP/JPu5anVUDZF+VieJtEcPYSWCY6C35M+6r55kHX7wYtbzkkpKwnLYpt/jHL3xgXpwIF1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHWeiys4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749115180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QbvOWE1CNUocL1BEc3ljc1g1zxTrUZmYCXxonJr+pKM=;
	b=OHWeiys4UL2OxcL/yza/XpmoI4Ne407yQz2rLz4kBWA7B8jsrZ0xWnH0BSAbsXetQjlWHM
	M4d85hviY4xrw2ckGLb9NBxmhXOiiet0s+PZsOarmzN8rC1hiGi/mnMI/kRYL51E1B9BNf
	yTOc+0Ua4LMc6d2qxkxisyLQS1tVmP8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-zcv0FoPiMA68dGw-KRH_nQ-1; Thu, 05 Jun 2025 05:19:39 -0400
X-MC-Unique: zcv0FoPiMA68dGw-KRH_nQ-1
X-Mimecast-MFC-AGG-ID: zcv0FoPiMA68dGw-KRH_nQ_1749115178
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a5232c6ae8so320682f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 05 Jun 2025 02:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749115178; x=1749719978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbvOWE1CNUocL1BEc3ljc1g1zxTrUZmYCXxonJr+pKM=;
        b=gUOKzcuJpiv4elEBwHv0pxBrFX1Sosf6zZdPzxSzILk0kpWofXlctqr8SxsDqgotr+
         2We912Cu2MPRVXVfU0uRAUy+BGVJhpcmXOYa0YLmRdPzeHPre2JWqPtJyXJEF4TEoKVU
         Et61QU2MT89Eh3cBT8N8WhYSunHq/uJ0Jyf6nBrRBJbu4P630XNiYNkkpyzR0oMFIK7r
         J//LD5RWmnb7qQ2fn33hTJWygdK8M20CF32wlpP0d04eDFcl+0sbZ5zPFKBEC/4tXJAZ
         S9nQhKu3yfWydnnPwMS/W1hEfTUnewrlXveZWMdxRdBxubbLF+Boh4blWbt3OgOQWfWs
         BPHg==
X-Forwarded-Encrypted: i=1; AJvYcCVxBrsT5Emfh2HmLbrq0xb9lwP/Hds0TUA55db3vwGJxuddqOyvPQunEKNcVr45x8MMZgYBaP7zZnCt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89A8ExYMP/Nq1dG4KA24v/RMP4FMFsW6Md/ynAs8glotM+Vjs
	bF6TUi8ky6+0nObW6agJAtkd3TmIUjBKcPMhphv1VayyiReUH/mlE7ahPYQN6xh3hv1Z0X/AJDi
	wWvRyrbi9gO8iBMHZ1ass3ewQeEIQynVH9tLXVlkZD1FgSdVan3tYnTL7J40sF2Q=
X-Gm-Gg: ASbGnct21f4kVdXzpwA9GGdQgRJ4JvcNsGkf9lEMFNuRen8FeSLvCEUXQkdST1I3Opl
	u8HT7wNFqqA4jN6Yj3OAZ2GwImcKGdrwgdIO/wISE3ahxtRjSN/4hzAp90DbRPAKVjqaWSVEYqk
	17DzsM8TkSJcU9a++Y5NfHha3dQkXkCYsEysprMUE/OvkiWGmU38BIF2KElHtaX+7Md/eUIp3CX
	lmuVcu/w3PmogKhHChEetS70AJ15jEjf3ozHOjG1PKzULM9m/r7t+hDDJlZmgubXIZqhgHueIFT
	PUo25NQgW6L5FEa8kko=
X-Received: by 2002:a05:6000:2901:b0:3a4:d6aa:1277 with SMTP id ffacd0b85a97d-3a51d96cfdcmr4632402f8f.37.1749115178505;
        Thu, 05 Jun 2025 02:19:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiVIWKhvMhdKbM6hBmvDr6wXdqFF9eZ53YO8jtw/IL68kmldCR4ynqhTKRPPASOlhqnJbzTw==
X-Received: by 2002:a05:6000:2901:b0:3a4:d6aa:1277 with SMTP id ffacd0b85a97d-3a51d96cfdcmr4632374f8f.37.1749115178007;
        Thu, 05 Jun 2025 02:19:38 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cced:ed10::f39? ([2a0d:3341:cced:ed10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f0097210sm23909436f8f.73.2025.06.05.02.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 02:19:37 -0700 (PDT)
Message-ID: <0d96b03a-e0a6-4277-b8e7-a6d9373539f6@redhat.com>
Date: Thu, 5 Jun 2025 11:19:36 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/mlx5: Flag state up only after cmdif is ready
To: Chenguang Zhao <zhaochenguang@kylinos.cn>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Moshe Shemesh <moshe@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250603061433.82155-1-zhaochenguang@kylinos.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250603061433.82155-1-zhaochenguang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/25 8:14 AM, Chenguang Zhao wrote:
> When driver is reloading during recovery flow, it can't get new commands
> till command interface is up again. Otherwise we may get to null pointer
> trying to access non initialized command structures.
> 
> The issue can be reproduced using the following script:
> 
> 1)Use following script to trigger PCI error.
> 
> for((i=1;i<1000;i++));
> do
> echo 1 > /sys/bus/pci/devices/0000\:01\:00.0/reset
> echo “pci reset test $i times”
> done
> 
> 2) Use following script to read speed.
> 
> while true; do cat /sys/class/net/eth0/speed &> /dev/null; done
> 
> task: ffff885f42820fd0 ti: ffff88603f758000 task.ti: ffff88603f758000
> RIP: 0010:[] [] dma_pool_alloc+0x1ab/0×290
> RSP: 0018:ffff88603f75baf0 EFLAGS: 00010046
> RAX: 0000000000000246 RBX: ffff882f77d90c80 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 00000000000080d0 RDI: ffff882f77d90d10
> RBP: ffff88603f75bb20 R08: 0000000000019ba0 R09: ffff88017fc07c00
> R10: ffffffffc0a9c384 R11: 0000000000000246 R12: ffff882f77d90d00
> R13: 00000000000080d0 R14: ffff882f77d90d10 R15: ffff88340b6c5ea8
> FS: 00007efce8330740(0000) GS:ffff885f4da00000(0000) knlGS:0000000000000000
> CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000003454fc6000 CR4: 00000000003407e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call trace:
>  mlx5_alloc_cmd_msg+0xb4/0×2a0 [mlx5_core]
>  mlx5_alloc_cmd_msg+0xd3/0×2a0 [mlx5_core]
>  cmd_exec+0xcf/0×8a0 [mlx5_core]
>  mlx5_cmd_exec+0x33/0×50 [mlx5_core]
>  mlx5_core_access_reg+0xf1/0×170 [mlx5_core]
>  mlx5_query_port_ptys+0x64/0×70 [mlx5_core]
>  mlx5e_get_link_ksettings+0x5c/0×360 [mlx5_core]
>  __ethtool_get_link_ksettings+0xa6/0×210
>  speed_show+0x78/0xb0
>  dev_attr_show+0x23/0×60
>  sysfs_read_file+0x99/0×190
>  vfs_read+0x9f/0×170
>  SyS_read+0x7f/0xe0
>  tracesys+0xe3/0xe8
> 
> Fixes: a80d1b68c8b7a0 ("net/mlx5: Break load_one into three stages")
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Minor nit: the 'net' tag should be in the subj prefix, alike:

[PATCH net v<n>] mlx5: #...

More importantly, please deal with Moshe feedback.

Thanks,

Paolo



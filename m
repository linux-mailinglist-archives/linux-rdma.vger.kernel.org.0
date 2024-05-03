Return-Path: <linux-rdma+bounces-2236-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8DF8BAB1C
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 12:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1C7281331
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA2515216F;
	Fri,  3 May 2024 10:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+QY8v/3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782A1514E8;
	Fri,  3 May 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733746; cv=none; b=XGCo8BMqQlfTfegTBmXzNb8ovs5kzOo7+6LMzC47pVbvmWjJS+LzN9La8O5FKMoQEMphMwB9Eq650xY5g81j+QVIFwINvolhJqQlWB9itzmh6fk5GIpk0gYV29HNoIPsU6Ynkk4yO7HU28YZ7jLLg3peoG2wIg8NumdlIiEUTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733746; c=relaxed/simple;
	bh=L/+/yQ4ynlo4LEdTLUSqn8WtkYkWtH/W+Dpk4/nEhZM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KusCy4d/+eOCY/6Mw29kjFuvkiz3U0qK9hgIRXmRvLvm7+dD3f0EIOdNLl72x2377UqhTer2pUrApwq0C5JvLbKSOsHevskV4qd/gs/aNqXQ56BYfvwycxI+vw+QfjfNCUEBLR/UndScctmPsj1wBoVZLPfFuw4TO+IaG+6Nrm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+QY8v/3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-346359c8785so7184862f8f.0;
        Fri, 03 May 2024 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714733743; x=1715338543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s2aXQu/7Cvkityv4Fhfmzm5AvZdMa2jnqA7f5CxcgWg=;
        b=V+QY8v/3B59nbDkTnG6cGaSCvfOw0Grylp2LqTJAH925zOIz7PpdABiXqbkHUbVlPu
         Y+9DucYEq6FRft9GXFxyJDz89VSFz2lK+g6MU2FJiF3GjgA+4YgO2EHvfMI4dE+yZNR3
         tU4fffy75Qzn78yeHD4fHUYZdUu8Z98EmJjAx7yXvAC2xlDGG2uH5TjnTjix33/E/iuY
         kjX46U8D15ctkjYPHCEE38SJt//PN4kSHCKZjalRw/TdTVYWwELLRpoJyQAaA/cv3G0u
         3Yvo17whXRlHL2dtSvWz6f+gw8FM+y/31RNs4tASko1srnhDSylxL2DhEs7dSwspvHEN
         vp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714733743; x=1715338543;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s2aXQu/7Cvkityv4Fhfmzm5AvZdMa2jnqA7f5CxcgWg=;
        b=VmuRST7nqlb5AYF6vHQzSjqzuClvV1d5mxfLN2+M0mIT4f7sO4xWyt0sZMRsJ+706T
         xMPcK+U4wqdCuHsyg3kPxB9rFBBgvpxyaHSDMWM84Vxm/JxlRZqk2O9qTyNfLr0Xnq8d
         CPf4k6i2BWd6MNSNDJ7TUryhOF1EJKvQ23T/NzrPYfgndBtI3eD8tuxmv+XT+NwGLkce
         n/dVFPSQBulGwloV5hesSfmgx3qtqRu4j0s9smAth/J9IsqPpOKbB6J7knWacV2hP89i
         r9HrVXKQZpLFKAhTQ1V8uNw58n4CHLkA262TUO/z353qJ92ywIBRmuf0ApZ51gPYaRL1
         3fYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDG6kDa5GdqZFeC1Xeoe8AiAlbjGVTPs77UZG7GDOm27m9/pNVRSQh9ZmM2mhH66LWeHYVTMRDmdKj7yK5FZABJ+ghSXQqwQ9cyUaI+fU7HDVzB1HJXbPnDQnePCyb5h3VMKwttlZ2Yjo1yzSbrz2y3Z2P9BElXJ6m/TNsVdIEIQ==
X-Gm-Message-State: AOJu0YzvhuPwdimbQqCVkZ5y7nG72q2UkcCVUgMuKxFDac62QQH/78MI
	GK00FvYS0env9kCdSucRnYYgbvTALFp30o3gdzdALsVk61FyJQ4bWfvPWner
X-Google-Smtp-Source: AGHT+IGjPNbPpEnjw1q0DMZYcaZGgSFNA2Geb8LMASoZ+/CeziS1rnqH5lA7zy7mzNdoAEZ2z6YPuw==
X-Received: by 2002:adf:a29e:0:b0:34d:99ac:dcd0 with SMTP id s30-20020adfa29e000000b0034d99acdcd0mr1528023wra.49.1714733742438;
        Fri, 03 May 2024 03:55:42 -0700 (PDT)
Received: from [10.16.124.60] ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id dz1-20020a0560000e8100b0034ccb43dbbbsm3455626wrb.38.2024.05.03.03.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 03:55:42 -0700 (PDT)
From: Zhu Yanjun <zyjzyj2000@gmail.com>
X-Google-Original-From: Zhu Yanjun <yanjun.zhu@linux.dev>
Message-ID: <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
Date: Fri, 3 May 2024 12:55:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
To: Joe Damato <jdamato@fastly.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com
Cc: gal@nvidia.com, nalramli@fastly.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 "open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240503022549.49852-1-jdamato@fastly.com>
Content-Language: en-US
In-Reply-To: <20240503022549.49852-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.05.24 04:25, Joe Damato wrote:
> Hi:
> 
> This is only 1 patch, so I know a cover letter isn't necessary, but it
> seems there are a few things to mention.
> 
> This change adds support for the per queue netdev-genl API to mlx5,
> which seems to output stats:
> 
> ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
>           --dump qstats-get --json '{"scope": "queue"}'
> 
> ...snip
>   {'ifindex': 7,
>    'queue-id': 28,
>    'queue-type': 'tx',
>    'tx-bytes': 399462,
>    'tx-packets': 3311},
> ...snip

Ethtool -S ethx can get the above information
"
...
      tx-0.packets: 2094
      tx-0.bytes: 294141
      rx-0.packets: 2200
      rx-0.bytes: 267673
...
"

> 
> I've tried to use the tooling suggested to verify that the per queue
> stats match the rtnl stats by doing this:
> 
>    NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
> 
> And the tool outputs that there is a failure:
> 
>    # Exception| Exception: Qstats are lower, fetched later
>    not ok 3 stats.pkt_byte_sum

With ethtool, does the above problem still occur?

Zhu Yanjun

> 
> The other tests all pass (including stats.qstat_by_ifindex).
> 
> This appears to mean that the netdev-genl queue stats have lower numbers
> than the rtnl stats even though the rtnl stats are fetched first. I
> added some debugging and found that both rx and tx bytes and packets are
> slightly lower.
> 
> The only explanations I can think of for this are:
> 
> 1. tx_ptp_opened and rx_ptp_opened are both true, in which case
>     mlx5e_fold_sw_stats64 adds bytes and packets to the rtnl struct and
>     might account for the difference. I skip this case in my
>     implementation, so that could certainly explain it.
> 2. Maybe I'm just misunderstanding how stats aggregation works in mlx5,
>     and that's why the numbers are slightly off?
> 
> It appears that the driver uses a workqueue to queue stats updates which
> happen periodically.
> 
>   0. the driver occasionally calls queue_work on the update_stats_work
>      workqueue.
>   1. This eventually calls MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw),
>      in drivers/net/ethernet/mellanox/mlx5/core/en_stats.c, which appears
>      to begin by first memsetting the internal stats struct where stats are
>      aggregated to zero. This would mean, I think, the get_base_stats
>      netdev-genl API implementation that I have is correct: simply set
>      everything to 0.... otherwise we'd end up double counting in the
>      netdev-genl RX and TX handlers.
>   2. Next, each of the stats helpers are called to collect stats into the
>      freshly 0'd internal struct (for example:
>      mlx5e_stats_grp_sw_update_stats_rq_stats).
> 
> That seems to be how stats are aggregated, which would suggest that if I
> simply .... do what I'm doing in this change the numbers should line up.
> 
> But they don't and its either because of PTP or because I am
> misunderstanding/doing something wrong.
> 
> Maybe the MLNX folks can suggest a hint?
> 
> Thanks,
> Joe
> 
> Joe Damato (1):
>    net/mlx5e: Add per queue netdev-genl stats
> 
>   .../net/ethernet/mellanox/mlx5/core/en_main.c | 68 +++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 



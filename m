Return-Path: <linux-rdma+bounces-11430-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31854ADF0DD
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 17:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F28E1689A3
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Jun 2025 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4D2EF29B;
	Wed, 18 Jun 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="3Hk42bHI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F72EAB83
	for <linux-rdma@vger.kernel.org>; Wed, 18 Jun 2025 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259632; cv=none; b=h5SQX62/yKmgmhed0C3yIe3TFNTrE/1yw/+BhsLN84FRFxUXQ3l2mIK3PL/vFtC74nW5SXrASm1k4qikNH8fG6xiJgCWcdGOSLIvUojdt58wDaZ1KfyAw78//1kw1kAkeqP3GU8bwVNY6Ao3hQc5VZJp6TWJ+HC3t77dwfMr8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259632; c=relaxed/simple;
	bh=Vn9iBRZx/9vbTN0sjYLHUj8pAqYVdflJQ14VCJDqr/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgNYSiA3KsXAgtN8MDCyTE4BDuo1AIrWIM7GJloR/E0v/ORUyeIEuHdGTCEhXjX0507GOv11tuaThKUW6EQCb7AuAb6MyQZWE/2wroultF6FVfpuz1YbMbXiZxMu/IIUVJGpVEhETMa66WEXKmsCnS7N5FMD2BBRpSm1/4t036A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=3Hk42bHI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade4679fba7so1286268266b.2
        for <linux-rdma@vger.kernel.org>; Wed, 18 Jun 2025 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750259628; x=1750864428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+F9qb0WoqT4O8g9mE9Zc/ggeTeVcLZ0CP5p+3+ztus=;
        b=3Hk42bHIdT8jPgeEuQ0o05zRHi6b+0+CdPEkcYgqnYRDXvN+FXh/R0204Ny+Ej3rEj
         2+YiWi0f4mDRssrYmSCmvzftRYaepNx7p0sQAqXEE6bk8EBaDuR1MyX7bg2oi6SbkGIt
         6dR1PbfYcTu79b5GUbyzNeaXQPFaNaM2WOmWPONcfSueOpb4PYzMH4IGyTfKnKy+1Cwm
         jLimWSFuXVv5VlOBu8wmAxBI+4lsU/MFY7JRygZRyRAlGxSgW+d7md9pEd29tBWzpwZD
         HPe8FvSfRARiJRWg4ghHwZZbsQA3QePa6mge04sdEu1Vt4u9CLXqBTAjpVVrKPotjPfj
         3/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750259628; x=1750864428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+F9qb0WoqT4O8g9mE9Zc/ggeTeVcLZ0CP5p+3+ztus=;
        b=fxMBEik7qNwneUuFA2if9JHzTEVlmRrYyrZmSrm/TZ/XIjYpWrNOlxGeW7Xm4LvOHe
         l+zoGpZyywrHAGBlnABTqrYLPUil6/L8N6pvCxuh918eH/l/6z/o8NkWCPlaLR0qk41v
         0yuC+o10cFEXtEFUwHChUawnL7vQv7f3XO9OeQWcIRHvGhb85fRVMKUfcBMGzVHPPl6H
         i3z8FG/m7AKJE83+aC5+iW+CisSGxUOoGoIddiiKSJZh8C7WWAwEq9zsyHj7I2dubZPV
         uzNZ59Y2jMb1+xtm36TmMEzxD7ENIBgL1w8Dcp8qezkKH26RUu9ANdVr/eK5U+Z+4+Gp
         rYrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV7aZoBTQRK5BW+M0xi/vudOSJd7Jq/ybLkDJ/28eHeUsSy0GJLmj1LM0yptxD/VXT0l1Wmif4qsrD@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGCIXq1w1rsCgAhtO+fYM0g7EC/WEUqjH7dp8RljWX/f1WqGF
	y1hinjkgzsANVgqqUSTty+aJnEFMmPslWOAzb/kbs3QZZjlEeVt6p4/8YRvmgIwVC8s=
X-Gm-Gg: ASbGncvB357N/EXzvemfsX8g8GLVb4tJlxGz3KUb2/OIv8I3uJCT7QHaN82a7sJFT0O
	sSGzpizHP1SK/0EpKJ0mG8fe7isxf9kfh+z9OAGMX4z6Bpi1oSEALDEEr/JteplPkK3Ugsa6J1j
	lYPLNcweSwEu+2aAUcBemGTh3ydZDf6StJIUDG/T/SjilQvF9WMCDbU04ArNygLRNY3ur5/gwbU
	32pqLqi4hcwMkq2TUT8c7tZH+PaDr1OoccVrZ+8dBCZfEhK4M86lIb12+Q7CLYHxpNMCww9CO04
	AliJcWiHSxlgyhh/yYYw7RikmAdgm5Z9wS0RXOOWvOjr7IgPTKo0Gks2naVP5+S4Muw0EGce5g4
	z5IwHflKQF/Vx9/Nvqw==
X-Google-Smtp-Source: AGHT+IFP5VYYTJdfIK01Sjykg0ObgRPDVxQKO2zjJ45JW2hF+daM15wGjp6eoU5BXmzHVJq/enFDkw==
X-Received: by 2002:a17:907:3c94:b0:ad5:5210:749c with SMTP id a640c23a62f3a-adfad3cda7dmr1548731566b.22.1750259627178;
        Wed, 18 Jun 2025 08:13:47 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fe907sm1076757366b.93.2025.06.18.08.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 08:13:46 -0700 (PDT)
Message-ID: <82caca13-7970-4f44-a68f-1efcf3e9a0f9@blackwall.org>
Date: Wed, 18 Jun 2025 18:13:44 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/6] vxlan: drop sock_lock
To: Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, skalluru@marvell.com, manishc@marvell.com,
 andrew+netdev@lunn.ch, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, tariqt@nvidia.com, saeedm@nvidia.com,
 louis.peens@corigine.com, shshaikh@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, ecree.xilinx@gmail.com, horms@kernel.org,
 dsahern@kernel.org, shuah@kernel.org, tglx@linutronix.de, mingo@kernel.org,
 ruanjinjie@huawei.com, idosch@nvidia.com, petrm@nvidia.com,
 kuniyu@google.com, sdf@fomichev.me, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 oss-drivers@corigine.com, linux-net-drivers@amd.com,
 linux-kselftest@vger.kernel.org, leon@kernel.org
References: <20250616162117.287806-1-stfomichev@gmail.com>
 <20250616162117.287806-3-stfomichev@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250616162117.287806-3-stfomichev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 19:21, Stanislav Fomichev wrote:
> We won't be able to sleep soon in vxlan_offload_rx_ports and won't be
> able to grab sock_lock. Instead of having separate spinlock to
> manage sockets, rely on rtnl lock. This is similar to how geneve
> manages its sockets.
> 
> Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c      | 35 ++++++++++++-----------------
>  drivers/net/vxlan/vxlan_private.h   |  2 +-
>  drivers/net/vxlan/vxlan_vnifilter.c | 18 ++++++---------
>  3 files changed, 22 insertions(+), 33 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



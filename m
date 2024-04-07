Return-Path: <linux-rdma+bounces-1817-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E80789B2CA
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Apr 2024 18:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A751C212B2
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Apr 2024 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4362E39FFF;
	Sun,  7 Apr 2024 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="eDIOg91r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA24F39AFD
	for <linux-rdma@vger.kernel.org>; Sun,  7 Apr 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712506094; cv=none; b=ueblLdRLi/1EqY0SGXRVXz/WcwhNNkZLmciYuPWznxzSv9uvozZtQD0lQuIOVG1MWNlDHfbnaydTa4aRAIzRCyjud8bEN+ULp9wuMJYgB1kkkjjVBtTPXA0/m9Y7jJKS4uYobRcB7lH85NiVsaE9yniUyTsJAmbM4djhnqM1lrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712506094; c=relaxed/simple;
	bh=zGkuvzr8pf1LER3G8FWKDDHaUt07rPeEIJjxGNiB4hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n101nqmgpFWIXyDFLVntGVVEaqH69k4ThzhAx5rrWr8y0L/Tq/1+fh5q4UB+fxqJxovpxAGzWtL+7uL0Rr3T9AAusNBvLQlSYAbtIQ6hctn/PVG4kvVo073HY/P939NVQv6JJAIzaLgd4QGr/wYd4CA4M1HFHsCo0j9NJeeToLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=eDIOg91r; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2a4bdef3d8eso446907a91.1
        for <linux-rdma@vger.kernel.org>; Sun, 07 Apr 2024 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712506092; x=1713110892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSGIn0xXQNmOG1sNf+o8Pi6w9FLOfAhgffN85yMP1ec=;
        b=eDIOg91rTGFAugZ3tTcVs0lH58CLz4knUCx7VCXPZ8wWbBIVwM5IEYHCky4CYUCNbZ
         OyqZqpFEYkotiPzUN9wESpOfX8mAvodexzs2oJFAW1dSa2ojAQdd6/2MCtk2axYnTLf8
         5Kt8o2cAEAcve4m527YUtawJ8fnbaE86tSKAg/NygAK0iEV6acenCdjsSPtYV3m+RJ0n
         txC7j/9u8ELCdwOsOAkGEGNY4+2pD+f973KMlkBYa/Eo1yjPrXDv6u9dzcyihs8LedPd
         693kcMdWqpBSS28j5FXcl05GSzkxCUmPDF4a9Dquohpt7TNida+3nzjhALBjAyalo27Y
         tK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712506092; x=1713110892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSGIn0xXQNmOG1sNf+o8Pi6w9FLOfAhgffN85yMP1ec=;
        b=cG9QNxdDN9dOcmAbk0v4Ag19WyCzsAKDURHn4TvD2GZSnr+2mrJ97NCe3czVLS0QKn
         t/wsWeLSeen0VovIXbpxh7L4Lpby/uMaTVxSJ5lh8RqGqQUfstwMCGyQpeDsBOsJxq7V
         3RckxLYh7kh4aCLp16+nSdGZa24TzvcBnwCZBYIKlo1VmaHMH5ioxGL/uLumHLiczEmT
         IsxLlCmNh0EMxZ63YkbtUqozGx2CABiPwd7tl1Qd0jjgPM+YcNqXyiQk2ooWoW+rj4HU
         rnWtiw6KMQh+OhxMKPtCAXsDETBzDsE0yvSVMOBIrRh6Znd5jphltpjH6AXN+yjSAInt
         3e4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3iluxZjzz9gRPQfMHZO9u7ijo1WXbExfrXncVi5XMATbvd3mc1vD3HRDP0DsGq+7+xCfRQ8JPB6G8uBmzMJWLqeMWa+3kUk+BFQ==
X-Gm-Message-State: AOJu0YxFyWS6iBYaNp5owGKihuCznBgEmmql2pDHDjPJhB4HPJn4WLFl
	HXBKRCQ0hf50hneJ1VpNfl/f4h5dRsr8ZgfSOvd1hunxxc35eXFtMO4os2LmBeo=
X-Google-Smtp-Source: AGHT+IEaLJJ9iUSeaEdc0RSiBHPeejYzWdhLArNsd5EXcOe9i8rfZPxEgmS7Sf5xyCXKdIXpdSJ7+A==
X-Received: by 2002:a17:90a:d242:b0:2a4:9222:a915 with SMTP id o2-20020a17090ad24200b002a49222a915mr4085444pjw.0.1712506091745;
        Sun, 07 Apr 2024 09:08:11 -0700 (PDT)
Received: from [192.168.1.27] (71-212-18-124.tukw.qwest.net. [71.212.18.124])
        by smtp.gmail.com with ESMTPSA id cu12-20020a17090afa8c00b002a2f6da006csm4735204pjb.52.2024.04.07.09.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 09:08:11 -0700 (PDT)
Message-ID: <f58a134c-f46f-4b30-b520-12b05e1346d2@davidwei.uk>
Date: Sun, 7 Apr 2024 09:08:10 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v4 2/2] mlx5/core: Support max_io_eqs for a function
To: Parav Pandit <parav@nvidia.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, corbet@lwn.net, kalesh-anakkur.purayil@broadcom.com
Cc: saeedm@nvidia.com, leon@kernel.org, jiri@resnulli.us, shayd@nvidia.com,
 danielj@nvidia.com, dchumak@nvidia.com, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20240406010538.220167-1-parav@nvidia.com>
 <20240406010538.220167-3-parav@nvidia.com>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240406010538.220167-3-parav@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-05 6:05 pm, Parav Pandit wrote:
> Implement get and set for the maximum IO event queues for SF and VF.
> This enables administrator on the hypervisor to control the maximum
> IO event queues which are typically used to derive the maximum and
> default number of net device channels or rdma device completion vectors.
> 
> Reviewed-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v3->v4:
> - addressed comment from David
> - replaced open coded overflow check with kernel api
> v2->v3:
> - limited to 80 chars per line in devlink
> - fixed comments from Jakub in mlx5 driver to fix missing mutex unlock
>   on error path
> v1->v2:
> - fixed comments from Kalesh
> - fixed missing kfree in get call
> - returning error code for get cmd failure
> - fixed error msg copy paste error in set on cmd failure
> - limited code to 80 chars limit
> - fixed set function variables for reverse christmas tree
> 
> ---
>  .../mellanox/mlx5/core/esw/devlink_port.c     |  4 +
>  .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++
>  .../mellanox/mlx5/core/eswitch_offloads.c     | 97 +++++++++++++++++++
>  3 files changed, 108 insertions(+)
> 

LGTM, thanks for addressing.


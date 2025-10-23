Return-Path: <linux-rdma+bounces-14024-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC47C01D90
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 16:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A63D3A456F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA4532D42B;
	Thu, 23 Oct 2025 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxf/SOFG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475922D0611
	for <linux-rdma@vger.kernel.org>; Thu, 23 Oct 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230059; cv=none; b=mxrvXjveUBsUzH1oV3dnhqmfWwCEhvqEeIBN8TCNmsuBSRh6WoyvFxvvGO7jomyF7kpB7b+L5ICDG38bHpw6BUw994xIojp8/+UAOanGmJsJqnWLLDRodZQU0GUln9cVKCcRnFC/rKQO+VGGKWNQ2XMOr75yOgF6CUgxmOBUxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230059; c=relaxed/simple;
	bh=/QeC+4KBQYT3wohYuPFOfqIAJyHO1wZV9UiHSECbF+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rgi68rbwUDeOl0Z0IWNNYGfltPT2cMYjRSqiPnhrqfySqgKMBWrDl2cuzBE1Wj84FChwYuqdsetvz1ii3TgvUIK/CsrRp8wfbbgcWBYdBui5HFRTnGkNnQuaKYv/tbhkcJCpHN0Vha9x/OkVuEaemGWm8uuN0w3zNvPCEtNoHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxf/SOFG; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-88f79ae58d9so96994185a.2
        for <linux-rdma@vger.kernel.org>; Thu, 23 Oct 2025 07:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761230057; x=1761834857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ty8jqgEMWrkU/Nsac/whYt2eOAER5E6EFOQ1MIoYtJs=;
        b=Lxf/SOFGFAM7eVPDXAQhd1Enwft6Uq3rhsdzAfPR5okP8jkVsZfuBXe/cr2XbnZwI2
         0OIjUp+cHoHPceboKQtp3MgNMDgRa70y4km1HSv/HWELXd/yVrxVE7IxJMmc7zhhUmav
         FI7QjjX5odF40uyiNDRAmwSgAc3QQAt5A8io/k/X/UcfCGqtjH1xTu3W3JDeMoxsrhlV
         btWTclQZOrY64E6aC2jPzN8GE9QAsZdmcc3X0762pr1n3ohbAizhYbEcG2D6e+jX2YZ8
         a6yhxUJTzF/Wfsdr1DWU6HHf3VpVeXqQMnsOOqnILq1cL7o4eIF/WDhbAm49NCuQ7DiH
         6jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761230057; x=1761834857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ty8jqgEMWrkU/Nsac/whYt2eOAER5E6EFOQ1MIoYtJs=;
        b=jbL5iT6ZpfX5WQdg3iV2yXgv3/bAM0UZ13iuo/xwLqqV4yqdjBLyai3+9y0HoJ6dG0
         clfv5bemT/rQP6pfqiDVqmSmxZAm2lufiMFcXWEQTxMrCNI8oDye+ALLG0R1/OdVn2Of
         ZN0haHTJgmYZNIbX2QwQG2AFAKGU7ExGsUDD5oos8bEYPh0VdnZW50OfFh9Z37HAvYhV
         e3J0IEFxA0ufQfrkdFhVaMlTAGdqQohb6h+RDF8ZlP/W67XrTzbNqwHdrfTmCQnBIavY
         34jvR86uGN7R6tKBqc9J7Ekafc0BacOHRTilmLhzkyr+lZ+Ni3N6FuaXjvbNHi/82G/p
         pyKA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Kyy/GB3/R+maWpBIaLnqF1thrjnf2CH1maGrKyi4JCEsir+ouX0L6C7BT+AaWRkBMS9HWyPjGfIR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QFv+hxnml4L/sQfOgkCctqU3QNgslqxZCr/Z39lbUFDYEtnX
	UNA0Z973l7DpHEy8iHBCLH2iO0lCvoyYLGy11ZbbKPDoTJBgMYwBihvZ
X-Gm-Gg: ASbGncuT7bZa+05ok6feKnPXpwXEFihB9oiQ2amLHLxhcTEshRnKUqlhn0ZRLYJd5Oz
	7/OudtnQz1vT//FdY+HosH0A2CCKxFU50xcO5j0p6A0AoXZEyTE0EvLthytgUeNXb8KxtR49KJF
	R7Baj5QsYNqiAt1tuG6YeyhmRcq7mbqLXptKA2NDZLW8aUwdoh76QHGRmzEBMnCmdoIBBEuT2Tm
	jNIpAFgZdYMBo19nxRcW3LwhYlRbJ0teOX2l+1W4slCRBm50+E5uKPLUuUBW6srPQm0nDzSBAaF
	QaHExjiw1wW08dSgkjX5COD9O6qi+iwaix07K5SgXiw3YaIf95q2PFr9RfKF7tp0a91gYFN93Cl
	65AK/YX3uzpQh/6P+M8CNwY449PcDUW+s3AnqdCZ7vB6t/TvIrHhbIeuqM6B0WkCmwiZBc8jDAS
	lmXepGR0u2/aslH1FgvtVmZy6GFyz/ESgn26cJMVJH2A==
X-Google-Smtp-Source: AGHT+IFk6zsFnw4L+tiI4iBc7mZ7I1pnhPccFZ233koLT7AqMhpvx2+P+Rp5WpaB7Fl/vtbeBra1Bg==
X-Received: by 2002:a05:620a:4512:b0:892:5412:b742 with SMTP id af79cd13be357-89c11e630d8mr327291585a.55.1761230056821;
        Thu, 23 Oct 2025 07:34:16 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:6893:5f51:a77:210a? ([2620:10d:c091:500::5:8f1b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c11698b74sm171117185a.30.2025.10.23.07.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 07:34:16 -0700 (PDT)
Message-ID: <ae217501-b1e0-4f85-a965-a99d1c44a55b@gmail.com>
Date: Thu, 23 Oct 2025 10:34:15 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5: Implement swp_l4_csum_mode via devlink
 params
To: Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20251022190932.1073898-1-daniel.zahka@gmail.com>
 <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <uqbng3vzz2ybmrrhdcocsfjtfxitck2rs76hcrsk7aiddjssp2@haqcnmzrljws>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/23/25 8:18 AM, Jiri Pirko wrote:
> Wed, Oct 22, 2025 at 09:09:31PM +0200, daniel.zahka@gmail.com wrote:
>> swp_l4_csum_mode controls how L4 transmit checksums are computed when
>> using Software Parser (SWP) hints for header locations.
>>
>> Supported values:
>>   1. device_default: use device default setting.
> Is this different between devices/fw_versions?

That is what I presume. I believe the current setting for 
swp_l4_csum_mode is ultimately encoded in the capabilities advertised to 
the driver during initialization. For example, I am mostly interested in 
mlx5e_psp_init(), which depends on:

     if (!MLX5_CAP_ETH(mdev, swp_csum_l4_partial)) {
         mlx5_core_dbg(mdev, "SWP L4 partial checksum not supported\n");
         return 0;
     }

My guess is that "device_default" means that this bit would depend on 
the device/fw_version.


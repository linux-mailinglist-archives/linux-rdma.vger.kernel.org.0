Return-Path: <linux-rdma+bounces-14879-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B108CA2D0C
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Dec 2025 09:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF31830AF9E1
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Dec 2025 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF61E330D3B;
	Thu,  4 Dec 2025 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDwPM5S0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA19398FAB
	for <linux-rdma@vger.kernel.org>; Thu,  4 Dec 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764836850; cv=none; b=J0j0LL1QGTlbfwiXaTHp+cj399RqqHVGtJ91eORsFh53CGaeLB3dUhgOJ4jI04VIc7hEQ1EmjDOuoZSTJMB2RzdPTLsterOpPx0H/IeNhdzohomt8R/0IJQs6aslg8f6bBKni01cbViy1aH42Oy7DxOFFd71czMMXxvpAKEkCyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764836850; c=relaxed/simple;
	bh=+mJapQUcgIG/gMfIXcsKANm2CElCwdjZuVxCtHLEwxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQaoPO8tNjIzAoPs88d/9G68r3d2PDTM86qg41M4fGRpyMqbYpWKO2Jqq6B5H0MIy/OQ9cgQExqsIvzNCrl+/t4beFFZO5wLeLxPKnjSQlRVhUjKyCaF3t8yZtaU6ODWufXSiPlcWUf4MU+IBbHzz8UiPIDP+5uLHpr7RRAMwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDwPM5S0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42e2e47be25so365996f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 04 Dec 2025 00:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764836846; x=1765441646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kk4Me8kGllHr/VDwvtsYkc5klFKItoxmBTnZhaBfwbM=;
        b=CDwPM5S08fh9JhPXyvVPbvm2Pw9U39wGIKSNwVHgCsQAXg9PMLSSZuqMYQvvNSC3I8
         UBgFCo12qkaz9VnC4HsBIcqfXy7KpXGvFMg+AyLWTXS3pmr5LTF7oJ1t+2AfaybgjiGK
         n7HBboT9VvquQlMaSxJyN04HtIi3LaG8wf/ubSYSzrS3mqJjzKa0rtrRNKxVtgePjKnf
         Ub3cECCfVs7KvxyNhf+MXV8rFFUpOGzLyd6SDAxy8HMR2hOk3fMN+9mUqlWtOkFipTIk
         QtkPp9+NRsy34tSog+hGmJupf/fUSr97qPtNoYPSzcQEz9uvkXiHdvjUeqrgLK8gnL+X
         i77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764836846; x=1765441646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kk4Me8kGllHr/VDwvtsYkc5klFKItoxmBTnZhaBfwbM=;
        b=eCGjYKa9I+rqeZEX03snY4AvZbEgmHtLOYAsZICQs6SD3K6/1mnX6DIgHyyDXnuy3V
         FHS4YtkK4DELXaUEv0etLJ6ShlAnctPsBxOtbuDlUnwSmlXEmuq1iHniWuk3JRGjevPO
         BGjkI42tSmUy97YTo5BAzrYDoIA8Gj2yKBPEH01JDBqSP6BiYTdQRwauJp13yzVjypuw
         BtITVRPqMz4mdVTP1FRp0uiGklgWw/vPY35PA9Xl+M6e1QFMShr+URYNnV0Kjog4loxs
         Hwp9Hn1SGyoo9KLSlS87+Hh4mKZRIGfUxFomZvbVZzA77G3ZFBCl2qLpAwRfx2nLk9Fe
         c5tw==
X-Forwarded-Encrypted: i=1; AJvYcCX01ZprNad7Dl1oTVqclLuPEfRaWzmtTvenTL04VQxpsXWRJRhe41tLZd9gamEsoVd7Un+z44JqEQZ3@vger.kernel.org
X-Gm-Message-State: AOJu0YylA7+/iQPgnaJQHb+7G9i0XVhaRw0HGVIaz/IgDWE6TzGsLCl4
	PEqMMjOR9LWaeLVoamhsaWjRJ3+kGA+iaZ5p+A0+0fipuGOnrUGpuJrx
X-Gm-Gg: ASbGncvygzxG/TU/fmAjN+tmIumD00/uNsIVp/U7zgn6RVuqijUKnCMt3D5Olbsbxfv
	E1oQdrUAy+IlBnv6h47D2bSepJqdwJwI9rV1tFK9rWyqG/CoRTQ3UyaMzX9W5634spl5ut7a/Jn
	dDt/UppWKYz7WPqFNE5LBu05doyxFlxrqhaxpOka0daWiL+CReKure1DxqFGAGSe/hyazYa24rm
	8yQB1lFmefIKRf1/AWG2OvIwwUvo2//84Yn0Av3+zEgocF/TTz6W6sQEk8hOer9jhj37Sp/oW95
	wHlK7/sVKoRV+s/TFC3oT/t3V71NW3sJE2ilt35BgJElDOh5PCGFW4tItaN9VArh5Rx5a0GTS/w
	wIWR6gkirQPKQWpNq93RpCE2KR5glGHAaH7x1JNEDsfQjnBUomS9PFxbsP2S4M+GrJxWnNbH3sZ
	hALS1ZDwRkoh4ohCiW5UrU2PecikI80fTH3lI=
X-Google-Smtp-Source: AGHT+IH0YMI90ZQb6ct+nat8DtXdZsUN3AYv/eA+GemdRzLIQywet3ITexoNTtRP65Z6ow9GuR0Ipw==
X-Received: by 2002:a05:6000:24c6:b0:42b:394a:9b1 with SMTP id ffacd0b85a97d-42f79841510mr1872635f8f.37.1764836845435;
        Thu, 04 Dec 2025 00:27:25 -0800 (PST)
Received: from [10.221.198.188] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe90f0sm1864164f8f.9.2025.12.04.00.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 00:27:24 -0800 (PST)
Message-ID: <825efa1d-363a-4e82-8dc1-d7520c413414@gmail.com>
Date: Thu, 4 Dec 2025 10:27:24 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fix double unregister of HCA_PORTS
 component
To: Farhan Ali <alifm@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shay Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
 <99db437a-be91-4e85-a201-ec3a890900c8@linux.ibm.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <99db437a-be91-4e85-a201-ec3a890900c8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 03/12/2025 23:10, Farhan Ali wrote:
> 
> On 12/2/2025 3:12 AM, Gerd Bayer wrote:
>> Clear hca_devcom_comp in device's private data after unregistering it in
>> LAG teardown. Otherwise a slightly lagging second pass through
>> mlx5_unload_one() might try to unregister it again and trip over
>> use-after-free.
>>
>> On s390 almost all PCI level recovery events trigger two passes through
>> mxl5_unload_one() - one through the poll_health() method and one through
>> mlx5_pci_err_detected() as callback from generic PCI error recovery.
>> While testing PCI error recovery paths with more kernel debug features
>> enabled, this issue reproducibly led to kernel panics with the following
>> call chain:
>>
>>   Unable to handle kernel pointer dereference in virtual kernel 
>> address space
>>   Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803 ESOP-2 FSI
>>   Fault in home space mode while using kernel ASCE.
>>   AS:00000000705c4007 R3:0000000000000024
>>   Oops: 0038 ilc:3 [#1]SMP
>>
>>   CPU: 14 UID: 0 PID: 156 Comm: kmcheck Kdump: loaded Not tainted
>>        6.18.0-20251130.rc7.git0.16131a59cab1.300.fc43.s390x+debug #1 
>> PREEMPT
>>
>>   Krnl PSW : 0404e00180000000 0000020fc86aa1dc 
>> (__lock_acquire+0x5c/0x15f0)
>>              R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>>   Krnl GPRS: 0000000000000000 0000020f00000001 6b6b6b6b6b6b6c33 
>> 0000000000000000
>>              0000000000000000 0000000000000000 0000000000000001 
>> 0000000000000000
>>              0000000000000000 0000020fca28b820 0000000000000000 
>> 0000010a1ced8100
>>              0000010a1ced8100 0000020fc9775068 0000018fce14f8b8 
>> 0000018fce14f7f8
>>   Krnl Code: 0000020fc86aa1cc: e3b003400004        lg      %r11,832
>>              0000020fc86aa1d2: a7840211           brc     
>> 8,0000020fc86aa5f4
>>             *0000020fc86aa1d6: c09000df0b25       larl    
>> %r9,0000020fca28b820
>>             >0000020fc86aa1dc: d50790002000       clc     0(8,%r9),0(%r2)
>>              0000020fc86aa1e2: a7840209           brc     
>> 8,0000020fc86aa5f4
>>              0000020fc86aa1e6: c0e001100401       larl    
>> %r14,0000020fca8aa9e8
>>              0000020fc86aa1ec: c01000e25a00       larl    
>> %r1,0000020fca2f55ec
>>              0000020fc86aa1f2: a7eb00e8           aghi    %r14,232
>>
>>   Call Trace:
>>    __lock_acquire+0x5c/0x15f0
>>    lock_acquire.part.0+0xf8/0x270
>>    lock_acquire+0xb0/0x1b0
>>    down_write+0x5a/0x250
>>    mlx5_detach_device+0x42/0x110 [mlx5_core]
>>    mlx5_unload_one_devl_locked+0x50/0xc0 [mlx5_core]
>>    mlx5_unload_one+0x42/0x60 [mlx5_core]
>>    mlx5_pci_err_detected+0x94/0x150 [mlx5_core]
>>    zpci_event_attempt_error_recovery+0xcc/0x388
>>
>> Fixes: 5a977b5833b7 ("net/mlx5: Lag, move devcom registration to LAG 
>> layer")
>> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
>> ---
>> Hi Shay et al,
>>
>> while checking for potential regressions by Lukas Wunner's recent work
>> on pci_save/restore_state() for the recoverability of mlx5 functions I
>> consistently hit this bug. (Bjorn has queued this up for 6.19, according
>> to [0] and [1])
>>
>> Apparently, the issue is unrelated to Lukas' work but can be reproduced
>> with master. It appears to be timing-sensitive, since it shows up only
>> when I use s390's debug_defconfig, but I think needs fixing anyhow, as
>> timing can change for other reasons, too.
>>
>> I've spotted two additional places where the devcom reference is not
>> cleared after calling mlx5_devcom_unregister_component() in
>> drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c that I have not
>> addressed with a patch, since I'm unclear about how to test these
>> paths.
>>
>> Thanks,
>> Gerd
>>
>> [0] https://lore.kernel.org/all/cover.1760274044.git.lukas@wunner.de/
>> [1] https://lore.kernel.org/linux-pci/ 
>> cover.1763483367.git.lukas@wunner.de/
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/ 
>> drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> index 
>> 3db0387bf6dcb727a65df9d0253f242554af06db..8ec04a5f434dd4f717d6d556649fcc2a584db847 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
>> @@ -1413,6 +1413,7 @@ static int __mlx5_lag_dev_add_mdev(struct 
>> mlx5_core_dev *dev)
>>   static void mlx5_lag_unregister_hca_devcom_comp(struct mlx5_core_dev 
>> *dev)
>>   {
>>       mlx5_devcom_unregister_component(dev->priv.hca_devcom_comp);
>> +    dev->priv.hca_devcom_comp = NULL;
>>   }
> 
> Though this fix looks correct to me in freeing hca_devcom_comp (not too 
> familiar with mlx5 internals), I wonder if it would be better to just 
> set devcom = NULL in devcom_free_comp_dev() after the kfree? This would 
> also take care of other places where devcom is not set to NULL?
> 

Setting NULL after the kfree will have no impact, it won't nullify the 
original field, but the function parameter copy (by-value).

devcom_free_comp_dev() and mlx5_devcom_unregister_component() get struct 
mlx5_devcom_comp_dev *devcom to work with, they can't nullify it for the 
caller context.



> Thanks
> 
> Farhan
> 



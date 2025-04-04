Return-Path: <linux-rdma+bounces-9152-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543C8A7BE16
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 15:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1705B3B488E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Apr 2025 13:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD31B1F1518;
	Fri,  4 Apr 2025 13:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uugS4K5E"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FEA1F12F9
	for <linux-rdma@vger.kernel.org>; Fri,  4 Apr 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774047; cv=none; b=BUZLFtAxErFMqEMh4Tr3f4QUHqwjpeEjskDzIfdSo1O5/DLoNwJsozDDLcbbEfQsKez1VoZKUzLnKwdfje9za2wej/rKw1Bq//Dg0xWm/D1yHb6bd8++jBJb+Ch5mvGcXunJyk83nYfvyhFMa/jWc1Q2H2UB1V22qmEvitm/ZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774047; c=relaxed/simple;
	bh=xANPefLqpcEQYBRE/NCV46oK1I/FrELUp3mVZEO+8co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe1hF1I90LdDzqCsIKmo2PJjxlkR0BXeobA+/FBYz1qiqoNpk7eLrQE57ELsgsuj5QTMSeOsXEY4Cc+jSEP/Dm4zdR/3RuntmLkY9jEgIvnIejq0a/c7CBtZ6OS4wpfdH0vepJmfuAOwYisrCscxv5xJ7ejhQdr33AnXOmj21EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uugS4K5E; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3291d0f9-40af-4e8d-aa08-b84132caf03d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743774041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WVYyYy47dRxRDE2y37KU6fRW5bT0lNVCJKYGaAjgBU=;
	b=uugS4K5EShcKvWJc+VGSsPwIPg4rMNQLThsiZLoVA7gjw0RdwfgRWXqG6XuvXjkc9V/UUy
	RPUEIM2kTvgk4rN/casblXmUQq6t/61LXHyHRG6aBGqKIqLOJ9uq3bqDk3NR7Z5JG9p2Kc
	bJVJUBEhVk3rq/XVylmp7GbTJX/Qz9k=
Date: Fri, 4 Apr 2025 15:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5.4.y] RDMA/srpt: Support specifying the srpt_service_guid
 parameter
To: Alok Tiwari <alok.a.tiwari@oracle.com>, bvanassche@acm.org,
 dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 target-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 darren.kenny@oracle.com
References: <20250403125955.2553106-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250403125955.2553106-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03.04.25 14:59, Alok Tiwari wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> [ Upstream commit fdfa083549de5d50ebf7f6811f33757781e838c0 ]
> 
> Make loading ib_srpt with this parameter set work. The current behavior is
> that setting that parameter while loading the ib_srpt kernel module
> triggers the following kernel crash:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> Call Trace:
>   <TASK>
>   parse_one+0x18c/0x1d0
>   parse_args+0xe1/0x230
>   load_module+0x8de/0xa60
>   init_module_from_file+0x8b/0xd0
>   idempotent_init_module+0x181/0x240
>   __x64_sys_finit_module+0x5a/0xb0
>   do_syscall_64+0x5f/0xe0
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Cc: LiHonggang <honggangli@163.com>
> Reported-by: LiHonggang <honggangli@163.com>
> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Link: https://lore.kernel.org/r/20240205004207.17031-1-bvanassche@acm.org
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [Alok: Backport to 5.4.y since the commit has already been backported to
> 5.15y, 5.10.y, and 4.19.y]
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Not sure if this "Cc: stable@vger.kernel.org" is needed to notify the 
engineer of stable branch or not.

Zhu Yanjun

> ---
>   drivers/infiniband/ulp/srpt/ib_srpt.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
> index d03a4f2e006f..f5fd8c1058ce 100644
> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
> @@ -79,12 +79,16 @@ module_param(srpt_srq_size, int, 0444);
>   MODULE_PARM_DESC(srpt_srq_size,
>   		 "Shared receive queue (SRQ) size.");
>   
> +static int srpt_set_u64_x(const char *buffer, const struct kernel_param *kp)
> +{
> +	return kstrtou64(buffer, 16, (u64 *)kp->arg);
> +}
>   static int srpt_get_u64_x(char *buffer, const struct kernel_param *kp)
>   {
>   	return sprintf(buffer, "0x%016llx", *(u64 *)kp->arg);
>   }
> -module_param_call(srpt_service_guid, NULL, srpt_get_u64_x, &srpt_service_guid,
> -		  0444);
> +module_param_call(srpt_service_guid, srpt_set_u64_x, srpt_get_u64_x,
> +		  &srpt_service_guid, 0444);
>   MODULE_PARM_DESC(srpt_service_guid,
>   		 "Using this value for ioc_guid, id_ext, and cm_listen_id instead of using the node_guid of the first HCA.");
>   



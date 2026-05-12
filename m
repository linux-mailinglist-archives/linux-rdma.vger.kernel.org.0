Return-Path: <linux-rdma+bounces-20491-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cL+mMxNAA2ro2AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20491-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:58:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 343435231E3
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5886332AFD0B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135E13AA9C7;
	Tue, 12 May 2026 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="zufW3TR2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786EE3A7D6D
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 14:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594598; cv=none; b=TbME/vgevGteQKgO0Xk9WDBTDKaKypfuWwa9JA9Uo4VoKmUx+Xuio09k7NQH/zelcO1QaXw3D8Lo3a+yh8F9rIM1ZvPTlIELXerMXrMktiryO5DD8FvlelaQGWlagNQdhEa2d+rb7OpqUVJJU62n4rHf3Gr2l1YAcdDzr8FlyHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594598; c=relaxed/simple;
	bh=krhky/M5cxxzAM3ulPdTJzrbQDI4uDuqpjWTZSNhVKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXDu5ZPSt3ESWC8Dp7fb16EIGvfG50sv6ww3/WleoiLndIwsjj1ty0zOjUqTx6bzT7SyJdIlUM2C1ZPdBQcjKVvvQM9hbFAS49soOwmb70jeejP+XQdThBSkCCyQNqMZiWTU+sQ++7fQPtad/S0+TDesWaVUwDeqeW/x0TRbQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=zufW3TR2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48e82c23840so20723805e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 07:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778594592; x=1779199392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNTnECiUqRJEN9vpnmevNhQ7pOFBCpaU08kQYt/hGqo=;
        b=zufW3TR2gUGW0yIKkTan8aoMISef3pASDKyC397CVvZF6ZzTaCdzykMHhxvGoa0uES
         R2tJZEXYo2MPITRVdoz2L6UPjL6DTs3af1gSuO2nvV0VoDINRyBbQMsE58lNjRpvtIK3
         tDKm0yJVd30vYu9axybyzTp93Dga3TH9hboFa1KbiLlpTJ3xTXJqjo+ThDTKeAjLHzGd
         dzqxexGjEv2N/3dGpluum6uB99B+jqyG4nZkxtqG8mLgnm5i16zbO8wLblRErugtZAZF
         u+KA3h4eyyYNOuj0JwuZZYfCLieas6jEqCXgHS4xE4ZXP+Pk8qFg0txiVw12aSHEhWsj
         2S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594592; x=1779199392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNTnECiUqRJEN9vpnmevNhQ7pOFBCpaU08kQYt/hGqo=;
        b=EmgLFBDwOKNwdICLp/hBrAWDiD47efpmJP1ENMf4fZic6D02hpWtk9uu/Po3b+KodV
         v7c0VqWusStV+bHpyDgeC5Jii3+yUyNQi6Z9146jx2rm5V8hKBDf5gnCjwea4JiLe4pV
         xWFZKI2K/gv26dT0VFn1OsmNzUmXeDJAkjhJXtReMzjL2dfnpn+GBIhvrhnhe6NSG29M
         OkyY+/3alGFMGzodIaOUM/EVXeURiz1Irxvt6i3A7lHze/AP8RirWotZTpru0Pjm6oXu
         5TDmf54Nrih+Aw8mGGogGSSKy3yyeKccqRCL4OHRTeb8L2gqJ+6J+EHg5lVRlc+P01Rx
         H7/A==
X-Gm-Message-State: AOJu0YzVBBilri0chVWjW0jynnCbUdiW46ewna9cLT1prvqEk7AjZ0/Z
	gsGLqV+o7BORjvUB8TUwrN6pLfv8kZ2AoaAM5CBhao3tZKa9j14/pyq04cb9yK9Rj1Y=
X-Gm-Gg: Acq92OGO4Ddz/qx0Ras2hlKDXaJIPfvXtaDjjDEBchtGugi7xar5EiFCrV40AXIqEB8
	t28cklHx4QddEXmZlWk2jNrTMfKY9+u3QqqgqDNptxpaOnbWsS/7aGqTISqssltivYFscm1C6rm
	YBHm/HjaltZoOsL6Tu6UOHOe7n4yTuREZ0zZvRXS3k+itV5zbjWHHENUKjpmbAUNYekZNeWRHdo
	rwpbsXfK4gg6OxFiEASkO8xHW1vhPDFCN4G6GmZOeplWnzpfAmMTCgRFznWs7+OvpT5BwYW1v70
	nHnThfAzXcpypuSzgaAbAcSC6IJ2iVfVd0vCof8FNMrmxIzgW/mggyczdpB5pievN+ZebxnUY51
	oPpvmmwaCcsaKo3pXKEaJVgQgU8tby2j07V9SNU5L98wP/ijgUtLlhQ2M6ai3bjQMHgSqM0LdgS
	PfKZW0LDViH1oxN1h88axzlCseN5WcuLc53WV24uyHZ896vw==
X-Received: by 2002:a05:600c:a11a:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48e8fe4b372mr35584435e9.4.1778594591264;
        Tue, 12 May 2026 07:03:11 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e64385bsm20758065e9.12.2026.05.12.07.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:03:10 -0700 (PDT)
Date: Tue, 12 May 2026 16:03:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, edwards@nvidia.com,
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com,
	yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 1/2] RDMA/uverbs: expose CoCo DMA bounce
 requirement to userspace
Message-ID: <agMzG-ZX6TRoikrI@FV6GYCPJ69>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-2-jiri@resnulli.us>
 <20260512130329.GU15586@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512130329.GU15586@unreal>
X-Rspamd-Queue-Id: 343435231E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20491-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 03:03:29PM CEST, leon@kernel.org wrote:
>On Wed, May 06, 2026 at 01:14:46PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> In CoCo guests, device DMA to regular userspace memory does not work
>> because the DMA mapping layer redirects all mappings through swiotlb
>> bounce buffers. Since RDMA devices access registered memory directly
>> without CPU involvement, there is no opportunity for swiotlb to
>> synchronize between the bounce buffer and the original pages.
>> 
>> Expose this condition to userspace as IB_UVERBS_DEVICE_CC_DMA_BOUNCE
>> in device_cap_flags_exi.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  drivers/infiniband/core/device.c     | 6 ++++++
>>  drivers/infiniband/core/uverbs_cmd.c | 2 ++
>>  include/rdma/ib_verbs.h              | 3 +++
>>  include/uapi/rdma/ib_user_verbs.h    | 2 ++
>>  4 files changed, 13 insertions(+)
>> 
>> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
>> index b89efaaa81ec..ad3da92c9318 100644
>> --- a/drivers/infiniband/core/device.c
>> +++ b/drivers/infiniband/core/device.c
>> @@ -42,6 +42,8 @@
>>  #include <linux/security.h>
>>  #include <linux/notifier.h>
>>  #include <linux/hashtable.h>
>> +#include <linux/cc_platform.h>
>> +#include <linux/swiotlb.h>
>>  #include <rdma/rdma_netlink.h>
>>  #include <rdma/ib_addr.h>
>>  #include <rdma/ib_cache.h>
>> @@ -1419,6 +1421,10 @@ int ib_register_device(struct ib_device *device, const char *name,
>>  	 */
>>  	WARN_ON(dma_device && !dma_device->dma_parms);
>>  	device->dma_device = dma_device;
>> +	if (dma_device &&
>> +	    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>> +	    is_swiotlb_force_bounce(dma_device))
>
>It is the wrong place. When I worked on my DMA series, I tried something
>similar (a call into SWIOTLB) to notify users that RDMA would not work.
>
>The general feedback was that this is a layering violation, and that any
>knowledge of SWIOTLB (and its API) should not leak out of the DMA API.
>
>You shouldn't call to is_swiotlb_force_bounce() here.

What do you suggest as alternative? We need to somehow tell the user
what is the situation.


>
>Thanks


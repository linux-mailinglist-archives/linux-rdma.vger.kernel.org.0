Return-Path: <linux-rdma+bounces-20492-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFqNGNk2A2pK1wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20492-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:19:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 636BF522350
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 16:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B07B30AC47B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E133AB5A4;
	Tue, 12 May 2026 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="XzErVxzV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C63AB462
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594661; cv=none; b=H6SYi+xqvuJF/yJU1nZF1QflqwbhjUTvqkZ1wpCtLZD0GvQz+bFIE/4zbQTaGSl4AU1gkRwQFPUZp6Xu6nYZLLlKNyVBDjwnNuDYsQq+m/4uNgHxGac4G+ZLNlHEJ4fSPGwRiayN5oOxAEByI5IeztOMIPTtaUWYsNMMykQg/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594661; c=relaxed/simple;
	bh=U9ynlyYZyxiZe+roCA9kQnSsad0dD+65yEb24it0MIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVStnRiboYRfviN4Czak0PlMTxi3SR/wtklYKXUhpWQxipnn/TkLiDOD2PIyTyNnKZcmpDEtGG/OCFu7BKfRuJ/RnI+9cS9+qTAUFZ69QiUPd5cD5MLcXZR7ic7ufGh1hiAf/ucW4MEdRJkbLxL1ufSbsncBFgAt4TBBVPzSjaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=XzErVxzV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44a74032ff8so4147988f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778594658; x=1779199458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=951HKGxNHyVMV4WYPINgnwK9W6qDZrEaB2HZn2DV6hg=;
        b=XzErVxzVZjIxVvObl6TIFGqTUBgxNOS17yDJW0wnJ4slgtP6Bem96f5SRF0LpjoXSx
         s5yKBI+LvLmCKUbao1tU9B1JZ8PcPwsb0lOjE8JHMntRgPVZ5S8bA5OzNrZTl1LnDD2y
         nA8NdqupsYblA9DDD/F3W5F9ALYbZAcd0hkkv36hR2AQ7UJzW87Ukv+6G8FeqMCMWT4n
         UqLlDRm2kEc61GlfDq1+dhC09L8U+5huSBpMFmpSUKjDEjFl6e/CRASvSL6vOsHsnTpJ
         pgif+N9sVv7FXEvcYZg8Up0XUgUQJdYx7lQrsxXFvBWLYfOf/EvpEeXg5+PAIX0ailR4
         ivSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594658; x=1779199458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=951HKGxNHyVMV4WYPINgnwK9W6qDZrEaB2HZn2DV6hg=;
        b=RPsbDVl/fQSXNeO5mdSsOZuxVyawlrUqmezvIBujswSqtoDc9d/N9UE7Wd1TV0sLFG
         m1etD9HXpelwP6+MPW2uXM5Kf0SSF/i6qMIPwOvD8YX/tPxTdQEiOmVpkkIUJn0wJw1u
         rUpzR1p7nl744AEkyEh2Z4cx8EquIqobrH5R4OWfhnNr1TtCeKoDN+UEJtly3n72+n3D
         NYNhbZbtFZJmyT5UBv5YwqeDbx4ruAsYwlzZuapCfsj2IXNIn9tMMXdtaaK0RLychj5A
         fC6M3/SrCom9vvp5HdmgF0KmkHx1aCUlLjiP3FE02zXOdmJhxNcQ/R1ENpxdIZCEFxae
         Niow==
X-Gm-Message-State: AOJu0YwnracsPGUJnFUPksTbie4quUEcaRv7RHwhu758ItqxLqO1PUKw
	pWqOxr16fI5+0XIXycGUbVuG2euM39tJANwR5irj8vDKnPjm2aB24nnaG+U0N7GpMLw=
X-Gm-Gg: Acq92OGmmATlyLieQmHXGKnLU9aR24d3HQdj3KCFLiV2zD3HyzW88as3kHBznc+HkdE
	ngPX/SVPgxFxLSRt5FUnmebcKhw2xxhlcnu5dP6/wZqBOfh2xDFl2FtF4hZQCY84HVZLQuBBWRw
	Zy38M/r3tZoaZw7EnUtuYeD7NK3z6c0Y4Hrd+i3f5zBMPxa0glXBavcngoA+y6MLxqzNr9pSkOG
	3Zb5/3R9H9McFGPjwS43wTSOgNkFM+doao7ahaLBnZ6bpbncwESpRnDCHdnQGdy2vlyEz6N/Gh2
	VDJRtBH8Qjz5owhGOqjn+MedTlcUjMfyg80hz9Jmy8l7pi1MqBh+D+PTiFr6CfxtxLPhfepuh/N
	QHJhRJZQbgIiL85kolqqXlIOjFVGXI3S08jkCGtAjNp3F74H46J/nisJ6xuwKCSf9lFDM3vOg5n
	0bBi5qQMEyT1xMCd4tgKULtO1HFY6g13AwYbE=
X-Received: by 2002:a05:6000:2013:b0:43c:f3ef:ee36 with SMTP id ffacd0b85a97d-4515d4d0fbcmr48908862f8f.33.1778594657661;
        Tue, 12 May 2026 07:04:17 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491304505sm33015706f8f.22.2026.05.12.07.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 07:04:17 -0700 (PDT)
Date: Tue, 12 May 2026 16:04:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, edwards@nvidia.com,
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com,
	yishaih@nvidia.com, lirongqing@baidu.com,
	huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn,
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v2 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <agMzXaCIhX4m7ldo@FV6GYCPJ69>
References: <20260506111447.2697789-1-jiri@resnulli.us>
 <20260506111447.2697789-3-jiri@resnulli.us>
 <20260512130515.GV15586@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512130515.GV15586@unreal>
X-Rspamd-Queue-Id: 636BF522350
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20492-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 03:05:15PM CEST, leon@kernel.org wrote:
>On Wed, May 06, 2026 at 01:14:47PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> When a device requires DMA bounce buffering inside a Confidential
>> Computing guest, __ib_umem_get_va() cannot work. The DMA mapping layer
>> redirects all mappings through swiotlb bounce buffers, so the device
>> receives DMA addresses pointing to bounce buffer memory rather than
>> the user's pages. Since RDMA devices access registered memory directly
>> without CPU involvement, there is no opportunity for swiotlb to
>> synchronize between the bounce buffer and the original pages.
>> 
>> The registration would already fail later on, since the umem mapping
>> is requested with DMA_ATTR_REQUIRE_COHERENT and gets rejected under
>> is_swiotlb_force_bounce() with -EIO. Fail early with -EOPNOTSUPP
>> instead, so the user gets a specific error code to react to.
>
>DMA_ATTR_REQUIRE_COHERENT was our answer to "layering violation claim".

I'm not sure I follow. What's the issue you see?




>
>Thanks
>
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v1->v2:
>> - updated patch description with mention of DMA_ATTR_REQUIRE_COHERENT
>> ---
>>  drivers/infiniband/core/umem.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
>> index 611d693eb9a2..b1877b83b021 100644
>> --- a/drivers/infiniband/core/umem.c
>> +++ b/drivers/infiniband/core/umem.c
>> @@ -167,6 +167,9 @@ static struct ib_umem *__ib_umem_get_va(struct ib_device *device,
>>  	int pinned, ret;
>>  	unsigned int gup_flags = FOLL_LONGTERM;
>>  
>> +	if (device->cc_dma_bounce)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>>  	/*
>>  	 * If the combination of the addr and size requested for this memory
>>  	 * region causes an integer overflow, return error.
>> -- 
>> 2.53.0
>> 


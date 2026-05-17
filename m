Return-Path: <linux-rdma+bounces-20847-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HJIM3rOCWrxqQQAu9opvQ
	(envelope-from <linux-rdma+bounces-20847-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:19:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 343CD561949
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAFD3302268E
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD03C09F6;
	Sun, 17 May 2026 14:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="QcyDWCXd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346F3BA236
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027467; cv=none; b=JoHz/abqcYV87/UPvjGyaguGI+TRgwLxlBl+FnGRZR5hVFI47/TQMWe4LEeHyS2XUAYqjOIdC1iW0GpQFTj8i8ZSG8RXRGQ1nhNRXrwAoHSsfuolrUPbvH3RE5TVgqlYn8/VMbWuUHzo4/eswkmLj8Tal8JNmKwwbc020kKIaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027467; c=relaxed/simple;
	bh=CdLyvNcMLnx553Lft8+y6eeHWpwezj0yJNCaraW/wRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8b89gdEMmK1Nyfn4+CALVhf/FrNg/N0w6iUczYjTORVaZpOEqCgFF5sYOSQcNWj7jvhndi94+h5iE+vqSqxNd3mcPFbQwcyPMpdt1hwlMu7BR13GcRVjq9YEDLBcJ4+oLkDnRCavluYIvoT/bgz/YIvRyCi0dzDfKEWk+6lwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=QcyDWCXd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891b0786beso9714695e9.1
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779027432; x=1779632232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lSfcVcBj16S4Fj1lAbyBzegPMIs1wVOb18ju2jefGw8=;
        b=QcyDWCXdIhokrhzgYXSVH/Keh1c0wf5XP/AyQYKKkCyYLQoU2BahJvEXktiqALOXFf
         dSLCkDYuUXjyYxF19wKW8XwaunYsi2j1jaqajhLPLGXUY506RAorh32dLTGqtkrreaCp
         1T3/hCu7Z1+kjcJvlYRlpd1fZt6FfrELdQaN8SSKHI7PArqS5bYihZpIo2WCv2dcqQEB
         RFWrAQ1rERLnHutuNnC4/SGLniTpDWxhyRVFUxPBRf2FbSPJ4XHIHhvAzQO9v1gPEpEf
         KydxnoN5hi8maUA5Stwu+j4AOx+Syf0xMwdX+++K9RZfscaYkKCGxdMDWZXqPneeuTfy
         8VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779027432; x=1779632232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSfcVcBj16S4Fj1lAbyBzegPMIs1wVOb18ju2jefGw8=;
        b=RnP4c5m1E/nZ8My7h0iP8qJuPn3Qe71LI+7gmcAWNE9s8x2gNVn1EQ3e5Q3ezVoHUO
         D0MLDsgl1E0ft1KX9uOlF3FwJrxo99eS/mH0FVR0xMEOpmYScUv4Ln3N9ZJfL2GKzHFk
         Ed/OKiIriXjQaHVyeH2B2MS3edk2hY4GH8PHli6J+DJPsAPPHBcrOGEci9NgwFBKMYjg
         3OXSlgaJ+3WEG5zwqc1bqpczI0ZhK+VZzjSi3PRJv1BMhmMIEklXBtZq00ZdXTmscr+9
         j9oZoihdAAnJlx7Pk6jm6aYOK5MyS5cO4gzR84iNWCTRjdLvDpXAfYW2W1CT56VAFWPW
         xtMQ==
X-Gm-Message-State: AOJu0YzV78d8SWQCAcHGT7ZLkpATyHNyUoucmYk53KkOrvjS2xWAPI3m
	nZZ6/shlGiPcmwgUAhWsYCptbO7s4AvhxflBT74+nS1Fc8t2a5QeNGl6FQ3xRro02mQ=
X-Gm-Gg: Acq92OHCkLIyi51fU4gkiiUwMFGyuiNFLekVi1lDtWYGRZe+gjWuwE4aqxxluv9mUS7
	9KS8cXGBw7fUXWPne02AeZB2wRVaCswfCw6oYSkFjt/OwgWbOV9PCdgmAcjP99Qxkp7LjmCr2g0
	47UfUiUbTuwk3wzpfN5wyfSU6dMnl3OtZH1F0SXDGPfm7rtoueUo1p3xeic0I2hHUcBxJdUjFbW
	zmu1Lv1RhNjBKXR1momCipvjy8MCxihAlmaSqJi6y/UHpXLLM/AB2UWkTNIURXsyAngx5ptM3fk
	lmJZ6XIps/lu3LD4kwtRqblMhsl1Lxl+rve+dpcWGDBLLkYIUXr1fFA28+FxE52FdRpiHq6Q3R7
	0F3hv9RCD052qPUYE+9BCFKTBnDPJijGersPljzfQDCPtlWMQC/Tv8SSDzePvdkbRS4tFM1GtW4
	zCPwYI8uB+eY11FLkl1GPRiDxhfBO9PcIvzNaiw+FC5CU=
X-Received: by 2002:a05:600c:c116:b0:48f:e230:2a22 with SMTP id 5b1f17b1804b1-48fe6632e84mr137267965e9.33.1779027432337;
        Sun, 17 May 2026 07:17:12 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:4146:8430:fb4a:baf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c885d5sm176171635e9.5.2026.05.17.07.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:17:10 -0700 (PDT)
Date: Sun, 17 May 2026 16:17:08 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 08/16] RDMA/efa: Use ib_umem_get_cq_buf()
 for user CQ buffer
Message-ID: <agnNwU8sWJgRjbtW@FV6GYCPJ69>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-9-jiri@resnulli.us>
 <20260517113603.GE33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517113603.GE33515@unreal>
X-Rspamd-Queue-Id: 343CD561949
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20847-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sun, May 17, 2026 at 01:36:03PM +0200, leon@kernel.org wrote:
>On Thu, May 07, 2026 at 02:52:23PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Pin the user CQ buffer with ib_umem_get_cq_buf() and take
>> ownership of the umem in the driver. Fall back to the
>> existing kernel-DMA path on NULL.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>> v2->v3:
>> - used ib_umem_get_cq_buf() to get umem, stored in efa_cq->umem
>> - replaced ib_umem_release_non_listed() with ib_umem_release()
>> - added release to efa_destroy_cq() and new error path
>> ---
>>  drivers/infiniband/hw/efa/efa_verbs.c | 27 +++++++++++++++++----------
>>  1 file changed, 17 insertions(+), 10 deletions(-)
>
><...>
>
>> -	if (ibcq->umem) {
>> -		if (ibcq->umem->length < cq->size) {
>> -			ibdev_dbg(&dev->ibdev, "External memory too small\n");
>> -			err = -EINVAL;
>> -			goto err_out;
>> -		}
>> +	umem = ib_umem_get_cq_buf(ibcq->device, udata, cq->size,
>> +				  IB_ACCESS_LOCAL_WRITE);
>> +	if (IS_ERR(umem)) {
>> +		err = PTR_ERR(umem);
>> +		goto err_out;
>> +	}
>> +
>> +	cq->umem = umem;
>>  
>> -		if (!ib_umem_is_contiguous(ibcq->umem)) {
>> +	if (umem) {
>> +		if (!ib_umem_is_contiguous(umem)) {
>>  			ibdev_dbg(&dev->ibdev, "Non contiguous CQ unsupported\n");
>>  			err = -EINVAL;
>> -			goto err_out;
>> +			goto err_release_umem;
>>  		}
>>  
>> -		cq->dma_addr = ib_umem_start_dma_addr(ibcq->umem);
>> +		cq->dma_addr = ib_umem_start_dma_addr(umem);
>
>This patch is the one that confused me the most. Didn't we already set
>`ibcq->umem` before calling ops.create_user_cq()? If so, we're now ignoring
>that pointer.

Indeed we do. It's a transition. ibvq->umem is going to be removed
entirely few patches later.




>
>Thanks


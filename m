Return-Path: <linux-rdma+bounces-20514-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJcyNWF4A2ri6AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20514-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:58:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41112528503
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1DC6309687B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B581F91D6;
	Tue, 12 May 2026 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Mbr8gSwf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E87625B081
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611233; cv=none; b=Bl8ze+u53F0DhEMQMpy0GljCbgvfHtHgpRTVV9PoYVgENsbuNu6L86W0QbxBVGzdi+bQGMFRcFi3dlMwfWbSt0+e0/wyXhLBTSQBOIJYsQ0neqHFIpXzJXTXjpoPQdJHDSI68ahqTfRtf8GlBHCEozD65HUWJuOQsUFn6GFVx5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611233; c=relaxed/simple;
	bh=DRBAVSHpzeLNCUF84SVtfoGSH2yVaHZDhrZMhFCKT9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce6TVoqXHNk5upw1cKmyDOFm6JNbWniSFXhhKgQZW/vjZJf6beBJxDwYMUcCo6csLbVA2NGjXn4X6KcZEv8BhcMeVI9XA7jRapqOUq806GmJs6B0p4kG+uc/MtyeNwaoVbxFWxm4oLgG5Xev19jmZYOPnv1978Viu0a1HMKHXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Mbr8gSwf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso4801784f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778611230; x=1779216030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mC01vuD+AES2DJCrLU9aahGx2LTf0iNn7xFbdIleELI=;
        b=Mbr8gSwf0kOtryKQkdRylejz21mqdZYFCS1gjJraadRU6qtVfPJdjnHj6eoq2k9cRx
         QJqHVZla7pyOFy+/MzRYXOGkO9KqEOyFzupiyvdcdWOSckOF1PJLaNu7wnPqQBdcmF6w
         XOC7rnUe0siWATpskyOpCT2sylyiynlqLHGXYHP2jWu4MsjgXEcgLVQkaUNmWy1lTriE
         fykgKgodzmfEhoEe22wlz2TqC7iWPvuHfntAQ4wwKIDH+bIXXrnp1owKdCj1YhAoc4Nr
         OQ41nUBqssqunB+4evydgT9TujQ5OAiT4I1oGTJ05+xWAR1bn34CLAjcgiBj2XxGz4O9
         Re1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611230; x=1779216030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mC01vuD+AES2DJCrLU9aahGx2LTf0iNn7xFbdIleELI=;
        b=YIPSGSijRseIxny01PGOP6UTK2I0Z6SWShaVMPPwSNtTIbLCPVOpjRuslaoFgl2Y2L
         1kFRXfFxwKH4KdDStp4qn1qdKZ9ktgp0N2PXG4+cjm8BGncEZNZT+mVTaKWqRlwp+06B
         T09Z2KNAu2wsjlLlcWoobPknpNMWMJEVmawpMfXtp+WlcTufeYoIGvT7ZdCyihjHP927
         yEhAz8zkL2fIxrLCftBw9wXuxq2EpVWKld57rkMOtb/70lxjcvDlw1WcClCjwS6AWcTn
         aBCX1pnTkGgKOOc44SRjk44A+1aThCSkueYRiSVWODVD8qBdTihXfztlHUxE4gAfzEoh
         2nww==
X-Gm-Message-State: AOJu0YxYeHLYpHIzWMksDkND80AALXETpvci7+sLtW7V+DR3fUd68gA5
	XN9lAMeWEtZf+Y60O4ReKi4YzIb0EwUEsyvkPxbhwmrb7muXjLsStTORUgO/goYmGJ4=
X-Gm-Gg: Acq92OFbJS0TSk2iOOmWhdl1XiDWcCCE+/RYmzOiFBx1Or1G6FB1hLqwcM5chA/YFPB
	mXPd0rjuoievvpJNkdZ4tHUpqx08m0Tw23M46j5slm9NrKSTxwmBbdtFlrZN54SUghEGZ/I/ew+
	1csN90N0uD8lgtCE6RwMntE8Yk7SMjZVcNEbyEm/tjtWiQFYo0+efagG3ZaGC/0ueUfaeFkRays
	Vjg02jirofJYWOJuFvHctD3TEztoiyR5Um+yJ5mvC8caU2zy8pE7qAZFor4yVbNQiyd/Pmxr47h
	QPInFgWngwHybcjuV+0mPZEHcna3kL0V0rLRZTo2bBPLS3C0f6ZhPEbYhp/phNMxQFLRvLQ6gHT
	IRY7LnWNcoHELSjoPD/rQfl4jXCwGeapJnO2DlT2dBWHjvMZBtF9AgKzgkt5sGTe4yl/csY7A6h
	bUWSH4t+BnfpmZKlUtzNA/N/Rwt7SLODhXug==
X-Received: by 2002:a05:6000:10cd:b0:452:8772:b36a with SMTP id ffacd0b85a97d-4528772b513mr31422082f8f.2.1778611230521;
        Tue, 12 May 2026 11:40:30 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.211.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6aea4sm39735162f8f.10.2026.05.12.11.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:40:29 -0700 (PDT)
Date: Tue, 12 May 2026 20:40:26 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 06/16] RDMA/uverbs: Push out CQ buffer umem
 processing into a helper
Message-ID: <agN0Gr4ul-a3DSvg@FV6GYCPJ69>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-7-jiri@resnulli.us>
 <20260512180342.GI7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512180342.GI7702@ziepe.ca>
X-Rspamd-Queue-Id: 41112528503
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20514-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,ziepe.ca:email]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 08:03:42PM CEST, jgg@ziepe.ca wrote:
>On Thu, May 07, 2026 at 02:52:21PM +0200, Jiri Pirko wrote:
>
>> +static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
>> +					    struct ib_uverbs_buffer_desc *desc)
>> +{
>> +	struct ib_device *ib_dev = attrs->context->device;
>> +	int ret;
>> +
>> +	if (uverbs_attr_is_valid(attrs,
>> UVERBS_ATTR_CREATE_CQ_BUFFER_VA)) {
>
>I know this is just moving code, but I've always disliked this
>function. I learned a trick using a case statement for this recently:
>
>	u32 present_attrs = 0;
>	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA))
>		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_VA);
>	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH))
>		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
>	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD))
>		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_FD);
>	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET))
>		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET);
>
>	switch (present_attrs) {
>	case 0:
>		return -ENODATA;
>	case BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_VA) |
>		BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH):
>[..]
>		return 0;
>	case BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_FD) |
>		BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) |
>		BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH):
>[..]
>		return 0;
>	default:
>		return -EINVAL;
>	}
>
>No need to build the complex tests to check in each branch if the
>other branch attributes are presented.

As this patch is just moving existing code, could we do this in a
follow-up? Patchset is already long enough. Will add that to my todo
list if you are okay with it.


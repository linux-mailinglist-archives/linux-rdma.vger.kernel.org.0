Return-Path: <linux-rdma+bounces-21151-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFREEoMUEGphTQYAu9opvQ
	(envelope-from <linux-rdma+bounces-21151-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 10:32:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 442205B09F7
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73CB73004048
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 08:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930E324B1F;
	Fri, 22 May 2026 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="QWg1Gavd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4922A26F2BF
	for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438715; cv=none; b=nkYmcUWtFTMSjtmrnRUsZViwjjupmi3ERen9etk3XR8zXZYE6Zyy13iLog7/rBGXI9Hv7wCUdfTmOa9eWN+yptYJl1fUOJx7p4FKyrHUCdB+HtRw7oR3unUJIQrEOBXz203AVG5uPX3ZfhXNqrvC1RzWmm0CHQGP5Jswe/qlIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438715; c=relaxed/simple;
	bh=EEqkT27TlId4h3beUOLCoSv9cHFPJwmJ+6ESFzXgDKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjdzSlYdtEHPnzGPp8N8uWWmuGTImZaqyW80Etx2+EU5bVDUi4dGr5cAhUOdWEvna0qHoFVWxGwpFgELR0e5bFs8K7hpUy9pyZJV+GKF9WGm2+px6OOJUya9I7g0sxgHgkix0+h6dYgY/6WKs6/nN3fvHEsmvqDJ7PtcuCqw1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=QWg1Gavd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e82c23840so56705915e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2026 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779438708; x=1780043508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5L+TbgpqpAMywBwsF4TYhq+71zfTDBHT9Bwfrcc2e1w=;
        b=QWg1Gavd1iqgBKM+eTgaUVrs1bs55Du2SSkFzFRHepd2fj8fGvQ235aXjH9W10l/D1
         y+kqhlKBeFZI1Kypd+AK7uVQKw4OqvQhcUY51ZYS5uTMkdbyYorz2aJfWgW/vHnSSgrJ
         RB/n5RMWusnJ2NeCaDT5XA7mghyzFDz3PsVhi2xeA51gFng3MU5YZTMPR1pYapDUMGPs
         +u36t/hcIxsdzdWfx1Yrsp5IRBunbXz2zimBNmdFURhmGn+gXht6KuO9bU1nSr9vM099
         vnaaWpNLBiztP2lrTXxGuhlKCm5xKIWTIGx1A6iMq1sM+y8oj/PFYX9Sk8VSKAILlrU5
         FLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779438708; x=1780043508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L+TbgpqpAMywBwsF4TYhq+71zfTDBHT9Bwfrcc2e1w=;
        b=fN4gjL03m1Gt6K4FJ2IoxtNwK0gokWv4Jwwkdc2OaT/V6zGFxd3+BQ8cH5AWFn5LK4
         YBTnBxFB28TeV2QLCgaFTtEB01JwlQ5YYg3wkTtPFS+SBv1VX0/DT+JdSq60eXxp7wCz
         jUJxkB14fPUlrr6+hXcOmolz0hS5zvXdP/YrW++QE2KsoaR7MDzQPTy54HDVo7clFRIF
         8c95q7PTXmOD+M8pjGhFmh3nO4ZZWxLojAZ0I1kvz9UH1Bn/MQtISXccbugLAdE23UTP
         zO30+L2zcdHipSdik9C99xhJCqx/vKM6ImjUOn9ylmoQzfnTOGhkqrFYWchXdpZ2pU1U
         8jow==
X-Gm-Message-State: AOJu0YxgVkipbS3qw23zveUNFPgDSCRMSP0doLxofaZzXpX6gyhlQJ7Y
	nMQt67cQg2M2LurM1kFOcxOi8XGlyS/1NpBn8B/QDLaVRGrjFFude3XsfhPXzp9DoTM=
X-Gm-Gg: Acq92OFtyPFT3UEYEv7WKvN13cyXBvS5fIbHRmmsZMx7UBN6+fCT4gE8LBJWiw+xYp4
	gUiw+bUxNQOyLJeY1y5whwKLRDuFvPo+NJXUqOw9DytEC/VbdRQCY+5Yan846GtasG4ASPcEmTa
	aWyNhOybecZn6Wx85nZ6STXDllAJXs9pLZYcFEJCouC3EpdB6f3GBtmM3pIuhRjIdG2+CkLYHPM
	RtcoJK+ksJNLNN7iEtqHwydxIZiJysq2cKQpte9cUihQja1nESE0VH5y+a63ZlQeMITvzhnGZN9
	ko7VXgF/C/L/YlaJW91A6dfiwJkiKDSfQz44dt4z2TYHNHD0Z1Sfgnjmg2U0jO+iW9Z7T/jKqeo
	e7gkPAHKLxg1Y456bdy5et/XGjwOjRvUgixepprlpd37ZSWOzOWEyaXFp7xqBv2KPR9sjd9ktn6
	yO90XPgEwWUYSLRJ8gYR+ZrOylmcBtWHJv20BqelVZ00I=
X-Received: by 2002:a05:600c:8484:b0:490:3b87:be0e with SMTP id 5b1f17b1804b1-490428e3362mr30797615e9.29.1779438708254;
        Fri, 22 May 2026 01:31:48 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4904526ca50sm25643615e9.2.2026.05.22.01.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:31:47 -0700 (PDT)
Date: Fri, 22 May 2026 10:31:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, edwards@nvidia.com, 
	kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com, yishaih@nvidia.com, 
	lirongqing@baidu.com, huangjunxian6@hisilicon.com, liuy22@mails.tsinghua.edu.cn, 
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v6 03/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <ahAK4bTnyK3Iswef@FV6GYCPJ69>
References: <20260520101129.899464-1-jiri@resnulli.us>
 <20260520101129.899464-4-jiri@resnulli.us>
 <20260520160844.GW7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520160844.GW7702@ziepe.ca>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21151-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,ziepe.ca:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 442205B09F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, May 20, 2026 at 06:08:44PM +0200, jgg@ziepe.ca wrote:
>On Wed, May 20, 2026 at 12:11:17PM +0200, Jiri Pirko wrote:
>> +int uverbs_attr_get_buffer_desc(const struct uverbs_attr_bundle *attrs,
>> +				u16 attr_id,
>> +				struct ib_uverbs_buffer_desc *desc)
>> +{
>> +	int ret;
>> +
>> +	ret = uverbs_copy_from(desc, attrs, attr_id);
>> +	if (ret)
>> +		return ret;
>> +	if (desc->reserved[0] || desc->reserved[1])
>> +		return -EINVAL;
>
>I'd like to carve out some space for optional kernel ignored flags
>here.
>
>Basically a flags field that kernel just ignores. If userspace
>requests a flag through this field that the kernel does not support it
>ignores the request and does nothing. 
>
>Then a seperate flags that the kernel does enforce every set bit is
>understood.
>
>We've not included this a few times in the past and were sad about
>it..

No problem. Will replace reverved[2] by "flags" and "optional_flag".


>
>I also want to think about how we can discover if the kernel supports
>this new path from userspace..

This is problematic. This is up to the driver if it implements
specific ATTR (may be generic or driver specific) or not. Not sure how
to do this. Per driver list of supported ATTRs? Idk. Ideas? One way or
another, this could be easily a follow-up.



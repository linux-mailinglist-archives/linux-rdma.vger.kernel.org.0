Return-Path: <linux-rdma+bounces-20084-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM16EwhP+2lFZQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20084-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 16:24:08 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF194DC144
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90ED030AB2F3
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6F47DFB9;
	Wed,  6 May 2026 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="UEQziuFe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A4747799D
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076885; cv=none; b=q1y7Nqe1RK/zCN7DDvEPYL2fTdg9fNRNxFYtdKtk+yUbnpZXOPjVWz2UTn7InLZu6rd95w/Jc4LBl5ylh3oOQKiXbQYC85iSxWYjNFzJDeSeIDxWmSD1oeCt9lkGXJ7vcC4tKvn162rOUTAqVpEaMXlzl/8KiEmPb69BNYrXyi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076885; c=relaxed/simple;
	bh=V92Ubofj3x90HB8/esfgWTgFv1y8I0dv5VNBs56LsPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ6FfG3g3/4PCoBTC2jJkHAegwobiJQ0vYhOx0ETyYDxwUDFdFnzOGwX3NuVvYwYnfGMOow04hC6UZAgMbkTGtErvLGePcSavU7ijz+gIsrzvrcPtNtODPzNddzu0os9lz4Kk7lqEFOz04ScveCHwFniaGkh79A2qANfxaWXHMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=UEQziuFe; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso77715635e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 07:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778076879; x=1778681679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lotSS3aHVW8Yq1kLnJO9LI2PcogVn+RfCBUmKl8BDc4=;
        b=UEQziuFekfY1bcaKzGWSkx+QeNCZmnb0Fg1JiWmq0XAjfqg3ZLsC68EK1qC2wGQVTw
         nvemyIPohd9VB6tdtOIEx9MC4PAfIDcs6nEabnW656KhxcDoaxswJ0oRZk3xyTAKCjaF
         avuDq3/SnOGsWNF72sp6oxsCuFlekW+122y9DzDiNJRMeq2Ny2K2DBYuAzMv5UJ5QUMc
         SEAcEqZ0drfrdO570uY63xGqdG3eyJW/bD9xvHiXYMhkn92i6BPFGmTJ4vGghrxhJtiS
         5hat6artLwmSUi55Nqqia1VK5k7Z99xWuLCdJuLgydOKmyQY21Yr4ZGijhlphFIEYEtM
         wTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778076879; x=1778681679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lotSS3aHVW8Yq1kLnJO9LI2PcogVn+RfCBUmKl8BDc4=;
        b=PSQdIlWInCoUTI+5SP8sSZAEBc+Rb+cPg1sFxTPjIsaq7nMjU2O7pukljJ8DCpM37a
         Ps23kYhAaYVKcSuJjjV5/SOC5qHMtxzgqoPdM1cGG2w+7QyCPr09GgztbZLpmZ8HBeCH
         B7+kZsBtRipYRI7l/Uvw85HRJWEpqK5lqAJjU6WEgA0VCcmJR5F2rEiRij4BxdGRgKQX
         AQPv07AZvig6/fg91meHLcfk5NeTRjh0i+xes0I4xWpIXHcwPsUQ84Ly12ENz/bXyaPg
         IDZR9epPBlmznewv10oQ8AhpmCbpqTqoNJtqPYdLpNS5FpRdvJToKdo7ISfS2bIuI5ng
         KXiw==
X-Gm-Message-State: AOJu0YzbJshmH3R3uKvVm9QtPupZp4/9Jxwnw2geiZD8uuBawQEcZGQK
	NX4YNAdMNPCLMoSnQ7RUXJFEtKTXCg6SLYST+RQ192dns2vS1YiKaZn72HpWd/ih63o=
X-Gm-Gg: AeBDies1KRchoYDgYjuPB6Ux/32Xp8q8OAR04uhshukVqcDAE5MlCLmYw0AeulW/OZw
	uiCojfjwC50WbG9TylDiIT81wtrZY3ImVPJdiKApZJG81Kh6xlNOZGZzHveWXXDrIo1V5uwmI7J
	K483cA6iB0HxjuGqIqqD9NpqPvdJ5Wy8pU3rBZCc4/rxinxTG6wvZkK3PYyHhvzkIuA2jjT52eJ
	wNDlZfd7vr77L3hU8ZTVGsglnAsawDeIl5pzoiiEFshAvSAWc19zwQyi1VQR6WEIJth5cPmpkaG
	/Svm3JunXm92R2u5srmkuLJi84kY5OVguT/8HG3cL8ripSKA7A3p5rByKtEfw1ZgfuQ8Ur3xOTl
	rrQKuB/idbtzLmBmIdgy9ADDUI4mdOv27sUPf3bb00mq9S6t4HdgIsNu1OWpQD8FR7OAkNGl0vt
	MHA99toRO8Z63VHF4LIY3QrEeaX2ao5ehLVHRJ0Tb8axwUgqS/41HcNw==
X-Received: by 2002:a05:600c:35d2:b0:487:4eb:d125 with SMTP id 5b1f17b1804b1-48e51e15589mr67768955e9.9.1778076878786;
        Wed, 06 May 2026 07:14:38 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:8c0b:afdd:3d9d:e976])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538fb19csm47568625e9.11.2026.05.06.07.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:14:38 -0700 (PDT)
Date: Wed, 6 May 2026 16:14:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v3 03/17] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <aftL-2sJb4JfyDIs@FV6GYCPJ69>
References: <20260504135731.2345383-1-jiri@resnulli.us>
 <20260504135731.2345383-4-jiri@resnulli.us>
 <aftENVgTr8AZVQnT@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aftENVgTr8AZVQnT@ziepe.ca>
X-Rspamd-Queue-Id: 9EF194DC144
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-20084-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:email,resnulli-us.20251104.gappssmtp.com:dkim]

Wed, May 06, 2026 at 03:37:57PM +0200, jgg@ziepe.ca wrote:
>On Mon, May 04, 2026 at 03:57:17PM +0200, Jiri Pirko wrote:
>
>> +/**
>> + * ib_umem_get - Canonical on-demand umem getter.
>> + * @device:        IB device.
>> + * @udata:         uverbs udata bundle (may be NULL).
>> + * @attr_id:       per-command UMEM attribute id; consulted if @udata is set.
>> + * @legacy_filler: optional command-specific legacy attr filler.
>> + *                 invoked if @udata is set.
>> + * @va_fallback:   if true, build a VA-typed desc with @addr.
>> + * @addr:          user VA, used if @va_fallback is true.
>> + * @size:          driver-required minimum length.
>> + * @access:        IB access flags forwarded to ib_umem_get_desc().
>> + *
>> + * Return: valid umem on success, ERR_PTR(...) on error, NULL
>> + * if no source produced a buffer (only possible when @va_fallback is false).
>> + */
>> +struct ib_umem *ib_umem_get(struct ib_device *device, struct ib_udata *udata,
>> +			    u16 attr_id,
>> +			    ib_umem_buf_desc_filler_t legacy_filler,
>> +			    bool va_fallback, u64 addr, size_t size, int access)
>
>I didn't try to look at what the drivers actually do, but I'm slightly
>surprised not to see an addr_size here? Is it the case the drivers
>don't have have a uhw->size to go along with their uhw->va?

"size_t size". What am I missing?

>
>I guess mrs always use mr->len and the cq/qps are doing something like
>uhw->ncqes*SIZE_CQE?
>
>Did you find any counter example?
>
>> +		ret = legacy_filler(attrs, &legacy_desc);
>> +		if (!ret) {
>> +			if (have_desc) {
>> +				ibdev_err(device,
>> +					  "UMEM attr (id=%u) and legacy attrs are mutually exclusive\n",
>> +					  attr_id);
>> +				return ERR_PTR(-EINVAL);
>
>We must never print on system calls, it just gives a way for unpriv
>userspace to fill the dmesg.

Sure. Will fix.


>
>> --- a/include/uapi/rdma/ib_user_ioctl_verbs.h
>> +++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
>> @@ -273,4 +273,27 @@ struct ib_uverbs_gid_entry {
>>  	__u32 netdev_ifindex; /* It is 0 if there is no netdev associated with it */
>>  };
>>  
>> +enum ib_uverbs_buffer_type {
>> +	IB_UVERBS_BUFFER_TYPE_DMABUF,
>> +	IB_UVERBS_BUFFER_TYPE_VA,
>> +};
>
>I've learned it helps backporters to add the =0, =1

Why do we care about backporters? I mean, the mainline code is what we
care of, and for that, enum default values are well defined and enough.
What am I missing?

>
>Jason


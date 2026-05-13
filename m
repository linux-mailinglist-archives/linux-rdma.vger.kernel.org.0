Return-Path: <linux-rdma+bounces-20600-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P/YH0bABGoeNgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20600-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 20:17:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB985538C27
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 20:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 229B23130A79
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 18:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB84C6EF0;
	Wed, 13 May 2026 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="olM87o1M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3564E3796
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695842; cv=none; b=KKsUt0RAX5Qj8/NVvLGT1QzyZZQcpkkgszQ5r9+l+lafg9GxnmWLiB/nfg5C3n9Wm4UjLhxDx3NQMPBWjhRpSFNVnZFl6xfl58IerrdfwmkZnWlAQOhGrOSo7GqaudHwkQmMojtZUQPC7+nwtOJk6SVLu5Hl8Doyux+Xe6TF+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695842; c=relaxed/simple;
	bh=gZxiwhPhcUkv3DTMaX//OGD7dkHMfpkVTBlM08nReXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpZ+scO0Zp9p91wURQpF+salou7CY9DtC6sTzo2xAQ73kmz9nU9E9s0LWdPOex+SWcufgpNJ285gOae+f9MP1tw5gBwCBq4xNh9VHXBtzoygWL01KQPfwZYEVImuVs+xNvnh/unoZsqtkK9XIdowDXhF4iN7IBIjRs5wuty9ouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=olM87o1M; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso4191069f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 11:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778695837; x=1779300637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=43igLQMcAzl+2eL3DA3xtT8jfA0HsU+87Y0/4p/2PnY=;
        b=olM87o1MnbhAYggb8mMhQfzgWaC6M3bHH2J2h3Wi5gOms+kdcXqo7Sa90SmBOKqF2I
         NaA5nSBDm8jSgOxihxpk6dtuus5mbxWvSCMElDkM2oSaPlIIa8ghp8fbYfGQFMvKKwv2
         /Xnup1WzhpCA8qWStJFM6+n7Aez/VJYOxQB8b4oI9WRSQGlzbRcAYo6FzjPUE7tKcdau
         xEHeSkodEhM5l77mHQIbGuXJwVAoJofxHBb1SMtUkrOdGXTUZYKWpHwdkQ/cIz+yCzdT
         STOy3oYingaT4kNfp7Z+YWiINemGWAvvIBJUhKj5BVGm9hebZghyTXg88tblRrd1VP78
         QE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778695837; x=1779300637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43igLQMcAzl+2eL3DA3xtT8jfA0HsU+87Y0/4p/2PnY=;
        b=HzGu9RbEpVSL9mkdB3HCzst+8LdRG5byQtTOtmJqss9RrlgvcjC19GVLOi9erSY/Zs
         Jj5Jr8mvqZDE0LQYf3NDkP0RMuv4SYtPXeJiF1Pkb+jS30HyWJ2+Tzd+WFY/E0qida4r
         SVuYE/VBltgnnCPLadfq6YJJvoh+bJUmy0UdY+8/h0T/mAq6umGp/V/SX1r3c+3LYtha
         vlEusEk3mT1bGpqp+yJgYqVz0wnEia1ljF/pe/TtEKDLpJjo7qpoWBocajNOdpTGlT1p
         +UhvpOg/y385wpyvG2Kv7tjWMyJCErBNR4teQfkXm4TbgywuHt9LW51636dv2Z3mmGuT
         eJhQ==
X-Gm-Message-State: AOJu0YxOAWE+UZQKwrF1qfePq5TlmCd8j/knTevODjCTq93+7YfM+O1P
	258qzk46dKxf8eugPuwlONMI8kuhOtb+WrkwXmZosb31lcSgVe0ad4LfHe0PXM4DYTI=
X-Gm-Gg: Acq92OH8w7YAeXtWkb5/4BLMqYH5CIR/+qWSGyVWrvjvStr4IEO+M4C3RFgyy51P3th
	JfPIHkii7ikhf3pP6BLE+5xJaPvlsswVilu6Us7tca63X1K03oPocsLeOYop2qOgMIbXQ9BwUO+
	8gJ0m9suCkEiWx6pCqs48SmpeALviapxqCOtIp0nMRQsTL8RbrNTXQXfzAycISrfeqkhOWGA+5f
	Z1cW+H41KyinNhBtPNHFRmTmEroWDjevwM3LN+bH11jJIQVq0Q60Mb1uyJd0uNj3DniajW/H6Ms
	szgN7jtGDvUwWD+jq4HdTpA7mKc/XBhFNqYHVvwCF/4CeNKDO+tNrCNJuS3ugPMvjZaCJSgaaT4
	OOIjv6kDJ+cV9pWHz4CHlDtv8fcAlC4dvwjY2L8h++cc1Lgak09tJN/tI88IsJ/vofsV31w9Pel
	f4iGJ23fO8JePxaynATiYCLtGdnKK5n18/YUk=
X-Received: by 2002:a5d:5f45:0:b0:44f:d9da:2c40 with SMTP id ffacd0b85a97d-45c5a1a8b66mr7127254f8f.21.1778695835703;
        Wed, 13 May 2026 11:10:35 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a562dsm561517f8f.33.2026.05.13.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:10:35 -0700 (PDT)
Date: Wed, 13 May 2026 20:10:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 11/16] RDMA/mlx4: Use ib_umem_get_cq_buf()
 for user CQ buffer
Message-ID: <agS-Txfk0jid-ut-@FV6GYCPJ69>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-12-jiri@resnulli.us>
 <20260512182927.GJ7702@ziepe.ca>
 <agRinwoVkaPujATb@FV6GYCPJ69>
 <20260513175124.GT7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513175124.GT7702@ziepe.ca>
X-Rspamd-Queue-Id: CB985538C27
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
	TAGGED_FROM(0.00)[bounces-20600-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Action: no action

Wed, May 13, 2026 at 07:51:24PM +0200, jgg@ziepe.ca wrote:
>On Wed, May 13, 2026 at 01:38:07PM +0200, Jiri Pirko wrote:
>> Tue, May 12, 2026 at 08:29:27PM CEST, jgg@ziepe.ca wrote:
>> >On Thu, May 07, 2026 at 02:52:26PM +0200, Jiri Pirko wrote:
>> >> +	cq->umem = ib_umem_get_cq_buf(&dev->ib_dev, udata, entries * cqe_size,
>> >> +				      IB_ACCESS_LOCAL_WRITE);
>> >> +	if (IS_ERR(cq->umem)) {
>> >> +		err = PTR_ERR(cq->umem);
>> >>  		goto err_cq;
>> >>  	}
>> >> +	if (cq->umem) {
>> >> +		if (dev->dev->caps.flags2 & MLX4_DEV_CAP_FLAG2_SW_CQ_INIT) {
>> >> +			err = -EOPNOTSUPP;
>> >> +			goto err_umem;
>> >
>> >Huh. this is getting pretty hacky.. The driver wants to memset the
>> >user buf to 0xcc for some reason, and it already has a nice flow that
>> >if that fails it tells the FW it fails and presumably is Ok.
>> >
>> >The issue is it passes buf_addr around insead of having made an
>> >ib_umem_memset() (which can reject dmabuf).
>> >
>> >Looks easy enough, change sg_zero_buffer() to sg_fill_buffer() to
>> >accept the 0xcc, ib_umem_memset() trivially calls it, remove the
>> >buf_addr from the call chain, directly use the umem in the
>> >mlx4_init_user_cqes(), remove the if above, use the
>> >ib_umem_get_cq_buf_or_va() in the driver..
>> >
>> >Leaving it like this just means the driver won't work with the new
>> >uAPI with normal VA which is not desirable..
>> 
>> Agreed. I would like to fix this in a follow-up patchset which would
>> look more or less like this (Claude generated):
>
>That plan seems right to me, lets just get it sorted before anything
>starts using the new uverbs flow.

Well, this is existing code with CQ legacy umem attrs. But sure, will
address this right after this patchset is merged.

>
>Also please look on the Sashiko report, I saw some interesting things

I don't see any url anywhere. Where to find it?


Return-Path: <linux-rdma+bounces-22223-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jz/BCN+7L2pCFQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22223-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:46:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7655B684B1F
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 10:46:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=AgB+kY3B;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22223-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22223-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77C22307D647
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 08:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCCD37F8CB;
	Mon, 15 Jun 2026 08:38:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D4336EF8
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 08:38:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512736; cv=none; b=KNchU2wvSF1B8A4X9ObpLiqzjQSfEBUU4/onrsmZmaRq/Fj0DS5o6P34trV/mkuqf7NAtS1MdXY4BZJYCLS7oqYHpPGAgXgXS5krGE+OPJCe5g2O5pIlnT8RFBcKD29HR7GsQ4XFdiXKqlI77r7ZiPDaZ16jahZBsXDM6CF1Zvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512736; c=relaxed/simple;
	bh=ZYmVFOgrTYHC/3wSPMeyldRWtEwfk0VBVIPxLuH6qyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GEUeZoM2s1lO2odRtsOLq2mrXSfAHuLeRtn/Rg9cDNuG44DZdh9lLeXjuZuhfkCn4z9BxmfPVb9x3dG+w/Y/YjiaYDmnEMEj3Futulc/Yx33gTJWdJIyWQfGRePq9LUnD2daZps621epArLIa47WoomClgFo7dGgkSAivwrMmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=AgB+kY3B; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490c1915793so26873915e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1781512730; x=1782117530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SOKcg9h2dIB7GoHqGxJTzpUfzkHeM9zk1DmQn+KH0Y=;
        b=AgB+kY3B+X82X3f6o7ZG2UQLtqOYOSZsY3PtVpJ9bH1J/Nny0ozqjXKkACUwKtIN0K
         ZJlN520GTTxu7iAm7I/fb3pU8vM8gd+HLGgsFCpHRdS5nlAwCMS9FepHoLj1sPe49eR6
         cNRlkz5SLA9UyQagmQqkxGpbbpHdjsJ0I4Ui/V6NsVM3DvHwfI8YcM82rMceWEcFJmRf
         lZlumP5yrNSUkzs4uCnBfbjyNySrYOjgOehC1yBlHx3IGzF176C2R7Zo5ED0r1LR9dl3
         4SqZSl+DQBT9bJiA5S15KxyioFEQXsAQlujONoiX9x+CNtU9T3oZxQgsCajbyEEzVI1y
         DX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781512730; x=1782117530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SOKcg9h2dIB7GoHqGxJTzpUfzkHeM9zk1DmQn+KH0Y=;
        b=d4o5djNEFWtL3PZGSI1Pihjmfu4Uv4A7PiR9y6427+46OB/1zt1VbxPyULmOP5EyHQ
         boW3jRbQk1Z23p9pBZMdbFiKlQpYxVjyI3ZtxM9QjBxsi+46Q//5SFyE1hOvrZ0xsVEz
         xDQBZdNl/13rvgNV8CZhRfDgorJzh857OoYxCFxm39QbD9vNMm+t9NF6xDSjYaIkOIUz
         URCc3oMadCfLuPlzAyuksxWXwcs/O3k5MaT0FrZWbsmMweihc3/F08dU7kCZ7xnWQejc
         VlXHPomoWQoyOxStSAl3FMqjdpVwKJpCqTQwGIkS3P7ISeQEaM99dacsMro/bVZQsFny
         vQEg==
X-Gm-Message-State: AOJu0YzymfR50W77bsyWtNmPqsVrL0pJufUKTlRfE4lrROonTFa1ssjN
	YGkSCBv6ss1lKcegbu2uuScptXy6ar8OrDVGmaX7yzgepVFW5MNI+qJG0JqMhv3wWqRHU1STUXV
	IjPOE
X-Gm-Gg: Acq92OGuJI/rMDmYBhYNFeCd45qt2qv/CexnOdnJBRNLMuqMgPpLFuBrfugz78GTfoP
	p2zQCtGamSbzyTu5MpY++KozKgOhiheoAsiUMYYUtM/XIe79YsL0+rUYTgQOXC4sJ+ZnjYxZ2QI
	wsPIgsj/D9eYbejb9/NIppoQGKSNKEq9GM8icHBRAW6CzY8KfWlg4Wy2ea5othZe870ScmeSTb3
	8hKlm0H+zU08/E/39u2y+qqneNVPw4eWhqCznBvsNzDuGj4sKPX1LNn//CKlEws114lwk6F9G7p
	B9TjSM/YYHJOp7Hm3d4bLK6uV8xgDHXSCKcDyXfAKVg552vq/4/ojJhHSaZuC1hlOHKk2L9Hq7w
	vRsuS7YgvFr1v7DFUtciZxxc6UB1WsHYjmcb/JlFdUEZ6m4XzCYx8c2rG6rOP4A9RxYKwjXCs4R
	TTghbc8sVZ9+gRStoY9lhArOlwdH0nn7CM
X-Received: by 2002:a05:600c:3144:b0:48f:e3e7:3d39 with SMTP id 5b1f17b1804b1-490ec4d523dmr173728895e9.11.1781512729897;
        Mon, 15 Jun 2026 01:38:49 -0700 (PDT)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea961f18sm253582705e9.2.2026.06.15.01.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:38:48 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:38:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	sfual@cse.ust.hk
Subject: Re: [PATCH rdma-next 4/6] RDMA/uverbs: Add ioctl method for CQ resize
Message-ID: <ai-6BtrZSqwN28Lf@FV6GYCPJ69>
References: <20260611151229.879514-1-jiri@resnulli.us>
 <20260611151229.879514-5-jiri@resnulli.us>
 <20260612130159.GJ1066031@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612130159.GJ1066031@ziepe.ca>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:leon@kernel.org,m:mrgolin@amazon.com,m:sfual@cse.ust.hk,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22223-lists,linux-rdma=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7655B684B1F

Fri, Jun 12, 2026 at 03:01:59PM +0200, jgg@ziepe.ca wrote:
>On Thu, Jun 11, 2026 at 05:12:27PM +0200, Jiri Pirko wrote:
>> +static int UVERBS_HANDLER(UVERBS_METHOD_CQ_RESIZE)(
>> +	struct uverbs_attr_bundle *attrs)
>> +{
>> +	struct ib_cq *cq =
>> +		uverbs_attr_get_obj(attrs, UVERBS_ATTR_RESIZE_CQ_HANDLE);
>> +	u32 cqe;
>> +	int ret;
>> +
>> +	if (IS_ERR(cq))
>> +		return PTR_ERR(cq);
>
>I think this is impossible?
>
>> +DECLARE_UVERBS_NAMED_METHOD(
>> +	UVERBS_METHOD_CQ_RESIZE,
>> +	UVERBS_ATTR_IDR(UVERBS_ATTR_RESIZE_CQ_HANDLE,
>> +			UVERBS_OBJECT_CQ,
>> +			UVERBS_ACCESS_READ,
>> +			UA_MANDATORY),
>
>Because of UA_MANDATORY?

Correct, I missed that. Will send v2.

>
>Jason


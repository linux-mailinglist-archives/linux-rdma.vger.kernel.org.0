Return-Path: <linux-rdma+bounces-16203-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNYpHKt1e2mMEgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16203-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 15:58:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF8B13AD
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 15:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79FA430087A7
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268EF257821;
	Thu, 29 Jan 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uNY+Z1H/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AD1531C1
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698703; cv=none; b=M3jSKzxZfQYlX7mB/NerUvwwBe03/tf5FRqQQ1n1rGAFrEBL6/1dOIINCQ2RnPIWcGbC30TdCSq7KjjAuZIv3ZY6trmaFlD2TO2459Jjd96MdcfAcnrU0IUZbXPh0ut1SLj8FdGoFQyXahVx1AgYWeiUaJywuEbNsGCfiq6KDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698703; c=relaxed/simple;
	bh=t4e/h0SMVgDn3joDz5MPufgF/ZUa3jt9ZbeUeFhAlJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izBV4oGd4GWqCUXhTBLV+dtkCNy8p9/RgyFdDKRjujsO1wz/sdqbWGb/Bw6D/fk0jk3YsWDN14oIJJjC2C5s0K42A906H04fJ5fjavzD25MUnwXvS2aZwzCMrP7q8KlfL4mOvSMtA1digyVAWP6cQ+ropky2L3IxmyusuddhhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uNY+Z1H/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806bf39419so13887925e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 06:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769698696; x=1770303496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYFiMuLbysXG7xtQRYLjJxY7umVxIv4xe62d5ESeBE8=;
        b=uNY+Z1H/8snTem6SBy8pXTo5hSf/6u/DEA22nrBNhKMIRjMVnxq+p6nLdIDBAR/Vc4
         KgSNgLCIbhm+F58v5eF+xqkcmUVLaUP8dj5FjH7OAlD3KStCdWCtULukSMHnAQWFHT7b
         M/itwwAGlrVxez12Acgq6yvtAhaHZvtrum69ksvVK5mSMOVMGSI24Qx3DrOokHxpIfmg
         yzjXreVHron9w9XvcyLylzQHxkXeD9zGAbrtdlq7RzhBw3RniJkCQbDrHknel4i0FqsE
         1XB9BywIprJIib7jmUX5IJ6kBZe+RVY16p1ytp1DSdQGoJKTLoeSKbESv6SenKZUGFvq
         3biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769698696; x=1770303496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYFiMuLbysXG7xtQRYLjJxY7umVxIv4xe62d5ESeBE8=;
        b=SPgnGUCfC0jkZ50q+AoCugTS7v/6APFi3VG8e+YqNLCZJg8//S63yGaAAAwIck3x/u
         andmHHnIvbHiexDJSZdAcqKbIpRB+97E0YicmV4fIrGKRvAa4vqkiYbdvS3lKRQPDA/d
         PTyPOfhQbMSLw7iloBN1G3rvIoplt+QhIwrq6reU3pxaN10F0Nc7a883vsYVP4i7kOOP
         kpue3LX/33Q7CosBg0T9ySV57jYthX6ISDBz6Y2dsBEfNBhmxoeio28hFX8TNZIVVCtg
         0bvh7HflydECU98CzlA0Wx3s0dKWdkJbl0W1JWLp+PxSB7uAVgk2aaeTZK7KIMIY52y8
         9MuQ==
X-Gm-Message-State: AOJu0YyubC9MDCHWMTcDUaGtpiP3VpR5XYuHtfawvDneTfS0ZPJnHG+Q
	Az50cS79RsRdPcZFty/JEyDN9emabeCWaPh13wylY/zpecwO0+dltRoOAqxfL2zODqBGszs+umb
	9tgYu
X-Gm-Gg: AZuq6aI+qOmRYV0k42vD+hhYgpAZjK1XTHq1ytG/2wYCZPs6ct9cFqXFQL+gM62Rq24
	iWI7p/aDEdSEQyWt1sMYKebRvzxNiqGCiJYJ8CB0MuvvEvSPCbb+My5f+DqVhG+xcu3j5R63TmE
	oJHF9D4B02gH3s7Ejr8QUn9oUDPmGAUVvRANu23o1Ao2nWBRpILmprs5A/FUCB54qpRB6TMgYjT
	4AilZpMnK847PGGWzli7qYLt7l0CM6GUfV6rRgePw6+C+CnJVYGQX4TnqXH0LzcMbq7Lmem3LAi
	hgSF2GsHI0wyc955IFSotrTbcfVisa3XEAWXwIzQZbcXe7EU5E+skvi2BmLbbD7UgmmHPuQirdF
	m/3t2gYgEl5wPM4lDI2avGrrVSaYuVdnYOhNO08hmtRm/miO8KDnrDpolVruNhXYs3R7opMmTtQ
	SUeEhgTztHfchu1NMCKQRVmsvHNyhe93VW4A==
X-Received: by 2002:a05:6000:26cf:b0:431:c06:bc82 with SMTP id ffacd0b85a97d-435ea067bb2mr5651095f8f.12.1769698696366;
        Thu, 29 Jan 2026 06:58:16 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee078sm15458777f8f.16.2026.01.29.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 06:58:15 -0800 (PST)
Date: Thu, 29 Jan 2026 15:58:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, msanalla@nvidia.com, 
	maorg@nvidia.com, parav@nvidia.com, mbloch@nvidia.com, markzhang@nvidia.com, 
	marco.crivellari@suse.com, roman.gushchin@linux.dev, "Yanjun.Zhu" <yanjun.zhu@linux.dev>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
Message-ID: <j5tnfwmkfqtmmtpkbcdxriu7wlgxydazuvkk4nkfv27nddlq4r@xx4amuxv6y7y>
References: <20260127160000.GG1641016@ziepe.ca>
 <05b40f3c-0d21-411a-b61a-156246482327@linux.dev>
 <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
 <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
 <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
 <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
 <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
 <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
 <inp2nyil62tkkvahvjvwvgp63ld5cffgowqhwlbssabhd2gaka@52lfxbmxvbzi>
 <8bdfe8a3-1cdb-43e3-b68e-428f6c5133d5@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bdfe8a3-1cdb-43e3-b68e-428f6c5133d5@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16203-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B6AF8B13AD
X-Rspamd-Action: no action

Thu, Jan 29, 2026 at 02:48:14PM +0100, penguin-kernel@I-love.SAKURA.ne.jp wrote:
>On 2026/01/29 21:38, Jiri Pirko wrote:
>> Since the notifiers I'm trying to fix don't use
>> ib_device_try_get/ib_device_put, I don't see how your proposal is
>> related to my fix. Feel free to send it as a separate patch if you like.
>
>I wanted to know an example of the notifiers you are trying to fix, for
>that might help understanding how "the ib device REGISTERED and netdev event racing"
>results in "unregister_netdevice: waiting for bond1 to become free. Usage count = 2" problem
>at https://lkml.kernel.org/r/SJ0PR12MB6806E77B849859B7BAC8CC1CDC89A@SJ0PR12MB6806.namprd12.prod.outlook.com .

I suggest you read the patch description again.
for example this funtion netdevice_event_work_handler()
which eventually gets to call ib_enum_all_roce_netdevs().
Basically roce_gid_mgmt.c event handlers for netdev/ipv4/ipv5 events.


>
>
>
>> If I'm not mistaken, you didn't pointed out any real issue with my patch,
>> only some guesses.
>
>Right.
>
>>                    So do you see any real issue?
>
>Not yet. I'm not yet familiar with rdma code.

Hmm.


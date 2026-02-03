Return-Path: <linux-rdma+bounces-16434-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHzxN766gWm7JAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16434-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:07:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 819ADD6911
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 10:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF1343022042
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBE5395D8C;
	Tue,  3 Feb 2026 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dw4OAkal"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DC830C614
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109626; cv=none; b=gskCJOojPQxqOh+fSLCvAhRlLE7WiisxCqL3hXVlaMgfFFv1HbKpk6Oq3pRqf07YDLv6QDcHAP/1cQLag+Bg6/BNtelEclCAmCMXnqG3f68XvAlQvP8R26U6MGivwDAnEEf4vJ7qTIRBuVn2YHitbmmQt86F42UOuMD2BYBgv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109626; c=relaxed/simple;
	bh=zcSdNJ63nbqNzFrhelD/1U1CexVoED2yAqrvFd1PnY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1zlOSPuV2qh2bDgZzs2e0pPW3BYC3dU71whfC7ynRmT5c64sCXnsryMos5+BGo88xKP+7zvQNoByhF/DKDddnLVWXs6dTtumpVOvutH/Wi8vhFQllyv5kUE/MLXv/tTHDf+0U/Xq4FWEKkb4f3BPNC7Dick65HbJX15sSepbbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dw4OAkal; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso4187555e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 01:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770109624; x=1770714424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dfKACiWgz9NttY5DwBqL3/0hrGwxZ3rJ0I9+LsVVX+s=;
        b=dw4OAkalyQq+ZbkO4+DvqsnOMmfljiNweGBszrlk4iCELwc3/2hM8DvaxfDsLmgVFP
         oDPHgNsumnKL9CVZ+SLvoETk8PlU5UxRPOOJ9iH35J0850EyZG6KTaadyLRfnGwodpP+
         L8ZGDLuMVv5UoGaUHDZ0SYhxNQTEm6ktwU3OYELWuTcd8uZEGN8bsPasTE4DbkjmC5UV
         SX3osrnZyGDK9iqfuEH6OdeW0e2ctt8DiKz50CvoIfpXogNMkpwj5BMXo7+01GgYodpz
         kPJZ0fgmL0f3XQyA6jdsHJEiPp5YtSftkKg6HrXG9BvpdQoDwjOPfyrdDYCEjN+jGko9
         tM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770109624; x=1770714424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfKACiWgz9NttY5DwBqL3/0hrGwxZ3rJ0I9+LsVVX+s=;
        b=Ajv12E4DJj7Fre2V7tUydAnTV0VOwJw5VfahdwoQcpf6n3mOqbAIJxffJA/Rl40ir4
         bk5dwwOF68nCSaT6V542o0kabhm5b9PXaEscWdKre96UrJsF+CaX5IoJZR3LXGnNubhk
         zjwU6hdAMavOvU+SNcE2bo1rC9TNQDRXOYKURyMT0I4aGxC4uAX55ICnkVTvEO030p+M
         gKeeSQYyZUbSxxRqbO1iJI4MeUafztzsTGDoItun9/iQXD1w8dv03GhV5zg/CL8fkTlU
         HyHZyec6nLnecRt49NAlilQR7NN6GDlHzg1343zdJ3KJprWr0Ji2Ppc1WV8GA2SfyKx3
         OEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIiC1cuPKzMMIjAgt9NnjdZyL6pV83KRRoCOcJsC9+HJjgbj4usbrYhZULxr3qzqwwH7zu0MAVVQW0@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvvEQWebDkrPpJoGaDoDhsugyusQmNTcEZtv3TMIMhK6HuGtP
	gtBY5L8CY4PtGrE67KLM5UOWl+mBFGrnmmNHKgHM8Ovekt3ePXsYp4JV/IXMtuK80q4=
X-Gm-Gg: AZuq6aLhdsxG2s+jcoPAiA6MqPk9Dfvipgm8/1fZvkNzzO7PzffRO5Y/fCz9NCNdGCw
	a2OpbpU/m0Tu1L01KT1GKSrbcLyDuKfP69Bx7+b3lqyPjJtuFaM9afDekqnA0IMFDZDohclIxU8
	9UXPI0GDYFHMdjQY8VRSC6ZQmR67fmz0X4ddWxiMGsPvSmJpQZUmBv1HCffUrvh3YaBeUyhmHME
	5lfKb4yUKTXDclEOg5VINIUcF+LovnuMG2SDVZOA3kHc7hT9SbETEMVBGCDu9qoFyzsafhbJsgv
	gdYkmz0aGl+S/6irUn+1z7DJYCTCDWKpiBe7ISRYfnX8NJZsmwYTCgwsmfzBopagGDU8wN4opnI
	dSvCcqOjswj6CCmvh/Bc/tOowSR3QzNP7YwsA7V9bSC5l+eJQpkvzU/TyPvK97dGbr4CkW7MAgA
	jjRg1sA23wVfOvB3PPPxQ=
X-Received: by 2002:a05:6000:2c0e:b0:436:1597:7c7c with SMTP id ffacd0b85a97d-436159780camr879230f8f.13.1770109623796;
        Tue, 03 Feb 2026 01:07:03 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e48a6sm48787403f8f.8.2026.02.03.01.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 01:07:03 -0800 (PST)
Date: Tue, 3 Feb 2026 10:07:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-rdma@vger.kernel.org, leon@kernel.org, msanalla@nvidia.com, maorg@nvidia.com, 
	parav@nvidia.com, mbloch@nvidia.com, markzhang@nvidia.com, 
	marco.crivellari@suse.com, roman.gushchin@linux.dev, "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
Message-ID: <cvvqenei3atlzl4xhlitn7mibegs7fpz7clwb7odjzkfhbrbyx@rk4jcrndqas2>
References: <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
 <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
 <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
 <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
 <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
 <inp2nyil62tkkvahvjvwvgp63ld5cffgowqhwlbssabhd2gaka@52lfxbmxvbzi>
 <8bdfe8a3-1cdb-43e3-b68e-428f6c5133d5@I-love.SAKURA.ne.jp>
 <j5tnfwmkfqtmmtpkbcdxriu7wlgxydazuvkk4nkfv27nddlq4r@xx4amuxv6y7y>
 <d6aee73d-91cb-4eb3-ad11-6244e973932b@I-love.SAKURA.ne.jp>
 <20260202235133.GP2328995@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202235133.GP2328995@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16434-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 819ADD6911
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 12:51:33AM +0100, jgg@ziepe.ca wrote:
>On Mon, Feb 02, 2026 at 11:20:22PM +0900, Tetsuo Handa wrote:
>
>> > - Event handlers correctly update stale GIDs even when racing with rescan
>> 
>> I couldn't confirm that this is always true. What happens if rdma_roce_rescan_device()
>> is preempted between make_default_gid() and __ib_cache_gid_add(), and NETDEV_CHANGEADDR
>> event runs meanwhile? It sounds to me that stale gid is possible because gid value is
>> calculated before holding the GID table mutex...
>> 
>> rdma_roce_rescan_device() {
>>   ib_enum_roce_netdev() {
>>     enum_all_gids_of_dev_cb() {
>>       add_default_gids() {
>>         ib_cache_gid_set_default_gid() {
>>           make_default_gid(ndev, &gid); // GIDs populated with OLD MAC
>>                                                                 ip link set eth4 addr NEW_MAC
>>                                                                 NETDEV_CHANGEADDR queued
>
>I thought this was impossible because enum_all_gids_of_dev_cb() holds
>the rtnl_lock()?

Yep.

>
>Jason


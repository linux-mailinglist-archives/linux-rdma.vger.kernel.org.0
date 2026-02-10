Return-Path: <linux-rdma+bounces-16697-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAGuMFLzimnUOwAAu9opvQ
	(envelope-from <linux-rdma+bounces-16697-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 09:58:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC211874A
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 09:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4757C304C05E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43F633DEE3;
	Tue, 10 Feb 2026 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ixTNnJtd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52F2EAB6B
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770713933; cv=none; b=N+/j6+MlKzUL5KHH4pCuFfO3CDOk+szzQtW9OJ+WnMQo102kVlAvHSN2IkbsXhd+gE9BILgeP0ZRlZWZkpS4MxU7NB5oJiT5Dyl3Fue/av6KD/pyA1ppJXufvtVUoP5bYFNuXQc9pdl9TTAjDqx9TBBcUHQGR0H3WUSebcRVLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770713933; c=relaxed/simple;
	bh=BMmzxXnzdjFjKyE7uxMIlNcf0YGRo6KMvHSZ6yW7rZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJgVPO7IUZen5yUrZOudnn7Ftgi0apVCostFaB1DxSHsaVIoC4Nx3tPGxX/T8fW+euj0NFTwi3UJz3zb3mFuuZWtL9AF4N/PsUt9WxymjKQSMumpnOiPXOtdDWvk8mBWWDfwsTkuQMU0e6zCDTrBNL0fsBS3q0t2OFghEM7iN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ixTNnJtd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso53001905e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 00:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770713928; x=1771318728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWYY3U31z6BGgnidbmycvVSXqO0AO2D3jQUXuMVwZMc=;
        b=ixTNnJtdtFhY7KA2BQC59BUSu3Re1BSYV8TyDIBmkPGuUVHpnqeD0wJwMNemjmvF2i
         9PN7OUfPJ4JYRKbgvpgnbyl724bIn6EKt7Aqb/bq/8fqO53FKWYL5SWgbpdB0wGtfl9M
         bTGXZ1ffNk4jDK3RoBYKqnRCBHaEj/GW9ARAatFB9kNlokYheR/MpAVxgTXVbn6i9mpF
         +2tcK7U1asrJLgq2qPEsHUpenBDOjXmgMo1fAa5V5D/NbVUqAPxrwKZGDaN8319xPrHf
         f+OcqSeQXSuJTiCH0GZvaI6A8GTBHeL9iKU8unHyExiPewl0Od69886ueJSgBhwgKPij
         Yrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770713928; x=1771318728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWYY3U31z6BGgnidbmycvVSXqO0AO2D3jQUXuMVwZMc=;
        b=udF90dB0hHIS8D00cUgJyENDbgfYvxe0V4PIxEftK/Zdh1YiOeroak6GSQgdG7Nym9
         RbWr8HFyWGuCxJ52/S6qySfjx5UT4DRoJVruGGciJ02T8bY9ySbqkpivWdbqI3xEk2FT
         x32buivHG3CmVbjehsw1YAPFjAhyWgS87dijJrr8u9PDLSmhSc7ThPr05Ay5CZSJHIDM
         v7gjt/B0so46EyyhNN2c/VSOco/FnKn0aB7tFrFykU+nG7kBrztPjC/vzpm3yBqTo/I/
         I8IDOlG/D6bZkAN7fP3ftYJnvCMJwvnewCzgBoFBLjxWa0X6jusP7iHWAuLfl1Z+GvE5
         prIg==
X-Forwarded-Encrypted: i=1; AJvYcCU+dEjrgIu/CkN4v9SE/drn1aMnyGHnxSdW0lk7NnHM5UhMTtUntK1Ky89YRBP8qhZ3DMuhv4tIe47u@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8jJL1NOs8VdI7jIaTXi4IHGOpSaUIjv4dqTysh0vqMIkROpwO
	Xe+nveDY3pvCA4CByn2QB+Z05H1nRazYex6VvVa8l5ct94LywoSCtt+2FFiF5UG1xNs=
X-Gm-Gg: AZuq6aImri12fBOtqlnM59hHdjlsJeYFbQy0jXIT57NC8cwRbnPYw/vy5DbesndzHuM
	mYq4lXLUGakHi6mq8DetQifKL04Ygk8RGrDkUv15thhmjPwk5qptf/oUIPf/e7GNbBnikgeNrpM
	ppyblYPS6Syj9F/tDy5yxe6FknNjsqdyiCVbkaXOYzutV50TQzDCXQYM7dM5e1PQzYcUg00BxuH
	gI1QUIpSkPUCXR0wCS43f+rBKYkBVKIQLxFI1OB9c7S52g9En20f5YHirG22IqclWULzsqTTJyL
	5CFjK91+S+65skfswoArIum+ikN+qVEo/9nw7/UwRMomlAW05e1h777OnBB2IamDYXPaa4mku8t
	xg9dHe7wQ1UTclP0wzhQ2qErpdFrvLTcrMGKn/mEBNzECTWHX9tl6NiO7vPQcztfMi7+RhRHn4X
	/JjkEL8n8To+oh7O2RwF1Sm9JnCVnZ4Jh7ZHw=
X-Received: by 2002:a05:600c:3b1e:b0:483:3380:ca0c with SMTP id 5b1f17b1804b1-4835083456cmr18915405e9.35.1770713927638;
        Tue, 10 Feb 2026 00:58:47 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm96652575e9.11.2026.02.10.00.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 00:58:47 -0800 (PST)
Date: Tue, 10 Feb 2026 09:58:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
	leon@kernel.org, msanalla@nvidia.com, maorg@nvidia.com, parav@nvidia.com, 
	mbloch@nvidia.com, markzhang@nvidia.com, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
Message-ID: <eqplwtvsocnqesb7vysnb6cq2emmghbg5wttkc6oyltsqtw6zi@6iewgx2qnsml>
References: <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
 <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
 <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
 <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
 <inp2nyil62tkkvahvjvwvgp63ld5cffgowqhwlbssabhd2gaka@52lfxbmxvbzi>
 <8bdfe8a3-1cdb-43e3-b68e-428f6c5133d5@I-love.SAKURA.ne.jp>
 <j5tnfwmkfqtmmtpkbcdxriu7wlgxydazuvkk4nkfv27nddlq4r@xx4amuxv6y7y>
 <d6aee73d-91cb-4eb3-ad11-6244e973932b@I-love.SAKURA.ne.jp>
 <20260202235133.GP2328995@ziepe.ca>
 <c5ebe396-eccf-450b-8486-e1900258d9c0@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5ebe396-eccf-450b-8486-e1900258d9c0@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16697-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,i-love.sakura.ne.jp:email]
X-Rspamd-Queue-Id: 0CEC211874A
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 04:52:10AM +0100, penguin-kernel@I-love.SAKURA.ne.jp wrote:
>On 2026/02/03 8:51, Jason Gunthorpe wrote:
>> On Mon, Feb 02, 2026 at 11:20:22PM +0900, Tetsuo Handa wrote:
>> 
>>>> - Event handlers correctly update stale GIDs even when racing with rescan
>>>
>>> I couldn't confirm that this is always true. What happens if rdma_roce_rescan_device()
>>> is preempted between make_default_gid() and __ib_cache_gid_add(), and NETDEV_CHANGEADDR
>>> event runs meanwhile? It sounds to me that stale gid is possible because gid value is
>>> calculated before holding the GID table mutex...
>>>
>>> rdma_roce_rescan_device() {
>>>   ib_enum_roce_netdev() {
>>>     enum_all_gids_of_dev_cb() {
>>>       add_default_gids() {
>>>         ib_cache_gid_set_default_gid() {
>>>           make_default_gid(ndev, &gid); // GIDs populated with OLD MAC
>>>                                                                 ip link set eth4 addr NEW_MAC
>>>                                                                 NETDEV_CHANGEADDR queued
>> 
>> I thought this was impossible because enum_all_gids_of_dev_cb() holds
>> the rtnl_lock()?
>
>Indeed, so it is not the GID table mutex but the RTNL mutex that serializes
>concurrent access between the initial rescan and event handlers.
>
>Jiri, can you append the race with unregister case to the patch description?

I don't understand what exactly you want and why.


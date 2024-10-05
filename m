Return-Path: <linux-rdma+bounces-5250-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24212991AE6
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2024 23:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F090B21A08
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Oct 2024 21:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04981662E5;
	Sat,  5 Oct 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="HojL8L1q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7A61607AC;
	Sat,  5 Oct 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728164373; cv=none; b=CS8TrwPSm8+1ugysEyFvbdppYg0plKp5AyoUkgf6eDBTn0LjSc+oSbxXfBSoaAcwsNc6deyePeXT7dFydQXdn7oiXOW6lAb2zd00zoquMyTWfePZCVJLIHeDul9Wg6cFd+cgSvZIaB6ZhXQw628a6be7p058sN+LtACnmEH2Y5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728164373; c=relaxed/simple;
	bh=fiZaPzv5rhU9emA2lA+1obyLFhyp4r6ZVvhoPHJZWqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2M8ckfo0JD5Yf8qSMUFEpmLXquns/w1MoIty2yFPmC1xK7CcC3DiV6EwZpvaiKpocOdkW1m4oMS4v5dduaCT2Ht5iLPdbqMPMktM0an6d9UXgcqvOvKq0d1rCSAqUYjcJG6XaGpw8ATsARwsfEp8WRji1KzQ7cnXwRJBTNytlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=HojL8L1q; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XLdym6QG9zlgT1M;
	Sat,  5 Oct 2024 21:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728164190; x=1730756191; bh=mmSl7eqWiha0nfA3hTlH5zkd
	KkX4dm03HscfrHTMGhI=; b=HojL8L1qLnNowfZUVh7eJ8b0Fgy9LFPPki3RMiiq
	5PeiLvy74j0A6qnTPUvVxeTjBNt6xSIP9ezBNwGrp3uoMgQHIQVwPmkctw0RCkOa
	AAHIOoR+l9Daj2VOm+b7tSWzHJFpZQzbQpI5Lu1SHUDqYNAOj4xqFBuf2Z2yBiwQ
	wOWH92oz9UDJEhI7K7RnuSvA+Vx5j2hUNGdi0XyAOOP8O4lmfKsrmPADwV8XcKJL
	gOnIYZgNrYS/M7BjbZXobIcNmf8gV9TTFDwYy3UzEoXFyNgeRYfjh2ZV2vprNlb5
	MJ0n3nHuV6dUsoYQ299TDpgLD5AjiVNknOgJoLRSjIVLJQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8jru5-91P3G7; Sat,  5 Oct 2024 21:36:30 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XLdyh70ZyzlgTWQ;
	Sat,  5 Oct 2024 21:36:28 +0000 (UTC)
Message-ID: <d5fe08b6-68df-4d67-8870-dd7ae391973e@acm.org>
Date: Sat, 5 Oct 2024 14:36:22 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Jens Axboe <axboe@kernel.dk>, Zhu Yanjun <yanjun.zhu@linux.dev>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <xpe6bea7rakpyoyfvspvin2dsozjmjtjktpph7rep3h25tv7fb@ooz4cu5z6bq6>
 <e6e6f77b-f5c6-4b1e-8ab2-b492755857f0@acm.org>
 <dvpmtffxeydtpid3gigfmmc2jtp2dws6tx4bc27hqo4dp2adhv@x4oqoa2qzl2l>
 <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
 <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
 <b60fa0ab-591b-41e8-9fca-399b6a25b6d9@linux.dev>
 <c5c3c7d7-2db9-44fe-a316-b0b5bab30f1e@kernel.dk>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <c5c3c7d7-2db9-44fe-a316-b0b5bab30f1e@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 6:41 PM, Jens Axboe wrote:
> That seems over-engineered. Seems to me that either these things should
> share a slab cache (why do they need one each, if they are the same
> sized object?!).

The size of two of the three slab caches is variable.

> And if they really do need one, surely something ala:
> 
> static atomic_long_t slab_index;
> 
> sprintf(slab_name, "foo-%ld", atomic_inc_return(&slab_index));
> 
> would be all you need.

A 32-bit counter wraps around after about 4 billion iterations, isn't
it?

Thanks,

Bart.




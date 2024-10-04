Return-Path: <linux-rdma+bounces-5219-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF5990938
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 18:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A332281DA6
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739DE1C8785;
	Fri,  4 Oct 2024 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NtWN6QkJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB9915B0FF;
	Fri,  4 Oct 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059520; cv=none; b=KCi+punMxNfQU7XwwBVOO1sVMeDLas1FFv+DMy4YjLm0A7NDQElGoBpmBFDavt2f/LYF5KK0vPuI4Skn1bsg2nv52zb0Y2BK9YQN5VMihfCYQrZjzlJ4RNflQ9Z9NdUvM9YPJsTQlU38BZ6zAfAbClpPxKmIXXyhvhobaq0RHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059520; c=relaxed/simple;
	bh=MPO+QWb96zfwbe7Z0K2PYar0mm56xo0AOUVkkpAhKrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klrWarEhljnXojuzuidyp3HGA4TFc6i/lqLtNgPnI+5rhnoikA0PGPlCnSVvJ757SC/gz39ga/IbNy7tzs+o77e3nFYy24pSk6N+eEQ0kZ0+HCSkszEsr0h6F50W3yYbPCHeWpC1wrFZahOJlzihKaWFAYrGo5sg0hHbXAL/SaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NtWN6QkJ; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XKvFp1xZYzlgMWK;
	Fri,  4 Oct 2024 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728059516; x=1730651517; bh=iz9E1I6B8CwQ/5Yzuw1pMYrb
	YElB81ywXT4KH+Y7XQU=; b=NtWN6QkJCsV2r4R8WncnrhauO+tSXdue3HbT2Lo2
	TDpVfmzofJmXb9frOoHfN+ksEB08Hw7t9ov20HCFj77TGHC/WrvQiMT5ofkCBPFm
	ETFqqTOAxjX+TS7q90mgXQ4etgqN9xs4Zp7FlkFb5UTAICXKVf91/35Muy4k6DTJ
	FZamWuaAGIDQBg8yOhwyplxc4qKNrDfRiHDiftADZxKMv97jfFnbchvHkqJEJwqO
	Cc//A0BUNEh+TX49PYYfqGpF+bRDDphYS00yKaXAwnGQWedQbw2KCFe/bJHJKPWa
	q/NHjCO7RiFTEMS8DzOSwa6iatxDF3Nrntu/91oG4hHVTA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MFDn1liQ5WJj; Fri,  4 Oct 2024 16:31:56 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XKvFl5T3hzlgVnF;
	Fri,  4 Oct 2024 16:31:55 +0000 (UTC)
Message-ID: <9fe72efb-46b8-4a72-b29c-c60a8c64f88c@acm.org>
Date: Fri, 4 Oct 2024 09:31:54 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.12-rc1 kernel
To: Zhu Yanjun <yanjun.zhu@linux.dev>,
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <5cff6598-21f3-4e85-9a06-f3a28380585b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 5:40 AM, Zhu Yanjun wrote:
> So I add a jiffies (u64) value into the name.

I don't think that embedding the value of the jiffies counter in the 
kmem cache names is sufficient to make cache names unique. That sounds 
like a fragile approach to me.

Bart.


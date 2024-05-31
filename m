Return-Path: <linux-rdma+bounces-2739-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3018D6A82
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 22:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4781C21745
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 20:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1B17F4FF;
	Fri, 31 May 2024 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3IRa5vKi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A39F17D37D;
	Fri, 31 May 2024 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717186138; cv=none; b=noSTDAreVuW9gf44Xo0BbjUVfLQV2ney6mPA9v8mPxJ1AzDRCvJbEioQw7K89hg0k7ElMJNQXYf7EDbqjrUghvNfmhnejknJJEq76Kcsoe3XdD0w8h2gSbV5R6FAlQ/uT4vyuQac3jA93jxUoGr0PZA1XJtUqpK0TR/H4QFLnlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717186138; c=relaxed/simple;
	bh=qJ3xjAYeIM5dfikpUZr//uQG9kmt6nHbhiUKNJJlmYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gscLsCfpCihtFlQynRXL8ESiZ05IrrrU/vYEWBnr9C0DzZd8oaZUIk9j2tJFZx557ud2MSvIPtB/Zb8KpX2FkbzX0nANsl4N7lZra2d4lynQEjfQICrvzKwV5p+vGC9HAELhU+7/32IZjxKVLCoqzb0sTr/lwxQr7E41d0TrhRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3IRa5vKi; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VrZ2J2D3lz6CmR43;
	Fri, 31 May 2024 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717186133; x=1719778134; bh=qJ3xjAYeIM5dfikpUZr//uQG
	9kmt6nHbhiUKNJJlmYs=; b=3IRa5vKiVTmcMmP2dIBQ+jae48HT3Ok31/z98R+a
	LHchjQhDyXzYbjUiwRpFHJzxnyQBMM9gvR/0SUxyxpzcUJkkc9repE8a3NjphYpO
	txMI6Fu6kJhgvXugIai+67m2Zpth3Ll42mTVo0fu1GEx0bAtdeQt3ytJZf5So+g+
	MAWAelgAZZ+K32B6020UtQEOgJ/X+wTPx+hRfim7GJSVNT2ZH9oXzcC3b+jl/SZx
	gGrPYSY7jedbvrN1H9nmTVL88nK25fDPaN9dQKyOmFgi1Joekk0MC+cKfHPjebv5
	PVt/IdxV1PEFSaOtSf5usvUUduo2uPGGLoNKHFVKsUTKjw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xwebMED3Mh0l; Fri, 31 May 2024 20:08:53 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VrZ2F0RsNz6CmSMs;
	Fri, 31 May 2024 20:08:52 +0000 (UTC)
Message-ID: <0a82785a-a417-4f53-8f3a-2a9ad3ab3bf7@acm.org>
Date: Fri, 31 May 2024 13:08:52 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.10-rc1 kernel
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nbd@other.debian.org" <nbd@other.debian.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
 <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev>
 <b29f3a7a-3d58-44e1-b4ab-dbb4420c04a9@acm.org>
 <CAD=hENdBGcBSzcaniH+En6gecpay7S-fm1foEg5vmuXiVYxhpQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAD=hENdBGcBSzcaniH+En6gecpay7S-fm1foEg5vmuXiVYxhpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/31/24 13:06, Zhu Yanjun wrote:
> On Fri, May 31, 2024 at 10:01=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
>>
>> On 5/31/24 07:35, Zhu Yanjun wrote:
>>> IIRC, the problem with srp/002, 011 also occurs with siw driver, do y=
ou make
>>> tests with siw driver to verify whether the problem with srp/002, 011=
 is also > fixed or not?
>>
>> I have not yet seen any failures of any of the SRP tests when using th=
e siw driver.
>> What am I missing?
 >
 > (left out a bunch of forwarded emails)

Forwarding emails is not useful, especially if these emails do not answer=
 the question
that I asked.

Thanks,

Bart.


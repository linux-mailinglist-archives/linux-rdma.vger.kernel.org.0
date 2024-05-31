Return-Path: <linux-rdma+bounces-2741-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E1E8D6B07
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 22:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF71F25F6B
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860E0208DA;
	Fri, 31 May 2024 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aIjFOs59"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BED26A;
	Fri, 31 May 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717188382; cv=none; b=iH2ym9itkJbPcx4O66cGqCraj3V31FMMu3gfzW2NNFHtnq3L9eMCIBB2XtVpfg7CbLRNYcnKYIuDYY4pHjuVLB4QrJ5BKjryprBlYNfYnj6+RCxIWL0dPNwTSxQoVPWgehxVxCGfW1AI2rMBVxFvxAicaUNQndBgTozjRP2edew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717188382; c=relaxed/simple;
	bh=pjr/u4iW51zkvFJ1IfKSN6KTApRPaGINQ43FO4J9CGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dr0kIms9x6jO9PjnVYmasgHMqZ97PSxcYkTv6SDIbvg1yYyFIKXVhcxZ8tTh7RbeP8gU8i9hhueFzRyUH/IU3P8K7h7g8UE8fvc7L9RkXbhFhn46bRXwGFjjg/yLFw/yE48gd9DZlJvqS/w/+UZm2YXm5zSIonWaV8AtmHCf+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aIjFOs59; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VrZsS1DQGzlgMVh;
	Fri, 31 May 2024 20:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717188377; x=1719780378; bh=S1p76AS0cf6kXj0arrO4uHwv
	tCrK3sOZAIQUxCLQYjw=; b=aIjFOs59T8LcAZQap6j+YsIwrvOvf60UO4e7TfiN
	pFEQB2abUGrZfcrYKKrkKrB2647WdjDFKB6QJPBEGUU1FyrrFvMdVnauviSoI0hA
	8Ka1eYWrrnBndgRXrYQjQUBJFhciyTRMhERfTmZPCsXskrnwnZCGQwt1XnP7/BtZ
	07W9IhNa8k41tcYhKdlOBfPLYBvEupFBPNKEFRz046N7z2cgZzPv6Uww0mHjz2hf
	XOHvIDbeIENN+oDsEjNrWgbW4T3ZdS+EbpXu6pZaAsIbozHinVgWm+RrA5r3sWC4
	jWpcpgKCAvcAjIM1NOQJZdB/ncuDWQDEbA7hhY+viPi9zQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3oVgloOHcuuQ; Fri, 31 May 2024 20:46:17 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VrZsP1vz8zlgMVf;
	Fri, 31 May 2024 20:46:17 +0000 (UTC)
Message-ID: <81a63f38-fab0-4536-bbc2-3f06752a7f9e@acm.org>
Date: Fri, 31 May 2024 13:46:16 -0700
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
 <0a82785a-a417-4f53-8f3a-2a9ad3ab3bf7@acm.org>
 <CAD=hENdgS40CmZs2o5M_O71k07Q7txg9-2XnaHP97_+eC9xT3w@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAD=hENdgS40CmZs2o5M_O71k07Q7txg9-2XnaHP97_+eC9xT3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/31/24 13:35, Zhu Yanjun wrote:
> On Fri, May 31, 2024 at 10:08=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
>>
>> On 5/31/24 13:06, Zhu Yanjun wrote:
>>> On Fri, May 31, 2024 at 10:01=E2=80=AFPM Bart Van Assche <bvanassche@=
acm.org> wrote:
>>>>
>>>> On 5/31/24 07:35, Zhu Yanjun wrote:
>>>>> IIRC, the problem with srp/002, 011 also occurs with siw driver, do=
 you make
>>>>> tests with siw driver to verify whether the problem with srp/002, 0=
11 is also > fixed or not?
>>>>
>>>> I have not yet seen any failures of any of the SRP tests when using =
the siw driver.
>>>> What am I missing?
>>   >
>>   > (left out a bunch of forwarded emails)
>>
>> Forwarding emails is not useful, especially if these emails do not ans=
wer the question
>> that I asked.
>=20
> Bob had made tests with siw. From his mail, it seems that the similar
> problem also occurs with SIW.

I'm not aware of anyone other than Bob having reported failures of the SR=
P tests
in combination with the siw driver.

Thanks,

Bart.



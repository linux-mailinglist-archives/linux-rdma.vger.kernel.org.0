Return-Path: <linux-rdma+bounces-5272-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E51129932DF
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 18:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813CC1C239D6
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 16:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E4B1DA622;
	Mon,  7 Oct 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WovIFSHt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9CA1D9346;
	Mon,  7 Oct 2024 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728317511; cv=none; b=A69reJWG8DBHLK+yRNXLahq1yx7bQ4MDmDFU8J8mK/3QqgfAQjktyN+L0EyEc1Xj8scsxiRTRo9b3h++75rHEhVOROgzwY2RMluZB2jCrdvF1JF1AAaKMaNYt1oFzHwzu776ERPPeFubo64C5P/h5mFtppOpP3REDlt1OS3MS3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728317511; c=relaxed/simple;
	bh=tSiVyaLxQ9UMpiYiC2keoYhHiL2ghoVibDkJFLdm34A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ay+ExPxi2dXAXGl5PTVeDDeeFUfLL0k9xqXuORMhai7we4t4YJUnpHJHPEgiDcw9ynSaF3NUn2TQ/qj3fqXooVWqHI+qeOLQy+gTZqxGtb58/UjkRzizSS7ti4hVfwbfGbbfUaVbVUWin/fz0BGRIkV1Plt6+bfoOnb/uhQemuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WovIFSHt; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XMkg343qWz6ClY9X;
	Mon,  7 Oct 2024 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728317501; x=1730909502; bh=tSiVyaLxQ9UMpiYiC2keoYhH
	iL2ghoVibDkJFLdm34A=; b=WovIFSHt5px8fCIaEZNEEHTbPfBeywFucNYGwYqo
	UYnSEjjBomy2+v+7GexiLSnte0hZZFTVc5ZbiVNygJYY+SiYfN6IO3WWN1LSlmym
	477FGhJy+hCFLPb0LAVviHnCM2gFMLpLVxQx6t/9uvogXv93p3PuMHs8cGI/WRr5
	IZhFbae7t0P3bdwAnAhxtaKGJVeW4EH5D+yfoTnYeQiHdFpqFI3HZSp0mgO0FSpn
	eRM39fSqVJorCupmoEr1yL4Ur5mPUXab4J0KCt2NqgRd96XZ8PaufT2bvWJVSWli
	fsxWvxmBwYyUvIUGLwgCagYcP1psX/t6IQpN5XiS7nKErg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mcWCQCMYXhaD; Mon,  7 Oct 2024 16:11:41 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XMkg11HShz6ClY9L;
	Mon,  7 Oct 2024 16:11:40 +0000 (UTC)
Message-ID: <874b5624-2ada-4ffb-adea-64b1b377b18d@acm.org>
Date: Mon, 7 Oct 2024 09:11:39 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/srpt: Make slab cache names unique
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20241004173730.1932859-1-bvanassche@acm.org>
 <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3108a1da-3eb3-4b9d-8063-eab25c7c2f29@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10/7/24 2:51 AM, Zhu Yanjun wrote:
>> +=C2=A0=C2=A0=C2=A0 char cache_name[32];
>=20
> The local variable cache_name is not zeroed.

I think that there are millions of local variables in the Linux kernel
that are not zero-initialized.

Bart.


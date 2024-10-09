Return-Path: <linux-rdma+bounces-5341-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DDC99771F
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 23:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F10284714
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 21:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6427018FC86;
	Wed,  9 Oct 2024 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hj0gQCpW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301A15FA74
	for <linux-rdma@vger.kernel.org>; Wed,  9 Oct 2024 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507639; cv=none; b=edrRLD6UAb6LIWcvxKMGLeaODxu61S3+HbE5T8BPSkTZyv6mzwi+PFjDlXyKyU8MMf4bVCNNfI67A2bhkuityWmSM6G1lMw66ix9wI1oC0SYwby0nGKzCILKyEbOaEDeb6eupvMgjj3D5Y+OW6jkCQvwo3KeghX7A2CYdKoXWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507639; c=relaxed/simple;
	bh=cYULsZzJEgKfVNWWJtUb905BLwrD+ZZHpt2xKNKSSAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ne6ukHj+hJzTuXW+VuQARuMhROa8XWeNTqLmtac5oQVLfuokfSfgTz64BfdOwN5FAgQ5DswlRDKI2VW4/0IKFgN+jgiHbN2WWX1/KdWgvJvww6yQaxAYMyCIwCek8kQrQHTpVPFb+1LgIoscbp2GC7z2OJ+MmADFqNQObeQJiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hj0gQCpW; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XP4zS6xgCz6ClPR9;
	Wed,  9 Oct 2024 21:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728507634; x=1731099635; bh=+hp3W8aRd/I8d3hLDvtehRrA
	ZHqP3GvSJXvtMLRHI40=; b=hj0gQCpW/vwraBRZnBjlnIg4vOWIZNrFHMdlua2/
	ddFgr7XgfJ3qFKJbcGk+W3MYOKPZYfZUmQQECQIsvFmEqCufg/PdW7hIzhaJZxMs
	awU3soS7aYgmmJg6rUHygf73REJcGzYsCaljrd3GyiaBHFIiPGjC9w9n0b7bapZM
	VyH80zaKexZYXCledS6ZoyDMEzPpwLuO77bRwDHz7M3Uk3WzNg7CxPYu68JrbNR3
	hMPweANUsQse8+RvpjClpDuU+00+yrZBhRYdOIz33c7hdkdc1HpnlrAG3XiNJM9c
	MXnozOy4DTccxbdX9K4zN8nel/4hVDEBx+Zt/VZXQulDUA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sDEYXBS2FvCE; Wed,  9 Oct 2024 21:00:34 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XP4zP5LfSz6ClL8t;
	Wed,  9 Oct 2024 21:00:33 +0000 (UTC)
Message-ID: <1bcb64ac-228c-495d-8c83-432ddc10bebf@acm.org>
Date: Wed, 9 Oct 2024 14:00:31 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] RDMA/srpt: Make slab cache names unique
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20241007203726.3076222-1-bvanassche@acm.org>
 <a5036e8c-4981-4910-a805-34fcc0521def@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a5036e8c-4981-4910-a805-34fcc0521def@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 10/8/24 5:48 AM, Zhu Yanjun wrote:
> =E5=9C=A8 2024/10/8 4:37, Bart Van Assche =E5=86=99=E9=81=93:
>> +static DEFINE_MUTEX(srpt_mc_mutex);=C2=A0=C2=A0=C2=A0 /* Protects=20
>> srpt_memory_caches. */
>=20
> Not sure if a function mutex_destroy is also needed in this commit or n=
ot.

Probably not since the module memory is freed shortly after
srpt_cleanup_module() has been called. From kernel/locking/mutex-debug.c:

void mutex_destroy(struct mutex *lock)
{
	DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock));
	lock->magic =3D NULL;
}

Bart.


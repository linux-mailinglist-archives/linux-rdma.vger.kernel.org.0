Return-Path: <linux-rdma+bounces-1002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCD1851725
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 15:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051BA1F21D1D
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 14:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFFF3A8EB;
	Mon, 12 Feb 2024 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOkQXm3K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919E83A8CD
	for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748662; cv=none; b=lL8rJbiU/MB0iBXWdGLy7BVMGRtIJtxtE92yv+9NgGbllL7/+vZCEsLC4pr0fzriAofrOtx3HwAiwS6A0/OKBHumALCAOW74N2E2JQHP9F5QHKy9yQwrvbGPpvrg+5vgrZQdik9LArCSlo9ZpQag30ErgzXbZssmQRCc+z5G3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748662; c=relaxed/simple;
	bh=Uk0FjYQKcjKMTjVZno8xTmi0NZBORFwA3P/kTHIBWBE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GCA3k8Fc3XpYXfxn5/YR5cb7VUnURkEKOdq6Oyy4OfAng5RQY9ni+wEi+WLytcPvT6bJnuWTIRMB7jX3pYRgmB7kEODGoyBfBYewY+ylCKEug9OMH1DvNEoOPax1yybVs7BowVkk8tr3Yk5acual5MEfwhgo1LRAZ7rmnQbVQXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOkQXm3K; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2184133da88so1998837fac.0
        for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 06:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707748659; x=1708353459; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XanpYcIZL4/iwghUjhv8lkFuhcnPKhLCE2Bwu39LPM=;
        b=gOkQXm3KoK9OzABO0WKuVuNx3Y6A0uCudhTDVEDe2R+uYCGZN3ajNNfc9t/Wu/mJT8
         gcGIfJR/Jw91euRe5R0maUXHUP+hKrGChenBKGCUaebCVsf0z9mkwAibAFnwzD+vO7vL
         av5ZClfoCUsehSBepPpyKVotWX22EC0p1ysBYbWdE6HY2UP7PSTl78X+YCxMYaDGA66B
         cFb95JYLSIGmD4OGiA9htbRVRNVYF1L8FEtCTZWzJgUNy2Ic2AZThtDO9VXRGZRyheCf
         aLDsMjNV0Sh56PbgQxuLZ+/8fZeScBTRnh3/l6yE8PMq/ce2q8VpxzJVPXc8t7W7bTZS
         UdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748659; x=1708353459;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XanpYcIZL4/iwghUjhv8lkFuhcnPKhLCE2Bwu39LPM=;
        b=HtFtPXwKaDLSLBazlcgRKZgS2ZWocTkhqlsRCmEzKVa/yezGBAQIN0E8YJmVI5THlh
         nuAj6iTI05Swf4QNCZ1D7wuZ0+J2KUXBIDWX6/0Pk+mpO6vUkx3Z+rwh0RQD3FLyKQQC
         W/Trma9j6TgoN4epxxTNwWJaOFEd7R+z26M0BA5l9mTO1CdIAJO6+ZYakaNX7oRhRafO
         hW32wwBG3r735ymMKSw0E3V63MuRNyJCzJc2w2w8maX7faE3a2TL1wHZHUUBlut4zU6S
         Vk+m85TZrBhEJOgvndofCrO65xVyAUKHlU+UjOp0wdf3R2zA5uEQc4G/Z1Nhpvkr5zI7
         Kx9Q==
X-Gm-Message-State: AOJu0YxCn2YhqU++idHh0SA74g/uP6h6a32I9seseS7TfseTllHMa8sb
	/18qCLBcRhaTGRjwXUbA6jn/vA6MZ0p2nyg3NaZ8jmXkheM1T/ON
X-Google-Smtp-Source: AGHT+IFQP8IoBth6AIBeCJjgewoI2NdZDlAV7BN52u8hdeEFaPLGkXSgu5FxfzEfaeWHYCdAEvYXIw==
X-Received: by 2002:a05:6871:b2b:b0:21a:13e8:2989 with SMTP id fq43-20020a0568710b2b00b0021a13e82989mr9126492oab.14.1707748657943;
        Mon, 12 Feb 2024 06:37:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfLW7ETQXb48l/x4xvEAh8+YsEfQ8CXgJV/HEs1vxObltl6zeAkGz2WwR/+/M13iKgJLPHk4GcnThWsqzhcLfIeLLIHqQ3nZRHGEB+oUREYgI1cM40hWT8q8bhzVAKP1ywx4HbTAh3XVadtrBP/sBrtu1q6M3nqiKkyXDcmyOLefOnJgaJEdjbGW7rR2V+tchoRBITfy3XeNROh2sx
Received: from smtpclient.apple ([2601:6c1:500:2c60:6d86:8556:54d5:7fa0])
        by smtp.gmail.com with ESMTPSA id gl15-20020a0568703c8f00b0021a600f3ff5sm556390oab.21.2024.02.12.06.37.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:37:37 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
From: Kevan Rehm <kevanrehm@gmail.com>
In-Reply-To: <20240212133303.GA765010@ziepe.ca>
Date: Mon, 12 Feb 2024 09:37:25 -0500
Cc: Mark Zhang <markzhang@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>,
 kevan.rehm@hpe.com,
 chien.tin.tung@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8BB93F6F-14EC-4B43-B1F0-5FE185A64073@gmail.com>
References: <3CAF66C4-32E1-4258-9656-D886843D7771@gmail.com>
 <20240212133303.GA765010@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On Feb 12, 2024, at 8:33=E2=80=AFAM, Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
>=20
> On Sun, Feb 11, 2024 at 02:24:16PM -0500, Kevan Rehm wrote:
>>=20
>>>> An application started by pytorch does a fork, then the child
>>>> process attempts to use libfabric to open a new DAOS infiniband
>>>> endpoint.  The original endpoint is owned and still in use by the
>>>> parent process.
>>>>=20
>>>> When the parent process created the endpoint (fi_fabric,
>>>> fi_domain, fi_endpoint calls), the mlx5 driver allocated memory
>>>> pages for use in SRQ creation, and issued a madvise to say that
>>>> the pages are DONTFORK.  These pages are associated with the
>>>> domain=E2=80=99sibv_device which is cached in the driver.  After =
the fork
>>>> when the child process calls fi_domain for its new endpoint, it
>>>> gets the ibv_device that was cached at the time it was created by
>>>> the parent.  The child process immediately segfaults when trying
>>>> to create a SRQ, because the pages associated with that
>>>> ibv_device are not in the child=E2=80=99s memory.  There doesn=E2=80=99=
t appear
>>>> to be any way for a child process to create a fresh endpoint
>>>> because of the caching being done for ibv_devices.
>>=20
>>> For anyone who is interested in this issue, please follow the links =
below:
>>> https://github.com/ofiwg/libfabric/issues/9792
>>> https://daosio.atlassian.net/browse/DAOS-15117
>>>=20
>>> Regarding the issue, I don't know if mlx5 actively used to run
>>> libfabric, but the mentioned call to ibv_dontfork_range() existed =
from
>>> prehistoric era.
>>=20
>> Yes, libfabric has used mlx5 for a long time.
>>=20
>>> Do you have any environment variables set related to rdma-core?
>>>=20
>> IBV_FORK_SAFE is set to 1
>>=20
>>> Is it reated to ibv_fork_init()? It must be called when fork() is =
called.
>>=20
>> Calling ibv_fork_init() doesn=E2=80=99t help, because it immediately =
checks mm_root, sees it is non-zero (from the parent process=E2=80=99s =
prior call), and returns doing nothing.
>> There is now a simplified test case, see =
https://github.com/ofiwg/libfabric/issues/9792 for ongoing analysis.
>=20
> This was all fixed in the kernel, upgrade your kernel and forking
> works much more reliably, but I'm not sure this case will work.

I agree, that won=E2=80=99t help here.

> It is a libfabric problem if it is expecting memory to be registers
> for RDMA and be used by both processes in a fork. That cannot work.
>=20
> Don't do that, or make the memory MAP_SHARED so that the fork children
> can access it.

Libfabric agrees, it wants to use separate registered memory in the =
child, but there doesn=E2=80=99t seem to be a way to do this.
>=20
> The bugs seem a bit confused, there is no issue with ibv_device
> sharing. Only with actually sharing underlying registered memory. Ie
> sharing a SRQ memory pool between the child and parent.

Libfabric calls rdma_get_devices(), then walks the list looking for the =
entry for the correct domain (mlx5_1).  It saves a pointer to the =
matching dev_list entry which is an ibv_context structure.  Wrapped on =
that ibv_context is the mlx5 context which contains the registered pages =
that had dontfork set when the parent established its connection.  When =
the child process calls rdma_get_devices(), desiring to create a fresh =
connection to the same mlx5_1 domain, it will instead get back the same =
ibv_context that the parent got, not a fresh one, and so creation of a =
SRQ will segfault.   How can libfabric force verbs to return a fresh =
ibv_context for mlx5_1 instead of the one returned to the parent =
process?
>=20
> "fork safe" does not magically make all scenarios work, it is
> targetted at a specific use case where a rdma using process forks and
> the fork does not continue to use rdma.
>=20
> Jason



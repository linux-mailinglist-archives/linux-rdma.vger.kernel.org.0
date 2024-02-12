Return-Path: <linux-rdma+bounces-1004-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFCB85189F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 17:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8458F1C21C23
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6233D0AB;
	Mon, 12 Feb 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpWdv856"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01C3D0A8
	for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 16:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753891; cv=none; b=PEvxlebJ2yuOjuRhR9d35Wz3z6GSxYN4h5eLl125yAXXUNxa70BqJXdRn9/0jS3sNnOLo9neyVcTKyG1INiSDzANZEJ7HwqiprOel7TJ8m0joZFzq9krfcUf1FtIawG8sfY7udrCna8aDsBfNM+ayORd21zv6OioczZyJj+o1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753891; c=relaxed/simple;
	bh=3qXHZUWnKbJGLH82dwGIHeW+rSF5Gf6W6XJWv+36Bps=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eaK9YRFIMXlGDhQs1o0MtrEBE9NAKxhmTM2dbdx7sDUiumsXGfJu08FEcvINL36UytuV6N2Mh/FyuaMVeKtvT8rVgDww9kyjzb6Na5UwwGs71Q6qMPEL+tDZ9ZyMMn36baSR61I0q+/b1TdhLF0Zx9RNppvB6ZYw+8yZENeewJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpWdv856; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-216f774c827so1497425fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707753889; x=1708358689; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YepDJWzAnRjoI73/+9JV3jlHcTqY8yZEL/wmhsPqoJU=;
        b=HpWdv856NBlIxHcxk+z3TgB2+y/73TdONm2LdSw8ZNeyxzzkYT0Fkalcx/d20r4XDC
         1zbeI128ZkLMw5tRRBXEhGPNjEwCVCV7E9Ion35UcAATVqjVQh/wM5+MaQ3M37U6x/ku
         FnFTCejUFLnb8pfM4jt3PCb/ae9efq7Bekvlln7OCixULqlp5i76/KjNV8wSkegLLu5W
         963c2+ulK0A/nept6WooFQHKEt7i7EUcJycoRruGn3nQD1pWOyzOHaSWqcpjB2kbdeqh
         GvyE5qzsvcN1NinfCV0JtJyc6jfhJS+qZhsXH9h5UdBhEB3a6IMaJGuknrC7ZqvhHX8r
         Xc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707753889; x=1708358689;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YepDJWzAnRjoI73/+9JV3jlHcTqY8yZEL/wmhsPqoJU=;
        b=L5g5ByuyHozbFWNDaUa8qI7rvtxEELGIwQJi8cZDJ5Dz9gjlPUB+9+Y/DHHAUFuOAd
         ahpiTg5pnkbvXKUtZ4DfrtRrXNPPjWuayLCh0DkxdSTUqkg094F87dhRactZATup6A0V
         3yX8qXJ+KW42a7hA6tKBzsUg1rkqx9FlkPeOog+B/L/NvfQ6PDpyYW3j2qPa/fcCnoAp
         nmIk3sK57eyNtfA7nfuG98a93HfNRuaXF5PjmrCN8/n/0ycyY2LSIMRsgV2kZdODisUk
         rlWBkDKoiJ96F0s9Hsi4QMCKu2Jxm6n6FrhW4Uc3bGYjBIj5Qzw+0C6ex7n/vTMF21jx
         +MQA==
X-Gm-Message-State: AOJu0YwHCTPBp4lF7r2F/4j8701ufhUJjcmkbc1bUY3K73Z35Va0ZSbJ
	/fQ+bIYb1+u8mik0UyTPLqW8pzDgJRwMtSNeQBazjtgO7b73Ynze
X-Google-Smtp-Source: AGHT+IEreAnKMREx/JldSQEFVRy0Y7pUGfeNzLonw4qxd/mz0uZLTi4nE7LRCDNpoaubqPGa6m1S8w==
X-Received: by 2002:a05:6870:18:b0:21a:29ff:86ea with SMTP id a24-20020a056870001800b0021a29ff86eamr5378474oaa.51.1707753889146;
        Mon, 12 Feb 2024 08:04:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQ0qK+CWFU7xr99EoP5e/D/Lu6a2ad1fpgFRcZ9j6VLK9kKRTZovQUTS8hzRyLzP3et+rcmz6XR/YTN7gfQgEgaGj0ZqeEOvfzkC8Pk3KH8wb64OFNSemWKp4IrpF1Pzc3mvZ5NcKmwFePblZeuQu55u96/bYCoMGO0yuT9Ihevy4u2A1loelAKkMF5QApASvyzx/z2UpIc96WKcWD
Received: from smtpclient.apple ([2601:6c1:500:2c60:2ca9:3984:5abb:843a])
        by smtp.gmail.com with ESMTPSA id nd10-20020a056871440a00b00219aa97e728sm1463951oab.26.2024.02.12.08.04.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2024 08:04:48 -0800 (PST)
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
In-Reply-To: <20240212144013.GD765010@ziepe.ca>
Date: Mon, 12 Feb 2024 11:04:36 -0500
Cc: Mark Zhang <markzhang@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>,
 kevan.rehm@hpe.com,
 chien.tin.tung@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <53992378-7BB2-4E8C-BD3F-8A2B1FC837BD@gmail.com>
References: <3CAF66C4-32E1-4258-9656-D886843D7771@gmail.com>
 <20240212133303.GA765010@ziepe.ca>
 <8BB93F6F-14EC-4B43-B1F0-5FE185A64073@gmail.com>
 <20240212144013.GD765010@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On Feb 12, 2024, at 9:40=E2=80=AFAM, Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
>=20
> On Mon, Feb 12, 2024 at 09:37:25AM -0500, Kevan Rehm wrote:
>=20
>>> This was all fixed in the kernel, upgrade your kernel and forking
>>> works much more reliably, but I'm not sure this case will work.
>>=20
>> I agree, that won=E2=80=99t help here.
>>=20
>>> It is a libfabric problem if it is expecting memory to be registers
>>> for RDMA and be used by both processes in a fork. That cannot work.
>>>=20
>>> Don't do that, or make the memory MAP_SHARED so that the fork =
children
>>> can access it.
>>=20
>> Libfabric agrees, it wants to use separate registered memory in the
>> child, but there doesn=E2=80=99t seem to be a way to do this.
>=20
> How can that be true? libfabric is the only entity that causes memory
> to be registered :)
>=20
>>> The bugs seem a bit confused, there is no issue with ibv_device
>>> sharing. Only with actually sharing underlying registered memory. Ie
>>> sharing a SRQ memory pool between the child and parent.
>>=20
>> Libfabric calls rdma_get_devices(), then walks the list looking for
>> the entry for the correct domain (mlx5_1).  It saves a pointer to
>> the matching dev_list entry which is an ibv_context structure.
>> Wrapped on that ibv_context is the mlx5 context which contains the
>> registered pages that had dontfork set when the parent established
>  ^^^^^^^^^^^^^^^^
>=20
> It does not. context don't have pages, your problem comes from
> something else.

My terminology may be incorrect, certainly my knowledge is limited. =20

See routine __add_page() in providers/mlx5/dbrec.c.  It calls either =
mlx5_alloc_buf() or mlx5_alloc_buf_extern() to allocate a page.  Those =
routines call ibv_dontfork_range on the page after it=E2=80=99s been =
allocated via posix_memalign().   _add_page() then adds the new page to =
the mlx5_context field dbr_available_pages.  Later the function =
mlx5_create_srq() calls mlx5_alloc_dbrec() to allocate space out of the =
page, it returns a __be32 which is stored in srq->db by =
mlx5_create_srq().  The routine then calls "*srq->db =3D 0=E2=80=9D to =
initialize the space.

When the parent process calls mlx5_create_srq() to create a SRQ, a page =
gets allocated and dontfork is set.  After the fork, the child process =
calls rdma_get_devices() which returns the parent's ibv_context, which =
contains the above-mentioned mlx5_context.  When the child calls =
mlx5_create_srq(), the =E2=80=9Csrq->db =3D 0=E2=80=9D statement =
segfaults because the space is allocated out of the same page that was =
allocated by the parent and is not in the child=E2=80=99s memory.
>=20
> Jason



Return-Path: <linux-rdma+bounces-951-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C555384CCC6
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 15:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C056B21EDB
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA8F7E760;
	Wed,  7 Feb 2024 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGdt/vGH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A247E587;
	Wed,  7 Feb 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316308; cv=none; b=c4bu/pdIZudm0w5jX4TCey5MJqDsoXIVgmaXDsKIEILQKg7/SoZi3GYcWbnIaEjE8m1TZ0fsdfeeg/n7vz2CruboFDEkTdu4xPybPH9mY2VKqVR1UpsRGPlqaYgHvbGw59UQL1BPNsBhvbh88nBmBkvx5IYLQuqrW5vR0UFBagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316308; c=relaxed/simple;
	bh=OPIgeCr9tX3JgphTgoxiOM/JEwMrIKmZmGk/wNxhpwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNiX0cEakSW2lAPMAQWooY8Gh2/DoXev0zFtn31fDAvOzAGee12gIjtUdJisE2rRm3/6vqQSOyzwWzqOwUEcm81TMQxzBRYHa+5Uwis/lFMw5f+8RWtx9jSQP+D/hnbR9cwA5GUCU5+t8p60ZTTD0odMa3CoOzHuijw6B6oI9Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGdt/vGH; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8df2edd29so439723a12.2;
        Wed, 07 Feb 2024 06:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707316306; x=1707921106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPIgeCr9tX3JgphTgoxiOM/JEwMrIKmZmGk/wNxhpwk=;
        b=NGdt/vGHBJwqh4gJF261gOHwnKsNfNEUT09uM0N3ujCS0XthxdaEtQC4pWAxvvRjHg
         nYokGQtIIj9B4T64OBhxGoZYpyBGXbBYPfJYuGt/uY6/Jr05KRXzWfWazEGiqmogSyiQ
         zw2dSUORq/z+XR/10gBLiy3YZP0sqnvZRqEGIfCAoqTSJq6kIBJ5aITp8tl0yD9y+P6E
         D391+w8C30ZKO7SjTj+1HqeLbepefrSZFC4bMCayg+qhgBHFinEPrPOTsaviY/YPvdxk
         5XyHGt8NqkSN9Sm3iNRvRFUrXVc64uTtOlVZhQSAQ0jubJgAoEkK7sqp2muMZ3HO0vAz
         lKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707316306; x=1707921106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPIgeCr9tX3JgphTgoxiOM/JEwMrIKmZmGk/wNxhpwk=;
        b=CUHV/XQ41yUh32ERyEyFYtNNkwxozYQiAUqecGFUrKlsBqD5FM1KUgCNfroROkMxkd
         ujQ44F5Tf1HtciZSCZ9pWAGof1AkThrUQlfzfqcDja4CAPqxzqK4iO1XEinzKXa8K16A
         xMJv+GuX8g9GYmmJpqA7VlDvh5442ZQb5i5MAq353GHVA5WmcejyzobKwLcyD4NCAuuC
         p1qbcs1xJvvtMU5qjUZTjLtZMwx3O8uCcyXyV9xtjwQfjLHNCI6r7G54tlytRX6B2E1g
         K4QDax5Ybg4jlYZdcHULvnc9H55rfFuaHIp0EOljrY3JRxUJ0lFeypdk+MxKYyx6BMD3
         Vx/g==
X-Forwarded-Encrypted: i=1; AJvYcCUYu7HjfKVR0HWAieW6OiUNA/HRzVhYPFoNZnQNqcJezHlJrsyz2V2sBHc9gwzr+kC/5jkFlXfLjKVjjWeFaswwRD+L51qnwGo4G34j10XMxhsgt42FWws7lvtjnkLEJd7f2YvvVDlQQxCGLoq+UXgB4Jf1L/b/GuovSfn3i4EcPw==
X-Gm-Message-State: AOJu0YyKNgRvPuhWDpMqjnq9jYxAAWoIwzyJeMGtpb5noWghPz7qojHs
	VArja2P89IDk59q6M1cfnLNVh+ueua7cBqWs8vWyLZQnuOrwXjnxY61eA5g4kewfWfk5B72LZ2Z
	1ST4x8m9V29d8Nap8xygMaitbTjXZaYSk
X-Google-Smtp-Source: AGHT+IFxgrOu+ahtaoPMOs67gwkpG6ceSI7wXNAVBWDW5vLpOtek9d22tntZIeUSdN3qHaaaghql1346fultsMOr/Hc=
X-Received: by 2002:a05:6a21:a59b:b0:19a:4e56:d81b with SMTP id
 gd27-20020a056a21a59b00b0019a4e56d81bmr5159619pzc.27.1707316306040; Wed, 07
 Feb 2024 06:31:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206010311.149103-1-jdamato@fastly.com> <7e338c2a-6091-4093-8ca2-bb3b2af3e79d@gmail.com>
 <20240206171159.GA11565@fastly.com> <44d321bf-88a0-4d6f-8572-dfbda088dd8f@nvidia.com>
 <20240206192314.GA11982@fastly.com> <b3c595d8-b30a-41ac-bb82-c1264678b3c4@nvidia.com>
 <20240207142529.GA12897@fastly.com>
In-Reply-To: <20240207142529.GA12897@fastly.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Wed, 7 Feb 2024 09:31:33 -0500
Message-ID: <CAA93jw6_KMR_T6vs5S40n6OGeCdxbhikE7DCEAbN1N8_nFW_5g@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and IRQs
To: Joe Damato <jdamato@fastly.com>
Cc: Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tariq Toukan <ttoukan.linux@gmail.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, rrameshbabu@nvidia.com, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 9:26=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> On Wed, Feb 07, 2024 at 08:59:18AM +0200, Gal Pressman wrote:
> > On 06/02/2024 21:23, Joe Damato wrote:
> > >> The per queue coalesce series is going through internal code review,=
 and is
> > >> expected to also be ready in a matter of a few weeks.
> > >
> > > OK, great. Thanks for letting me know; we are definitely interested i=
n
> > > using this feature.
> >
> > Hi Joe,
> > Can you please share some details about your usecase for this feature?
>
> It was outlined in the cover letter for the RFC [1].
>
> But, briefly: we set a number of queues (say 16) via ethtool. We then
> create a series of n-tuple filters directing certain flows to queues 0-7
> via a custom RSS context. The remaining queues, 8-15 are for all other
> flows via the default RSS context.
>
> Queues 0-7 are used with busy polling from userland so we want those queu=
es
> to have a larger rx/tx-usecs rx/tx-frames than queues 8-15.

I am looking forward to trying this to chop some usec off of eBPF. I
am curious as to how low can you go...

> We implemented basic support for this in the RFC we sent to the mailing
> list.

thank you for re-citing this:

> [1]: https://lore.kernel.org/lkml/20230823223121.58676-1-dev@nalramli.com=
/

The big feature that I hope appears in some ethernet card someday the
ability to map (say 16k) LPMs to a hw queue, as opposed to a mere
tuple. It's the biggest overhead operation we have (presently in
vectoring data via ebpf) to libreqos for 10k+ ISP subscribers.

>


--=20
40 years of net history, a couple songs:
https://www.youtube.com/watch?v=3DD9RGX6QFm5E
Dave T=C3=A4ht CSO, LibreQos


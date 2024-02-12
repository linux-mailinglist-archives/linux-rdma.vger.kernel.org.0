Return-Path: <linux-rdma+bounces-1006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FB68519C4
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 17:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8818A286C62
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762203D984;
	Mon, 12 Feb 2024 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtmBWfFf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC473D0C6
	for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755874; cv=none; b=mntDVKLS3zvxfr/+yVz8Sgt64rQdZA+P89/5X0FFrnmevmRkca1PkpFmGjRmucQ81c2w7lWk15q8bLqiUQ4OS2r99zS5RyYBvZicm26fK5GMi5HZQaHUKj5vxCsl8DoisE1VXEaIdX2t8NelJXCKL5UtBAA2q2BzetnlyFX0oaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755874; c=relaxed/simple;
	bh=Gs5cNJ90+bxiWkcg62aKE71nSN+46iDH8LABMcNa0tI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=boQ+A2FiVEduCPclkOlLA6+MZ4VkH3mYgtD5R2HyFS+FPMg56LTwL5ap2VqIenx0umiDDAb39e+vrIw/FvLaiTxLTRYiXyYMAF5LRV/qykOYAiRGAh6Z4VdPeY69TUWzVyStw2wrOFWQdk61DaU49DlA1H51qPrZImXZkP7f8DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BtmBWfFf; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so15862b6e.2
        for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 08:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707755872; x=1708360672; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1QJAKETUj08i4fwEaWTrNPhFlp7ATF7BDaCx2//X6A=;
        b=BtmBWfFfTi9F8hbUpP2NFf+j0aqv38TIPB0lxUWRX4TWMdNimYiuFWkfiKjnpvP2+I
         Y5hq5jDFAt1hQFk5qVTmU6sF0tvrM8qGkd7Wt7Evd5x0zjpxgHcgS9EOxQLILHmpxpWt
         7JOiD6uq+FQxeSFI5WXNGc+y+sg8qMhb+ZEQNM9KDQAp6H6m+7zjAipCvDUJzDnVW+5Y
         fAQDo54gfx3p7HVPBLjcXiFtSQWzb9Zlm7s4rqc6hvUUzFaRFs1eUf4Ti9thwaeyI/fF
         c3Y4Kx4A3uzRUkEgJKKlKqDN4T4GBG8OLG0gkAO44H6ljgN4FFuqsuBP/vfp4s+arLkH
         5/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707755872; x=1708360672;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1QJAKETUj08i4fwEaWTrNPhFlp7ATF7BDaCx2//X6A=;
        b=R8DgfCVbOSFETykp4F0KyL30VULTwPNPWCTgeF+ng0ltT0vRRjckKc3n2bXfG7LonI
         qDFQdVvSEbFpA2SBbfydOqWn2y4tD6mO5DEq8vKlV64GP2jOnvCeruixyfHBFOsSfqV8
         rCqMgPg5Cvj7bgN7djlHi9arpE5hOJe/Pxt9dafsZB9I6EUYUE2EoPWjgP09IrPy1f86
         bhpmvs5+XADm5WMCXzXnJMcsD/tMXTMI/BjG+gpvmj4qinYjEaH6HwChxmGykp3BzOBD
         QPgHfTJnMwwSfndwLN6p1W83Gqx70pj+FFYWT4q8mXdUxYcslWfk74Ti7hYhOuS0NzND
         6g+Q==
X-Gm-Message-State: AOJu0Yw6mnSinlOBdqFXtYtNpe3K7SHPM4gEvXc2lvNBCNEf1LEkN/KT
	8mJYXh1EtlFekxoMSXS4LO/zPNIM+fJ6J7qgzUDd4pMWwxtKfyfz
X-Google-Smtp-Source: AGHT+IFOa768WNjg6hRlid43t/coZGj7gbfIKXX6Gek3Isey0QXzCcz+tdRsRO0zO7HXlQno8lKh7w==
X-Received: by 2002:a05:6808:1917:b0:3be:d38b:9cf1 with SMTP id bf23-20020a056808191700b003bed38b9cf1mr9954617oib.35.1707755871891;
        Mon, 12 Feb 2024 08:37:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvhfQXfdjCcDXB8aaOKwxxGevTR0Rtgn4O+/rzl3T20iPgRrITZnKG2CuwePyU03X7s7EyTuIsSGfGB+Ibo0PqesMGFgZTHDU+yrHfUNXXjHArOJzLCZkJX+eaAfTOgILwHGgoRW3887SUurmmIbG6wXqfRLgZTNilUpAiUY1YLJglKf8nsDq5+ew6J5/MzPNfoCJ20LWMielpmEOB
Received: from smtpclient.apple ([2601:6c1:500:2c60:2ca9:3984:5abb:843a])
        by smtp.gmail.com with ESMTPSA id r24-20020a0568080ab800b003c032640de1sm110834oij.47.2024.02.12.08.37.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Feb 2024 08:37:51 -0800 (PST)
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
In-Reply-To: <20240212161238.GF765010@ziepe.ca>
Date: Mon, 12 Feb 2024 11:37:39 -0500
Cc: Mark Zhang <markzhang@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>,
 kevan.rehm@hpe.com,
 chien.tin.tung@intel.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0BC5DF9E-53A2-4224-8EDE-87B4F2407D56@gmail.com>
References: <3CAF66C4-32E1-4258-9656-D886843D7771@gmail.com>
 <20240212133303.GA765010@ziepe.ca>
 <8BB93F6F-14EC-4B43-B1F0-5FE185A64073@gmail.com>
 <20240212144013.GD765010@ziepe.ca>
 <53992378-7BB2-4E8C-BD3F-8A2B1FC837BD@gmail.com>
 <20240212161238.GF765010@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On Feb 12, 2024, at 11:12=E2=80=AFAM, Jason Gunthorpe <jgg@ziepe.ca> =
wrote:
>=20
> On Mon, Feb 12, 2024 at 11:04:36AM -0500, Kevan Rehm wrote:
>=20
>> Those routines call ibv_dontfork_range on the page after it=E2=80=99s =
been
>> allocated via posix_memalign().  _add_page() then adds the new page
>> to the mlx5_context field dbr_available_pages.
>=20
> Oh, if this is your trouble then upgrade your kernel. This part is
> fixed on kernels that have working fork support.

That=E2=80=99s the bit that confuses me; all this is happening in user =
space, what is different in the kernel that would prevent this problem =
from occurring in user space?   Any guess as to how much newer a kernel =
must be?
>=20
> Jason



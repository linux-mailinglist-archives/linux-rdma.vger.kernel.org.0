Return-Path: <linux-rdma+bounces-2519-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1438C7D04
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 21:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214DA1C2223C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 19:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AD715920B;
	Thu, 16 May 2024 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bahG2UVJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41672158D99;
	Thu, 16 May 2024 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886468; cv=none; b=I6OUnz5XAWaAEBCNonPd1X6SahW5MR9vpaLhwTFuC+iNHTYv083CuwZ2g3BUvjhDdULcgHxMc7nvfDK4YvKXooy9fAXb6UlvmBO9jX1hiP9u4+Yc4l3xr8OfQSEZCBJ/A/NgquzTnaZTNfOgCEAHTmjzLKC8QygmNiHcCmdU23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886468; c=relaxed/simple;
	bh=vdVstfTJWRr25JayXKawfEg+DKVNWLVsJwrCAWHBcOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAc3L1mpoIu8pdOx1Ss2CBG8RFaqUz5XQu6FHrXMqHskWLtflz31Jc2r4bU4hkx+tGV+sVTO94ZqWcx6i5Tt6KD+5N9GiINLbKBcw5rvXsgWLWTp2HxGi7kZJQdYsKyW/yxqnBxgexUcYNrE57h4MVhbLog3wx26iKPboxKcD3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bahG2UVJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f44dd41a5cso616940b3a.0;
        Thu, 16 May 2024 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715886465; x=1716491265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdVstfTJWRr25JayXKawfEg+DKVNWLVsJwrCAWHBcOA=;
        b=bahG2UVJCKX+3QRk3oG2AYqTxI0QSQ2+XGfGkCUkzc9KxIATJ3iHcv+D1f0Mh/8aAM
         bkqyavgGVwThMSKTTU4uuOebbuvp32rGIilN1TGan10uEbf3FOATWm1Dpc3vFZXIlLHN
         utqaaMUnmluVq7puXz9e8cFrAe+UZpEvSUtRcI7ZOue8wIiR9L3E7TlkqJ0g/4p7YmIP
         +W94DvX1MsImlKwWwNVRMAGJZWw8tYjdyx6lTJHKZjuWmvxYx7RT/YIEocd7YFl+nBPW
         tT0g9JQbDfcwQBL3B1PBLAeaccBHHWp0zNoC0wQwomZhZl4dhshsJD9uMABim5vhoulg
         fHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715886465; x=1716491265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdVstfTJWRr25JayXKawfEg+DKVNWLVsJwrCAWHBcOA=;
        b=XusfDbOwq/kFNmasErAVdMxlYVzFuRxZ/8INMPs8i3+xwjqRBbd7pU4CjQcg7AW45I
         OxdmgZE3I8kaNqARRYaUlWK7vxYKObk1LICPkfjmBU7qY5tfPKllxLqA2arVY0U1Wy1J
         3J0lJDbjsMKjxR1mZzfXKRsjvcHQaFVMkRpji2k6fMpW8mdHmlcdINsNnfFgvU6usRj1
         dWqYV0Hm0fj3PWSWUoQncTcwFSzqX5NrlQoagdo+BNwX+QCqj2Q9CIB3kPW5SqB5NPoT
         x0D23V7oFX4LUDHAgX0iIIhlYAF3ejTAXZbhHjYCCsF7dbblKy8TEgMNiUtGU7rxrltp
         HP7g==
X-Forwarded-Encrypted: i=1; AJvYcCVNE8wOpX/qc8ydb/k3w6A0vs5MCmatt9MBXq6WoJQ2hYBoWFZM+Kxv69efkgDmtwdJwIXxkv30JI9zAMlDMR+J6GSRlzihsJzC1Yx71WPaqXFAwJEImMNpHFWk0M/97QRawPFt/BDuiZTT/Vn6+Hl4LzYW79AWaPIG3d9c9QMe8Q==
X-Gm-Message-State: AOJu0Yyp9P7W+Q1jFvzAtcuci2CC5OMss2zgNbLhO2pzpOaz42VC3hkq
	wLbRZeyvXqLwfLacIdj/w0QxuGFfvhHUEMncakUWSj4YwZ2EqdrKtbLiCa11cAuVVt4OBIOuFON
	nM1z3n4IijSpGR1F0QjmxIEf7cTE=
X-Google-Smtp-Source: AGHT+IGLFT1S7qQvZoURCyPTWP6DLQxIRfqFMLgmLurk+JpY7haynCdqsfwTebdBhjXGd/5cwIz/OyJ0cMQ8OV0KcMA=
X-Received: by 2002:a05:6a20:9498:b0:1af:c5b9:273b with SMTP id
 adf61e73a8af0-1afde1d824cmr19019205637.54.1715886465298; Thu, 16 May 2024
 12:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515125342.1069999-1-haakon.bugge@oracle.com>
 <20240515125342.1069999-4-haakon.bugge@oracle.com> <82bf9e5f-b798-4d29-8473-c074a34f15b0@linux.dev>
 <236B9732-8264-454C-94BF-7C9D491D3A37@oracle.com>
In-Reply-To: <236B9732-8264-454C-94BF-7C9D491D3A37@oracle.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Fri, 17 May 2024 03:07:34 +0800
Message-ID: <CAEz=Lcvbc3O+PtDSLvGAgd5fmps8j69DDn+Mgm8UWMFMNSd8WA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] RDMA/cma: Brute force GFP_NOIO
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, OFED mailing list <linux-rdma@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, 
	"rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	Manjunath Patil <manjunath.b.patil@oracle.com>, Mark Zhang <markzhang@nvidia.com>, 
	Chuck Lever III <chuck.lever@oracle.com>, Shiraz Saleem <shiraz.saleem@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:54=E2=80=AFPM Haakon Bugge <haakon.bugge@oracle.=
com> wrote:
>
> Hi Yanjun,
>
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/maintainer-netdev.rst?h=3Dv6.9#n376
> >
> > "
> > Netdev has a convention for ordering local variables in functions.
> > Order the variable declaration lines longest to shortest, e.g.::
>
> "Infiniband subsystem" !=3D netdev, right?

All kernel subsystems should follow this rule, including the network
and rdma subsystems

>
>
> Thxs, H=C3=A5kon
>


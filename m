Return-Path: <linux-rdma+bounces-12659-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7AAB1FE85
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 07:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A77F1892614
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 05:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284B267B90;
	Mon, 11 Aug 2025 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="pJ8Qk1QU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFC5264A86
	for <linux-rdma@vger.kernel.org>; Mon, 11 Aug 2025 05:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890005; cv=none; b=RJxVjmmZAC8A1RVDXX1ubmASIxs1NAz8kjqwWPlcDtTVPgIlOa9zmckNmvi6I6p5qeXybfO96DMIFRm/AJ3zqR4CXB6G6gi5eElAfr03Hp7ff2vYm1gG5OycQG9tIyiGD0Acp3Mm0mfgwie/L1JQXnHX8TjKdWGvXO+G1RbKG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890005; c=relaxed/simple;
	bh=vTpxG/7bwb/tV6gaPq+KpsnEWX7NoumATykPMMwu+dM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUe0jS4iFZ1p5xvgc4XXINcmJ+J8tZxFJmdHTejBeDrstjRsl232XDtfK2zTbVcXAbvJiELUgDpDwPQ7hVv9e0eXUnbK8gAFis59LSTCIWmVL4sD1RLqXzMoqIaXF1eqe8dO/9z8eVDtvSZhbMTAvkv+J+RaAA7QCo54gazkbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=pJ8Qk1QU; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6156463fae9so7862572a12.0
        for <linux-rdma@vger.kernel.org>; Sun, 10 Aug 2025 22:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1754890001; x=1755494801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69PxPPhAwOTbogeViQvDw262FB76BrPzf0OJx/mbyF8=;
        b=pJ8Qk1QUji0T9x1vmhcVQ3W9xKI3jpjJZJtwBT6w4unaLxOFF3M9YSAzr3xp1p2Pa4
         7O1r3rKdPiKh9oyaLY2vY5Y4qQy9OBc1EFTsUdvD6CfJWnUrJ5hWKkNFaBJZJQeBYmKT
         zpK/8lN5XQS2a9CgTHXu1ZwcT6N52D6hlx5uI+K33NCIlXJVuJmOdcunDUUly3GTESWG
         RvR4skDTS3ZAXV2ycG2GHAHCcWbM6uv+k64CwmYm3PYEdrCk/jTyXw03aj8oqVKs09nm
         9gyYCzaXnLRPxoCcxp8t5KJ8tDQpb2LVv3V62/KIPEduMvj1ZNQ3n1uPJLeYfMRq34CA
         TfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754890001; x=1755494801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69PxPPhAwOTbogeViQvDw262FB76BrPzf0OJx/mbyF8=;
        b=cwFbU9oZ+Rsew8HpuN0XFOcH3Ajpe2lSAdsNKuQe0JQ0KQbWvURm61YZ+Dv/Rb0lPA
         6amlUOq8mv/AvLqXbPWURYpsD6T6TshuVSN1wNIT/MTfQDiTl49pCGTk81gLVVxwvWAT
         uD18SN4VfdCJZrcS22N77D6mb8J0dt3nuPjuPWtEWbQcm7TSXctiYSZ4IIifB0dG4nis
         pYolU7RrG0/oKDD/aVT1PAW3PMfgWNwoJqt6tXkZmNBlzyOp2PDH32Q/5czn6rUfMZv6
         2fBvgmhRbKmwFZjEEMoR5AEk0oq28yMT5SKvwNbnf5eDgOz6Rf4QY+7tYVR2Bneca2rS
         vSjA==
X-Forwarded-Encrypted: i=1; AJvYcCUktzZL19Q1ORt/icqEZJC9yOlU+tf5iUGkbS6KV3BucqnLJhMwgX8ngfPmXczSpR0fMXyf1ngudMXg@vger.kernel.org
X-Gm-Message-State: AOJu0YxXedbYNEtNIDyDsnan40UhsaI7eyLYXlF6cYpWl1V8fZuVOBDD
	Q6Tlopc2OfBQ3yjJ1EcMuakyw0oZmVdtOW3wNZtK6DI3Zvq4p7TwIygIxBTQ1khcL4BYbLRs9Wr
	6DhGik1ONYJ+11baxvy4M66/rrNE6fXV04qyM1qAhLA==
X-Gm-Gg: ASbGncuKR2vM8zGVhyT+gqmXO5YPE4NjS7aUzmLk2IWLBQDDxZG+Ktvqb/xNrhgu6An
	k1xWg+sL99TTIO4WY44HzXC+vPnM9tj/hebS8Ppay1lVrHuDdHnRSH2HyjB08mlpLxmbp4oU5hy
	lKMBlLEWRuX8oBp3eLOMoMZQYfGBuTYe8laYFG0BbranIxYVzxT2i/L9pTl4bCZZPhIZe6iPxmy
	xb0vLe1cnvzT+TuiA==
X-Google-Smtp-Source: AGHT+IHaYSux36WBVNo6NkZaBw2GJAYwmrtrQojyp38xI/LkSrRkgdTHlXqlCqLZ1P02eXH1IuG84+lRDv8VSU4MWNo=
X-Received: by 2002:a17:907:7247:b0:af9:6863:9d41 with SMTP id
 a640c23a62f3a-af9a3e3f258mr1582062866b.14.1754890000722; Sun, 10 Aug 2025
 22:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806123921.633410-1-philipp.reisner@linbit.com> <5a31f3ef-358f-4382-8ad1-8050569a2a23@linux.dev>
In-Reply-To: <5a31f3ef-358f-4382-8ad1-8050569a2a23@linux.dev>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Mon, 11 Aug 2025 07:26:29 +0200
X-Gm-Features: Ac12FXwoMO_YfYRatsrbC8Hz6zhCD_XEaGw7Cu0dcqifieHK8nSJiOGowkx_ebg
Message-ID: <CADGDV=UgDb51nEtdide7k8==urCdrWcig8kBAY6k0PryR0c7xw@mail.gmail.com>
Subject: Re: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 3:09=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/8/6 5:39, Philipp Reisner =E5=86=99=E9=81=93:
> > Allow the comp_handler callback implementation to call ib_poll_cq().
> > A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> > And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
> >
> > The Mellanox and Intel drivers allow a comp_handler callback
> > implementation to call ib_poll_cq().
> >
> > Avoid the deadlock by calling the comp_handler callback without
> > holding cq->cw_lock.
> >
> > Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
>
> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
> Test resize CQ, start with specific value and then increase and decrease
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_=
cq
>      u.poll_cq(self.client.cq)
>    File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>      wcs =3D _poll_cq(cq, count, data)
>            ^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>      raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)=
')
> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
> remaining)
>
> After I applied your patch in kervel v6.16, I got the above errors.
>
> Zhu Yanjun
>

Hello Zhu,

When I run the test_resize_cq test in a loop (100 runs each) on the
original code and with my patch, I get about the same failure rate.

without my patch success=3D87 failure=3D13
without my patch success=3D82 failure=3D18
without my patch success=3D81 failure=3D19
with my patch    success=3D89 failure=3D11
with my patch    success=3D90 failure=3D10
with my patch    success=3D82 failure=3D18

The patch I am proposing does not change the failure rate of this test.

Best regards,
 Philipp

#!/bin/bash

success=3D0
failure=3D0

for (( i =3D 0; i < 100; i++ )) do
      if rdma-core/build/bin/run_tests.py -k test_resize_cq; then
  success=3D$((success+1))
      else
  failure=3D$((failure+1))
      fi
done
echo success=3D$success failure=3D$failure


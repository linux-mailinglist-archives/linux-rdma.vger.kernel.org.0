Return-Path: <linux-rdma+bounces-3541-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2726D91A72A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 15:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B2322886A9
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 13:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBAA17838D;
	Thu, 27 Jun 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Vp6mALM/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC417965E
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493181; cv=none; b=hDWt3dKsOkeUUYzGOxEzb5hFA1spEbspnxSsDkuzlFR96V5K43ZVDm59IQYhQAS08BwkFprAnskY4wLqS9BXIyDxsspCZKlpSVCKx8bEbJ2e5Y6xH0Gw54WGGwWKdLiqi0RRmr0xKF0TnMftS1Dvz86xDgjbO/WKX87V6fidrbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493181; c=relaxed/simple;
	bh=djf+zpDy0cGzml2gdulK4XsNMklzMkCpPiMsnT/SHHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=am8WzvS6V23K6B1NT/Bi+GRuceoIkG9sRLmkviz/jZX3GqksirWH2UmF23zAIoGMxS45IM7eMmtGetvkXi3apQ4fpl5N00Mfw8qm9+XTMNVagx0DDwaCsVhicq1XNPsVgknw+yahfUEPEP9yZLlhmZBACyoaly034yX4mekXiqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Vp6mALM/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d15b85a34so1666377a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1719493178; x=1720097978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWHz2FIZmR9jlDrFPN04RMbtkT6hZhyxIzbXRjccwgc=;
        b=Vp6mALM/+CD/pkSwNNdeufo5f1Ixu0V7uJ85ijBHnYlOpPZTzn8MVMK55v37dBKx+h
         F4MWczubBW3GCaIurryg/tTgzwN/HedamRM17NkYByZWh1DeE02fZTJaXrBE+iiyLXGH
         RkjjqRT9Tn0EwnSmRzHtmQZe2efc9SNX6mc225d5Z0vKekScI1tnnASDtTAqY4WL1utg
         DqtkbATF+TrLoeUAzEPtYwHKqtzcN0EGtsVmOn24a44nor1IlRxM+M463v2F2V5GNqPG
         0qKxY/WYrebBeF0CB5kvFtB0PDlxlujfm+2qC0Tr+hEtn2KUHtTvGAQkapYfDze1wAuT
         Lijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493178; x=1720097978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWHz2FIZmR9jlDrFPN04RMbtkT6hZhyxIzbXRjccwgc=;
        b=I8ufXf8eyGmVgc9NyMCyAmINgg7/uggkjjiKqyvFhyEAWhetl8C1DQu00cAWULb5Ao
         RTWYOENvOAdXB+Q8vycqUu0B8Zg+c5rGXtw2CJedgLXpnI1Zl6pJY7AHX0o2B9Ala5LV
         5EDM56rtAIOU2R12N7JDE2VBJIUiEm8cT8+E9kArtr0q4hKDssrYgt0n5t8K0wuF9JHG
         m8moihYPe7/3hPPR3ZVeQ+Ope8fhJetd9SxIkDdquNxPTA6FA+MvX6cTM7gI98Im29dM
         x27oWuPIRd272ms4a2OcZgXUv8SC4U1twQrSOEO+hS0bO05OW0ZyalmZainqOqppwYMt
         znNA==
X-Forwarded-Encrypted: i=1; AJvYcCXuAOFumqAPEOHLGFVj3nYKk6y165vDxu5FmHpYVbIrm69zp6TOdC/pbySJZnDKXwLzNUxahpNJBGYO4PyF4YcH69+OJJOhDQm6mw==
X-Gm-Message-State: AOJu0YxrKMGYeetkyIeSfjCqrU5XUzGn9D8r7k6tH057lHg8rPU7PGSV
	VDv4KKkoSiSQRb2zjSMnbMzIbndQ2jgqIgh+9WTWIFo8lJlCq/0Pz2e0h7Wv0DJXWbcoIIfGWiz
	F16rIoA+cRLl7D95OUr57IPjcij8lIccn4mz0Qg==
X-Google-Smtp-Source: AGHT+IGb36nfDmQg3J0KfNIEsQLDUZQFaR8fiSp4DzS029pm7FdcwFqbfZ9gp9MN4M5+cIA/npuz/aHOpc7E8ST57AI=
X-Received: by 2002:a05:6402:3491:b0:585:59d1:52da with SMTP id
 4fb4d7f45d1cf-58559d1555cmr926476a12.1.1719493177672; Thu, 27 Jun 2024
 05:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175703.605111-1-yury.norov@gmail.com> <20240620175703.605111-25-yury.norov@gmail.com>
In-Reply-To: <20240620175703.605111-25-yury.norov@gmail.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Thu, 27 Jun 2024 14:59:27 +0200
Message-ID: <CAMGffEnKZK_Du+f=v_PxsJEv4PE=L=vnkejXWW3Eu7gw9vpKSw@mail.gmail.com>
Subject: Re: [PATCH v4 24/40] RDMA/rtrs: optimize __rtrs_get_permit() by using find_and_set_bit_lock()
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 7:58=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> The function opencodes find_and_set_bit_lock() with a while-loop polling
> on test_and_set_bit_lock(). Use the dedicated function instead.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
lgtm, thx!
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/=
ulp/rtrs/rtrs-clt.c
> index 88106cf5ce55..52b7728f6c63 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -10,6 +10,7 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
>
> +#include <linux/find_atomic.h>
>  #include <linux/module.h>
>  #include <linux/rculist.h>
>  #include <linux/random.h>
> @@ -72,18 +73,9 @@ __rtrs_get_permit(struct rtrs_clt_sess *clt, enum rtrs=
_clt_con_type con_type)
>         struct rtrs_permit *permit;
>         int bit;
>
> -       /*
> -        * Adapted from null_blk get_tag(). Callers from different cpus m=
ay
> -        * grab the same bit, since find_first_zero_bit is not atomic.
> -        * But then the test_and_set_bit_lock will fail for all the
> -        * callers but one, so that they will loop again.
> -        * This way an explicit spinlock is not required.
> -        */
> -       do {
> -               bit =3D find_first_zero_bit(clt->permits_map, max_depth);
> -               if (bit >=3D max_depth)
> -                       return NULL;
> -       } while (test_and_set_bit_lock(bit, clt->permits_map));
> +       bit =3D find_and_set_bit_lock(clt->permits_map, max_depth);
> +       if (bit >=3D max_depth)
> +               return NULL;
>
>         permit =3D get_permit(clt, bit);
>         WARN_ON(permit->mem_id !=3D bit);
> --
> 2.43.0
>


Return-Path: <linux-rdma+bounces-7398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9A6A26F37
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 11:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684591659D4
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EECF209F5B;
	Tue,  4 Feb 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aKZ8AYzH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F061204F63
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664405; cv=none; b=f7+I/ZGQ88eVH5yZoM6WFrM4xcevgEAypBUeyCaFlnEMJrlaUWsiCKabjsvdErRHyh0PUt+ssYFtEyFV1B6tnLw30Z1BPITSut7qzx5UvNnhsjjbPjWyKT+H+oA5NtL2JBrECbGjWMuxrG02DJWAyOEbb8349jAqZ8RPJdCH3hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664405; c=relaxed/simple;
	bh=vpEOHp28u8/3DqxSH8sWKiBWQS2glpw+a+CDjrIxHzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f557+Qq9qQdL3cMbxbePb4wxQ6CAI+zbCv1sMZbY+fKAFKxUY0fq6ShzfDxAGkdMl+wo+t2coDgOzNVof85Hd9rdnVvloJ1slUo6MUyJ/BBwwOLLT3Xq6lpG11Or84UAnk3JtY7HAAwG81Rl8h4rT3Jl4PlO5FGm6uqhuzjzsuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aKZ8AYzH; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2b7cd4d784dso131840fac.3
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2025 02:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738664402; x=1739269202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ABE2e1UY0gYhL1YJ8FK9aq+qtD8dGGB15Ir9xb5xf4=;
        b=aKZ8AYzHdAhhtpgeN5d78JNhcopA4WFCklSnuWwINOgG3AR8S5yadUwQQWRfnXvXBy
         znVH4N6Uho8vrtAkzTcMGYfsrCHp7ReUR6TCxTvZVNjUqS1ZGtzhZ550OTf+jWDsKdP0
         czWyJmI/7a2G9SThMAGgyHKTkbnP2WWE5goUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738664402; x=1739269202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ABE2e1UY0gYhL1YJ8FK9aq+qtD8dGGB15Ir9xb5xf4=;
        b=lcrK35dC3luWRRag+O7uMKlpyqANOqpTApYczm0JN0JSyIZMzwNdjxtMmJe8SZ6BMW
         ViYxwvXsnRgq4H5khPso4Q9VVtF/LbVPdkkqVIa0684OTvaAJBgr8PF27W5hEoDSJFsi
         rM6tXSunrzeT/hUdaspjCS5xLHGPMZ53gbCEHOizc6FvQD0Hiu9TCdbQPO85oKoMKGr/
         54ZHvHzFMjt2campMrrgDgaVcmK88VdQ8paLEgsyCQXcx2iuZ7sCMtDBcNKDLhs7DK3A
         S73FiIw+wR2MVW20bLkfirZBCRQtMTOr1pwuamvIFTxmNvp/CdBJNZ2fpVgPp5TNjHy3
         qXNA==
X-Forwarded-Encrypted: i=1; AJvYcCWx+EKjzoV2LBwVQznTaXMGOvzqVTsciiwLjmnS4nqXx0jat7N/gyYA0Q+ac7QHlVxFav4YjGCjGSNb@vger.kernel.org
X-Gm-Message-State: AOJu0YxuIVTKNiXydao1u44YJ6kKOVDzMroBQSNryvIQ3vGQodOtPvyZ
	6t8Lf2etQtLgZ33lrVaK/EgCu9xg7kOcJpZPi/6cOuYRwMqeTS3ksceTIyy00m3t+FClbDA1sTp
	DAQr98z5N1Uw+JMMCx5dYWERWxvq5U3XRMuxg
X-Gm-Gg: ASbGncsK5YtbpC7OO9Bcp8vNOymwYRAqKoD8PGaIOrMBoLqw13yu9byvE7v7Y4v4JNi
	Z7U/0WfQ8zOhCgdGN83CrTu7orWJHG6j3HRBHg8PNJ/AruZ15ItihBC5sh3l8qksIj4wONF2siQ
	==
X-Google-Smtp-Source: AGHT+IGSK1MpERZtgyWagGMYa2me6nKySGTgSR45yJgdLHEA+Oh+ARZsFWKWawFyuMXKB/xEdyBR7Q22Wy9tJnQbUU8=
X-Received: by 2002:a05:6871:a4c9:b0:2a3:832e:5492 with SMTP id
 586e51a60fabf-2b32f3bd927mr14280191fac.25.1738664402213; Tue, 04 Feb 2025
 02:20:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738659966-26557-1-git-send-email-selvin.xavier@broadcom.com> <20250204095651.GI74886@unreal>
In-Reply-To: <20250204095651.GI74886@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Tue, 4 Feb 2025 15:49:51 +0530
X-Gm-Features: AWEUYZkTfwNsKbJYKQsjGBYmIgR9DYV8sFP-CNUv825-CeozHYWY8NNrAh4bryk
Message-ID: <CA+sbYW2Lbrcu_sVnj12B6b=8v5XmXzA3uRBkBSfjKjG3uFcZjQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Fix the error due to the array depth
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
	kalesh-anakkur.purayil@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 3:26=E2=80=AFPM Leon Romanovsky <leon@kernel.org> wr=
ote:
>
> On Tue, Feb 04, 2025 at 01:06:06AM -0800, Selvin Xavier wrote:
> > Fixing the issue reported by kernel test robot
> >
> > drivers/infiniband/hw/bnxt_re/debugfs.h:34:40: error: variably modified=
 'gen0_parms' at file scope
> >
> > Using the fixed size depth for the array.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202502041114.K8XQYeJg-lkp=
@intel.com/
> > Fixes: a3c71713d954 ("RDMA/bnxt_re: Congestion control settings using d=
ebugfs hook")
> > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > ---
> >  drivers/infiniband/hw/bnxt_re/debugfs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Thanks, I squashed this patch into "RDMA/bnxt_re: Congestion control
> settings using debugfs hook".
Sure thanks


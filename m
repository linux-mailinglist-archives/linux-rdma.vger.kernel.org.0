Return-Path: <linux-rdma+bounces-9097-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21178A7838C
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 22:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567CD16D983
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3F520D50B;
	Tue,  1 Apr 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GN85febK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2414AD20
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540528; cv=none; b=RguFeIatsubB7JeYushglae7zOoJE74eqeiUjwwD0igJ9EpP+vEGoHeZ87PW6O03l6YEEe5SwFaVoKjyage2prtIdpUSNs9yoq+josO5yzW4fL8f+M7K0qGwBhyyxBcbXwwic5hjnDzwy0qVnVVGMVkMnt+U4fi0uOMzMOHDMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540528; c=relaxed/simple;
	bh=qwztNLshqymLlN2X4UgeFOrucyjgwUfhecdMODasoMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iG28iSmameA077n+LDltm55SXVpz6jT05GGZ08UKMxI/k7/wRRtv8+PgHIhlHH807VYpDESI8szNG3y47uDn3qOKgVyhvyUE6A/O5b7JiPodokkGNz3YxRxBMP5piMBfoZXKQXPvQUm+qUNR7w3a72o56gOpBMq+OXmXTBlnSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GN85febK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394036c0efso41010005e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1743540525; x=1744145325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkO4a88+Txv/GLJVvPTo4zIPNNIrQG92E4ZbquZedeE=;
        b=GN85febK07OyH8QYrolrmfBh8t/atxvtcmmkKO+LCCAc/4nm4IbHG8M8TiejpUdpdm
         H8O7wCRRPBBEx6COlTZiV/HStCSIkyM3VquiMqfnqlCxSrdgtxT49PIOPSJjUM6Kc6n9
         2ptDoMJsg1+LDiaJzQPTh+F8p8XAzhYnDlS5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540525; x=1744145325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkO4a88+Txv/GLJVvPTo4zIPNNIrQG92E4ZbquZedeE=;
        b=bEOs1ynxDfUTvzIgQUTYqrl/MqyaLQfWqjaZlMQpqDzaI8MzmdU50p7pGilvlKZOab
         BxVnGPmUq4IdCMrv9coj+xWSLO4vBbNOfJrc3lG1hZKBewsgmLMNA1QtANUl+MCik6Ot
         WAyGIjM/c2n5hAVvHmDwElQMt9nV0N+2cP2xP/7k3TvtE7ZKP2Gg8Mm8dXZGigUkv/gc
         GVNAEMBFqwjp5gUOzLcYdommE6Xw3EfIL9Mxb3tB3I0aPf3b93ZxGCLL/8Ndyh4L9JRD
         Zj5AB4f6y+IuD1WkKK0h3q2re+8pw4us/7CD0zGrfk1H3SrLC0egneYBidlKMMboiprH
         O8PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM+1aRVqIioYnpCgtGIWSO3W2RIuq+eo3pJUmExKxSutwl87TEAN3iwsR3MHSoSKBnmUoBVT+Vo3/m@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgjTJo9hb+cOIfM5ymMaKBNfEWcwEswT88ELtHhjhm4vmKDur
	dxZ9DG9fAsszJBDFaiUJmNxRXZlr9S9y/KQ4c5McKARTsl8rEVVbPyLJgKsSI29b0BD0KN9g9Rg
	JXX1hnygv/T54PXCzjyVuPc+vpHwNJvUslUvc
X-Gm-Gg: ASbGnctXm2+KNQJhNVXm0FdnJio2fyBo2VpALj8jvtPsTIgBiwsRVmGUN23DsavYWrM
	rgjt1Ihz3C1CoXfcsa9Ye+wiugEqs1jJlWiXgl18N9iGWjauL1TlCJVnOziSHkPB4jKERyAxQul
	x++f1iSdJDaAHhyKKg63MybO1hMsk=
X-Google-Smtp-Source: AGHT+IFIMvNtEEcNZfKRl7q+JoxC15xSd+SXbP0Vz47P/z+prk1TU3mVNFVIKV+JeDHOGNaMwYzJiIWIykH4uNPP1I8=
X-Received: by 2002:a05:600c:83cc:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-43db62b59d7mr121396845e9.25.1743540525321; Tue, 01 Apr 2025
 13:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
 <20250223133456.GA53094@unreal> <CA+sbYW3VdewdCrU+PtvAksXXyi=zgGm6Yk=BHNNfbp1DDjRKcQ@mail.gmail.com>
 <20250401134133.GD186258@ziepe.ca>
In-Reply-To: <20250401134133.GD186258@ziepe.ca>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Tue, 1 Apr 2025 16:48:34 -0400
X-Gm-Features: AQ5f1JpIsW_7IkXLGjeXIQXGkdUItH5Ex9T6h9foDQscw-Izjnyr_X4gXQVfmwk
Message-ID: <CACDg6nXwG8ibo=PHnz3WpMzkJbWuWrRtTcj3-JJDDdc9RMm+PA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 0/9] RDMA/bnxt_re: Driver Debug Enhancements
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, Leon Romanovsky <leon@kernel.org>, 
	linux-rdma@vger.kernel.org, kalesh-anakkur.purayil@broadcom.com, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, abeni@redhat.com, horms@kernel.org, 
	michael.chan@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:41=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Feb 24, 2025 at 02:30:04PM +0530, Selvin Xavier wrote:
> > > I'm aware that you are not keeping objects itself, but their shadow
> > > copy. So if you want, your FW can store these failed objects and you
> > > will retrieve them through existing netdev side (ethtool -w ...).
>
> > FW doesn't have enough memory to backup this info. It needs to
> > be backed up in the host memory and FW has to write it to host memory
> > when an error happens. This is possible in some newer FW versions.
> > But itt is not just the HW context that we are caching here. We need to=
 backup
> > some host side driver/lib info also to correlate with the HW context.
> > We have been debugging issues like this using our Out of box driver
> > and we find it useful to get the context
> > of failure. Some of the internal tools can decode this information and
> > we want to
> > have the same behavior between inbox and Out of Box driver.
>
> Can you run some kind of daemon in userspace to collect this
> information in real time, maybe using fwctl or something instead of
> having the driver capture it?
>

Looking at a real-time log is exactly what we are doing.  We have
support for infrastructure to do that already so just adding this log
would not be too difficult.


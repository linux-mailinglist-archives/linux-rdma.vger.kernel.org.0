Return-Path: <linux-rdma+bounces-4378-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB9A953882
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 18:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF8D1C2380E
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2024 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED30198E78;
	Thu, 15 Aug 2024 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMa7+Qi3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BCD1AC8AE;
	Thu, 15 Aug 2024 16:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740357; cv=none; b=dZk8A5qqxfUfFUBaLx7IgHzaviNSal2t00JYLRFS/v4Fz39jc+5rP6C5jFBJfTI2QvdpcqVdG+x4jZMFuKLzshBPkxZ9adyjhc6Xr3yX4ZK1b27mfeq8TJQ1GWjbnUjujMDfG9M6au9j2g/+RVpnB3M0BGOJ68BXxVcYvuLyWKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740357; c=relaxed/simple;
	bh=REDBmW50O6YwhHm23WAYTS4Q9fYVLztzTKaCDF6GFns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9JLT4brwPLgiPEnROjgK1qYOmjIPXvlqsTgJyZhvUHA0vY2UQ48zAmcl/JOZoVBRTcHqaSdc6kWxZ5dcNXZAGAMgTxjnPCtM6Vr7iKaJocyH3L2UVIQ93wFeSnyG63xo3MJCcqbbF1j6heprRoAAYwJA7+fkX0cHSsK93U6VSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMa7+Qi3; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-49762c3eb85so379466137.0;
        Thu, 15 Aug 2024 09:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723740355; x=1724345155; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wO60qZJRiyX/9Tw0BWLsDPeEetlxOdL32PKm7tD3jiE=;
        b=fMa7+Qi3vyaqmfQUYkO6QZWdPxt7d+x96kr9mpSByHzGmc3k9tYPkNsJ7meirixo48
         SEP0vGCQ4FuL+XNdHS4SK5pl9mvpJyqxO8OWV3rxiaNjZOT71n1qHgRANuYzkr5JPXdG
         cM/FeFczHGYCPlY9MjOGP3qQqv5bHjkiiN22I4sLHwmpO9aD52ACpf0O/PHcyybjpw4C
         uuncnPFD+76Zo5Q0STW44dFVbU8rsJcAnaqJV5LD4n9yZZleXZzU/gouhxsQArtF+dNm
         pVbZOsGcWt6njhAv40srrTozej/SPms2CkyP8rLF3Pl9hEynVoh1o2FsdbTs8H3a00R3
         bnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723740355; x=1724345155;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wO60qZJRiyX/9Tw0BWLsDPeEetlxOdL32PKm7tD3jiE=;
        b=Cob6lHoMteWpr8vKSU1QbIVDNVocvg+NJvTvhItesaubnAKLDPWjZYFOno7zv/70ie
         x/jujQmj31+p+rf64S66gsLfLdo+ykO5YLCfW1pYNa5WdOC9xlZCy/we4lZM7aUpoY0b
         jqtjUlYWbQwu4cF0jOCStgs1CfV7ReMpDblX+fn/e9gklI2XnNLjcV/CQMft7SpzrhRa
         bYj/mJ1QFRIg7oOJZB0gzP4g5L31Z60pY/oadU/gRZ1457kDpLXz3cOtVRTuN6K4puxj
         oO0HwRm3hjpeJh7m2hpWUWibdVfxSZsSKuaI17asOGShLdnTrcAoC/8COIOoPxyj7FZN
         kQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl0n6WEbVSUyNFnz0GfDR/MW6QmqGZqTS3ox8X4IIc0tq5q4q4LRt/tSvkztLysA70raOwfW/hG6IlLdR8BbQ2aajZLc+nQZYqyQLFwMO9nzWAQ9Z5qeHu4Xsm0+FgJIK7rS89DO1Q44E07Zef6psGJS0NIWpaKxNAxFCv4EODOg==
X-Gm-Message-State: AOJu0YzYLAUGWMgwogUzjdNSNMb+IPvOq+QBJgFhe77BmlqdyeGFsPJ3
	s5MNjCsrPZMLItS28SKvNxA0PhwO5X0o+pmDwRv1bfGBwdKWWrsUQxCELu3ptevJI7WnmbUZDFh
	6l/1snIf/vonhbiTDWwM0KwlFRtQ=
X-Google-Smtp-Source: AGHT+IEUTOII+yPKPkY0echDUV5m3666V4BemJlyN9UYsCQ8Ho0IjsNS5ik8uHRlMZp8QJ65wQX6nFC05aVNwx7jEio=
X-Received: by 2002:a05:6102:1609:b0:492:a39c:57d7 with SMTP id
 ada2fe7eead31-4977989b735mr472462137.4.1723740354642; Thu, 15 Aug 2024
 09:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
 <20240730183403.4176544-6-allen.lkml@gmail.com> <20240731190829.50da925d@kernel.org>
 <CAOMdWS+HJfjDpQX1yE+2O3nb1qAkQJC_GSiCjrrAJVrRB5r_rg@mail.gmail.com>
 <20240801175756.71753263@kernel.org> <CAOMdWSKRFXFdi4SF20LH528KcXtxD+OL=HzSh9Gzqy9HCqkUGw@mail.gmail.com>
 <20240805123946.015b383f@kernel.org> <CAOMdWS+=5OVmtez1NPjHTMbYy9br8ciRy8nmsnaFguTKJQiD9g@mail.gmail.com>
 <20240807073752.01bce1d2@kernel.org> <CAOMdWSJF3L+bj-f5yz5BULTHR1rsCV-rr_MK0bobpKgRwuM9kA@mail.gmail.com>
 <20240809203606.69010c5b@kernel.org>
In-Reply-To: <20240809203606.69010c5b@kernel.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 15 Aug 2024 09:45:43 -0700
Message-ID: <CAOMdWSLEWzdzSEzZqhZAMqfG7OtpLPeFGMuUVn1eYt1Pc_YhRA@mail.gmail.com>
Subject: Re: [net-next v3 05/15] net: cavium/liquidio: Convert tasklet API to
 new bottom half workqueue mechanism
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, jes@trained-monkey.org, kda@linux-powerpc.org, 
	cai.huoqing@linux.dev, dougmill@linux.ibm.com, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, 
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, 
	cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com, mlindner@marvell.com, 
	stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com, 
	Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, borisp@nvidia.com, 
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
	louis.peens@corigine.com, richardcochran@gmail.com, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acenic@sunsite.dk, linux-net-drivers@amd.com, netdev@vger.kernel.org, 
	Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"

> > > > In the context of of the driver, the conversion from tasklet_enable()
> > > > to enable_and_queue_work() is correct because the callback function
> > > > associated with the work item is designed to be safe even if there
> > > > is no immediate work to process. The callback function can handle
> > > > being invoked in such situations without causing errors or undesirable
> > > > behavior. This makes the workqueue approach a suitable and safe
> > > > replacement for the current tasklet mechanism, as it provides the
> > > > necessary flexibility and ensures that the work item is properly
> > > > scheduled and executed.
> > >
> > > Fewer words, clearer indication that you read the code would be better
> > > for the reviewer. Like actually call out what in the code makes it safe.
> > >
> > Okay.
> > > Just to be clear -- conversions to enable_and_queue_work() will require
> > > manual inspection in every case.
> >
> > Attempting again.
> >
> > The enable_and_queue_work() only schedules work if it is not already
> > enabled, similar to how tasklet_enable() would only allow a tasklet to run
> > if it had been previously scheduled.
> >
> > In the current driver, where we are attempting conversion, enable_work()
> > checks whether the work is already enabled and only enables it if it
> > was disabled. If no new work is queued, queue_work() won't be called.
> > Hence, the callback is safe even if there's no work.
>
> Hm. Let me give you an example of what I was hoping to see for this
> patch (in addition to your explanation of the API difference):
>
>  The conversion for oct_priv->droq_bh_work should be safe. While
>  the work is per adapter, the callback (octeon_droq_bh()) walks all
>  queues, and for each queue checks whether the oct->io_qmask.oq mask
>  has a bit set. In case of spurious scheduling of the work - none of
>  the bits should be set, making the callback a noop.

Thank you. Really appreciate your patience and help.

Would you prefer a new series/or update this patch with this
additional info and resend it.

Thanks.

-- 
       - Allen


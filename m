Return-Path: <linux-rdma+bounces-2380-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBFF8C1877
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 23:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C1D1C21C9A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 May 2024 21:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1BD12838D;
	Thu,  9 May 2024 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCO5rgmD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B182871;
	Thu,  9 May 2024 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290527; cv=none; b=hsztUcPB1SpqxyMwb3QosdfqJdtsjxJPYPrSUfd2smi6jCCA5ioy2yoB8B07Hc9VCoskEZykdyUI3KLifzv+bJy6uHeeO3oxLihAtIFV+KvcEOFJzOaPwPYB/0sIqvM6OvS0jo9n69mT6b4ivZ2KqjACxTcORv8/KEaZR/9WCb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290527; c=relaxed/simple;
	bh=UwbCOJ+2ltILz7mmNFABnaGxjulRAwqZ+Yv5Bs9oBTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSnqpyvI4P61TSKUKefTYoaYdnrb/m+xhQvs706iy6N1Xp02TougufaiNtfw5ajXl2wpEN8n4CJ6zA418z4HAYvg9spIV8+SuhS6quzVrx22NaL5GDMBtdtIjI02p+uOSQfvn5jTXmR9HSa2ZWWChuJb+kMzy5A0vXftXaqkI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCO5rgmD; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7f82c932858so440804241.0;
        Thu, 09 May 2024 14:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715290524; x=1715895324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Yo3NJl/+D3HjDzk2u86J+UDtYtrXvOHQjT1qCvhfSw=;
        b=bCO5rgmDjNmNHOd4rdDidebbEu/czR20bYwycwbsINCPco/LrDrifnvwC2fF8mKE50
         W5O9GLpC4UCSnHW7JlmMxcYuMF6loqvf7JuNSuXEmhCISPy3v9ge6LMiaf/IIcOxVllU
         FwDNFaYSMAlLTmrCM2zvwpQMJWmWNR+f93WJ5Kh3Cv2EW6hn4FclNpb3lBwm8YJiCM4c
         6G+VfcNhanfiUx1L6IPIysJW+pyrHoGaQBdjUUtkj+tygrOUrrs9pnA7N1yaxkKe5CfI
         yFMOISiNxnShdBV4J3KYTePCaJaBfBZqSVObOPk7k3nyP/Mjbd9gbaSbnUYXOXEX4qP7
         1pLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715290524; x=1715895324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Yo3NJl/+D3HjDzk2u86J+UDtYtrXvOHQjT1qCvhfSw=;
        b=ce736AjipCnN6DYMHYEG+7ExThvf+HH8z1Hiv8C6Wlhc2aWK5zrqhkZj98xaPTR6UQ
         Ih4POQsEhwICU1Xl3xBquzNXml2COxKNROEaDOnh5tqcDDKG/Li3Cxlw7mPzN8Va9xQf
         4cZVttYTjx/gVEuh7UosnI/1fa2jRJg52OKebyZ1PYtx+oJacG1QqbbfCEcpsKg7ttlT
         iik9NInEUmJNYG84CZOl/T3V6cHcKpH89CnO3pqTLEAH7IGKYr3CdvGDXG+c8oGDlafb
         VbAIutaZ/xZSxAdQFEhN0Nx+Pvvv6GP7DwIH0+smcwn1Cgs/kIyTwQ+SrCwLE06HHMeE
         +yZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRSYV9CFgnv+fZ19PJaXvjpxeS2bx36TjEc/VUxF+0eA3mufo6xizqP935TWlGs3HmpQEHMFUSotdv3hLQpT2uEMC0ykDiuFTOcnG79YyTg9s/DgZdfmyzmzsFkV8ho8+MpGa/sWjQRRLvwFB28QCTgc4ec2cRc5NBiL5+PFOtYQ==
X-Gm-Message-State: AOJu0Yx//rQckLpLUTgbqBrozL5CeWbidPqcrWikv5QBGeRDtI8hQ5Wi
	aEhrnv3lRTcaEP1VnRZgS8UWBnKDsHO97P/5J4A6FIL6DfhvH4tDGOiqA95W5gKy3/l2ZnHFVQz
	/1t3mLBJ4HOcGj3mclQKh9hIYF2k=
X-Google-Smtp-Source: AGHT+IEDcACUSM80VSR45ArKgZiWP4c9kqdCth3bLU1kbXd1shP57oMwEOz/0YVPrQ6VzKWJJJR4QpRgtprtu6Wem7s=
X-Received: by 2002:a05:6102:3ece:b0:47e:5c2e:5695 with SMTP id
 ada2fe7eead31-48077e45cc6mr1030292137.23.1715290523779; Thu, 09 May 2024
 14:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507190111.16710-1-apais@linux.microsoft.com>
 <20240507190111.16710-2-apais@linux.microsoft.com> <Zjp/kgBE2ddjV044@shell.armlinux.org.uk>
 <CAOMdWSKfkT4K9MAOn-rL44pycHPhVDj4CtiYkru5y_s0S-sPeQ@mail.gmail.com> <20240508201654.GA2248333@kernel.org>
In-Reply-To: <20240508201654.GA2248333@kernel.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 9 May 2024 14:35:12 -0700
Message-ID: <CAOMdWSJ2vV5gYpEQUCpAco3W9ZKKmmj1LXGzk7kTbAaBmsQknQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] [RFC] ethernet: Convert from tasklet to BH workqueue
To: Simon Horman <horms@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Allen Pais <apais@linux.microsoft.com>, 
	netdev@vger.kernel.org, jes@trained-monkey.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	kda@linux-powerpc.org, cai.huoqing@linux.dev, dougmill@linux.ibm.com, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, 
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, 
	cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com, mlindner@marvell.com, 
	stephen@networkplumber.org, nbd@nbd.name, sean.wang@mediatek.com, 
	Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, borisp@nvidia.com, 
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com, 
	louis.peens@corigine.com, richardcochran@gmail.com, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acenic@sunsite.dk, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org, 
	oss-drivers@corigine.com, linux-net-drivers@amd.com
Content-Type: text/plain; charset="UTF-8"

> > > On Tue, May 07, 2024 at 07:01:11PM +0000, Allen Pais wrote:
> > > > The only generic interface to execute asynchronously in the BH context is
> > > > tasklet; however, it's marked deprecated and has some design flaws. To
> > > > replace tasklets, BH workqueue support was recently added. A BH workqueue
> > > > behaves similarly to regular workqueues except that the queued work items
> > > > are executed in the BH context.
> > > >
> > > > This patch converts drivers/ethernet/* from tasklet to BH workqueue.
> > >
> > > I doubt you're going to get many comments on this patch, being so large
> > > and spread across all drivers. I'm not going to bother trying to edit
> > > this down to something more sensible, I'll just plonk my comment here.
> > >
> > > For the mvpp2 driver, you're only updating a comment - and looking at
> > > it, the comment no longer reflects the code. It doesn't make use of
> > > tasklets at all. That makes the comment wrong whether or not it's
> > > updated. So I suggest rather than doing a search and replace for
> > > "tasklet" to "BH blahblah" (sorry, I don't remember what you replaced
> > > it with) just get rid of that bit of the comment.
> > >
> >
> >  Thank you Russell.
> >
> >  I will get rid of the comment. If it helps, I can create a patch for each
> > driver. We did that in the past, with this series, I thought it would be
> > easier to apply one patch.
>
> Hi Allen and Russell,
>
> My 2c worth:
>
> * In general non bug-fix patches for networking code should be targeted at
>   net-next. This means that they should include net-next in the subject,
>   and be based on that tree.
>
>   Subject: [PATCH net-next] ...
>
> * This series does not appear to apply to net-next
>
> * This series appears to depend on code which is not present in net-next.
>   f.e. disable_work_sync
>
> * The Infiniband patches should probably be submitted separately
>   to the relevant maintainers
>
> * As this patch seems to involve many non-trivial changes
>   it seems to me that it would be best to break it up somehow.
>   To allow proper review.
>
> * Patch-sets for net-next should be limited to 15 patches,
>   so perhaps multiple sequential batches would be a way forwards.
>
> Link: https://docs.kernel.org/process/maintainer-netdev.html

 Thank you very much for taking the time to write back.
Since the patches that are necessary for this series are not in
net-next, I could not target net-next.

 I will wait for the patches to land in net-next, and the v2 will
be broken into multiple smaller sets(per driver).

Thanks.
 Allen


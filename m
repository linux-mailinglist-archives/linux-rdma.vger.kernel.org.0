Return-Path: <linux-rdma+bounces-4138-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87A894373B
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D051C20DE8
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5BD16C87A;
	Wed, 31 Jul 2024 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuWycBef"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F591684AD;
	Wed, 31 Jul 2024 20:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458521; cv=none; b=kvHAbncK3o4N0vbkdaiqPSiPRFqxmEORrntUXxe977Qu348SaflT5anksWhmghyjkGQQdpReZLvsyhGV644datHkcaluFtRYJkTd65BiV76lSkopjBdMrCX/IajGaBmP/tjeDrgby0sZJaQUjMv6aQZPSu64lsAkVwqXvOPo1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458521; c=relaxed/simple;
	bh=7xwx8ld0J2l90yhVopRDkNzKh/x4y6JBekiHZ1M3hKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SF3fvQ5+iGBxps1wfxWkLWpH/N6DsD3RBvKQzQQd24s0I47C2ypgKd/QwfJdYUdzrD1bnRyEkLaUu9F9HfVqLtmIS+PAjYRZQWFWptoxUwGSKgQH4ToDaBNM8/GCw1DEUCcC5Rfww2s5jWlaXJ2qLLB+z3FaL4JRP6w44TGR+hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuWycBef; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-492a8333cb1so1552107137.3;
        Wed, 31 Jul 2024 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722458519; x=1723063319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7xwx8ld0J2l90yhVopRDkNzKh/x4y6JBekiHZ1M3hKA=;
        b=OuWycBefdD58vEFVw3omcfxjLnj7RmxnFk2RPGM+gOj1SfFSbM74+TTlFTIyLfx6xH
         SRCq2eD54uFWiNjirZGK8e1Mn/XtRZMSKQmO1cYRl98D3wj0Is0kMsVN92sBE3ez2XXU
         ZBAz7IPFNJyEy08qGe+zklRcHWto7DgJpcawCdnmGVH8kBZPQvgi2huwulFialjF5P3r
         c/c23jsZVsSQGt+Oe7jdjFGIwOCL35E0lRkONS2qoFYohXrOY2BK17JwukASHArhnzUe
         AxRZeDRMG4kabYs+0vlbWgfNzjAMgDpWmN7dlRNn3YwXzbgVWNGAGjdJATQ+m8u/z/vY
         5VcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458519; x=1723063319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xwx8ld0J2l90yhVopRDkNzKh/x4y6JBekiHZ1M3hKA=;
        b=m49JDXjEvgBiq2v95R16H186ieHlFjnnry480P9Fh2wHG0/gX13vUwzTpn1Jy8g+ir
         Pu4ZAlvKjiKtUfE7RHk0WJT+fSDOndc7Jdlm/lAweO0aew9YWvrXqMPdxCLxv8ged+Lx
         oSJLJIEKI/iW8drG2hzoyA6iXpIJDxUmaqJv/4pGO9+PijcMxI/puhdYc75tU4TeZdQb
         uwDJsXa7hLy+gSVg3lyLldJ26RMrkfn628IyBL51arf9J+UJRkaiwwVHUziSXotprn0c
         79c36fgfEZ9z7jGmwbvNWWH293J6huUn//OCcTsaAKrphyT+7Sp+ftbzlizFcUXt1Bpa
         tJgA==
X-Forwarded-Encrypted: i=1; AJvYcCWiDIRC8gVD+eZcCN1WCNttWGGaIYrNmoLFHgQdjW15VD5acDyGssUJz1FTrwxQyL1QxHuHXPC4eChqD6iC2SGEakeG/has/TqruxjmDCWaf4fNM8IUAm9m6GPJH+qhe7GOD+1ktU/esVEjgLyTgxLfCW4/2/zYdD97sgsA+z7jkQ==
X-Gm-Message-State: AOJu0YzeYjHIC19/CqdGVQpWsCWwvbrcDwp8vA5AwF1+qidbmM2BMiGb
	DBixDqOt0pEry6DGSkSe9UfzvVlPjy/X4Q6zSFagNRNmm1MFbbugP5ijkPeOTDnmx+sa/qbC/vN
	fMrB3ZJ1aqt2sTq5ZVz9ivZxwcgs=
X-Google-Smtp-Source: AGHT+IHcApjBJ2q3BO5jPAxXBWewi8ikoH38BgaDeBX6L4YnH1UAFvGCthljFOnpSQiyZZ3jQgewHemNEnBx38+vh5A=
X-Received: by 2002:a05:6102:304c:b0:48f:95aa:ae2b with SMTP id
 ada2fe7eead31-4945099d090mr667462137.28.1722458518682; Wed, 31 Jul 2024
 13:41:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
 <20240730183403.4176544-15-allen.lkml@gmail.com> <fbb19744-cc77-4541-90b5-0760e0eeae22@lunn.ch>
In-Reply-To: <fbb19744-cc77-4541-90b5-0760e0eeae22@lunn.ch>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 31 Jul 2024 13:41:47 -0700
Message-ID: <CAOMdWS+b0nqK4vuU5+VhZES5EabQzj5P7vtejSy5HNnQt8xeww@mail.gmail.com>
Subject: Re: [net-next v3 14/15] net: marvell: Convert tasklet API to new
 bottom half workqueue mechanism
To: Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	jes@trained-monkey.org, kda@linux-powerpc.org, cai.huoqing@linux.dev, 
	dougmill@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, 
	tlfalcon@linux.ibm.com, cooldavid@cooldavid.org, nbd@nbd.name, 
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	borisp@nvidia.com, bryan.whitehead@microchip.com, 
	UNGLinuxDriver@microchip.com, louis.peens@corigine.com, 
	richardcochran@gmail.com, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk, 
	linux-net-drivers@amd.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > - * Called only from mvpp2_txq_done(), called from mvpp2_tx()
> > - * (migration disabled) and from the TX completion tasklet (migration
> > - * disabled) so using smp_processor_id() is OK.
> > + * Called only from mvpp2_txq_done().
> > + *
> > + * Historically, this function was invoked directly from mvpp2_tx()
> > + * (with migration disabled) and from the bottom half workqueue.
> > + * Verify that the use of smp_processor_id() is still appropriate
> > + * considering the current bottom half workqueue implementation.
>
> What does this mean? You want somebody else to verify this? You are
> potentially breaking this driver?
>

Thanks for providing the review. Apologies for not having worded
this correctly. Russel did ask me to leave it as it was when I first sent out
the series. Perhaps I should do so. Kindly advice.

Thanks,
Allen


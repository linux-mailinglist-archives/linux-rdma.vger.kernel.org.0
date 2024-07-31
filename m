Return-Path: <linux-rdma+bounces-4139-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20593943752
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 22:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3D41F23EDE
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2024 20:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319A14F125;
	Wed, 31 Jul 2024 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP6/X0iF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F165F210EE;
	Wed, 31 Jul 2024 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458781; cv=none; b=Nhu2utHWbtsjoFeGai1Pz52kusMpv2cCzOAUmHta9lbR9M5Zk98nVw99EHtVp7BhsMTvbHNB9D04q4KI0Yvxo08+ig5oNFPwZqUYXcJ8EuH+t8eX3GaCPLreTR8RpYblGh2UVS0DXSHdIjvwDJuaJj4cKhd+dE9HcEoc8BzqaZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458781; c=relaxed/simple;
	bh=0qUeFebIJHT1YnNow9lfN6B2ynMkXLaJz8K2HbYpg+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjU+VkK9IN8+suSGZSGn6m6bnY4K/6U97lSqcF2K+fhbXs07n6A+tllSC+dpFb/ecFB54UOfeLzp7+ZmXaHsEiWlKu67rLsaAdT+zxXYjMs2nBIBJKDWNj5G4Jo7L788bp9Uh+FyiD4bjffTBBtKVx6rODHgQz000v7C7pgYwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lP6/X0iF; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-492a3fe7e72so1711676137.1;
        Wed, 31 Jul 2024 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722458779; x=1723063579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9PcXgHUJK8BDjP6AP1Iza5JMe7uKNZuibkQk76WkYPY=;
        b=lP6/X0iFFPZioAE+qzIFSpwWjcHbDh+4mi2euT33bZFzFPiDwPN7olbWnBbQhrJ2ly
         NkHBuL1wqFC3ur0ecjppWTpDEwvkwKcMnMKGPbhlLYgfS3F2T1WR21cnWwPYTl8UnQdI
         DA24zxNrsGofuI16z7SgN2pm/EGdywDjie5uaYdZSDMxtVrHPUzj1w7rhOpSbSHxLMCb
         kmJ0E1U6g8QLJZ+zMeAInrZHXeF6sRCaCsD5weYhgALxLnQZ+cT/v+MbHGVB2G34oPp1
         yJJIlWMIoglVqf15upqsL6Bhp44JYCxKL4mUDz3o7vIhDx3PxtqcaTKeoZp86FC2+pc0
         LoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458779; x=1723063579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PcXgHUJK8BDjP6AP1Iza5JMe7uKNZuibkQk76WkYPY=;
        b=s5tj+1px6ConLsZHO6ItNkKxcbRWEr7E37zcuDT2m9Vutk1mxeHsT4RMFWIlJ/+koK
         GvR1G0EIsbyLgsMAUpodSN5vlEki4NEjk1fLPyxOvkyyYTBRvnrMgWwJ6jZGp3+UlPLM
         fgLA9PZN1y6OAXq0Jeotc7pvzc11NitGX/iG0uy58ECXrGjo1yL5vOI7w/oeGbB5tkiG
         E/sACRiitBFPRtQxy+gdTClO8b54gHkpDVOlDUazozzYa+aJCvRzVMyrEDqOTssvKEM3
         OlaWRa9XHYWVlfleKDYwq1+TrNHT7u7LLwMIuqQ4OwlM/5WgUXdWNc485iyce/xpaiuA
         oIUw==
X-Forwarded-Encrypted: i=1; AJvYcCV7DDfwVZvCWFcMMiA7jRPhR+XHRB2+nGnXtK2+vd6XI3WfuCvQVXhUbRO9Iejrr4XZ1tXvgwRE1qaOj70aZoX26dMoeBVUwODZOZMy7cLzJ0v1iTEQSQ9VPrdHmrGrzP5j/V1KI4fN0rmgKooSl0TV4TlRFL83p1rXEkZvGM7P0w==
X-Gm-Message-State: AOJu0Yw8U0NTzsSl/ZeSVopWxfSwXn83l80wOrOwZDnwEbj0PTlHWG/l
	ubkanwamxrnamgYECk/laCx4VIC7p/L0YumxX1XN8fUY/UuNCbtGnHdh/oCSM33L7dMxNPvsON8
	HfDMmzEcq31LekJwjB11Zngrcu1I=
X-Google-Smtp-Source: AGHT+IHDJRjjx4Y4OJPy7BaN48m08YHPIE9lnhe1XeHJSvF0oRes+XyuEyDjSsKrOySj2JVw2DSvVC2y7uQrgrJu0n8=
X-Received: by 2002:a05:6102:3f13:b0:48f:39df:2d8e with SMTP id
 ada2fe7eead31-494509843ccmr707924137.19.1722458778772; Wed, 31 Jul 2024
 13:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
 <20240730183403.4176544-15-allen.lkml@gmail.com> <fbb19744-cc77-4541-90b5-0760e0eeae22@lunn.ch>
 <ZqlnwSDCvhrRe32K@shell.armlinux.org.uk>
In-Reply-To: <ZqlnwSDCvhrRe32K@shell.armlinux.org.uk>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 31 Jul 2024 13:46:07 -0700
Message-ID: <CAOMdWSLkra7LwXO=iy+OidZ3fWt5gpXEAteDciMLwcYe0Ox+fA@mail.gmail.com>
Subject: Re: [net-next v3 14/15] net: marvell: Convert tasklet API to new
 bottom half workqueue mechanism
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, kuba@kernel.org, 
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
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

> On Tue, Jul 30, 2024 at 10:39:51PM +0200, Andrew Lunn wrote:
> > > - * Called only from mvpp2_txq_done(), called from mvpp2_tx()
> > > - * (migration disabled) and from the TX completion tasklet (migration
> > > - * disabled) so using smp_processor_id() is OK.
> > > + * Called only from mvpp2_txq_done().
> > > + *
> > > + * Historically, this function was invoked directly from mvpp2_tx()
> > > + * (with migration disabled) and from the bottom half workqueue.
> > > + * Verify that the use of smp_processor_id() is still appropriate
> > > + * considering the current bottom half workqueue implementation.
> >
> > What does this mean? You want somebody else to verify this? You are
> > potentially breaking this driver?
>
> I don't see how, the only thing that's changing in mvpp2 seems to be
> an outdated comment that happens to mention a tasklet, but the
> driver doesn't use tasklets.
>
> Let's look at the original comment which claims what the call sites
> are:
>
> static void mvpp2_txq_done(struct mvpp2_port *port, struct mvpp2_tx_queue *txq,
>                            struct mvpp2_txq_pcpu *txq_pcpu)
> {
> ...
>         tx_done = mvpp2_txq_sent_desc_proc(port, txq);
>
> and that is it. _This_ function is called from several places:
>
> mvpp2_tx_done()
> mvpp2_xdp_finish_tx()
> mvpp2_tx()
>
> So I suppose that the original comment was referring to the
> mvpp2_tx() -> mvpp2_txq_done() -> mvpp2_txq_sent_desc_proc() call path,
> and the others were added over time.

 You are right, I should have checked the calls before modifying the comment.

>
> mvpp2_tx_done() is called from mvpp2_hr_timer_cb(), and yes, back in
> the distant history there was a tasklet here - see:
>
> ecb9f80db23a net/mvpp2: Replace tasklet with softirq hrtimer

 I missed this bit completely,  "historically...." is completely wrong and
misleading.

>
> So, the comment referring to a tasklet was left over from that commit
> and never fixed up.
>
> Given this, I don't think the new paragraph starting "Historically"
> is correct (or even relevant) as I think it misinterprets the original
> comment - and "this function" is ambiguous in it, but either way its
> still wrong.
>
> If we assume that "this function" refers to the one below the comment,
> then this has never been called directly from mvpp2_tx() nor the
> tasklet, and talking about a bottom half workqueue makes no sense
> because "historically" it's never been called from a bottom half
> workqueue.
>
> If we assume that "this function" refers to mvpp2_txq_done(), then
> it's not historical that this was called from mvpp2_tx(), because it
> still is today. And the bit about being called from a bottom half
> workqueue is still false.
>
> Given that bottom half workqueues have absolutely nothing to do with
> this code path, the sentence beginning with "Verify" seems totally
> irrelevant (at least to me.)
>
> So, I think I've comprehensively ripped the new comment to shreds.
> It would be far better to leave the driver alone and not change the
> comment despite it incorrectly referring to a tasklet that has
> already been eliminated (and at least was historically correct),
> rather than the new comment which just seems wrong.

  I am open to leaving the comment as is or completely removing it.
I am open to suggestions, please let me know what would be
the correct thing to do.

Thanks for taking the time out to review and write back.

- Allen

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!



-- 
       - Allen


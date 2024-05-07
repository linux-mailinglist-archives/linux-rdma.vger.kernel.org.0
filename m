Return-Path: <linux-rdma+bounces-2330-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15548BEC92
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 21:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717211F277B5
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 19:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB80116DEC3;
	Tue,  7 May 2024 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFewAg00"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BE16D4E7;
	Tue,  7 May 2024 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715110043; cv=none; b=P4gOlS99uu+4uHAKRuQTTGz3VjUTPa8EhFHrEuwS0RyRpz6FGVxFKWM5G0ghP+x7cS6tkGYikPitKB5PXKxlurkaWApoFaGQdzjXHr1ZzxJ9qA027syl/TCTuX1xwp4qU3Ps63Sagk5Zb9xs+E1Ob1mifvtBZ5fGQU8cCibPvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715110043; c=relaxed/simple;
	bh=jeEx30xO/x9LOb3Dx3gBRF9zT0JbeISVhGFM0Bk3pUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7B1nEpMrtzwmCKr6hkuy/qHTphYdIDdbIZvgJs2MlqMS1QuxaMRRa+Q/kCFGJpcdY5iJ36eIqRUaReS8ORjRJmd2HnI6tmm47IrNzcAa954uH/LUyjvPRDHnU0RlLXrNcA5X5dD3546VoQdVz5ZvMQfL2upTEA69GbBWsjaAT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFewAg00; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4df3ad5520aso1249353e0c.0;
        Tue, 07 May 2024 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715110041; x=1715714841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAc3byTNBsHPa+WdoCVtnwL96sJFYPacjsD1Mg7kFVQ=;
        b=LFewAg00VRBFmXS6C94a7Kp/jKcbCOB5+uexf0NN+R6V19n56nDkkmmyOR/uJRym6U
         xwzIJaYYvolD4HXpWsPGy+TWu6R4RrwXIUKu9BPK9HiynW8OpKvBPYxcCq0gktttO+H0
         bVqrtPYP+SYHx7rzgfXFJOHrzymh3r4mThvNSy3ugl/F2q7RMDSfBzllxFfmbd7FwwTI
         WynC8F4ktAWq3mABm9fR6C7ovrGHD2Dxs+JuZ2YyiQ7+voP5dvQk0s3aHYcDp7IEZ+WJ
         MbQ1DiKnCuocevPM3HonH3j08PK2AeU9ztD3ZEhHlXG3AkVF+gbiRIIhP//XFvMbrjY6
         Unuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715110041; x=1715714841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAc3byTNBsHPa+WdoCVtnwL96sJFYPacjsD1Mg7kFVQ=;
        b=jH/s8rs/4ofJjbfxJVKiluHusFnm/DQzFLEyBSAf6VHDneoWPh+qaJspllTzqbEWTU
         EvbjJquCcDhvw6SUSmsRbp6Vf2hFI9nnDmids1stHjOswT2T8x6uJMkUaEJBusfuOzUD
         hWOIv0cmuAQU0/7rCco6/Vl+m87OFJ5N6hn11Fpvz0rQXJJ49T4p/xYVbj8LL+DBbucj
         AUOrq/QvKPNDmtij/nV0DfDKQqV7z9ZcNo8trgmd2W6RuIgxiVF5NMSc1IpzeZaGepTi
         zQRZWaHoa6s+1mjUP7St+4U1f6wJKA5ENNAu2SPEhYZzOJTWIxpwP2pcpuU++oq7lplW
         x/HQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9pZGwvvj3rEOoifAynXEzl9rb7KcDR5fJOq8Em5VKLVzlbeGxwEs4vB4zZGN8Hd1hO85f/6b7xe3iGNf0ZkIgYmYn8OQBRXqzT+aAeyNum7t0fdeIsq+TAvZEL2VWKopJdF/aWava18GTUUhYzQIS7ELFO151jNKwtpnLBR9SkA==
X-Gm-Message-State: AOJu0YyfFMfk8/u8WE9d6CiaD8dnMhJ/2ES/sdDgHuEuAoXSaHzBX2Xa
	dzu6U82LB/8O6AtWf0l6oISUIKiUsqrKuxCw/28JnsZZBsQlb14XZqtYnuSBxNbqETES66i7SNo
	hVJyUV0gbysZPdsV7f7Ai5yyZtAg=
X-Google-Smtp-Source: AGHT+IFNdkHpD3Gwn20I/Y7Qjqry/oQQapXeMBHaaXt7fkTgoavVUMdoy9nyAnEFQ2HO1nDpfnp2Y4SnJOqaHSWKU1A=
X-Received: by 2002:a05:6122:411b:b0:4df:2b08:f217 with SMTP id
 71dfb90a1353d-4df69181920mr566063e0c.6.1715110041132; Tue, 07 May 2024
 12:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507190111.16710-1-apais@linux.microsoft.com>
 <20240507190111.16710-2-apais@linux.microsoft.com> <Zjp/kgBE2ddjV044@shell.armlinux.org.uk>
In-Reply-To: <Zjp/kgBE2ddjV044@shell.armlinux.org.uk>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 7 May 2024 12:27:10 -0700
Message-ID: <CAOMdWSKfkT4K9MAOn-rL44pycHPhVDj4CtiYkru5y_s0S-sPeQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] [RFC] ethernet: Convert from tasklet to BH workqueue
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Allen Pais <apais@linux.microsoft.com>, netdev@vger.kernel.org, 
	jes@trained-monkey.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, kda@linux-powerpc.org, 
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
	linux-acenic@sunsite.dk, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org, 
	oss-drivers@corigine.com, linux-net-drivers@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 12:23=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Tue, May 07, 2024 at 07:01:11PM +0000, Allen Pais wrote:
> > The only generic interface to execute asynchronously in the BH context =
is
> > tasklet; however, it's marked deprecated and has some design flaws. To
> > replace tasklets, BH workqueue support was recently added. A BH workque=
ue
> > behaves similarly to regular workqueues except that the queued work ite=
ms
> > are executed in the BH context.
> >
> > This patch converts drivers/ethernet/* from tasklet to BH workqueue.
>
> I doubt you're going to get many comments on this patch, being so large
> and spread across all drivers. I'm not going to bother trying to edit
> this down to something more sensible, I'll just plonk my comment here.
>
> For the mvpp2 driver, you're only updating a comment - and looking at
> it, the comment no longer reflects the code. It doesn't make use of
> tasklets at all. That makes the comment wrong whether or not it's
> updated. So I suggest rather than doing a search and replace for
> "tasklet" to "BH blahblah" (sorry, I don't remember what you replaced
> it with) just get rid of that bit of the comment.
>

 Thank you Russell.

 I will get rid of the comment. If it helps, I can create a patch for each
driver. We did that in the past, with this series, I thought it would be
easier to apply one patch.

Thanks,

       - Allen


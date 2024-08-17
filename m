Return-Path: <linux-rdma+bounces-4401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B79BD9558F1
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Aug 2024 18:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717A01F21DA2
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Aug 2024 16:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7EB155300;
	Sat, 17 Aug 2024 16:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnbialIX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFDC14F9CF;
	Sat, 17 Aug 2024 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912048; cv=none; b=jm7RPorkoNkoicx7qKnH20MoTvERm4rjkF84dFX0a1prx4jUdtJx13diH8/82sPKvtntjSEOYNkFombW9yXFStMhjc8kicNZXZXLvtCYCZx/PZYTbW4CGQ815O9ANbMypwmJHny0R+k1zjbH60EBN5n5CPx3Pe/kD13S8lDI0v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912048; c=relaxed/simple;
	bh=M321tqZviLaBwQ05L11bRWv/zf9KkqcTufhMPYAXpIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPacRGe6UMcfojizKqcxdcdmUdGk5RBg9/56tdWfcsbGkbZLhrLRWPrJh+LqB2ZazgdQWNPSDr8EQv1zaXGDJmASaKgL+5gkWK5xTlnP79mqn/C9vDDH1V3Oljg5L5q9XP8FEaMlAmZ8+YnQu8sJLJpPcDhkxQ/pGYLE+laCetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnbialIX; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-842fe6f6c04so809950241.2;
        Sat, 17 Aug 2024 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723912046; x=1724516846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T1A5yMQKgbCZuCbj77O+oxwO97dOiKdh/DiTFn2+/hs=;
        b=cnbialIXQfnEjTae8JIUu7APD5VVkNohOKP28tRDyMoUULCnwNAXHmgd0vVRimU2Ck
         oVTThAIJMeyit3k3i1UeNxvL2YeWfN1JugkvpHP4g5HDEejUr/pN38JKD0h0C63/22Ir
         xRB/o5x2rZIAijmfQfYA17/DO6oNW6Rm7Y7uTZMD2JaOTWVCX6dzmQazU9YVHx3Yw4pv
         DB8l40hS4ZVvp6xztlnfcGGLws8A88jGDLCpx0+v3FjHLqPY/e0L8rK0DdzHH+Qgujg2
         T2ri4CfshzlA4dGC0FoyBWBGZD5yVkO6ceuj6hn8RwY74EMBGEvEdglfDRyPcenLEU2l
         1Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912046; x=1724516846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1A5yMQKgbCZuCbj77O+oxwO97dOiKdh/DiTFn2+/hs=;
        b=vrd/0JaiWIeIfupeWe9KYtmzkfIxM5jYbp+1Ofp2YaR6u7tppIoxNhcbxIFhZ9XlDV
         hRigmaO5YvE6bGY+7rlwRWYv6u0FZxsZahAC7vAcLIQUoBLe1rlaxhxvkmoBrARB5OEo
         TPzehhOAIKXvve3XUxkUSgeMy1yKc2vutZcrXK88fzeuIRVlJxpqlRDFjgpao7MVT5qX
         t7NU/stquBq5HGc+CoUv9KUhkmgIgj6b5TO4e9YC4Q6UZBlkLsV7Iplagj3U61q+iFYu
         QhTvqqzUv1Ry4R3uZGccGqBbnAoTUkEbNnmhFLcB//+/oLvaMb7QN065p/bWvkbj2kUk
         2+eg==
X-Forwarded-Encrypted: i=1; AJvYcCVNJC3dEIhX6ZPACLO+FrwKxXtet+j5PHFRrsxcIDeenjQ+AH9xRLEBgEduHeSMd+/G7tG+EIUkwm7aB2gB/7EpluUEI8V8N0NdGmu3RzN+yMdlqVQTfjJ6t+3I19+kDlS1qyjrixNgT+uHjMPJb1Utz1EVTEkz2TveOirLXQoYZw==
X-Gm-Message-State: AOJu0YxLfCqOfz7mFNiETBZGydK+8nnBNL8MhJnCnx23TNnSS3BwH0bH
	6xEfDZ3DoT+3Cq1ck7WB42Y5F2I07QX4WtUjpkycJHv0Rmvjwv3exB9tNrHKt4TsfxulO7fpODR
	n6mrHww5PM2rJdcsAXTOdoKfRJTc=
X-Google-Smtp-Source: AGHT+IFx0j8ezeKwWu+XpqYMf8JHykePkwdV2Y3dtrWi4k5+xq/d3tJKId26C/oubJUmlDbTay38F1tRYOoR1BkUNGw=
X-Received: by 2002:a05:6102:3749:b0:493:e0cb:7263 with SMTP id
 ada2fe7eead31-497799a66aemr7331522137.29.1723912046305; Sat, 17 Aug 2024
 09:27:26 -0700 (PDT)
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
 <20240809203606.69010c5b@kernel.org> <CAOMdWSLEWzdzSEzZqhZAMqfG7OtpLPeFGMuUVn1eYt1Pc_YhRA@mail.gmail.com>
 <20240815164924.6312eb47@kernel.org>
In-Reply-To: <20240815164924.6312eb47@kernel.org>
From: Allen <allen.lkml@gmail.com>
Date: Sat, 17 Aug 2024 09:27:14 -0700
Message-ID: <CAOMdWSKzh6gAzcQWNO=PWr1oOqf=9dKnhncSgkY5fYcL4nTMdA@mail.gmail.com>
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

> > > Hm. Let me give you an example of what I was hoping to see for this
> > > patch (in addition to your explanation of the API difference):
> > >
> > >  The conversion for oct_priv->droq_bh_work should be safe. While
> > >  the work is per adapter, the callback (octeon_droq_bh()) walks all
> > >  queues, and for each queue checks whether the oct->io_qmask.oq mask
> > >  has a bit set. In case of spurious scheduling of the work - none of
> > >  the bits should be set, making the callback a noop.
> >
> > Thank you. Really appreciate your patience and help.
> >
> > Would you prefer a new series/or update this patch with this
> > additional info and resend it.
>
> Just thinking from the perspective of getting the conversions merged,
> could you send out the drivers/net/ethernet conversions which don't
> include use of enable_and_queue_work() first? Those should be quick
> to review and marge. And then separately if you could send the rest
> with updated commit messages for each case that would be splendid

 Sure, let me send the series again with this driver dropped. We can
revisit drivers with enable_and_queue_work() later.

Thank you.

-- 
       - Allen


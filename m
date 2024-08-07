Return-Path: <linux-rdma+bounces-4232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3182994A7B5
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623031C21AF2
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 12:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375311E672A;
	Wed,  7 Aug 2024 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InALkeYZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971171E2101;
	Wed,  7 Aug 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723033789; cv=none; b=gmjLz8pHQ69fdjveLvpyhqqoZYTup70wQgIbIkGizTKCYRomFtZyWqrJdUIqAPB3NzqeLipFvCfyeKPxUWzq+5h9AIXmaGwTgjgEh9NEucoP3CHztOnpSSsY+tupYuiZ1cBe8YeHym7EZOP4tnV4q1ED9lARNNczNdbWfi+EtOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723033789; c=relaxed/simple;
	bh=pgiw/PXddMIrw7PyP7Ctp5k5rWWWnsIDF+Ip6XS+nU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzoORiD1yz9tT3ci4ojS6G3PoP5o69TTrCXcG82pT891swkeglRd1vt3XIminrliQw3W2VGIluoUm/ZppkMpewdlUIibTlmI+IM+tmjfq5BfBLbSHsj60KcJ+9ZmqajG02lL2AVg0a6PmiJi6LQ7MbTUoNg7kQ5w5bYJuQaEP+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InALkeYZ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ff4568676eso18167975ad.0;
        Wed, 07 Aug 2024 05:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723033787; x=1723638587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx32xTT3Lmjn28QqG28xI58RScq11tK0yTOGRh/oOE4=;
        b=InALkeYZdPu7jCgUElCeuRW7/X+R2krN6fMJH1gEVVsB4UbInj2c0Ooarc6fN/k8kT
         ievk/lYeMiUhSnFjtq95iG5YMMJdslV66z1UhXW2s/2zVZ0zOwYpnf3706VEHtyUHWfv
         kcongexK6KJxH2NXVnLNhRPoPS4Vefe9fGl/Jtxm7RmrISF02ThK9/0U3ciltXsBsv34
         kQRcC8JrARXadCNmLanmPKcvX5RsBajVkOpjqXSP+nkFBXhqnA21g7NtiR69Uxnvqgfe
         BszFKuqyaZzbp5H3eaRDeLm1pZR4u1fJltd41WhCyVRM7GeEKbUF4T54smQiVMufSdD8
         lAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723033787; x=1723638587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kx32xTT3Lmjn28QqG28xI58RScq11tK0yTOGRh/oOE4=;
        b=dYaYB9tsDZMnUYEr2Zn1rBpLaIUDm3SQcms18AUNb+t4BmtRygAm34TSQ5ADdHIZfv
         7JbGWDNGqh5fMyUruvdNVwCpADdHW1xkpspC7Sj0wFAbmd0S43J3U+qF6Nfq9IquJ4oJ
         G9S3AdE1xiGXoI6XabmOoT+oNkLGuj2UI08mi2bY4JFIll1I94uO/pOIH8++KsSPCQvF
         NAIEzzqhyQNzgSKoSLIwIY7PJfotoVIAE8bimmQLdQNyQfHsCELmTUHWHvicCeOCsSUg
         ayPwFZLB6heBDkYFfDFhmoVlZdqr/fNSNXZIZO/nkslPllT05OTrKv6x+fSyqoUY/2SL
         Yw5w==
X-Forwarded-Encrypted: i=1; AJvYcCW8Pyla9kVCKpvfKinCIe7OwyKSGaKmR2P/BnEI8xXZsDtI/6FPmdzrSq1eu/AvRdutV7OybMtJMf86addMoOGp3dtJscYXwSGnepnQ9EdPiva/OlqCwcooKwmjOxvJBmEiBXuA0sd1b0RLrf1YX4iOjlb4jAffpVz6ZWRD5D5mMXiTRFKjI+0QmnVMPFZ3wbHgo1hJuBn15XeXMg==
X-Gm-Message-State: AOJu0YxCV01I5As8SLNZieWb0JM8BSnXPIR4YpwQvjSQxQAfDgFxl4vc
	NIjTLNUYMjJESwKprCWoxWM/bcwCmgl4iaVtUSKRXF8ULiXgAnvweg+Ajf7To1BVChgAefpto2w
	50daulzASN3fXqoJ/7iJ/+q9a2AA=
X-Google-Smtp-Source: AGHT+IHX/Io8BGEe/ckylAL2OpQEtD0KNkWtQjYnygkiTok5unepYcDXoXJVkqfRWDMR5n7NAPzxYbxjWVzJl5nWASc=
X-Received: by 2002:a17:903:41d2:b0:1fd:9d0c:9996 with SMTP id
 d9443c01a7336-1ff572d4738mr263854185ad.35.1723033786674; Wed, 07 Aug 2024
 05:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806193622.GA74589@bhelgaas> <20240807084348.12304-1-mattc@purestorage.com>
 <alpine.DEB.2.21.2408070956520.61955@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2408070956520.61955@angie.orcam.me.uk>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 7 Aug 2024 22:29:35 +1000
Message-ID: <CAOSf1CHo66dxmChrx97+tfKSE=JM_NzrgdUF_Y4kFabnu3qotQ@mail.gmail.com>
Subject: Re: PCI: Work around PCIe link training failures
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Matthew W Carlis <mattc@purestorage.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, mahesh@linux.ibm.com, edumazet@google.com, 
	sr@denx.de, leon@kernel.org, linux-rdma@vger.kernel.org, helgaas@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, Jim Wilson <wilson@tuliptree.org>, 
	linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, alex.williamson@redhat.com, 
	Bjorn Helgaas <bhelgaas@google.com>, mika.westerberg@linux.intel.com, 
	david.abdurachmanov@gmail.com, saeedm@nvidia.com, 
	linux-kernel@vger.kernel.org, lukas@wunner.de, netdev@vger.kernel.org, 
	pali@kernel.org, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 9:14=E2=80=AFPM Maciej W. Rozycki <macro@orcam.me.uk=
> wrote:
>
> On Wed, 7 Aug 2024, Matthew W Carlis wrote:
>
> > > it does seem like this series made wASMedia ASM2824 work better but
> > > caused regressions elsewhere, so maybe we just need to accept that
> > > ASM2824 is slightly broken and doesn't work as well as it should.
> >
> > One of my colleagues challenged me to provide a more concrete example
> > where the change will cause problems. One such configuration would be n=
ot
> > implementing the Power Controller Control in the Slot Capabilities Regi=
ster.
> > Then, Powering off the slot via out-of-band interfaces would result in =
the
> > kernel forcing the DSP to Gen1 100% of the time as far as I can tell.
> > The aspect of this force to Gen1 that is the most concerning to my team=
 is
> > that it isn't cleaned up even if we replaced the EP with some other EP.
>
>  Why does that happen?
>
>  For the quirk to trigger, the link has to be down and there has to be th=
e
> LBMS Link Status bit set from link management events as per the PCIe spec
> while the link was previously up, and then both of that while rescanning
> the PCIe device in question, so there's a lot of conditions to meet.  Is
> it the case that in your setup there is no device at this point, but one
> gets plugged in later?

My read was that Matt is essentially doing a surprise hot-unplug by
removing power to the card without notifying the OS. I thought the
LBMS bit wouldn't be set in that case since the link goes down rather
than changes speed, but the spec is a little vague and that appears to
be happening in Matt's testing. It might be worth disabling the
workaround if the port has the surprise hotplug capability bit set.
It's fairly common for ports on NVMe drive backplanes to have it set
and a lot of people would be unhappy about those being forced to Gen 1
by accident.


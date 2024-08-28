Return-Path: <linux-rdma+bounces-4618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6135E962A9E
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 16:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC928193B
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 14:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAA719AD4F;
	Wed, 28 Aug 2024 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAa4Y3K5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92118786F
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856277; cv=none; b=j1K/5/nY/Yj1PRyzF/Mge0yiz1KBteIXkHNbm1EB6nilddXeiEzTQiMAHXT+K/E37AlpymxAQfVddjVMzsAYOF8qfzbgVGTojmoEaCZy7siLXj281xvy4SdXajOmS4SwXM5VpHCzpztejsNemRyrv1FgjupC+ALq1TANQCbVsrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856277; c=relaxed/simple;
	bh=ZgCnA1wzmUTqIfZB4aA6IVpXt84nvAyujTifgpPipX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKEsAb0IGagKV2ARBxCquL4m25WPNXMymoaG/MFPOTGX/nrG94E3MxGLOlLir7bfaLr3ljOhH5qjmh6NLSmvF2xFOG6x4uPrYG0xSyiiHU5jHPfnDJATgGvvCqYa2BB+k4NTRmuMh5amaVxZpo5PwtzmU2QYXROvJokd8ME/cvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hAa4Y3K5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso7488993a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 07:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724856274; x=1725461074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lMLlBkF+X0UAPxanGoW9c0nX9urIpDu3ChZAc+aocJQ=;
        b=hAa4Y3K5OlrZ3r8zpig5lk81HpCxzQefP2siva8lxI6JI8SCkoxqFCIYqgYS2y0Ni7
         JlB+fwywqkBXd+HaFUxo5X8skmy4MyfZvNwt1o9TR1iVG8G9+mYnkJnSnNYa0Dh3cy0X
         JN5nkO9VhY1Ihyqv2tYHUygkvDFOJdvTelysBH/wBF3F2ssv6MlVOwuKukWgx/sppKd5
         CxhWjJdZMzRv0rdcWlSJyF+RlTJhhg+HiPoi2GrwacpluKgaS2G3ARTxxxxCGUkCBDAj
         tgBlQxM7b1uPI6Rp85VpU1/zx++rXEiFw0/lc5OdItMu606wceNpAbtbfmnaAbQ2Qum2
         D2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724856274; x=1725461074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMLlBkF+X0UAPxanGoW9c0nX9urIpDu3ChZAc+aocJQ=;
        b=bkFvlXTxquWEOq7MIU78wye5+yyxI6yre5Gr1F/fr+w1nadyT1xM066Cbo+QU2e1vV
         R285z2sfUyEuuQ2tGx21iuEcinDNI3tmwg9KkoOPvXV06ERZNANHTzm2zcyOfHs1c7pG
         bpkzRpGk0sHQmSSlWwFmIVOz8+srxW7Qv99UmOzBimLmPWJ40z+7lXAOxo/HZXhnFOK6
         i+9Dg5PRChIIwWAQj8B3qZTdT7DSyy1iXCyOHdlu3HzTGw228i2iEf19n5tN/ZLjCokS
         nPwrZfDK+oJ+7YqVXTfdwE9JMVvCoSFNyYhGEbzss3BFt9iZX026Ix9FDGJcHusJlpfb
         j4qA==
X-Forwarded-Encrypted: i=1; AJvYcCX5b/OLdDOkTqetzw6nu7ZtRtiayqxIiBWEbxwwvOPlKmLuXbbXsOWcOlkp3zgT/PLvXgSHFPbDj+JC@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJg6xhY3j7Tw8LsNc8eEwRquEICF1oVp2ncvG1p+4DdJSNE7q
	KXLZE0y+PWTnEo/qvVWXf1fVg6v//6gwbnK2SVQWSo+7Iq8w2TLri0uOa7xunVEAQkOQHRal++N
	Pyr/b7qgajfSt4KBeHDaWtl+3DJtnhoymLXP5Im4WpDs8W69ofYE=
X-Google-Smtp-Source: AGHT+IFyk+kTCokuzymxTU65XxPFz/vqgoNyY1mR7t2DlQeQBZFZM1TpBaM2aM+FQZ0SjV1YJL3xTSbiwMEn0Dbf5y4=
X-Received: by 2002:a05:6402:50c9:b0:5be:f2fa:5ee9 with SMTP id
 4fb4d7f45d1cf-5c213dc01aemr1718052a12.15.1724856273744; Wed, 28 Aug 2024
 07:44:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <133c1301-dd19-4cce-82dc-3e8ee145c594@cornelisnetworks.com>
 <842aef7f-d6e1-490a-97b9-163287ddfe2d@cornelisnetworks.com>
 <CANLsYkx2OThcBjs1Qn_Bgd0LE1+EN7c0Dh7NE=1dEBB4xqS9cQ@mail.gmail.com> <59cd0c1c-b5a0-471a-810d-65d42b021760@cornelisnetworks.com>
In-Reply-To: <59cd0c1c-b5a0-471a-810d-65d42b021760@cornelisnetworks.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 28 Aug 2024 08:44:22 -0600
Message-ID: <CANLsYkwPoLsvLgJu+MqfZsVna_nxyx6BnkSFBrmpbxMC0sv_fw@mail.gmail.com>
Subject: Re: Using RPMSG to communicate between host and guest drivers
To: Doug Miller <doug.miller@cornelisnetworks.com>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	linux-remoteproc@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	OFED mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Aug 2024 at 11:22, Doug Miller
<doug.miller@cornelisnetworks.com> wrote:
>
> On 8/26/2024 11:50 AM, Mathieu Poirier wrote:
> > Apologies for the late reply - this got lost in the vacation email backlog.
> >
> > On Mon, 26 Aug 2024 at 10:27, Dennis Dalessandro
> > <dennis.dalessandro@cornelisnetworks.com> wrote:
> >> On 7/31/24 4:02 PM, Doug Miller wrote:
> >>> I am working on SR-IOV support for a new adapter which has shared
> >>> resources between the PF and VFs and requires an out-of-band (outside
> > It would have been a good idea to let people know what "PF" and "VF"
> > means to avoid confusion.
> "PF" refers to the Physical Function of the PCI adapter - that which
> exists always, regardless of whether SR-IOV is active. The "VF" refers
> to the virtual function(s) that are created when SR-IOV is enabled and
> configured. Typically, the VFs and the PF are assigned to different OS
> instances running in different VMs. So, the OS that owns the PF needs to
> be able to handle resource requests from the OSes that own the VFs (and
> also send notifications).

Thank you for the clarification.

> >
> >>> the adapter) communication mechanism to manage those resources. I have
> >>> been looking at RPMSG as a mechanism to communicate between the driver
> >>> on a guest (VM) and the driver on the host OS (which "owns" the
> >>> resources). It appears to me that virtio is intended for communication
> >>> between guests and host, and RPMSG over virtio is what I want to use.
> >>>
> > Virtio is definitely the standard way to convey information between a
> > host and a guest.  You can specify as many virtqueues as needed
> > (in-band and out-of-band) and it is widely supported.  What
> > information is conveyed by the virtqueues and how it gets conveyed is
> > entirely up to the use case.  Have a look at the specification of
> > existing virtio drivers to get a better idea [1].  If the driver you
> > are working with hasn't been standardised, I highly encourage you to
> > submit a draft for it.  If it has then add to the current
> > specification.
> >
> > All that said, you could use RPMSG as the protocol that runs on top of
> > the virtqueues - that should be fairly easy to do.
> I had initially started looking at using virtio directly, but it looked
> like I was going to have to get a new device ID defined upstream and it
> would be a significant effort compared to using an existing facility. I
> then saw device ID VIRTIO_ID_RPMSG, which appears to be exactly what
> we'd have to create if we were defining a new virtio device for what we
> need. However, the problem has been understanding how to write code to
> provide the rpmsg "device" side. There does not appear to be any
> documentation and there is no example code to follow. It seems that the
> device side is typically contained in a GPU or accelerator, which was
> not written for a Linux kernel. So I have many questions on how (and
> when) to use the interfaces (rpmsg_register_device,
> rpmsg_create_channel, rpmsg_create_ept, rpmsg_find_device, ...).

VIRTIO_ID_RPMSG is a special case - it was defined to establish a
communication channel between a main processor (typically a cortex-A)
and a remote processor, something like a M4 or an R5F.  As such it is
typically used in conjunction with the "remoteproc" subsystem.  The
device side you are looking for is part of the openAMP library [1].  I
am not aware of an implementation of a virtio device that would use
VIRTIO_ID_RPMSG in a MMIO area or a PCI config space to instantiate a
generic message passing interface.

[1]. https://github.com/OpenAMP/open-amp

> >
> > Thanks,
> > Mathieu
> >
> > [1]. https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html
> >
> >>> Can anyone confirm that RPMSG is capable of doing what we need? If so,
> >>> I'll need some help figuring out how to use that from kernel device
> >>> drivers (I've not been able to find any examples of doing the
> >>> service/device side). If not, is there some other facility that is
> >>> better suited?
> >> Hi Bjorn and Mathieu, any advice here for Doug? Adding linux-rdma folks as that
> >> is where this will eventually target.
> >>
> >> -Denny
> >>
>
> External recipient


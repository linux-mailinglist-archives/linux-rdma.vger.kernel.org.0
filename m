Return-Path: <linux-rdma+bounces-4008-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122F093CF40
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 10:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE082837E5
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jul 2024 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70E7176AD2;
	Fri, 26 Jul 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV0tk0Fc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295021741FB;
	Fri, 26 Jul 2024 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981108; cv=none; b=Xkk3JHq25YQ3RVQ9a6nuqRI2viQb/Poj5gXAITb7CNcsXTVy83DmRoeZ+zIhZ7nmMdYFFtckFmdNy+pcc8X2f6Iop3vrjgXDO+y/9XP8nw5dItu69Uq/FfQMdd/OBVXJNj39kG4EBLV1QltUyOPdmN6rnKPO8DJd6uCbCezzwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981108; c=relaxed/simple;
	bh=GfulG0t9WbtzwIHjpbSdV8fiy8kLPHEJcxxQ+VKbRbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nC6ATyCf/AXAdpvFHdcNx7H8pJEoBv1JhwH9Ig5JTAaDoq62kPkrExNC7tO8fK0HTcK/jI93jyLYl44kDiDvcwlR4v6M9pmNg1a8gAqHVxw0Ps5ROZFb9hLGJVu6tQLUKgjNFdOENCn6JAXH5hmh3LDi0ikVXdEtp6sk+mSu3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV0tk0Fc; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4928da539c3so520206137.1;
        Fri, 26 Jul 2024 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721981106; x=1722585906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfulG0t9WbtzwIHjpbSdV8fiy8kLPHEJcxxQ+VKbRbk=;
        b=CV0tk0FcDzvYWxhscQWOesk5WFKWSlCKysNG7yFoqJdOKvbh90r2h0UoP7k1FzttTP
         t+GPcKaln1EC9frVbpIG/ucfSPaywkKG1+Qe/rPWREmTPe1ExFDgrgoF9OjAJMKdsDVm
         kh1yHs94NntUJx3Nqb8ggbtbQMCbakOT9gt/IFSHT+jDsk6UN3zrPBNyZCRpCeOKzEiY
         v0BqrmELHj+2jl8cjmYYHxnMuNrc5abIhS/qESGpJNlF5FWwLzTVN9MyV9tMyI4qWn5y
         tMOVMIPm0t6VSnTjjG8vA5kL6mkJ8b+MeCuyZ+wuc94Ol4DsIeQClnnfeKx87KPFCDJp
         RUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721981106; x=1722585906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfulG0t9WbtzwIHjpbSdV8fiy8kLPHEJcxxQ+VKbRbk=;
        b=l8KcxayddFfYvPYSGrWeV+VywJFAeOa0ra2qI2aGz/4F/MFvKJXhlsXIQJw4xtalw6
         8xIf+ohd7cKKqB1xOsHy8PvdYm6GwbhPdQel3epd4y+zD+126Q9Pl520J4xesVZ/MEV+
         PdglNNvzlBrztR75zDhNzR0o6IIopbQC2xM4b5p9R2kBtfluZ9redH8rM7n0oCiL7dVS
         K1s+GMJed2OUotCpRPjkA680hJdFhuWI7l5YG4uSia46bjXg/3BeIKDrZKYQ8jD8YunL
         E/XudmHZAvuLxg+WcMivyBC8C7qmH7s8vviuwlB0gjFB1RXCVfldYJHSfYWm4y9qzlF1
         F9AA==
X-Forwarded-Encrypted: i=1; AJvYcCWZGS2hROEnairOSDplXyTkxs59JZf8DzfjlwUKCfAu2Pit9arwnWP6wE/y51Ac0vg0K3gV9uMm4qjS59k/hrsu177XCdHuRseH9KHulQaVwoxC1My9TZCaZfwXTcrGjMthiT5JRvP6gGjFBEKa00R1uJgeWXRJ0T2mQSjvkQ==
X-Gm-Message-State: AOJu0YxOoVxOFyVwEX+3TDLJWYpAVMp2e8QcPDJJLsbpWIl9ndeU+b/2
	nHXPdwil+zR0EBePkdd3tTKCxsOyJ7cI9gwMnGGUzdFCLMJKdioDe7UriUIpzbygEnPOQVREnrj
	hoF/wDOHEvWqvY+JNcpKakpVsdU0=
X-Google-Smtp-Source: AGHT+IER20+OH20FeNofjZbNSg5YSO4uu2dsN1XaOxb4vENmdqxfMdxAVIy8F71gyOTt7gr/ZbKk6MdsE0ObKrXjlQk=
X-Received: by 2002:a67:e708:0:b0:48f:4778:9299 with SMTP id
 ada2fe7eead31-493d9b6d27emr5949947137.28.1721981106078; Fri, 26 Jul 2024
 01:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm> <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com> <a75782218f34ae3cff725cbcfb321527f6aa2e14.camel@HansenPartnership.com>
 <20240725193125.GD14252@pendragon.ideasonboard.com> <20240725194314.GS3371438@nvidia.com>
 <20240725200703.GG14252@pendragon.ideasonboard.com>
In-Reply-To: <20240725200703.GG14252@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Fri, 26 Jul 2024 10:04:48 +0200
Message-ID: <CAPybu_0C44q+d33LN8yKGSyv6HKBMPNy0AG4LkCOqxc87w3WrQ@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Jiri Kosina <jikos@kernel.org>, Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent

On Thu, Jul 25, 2024 at 10:07=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Jason,
>
> On Thu, Jul 25, 2024 at 04:43:14PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 25, 2024 at 10:31:25PM +0300, Laurent Pinchart wrote:
> >
> > > I don't think those are necessarily relevant examples, as far as devi=
ce
> > > pass-through goes. Vendors have many times reverted to proprietary wa=
ys,
> > > and they still do, at least in the areas of the kernel I'm most activ=
e
> > > in. I've seen first hand a large SoC vendor very close to opening a
> > > significant part of their camera stack and changing their mind at the
> > > last minute when they heard they could possibly merge their code thro=
ugh
> > > a different subsystem with a pass-through blank cheque.
> >
> > If someone came with a fully open source framework for (say) some
> > camera,
>
> We have such a framework, it's called libcamera :-) Multiple vendors are
> already collaborating.
>
> > with a passthrough kernel driver design, would you reject it
> > soley because it is passthrough based and you are scared that
> > something else will use it to do something not open source?
>
> It depends what "passthrough kernel driver design" means. If it means
> accessing the PCI registers directly from userspace, yes. That's what X
> used to do before KMS, and I'm glad it's now a distant past.


Nobody has suggested giving PCI register access to userspace.


>
> If it means a kernel driver that takes the majority of its runtime
> parameters from a buffer blob assembled by userspace, while controlling
> clocks, power domains and performing basic validation in kernelspace,
> then I've already acked multiple drivers with such a design, exactly
> because they have open-source userspace that doesn't try to keep many
> device features proprietary and usable by closed-source userspace only.

If that was an option we would not be having this discussion.

Vendors cannot have vendor access in v4l2.
"""
It is not an option to upstream a driver that has support for
undocumented closed features. Basically maintainers can't put their
name on something that contains unverifiable (for them) and unusable
(by all except the vendor) features.
"""
https://linuxtv.org/news.php?entry=3D2022-11-14-1.hverkuil


>
> > I wouldn't agree with that position, I think denying users useful open
> > source solutions out of fear is not what Linux should be doing.
>
> --
> Regards,
>
> Laurent Pinchart
>


--
Ricardo Ribalda


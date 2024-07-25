Return-Path: <linux-rdma+bounces-3976-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AC693BF16
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 11:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA2E1C20F0E
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA429197A6A;
	Thu, 25 Jul 2024 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGeFiqhV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F4116C690;
	Thu, 25 Jul 2024 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899618; cv=none; b=noqy2x+klKuz8DMZz3uRUCaaEWr7uFWdIAtROsbcdklDkbAft6+1ya4hdIFCt+Ogurh2j9P6cZOs9/eoepMrtjxX8GFkwxL0YfaTnlIoWauwtHI1vQp4E3SS7rXEqNYtIXS6guiP7lm2sC2HuVEyro/qPeO/lp7X8F9xR4MRLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899618; c=relaxed/simple;
	bh=GxfeIqEMhSlZx5VfQdJ/o64sqUdkOvLZVRFcbIn5WlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWCAIqkfk5S1nQyyhesa34OsjDr4M6cDVO60HTD8iP0ij1s5T2b9ej5p/XMWs1VFEPD5VqsXXogQ67n62Py/77r01VNpfTHtPNDi2LYItpc0mROSbtbr96tUrQgmmlrLmWtO+8Tvx0q56vfnjSU7Q4e58MInR6pphKGOAslNxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGeFiqhV; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4f6b7250d6dso298396e0c.0;
        Thu, 25 Jul 2024 02:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721899616; x=1722504416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxfeIqEMhSlZx5VfQdJ/o64sqUdkOvLZVRFcbIn5WlU=;
        b=QGeFiqhVN/cqIDa8QlUXkQ1LryQ81aFltyuaA5eAKCe4mEDA/VCWfFtsKOI8KHPAqk
         8o5rozg2ZDhAbMdLWLW4+Nfa3lXAvVsvT2HrT7M8tYXEsxVGpITCWzNr0yMex9ngUMB+
         nSRq0kVzMbMATFWVx4WP968WkW4JFBZxtURG/hED4T8ZunNVd1+HW3L/2fEtEniTglAK
         XWLElVlhTw/bWt5nou6+09qS1RG/P49ugqy3xI7k/uQVMLLXkS4xkbp5f28yf9QxbY8s
         FyS1PzBoJC0PlDAmYaVMQEVzzXP+6yq2F6eHP7h9eJ3NEHB5WRCmhwZsFueImgD1omAi
         Yw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721899616; x=1722504416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxfeIqEMhSlZx5VfQdJ/o64sqUdkOvLZVRFcbIn5WlU=;
        b=oC+4WP72Hu+i+WDr0MNSeZO6EjY/oM3q29x4YS/GgWC9N+sKULsWtEse2Rss63YCnI
         htSG7D2qL8RCIaquH4e2MewEmnhckDNso3YJdHeZkDRN2ePdeoBL3jT9kLe+be2i3xmD
         RLSPs2Dj1jMvjhk/lY1yaz/ezCU4GrIW+uQf/tHIKfWFKEAZw+KrTG4hxDigRoFQ7e25
         4B5vzTpGTjIcNvkFqLsdr/PUsQpChHpsAS0bu2n9HlF7ZJOztqBx5eYy1teXRVVRmDqg
         QyscosXmKxEdy7Yczr3MLw7XWjBdDw3tFT+8HFKjZLuk8YoYVcY7vmgF8qpn2Qmhf9MB
         /QfA==
X-Forwarded-Encrypted: i=1; AJvYcCVPEPUm23/bXcK/ckRGs4IDiVW056EWpmMpiJbIUqzeVa4eWnbcZUUXHoaTGgrLTpobXVBQ3I0hsZeBffKAJh/TvqBN6ZaeQqqeJSF+hErNX5zL3yJ2kmvJ/Oj4OeNesRxTuWe4laJHcikzCFHrNSmjAhVzykUtB/napBHwHA==
X-Gm-Message-State: AOJu0YzsOYwngl2mrEdKOr8yTLswVSPpmJFMX5kLrYl1tnZa/2LI6eQl
	6CwzXKGsNjFsBU0viZA2mN9u8N3T7WgX7AaLPH1H2ttxuZrF1sQrOEgjyB8c4yb/0PDrGDxhoBM
	1mCKjN/te7EY7FeqLcy96ER+Famg=
X-Google-Smtp-Source: AGHT+IGbHyep8xJMWEks+3bmG2i9KzcJWzZdjHeXmEmYSyDNJX/F+ls2Zg1ZbMJP/MznJjE1fg7/QYQz9ZGxRYkjnbg=
X-Received: by 2002:a05:6102:5709:b0:492:ad30:b6e8 with SMTP id
 ada2fe7eead31-493d9a83cc7mr1593183137.3.1721899615871; Thu, 25 Jul 2024
 02:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <nycvar.YFH.7.76.2407231320210.11380@cbobk.fhfr.pm> <1e82a5c97e915144e01dd65575929c15bc0db397.camel@HansenPartnership.com>
 <20240724200012.GA23293@pendragon.ideasonboard.com>
In-Reply-To: <20240724200012.GA23293@pendragon.ideasonboard.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Thu, 25 Jul 2024 11:26:38 +0200
Message-ID: <CAPybu_0SN7m=m=+z5hu_4M+STGh2t0J-hFEmtDTgx6fYWKzk3A@mail.gmail.com>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Jiri Kosina <jikos@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:02=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

>
> While "userspace drivers" often cause allergic reactions, I think I
> won't cause a controversy if I say that we are all used to them in
> certain areas. My heart rate will increase if someone proposes replacing
> a USB webcam driver with a libusb-based solution, but I don't lose sleep
> over the fact that my GPU is mostly controlled by code in Mesa.

I think the key point here is that USB webcams follow a standard, and
GPUs don't.


>
> What I get from the discussions I've followed or partcipated in over the
> years is that the main worry of free software communities is being
> forced to use closed-source userspace components, whether that would be
> to make the device usable at all, or to achieve decent level of
> performance or full feature set. We've been through years of mostly
> closed-source GPU support, of printer "windrivers", and quite a few
> other horrors. The good news is that we've so far overcome lots (most)
> of those challenges. Reverse engineering projects paid off, and so did
> working hand-in-hand with industry actors in multiple ways (both openly
> and behind the scenes). One could then legitimately ask why we're still
> scared.


It would be great to define what are the free software communities
here. Distros and final users are also "free software communities" and
they do not care about niche use cases covered by proprietary
software.
They only care (and should care) about normal workflows.


>
> I can't fully answer that question, but there are two points that I
> think are relevant. Note that due to my background and experience, this
> will be heavily biased towards consumer and embedded hardware, not data
> centre-grade devices. Some technologies from the latter however have a
> tendency to migrate to the former over time, so the distinction isn't
> necessarily as relevant as one may consider.
>
> The first point is that hardware gets more complicated over time, and in
> some markets there's also an increase in the number of vendors and
> devices. There's a perceived (whether true or not) danger that we won't
> be able to keep up with just reverse engineering and a development model
> relying on hobyists. Getting vendors involved is important if we want to
> scale.

If we want vendors involved, we need to build an ecosystem where they
feel invited.

We should not take as hostages our users and impose rules on how they
should build or even sell their product.

>
> Second, I think there's a fear of regression. For some categories of
> devices, we have made slow but real progress to try and convince the
> industry to be more open. This sometimes took a decade of work,
> patiently building bridges and creating ecosystems brick by brick. Some
> of those ecosystems are sturdy, some not so. Giving pass-through a blank
> check will likely have very different effects in different areas. I
> don't personally believe it will shatter everything, but I'm convinced
> it carries risk in areas where cooperation with vendors is in its
> infancy or is fragile for any other reason.

We control what is accepted and what is not. We just need clear rules,
to avoid regressions like:
- For areas where there is a standard (NVME, UVC,...) most of the
drivers must be in-kernel, and use generic system calls.
- For areas with no standard, custom system calls are allowed, and
some part of the driver can be in userspace.
- To land a driver, there must be a full open source stack capable of
using it for standard use cases.
- If there is an established open source stack (mesa, openVINO,
libcamera...), the open source stack must be based on it.
- Vendor passthrough mechanisms are allowed for niche use cases or
development/experimentation.

I believe those rules are already in place in some subsystems. We just
have to agree what rules should apply to all the kernel by policy.

We can agree that this kind of discussion is done better face to face.

Regards!



>
> Finally, let's not forget that pass-through APIs are not an all or
> nothing option. To cite that example only, DRM requires GPU drivers to
> have an open-source userspace implementation to merge the kernel driver,
> and the same subsystems strongly pushes for API standardization for
> display controllers. We can set different rules for different cases.
>
> --
> Regards,
>
> Laurent Pinchart
>


--
Ricardo Ribalda


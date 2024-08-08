Return-Path: <linux-rdma+bounces-4257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67F94C73F
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 01:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90637B24076
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Aug 2024 23:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB2415F404;
	Thu,  8 Aug 2024 23:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTcS92UO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555E15F316;
	Thu,  8 Aug 2024 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158846; cv=none; b=QjVMI2FlKO+dCxjtSLeYOFQWJzo7bRDVMAWzHx2k8fTN1WTCFCZbu17wKXYUin/QGfaWzzCyBkRG4iXHqlxCWNrCDMrDJed/Fm475VTYo+T1ecQjlOc7jxJyBMgMbx3KYF363ab1zwGGw7rZALqmM8koPan9aTQ2GXlmd1W1ydA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158846; c=relaxed/simple;
	bh=SzxAnNd+2P5RagrV70uSTDmukSTtgzZlqgxHDGW9DCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=STjUEbfLZgf22jP5Muc69a23hn6FEK6KPfYa0tcgm4wEGsV6bhBaZfbDFvxg7huUt6ouqO8LEJAQjIAGrG4c2YOG6JplaG11k5OL3ioLKoPgUn498Gd3qV4CvT5dW/s4fi8n1H94bu9BRDt0vqY7fXLrZiqIc0AFSSQeM7NW7lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTcS92UO; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc569440e1so14119665ad.3;
        Thu, 08 Aug 2024 16:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723158844; x=1723763644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzxAnNd+2P5RagrV70uSTDmukSTtgzZlqgxHDGW9DCk=;
        b=GTcS92UOxM5r+IY+f18shqYQaqilorIAtPshUcgksZ+ieXQIUwvvsYiD+62NgCubm6
         fPsy27sg8sF/hWI+bw+/ViJbV8Y+Ww8yl4IDRy1jemSUixARqVyHln8okBzdsS2HfVlj
         4u5InMpneuRPfMDKLadGVBEyACWyMlhpzK5vbfHuwqIeWSLjsClX3eBcfy4Dc/RUJQJX
         TQl3sk6ChjSk5wEdlyRiyHV22TZc8YIvTtG5dJXcLj/URy4gk6Mg/lOU3lqKVKOrFjIO
         I2SNMBNKOte5gGJw+JALZciRaSeeD6/ZqOG37BUAGJzKeJifrpzVIxg4xlxFRqKKY9sJ
         wxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723158844; x=1723763644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzxAnNd+2P5RagrV70uSTDmukSTtgzZlqgxHDGW9DCk=;
        b=eAx+jOJ3MuMCcYuTcz9TV0ZdoBx/0IHc5rRMoK+jVChaVyhljbbLQlRONy+9Wcs3OI
         ZXWDwfHhYAw1JwE2sj/p8FV5GthsmCiPeLFCOYrj/+6xmoJOs9WP4zEwA2YnKN39jMpm
         REt4/OL1kOKpIsHDznWHO/qfx813lRCgputLK+o1XHPvmVVWpCXT+Q+vJnMcCD/CdbCb
         KG/DgTJp8fdU4XeV2retNgJwgJVU+2Lh+vGmZEbCFl1katfm3zmV3EdJtvr5B9DR8ZyI
         fCWAa9xiUqVdZSAB6WXjlnrLgKaulzDFUafpIX2hJbRh005AbOxJ3sAJOe4O1ahsewQ3
         JdZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIRIkjney0s2GoCvQsJK0YwZGG+tEMMgJNqorJMyzmNA+iTpjuUjx5yxSdAAzpfdKLrMNW4DxCms6RJHeBq/aIu5SDY+cCV4sw2q5dYFqW32d9uoQVV+BZPcKY66RUoAADP3gQoxOnB1xxQ2GXXbnQs4BY8oyfyB+9MFVK6/zKPivOR+AjHNRftV0tiXFY4t3XUwKTtup/JD8ViA==
X-Gm-Message-State: AOJu0YwUhJBKtZRx5ZcfNjizIQa+sAuwfeabptjSXN9FbcmO0Mqrak3c
	tirdNI0bDUYJ8vvXzyHrtS7J5q3Ez8XbrXuCLuVXq9SN64z6uKsjjlCunPxjSTDk6Qn0/xHUkIk
	DyeDUt3ef5s3dSFv3ZuCw6vC3mWA=
X-Google-Smtp-Source: AGHT+IG1/DdoAKFjvHg9EVP5I2kaAQyATplTDXAqOEcpfBC4JM11ab36k7mIWy41WyBWVbFkeNIGORA/STIiVejkIG8=
X-Received: by 2002:a17:902:d503:b0:1fb:5b83:48d9 with SMTP id
 d9443c01a7336-200952a285cmr45534635ad.37.1723158844196; Thu, 08 Aug 2024
 16:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.21.2408071241160.61955@angie.orcam.me.uk> <20240808020753.16282-1-mattc@purestorage.com>
In-Reply-To: <20240808020753.16282-1-mattc@purestorage.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Fri, 9 Aug 2024 09:13:52 +1000
Message-ID: <CAOSf1CEcUgVg3bj4s-zRM0RUCkLq-udiyA7QGOy66=Bam8PDFw@mail.gmail.com>
Subject: Re: PCI: Work around PCIe link training failures
To: Matthew W Carlis <mattc@purestorage.com>
Cc: macro@orcam.me.uk, alex.williamson@redhat.com, bhelgaas@google.com, 
	davem@davemloft.net, david.abdurachmanov@gmail.com, edumazet@google.com, 
	helgaas@kernel.org, kuba@kernel.org, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, lukas@wunner.de, 
	mahesh@linux.ibm.com, mika.westerberg@linux.intel.com, netdev@vger.kernel.org, 
	npiggin@gmail.com, pabeni@redhat.com, pali@kernel.org, saeedm@nvidia.com, 
	sr@denx.de, wilson@tuliptree.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 12:08=E2=80=AFPM Matthew W Carlis <mattc@purestorage=
.com> wrote:
>
> On Wed, 7 Aug 2024 22:29:35 +1000 Oliver O'Halloran Wrote
> > My read was that Matt is essentially doing a surprise hot-unplug by
> > removing power to the card without notifying the OS. I thought the
> > LBMS bit wouldn't be set in that case since the link goes down rather
> > than changes speed, but the spec is a little vague and that appears to
> > be happening in Matt's testing. It might be worth disabling the
> > workaround if the port has the surprise hotplug capability bit set.
>
> Most of the systems I have are using downstream port containment which do=
es
> not recommend setting the Hot-Plug Surprise in Slot Capabilities & theref=
ore
> we do not. The first time we noticed an issue with this patch was in test
> automation which was power cycling the endpoints & injecting uncorrectabl=
e
> errors to ensure our hosts are robust in the face of PCIe chaos & that th=
ey
> will recover. Later we started to see other teams on other products
> encountering the same bug in simpler cases where humans turn on and off
> EP power for development purposes.

Ok? If we have to check for DPC being enabled in addition to checking
the surprise bit in the slot capabilities then that's fine, we can do
that. The question to be answered here is: how should this feature
work on ports where it's normal for a device to be removed without any
notice?


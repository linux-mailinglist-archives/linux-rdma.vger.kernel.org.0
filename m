Return-Path: <linux-rdma+bounces-2509-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900178C78EE
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 17:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7EE285293
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 15:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C58146D7F;
	Thu, 16 May 2024 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=balaenaquant-com.20230601.gappssmtp.com header.i=@balaenaquant-com.20230601.gappssmtp.com header.b="U+O6+GHW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C8A1487F2
	for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871944; cv=none; b=g/M2yt5Kc2HHwsC2bkm93FrlYvGZ1m99QXbcheMFwhLtlScICEuv38KXHOm86iAXPB48gqQIL4nU937VXyG5Bh+OirTGpqBHy59VyGWXL1aAf1iP10yQtZXJ6smawzMKuCGJQ9xYuA/1iNQC3tOxaudOgKN1kLOf1jLdnxC7kL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871944; c=relaxed/simple;
	bh=3uWmaBm8ANPCAz0u/3n2oLSKBSrif39MJHXyv97sI4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+svd/wReU0hKZFSSjenLaBNPWYGQzAo0xUKB3ceRWA0zUZ+u4wFh9XA/lcxyCUyTKSx3USUdsXmeOVdVKXR/rTVRKurKpaxN0bPbTZRfu94VMotGPMWGGAFbuAjjvDMrW6pY1XW5FKSntEPtawbfO68k0RvBH6AGTAaPvek/jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=balaenaquant.com; spf=none smtp.mailfrom=balaenaquant.com; dkim=pass (2048-bit key) header.d=balaenaquant-com.20230601.gappssmtp.com header.i=@balaenaquant-com.20230601.gappssmtp.com header.b=U+O6+GHW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=balaenaquant.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=balaenaquant.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572e48f91e9so3907732a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=balaenaquant-com.20230601.gappssmtp.com; s=20230601; t=1715871941; x=1716476741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uWmaBm8ANPCAz0u/3n2oLSKBSrif39MJHXyv97sI4k=;
        b=U+O6+GHWXIvayXC4ZNJPHyxD6syVrJj1bUXKj/myQU4xwjcH03XFNYbLgKTUUdKN79
         Cgc8wfeOjRaaCCR2LPO5kHT/1QFlPILwJZZoMQeA82aug51yQRmF/kiFIEeJB1XsJXUn
         YCsUmpoWJLtFw7D2VyyAyDddP9EZU3IkwYojz4ycpIdZpo+Oqx94MTP8u2XG8u4TE09M
         RKu+Vinl0ht0/GhEM7RaZpU3V/1PCE+2oCIA1JIBy9S/wwt8Oag23vhX3jdZUYW6l+Mm
         q0Nf9VjWM5AOWeg3EWRqKcf1G9oMJHHeOsvnlnuIGLDEHUwwdvM4y5dsmhFk4RbLiLoD
         gjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715871941; x=1716476741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uWmaBm8ANPCAz0u/3n2oLSKBSrif39MJHXyv97sI4k=;
        b=sj52NDAgYn6JmblYWoIrZSj24/7HOUU8BpMrJtujRp+nmE62qRb4mOiC37qpLUIF3x
         OwFukCEB1bMy8wiqGaobDuwXXdhLfGKn//4OYGUcSYGoC0WJ1xKEQhC9zE1te320+uId
         DZAsrel+eC0GMDIqOovl+EqqWz7XOrgjBMMC9R4ResLlyaEaIv7t7P4jBrMXEnhhPotN
         M/2vos2TFsGewZj4kDDTsA/xt6jJenHMhnJatX1c0uUmNnlX+R0aMMWq2vZR7CAELgmW
         HUY7alVOwNRLiJzlWfHS23aJyyGGafvJiDOQL+bPpwhk99rAcAdhKB2Qvj0rJkAI50AH
         MQZg==
X-Gm-Message-State: AOJu0YyyckxMxbBCqrroRZhtXiKjq84h4vanni2cX+EiAuoz34rXcgHz
	v66lIItQ2keCAdH7kAkiWM7pXfh3LqHYc5dLaXCcc9ZeLYUmp6tSzXfXY+EiDvFZvQET6zKsVbb
	cGQrmo8rz9QyeOfyLTWRsvZZ7tj6aNs4h8rd+M5vivBAo7bVFu74=
X-Google-Smtp-Source: AGHT+IElGXnhC6wQsL+wjrqd8350Ski1JxqAQKhkCd5UZnRYVvqJZCL/VfcHLegS7l2eUw1xWcEpU/Ng2W4QWqdTwVU=
X-Received: by 2002:a17:906:fe4a:b0:a59:a8a4:a59d with SMTP id
 a640c23a62f3a-a5a2d66aa6dmr1493673066b.62.1715871940955; Thu, 16 May 2024
 08:05:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJTiWe+M-gwPb-GvCvcNrhtrqj96NA34YTRLAQsLS0ffucK+Cg@mail.gmail.com>
 <GV1PR83MB0700C80470457BD70210F8C6B4ED2@GV1PR83MB0700.EURPRD83.prod.outlook.com>
In-Reply-To: <GV1PR83MB0700C80470457BD70210F8C6B4ED2@GV1PR83MB0700.EURPRD83.prod.outlook.com>
From: Jun Han Ng <junhan@balaenaquant.com>
Date: Thu, 16 May 2024 23:05:09 +0800
Message-ID: <CAJTiWeKwj-7J3YH3twb5sJ53_qHJ5Nrt2C9HxAPVcKk9pXMw2g@mail.gmail.com>
Subject: Re: ENODEV in rdma_create_ep with loopback as address
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was indeed using 127.0.0.1, I changed the address to the interfaces
IP instead and it worked. Your advice was helpful!

On Thu, May 16, 2024 at 10:48=E2=80=AFPM Konstantin Taranov
<kotaranov@microsoft.com> wrote:
>
> > When attempting to call rdma_create_ep in active mode with the loopback
> > address obtained by rdma_getaddrinfo, -1 is returned with ENODEV errno(=
).
>
> What do you call a "loopback address"?
>
> Note, you cannot use 127.0.0.1 as there is no RDMA device behind this IP.
> You can run "ibv_devinfo -v" and use any IP listed in the GID table for a=
 loopback experiment.
>
> - Konstantin


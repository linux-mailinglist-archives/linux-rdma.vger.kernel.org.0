Return-Path: <linux-rdma+bounces-7404-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECB0A27A3C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 19:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6EF1886126
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 18:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F792185B4;
	Tue,  4 Feb 2025 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgby/CT1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667120DD4B;
	Tue,  4 Feb 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694486; cv=none; b=O6Xzx9G1FG7uFG8ohPgvIfDFRey0yAJInDQlp0Mx6BjvhUgz3zXvYGgmt2TWRkCswmOLKbI0MmULsMJgP/pySYM5IUf7cdT6q9WS8CPdaiDNkK4UOilzurKaypc7KaU96//8jnVMa8bS+qg9tLoKqOVE4ALDlkqb9EdSDcV8Nlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694486; c=relaxed/simple;
	bh=BykhNrU5yb/xqnxH478PuhsPI4enRJ10a8mBBuIAm+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iF2QwJ3n3NzlQ1JtomV8a2f+NfkTuWNFkGkN2jbEktMEqcuXe2DoarzfDbmQmvPVB1YVWDSu7XnwddIJ4yLkukrxxHoEjsyi4plIQkTyT3YIeq3h1xKUXdlteG3SZKXzfhfQbiJP/qtU3KDrY/dlL9fErtMcgDiPRLzIZtIkexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgby/CT1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38db104d35eso584863f8f.1;
        Tue, 04 Feb 2025 10:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694483; x=1739299283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4898qSs9PnK6sao1kkrPVANsRxsn9Ys1yqup6ircsYk=;
        b=fgby/CT1b6JuWCtd2as9m6qwhamkt3IfJO/hXlbfYIDm+QiKrOpEnpLJ0onkB3+YGG
         R9a1GJol6oFczaGEIQsZuSj/Lx2LoJqCOEU1E3kuAbBSsFmFD0eajAA4L49KoNZ9pmwD
         50GYN0GzZ+Utl/T5jlR6aJtvtVKrwhTE0C9W/+IC2P2LM3ZbleaBUdpluiCenaiZ2Evm
         dH5tYexTX9hL60fKaoZcim6Qg7gqx4IakgZaWHIi7/SnHEFAaD/Ge9Ut8UyFrSZondzO
         qoXDYe8yL1Wz2+/nXiuvvw4KVCwcA8CFtmqSBR76m19eKBeuqW8OF6u6A2F9Vg1AIhX2
         O85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694483; x=1739299283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4898qSs9PnK6sao1kkrPVANsRxsn9Ys1yqup6ircsYk=;
        b=Rs+SteLk4xgvzxEzH9w6qWGYPr8Uwo4hXE3NZNkntxCZF4BySZ5u5vqIft0tT7LAc8
         OMPa3z29BHoo4V/K0vme8a2MQUXcPwYsj9pvbJe0FEcwqPzhGjsold0o3AmQ4b8NvVkh
         UU6F2b+by+PktQkuuheWYxTDh2OInzQ4f1De110esPYxqUdBp4kxAu1S1xacrqeCt62N
         rUJPtM3npp1Af0rlv0DCbS/wyeovV+tAJknK94BogLl+YUARWdyd2qBBwTheyCGT8Nd/
         3QBZPyAoBhjs+/xJ3+qOR7nCP6RfbkTQUydiG819Gx/UkF8+ZIKx7FrqffZgK9wfbh2e
         X2wg==
X-Forwarded-Encrypted: i=1; AJvYcCU0nc4aHfnHiomsLuf4G9omM7q8cFdoTyr2f3opvIxbMv9PqMyte6LKjHnOtfr8nBqY/qkre//iWlao+A==@vger.kernel.org, AJvYcCVT7nPA5CkI76GyGA6sxw3q/uWbtGgzSpxm0a34FU+HZbWvexMSLGo1JJYTqeaw9sgl8DwFLjoq@vger.kernel.org, AJvYcCX9Shxq0TdA7F7L/57P7wtTc0lvn91Z/knfTgWyurACisrzIjU/7tY0x1EBavSj6W5jFsD2t0cySDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFI6T8kwKWa4ES6Np4CSU37WOaNmomvSP+lNu67g5r3VP/kWB
	g3F+t60Kv7+3y5g8DgbHqlIBAvikZgF0oYfGUw8DDucNKZxSO7+U
X-Gm-Gg: ASbGncvpAbtxRBGYzhJy8NdZj2nDilsR4KX3JWqy/n9oUPim1TL5dffLwuD3uBo5Og3
	U3L+2kUtESOBBNpzOZ+1Q0YXutsprCPmdbD7WcBuzVC2zWhwUVr01GsYkGZ1lD+Q722gNaVn1k8
	IXXKyHSnLb3eBvXtX0J9a52494WnssmfxKs7HqVir/Ru/S0N+JABOMq0qgu58N9N93w8xPDK7ez
	aTbXkXvUrC6xGk4bzIE+/7KlrkqD/x6CufPmP9amnDCThzrKnW10YQOLC9YXTTvD5dhoZWZTK9U
	bzIWz8QViInNtWrVCTb9v+5UdRrlv931wRcQhlF1dtJ0NBd6aH3JSA==
X-Google-Smtp-Source: AGHT+IGMukZOMOoqMJBYdI9wFhFfAKlkZp4ajbkSfhODZBJb/b8M/hgpAVxedM8x8xtUfaPTkcI0pQ==
X-Received: by 2002:a05:6000:1fac:b0:38d:af14:cb1 with SMTP id ffacd0b85a97d-38daf140ef5mr3130992f8f.54.1738694483262;
        Tue, 04 Feb 2025 10:41:23 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1d1d03sm16776348f8f.99.2025.02.04.10.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:41:22 -0800 (PST)
Date: Tue, 4 Feb 2025 18:41:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, sridhar.samudrala@intel.com,
 jacob.e.keller@intel.com, pio.raczynski@gmail.com,
 konrad.knitter@intel.com, marcin.szycik@intel.com,
 nex.sw.ncis.nat.hpm.dev@intel.com, przemyslaw.kitszel@intel.com,
 jiri@resnulli.us, horms@kernel.org, David.Laight@aculab.com,
 pmenzel@molgen.mpg.de, mschmidt@redhat.com, tatyana.e.nikolova@intel.com,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ice: devlink PF MSI-X max and min
 parameter
Message-ID: <20250204184121.168eaba2@pumpkin>
In-Reply-To: <Z6GuSJCshbWlkiLu@mev-dev.igk.intel.com>
References: <20250203210940.328608-1-anthony.l.nguyen@intel.com>
	<20250203210940.328608-3-anthony.l.nguyen@intel.com>
	<20250203214808.129b75e5@pumpkin>
	<Z6GuSJCshbWlkiLu@mev-dev.igk.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 07:06:00 +0100
Michal Swiatkowski <michal.swiatkowski@linux.intel.com> wrote:

> On Mon, Feb 03, 2025 at 09:48:08PM +0000, David Laight wrote:
> > On Mon,  3 Feb 2025 13:09:31 -0800
> > Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
> >   
> > > From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > > 
> > > Use generic devlink PF MSI-X parameter to allow user to change MSI-X
> > > range.
> > > 
> > > Add notes about this parameters into ice devlink documentation.
....
> > Don't those checks make it difficult to set the min and max together?
> > I think you need to create the new min/max pair and check they are
> > valid together.
> > Which probably requires one parameter with two values.
> >   
> 
> I wanted to reuse exsisting parameter. The other user of it is bnxt
> driver. In it there is a separate check for min "max" and max "max".
> It is also problematic, because min can be set to value greater than
> max (here it can happen when setting together to specific values).
> I can do a follow up to this series and change this parameter as you
> suggested. What do you think?

Changing the way a parameter is used will break API compatibility.
Perhaps you can get the generic parameter validation function to
update a 'pending' copy, and then do the final min < max check after
all the parameters have been processed before actually updating
the live limits.

The other option is just not to check whether min < max and just
document which takes precedence (and not use clamp()).

It may even be worth saving the 'live limits' as 'hi << 16 | lo' so
that then can be accessed atomically (with READ/WRITE_ONCE) to avoid
anything looking at the limits getting confused.
(Although maybe that doesn't matter here?)

	David

> 
> Thanks,
> Michal


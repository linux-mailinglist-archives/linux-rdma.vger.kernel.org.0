Return-Path: <linux-rdma+bounces-950-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B78584CCA2
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 15:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802931C25A3D
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Feb 2024 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED65F7CF32;
	Wed,  7 Feb 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="iMz96eud"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317E7CF05
	for <linux-rdma@vger.kernel.org>; Wed,  7 Feb 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315935; cv=none; b=Q/iE5mM8qGfwfLQs33+mXOE0qbiaAAkJkvq9V59zdIcwQlfwaE0A7z3Mqb/J6GXQoE9D1vdY4dRZkQZ+OwDdpF6Fx7ISw7kc5WXLFSGAwcVzlP4XUnrarfqkePgz9oNQzF9u4tNi8Cb5bauF+NNhGTu8FiTMFSooFVh+AbqpTp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315935; c=relaxed/simple;
	bh=8TjpTnr2uOUHyjAU8x1r6nNiu4YhGYIiXKjaSIx66JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVAhG7iLryfuWC24kg75OOkgCh6oLmOMeiEwr0IV8r2GT+YxJaY1WkM5NBELa/3J5qVo9Tyf1M2mj1hkZu7TBKoHIDyCQJ3DwEpsbabUQJe3e9NEvEesajoKGse6wD/G41rc4X1Qq6qaGmuIt+DG+/cZXDSPJU7/uTJbgzpytyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=iMz96eud; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e1270e8cd3so249053a34.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Feb 2024 06:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707315933; x=1707920733; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaaCT+rhJtD+61LWJubfwBSzXr8X6PtWTAbxqQNnRNs=;
        b=iMz96eud1GYBWHS3fj/n5tHdGw/RyTxmuv5pmSkXtmppZHcl7uP48hCvxVIyD90lmi
         1Hf/QeDq+Bj0YVwyovGcRbRs+ZTuI9Sf2QThGVN3o3f3pO6Z4Vd2Uso7IwFpyQyTwvrS
         qligkiH8fp/mDGleCTCOxZpOQOUvcZOPD7Jic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315933; x=1707920733;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaaCT+rhJtD+61LWJubfwBSzXr8X6PtWTAbxqQNnRNs=;
        b=QCiT0US927o/7huEB7+ZLr3mMvZbuL0K509Ki9pMvdnyBHEiuuWfj1noo25JtxcfLa
         B+Dv2VnlC0w4c9TUVZ0RY0IVMICPOX2eH7tPde8O0nMG3WJQU/YEbJ5YfUCwYq9eeHNl
         jcUkkJaqqGk6XZezLHw8KZYlc4iDVdkPEZ8EMGeNcNn85VsyOOJMOXAJ4tC5ugVqWpZQ
         Kez4WHEYCy9sHTsu9KA371a0K50x8VacH/GXrvRSJU3weJFrylWH06mewDVZf7Pi0ZJK
         VyvMcb93znC9GScF/eMwrtLIOyOKTYfhOJicIb7FTRjum3iqlRu3d4ppyQ62MvIIYnkM
         K0fw==
X-Gm-Message-State: AOJu0YyxZCLQWvTUfICxQ+hUF5gIJK9WFpKuIu9FRNDksLWadOCkoqtD
	Arc8L3cbF+6mqSqPrb7wQI47Oh7mV8D2GOk36V68piYZGJdDGlLVZO21wymfmZ0=
X-Google-Smtp-Source: AGHT+IHCk9rLNop5t04dt5x+GZXCejO4EU+I7pA1zPkR2gFy1eQTvrGJQb2+FEZyCy0ZfSCaEDQ//Q==
X-Received: by 2002:a05:6358:2626:b0:178:e3b4:9779 with SMTP id l38-20020a056358262600b00178e3b49779mr2959534rwc.21.1707315932745;
        Wed, 07 Feb 2024 06:25:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEGEAtNDvoZPEMB3Kv7QlzSeHyGMzAwgWPVeLcEYDIxX5Hdr+7D4ecvydaNdD4QX5ioyy9xN9UkR8Z0Lnh8bJ22A1D0Z4uoGLFIfKnYENJZqYY5n13S6zt1Wp+rh/4GxMU3mTmyZAcGz/TkSuWN6l/sO7DgVhQ1S6/fXla+UGbqlNUpSRBKbwNjg5Adow3KhHmDEmH5MD99zn2AXniSECFJyR7jUYfQsc6I8i0l+gaiJu1k2Ou4cC7frCiTYkS4X9hZq+xqqueQAKpRM2xt5QiKco+4yNIF7tSjo1oy5Bi94IXf3ObyOx/p7f4/4+pJOXpWRd9Wqxk7xZMAgRZYHt2WPnShMD2J5UCJ1AiW3wjIbB7yJqA+tOAiI3VhvshhojjvQg=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78c04000000b006dde0f53fc2sm1605617pfd.49.2024.02.07.06.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Feb 2024 06:25:32 -0800 (PST)
Date: Wed, 7 Feb 2024 06:25:29 -0800
From: Joe Damato <jdamato@fastly.com>
To: Gal Pressman <gal@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	Tariq Toukan <ttoukan.linux@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	rrameshbabu@nvidia.com, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next] eth: mlx5: link NAPI instances to queues and
 IRQs
Message-ID: <20240207142529.GA12897@fastly.com>
References: <20240206010311.149103-1-jdamato@fastly.com>
 <7e338c2a-6091-4093-8ca2-bb3b2af3e79d@gmail.com>
 <20240206171159.GA11565@fastly.com>
 <44d321bf-88a0-4d6f-8572-dfbda088dd8f@nvidia.com>
 <20240206192314.GA11982@fastly.com>
 <b3c595d8-b30a-41ac-bb82-c1264678b3c4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3c595d8-b30a-41ac-bb82-c1264678b3c4@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 07, 2024 at 08:59:18AM +0200, Gal Pressman wrote:
> On 06/02/2024 21:23, Joe Damato wrote:
> >> The per queue coalesce series is going through internal code review, and is
> >> expected to also be ready in a matter of a few weeks.
> > 
> > OK, great. Thanks for letting me know; we are definitely interested in
> > using this feature.
> 
> Hi Joe,
> Can you please share some details about your usecase for this feature?

It was outlined in the cover letter for the RFC [1].

But, briefly: we set a number of queues (say 16) via ethtool. We then
create a series of n-tuple filters directing certain flows to queues 0-7
via a custom RSS context. The remaining queues, 8-15 are for all other
flows via the default RSS context.

Queues 0-7 are used with busy polling from userland so we want those queues
to have a larger rx/tx-usecs rx/tx-frames than queues 8-15.

We implemented basic support for this in the RFC we sent to the mailing
list.

[1]: https://lore.kernel.org/lkml/20230823223121.58676-1-dev@nalramli.com/


Return-Path: <linux-rdma+bounces-7366-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C56FA25DF0
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 16:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483DD7A180D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2025 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB1208970;
	Mon,  3 Feb 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KaeveK5b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C6205E32
	for <linux-rdma@vger.kernel.org>; Mon,  3 Feb 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595290; cv=none; b=SM92edIlCOpmUuOx4MraVt9Nf1VHVze5k+U9IIQOlq3qkfXauJGFXbeKn4d7t+x+e+bIJc6JFVuWgxO5SleReGKgXDvMPlQ2zVIZJbIlZbSpq9h+z2i+3jDltoR4Vw8OOLromSh10WXGmpTF+NiKOZWGmLDEZSFiTMWyG2ndXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595290; c=relaxed/simple;
	bh=8L3lZCr5Yh9GUMcmv4LwjtFjnj2T4yg1op4QyO5LEUg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD6+PBTqNu+kUw7LjJkJOibrr3Rl3awnmb3FgEAz8bPe/tfNHJ5x3bVFcXYmt0hzmY/3BZE8AL98hE5gjNQwRZcc+gVSrTJDXC9cSl2t5asJLqmoY6IsrwLOE76WI0043U5b7yeH2tkSA5i/nkVjSCUpWmaa/xZmfKgSla92XgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KaeveK5b; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7bcf32a6582so400647085a.1
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2025 07:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738595287; x=1739200087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIfqpXWa2saTTZIkeCGgjoPhbUp2hEhSFcQHJJf5WU0=;
        b=KaeveK5b8zakSjNQ+ijy/xtt76OcNkiWLeRJ5f2vhHz0xHNqLfGFbnm3VFN/Pr90Hl
         3h3MTP1H2FOclDm085BBIjuCY+L5MJAcqgrirObXQE4M7OdntaFnudIVn0w8/Hr26qoo
         3ijZAphccXyyf307aC5mljLI8ETsKiIf7wXNFYpM35SFOggE/E3h1wZlA5PaBkX9WGAl
         a7B4dio7079kBk0mKEpODVE0WRqHHlmeevUc6FP7BvadrY3KDWtyWZI5zn6L5mC6xsZ4
         AJV5vvAaN0rtf1RYeaSy+SszNEfdXvuTxptX8FbVRdpuzH8qkYd1kTEswBaG1EfsZ+8w
         4V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595287; x=1739200087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIfqpXWa2saTTZIkeCGgjoPhbUp2hEhSFcQHJJf5WU0=;
        b=SKUJNn0EYKs8TFjKok3LM+K6173ch6dzpNU38TlHiZYWHfCtKOS8RucuRfoPdg36nC
         s0jrxWXle1XMi5XTEyBkVZEuDMu5KHJOmr2YuvLzyOzCVewrwEfxihNan63Q8nzi7PPO
         KeibCpFpoVKrmsnFDxECnRKZab6jrP6mgdIrrYGqU2nGwa0u5G8Oujw6DOyObWNqAe6I
         406YCI90oPNbSrrv0CNx4/g6xt2FP4pnWoNFjAEfpBwAVCM9dTlqRB9Lwznjjh1RgFl7
         bqrUnR+ORSb+MVgrnvbDpaBdrSl2Xwk3QvYmXhB1C14JC4nzm1pbw6Dc4URWDBmzyf4V
         HnYg==
X-Forwarded-Encrypted: i=1; AJvYcCXZKkFFRWO+2KHov41SCSvpoPYS+BlviW8plD5bLU/a+tZFcbVrEu4h4eHWn7M5KHqOqh84Nb4IApC5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywioh3Xnqp0FqR+sNi4T6T58/CmUo/2TpUjr+jIQJphixBiSDYj
	q1FHw7S13w7CKOG2u5NDuRd3YFykIfrNQQFEeW/v1mv471w+dfvr1wREaV2DCtI=
X-Gm-Gg: ASbGncs5DLr+df3KpEGa7/jDl/kJdk1DpShLUspGnr7EO9bYEveV0ScFzY+ofRA8wYq
	zN8af++CEDck79eozVOWs2tOsqJPDkUPsC8EZR8SU+zIkErTR2FAld4bGyaQJJGJjcE0wTxXecw
	9azg7eyRFwXIkDNyRdjrzWG8QYm6StmrbTLlVmmP9ft/dsEfJ06BcxKt2FcR2/HWtVPTRWtEc54
	uwq8gtj1V925pAs5g054bqJhxnctbaO4mQ76GuFdYbIulOgo15mAS/lWQpWc782hA==
X-Google-Smtp-Source: AGHT+IH/qa1lrVLcKxozjVl1Axtfg0S5tmpdY0Hz1inHc6vNMg7mQBJDuUSeOKIlGn70ib6W5YOi8A==
X-Received: by 2002:a05:620a:19a8:b0:7b6:c540:9531 with SMTP id af79cd13be357-7bffcce8d01mr3518318185a.18.1738595287317;
        Mon, 03 Feb 2025 07:08:07 -0800 (PST)
Received: from ziepe.ca ([130.41.10.206])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8d1280sm534889985a.45.2025.02.03.07.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 07:08:06 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tey3R-0000000As1Z-1rVV;
	Mon, 03 Feb 2025 11:08:05 -0400
Date: Mon, 3 Feb 2025 11:08:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Yonatan Maman <ymaman@nvidia.com>, kherbst@redhat.com,
	lyude@redhat.com, dakr@redhat.com, airlied@gmail.com,
	simona@ffwll.ch, leon@kernel.org, jglisse@redhat.com,
	akpm@linux-foundation.org, GalShalom@nvidia.com,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-mm@kvack.org, linux-tegra@vger.kernel.org
Subject: Re: [RFC 1/5] mm/hmm: HMM API to enable P2P DMA for device private
 pages
Message-ID: <20250203150805.GC2296753@ziepe.ca>
References: <20250128151610.GC1524382@ziepe.ca>
 <b78d32e13811ef1fa57b0535749c811f2afb4dcd.camel@linux.intel.com>
 <20250128172123.GD1524382@ziepe.ca>
 <Z5ovcnX2zVoqdomA@phenom.ffwll.local>
 <20250129134757.GA2120662@ziepe.ca>
 <Z5tZc0OQukfZEr3H@phenom.ffwll.local>
 <20250130132317.GG2120662@ziepe.ca>
 <Z5ukSNjvmQcXsZTm@phenom.ffwll.local>
 <20250130174217.GA2296753@ziepe.ca>
 <Z50BbuUQWIaDPRzK@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z50BbuUQWIaDPRzK@phenom.ffwll.local>

On Fri, Jan 31, 2025 at 05:59:26PM +0100, Simona Vetter wrote:

> So one aspect where I don't like the pgmap->owner approach much is that
> it's a big thing to get right, and it feels a bit to me that we don't yet
> know the right questions.

Well, I would say it isn't really complete yet. No driver has yet
attempted to use a private interconnect with these scheme. Probably it
needs more work.

> A bit related is that we'll have to do some driver-specific migration
> after hmm_range_fault anyway for allocation policies. With coherent
> interconnect that'd be up to numactl, but for driver private it's all up
> to the driver. And once we have that, we can also migrate memory around
> that's misplaced for functional and not just performance reasons.

Are you sure? This doesn't seem to what any hmm_range_fault() user
should be doing. hmm_range_fault() is to help mirror the page table
to a secondary, that is all. Migration policy shouldn't be part of it,
just mirroring doesn't necessarily mean any access was performed, for
instance.

And mirroring doesn't track any access done by non-faulting cases either.

> The plan I discussed with Thomas a while back at least for gpus was to
> have that as a drm_devpagemap library, 

I would not be happy to see this. Please improve pagemap directly if
you think you need more things.

> which would have a common owner (or
> maybe per driver or so as Thomas suggested). 

Neither really match the expected design here. The owner should be
entirely based on reachability. Devices that cannot reach each other
directly should have different owners.

> But upfront speccing all this out doesn't seem like a good idea to,
> because I honestly don't know what we all need.

This is why it is currently just void *owner  :)

Jason


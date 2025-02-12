Return-Path: <linux-rdma+bounces-7665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798FA31A90
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 01:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C4718877F7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 00:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D7C1876;
	Wed, 12 Feb 2025 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="vNovxPUW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6AFC0E
	for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2025 00:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739320660; cv=none; b=RrTSU99cQDiopPHs5EBcEfRd3Xtnai2KYQyT5BO3mMDPSZZrZv18jOWQCYFcizqrnUsZL1Vm8A3xfmTgqci6h8lZatKhQ62Bfar8kig+04PfKUQmGWM5I35/jCI/9WUB9H6uU2brOiRt0LYLeK7TSctDNSyeKiAotWU0WzERpOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739320660; c=relaxed/simple;
	bh=YSvSdah0bKTEIup9mhuKAIdnz9EFwCw2r1vehy/Wxd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoNiNEeXTxEcyeBM/HxY7IppoPxZz93PJ2knD5k9eResIMFjVO0ayASfilwCtIr7kBxqHUDZttyxQ+mWO85mXHGV0lVDKK2lLY8Z824u7Jzf5d4/YBv4qjicg4LzdN4/qeWM/5yMvBbSEPHT1hvnW5KHxMNMxpoe7yWA+6xLMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=vNovxPUW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so165743a91.2
        for <linux-rdma@vger.kernel.org>; Tue, 11 Feb 2025 16:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739320658; x=1739925458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikhPyTe6NtiZ3aec/ge2RXv/HlgjomU3KdF4rZpkmkY=;
        b=vNovxPUWmyCdUa27ZztBjXg3ZyJv16SLVjMPfk/2lt3R5W45LEj/Ouhvo/F2YK6/jN
         3lp+TN4R9ZkGzdBgWJ2j0TFzqk+xFnYpTziC8fI1ffk+Oz0ZAhIe8lxf3B0XsStNb1sL
         xIJWnehvBj1CVuGckYxUHrQUJwVPjHzMfV+yivky0inj/GiaHZbstJtU1WlI4r8130l1
         UVxXRSLgbsZ2g1jLHS7eoB+OqKZ/vCGEvYOxLIkbJdH6beTGMFu0uNLnuKv/5FW6d22y
         8Psfcq6TBGnzrpaJDHpEUOzDC8RIlKXiOsHbF1+J5HzCzw7IW8haua6oOK0QMv28yiLR
         mPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739320658; x=1739925458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikhPyTe6NtiZ3aec/ge2RXv/HlgjomU3KdF4rZpkmkY=;
        b=jsAGreJ20WVGBuGK3H3DY6UlygEJH9BI3vY+QU29+t6j7oLF5W0iLDzCoGkQ+tqFFK
         +Fg9vw/bfZzKXoRrhUZBqSDjq2Ga/XLVi50WAFo5cPBTSGLgRwTgDJdEgO1ZFVAQRZgZ
         xa++IqHpxxq4b5tyRnB976HkQMZStBpZsBeQ+bPp7OQeeXigUV92CyC/Lp/3JZFl6KOh
         6UoEQj+v/9ssuKB0nxr1Fvw7o3ssa8lbdU41YwtzlNTUzhfYXtfMP6w5EYmB6/RHqIPD
         oHB+37Q8xCmijg+RvAwHCvZCQqG5pfMdiF1AGbno+Upz3hIqDWx46vl8GofpAmDTc1hC
         XxNw==
X-Forwarded-Encrypted: i=1; AJvYcCVeUaMPQR0n0eg/3ytqS+sGuseOKLAuyOjZhhGhoZjs92oL3EqO2pVurJ8p/k419vBnZ7ttfx+XRsM2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/meiJanhxbz5R7enn8H92F0B7RMb1RB6nb5rMg2vs1nhVtbzT
	CXIrB/E2iKGw8+Y7fPPDtFyvo1dElYNNQMvulLSVnipfX97RAQgTgCLDRrJooFTvBZzquHp0JYn
	Z
X-Gm-Gg: ASbGncvab9uqRwdoxWoZGuzOu6wfjXXdjcgbGG5qbYn9etWy9SgwvHGbjIBrBuQf3t3
	YGta4Vy97hPdwpGSV0PE+rQ2QMGV/YABPsPp2sOiLTK/zW2xYt0Vtp+E4KQTIl0Q5rmGPSRRSuY
	GenQZm6fNp1FZkHRJkSkmiSbwiBsT2Tnalwtj0R2uRA/iFGbhOKAuN97nLoSyY3T1MRKRnOXTYM
	1UewBT/IvPRuYRUv/DVb456tgU2LFPBkiehxjbuf6iQ1LtYNa0iwGEc1GWWI5lpamRWTyzxtNOg
	xsNVGe8fR9q6M7RCqYMvFKmyBh6+TbbV58ihPOGNocKAFqS3vdZXQ1zO/ZW8eEblbQFF
X-Google-Smtp-Source: AGHT+IFLyeYwU6Oy0JIVL6fTE1Wf/d8hPAYNZvjz9ExKRE039OR/aOJBA99Q95y1XNDQNeGgxslDfA==
X-Received: by 2002:a05:6a00:1789:b0:730:7d3f:8c78 with SMTP id d2e1a72fcca58-7322c376a27mr1967734b3a.3.1739320658388;
        Tue, 11 Feb 2025 16:37:38 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7308ac1a373sm4641127b3a.41.2025.02.11.16.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:37:38 -0800 (PST)
Date: Tue, 11 Feb 2025 16:37:35 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: longli@linuxonhyperv.com, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Ajay Sharma <sharmaajay@microsoft.com>,
 Konstantin Taranov <kotaranov@microsoft.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, Long Li
 <longli@microsoft.com>
Subject: Re: [PATCH net-next v3] hv_netvsc: Set device flags for properly
 indicating bonding in Hyper-V
Message-ID: <20250211163735.18d0fd02@hermes.local>
In-Reply-To: <20250211162026.593b0b93@kernel.org>
References: <1738965337-23085-1-git-send-email-longli@linuxonhyperv.com>
	<20250211162026.593b0b93@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 16:20:26 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri,  7 Feb 2025 13:55:37 -0800 longli@linuxonhyperv.com wrote:
> > On Hyper-V platforms, a slave VF netdev always bonds to Netvsc and remains
> > as Netvsc's only active slave as long as the slave device is present. This
> > behavior is the same as a bonded device, but it's not user-configurable.
> > 
> > Some kernel APIs (e.g those in "include/linux/netdevice.h") check for
> > IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used in
> > a master/slave bonded setup. Netvsc's bonding setup with its slave device
> > falls into this category.  
> 
> Again, this is way too much of a hack. You're trying to make
> netif_is_bond_master() return true for your franken-interfaces
> with minimal effort. 

Agree but disagree as to reasoning.

The way bonding is handled in the kernel internal API's is ad-hoc.
Really a better solution is needed.

The real problem is in any code (other than the bonding driver itself)
looking at IFF_BONDING is broken. All that code won't work if used over team
or failover devices (luckily no one ever seems to use them).


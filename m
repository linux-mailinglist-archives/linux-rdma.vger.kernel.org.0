Return-Path: <linux-rdma+bounces-5366-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330EA998CCD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 18:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA311C23380
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 16:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383411CDA36;
	Thu, 10 Oct 2024 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GsTrJMkU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76FD1CBE80
	for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576464; cv=none; b=qQLEihEwHKl+84DpNCVwnDz/SeiYGhQ006Nhp8IzxV9JjRpN88KtuOsYskEO3iUbqghEx7Gfa6KO/mTR4Hzwz7xfCX9ARHxbuoQhWw/+HS7VBRlrin2Jv7IxRZCpBAOKFpZPWd0+l2610M0CLpGqmsRFCNoA8lQuqE5iL3yhHH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576464; c=relaxed/simple;
	bh=gMJJQSlsn8Yh8reIJdg3CtduncAlSvBM+SH5wCCRMpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7kPFYYHpTNERWTGcsSCAMRaQn4S/03YAUMQ7MdvGfa3TzA2jczI41J5cH2liNIZROV0VOYG1/0Wv4BN6X0ds69dBhdUPND4CyzxAQ0b1nWV1w/Dbd7kIdvk46OK/aEUqdgjShHX93ZCzNdnnI5RY6w7HEvIhrooii/f9hOeVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GsTrJMkU; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b9b35c7c7so7185025ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728576461; x=1729181261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLDmBuPbqdFWywlMJb7s5WtOj7TP+t2aXk4dAI9ZYPM=;
        b=GsTrJMkU25PTamlCMwj87VBDSg08a9TYsWC/cOPWfuVOfRvnrParif5IpeDbCg4MKw
         wHJ/vAKC1dIdXOs1HCvL9FNUt+WJhcZnLPmPOdzXcizhVnHsxxDZcOn2FrwYYfbJa/X2
         3aNilAGkKW3DcnVXRiG8wt/fKZJLJDwx9hdW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728576461; x=1729181261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLDmBuPbqdFWywlMJb7s5WtOj7TP+t2aXk4dAI9ZYPM=;
        b=OOWdS0D7oTNp541Sb2oCV9EJoR1MhRkWubYJjULxB4w6AiIICBsjbeNH0BKAwxpCTQ
         2LpC4mUaf32pU6pZ+vXXvKYCtfQUaNnquK0ttrIprir7TWZ7YHIwHWkKb6OCqeoLHCUv
         6xzfzLNdfXvJYx7Bx+qLxU7SKsudq5+YMJMdmw17GwmmfiX5OXQZy7IYzdxV7WIeKZB0
         AKF5+ga60OpCdb8Xcirw4CwWWAMD3ejRitPvIMghqU3G8BWVfhdLn8Jdhb3ORpaHliiM
         Vl6dSaJd5fWL1u654v+765Vvm+ZM2eNqebW4uo3Dd2II2KnBrAFlPb+bg8hX37h9rjN6
         OZ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPb1/YweYflTICj4tJw/0kIN3b7MYQJegY3hYaa93cBwyv/nTfG8ABaEuBvL5sCXDULuUeOPcPi/Et@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ZjJL/9OTLkhGWd/kKvF1E3CvzeX+XYRPieB7cQxSOytRacDe
	s0hY8c21mUf2tFJhSXJ0itaVViZPypI59rEGL9IAz9FWL5WBAENYEKUJPcOFK5Q=
X-Google-Smtp-Source: AGHT+IG0fUbGFEzJUGz4lr95LVIQt209ymVKDCNv+HN/QpGQnTewWumSlw9CcDSQqGqrSbXg5wKhWw==
X-Received: by 2002:a17:903:32c9:b0:20b:43f8:d764 with SMTP id d9443c01a7336-20c6375c6e4mr98324265ad.8.1728576461240;
        Thu, 10 Oct 2024 09:07:41 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33ce22sm10984635ad.256.2024.10.10.09.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:07:40 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:07:37 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 9/9] mlx4: Add support for persistent NAPI config
 to RX CQs
Message-ID: <Zwf7ydIettFJ6p2K@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241009005525.13651-1-jdamato@fastly.com>
 <20241009005525.13651-10-jdamato@fastly.com>
 <CANn89i+187Yht9K-Vkg6j_qj9sFiK0jaGSxMDdYCAUZUtBgMOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+187Yht9K-Vkg6j_qj9sFiK0jaGSxMDdYCAUZUtBgMOw@mail.gmail.com>

On Thu, Oct 10, 2024 at 06:28:59AM +0200, Eric Dumazet wrote:
> On Wed, Oct 9, 2024 at 2:56 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Use netif_napi_add_config to assign persistent per-NAPI config when
> > initializing RX CQ NAPIs.
> >
> > Presently, struct napi_config only has support for two fields used for
> > RX, so there is no need to support them with TX CQs, yet.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> 
> nit: technically, the napi_defer_hard_irqs could benefit TX completions as well.

That's true - I think I missed updating this commit message when I
realized it. I can correct the commit message while retaining your
Reviewed-by for the v6.

Note: This adds to the confusion I have around the support for
allocating max(rxqs, txqs) config structs; it would seem we'll be
missing config structure for some queues if the system is configured
to use the maximum number of each? Perhaps that configuration is
uncommon enough that it doesn't matter?
 
> Reviewed-by: Eric Dumazet <edumazet@google.com>


Return-Path: <linux-rdma+bounces-2472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875018C49DF
	for <lists+linux-rdma@lfdr.de>; Tue, 14 May 2024 01:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA95E1F21F3C
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 23:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56384E17;
	Mon, 13 May 2024 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H9HUxKuX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5584DF4
	for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715641580; cv=none; b=KS1AyIOf3XsKRIkg3d9IBqDE7Bk4AjjKQj1XFZFg4POEw0h21JrPifrCvyN94KbQ/dt33KJa0z7IV5v9oazHfROP9vKivP/85nk9G4Q3+JIWO5HQGwCBvpMkpNSQULg1vkM6N7NPyhpwNhm1/ibtJhpjcg9V4P25K2xaDSc3B38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715641580; c=relaxed/simple;
	bh=1QNMHnIjg/Tb+YW4thfawpAMJeCIRCs3mm95uw3AUNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YARK6tXB662ZN66TvHa4KzP6OUFBEqcxXTZ2KyONuTgMIPRRzUCIeVzHyuTXwjYaO69QaNos5Cq7AZCVSxKwP0ZB86U0xpcfERXJwh/JBank4JUfVEVLy673Dys8YOijhdPqNP/SXgjTGiHepvPBeBfFtzRKxOd8YksI+RJT/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=H9HUxKuX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so28210055ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 16:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715641578; x=1716246378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4/FqARGodQUd4K2eEmu4YR59CbGKEydXfi5YMd/QCV0=;
        b=H9HUxKuXtNIw0W7Y/H9C7jGqs40lPHSZ8LT3UsbQbJhDriVYYrFxrm3IjQbCqhTkyz
         Iko7kIBNBRicpn7DDSKUHCnTxKpG6AuzOiBjPntmN2xE+hfPXEnUVTpkRQZdDDGbeZqK
         yiJTLxLJXmhiBE0Zo3de3PtaF0MwCbb+BybXj5AHNWWF8kxyIXOFYI1m9Nr3Za9WKvfN
         CHUnJ3efRE1N4JxFRrayxTMpxJ1q5Z1C7DKFORbiyT2y93onUhB9wVFbvU2xePODH7rS
         lB4/d9WjM/6EHh4JUlwg4yKa52vWZ9aX9u3lS2LyBGRBCju8Gp4Et9RQGEpJu8waTTx5
         9LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715641578; x=1716246378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/FqARGodQUd4K2eEmu4YR59CbGKEydXfi5YMd/QCV0=;
        b=wW9y+lS2SrdzCsUovC2ksLSKH7PDsw0IYy7YFOkxaLPak57efxmL19ZbGSp1c4/rE0
         rtyvJMFF50GsBCdRKimL8QULcBIk1XsUBbIr1b8lpbIFHTXV2Un1hp7c3SzdkgNnp7w3
         WuU6v+MYtaEm4cP2c73dOEGbZjdaEizDX9TQHNwO2/gSaKGeeSQGD/3z4BR7f6O4M5sJ
         q7tETOA86hmsAmspLT54osfd3aulVUEVsblh9Jj+TBCw5MmCWycjUG64FHsI3XOncEA2
         uGiDlY1SAhvgAmziG6BHr6sdwZrZeNnLbkTs7ffWSsa1lNdf5NgrVpuWyRm1F3qRbO3L
         pWzg==
X-Forwarded-Encrypted: i=1; AJvYcCVXpjPq4+bkY6Hr8gJPMz4y/e7DB25oD8Jf363FuK3bDO4e6l/8Zibz6OnQPAiiQKZXKJWkPcsr/gWjm8gO477vhZXPFG58xxkH9g==
X-Gm-Message-State: AOJu0YzLdvFVwkM1t2kPos/fA2vtjNt7B14Bd1yDbBJb4pvpzL8ZBT/b
	+hxLxVbM0Aq3YAPLmEC6JEGiqOjaiCDVYxEiwJqslH6vqfS6LHxAXgOwO9nZLaA=
X-Google-Smtp-Source: AGHT+IEY6vTkNLQ5aDFl6ziFRoY24BM7GlO8qN98W3K261UAVqcSWAl/Qhkhw497180Jq+GGmFRe8Q==
X-Received: by 2002:a17:902:f68f:b0:1e0:9964:76f4 with SMTP id d9443c01a7336-1ef42e6e646mr158440115ad.14.1715641577934;
        Mon, 13 May 2024 16:06:17 -0700 (PDT)
Received: from ziepe.ca ([50.204.89.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badcd43sm82411555ad.105.2024.05.13.16.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 16:06:17 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s6ekK-0001fY-JW;
	Mon, 13 May 2024 20:06:16 -0300
Date: Mon, 13 May 2024 20:06:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Shay Drory <shayd@nvidia.com>,
	netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, david.m.ertman@intel.com,
	rafael@kernel.org, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
	leon@kernel.org, tariqt@nvidia.com, Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH net-next v4 1/2] driver core: auxiliary bus: show
 auxiliary device IRQs
Message-ID: <ZkKc6BFEQsmjTbvl@ziepe.ca>
References: <20240509091411.627775-1-shayd@nvidia.com>
 <20240509091411.627775-2-shayd@nvidia.com>
 <2024051056-encrypt-divided-30d2@gregkh>
 <22533dbb-3be9-4ff2-9b59-b3d6a650f7b3@intel.com>
 <ZkDg8Aj/TdOqFwqf@ziepe.ca>
 <5a3520fa-590f-48be-8594-de44ae4eb750@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3520fa-590f-48be-8594-de44ae4eb750@intel.com>

On Mon, May 13, 2024 at 10:33:18AM +0200, Przemek Kitszel wrote:

> What if I want to store some struct, potentially with need of some init
> call (say, there will be a spinlock there)?

Yes, that specific pattern is definately a bit tricky, I have a
version in iommufd and I think at least someplace else... A helper of
some sort would be nice and could do a bit more work to be optimal.
 
Jason


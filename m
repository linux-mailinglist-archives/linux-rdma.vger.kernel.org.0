Return-Path: <linux-rdma+bounces-4954-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 734AC9796D6
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2024 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB42281D78
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2024 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFD1C57B8;
	Sun, 15 Sep 2024 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ht1w9fSx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579561C460F
	for <linux-rdma@vger.kernel.org>; Sun, 15 Sep 2024 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726407350; cv=none; b=UUllhxt9sDbk6nhnxhMq9+7nz1uAA2Y6/Z46oAs5OLnXaiPl2p6zliw2y6gXsYWBAh4vpzcZzn4BgSrUVKCnqDHOSzjfcbETgM2SQthoULhsPq+qQeMoMj6G5Qr/oQQNijTen03IaxPFGEiBqvidW+ULkZ4/MuiVtN9J810mJGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726407350; c=relaxed/simple;
	bh=MFuUzm3zMLV2CZh46NonDUDb1OmZjnpTyIwCOgzIMhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayOPVTS8272gZjsbU91tA1ErRE4N2qVGlsRRP03ucHLhP1O116B3VtmU+RjPeZgN0wK6NlgOK3/GZ8j6pkQHXJVgn+h25gwvXZBvU3E+5g3Sa/XD+1t4fJe5967cbz4/9ojsV6Q0Io6Ci1/3jDxO85/7VglBbb80DEcAmRXaVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ht1w9fSx; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-458366791aaso18855861cf.1
        for <linux-rdma@vger.kernel.org>; Sun, 15 Sep 2024 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726407348; x=1727012148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBZgZQ/X+6st0aH7GdIVp1tBi9c0iIhLFTb6MeWUSec=;
        b=ht1w9fSxNJy0ez9Hqa3Y3Y9wr8zTcW72Qy9d2luxR7133NBWDZ8xRBNrz6Rn3BZnzK
         NKLMBA0qHPBWXpRd3J+wkpW+AKpm86LW0HNcWau91ACzVr4cveZHlzTc37c0CROqOa22
         UtIg49HcdimZ8LLCy1pEcFVhDwQfJ7/6TQ8RuDtjL5gUqZ4eoZzqsb9CVmmBIe5SAu4H
         xfuF7MIkEEgwXvHpo2nt1J9wHi+YXImEW5L/M2lRiGkweiUqgjaQlpoW5UejXEhJ8PTF
         fPubsqs+mpZeogjA7DANoQ09XjoZ/ksNU4sy+xvITJ67UdvGseYFR3wbD9NljJFkZvDq
         pWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726407348; x=1727012148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBZgZQ/X+6st0aH7GdIVp1tBi9c0iIhLFTb6MeWUSec=;
        b=vRFCdrpb0WvdP0Tc9ij3c6XKCfdJn/XXDw6d2GZGHgtyNi0Gvp+JTE9DZgdfj8sd+x
         YT2zlDnu7AGIYn9oCSu8TotlnqufukebPMjp9KejkxPPMu5Cp3J2YQ6CFS18d8dxxA1Z
         6Vg0eDhasjkpQSKG4fVhNBs5EF05w5n3Y+5Vk2EJG0wkGr4yxiesjottplIsYIwHyXeo
         A8/oi9T5LjLpr4cWgGCv0lcGaZHtOZcs6kjD31l4a9iJ1qYvX8DWgA3Z0OsvjP9tiWDo
         jQRYPu4k9OwLtVuoPA0LqxtWjGBTUHZI0+4Z+4fwWnXWMJ5jcm50V/NqsPS35BCmvETD
         VMnw==
X-Forwarded-Encrypted: i=1; AJvYcCUlbRCqo9I8XwyWoYzH8C9XihQ/au0IQgOpb01uXpBQQ7IzCT5PM195mEyzCCs6Pyc5CFFo3SaHT2Gx@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGXShILO6ksnwtvCuv3rrPxBEDX0b4djkrsplCK0NYv40POdV
	TMChAW96StUx1GknkWBfKk4uQZVZv/CTvxljqot+r3Mr2n0RDIIcSm17B+haCOE=
X-Google-Smtp-Source: AGHT+IFfd55b1bDIJCVeC7CmAbChsQwmoF/CcF7pxemMMuQO+q6jkx98WdhJWgJxofnNUxtRsST99A==
X-Received: by 2002:a05:622a:1a88:b0:458:4286:6762 with SMTP id d75a77b69052e-458602cae58mr187488141cf.15.1726407348207;
        Sun, 15 Sep 2024 06:35:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aad2363bsm17960661cf.86.2024.09.15.06.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 06:35:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sppPn-007atk-7Y;
	Sun, 15 Sep 2024 10:35:47 -0300
Date: Sun, 15 Sep 2024 10:35:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 for-next 1/2] RDMA/core: Provide
 rdma_user_mmap_disassociate() to disassociate mmap pages
Message-ID: <20240915133547.GB869260@ziepe.ca>
References: <20240905131155.1441478-1-huangjunxian6@hisilicon.com>
 <20240905131155.1441478-2-huangjunxian6@hisilicon.com>
 <ZtxDF7EMY13tYny2@ziepe.ca>
 <d76dd514-aceb-b7cb-705a-298fc905fae3@hisilicon.com>
 <20240911102018.GF4026@unreal>
 <d8015dc6-c65c-2eed-0ffe-0c35a4cd0b2a@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8015dc6-c65c-2eed-0ffe-0c35a4cd0b2a@hisilicon.com>

On Wed, Sep 11, 2024 at 08:38:35PM +0800, Junxian Huang wrote:

> Once hns device is reset, we don't allow any doorbell until driver's
> re-initialization is completed. Not only all existing mmaps on ucontexts
> will be zapped, no more new mmaps are allowed either.
> 
> This actually makes ucontexts unavailable since userspace cannot access
> HW with them any more. Users will have to destroy the old ucontext and
> allocate a new one after driver's re-initialization is completed.

It is supposed to come back once the reset is completed, yes userspace
may need to restart some objects but the ucontext shouldn't be left
crippled.

Jason


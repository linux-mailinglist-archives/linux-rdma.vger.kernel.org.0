Return-Path: <linux-rdma+bounces-7048-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16678A142F6
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 21:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AD31621C5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2025 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECECA236A8E;
	Thu, 16 Jan 2025 20:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z1gNKkW1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B5A22FAFC
	for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2025 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058737; cv=none; b=SbPr0RevmAy5BmYZdeTiZ98C+U3grmvaZparzsU6+9SzST8pImWnsulx7CQ910WbKkednzbrLG0p4z1jwRcV/2GRRDDC/lQGb719Fy4g1sPGSZNWRwenxg0aKXp8qcRkLmas5oRXQfADWSQa7JTI3V5qBQGKHhAxsQmJ1bx2ktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058737; c=relaxed/simple;
	bh=TW2t02hwCcCvA4dY7CqwLTCEluJxPrBR26gpeJGJ43c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XISH1JGyYll/78krmKRHxFcJ8HXuX2d3BLmBkdDrbDeslyeUPO/LiXDtY8ogGwhSrOq9HqbFwWEqytctHY7mazT5y9sKtynmAsTBhWuGfK6MTo3q/BwOe3PNp6cZOIw+T+eWYq1e2+Xa3t+9TnRxeRsWG4dA75hI93VzRq9zYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z1gNKkW1; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd15d03eacso14465606d6.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2025 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737058735; x=1737663535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjLKJevC2V7Xu5ADPJrgzXE+Cum0TiiT74cho1sXgi8=;
        b=Z1gNKkW14lxu8cW6U2PHwwOrjlbCi3tIzLd/2avcQf9Fuzn889VVOr9ybxwoUPqCuv
         UrlUDZ8tiO7rR5LLqvlFYQKbdmpXMfQ2XW0hBXvTBBMHgQAT0J45BMQfSK2jLIguAsar
         s1iLvXU2HwWnQagI5cNOnCWs4jUS0zi2csu0fYL1DffC/iEu8/cENDOofNAxmypsSlu0
         K/Uu2XHu9BlJih4R30VaZ0vHZWqixXYRbwp1mt4wg92EH/TDgMvLXFUSCKgvSJEQSDOP
         bdSWOfiRkI69IZPm0fI1wPl4+xqHyU4z127BDzbHmrE+4WX19o3G+2Q6xszzjQ5/WiAR
         4pLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737058735; x=1737663535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjLKJevC2V7Xu5ADPJrgzXE+Cum0TiiT74cho1sXgi8=;
        b=l+O2Ua8yBg+Jft8/6a1DmUGrZqYkLV+Iti3jdfn+FVIzv5UaYrrEg7Xq2SnZh974yN
         FJJrGRFRFRt8K+UtEoN3fNHu2Axk4U1eY9SavGP+ShZcICrqr3/0JujeJ7nof8SEYUCA
         NdCbtcjjruVuQikL6n5QMNvdBEBrWy4I9o/hrwe5tFh8sOErXMT487t9Ov5o3LZ16GaV
         PUgkeO7bGJZbfam5xAvZ4FbEiVmziryhFzJcxNWp852xNMp7yDSmTANcSZUGcULUUdu4
         ZsaFtDJVY8PCTZSlHZirhxHi9xMlJwSilQirChgNt47itbgZHXCvDoRejCZOmTDhX+L+
         tHZA==
X-Forwarded-Encrypted: i=1; AJvYcCWgxxR1u9108C77LuUmgDY9LHp3I5pHmHtNoHaG41Pl6QSlI0IllC903lEDKWXMxAXwbhCaqPx/FjI/@vger.kernel.org
X-Gm-Message-State: AOJu0YzZh6EJH1+hxBBnQJTHOrhHDd/lcyqWSBKQ5J/1IZwguUmmt/yV
	/jN7+dD3aqqC756D7r+XWtFBZFCme4Ophxptt8QSIfYelEuoRxLE/ny5owY82QS19PWibBEz76I
	y
X-Gm-Gg: ASbGncuTnbF9dWkK66BhA8QKON+2YLr2JKv4WNXwFXI0+9v24jXTIFxmhUFzY8jnp4U
	bQFyHtYqEieDxkk+N8TycsPZuIZqYMCHJqU/oJbUhdB5oQdmP817tK5JzGQBkDGdKzrokNbDeaN
	r/bIU/u55z0/ArqVSdbm+zIlnivqdAmPWdAFdPYCVcrd5qTKu4KzyEJk2EIq8lfpRQx7H7BwTFo
	bTwtyEeN+DE2zZFvVzfvCmdascknTDqpa1OmizaDW9qSvbA0J9XVtUYVSmCcbAdoP4p51uwKqth
	3pEc9qH9UIG0aDlSIiA3A1kRZfrCFA==
X-Google-Smtp-Source: AGHT+IGiuhJCb6CE3xcrJekt3qGHV8KtpIud5ATr1ePaT30zfzK6ww+BnPBnVPMzNC6cTFY+JSWjmQ==
X-Received: by 2002:a05:6214:20a2:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6e192ca312amr104688286d6.15.1737058735081;
        Thu, 16 Jan 2025 12:18:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afce4695sm3441426d6.104.2025.01.16.12.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 12:18:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tYWKL-00000002y1X-3wBD;
	Thu, 16 Jan 2025 16:18:53 -0400
Date: Thu, 16 Jan 2025 16:18:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20250116201853.GE674319@ziepe.ca>
References: <cover.1734436840.git.leon@kernel.org>
 <fa43307222f263e65ae0a84c303150def15e2c77.1734436840.git.leon@kernel.org>
 <ad2312e0-10d5-467a-be5e-75e80805b311@arm.com>
 <20250115083340.GL3146852@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115083340.GL3146852@unreal>

On Wed, Jan 15, 2025 at 10:33:40AM +0200, Leon Romanovsky wrote:
> > > +	do {
> > > +		phys_addr_t phys;
> > > +		size_t len;
> > > +
> > > +		phys = iommu_iova_to_phys(domain, addr);
> > > +		if (WARN_ON(!phys))
> > > +			continue;
> > 
> > Infinite WARN_ON loop, nice.
> 
> No problem, will change it to WARN_ON_ONCE.

I think the other point is that the addr doesn't increase, so this
loop will lock up.

Possibly just do return? I suppose something is hopelessly corrupted
if we ever hit this..

Jason


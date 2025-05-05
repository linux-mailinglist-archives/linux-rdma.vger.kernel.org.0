Return-Path: <linux-rdma+bounces-9970-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26434AA931C
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624F53BAD14
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 12:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63D6250C0F;
	Mon,  5 May 2025 12:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="d5rF7RkT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9646D2500D0
	for <linux-rdma@vger.kernel.org>; Mon,  5 May 2025 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448147; cv=none; b=U663qGiHPwoy/H2n9yBdvz78tZWz5kzMRnLR3RT3g6lNRQTokK5A4U6pzt9ycFRs4Rps80aCxTwRO5wOjFHrAwuZlHveJFwE2/yNP7DVeZtIYMTKVbAjW5+cudVS5gUaUgwUix5smtbBvu/QeG4PC+YaDl18F/VV0WAVgqYWQYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448147; c=relaxed/simple;
	bh=8st2WkhNjYa0sS1ZjGydQ5cI8qeMQD3qVytw+PewtLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7eFdgEgaO3UPveEzFordoz4sC9wciBOSkPPbMG+RULcSF9DhVLltE08bNOaS5ir2Q+maoClJgS7coFT3vjfEB5D2e961CEKQPn4W+eKhmovV/8E88h/J1j8sHeppoi5k4KQPmPB9ZVle+aHwEHDuY5xHODIeuM0+dqF5aA0hlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=d5rF7RkT; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f4cd4c07c3so38122606d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 05 May 2025 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746448144; x=1747052944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mfu+tu5hpHDhrhemjgH6VucLj0HupA6g7txg5hR1fns=;
        b=d5rF7RkTmsJIBWsVD7r8ZkiItKXsgG/IbfI1O5P30GgnZ18NuAXa9eP3PofKtR4MG0
         K3hKiOCDSlt1JiNQdhav+XFXb3Uu6gZqSHBorp5ZpiG1Hm/lph0vpRPQ0MP2poUZKyCZ
         gLaF+DKDt6doc4D+XMMDB+puE8X1g0e1seAAPnKRXk6pn30VYcTdFZ2Vv58Th9J4lcvu
         QFpQupl7AMl5vIx0jZlhfvDVfNplt3sa/ll0jeXRRN/jOxqPVOuRRbGLzME9SNr0s1jh
         r80iCVsOAcD5bTSFn1dsarpkJqTWD7NBAJ+kwQbClpuV4o31q9LP5LPBTWmmjxrOJai7
         Nf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746448144; x=1747052944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfu+tu5hpHDhrhemjgH6VucLj0HupA6g7txg5hR1fns=;
        b=tQhTlxPFBPbgQQiBSzY/kZ4Oav9nMiu/M3PTOfkdez/wT/EoV1vqMkPu8Lll8/rfe8
         VdNHfGKns1WFVqieXCfECGfgV4INu6jXJBUIMHJajpfq29cqNc4Zq+ok++CJkyG4aaVB
         +O/Zf7/zAJZWY8Ue/kB5Ypf0EjxbTU+E77V6wVnjJUQy52l9CpPiQkpbFZP6JSCa3HZL
         jIvc5WuNpo7ZMfSDOHQ7iylGJ7um1sszOTCjun5/ZVicmrhy2NHxvTKMsE9dMGV3M1t2
         hJaEz92yik31HxFJ4rrM7lcbihn4O/uJdPoCiFVu/PiQ+Y40FXnj2FnS20u16preSfUK
         q7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM73/vPCe+cUpMI9oZuChVGC8dOABCc77kHcwsAFxtDSToazkLtSVbsPaTOVD8Q71d8VJHiVlqZpye@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lYG/6VqOjmaQbjM0kxpjh9g12hOmFPFnI0ljoGw9ok/a7hly
	huetGFqSQMYPDaZc6i3EPa5YPDgWEDseOtAZW0TJjKCXO15fxBa7U3VcsDHRp3I=
X-Gm-Gg: ASbGncv3hiZSuWK2qett6srhprMqyEd0/jFRaoauyq4btxVUb8WUeXnDJmv+f+GZJdG
	sa7KDxLg4LYqej3z/4rxuBOnwzEayNvpoTyTc8SwmUNKSd6cOrviQW6sOn9ewvq59MeuQfvoPWx
	5z0OcBEt+HV6yQxCmAodcJsoXbzDEnHd60NwryWN8KTwZJu16zNN3z2pXAx7GiuJWWslOZfUJ/q
	cddtJlX/ss4rT8o9qHhxwUd6vbCMUwEonHmsuriGOQrR9mhJ6wRBDdjl1tMqBVfu573pzrdUCTS
	31EvOswEiKlW/PdqxgbkckhfuCsceW5lgoDm4gxbnUiBs81L3kJTqBs/AqgM6GYduPfNxCfNBgc
	xRAE+M4HVEfFWVD487J8=
X-Google-Smtp-Source: AGHT+IHrrCkbPkXSi1eXZMzeybSC5P++W/lKXALdeEOdhNPGMmZG6yFN5oZZyeIbSctGCJtNUEnJAg==
X-Received: by 2002:a05:6214:b69:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6f523852b68mr146814446d6.38.1746448144313;
        Mon, 05 May 2025 05:29:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f50f3c3887sm54983076d6.38.2025.05.05.05.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:29:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uBuwQ-0000000GxAs-3q1W;
	Mon, 05 May 2025 09:29:02 -0300
Date: Mon, 5 May 2025 09:29:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v11 0/9] Provide a new two step DMA mapping API
Message-ID: <20250505122902.GF2260621@ziepe.ca>
References: <cover.1746424934.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746424934.git.leon@kernel.org>

On Mon, May 05, 2025 at 10:01:37AM +0300, Leon Romanovsky wrote:
> Hi Marek,
> 
> These are the DMA/IOMMU patches only, which have not seen functional
> changes for a while.  They are tested and reviewed and ready to merge.
> 
> We will work with relevant subsystems to merge rest of the conversion
> patches. At least some of them will be done in next cycle to reduce
> merge conflicts.

Please lets have this on a branch so I can do the rdma parts this
cycle.

Thanks,
Jason


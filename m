Return-Path: <linux-rdma+bounces-3041-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AA79027B0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 19:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC132848D0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E69714A0A0;
	Mon, 10 Jun 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S+TKeib5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305A145FF7
	for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040306; cv=none; b=PWfZ9udn+hwTvVLc8rZ7tI3YBK+zIzhMsztH/qthJpbFJs4ISbxwpC3vb/Lp+bq4iSPBSI+iu9evGt5rv+99DJx5gbi+TRA5aiYTig1gR3uYL+8u3GLlzyPjsnIgGnX8OMd2XHYC0lwE+AYjUlE+zdUu9oVK1NKQc2Bwy+1qC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040306; c=relaxed/simple;
	bh=mTYg2I3WuTkpyh/+o64UPh2Y+YNRCZ3wV9gBi8Zm0Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsxR7ODwwKT9/m/UgKl47RmJirwxJBZ5RPkT0QlrMGcP+3bynBMimLMB095/gtpiYdFBAo5r+Q3lqP9Zl+Emd1JFoXaBYNbkMOXcT3wqyd022YhpbAO2JV1dvtWxFI2Odem2jhRbXpi+a8UPDK2PNq8DGsyiQfI7GFtCpimMEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S+TKeib5; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-79550284502so8376685a.2
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jun 2024 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718040304; x=1718645104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=25m3KIGLmguUC8/pQLLfTfUUYokxVK5unna2aPd6ENo=;
        b=S+TKeib5I+1Dkq43acjA8a7FUUSahJRBvyI1FIbAZUhYFHySf9FerIeM4YULmQ1ara
         9DLhZxEzHbFUJwT7vlqjva+4TupaEfrc8S7+8Fce/VJifBnfg0vC6DM7++mXeUxS6rLb
         ZnunedLMoKK3aiBwdBuPDB1/Fyu5+DjSKBw/ePkoBhdxm+BC84meFPlGaEczdhhO73Ab
         Pn5pIy/wIVUepSpk/reK4qYuYosNezVLoQhBcm69YeCim9DxhJBPSb6b50TtnhmhrH1n
         iaA98DDKAnmDiVbFTsr+VsRP8mhavrlXXGovRyFOvGmGMTq77owyS6goh4dZEOwMBJjF
         hDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040304; x=1718645104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25m3KIGLmguUC8/pQLLfTfUUYokxVK5unna2aPd6ENo=;
        b=rXDMHB9fqZeie6IEEiYl9YqCr9DiB0tciBnW3nSl0k/cpqbx7VsuHDoMSyqbhau14O
         DZ7brQclcE70boFs0NRvXUOgAyyscQDx31wLDxfAupZBuwv7PY1sY2O1sg/yGu8wRBIj
         GGowQ+Dq6KPgvSDr05XCtpK8ax6nDguLQiI6PhRNvQh3MtfCNHsKrYgBzJpdT7iFju/n
         jNUjlcSId9+3B+UXKMGdXuXIpFftQA5VV0oeblg0n9LL//LzkAiRlIQIhf1qGUlx2Dc+
         EHPEhU4qGcgbP78Cxm2AIEkdTLveyNsjQLzJY6V3m6kWZF0wg/W79cSGkQUK2sXLS3ni
         uWlg==
X-Forwarded-Encrypted: i=1; AJvYcCVDYGyM1xCCsvjz5qR8C3pGv79C6bnKeKOtbRgw/jEhY5WVslFaCJHYqQ6duUsBwn6fDHxqEjbfvBzRGNPnLelQ8tsyqVHw/QD7xw==
X-Gm-Message-State: AOJu0Yz5IQDL2lpRnaE9zX3soXVkpkpJzA2gusFnHvaCpFQdcqtqg0mu
	uPY0FkW+M1QacPm1nENIuV0dFVYEELHU2/1PN6fCGQcWiJQDXAtg20BcUCsBqio=
X-Google-Smtp-Source: AGHT+IERiQrm9SUSeQMdKlpq1AJrD/6cpiXXPM5R7XiNqEGctS72ZsZ7Qn7LPR52HM49FztB2xw/bQ==
X-Received: by 2002:a05:620a:2949:b0:795:60ba:76a3 with SMTP id af79cd13be357-79560ba7949mr495154685a.12.1718040304159;
        Mon, 10 Jun 2024 10:25:04 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7958e85b6b3sm134283285a.100.2024.06.10.10.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 10:25:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGilR-00EocS-4l;
	Mon, 10 Jun 2024 14:25:01 -0300
Date: Mon, 10 Jun 2024 14:25:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Zeng, Oak" <oak.zeng@intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Brost, Matthew" <matthew.brost@intel.com>,
	"Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	"Bommu, Krishnaiah" <krishnaiah.bommu@intel.com>,
	"Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240610172501.GJ791043@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>
 <20240503164239.GB901876@ziepe.ca>
 <PH7PR11MB70047236290DC1CFF9150B8592C62@PH7PR11MB7004.namprd11.prod.outlook.com>
 <20240610161826.GA4966@unreal>
 <PH7PR11MB7004A071F27B4CF45740B87E92C62@PH7PR11MB7004.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB7004A071F27B4CF45740B87E92C62@PH7PR11MB7004.namprd11.prod.outlook.com>

On Mon, Jun 10, 2024 at 04:40:19PM +0000, Zeng, Oak wrote:
> Thanks Leon and Yanjun for the reply!
> 
> Based on the reply, we will continue use the current version for
> test (as it is tested for vfio and rdma). We will switch to v1 once
> it is fully tested/reviewed.

I'm glad you are finding it useful, one of my interests with this work
is to improve all the HMM users.

Jason


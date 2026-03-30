Return-Path: <linux-rdma+bounces-18814-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHQaMH75ymmlBwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18814-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 00:30:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC3A361F41
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 00:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A190301BA5B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 22:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C080E3E3D90;
	Mon, 30 Mar 2026 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SRVjkBgu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8E3E315F
	for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909606; cv=none; b=qnf7H+o+vfwIxkHJ1UXiYlQMDKnLXk8ZYss6sizVDpd3Mz8J7MC4l93qIVYN81WxtQ+IGhXn3yYLwbVWqloRjLpJBgcgec8zXzo7sTlZRVJIb8fd9ONl+eGG0ORA1u8NXOqOmSnXsY10oNWa7DZ4YXUOZJHzMFW2hNhhUcTdZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909606; c=relaxed/simple;
	bh=njYxOmFhF0kKZxmCluaJeRNQJOvHXtTT/LYX+fA/Jes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB6XSyYYfI5/joCEDv22UnDo23jc72kvM7VLqGJ3lDnewr6Kye0OjVVazH9YDDe+8O4TzwpJF4sQblPamtfBK9l2foHRJPB4g0ooRC7mzC9/rLxobeN9HeP9pPNwlTki2NuiG1rhwz5r6nlz5Hf7CmbciASrhn6hp8DTeDRztog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SRVjkBgu; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfc40e4158so596223385a.1
        for <linux-rdma@vger.kernel.org>; Mon, 30 Mar 2026 15:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774909593; x=1775514393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMpjIoYB4wkYY1B4Qvo8YM+LGvG/wS7KH0HgKJnMSKw=;
        b=SRVjkBguFjfCZK6KyO2Br10O0nqWk6wAn3BLxlEleze8weF4NGKj5VBS1no0JjO5YI
         g/8icibDzjoJ0tJ3mTX8v++aieNJw05tHkPlWTQpChPxIIwkR+mVcZapcZOaZwamMkGU
         BxFsK6CI60m3/NSHR9n7W/1RRGEA/BwYPMseTh37M/BCi6MEgkRPdeEMsVaqjQzrH1M2
         hfIKXlVf8INWVlRRJtrqNQBeTHeyhxBgPBBJti+7t1bjluyepJUzik8KVlxhpl/B3k5a
         5bv6rOSUlHPqk37gDhEw2D5iGe/tdQtZx2u/ofN+hR7axrwuYFIQPz5ctd56nxod8Ysk
         WMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774909593; x=1775514393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMpjIoYB4wkYY1B4Qvo8YM+LGvG/wS7KH0HgKJnMSKw=;
        b=bm+U5wjNkXpmUMNFOUm1gA9mOnlSlJxebw32PGi6tj1x3ALoe9/jRxESVUiI5O56Jx
         cTvkNwrEJlZ2CEX+0EIdzgP1GGmp+erqazcm8Ace6vKnWKKhjCj1Zvqs6wiB5lfb1lKH
         TRyI1gxHatWNkPXbbwjM6VmI1fZwjnuG0RNnFLmiM0aNjqd9HYKougPVAukLZ/Zu7vyy
         6qiu0eUUsWS2Dey2GsPdNNG1VEFRG1ks4k1pK7Q2D3qRKWHUzQ1GKyZJSlopZ01zWqvO
         H9G/uZ8XTK8V8hnK538yQHSspOT0vSCciLn7ER4FAQGdoCC8Pw1TwHnWDCOEsHrAqdyB
         0Ejg==
X-Forwarded-Encrypted: i=1; AJvYcCX8Kt2gYXq0QptIXVv1klQMqI3AbDySdmcUGI3AvJyUqg62CPfOtpqdhpIBAScWhnKMgMiZRqMLWsQn@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhmFUSVMM0VnwjvscustmdPOxqlmkm79uXJOP9QsjUaS9n345
	nQugFdTuXCkJlfilYdB3aKreKIf0VBN5FRFTjVxXF4pzKNzqg7Z82LBFCpx5xKi4EL0=
X-Gm-Gg: ATEYQzx2fFukIL2Kd8hUirOASvxZhy1iDqXd4nwcKmQdRLSNzqKqSCyhoackCeQvQa4
	LUXyD6BfW2iKUVTUlVK2qDWaRNXGHhxF1Pbs9dNZHyjJW/hKaBMXgkpI57LRmkLkC9YrtQ/P9HZ
	k+sESWrEjUmUa92ggTu+EzoXOuJ4VV+6DB+wZDEAq7uOe9ZW0TAAtxZ1N2iKh0/bgwh6ThS9tqW
	r5JS5JetBdV22S/QPzqMLuPudYqHWVseiGE3+1raLwN4bsR21J04rz6USq0Arj8rfbAfBRIMmlV
	JLvcAuqQMOEykJKp9FV696H5uoRNxcbpfden/jZDNMGStfhKQtvsskaeiPmWa9H7K4487E/YUjW
	NtbS7ZWKXzVmPfDVZVmhnw3Ofgn88rHwehldjArZj2qZvrpU/eOzfv77jBsPTNWY79ipD+N3kwN
	rucq5bWCHyQ1D+WxH0SWL7WIJ+doWcDOmcoziLJD9IRumUmERpUnBm0mrdOx5aV7uZmskPNw==
X-Received: by 2002:a05:620a:2991:b0:8cf:cfdf:733e with SMTP id af79cd13be357-8d01c689577mr1767721685a.32.1774909592771;
        Mon, 30 Mar 2026 15:26:32 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028090f43sm711572985a.45.2026.03.30.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 15:26:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7L43-00000005H5o-0vBI;
	Mon, 30 Mar 2026 19:26:31 -0300
Date: Mon, 30 Mar 2026 19:26:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gerd Bayer <gbayer@linux.ibm.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Leon Romanovsky <leon@kernel.org>,
	Michal Kalderon <mkalderon@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v7 1/3] PCI: AtomicOps: Do not enable requests by RCiEPs
Message-ID: <20260330222631.GF246076@ziepe.ca>
References: <20260330-fix_pciatops-v7-1-f601818417e8@linux.ibm.com>
 <20260330214253.GA92498@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330214253.GA92498@bhelgaas>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18814-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BFC3A361F41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 04:42:53PM -0500, Bjorn Helgaas wrote:
> [+to amdgpu, bnxe_re, mlx5 IB, qedr, mlx5 maintainers]
> 
> On Mon, Mar 30, 2026 at 03:09:44PM +0200, Gerd Bayer wrote:
> > Since root complex integrated end points (RCiEPs) attach to a bus that
> > has no bridge device describing the root port, the capability to
> > complete AtomicOps requests cannot be determined with PCIe methods.
> > 
> > Change default of pci_enable_atomic_ops_to_root() to not enable
> > AtomicOps requests on RCiEPs.
> 
> I know I suggested this because there's nothing explicit that tells us
> whether the RC supports atomic ops from RCiEPs [1].  But I'm concerned
> that GPUs, infiniband HCAs, and NICs that use atomic ops may be
> implemented as RCiEPs and would be broken by this.

AFAIK none of the NICs are integrated into root complexes in their
topology model..

Jason


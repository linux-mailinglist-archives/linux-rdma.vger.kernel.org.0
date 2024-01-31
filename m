Return-Path: <linux-rdma+bounces-835-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D1844066
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 14:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE69B2ECFA
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1866B7BAEC;
	Wed, 31 Jan 2024 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LaHpckYC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9979DB6
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707115; cv=none; b=iGZ0MI/PG+n+NBIac950afCjSlggkCZqV57DSfcNL30SNIv8P+Hhlkz4a1syq0PZv8MkS+f5B4YubhWZJkpGndNJ/Bp0ORe2mUeED1OC2qVtnxBSQyIHAOSFOEfl5Z1AalVgikINGEcT90SkfgXX+2u8A8aZSnUs6TD2pjgS+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707115; c=relaxed/simple;
	bh=lrPNbqp+OZRTIn9987fdKNgyTo4PacMDCTR9zAkjJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMP8dhcSVZ8i2g6iijLD3JIuDfm/U+jqyzdlsKaWXNGYYQKuDD05DEjUmzOfyWRLznknhjWyPNpKJ6phmyDPsAaEmqcsNqyafxa/6O0PLJjQyT2vIGzASwlpSpinGG9uez71aT6BlKBrb8im31X6PyVT2m6fetfV9oDK9QGCPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LaHpckYC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RyPW6XVd2RR5+mbTG8L0WuDlJGFM9PyJgN94TlaKNoU=; b=LaHpckYCsEwsEQtEZDjCa+rxwA
	RhkEG1dmInbH/WWQ0xMdVwJ1oogqNL+xPX6B41qybeoDkZwvGIip30u4kfsB1G1aOc4NWUKwvqpR2
	OVhl4R5sCwXs16k/FkQgW7D3bWr3xxzfU+ggRgI8UGjNZM2bh1HnqzYZK1I39RnWBOYIlxxzuqLRm
	rqhi99UPOWetsHsrEkiuGON2H13KU7uz7dTrCcHneWEnY4QP2kEsDxA8hl4r6B1WFn/lz/91H2AAi
	IjNp5roT/IglTgWbKLluzxHMOBBMj/YluuU1LeeM98WpmxapAF0bgF/DPduHcztXRQxIyXunYbOeP
	EY7OlTcA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAU4-00000003Ztm-2TbS;
	Wed, 31 Jan 2024 13:18:32 +0000
Date: Wed, 31 Jan 2024 05:18:32 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Arthur Muller <arthur_mueller@gmx.net>
Cc: Martin Oliveira <Martin.Oliveira@eideticom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Kelly Ursenbach <Kelly.Ursenbach@eideticom.com>,
	"Lee, Jason" <jasonlee@lanl.gov>,
	Logan Gunthorpe <Logan.Gunthorpe@eideticom.com>
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
Message-ID: <ZbpIqA9eZ5YYJOPO@infradead.org>
References: <MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
 <9a40e66eb8ffc48a2e3765cf77f49914d57c55e7.camel@gmx.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a40e66eb8ffc48a2e3765cf77f49914d57c55e7.camel@gmx.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jan 31, 2024 at 06:34:00AM +0100, Arthur Muller wrote:
> Dear all,
> 
> We've encountered a similar issue. In our case, we are using the Lustre
> file system instead of NVMe-oF to connect our storage over the network.
> Our setup involves an AMD EPYC 7282 machine paired with Mellanox
> MT28908 cards. Following the guidelines in the Nvidia documentation:
> 
> https://docs.nvidia.com/networking/display/mlnxenv584150lts/installing+mlnx_en#src-2477565014_InstallingMLNX_EN-InstallationModes
> 
> we compiled the MLNX_EN 5.8 LTS driver using VMA. Additionally, we
> experimented with the latest MLNX_EN 23.10 driver, encountering the
> same issue. 

If you use the nvidia out of tree junk you are completely on your own
and have no one to blame but yourself.  Any problems with that do not
belong on a Linux mailing list.



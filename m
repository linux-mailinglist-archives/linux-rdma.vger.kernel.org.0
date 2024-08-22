Return-Path: <linux-rdma+bounces-4479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90E095A8E7
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 02:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AC11F2267F
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 00:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879C6179AE;
	Thu, 22 Aug 2024 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUp9FCJP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DF3D53C;
	Thu, 22 Aug 2024 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286653; cv=none; b=PxU9e8lt88s+QFY56qEylorrTy7riRoCwSi5p+R8bpT00F7sKf8wWnnOk3sCE9ytpKOlZcpyG9s8v9IzX04PnkNnB1Ry7hTcLqP4DUeadl5w0T/4+RDHnn27C4iTforGsPp1SAUMwTB1iNyrJ/2RF820pGkUTiczB9Qp82PhNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286653; c=relaxed/simple;
	bh=V3Uh6C19f9jtTqekCLCV/Od6meKawk7FjOuYq0w3R3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBsz5n9UR1npjn4Jz5k08Tk5aVpPou03CfMzZqWm34p7zFp0P9LDMhh+y1X8ywikT3A1XiQzlMT4/I/RTS08+3+IbvFbwx8S0DOsze5LwcWG7sgEfgctxWnkpGpTZ93EFmoOwz+hWgwc1rKYYCzVcYOyafj36XbmmkCAc600Rws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUp9FCJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA46C4AF10;
	Thu, 22 Aug 2024 00:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724286653;
	bh=V3Uh6C19f9jtTqekCLCV/Od6meKawk7FjOuYq0w3R3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iUp9FCJPW+Stoik/33wDpjXItQlwDbS7PH3BqD61xAx7JXUlMYTRoi3i88UxkaT5D
	 A2iAmctPXLN6A2PwnJ6k8JkZCkOQBAOnhwKhid4hfGcnbB1vCawFbqpALkLEEdu+wq
	 RX4eTRWuJQECznK00eQIE9sDxitE/qpB8c5kgcpoy0mifV0KTNLvF87n9nWVq9ieI8
	 msIcArbRditB1jbTmFYW+wjb4Iw8b4JD2DVNK5OG3tCXYK0xP6kEstLbkWw1siGiNs
	 m+Yp4Iz6uDPILxQcKfb8+N2GFd6ctwBuc/Vm6LbOmHi4RtllDz7yZwX4aN61kPHeCT
	 F8BzIi8uYWTbA==
Date: Wed, 21 Aug 2024 17:30:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Itay
 Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Leonid Bloch
 <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>
Subject: Re: [PATCH v3 05/10] fwctl: FWCTL_RPC to execute a Remote Procedure
 Call to device firmware
Message-ID: <20240821173051.4c4bf1f2@kernel.org>
In-Reply-To: <20240822001434.GN3773488@nvidia.com>
References: <0-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
	<5-v3-960f17f90f17+516-fwctl_jgg@nvidia.com>
	<20240821164950.486849ca@kernel.org>
	<20240822001434.GN3773488@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Aug 2024 21:14:34 -0300 Jason Gunthorpe wrote:
> > Nacked-by: Jakub Kicinski <kuba@kernel.org> # RFC 3514  
> 
> Your "evil bit" thing has been responded to already and that isn't how
> it works.

"Isn't how it works"? Please just carry the tag and don't waste my time.

> You never asked me for netdev ccs.

I definitely have. Either you or Saeed who was posting the earlier
revisions.


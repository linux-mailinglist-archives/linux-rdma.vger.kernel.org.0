Return-Path: <linux-rdma+bounces-2211-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411FE8B9EF8
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 18:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A751C21CF2
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2024 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECA916D9D1;
	Thu,  2 May 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyPQpixP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0945FB9C
	for <linux-rdma@vger.kernel.org>; Thu,  2 May 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668867; cv=none; b=rPGmXKNiqjct0hn7OKb931WArNZ0W0gBNTZmd1IMirbtkbsYPSfSPqZY4M5BSb+dBsR/uPOhNfULAgHTjyyD2AJtDP41R+JHhB5KZ/cG+jgACI0Kc8sw+JXTTvs5mMMi0PXR/96rAJTzq3so0i8fWffhjeM5nvOzHnKPWc5FzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668867; c=relaxed/simple;
	bh=PTgqMfzMNo3u/7ipB9GNQC917i8pPD5zWDHzqa4ua7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tMuXGjc4/VWgtfUTq46V04cc35Ui2/Whaja0XS6dbVFCkMRLoXTJTFVdK5eWoTBEShRrSIMFgLpFlhJPYX4MWhx/6RlaquMQXyhDgGwWYWWvNRtV29wAfQfm4HbTDuT0fhPJnmHhfF2pSD+/9Cnp2RKIn6kp4EhPNB/bD8HrLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyPQpixP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3693C113CC;
	Thu,  2 May 2024 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714668867;
	bh=PTgqMfzMNo3u/7ipB9GNQC917i8pPD5zWDHzqa4ua7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyPQpixPWQVah3k7yXc6WC0/TiA9gBixFv+p0c2sJAg3bf9mFQ6bucPiedCQhYw4s
	 oVjkd3dutxKEs7XtQ9C99KRwv28zR46e37ExZQIZ6cutXu3Xs7EBZ0e1k0K+8viW1m
	 JDGS641+AJIi8Ar3RcPWnOu9yxKfi/bJhzKNtQLeVg/er1JM0LvGVbju8fiyELnOvt
	 JLQW4Hdtmzguju9oqZeAuP0dGbTJeV7jcqoAy+fTNpM7Y5vhZrRdNdoC8n1amjJBst
	 YnyL5bkZ97OvZ78d1CoYQI+96QWoQnLxOxbyg+B319arNZQ5D1WzjNqwprXPdxbo77
	 mzYQ02SAPkY6w==
Date: Thu, 2 May 2024 19:54:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ewen Chan <alpha754293@hotmail.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: SRIOV virtual functions with Linux "inbox" opensm
Message-ID: <20240502165422.GK100414@unreal>
References: <SA1P221MB10184D6002569E274E6630D7B5122@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>
 <20240430120303.GB100414@unreal>
 <SA1P221MB1018617920998E6E4F74931AB5192@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1P221MB1018617920998E6E4F74931AB5192@SA1P221MB1018.NAMP221.PROD.OUTLOOK.COM>

On Wed, May 01, 2024 at 04:43:39AM +0000, Ewen Chan wrote:
> Leon:
> 
> I see in the link that you provided that the IB management packages are only available for Redhat.
> 
> Would it be safe to assume that there are no Debian equivalent to these packages?

Right, at the moment, there is no Debian equivalent to these packages.

Thanks

> 
> Your help is greatly appreciated.
> 
> Thank you.
> 
> 
> 
> 
> From: Leon Romanovsky <leon@kernel.org>
> Sent: April 30, 2024 8:03 AM
> To: Ewen Chan <alpha754293@hotmail.com>
> Cc: linux-rdma@vger.kernel.org <linux-rdma@vger.kernel.org>
> Subject: Re: SRIOV virtual functions with Linux "inbox" opensm
>  
> On Mon, Apr 22, 2024 at 10:09:15AM +0000, Ewen Chan wrote:
> > To Whom It May Concern:
> >
> > I am using a few Mellanox ConnectX-4 100 Gbps Infiniband NIC that's connected together via a Mellanox MSB7890 externally managed switch.
> >
> > I have a dual Xeon E5-2697A v4, Proxmox 7.4-17 (Debian 11) server that's running opensm, along with two AMD Ryzen 5950X compute nodes, that also have the ConnectX-4 in them, running Proxmox 7.4-17 as well.
> >
> > I have enabled SR-IOV on all three systems, and all three systems have 8 virtual functions for said ConnectX-4.
> >
> > I read in the Nvidia/Mellanox documentation that I would need to add the parameter "virt_enabled 2" to /etc/opensm/opensm.conf so that the OpenSM subnet manager will know that virtual functions are enabled, but it would appear that the opensm that ships with Debian 11/linux-rdma, either ignores that option or doesn't know what to do with it.
> >
> > I would prefer NOT to install the MLNX_OFED drivers for Debian (11) if I can avoid it.
> >
> > My two questions are how do I get the linux opensm to:
> >
> >     Recognise that I am using virtual functions (so that it would understand that there are multiple traffic streams coming over the wire, via one physical port)?
> >
> >     Automatically assign the Node GUID and Port GUID so that I don't have to set those manually.
> >
> >     (I've set the Node GUID and Port GUID on the my Ryzen compute node host already, and I can see the Node GUID and Port GUID inside my CentOS 7.7.1908 VM (which I've updated to use the 5.4.247 kernel), but it is still showing "Port 1, State: Down".)
> >
> >
> > Your help is greatly appreciated.
> 
> Linux opensm is not supporting ConnectX4+ SRIOV.
> 
> You can install SM RPM from NVIDIA Web to enable ConnectX4 SRIOV.
> https://network.nvidia.com/products/adapter-software/infiniband-management-and-monitoring-tools/
> 
> Thanks
> 
> >
> > Thank you.
> >


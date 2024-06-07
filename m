Return-Path: <linux-rdma+bounces-2992-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEB2900407
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 14:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B1BB23997
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jun 2024 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D5918F2D9;
	Fri,  7 Jun 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="icGmWSfV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6721E4A1;
	Fri,  7 Jun 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717764586; cv=none; b=DFVvJV37hPMFzoMz4BXyVME4MUHghun5+aBYKJk0UvrZdtylGw9oMKB1hi8lW+wq4ShNofhh1W2lBNskloenbnyy/9PawnnfdYj21L8CU6IT0/6zHsUlVu4sCsV44Gn4qDw8I6syFIU77asx3LTQUJDSe9jinQH9/s4v4CpWwkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717764586; c=relaxed/simple;
	bh=Bfgfa143G4DHdrFe7lxSCSckblGF7uW5HXJRY2g1Q6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfiySXTGLgDlFyI1RQURHPw376xceLgwHWn9NDtTkTMNwep5a6NOd+VGWEn5wg8sO1W2oMNZCLkP2ko3JXhIc/qDRAtLtgAAqYD+o7ks4ICWifBi9Qanl8NbZJK85okhEBYKI+Pcdc9C6eIDw6e9kPF8U2vX306oGOrWhdnTIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=icGmWSfV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=G2qEK1PosUxBiovM8jMSdaJor4MsDmSI8cQfYuLb8v4=; b=icGmWSfVRWu/nowvbGDdkxIefB
	Pw4kINXDgRgGLW6DDe/Pl8k00+2s7sv0+3jNHfilNvg7Nk91KDlypBb0rBGQV7kNRWULLnfu8t7X/
	fP1VblNceZpzPlMvZEwiVHu1TRmveJpnB2He2leRmCO4K1lwcPBnDEcT/uX7zPnZ/8Ok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sFZ20-00H7iB-0G; Fri, 07 Jun 2024 14:49:20 +0200
Date: Fri, 7 Jun 2024 14:49:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <b023413e-d6e1-4a47-bdf2-98cc57a2e0ae@lunn.ch>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
 <20240606071811.34767cce@kernel.org>
 <ZmK3-rkibH8j4ZwM@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmK3-rkibH8j4ZwM@nanopsycho.orion>

> >This API gives user space SDKs a trivial way of implementing all
> >switching, routing, filtering, QoS offloads etc.
> >An argument can be made that given somewhat mixed switchdev experience
> 
> Can you elaborabe a bit more what you mean by "mixed switchdev
> experience" please?

I don't want to put words in Jakubs mouth but, in my opinion,
switchdev has been great for SoHo switches. We have over 100
supported, mostly implemented by the community, but some vendors also
supporting their own hardware.

We have two enterprise switch families supported, each by its own
vendor. And we have one TOR switch family supported by the vendor.

So i would say switchdev has worked out great for SoHo, but kernel
bypass is still the norm for most things bigger than SoHo.

Why? My guess is, the products with a SoHo switch is not actually a
switch. It is a wifi box, with a switch. It is a cable modem, with a
switch. It is an inflight entertainment system, with a switch, etc.
It is much easier to build such multi-purpose systems when everything
is nicely integrated into the kernel, you don't have to fight with
multiple vendors supplying SDKs which only work on a disjoint set of
kernels, etc.

For bigger, single purpose devices, it is just a switch, there is less
inconvenience of using just one vendor SDK, on top of the vendor
proscribed kernel.

	Andrew



Return-Path: <linux-rdma+bounces-8983-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F8DA71CBF
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 18:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41173B7A9D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 17:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752C1F91F6;
	Wed, 26 Mar 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BU9Og08n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC581F8690;
	Wed, 26 Mar 2025 17:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009193; cv=none; b=YrDaclU+SXR10Fv8cHR5zMCNHN86sWw2nZWGtPQrwcH8V99JhGjHF4bhBPGGSzMCBXkKyEA4/5EMqDqjWJs5Uyb5wcl6C+rNdXP1//rC24kS7coOp0dBM/FhJsgNRYT1nEu/0qIGAUFVxn6+NdDeR6bNqT+v1XOvlIMu37ba2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009193; c=relaxed/simple;
	bh=fvBB9wfDxXxV/ks7FzUXd+XOOYLlUbJCbYYrEydpVDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U82CYy+m1x1GbJZCbvw6I5kzvBwURdSZqKU9T9tJPj3Uuv/r8sGAKHjMNe2/obWoKzAEO7O4ofefS1qmaP8U9ecf3N3NSNtD7/f1GbAJuKmB5skWTTK9xAWwo4t54te/CZgWeACy/G9vUr5fxO6yjLD4Xx6N6Vt26gIDoe7bpoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BU9Og08n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D54CC4CEE2;
	Wed, 26 Mar 2025 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743009193;
	bh=fvBB9wfDxXxV/ks7FzUXd+XOOYLlUbJCbYYrEydpVDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BU9Og08nAoFqvnMuxVRNOIaXfo8guOUZcGuXJNpDNpnwD16jswzRjpEgYqxrqRtJ9
	 YiIDES6bu3d5BbQOxjPahBvoOUPd5Zc4VZW3/lg70nEAJS2CiMGNIxix4P/JAAR5PY
	 WYJOQsGOv3Kv7rEvdsft9cPxRzcQMLvq9hnEJitRMIUkcHTpQwn0599/5Oq4NAkwhI
	 tz+/JkaFPVffai6wHh9OPVwaqSBTF+NEyAA/6aoy8L2q9KynnS/BUev4p5koWVj/0E
	 41FOvvnCjYLMdI3FCJ6QpoWORiNqGLQa2+JGDEUixW4n/PRyTsgE+fOWj75lFJ4mLo
	 S3fAfuxKJTKvA==
Date: Wed, 26 Mar 2025 10:13:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Dave Jiang <dave.jiang@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
 Shannon Nelson <shannon.nelson@amd.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Please pull fwctl subsystem changes
Message-ID: <20250326101312.7557b3d1@kernel.org>
In-Reply-To: <Z+F2tcBM1LJpTDF9@nvidia.com>
References: <Z+F2tcBM1LJpTDF9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 12:13:57 -0300 Jason Gunthorpe wrote:
> fwctl is a new subsystem intended to bring some common rules and order to
> the growing pattern of exposing a secure FW interface directly to
> userspace. Unlike existing places like RDMA/DRM/VFIO/uacce that are
> exposing a device for datapath operations fwctl is focused on debugging,
> configuration and provisioning of the device. It will not have the
> necessary features like interrupt delivery to support a datapath.
> 
> This concept is similar to the long standing practice in the "HW" RAID
> space of having a device specific misc device to manage the RAID
> controller FW. fwctl generalizes this notion of a companion debug and
> management interface that goes along with a dataplane implemented in an
> appropriate subsystem.

This breaks netdev's long standing policy against exposing proprietary
interfaces (proprietary user space <> proprietary FW). I've been asking
all this time for the interface to be disabled if the device is used
purely as a netdev. Hopefully retaining the benefits of community
standards for majority of users who only use netdev. This has not been
done. 


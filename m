Return-Path: <linux-rdma+bounces-4100-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53AC9412F5
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 15:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9E11C22539
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C96519F495;
	Tue, 30 Jul 2024 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f34Ys4YJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1C19F461;
	Tue, 30 Jul 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722345588; cv=none; b=p7h1ayIo0Uu+EyGvGN4PC+Zq4yU3YzRUDho1Hj7PW6Cyqwb/fl1nZVvgKu0hg7+/xvQDiBDLL/wx7moVz26xtceg7A40jHksjh6aB1AmIUY9K1eR54eVc9HlxZo1KY+7LqesnGo3NRq2jyS/1s00dFhsFEjJoEjg+E12R/eAWl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722345588; c=relaxed/simple;
	bh=shET7++dHCt9/Z8YVKh9qnbzU+cUXl9oYnQ7KccNs2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyMMatScEKJm1mT0yQe+E/skE9wKsNk8nNHOzjB6kIvy3YPXC9qaxNNJ5l0XGrkxqpBmvn/2NTOnMoSe3ks5tXht9I5U6mp0o25xU8h+noRUj4TYIZAYoA+F/sxnG0HmQuHhgdRhE+N50Re7qHFG19UxEKlDTB6hktOpK5uq9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f34Ys4YJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C541E40E0205;
	Tue, 30 Jul 2024 13:19:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fBqAozI4p1MH; Tue, 30 Jul 2024 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722345580; bh=FlasjGTrAQM5tzrEQba/+nuqA8c0Yk58VBHRZXHafyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f34Ys4YJ2AXVe0yM93AS0d+NPUoX43ij4tSdBywbe0Pm2oD4PcmeI5CNPaOCAkX9I
	 ofc23rY6rd6O6odqpefSN1iIK/VtRAxcPudDKoeL+CC11yDadaNvONUF/0UIlKN3nI
	 AKRiC0XmlVYTpglIU+GeAGhkkTl4ggHKaY8f1cbAdvF77I6VyoXb8BYoVeZlQ96CC8
	 +Q8VFzkcLjduJmt58a2lEGaoaUf4dJNt9/Gf7LmWtMCv69awSV7emBdXPwFLMjzXZy
	 tMYb1d7d4creQOTCYArJjKbpb6bMZQydIBwCzDMR6P0FNUZtP53JtB1jFwiBdCk4rq
	 K2hBDUtOEANqts2IlwfEk/Z2xmhjGwfzTvCvOGR931OKZ/WiLRMAh4ot6ZdxA73IyG
	 baYFFDeO5EE2VHn4P0bOxexkF26WculZYWW5NpmT77OK/KTStGwkxxovwlZo5KZd/G
	 wjK40+GViT28Cf6QicA0rlbwMmomDATbvP4Oc9syt1OhQR82/kXeGmCuw41Ll5EGFM
	 aCg6t6+gLZbkTBlVRXdfXbRmXB9MtYXzenG9BApaKJrBalXlNxmh0CZczOvQFqjPPW
	 p9Zz6Jehm4KTMjhb4/zN8eHsWG+hbcnsT7RGPCDjzuihDTr3+zz56zHxvYe7qerxBH
	 Hz6zzDv0SfqLpdM9Ri0tq+6c=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51F1440E019C;
	Tue, 30 Jul 2024 13:19:31 +0000 (UTC)
Date: Tue, 30 Jul 2024 15:19:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, shiju.jose@huawei.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240730131930.GCZqjoYm89oz7CXyJg@fat_crate.local>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240729134512.0000487f@Huawei.com>
 <20240729133839.GDZqebX1LXB-Pt7_iO@fat_crate.local>
 <20240729152943.000009af@Huawei.com>
 <20240729145850.GD3371438@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240729145850.GD3371438@nvidia.com>

On Mon, Jul 29, 2024 at 11:58:50AM -0300, Jason Gunthorpe wrote:
> Like continuous memory scrubbing and EDAC is not really fwctl since it
> is part of the main mission of a memory device. However evaluating the
> memory to measure current ECC error rate for data collection and
> debugging would be appropriate for fwctl.

fwctl?

What's that? Something to do with "firmware"? If so, how does this thing have
anything to do with RAS stuff?

We have rasdaemon for that where all the RAS controlling and evaluation goes
into.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


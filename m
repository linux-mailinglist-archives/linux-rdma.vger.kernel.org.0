Return-Path: <linux-rdma+bounces-11646-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05A9AE9059
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 23:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0622C5A80A1
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jun 2025 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904722580E1;
	Wed, 25 Jun 2025 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQXqfcZ0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255E25394B;
	Wed, 25 Jun 2025 21:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887875; cv=none; b=M0M4X7mgSFL/r8XZrwkSC1lvuSGFtx6qVyiv6BJcyFTth2nI05/OpoArk5sstNgHWutN9lFQtv/m7+4k5anPWWvKAgewWJH7AhiaLNLDVjxyXqK9R7M//2U5+OR3QA0trXpIEWmZbN1ZicsmvCBzp76zXwEFO1XeIrXw7yM+j0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887875; c=relaxed/simple;
	bh=hqwh/dY21896bJrYmX4Yv2JQEBkEGWOtQ4EieyahV0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqGxw0GoR0NwoxT5GLxaE93MUjkXbh8p7rkBEbc8DugWpM39Vq68cy1r8zacYL/3gcKulU8bmD5c9jCSwGvBUfeemi5RnRr2sQetOAcLOt/ePRNk+GFoP3z1IEX28IQYFHYzKsIMA+GlORKTOLuzZge5cHLIlU40OjanmI0Q9UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQXqfcZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF20C4CEEA;
	Wed, 25 Jun 2025 21:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750887874;
	bh=hqwh/dY21896bJrYmX4Yv2JQEBkEGWOtQ4EieyahV0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HQXqfcZ0/Kcqmss3IWi1xMaMcs71wHzEtxwKgVHCGzLz83CD1zoy6VcIj/0pSdQhJ
	 SJFpM6+OJG9XD/tSnFa+TfqEtjB22b4EozdERECwPWwCVHWdeeSuRZjTkCKuOejVYW
	 +6h4KY9rrdfOEx4bt4Re7FrA8McslCP+gClT1PDObQjVAlqLdjSi0db9VZJDF2k6kQ
	 iOxzawW88+1cKOBnUfLfDKLwH0f2N4FoPE9pXlXWOFG8RAQbM+RdcyHaagvvbi1XGl
	 AQbaEvYXoTkoO9uvqNXB021ZgS+NHzE+R3IFvCWJ5VR62K7Vb00vjQQ+6W6IUD3+HF
	 fn4z1XJ0GyxBA==
Date: Wed, 25 Jun 2025 14:44:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: <shannon.nelson@amd.com>, <brett.creeley@amd.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>,
 <andrew+netdev@lunn.ch>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
 <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/14] Introduce AMD Pensando RDMA driver
Message-ID: <20250625144433.351c7be4@kernel.org>
In-Reply-To: <20250624121315.739049-1-abhijit.gangurde@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 17:43:01 +0530 Abhijit Gangurde wrote:
> This patchset introduces an RDMA driver for the AMD Pensando adapter.
> An AMD Pensando Ethernet device with RDMA capabilities extends its
> functionality through an auxiliary device.
> 
> The first 6 patches of the series modify the ionic Ethernet driver
> to support the RDMA driver. The ionic RDMA driver implementation is
> split into the remaining 8 patches.

Nothing exciting here from the Ethernet side, AFACT.
Once it's ready to be merged from RDMA side could you put it on a
branch so both trees can merge? Unless you have no other patches 
ethernet for ionic in this release cycle..


Return-Path: <linux-rdma+bounces-8065-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB63A43892
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 10:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F416C1685A1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 09:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F2267F7B;
	Tue, 25 Feb 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="O884BqCB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0F267B9E;
	Tue, 25 Feb 2025 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473870; cv=none; b=Ofoh7SFobBcU9kJJuID0kSJF2ed733A8mlY87tNJUDV3OJOOjXDB3SQoO30RnEFpzGm89f8rOoqjUbToG3mA0OxJ7h7ZQDotyt0Fml6FYC1bosn5iymAOdha29bhtLxHJ63IjjTpGv81YgzaBA66NRTk7znH02m+c7FlGfulcP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473870; c=relaxed/simple;
	bh=eYZp9i5fVrw5bx7U2Td0qHV1PiM1BEYZra34O9ZwKMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEa4YgMOBgJdf/jiGhbWiBBeOC9NpVbF1hf3FdpsbYmwnB2QE3IhxlUqqRGGOuCK5EJ1QmbeTDjtYxzZo4gDmyY6xoJBv0JGFw5nnMEcSjMFx0B2YcMhpvDQPxmnxGqhcCOqL+MU+MXwBo+rijSi0gH5Ak75xuATyNlGPoeQvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=O884BqCB; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6477B20799;
	Tue, 25 Feb 2025 09:57:45 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Xi-FHaOAzru; Tue, 25 Feb 2025 09:57:44 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8DFC32050A;
	Tue, 25 Feb 2025 09:57:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8DFC32050A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1740473864;
	bh=KO8QT1Iud2j7VddE/JgWZ6zVDpqfkHfxQ9iGzJdyXlA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=O884BqCB+2PDt7/FG+IfXb4WPIOnChiGWm5WWq+2pT+Rqlscx5O7PCQNReE6yHd+t
	 wVUcFru8nNgtg9SCQPFh3Q+13UNXJ1bWkPTI6h2B3nP01iSw3AY89yd4tagjbTLRXs
	 Sc9amBwHuomP2H4FXE9Ir/89yOFheh98Yu4pfP2sShIbKXDpggGQYGRbpUI1U3GydN
	 uNeLSwvDk7AOb04jwK3ouTeVvOQGL31nXhWNvcPS60c1/mw8BmV5b4d1h8dWBvZWF8
	 nU0rGs4im59pTYSOEqWM0oErNGY3SATZQK6RnHO4SjY2whOmEd/6lC+P3obB1Yy3+D
	 0IRRrKP9gVtDg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Feb 2025 09:57:44 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 09:57:43 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 4C09F3182E64; Tue, 25 Feb 2025 09:57:43 +0100 (CET)
Date: Tue, 25 Feb 2025 09:57:43 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Ayush Sawal
	<ayush.sawal@chelsio.com>, Bharat Bhushan <bbhushan2@marvell.com>, "Eric
 Dumazet" <edumazet@google.com>, Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Jay
 Vosburgh" <jv@jvosburgh.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Louis Peens
	<louis.peens@corigine.com>, <netdev@vger.kernel.org>,
	<oss-drivers@corigine.com>, Paolo Abeni <pabeni@redhat.com>, "Potnuri Bharat
 Teja" <bharat@chelsio.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>, Tariq Toukan <tariqt@nvidia.com>, "Tony
 Nguyen" <anthony.l.nguyen@intel.com>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	Bharat Bhushan <bharatb.linux@gmail.com>
Subject: Re: [PATCH ipsec-next v1 0/5] Support PMTU in tunnel mode for packet
 offload
Message-ID: <Z72GB6wIUgDqunsQ@gauss3.secunet.de>
References: <cover.1739972570.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1739972570.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Feb 19, 2025 at 03:50:56PM +0200, Leon Romanovsky wrote:
> Changelog:
> v1:
>  * Changed signature and names of functions which set and clear type_offload
>  * Fixed typos
>  * Add Zhu's ROB tag
> v0: https://lore.kernel.org/all/cover.1738778580.git.leon@kernel.org
> 
> Hi,
> 
> This series refactors the xdo_dev_offload_ok() to be global place for
> drivers to check if their offload can perform encryption for xmit
> packets.
> 
> Such common place gives us an option to check MTU and PMTU at one place.
> 
> Thanks
> 
> Leon Romanovsky (5):
>   xfrm: delay initialization of offload path till its actually requested
>   xfrm: simplify SA initialization routine
>   xfrm: rely on XFRM offload
>   xfrm: provide common xdo_dev_offload_ok callback implementation
>   xfrm: check for PMTU in tunnel mode for packet offload

Series applied, thanks a lot Leon!


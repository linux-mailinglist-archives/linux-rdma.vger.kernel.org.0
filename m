Return-Path: <linux-rdma+bounces-11655-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975ACAE9697
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 09:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD87A5A5FF5
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 07:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFBA238D53;
	Thu, 26 Jun 2025 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVpVh8Te"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0E71411EB;
	Thu, 26 Jun 2025 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750921676; cv=none; b=XgbaDg0gEQnCTm9txRTqrlwJ+pDijuYvk5pSs2+xrXqDfGcvBc8DYTpnaOl0kmEgKGTZkX8ZrLyruJoIAoj34zQ7o86arZiCXJfSMWiJkFzNCGnfOalGRvJk2Ock+4Q2AYvv0KrvjTxHhSgEOhFwl45W4PbkvR/L9faCl9JVGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750921676; c=relaxed/simple;
	bh=ASdlCp2McvG3ZeOs/MGNcslmJonLmJnZEUqVNr4Qxt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bR5GjO3dQai9RXg3bacadEFMqxHVL84ysp3kpIIYc2/Q7C9hOIFcGPZc9ykZJwNNdVQTVpOJ2hIYHbAB3m8QjqHUr09bWiFVvOgtxpLzX2LMrlyeSbIU8j6kFWnfXv+BKLWWFbR3I6/pC4M4QQOyQ3Bawz1Bdu2wRMpu4AvkqJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVpVh8Te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9980FC4CEEB;
	Thu, 26 Jun 2025 07:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750921673;
	bh=ASdlCp2McvG3ZeOs/MGNcslmJonLmJnZEUqVNr4Qxt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVpVh8TecTjmcWu9hcESSWFZs0woLHXrnb4BpI/4b9Itg1oEBkQdSrhuac+ImLMYG
	 ZYk+XtIfVxT2K2GM99996IB6zadBcAnAYwbjrgAiqoxMTthbSWg4bnDRonAH2TOwMP
	 b+DEKuXi0RnibmWxJ0LOSyvOkSxj9B74hkQt3IY6QnyEUj+AV6fiKC5Lx6lRkMJjP2
	 YKpwJkqVQaUQuyJ7fcmvnpPOOv8COvx/w7cLR96d8Z4p+yxUacTnF0IVrnFYqX50p6
	 oDWnhkW60l2HlLZi02mIBELLTS3CfUQH2M9WdFb1rIYJlqtYekLSy7hwey+wy2LAr3
	 PQT6ltwxADhbw==
Date: Thu, 26 Jun 2025 10:07:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, jgg@ziepe.ca, andrew+netdev@lunn.ch,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] Introduce AMD Pensando RDMA driver
Message-ID: <20250626070748.GH17401@unreal>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624121315.739049-1-abhijit.gangurde@amd.com>

On Tue, Jun 24, 2025 at 05:43:01PM +0530, Abhijit Gangurde wrote:
> This patchset introduces an RDMA driver for the AMD Pensando adapter.

Please send PR with user-space part for this driver.
https://github.com/linux-rdma/rdma-core/pulls

Thanks


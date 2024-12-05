Return-Path: <linux-rdma+bounces-6261-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CB39E4FC6
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 09:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDEF2817EA
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Dec 2024 08:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55A71D47CB;
	Thu,  5 Dec 2024 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0UHqCT4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7EF1D2B22;
	Thu,  5 Dec 2024 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387567; cv=none; b=K7+y0CwRhmy+ohEEp3vieiFY8Jm39H8d29lZmawKceQPwnlbAuo1NHNqV/JTJqYN4aheQLb6B1PPk9QredVxkthKCySWvbaTVQLqo3lSSKtAKECGdYgK50l9RcjC3TzFBb55dMpHHZb6YPhak8DD60drLWB39G6drzS0mZF3V2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387567; c=relaxed/simple;
	bh=L3Q4+XFEGZLsE/qvoDe6aqx3738LMaa3603y9rqxW4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQPRb6sAGOMdZXG+caksTnSVVTtNemKN6vMjcV0I8PJlcSlgsEfcNiaiUXO01OtR2UQNQcpuzNNkvbvbSpN6fbqwPSryVCPkwFuB8hOPNT/ic4DG/eZf2JM4Ue7cvK+JxXERqLzmpqy7ajJZNgTaHVFTtUr+4oa+y6dhviTMRow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0UHqCT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3862C4CEDF;
	Thu,  5 Dec 2024 08:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733387566;
	bh=L3Q4+XFEGZLsE/qvoDe6aqx3738LMaa3603y9rqxW4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0UHqCT4EIGJcE7V35yuXymaT2kuYtB6gECL1hj5SnK5kjWJqgqULtr/6Yk2CBdUD
	 u5J7femdAkye+GuUHdUsemJF4RNKmj6vZqNVLOnTQQatF0tOUQYoilO8LBXMWM8GcK
	 aIVkKsSiWvKuS1rSHBn70c4voCBjyulJuAWCiylMbn3xbmjUabiEJcA4HDFiVZYTIP
	 F1SvfLwEGVOJNn4Xvcokkeqf9UinQlL6LmflueBEcMNjqJDBP16+/+0oiKsFPFU57a
	 WX7YEHLXXxRLqBgMeA1wgCHdeTEuFaKCR96Z3bdurCm+Q8ddDCAN9+3N5x5hh75QLt
	 ONHuMGrbF5Msw==
Date: Thu, 5 Dec 2024 10:32:40 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net/mlx5: DR, prevent potential error pointer
 dereference
Message-ID: <20241205083240.GS1245331@unreal>
References: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
 <ad93dd90-671b-4c0e-8a96-9dab239a5d07@intel.com>
 <bf47a26a-ec69-433b-9cf9-667f9bccbec1@stanley.mountain>
 <4183c48a-3c78-47e2-a7b2-11d387b6f833@nvidia.com>
 <93a06b66-ab5e-4722-9270-cf892470d004@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93a06b66-ab5e-4722-9270-cf892470d004@intel.com>

On Tue, Dec 03, 2024 at 11:02:15AM +0100, Mateusz Polchlopek wrote:
> 
> 
> On 12/3/2024 10:44 AM, Yevgeny Kliteynik wrote:
> > On 03-Dec-24 11:39, Dan Carpenter wrote:
> > > On Tue, Dec 03, 2024 at 10:32:13AM +0100, Mateusz Polchlopek wrote:
> > > > 
> > > > 
> > > > On 11/30/2024 11:01 AM, Dan Carpenter wrote:
> > > > > The dr_domain_add_vport_cap() function genereally returns NULL on error
> > > > 
> > > > Typo. Should be "generally"
> > > > 
> > > 
> > > Sure.
> > > 
> > > > > but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
> > > > > retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
> > > > 
> > > > Please remove unnecessary space.
> > > > 
> > > 
> > > What are you talking about?
> > 
> > Oh, I see it :)
> > Double space between "retry." and "The"
> > 
> > -- YK
> > 
> 
> Yup, exactly. Sorry, I could point it.

Double space after period is perfectly valid typographic style. It is
with us for last 250 years.

Thanks

> 
> 
> > > regards,
> > > dan carpenter
> > > 
> > > 
> > 
> 


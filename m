Return-Path: <linux-rdma+bounces-1421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A9B87A8C9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 14:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14C71F239EA
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Mar 2024 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0597442077;
	Wed, 13 Mar 2024 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHCFVja7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAB43AB2;
	Wed, 13 Mar 2024 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338127; cv=none; b=mxS5Sva2mRXiFTk9KRsb17cgtxaUyf3rAZPYlAUZKPkQwadxseaj+nxvTBhGNx5YrTHCIY0S2CbAegiyvPFAMeKOeAnm5wNWN+ta/57cGunEarAq8A2qSqKf/6tkTDySD3jbmkpL2BQIIYoKSJnzDre+zeoIVWeWns+JBQcQLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338127; c=relaxed/simple;
	bh=PCHsD/VQoswrhwP5anewHDANjB0LrY7cywHDvbFvbRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSAsPAJKnqQa+uBT8xs+tQLbsTscyKWmPTkqLgZft9toTrlflx8DBMGGlL0BJ85WJ3zEv2nwvy7pF9ZCPMwLLDGfa8wIt2W0DS+LUxEOSHHPFJrjwMVuIXbq06KHEFKgAptk6Yqbdi42FX/Oik2lkPRVQHD1H0FCXAluRAwUjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHCFVja7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC741C433F1;
	Wed, 13 Mar 2024 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710338127;
	bh=PCHsD/VQoswrhwP5anewHDANjB0LrY7cywHDvbFvbRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cHCFVja7FRWLcKljBwYQn68U/bQSpd2wwUXLu9bAqOMNwYna4UFyl09W4AU5ZJ7KH
	 D0TWTl/k2JE533/bI6IRoOcITtJzF6BugXjm9dBSBnb0jUr93FACaxb+D0hAIqRbSg
	 qmMWUZRBgdBwg2R5+gX0HfzyCHFq+euOynz9H4OLq0S3yR/W/m8VRJWK+sQz6PprEB
	 GccDx51Nz0BHa9B6tJH0+EKl1LN+Pvd4Ew0uwb1GvfXTLibUi6RI9XWqujLEC0O1We
	 Tx+/Num4yw0q4VMsLPz9GO8O4O7hdwyDQGuWocaeCxqOvUcv3qL9GwMCop8swgavcP
	 I4bo2TtSPAVZA==
Date: Wed, 13 Mar 2024 06:55:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Dennis Dalessandro
 <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 keescook@chromium.org, "open list:HFI1 DRIVER"
 <linux-rdma@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240313065526.10c6217b@kernel.org>
In-Reply-To: <20240313104252.GA12921@unreal>
References: <20240313103311.2926567-1-leitao@debian.org>
	<20240313104252.GA12921@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 12:42:52 +0200 Leon Romanovsky wrote:
> > PS: this diff needs d160c66cda0ac8614 ("net: Do not return value from
> > init_dummy_netdev()") in order to apply and build cleanly.  
> 
> We are in merge window now, so if Dennis approves, I will apply it
> after the merge window

Can we do a shared branch? We don't want to wait full release cycle
for a single driver outside of netdev.


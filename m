Return-Path: <linux-rdma+bounces-435-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD8815F1A
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Dec 2023 13:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC931C20BA3
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Dec 2023 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7C342AB4;
	Sun, 17 Dec 2023 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok0JDuV1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A8E4314E
	for <linux-rdma@vger.kernel.org>; Sun, 17 Dec 2023 12:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E608C433C7;
	Sun, 17 Dec 2023 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702817711;
	bh=nBxZSdqzWtNmnLzsRGgz00yCRokKKrZ3TqNAa7nPdK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ok0JDuV1dEPAX1OMO+1bpdNy4EUa72i/XS9XvE3dPArTk7I4lUBB7ZmRYQ7RaveGj
	 DJ+PGR05+PaKWg9VCtYnaC1gfzEyMEcNFx9JH22+E2Of3zOLPFXeEGTD3zuJq+lo9a
	 8JqoYOJrHzIKRjkvOTRd4y9XHK3aRU35OmwB+9dZY72cGOXOUKE2xtn5ARYlBeTQpV
	 h2KtNP4ZKFTqEygVHnSkpZy3dDopy5M2HkOuGDKuErZ2Jymgxqg2cVKDAZaiIzp4uZ
	 b/mwtWPOrbsM8AkdvEjD5W1Lb2ELgL0JeBKOHyPDrGvrmJ7VBB1ACACH186LSrUToJ
	 DctCEVh2s3ZNA==
Date: Sun, 17 Dec 2023 14:55:07 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Arka Sharma <arka.sw1988@gmail.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: ENOMEM returned by ibp_post_recv
Message-ID: <20231217125507.GB4886@unreal>
References: <CAPO=kN2giA5U9kkmag_jXHP-WAUquWktqa_arVdrRRqY0XTXSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPO=kN2giA5U9kkmag_jXHP-WAUquWktqa_arVdrRRqY0XTXSg@mail.gmail.com>

On Wed, Dec 13, 2023 at 09:37:19PM +0530, Arka Sharma wrote:
> Hi,
> 
> I am using MT28908 Connectx-6, and running on Ubuntu 22.04 with
> libmlx.so.1.22.39. From my application which is posting a receive work
> request I have no outstanding requests with the rnic, and I am
> attempting to post a receive work request, I sometimes get ENOMEM,
> which based on the verbs docs indicates queue full. I tried running
> dump from the mellanox firmware tool but couldn't get much hint. Any
> pointers would be appreciated.

Please approach your Nvidia customer representative, they probably will
help you better than us.

Thanks

> 
> Regards,
> Arka
> 


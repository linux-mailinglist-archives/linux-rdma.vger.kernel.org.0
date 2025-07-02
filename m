Return-Path: <linux-rdma+bounces-11848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B91AF60BD
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 20:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBFF3AEC09
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58BE30B9A2;
	Wed,  2 Jul 2025 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ9OEfLh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E372F5084;
	Wed,  2 Jul 2025 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479427; cv=none; b=XPN3ikC360eFlozjTDu9QOOfUjYV5bZ5z5CFg6G8PRH/QTiAqyrIDJXBh8JHA4Vo5Zc7lTNLY5df0uvdDGcvV59Ox3a42x4zk9E29G6bcsy0yc+XsCKu6/u1X1Ky9Y6TJH/P8cpZEie9qmtR/dc/xTkUClzALGCXHOop8s7UcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479427; c=relaxed/simple;
	bh=XISQve1mwG3wcsLxRGrLHst5FIinGfPaSZGxTh0ls64=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IQQyHg6dznL74u/w8KkM4bvODAAxHTP40SEjnnzCwTc75wu8y8Z6pLe3LPY8Pa5VD4b+tsK15QW+LgcGX1crx+wAHit76Hg2u3Yoxz8Dk1xX4/cTiEhfIKEBCuK7Y7rjVLYozFk+90KfVHb4cB3n1280fl9FDPXNQjBNDxAaMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ9OEfLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B835C4CEE7;
	Wed,  2 Jul 2025 18:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751479427;
	bh=XISQve1mwG3wcsLxRGrLHst5FIinGfPaSZGxTh0ls64=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EJ9OEfLhWMtrTlYGDWFbNv24fEZamRoSyYwyTJa7T117Cz8FHINHpNx7oUtCzw8wO
	 QllGVne5ATaJutRgUfcCmdxFcMisOTst8EP6D54ngNZapGw03I7te/COQXInMlUnI5
	 jpeBHyTE8rIqJObBcCdLZHenqmcSCaCtiDYd5K9gDGSP8ooW7tdK31mHNgKqvNzt83
	 iSQMJe1MP7/cEhOfutdICdgWxGSGtXDroC1WabrEMfOTsan++lF8Pa1Ct9jWWTyZh1
	 xV+ATjPHtIuRV44kOjrau3d03ztmd0bUezB6DG6RKFK/S/3+NhOaO/6rRuQsRMvb8G
	 hydv+EfyeIOBw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org, 
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <78cf89b5d8452caf1e979350b30ada6904362f66.1751451780.git.leon@kernel.org>
References: <78cf89b5d8452caf1e979350b30ada6904362f66.1751451780.git.leon@kernel.org>
Subject: Re: [PATCH mlx5-next] net/mlx5: fs, fix RDMA TRANSPORT init
 cleanup flow
Message-Id: <175147942444.802864.12981024482429695717.b4-ty@kernel.org>
Date: Wed, 02 Jul 2025 14:03:44 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 02 Jul 2025 13:24:04 +0300, Leon Romanovsky wrote:
> Failing during the initialization of root_namespace didn't cleanup
> the priorities of the namespace on which the failure occurred.
> 
> Properly cleanup said priorities on failure.
> 
> 

Applied, thanks!

[1/1] net/mlx5: fs, fix RDMA TRANSPORT init cleanup flow
      https://git.kernel.org/rdma/rdma/c/8366561fd6c641

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



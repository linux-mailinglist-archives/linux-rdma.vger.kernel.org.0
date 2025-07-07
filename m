Return-Path: <linux-rdma+bounces-11946-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7203AFBED6
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 02:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2A07A9F58
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jul 2025 23:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5088928C025;
	Mon,  7 Jul 2025 23:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9A1+Z4g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09A28A704;
	Mon,  7 Jul 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932798; cv=none; b=R1625FhQhvtzhe7Zz5tjIks3MWsh07iextNvzbRYgfArYj9r6u7YJe8vPVL/FoV4dVUYPArHAOI8keuQlmfPYMbaTROYCCbNJnGcVhmd3AAcIj0oisQotduETN6HDkw7n1kYtvC+yp0DK6tN5uC8q0NsNEcrA+IuASRqEaSo0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932798; c=relaxed/simple;
	bh=vVQAswP6Isaud9swQz92zL9tG6ep0AClXvMhgT4UBe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEbJzsBsY0OtsPptTVYbfAB7RX9Z5BvG/2Jkw1wb8gn678CBRDLokk8qPP1hH12S3M8AhdMXqKq0HgftRaLez4WG1VjlVpkykrZWkMAdPwafsocf29SeIoKAyoMrL6iN8L+BNgXO6E8WK0QzsqZVu34XOrRzQfz0MH0JxQhHmsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9A1+Z4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43172C4CEE3;
	Mon,  7 Jul 2025 23:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751932797;
	bh=vVQAswP6Isaud9swQz92zL9tG6ep0AClXvMhgT4UBe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H9A1+Z4gROOCKkURpF3ESL/NkvX52UgyKI1DxVIl1MHC5/K4fOHH6Dg5tds9XQKa4
	 5ybdggPqD5cemF4U+Iyi6nufTnGhjQP8Fh3KDc/l6Dmc+lkzE7MPbwnzMu/pbuy7aV
	 /O22nJ4rZfkbp2Wjo9Q9gBvg4/7aokgjdcnJHZ5i5hRbqaA+6EbHk7vaxcskV+Ul7l
	 dX7I7aNC8IOO4gtghbnNWHTQIYlnvKn2BkI+jj9hwetkZIGiW0O4zTh7LuhF+HwtGx
	 Dtr3dVgPhWVqoAzJU4Zl59zjFXIvAR95IiGoJiZtWxbk6UVDwsbarvKbIGL/Ax6+NB
	 TiX2lqI/pZ71g==
Date: Mon, 7 Jul 2025 16:59:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [pull-request] mlx5-next updates 2025-07-03
Message-ID: <20250707165956.4f6f96df@kernel.org>
In-Reply-To: <1751574385-24672-1-git-send-email-tariqt@nvidia.com>
References: <1751574385-24672-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 23:26:25 +0300 Tariq Toukan wrote:
> Hi,
> 
> The following pull-request contains common mlx5 updates
> for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> ----------------------------------------------------------------
> 
> The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:
> 
>   Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git 02943ac2f6fb
> 
> for you to fetch changes up to 02943ac2f6fbba8fc5e57c57e7cbc2d7c67ebf0d:
> 
>   net/mlx5: fs, fix RDMA TRANSPORT init cleanup flow (2025-07-02 14:08:18 -0400)

Doesn't work:

fatal: couldn't find remote ref 02943ac2f6fb

In general a named tag would be better.


Return-Path: <linux-rdma+bounces-5728-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812E19BADE2
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 09:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D56B21A1A
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Nov 2024 08:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1E519D8B2;
	Mon,  4 Nov 2024 08:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ildBtHOt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E0E18A6C8;
	Mon,  4 Nov 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730708439; cv=none; b=ZmSZUyUYgPzitjZRXEaQVadrcv48auddfW1e24GTSUhlMSuv/hV2OhULLAIrL0/MT2hQ7hZfc40kwjiFeTtr+dK7I3ZGRtthXMVh2PE2KBw8u2lJK9gVCBqmLSrFlqajJ1LnitiB65WpM9yPMQtgJHUDWeg41gCbx57uRJ2jDFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730708439; c=relaxed/simple;
	bh=cYP19ayu+a4SMDF4NOeELfl0OpEhHMtWimQnty+HFbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dEttj6Fh7P8l7iNcAK2uW0se/Y2w2mImzokBBSRWrLH4MELQKefCiGRsXpXC+x566msDmi7cDUaRTaFtfLec5MplOPwU+DdXjt3i1v9QpQUjASu9xXVuopaxwOPmbC7gdI+9OvrjLziupCMTsBcWdEySpF2IHpwqRlWNrypLPlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ildBtHOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489A4C4CECE;
	Mon,  4 Nov 2024 08:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730708437;
	bh=cYP19ayu+a4SMDF4NOeELfl0OpEhHMtWimQnty+HFbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ildBtHOthxY2xYf4c27zaUM9PV+jhvDrx3RUjssqP2KFOhmJZ3591kzCBoiW6byb6
	 vmwpK0tz38tzPRH0DppvBhQ7rB+LFGm4sbhbyNHwXNYr9lJx7plL8RTKlnZsRScxli
	 1+k9uzT7Rpv/J8znVoqXKBz8OqAYEVbkI+B3p1nyelbbOgW80O1bQR/Ilnt3jjSci3
	 x31uUrmIKnRDUDS/AZYniR12LhUAjneaxXKgBTeootA7+amVCecdShUbUhuu7pKLoq
	 8EMM+vVZy9IyQIFWCd7Jzhxy5Acol3pwQ49mJi9S7jbsUGp3L57RBgwNpnWcmlcIVl
	 UadMeP4nr1k6Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Edward Srouji <edwards@nvidia.com>, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Yishai Hadas <yishaih@nvidia.com>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1725362773.git.leon@kernel.org>
References: <cover.1725362773.git.leon@kernel.org>
Subject: Re: (subset) [PATCH rdma-next 0/2] Introduce mlx5 data direct
 placement (DDP)
Message-Id: <173070843405.153955.14255141986719362482.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 03:20:34 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 03 Sep 2024 14:37:50 +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This series from Edward introduces mlx5 data direct placement (DDP)
> feature.
> 
> [...]

Applied, thanks!

[2/2] RDMA/mlx5: Support OOO RX WQE consumption
      https://git.kernel.org/rdma/rdma/c/ded397366b5540

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



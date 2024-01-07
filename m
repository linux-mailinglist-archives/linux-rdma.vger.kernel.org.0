Return-Path: <linux-rdma+bounces-550-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 714D38263B3
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jan 2024 11:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250251F21B49
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jan 2024 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057C12B7F;
	Sun,  7 Jan 2024 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkoXQpH6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CB212B6E
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jan 2024 10:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD18C433C8;
	Sun,  7 Jan 2024 10:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704621829;
	bh=bRFqSF3d6bEYgvlpTsdmuuAKafITSaumyLiu5bg9vZ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FkoXQpH6obVDWtHnI34vMnywl+uc7J28gdqRVXJr0MZNRgmp/eYWQ03vYlXs3nGWR
	 kyPpihIbHYtMqCQOZi1p2SUCGN5SpkjfuWasDNtcGzYcjy6tMYG/SNdKHh/NGGPyV3
	 5Bz/sYNyU1kn4WdYRYPQhiK7jGpFbRwNJYRxZKYnLjf9RkcGg/ihb9UW51Zp2MLYnk
	 igZM3Br+1D1poTZcALD9PExS+efED0jGhZYIBtO0vZwNYLUPlPe+XYyrSiTNdfOHKJ
	 phDdEJ94UwgwGoucOLC/Q8dN/R/Rljdu51imR+Dvo4skUymT1GJC8hiaulW9IoPDdv
	 web5Lk1lufzsw==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Michael Margolin <mrgolin@amazon.com>
Cc: sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
 Anas Mousa <anasmous@amazon.com>, Firas Jahjah <firasj@amazon.com>
In-Reply-To: <20240104095155.10676-1-mrgolin@amazon.com>
References: <20240104095155.10676-1-mrgolin@amazon.com>
Subject: Re: [PATCH for-next v4] RDMA/efa: Add EFA query MR support
Message-Id: <170462182398.29089.4775817913000294016.b4-ty@kernel.org>
Date: Sun, 07 Jan 2024 12:03:43 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Thu, 04 Jan 2024 09:51:55 +0000, Michael Margolin wrote:
> Add EFA driver uapi definitions and register a new query MR method that
> currently returns the physical interconnects the device is using to
> reach the MR. Update admin definitions and efa-abi accordingly.
> 
> 

Applied, thanks!

[1/1] RDMA/efa: Add EFA query MR support
      https://git.kernel.org/rdma/rdma/c/2307157c850960

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


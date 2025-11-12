Return-Path: <linux-rdma+bounces-14437-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A75C51F73
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377E21896FC2
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 11:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB04B2FF641;
	Wed, 12 Nov 2025 11:24:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E62C15BE;
	Wed, 12 Nov 2025 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946679; cv=none; b=IY+Q4eiQMuwy+N8RQiRGnxWVIhI5UiZgQDJYn0OaXYsK/Scu6wPnPgPQXF1shlCnuQRrDqJ8VbqjZNUMNYjs3O2Bhz8BXkSTz127KNCEemA1lVPHqBDhe3NZM3TuqLKR8Jq9+PNbgitEUCLOw33wspQSdXNtUNx+Kx0y8SB/ZNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946679; c=relaxed/simple;
	bh=uHm7vKgxiwWctvMY7yDEPPa/0SOELAi2YhC7rxspQFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kHqfssdgaBnRQbcOiDm7zmtgVes4v5gMBqErAi6Wht+QGLsnDZwN0iPIPGOJt4whT6aOlkTzWmdxmOk/awq6djB0jE12WG4pP/WDnAnXN3jX60pLF64DLKgzS6Ag/OFvMWFVvLnGGLHKN9os+InWWOO5hLOoYCNv9DwHMgIuFHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4FAC116B1;
	Wed, 12 Nov 2025 11:24:38 +0000 (UTC)
From: Leon Romanovsky <leonro@nvidia.com>
To: netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <20251112062908.2711007-1-rdunlap@infradead.org>
References: <20251112062908.2711007-1-rdunlap@infradead.org>
Subject: Re: [PATCH] RDMA/cm: correct typedef and bad line warnings
Message-Id: <176294667614.872552.9817692059627201462.b4-ty@nvidia.com>
Date: Wed, 12 Nov 2025 06:24:36 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3


On Tue, 11 Nov 2025 22:29:08 -0800, Randy Dunlap wrote:
> In include/rdma/ib_cm.h:
> 
> Correct a typedef's kernel-doc notation by adding the 'typedef' keyword
> to it to avoid a warning.
> Add a leading " *" to a kernel-doc line to avoid a warning.
> 
> Warning: ib_cm.h:289 function parameter 'ib_cm_handler' not described
>  in 'int'
> Warning: ib_cm.h:289 expecting prototype for ib_cm_handler().  Prototype
>  was for int() instead
> Warning: ib_cm.h:484 bad line: connection message in case duplicates
>  are received.
> 
> [...]

Applied, thanks!

[1/1] RDMA/cm: correct typedef and bad line warnings
      https://git.kernel.org/rdma/rdma/c/64a5e132a82a02

Best regards,
-- 
Leon Romanovsky <leonro@nvidia.com>



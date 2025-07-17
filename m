Return-Path: <linux-rdma+bounces-12267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF5B08CB7
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 14:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A60A46C47
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30542BD035;
	Thu, 17 Jul 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5qqkJ4T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1029ACF3;
	Thu, 17 Jul 2025 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754808; cv=none; b=qc34OGlD6sLmv+QEGR7BmRdfnV55cXQL03CvENxmpGugB1nsiLrXe9YomsLnqa4mqXPJIpNKlFcaw3vE1K3WV+khBv3BbLltbnccOub0inatqXzP4CinEHCifpwL3EDJm8xX8RKJO2EKLGFlJ8Qhx5oSfekAWbS3iw2Cba7dj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754808; c=relaxed/simple;
	bh=HqH5zSuEtRcYd+zTcAWz9KZZEXE9LB7c+ay5kz7OkbA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RDkNA4yPTqkAoyVBjJ6wKORy+kof2ndhNIT4kJcppHor6IULM3NynPmdfarkInIHobuNgMqYvx1VOs8gKwHNTnCFl1DBSpPq2S/K+L7FTxEITr/ewC7M0XWbWAGCAPkAcXEiq4+IZi0xfFlHAQnDY6g304LY23HOnxjp3LXlnx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5qqkJ4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B702BC4CEEB;
	Thu, 17 Jul 2025 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752754808;
	bh=HqH5zSuEtRcYd+zTcAWz9KZZEXE9LB7c+ay5kz7OkbA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P5qqkJ4TPb2ymD9Io8TUCZ7uIM5vwQpgMbCmNZKhxehl2YH26beE5axVrbY3JPaiw
	 WGWovFovKZnv9cJWcRucqstZ6w+GUjLkIRmznPL557F43ZCfd96RepiqtMMdNe1V5i
	 pauF29HJwwzhQq9Sekwx7eopQa8azzsdUp6qmWOiDV8yFGG30gI/84k3gf2eUHWkRd
	 zKxNBbnsGi6k1ETwvt/0JFDIWZtOWmSIa8wio25Ti3OwgWRaPdCSqN7cDtyCdZ0uz/
	 Li0+yxM/xvFy0NMUJXfkU0gZy0jnV2obsfwargb/BIzRZD15WDQihoG3piEEid+9E0
	 LgE5cYoTMlAzg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250717112108.4036171-1-colin.i.king@gmail.com>
References: <20250717112108.4036171-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] RDMA/mlx5: remove redundant check on err on
 return expression
Message-Id: <175275480530.658097.13704229214903648802.b4-ty@kernel.org>
Date: Thu, 17 Jul 2025 08:20:05 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 17 Jul 2025 12:21:08 +0100, Colin Ian King wrote:
> Currently all paths that set err and then check it for an error
> perform immediate returns, hence err always zero at the end of
> the function _mlx5r_umr_zap_mkey.  The return expression
> err ? err : nblocks has a redundant check on the err since err
> is always zero, so just return nblocks instead.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: remove redundant check on err on return expression
      https://git.kernel.org/rdma/rdma/c/aee80e6ffc5878

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



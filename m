Return-Path: <linux-rdma+bounces-3168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05053909E3D
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4401F21547
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 15:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AC01172C;
	Sun, 16 Jun 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHcH5hGA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E897CECF;
	Sun, 16 Jun 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718553222; cv=none; b=PpqtBex9YYg6gsVolLTax1dDxoHQYefLXYrHpEoN3hdASaimabIUivPNzPIzqWTD3eJOQDVi75qYwi+0foQzRh70eexwroGsbkSoiwLG7HfYoggaA5DzCnEjVxD7eSH+TdaSo3X1FFU4hd7PRkvx3wThwGq6ikiRmFAbkrPmkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718553222; c=relaxed/simple;
	bh=cY4GT+bEZkogCxB+duZnS1X2mDg1EzPWY0xhN4kFyiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nRf7LtS90gl863j+xAy/1TPa5fZMYCHDiNTAifflNPasJTShd6KSIcI8IWxea5sDeq3Y8DKQb5W5qATBud6SwpZcWMBgDmmOJOXtpiVFbarlYfV6OtAKTM0xw/SgsvGO2whZ+gD5XrXfPeiioR6DYP46lCQA5RXHS01YPYvp4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHcH5hGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96025C2BBFC;
	Sun, 16 Jun 2024 15:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718553221;
	bh=cY4GT+bEZkogCxB+duZnS1X2mDg1EzPWY0xhN4kFyiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FHcH5hGAJfJRA+Ypa7JshUHBItOjCF+HjDtPDfY/RIcrXwMdZ55FZrWYOe56u7mki
	 L71mZd/kdxQvdMMMOwz9WpznUuinDxhYQofGfwTO0wN2hkO5ok/CVFCsfjKgT9KCSA
	 e109pHl+iXvYEhlUYL2ROMp8W5HEGFzvW+5nGgVkzzW/nNG+OfLTzluGzgd3FFAfAn
	 oD4QqcLu7bezwJ3bzo7iT/00EObfasq67p00EjbwSuyGml4rVig7kPbCuWFhTca9Tv
	 DDQ5jIqJZlPkS/3wKCLTxXerzyBl32jKgZk9Pvw2lVp2fApU8amaIK7PvOfICYwZi2
	 ybkGVaFCKhTdA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org, 
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
 Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <250466af94f4989d638fab168e246035530e912f.1718301543.git.leon@kernel.org>
References: <250466af94f4989d638fab168e246035530e912f.1718301543.git.leon@kernel.org>
Subject: Re: [PATCH mlx5-next] RDMA/mlx5: Add Qcounters
 req_transport_retries_exceeded/req_rnr_retries_exceeded
Message-Id: <171855321655.140417.11921317373923659644.b4-ty@kernel.org>
Date: Sun, 16 Jun 2024 18:53:36 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Thu, 13 Jun 2024 21:00:04 +0300, Leon Romanovsky wrote:
> The req_transport_retries_exceeded counter shows the number of times
> requester detected transport retries exceed error.
> 
> The req_rnr_retries_exceeded counter show the number of times the
> requester detected RNR NAKs retries exceed error.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Add Qcounters req_transport_retries_exceeded/req_rnr_retries_exceeded
      https://git.kernel.org/rdma/rdma/c/b339e0a39dc377

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



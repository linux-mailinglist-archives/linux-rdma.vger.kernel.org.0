Return-Path: <linux-rdma+bounces-13936-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40518BEE3C9
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 13:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C969B189D494
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Oct 2025 11:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1E22E6CA3;
	Sun, 19 Oct 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACnkAzvd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AD2E62A8;
	Sun, 19 Oct 2025 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760874185; cv=none; b=ZpFqKfeVjIdhEQ90Kta1UOKxnkcEiT8XVB9uP85AVKBjyvu5v2AuHmu3OS4DN/uhFWdUzwieSHBbvkNbcanRTnxjNN23+x1htFiMFwricqaQMiJzi6S20GUXb+l2kOKp24SF9nQuc+2Fr+xtc67ZOmwdc88jSlif2vpzg3/9D8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760874185; c=relaxed/simple;
	bh=sxIdf2TDihjjUe+ar/Lb0guj0iRhwTOQoqVwsaF/Uuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AvC/ok72f2cnvPi1TAAzS2U+jYD8OcueIOzU3nVimGZP5WAHgLgpeOi2g45OnzeliKmK6sxoyMA9AE5L29T+T0fNY8+KY4Jwko63OSV+M7zOvVGCtMSrORvV/Ywt18RZgW2+WEHO2dQNy2duCuJQWFeMWMMwPcfUNGmhrzwcOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACnkAzvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96938C4CEE7;
	Sun, 19 Oct 2025 11:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760874184;
	bh=sxIdf2TDihjjUe+ar/Lb0guj0iRhwTOQoqVwsaF/Uuc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ACnkAzvdqqGZAsQAUYjSrKqbrR1S6WsFEEwY5Xc9z3t0j7Se+JRWz7STVBtxRH07H
	 1VmttEcoilmHHgs0t8ADAJiqHHUMOEwBz1pYPeVTe3I2WbUj45M2FdTC8U/dNevSHz
	 0BF7CE+7Wrvw7wBVXxh1di17pMdXhpewKrh7gEPUipbZ8Q+5gD4eSvwi0UrdglWyfO
	 CfOe2MJX2cUK8lZWqbpasoEE4cXoB/gV1QJGMOXPnGKBbpPWoIRQudXp6RzQBxwJQz
	 02y9aWRbzHVlprlA+O5sl+x/3j8egVVEqwob3S1Oz6CGFpyoy3HQ5aYpmg0+tbqkHj
	 5y1x4sFFIffVg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Shuhao Fu <sfual@cse.ust.hk>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <aOh1le4YqtYwj-hH@osx.local>
References: <aOh1le4YqtYwj-hH@osx.local>
Subject: Re: [PATCH v2] RDMA/uverbs: fix umem release in
 UVERBS_METHOD_CQ_CREATE
Message-Id: <176087418063.150745.13749475166152366151.b4-ty@kernel.org>
Date: Sun, 19 Oct 2025 07:43:00 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Fri, 10 Oct 2025 10:55:17 +0800, Shuhao Fu wrote:
> In `UVERBS_METHOD_CQ_CREATE`, umem should be released if anything goes
> wrong. Currently, if `create_cq_umem` fails, umem would not be
> released or referenced, causing a possible leak.
> 
> In this patch, we release umem at `UVERBS_METHOD_CQ_CREATE`, the driver
> should not release umem if it returns an error code.
> 
> [...]

Applied, thanks!

[1/1] RDMA/uverbs: fix umem release in UVERBS_METHOD_CQ_CREATE
      https://git.kernel.org/rdma/rdma/c/d8713158faad0f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



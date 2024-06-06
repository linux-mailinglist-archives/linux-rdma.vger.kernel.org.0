Return-Path: <linux-rdma+bounces-2941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F298FE596
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 13:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42BFEB2256C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289AE1957E5;
	Thu,  6 Jun 2024 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIUK6tIg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85943CF73;
	Thu,  6 Jun 2024 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673941; cv=none; b=pQnUa5hP60XPvIBocSVmaQ0OVGvCfelDZ8zZVqQVIC20zzpgtNLzdy0lnNQXqmZ+AHqu7PXaMnKtERbeD9rfY0LzH23xTX9YTUgApJOJCxxhOXIknt71U2KiPGI1ZnJvjhmsi+T2p1wt9JICk8mqKXZiUZ1g26Tk2Q5a/ufyLnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673941; c=relaxed/simple;
	bh=Vr9iOtA/dEG3sHGJa1e7omIFl3U2OgHMWrWLjO3EZOY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bpak1FQxQq8GGJR/Ns1E1JHysRif90Pb/hZVfMBWGiFMethmOfoC8nNjZugwELpnH7dXG8/xh6YTCFBBMV6MJYMvh2M7Ed4yfiHpycD3RCPYVqmZ5t2OXMCNHr0NwYw/uDE6cRBzQsjSCx2cPY0EjecOF0byCmDuh9L+EwZnZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIUK6tIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECA1C4AF0A;
	Thu,  6 Jun 2024 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717673941;
	bh=Vr9iOtA/dEG3sHGJa1e7omIFl3U2OgHMWrWLjO3EZOY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uIUK6tIgMRJos/7Wb3VqW64l/j2HOW436liC2S9KVjOsIkG9cDu2O3aUM+gzwkwJy
	 7Oio2x6TC8vbf6QJeflLTBf0Ny1SoTGamcWE752eybVzOGWUHglK3gWX/JVblxabpV
	 YyYKDBPKMsJFUmILtOgb1plI6qzOSCiTiRT7bvxb68onPxJ4HUsLexk35dmuoxOx+Z
	 WWlw+dF8K5Mf+uGZHOaQHQkuKH3THFLP4/bGKECHIbR/3IHWOmOfeNXB02fN9okrrD
	 QornFX2tBDasZZEDz1smGE+7Yd7Jgudle5PEMVADkQ7A6khmPt4pJrBiTJBSzKc5H1
	 lpywIGefG1NFg==
From: Leon Romanovsky <leon@kernel.org>
To: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com, 
 jgg@ziepe.ca, Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1717575368-14879-1-git-send-email-kotaranov@linux.microsoft.com>
References: <1717575368-14879-1-git-send-email-kotaranov@linux.microsoft.com>
Subject: Re: [PATCH v2 1/1] RDMA/mana_ib: ignore optional access flags for
 MRs
Message-Id: <171767393704.412029.4137915627351184784.b4-ty@kernel.org>
Date: Thu, 06 Jun 2024 14:38:57 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Wed, 05 Jun 2024 01:16:08 -0700, Konstantin Taranov wrote:
> Ignore optional ib_access_flags when an MR is created.
> 
> 

Applied, thanks!

[1/1] RDMA/mana_ib: ignore optional access flags for MRs
      https://git.kernel.org/rdma/rdma/c/62093519622311

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



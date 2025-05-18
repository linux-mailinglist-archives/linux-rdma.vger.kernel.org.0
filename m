Return-Path: <linux-rdma+bounces-10394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C449EABAE86
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 09:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535B1178146
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 07:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CFD1DF756;
	Sun, 18 May 2025 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKot5Oyh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D53C30
	for <linux-rdma@vger.kernel.org>; Sun, 18 May 2025 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554774; cv=none; b=NsWcY11SVFS6x54mTBQs7Kv3yEl94O/uMqxLVVQvH7Nm9odbS7nWcX/DNBWvMNC0f+21VnQ9lJ8FiNHwq9yJC5bbB+Tzq0aaG06xu3ZYmeTN9iDpAVhlb9qts1COjexl20F/Sn4XqKXpXAzGuaX2U+unZx4Nz3803bJeWG4UeUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554774; c=relaxed/simple;
	bh=U2IzcykXl+MDaqcVK77zRzsstDrD0PNrgqgj5OabUV8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Si9oHpQIcZ295Hp8cOLeeoFw0/4cwF3NjdoFpwH8g9ax3089T5EHI2Md8Do8EQPaE47EtNJtzuOqpMyx8LMmdqYabqR9iJsVvYj/vkS8AC4Fdb1MMuAyYALygB/fepcKT4/6l0WHc0k6JJwO6TMYuvzA7dMYfVagyi6ECjpS304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKot5Oyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59C2C4CEE7;
	Sun, 18 May 2025 07:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747554774;
	bh=U2IzcykXl+MDaqcVK77zRzsstDrD0PNrgqgj5OabUV8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CKot5Oyh+qgAFIRn0djQtlZnJE6YBPxMyGQtR9kPFiJjanl89olNS4H5ccY+MwgdF
	 1l16hMvAtYtVykx1+lLBz3J3dA/C6dvkwpW3s3ZxN/yuJvL4ZHM1gyMru6bfc3FWYD
	 /6z7UyFisKRP6H6S/xeflnjpKAejlBLCZALsbX0VGRFMF4KSppFe7tyAK8+s9N8riI
	 rac2i91V6upG1UIFJLWFiQlWqQQCs16dVFeaDo7SdcVjb2sKpmK3VExSfQGqZIcO2u
	 D3jmvQc19XUcccwVfv98n3XaeiBsXWclN3fS74kWIE8i+nNI2blU8mUvjI8ABdbLBU
	 6pjTBWqMBnSpQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Patrisious Haddad <phaddad@nvidia.com>, linux-rdma@vger.kernel.org, 
 Maor Gottlieb <maorg@nvidia.com>
In-Reply-To: <b842d2f523e9b82e221378c444ebd5860d612959.1747134197.git.leon@kernel.org>
References: <b842d2f523e9b82e221378c444ebd5860d612959.1747134197.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Add support for 200Gbps per lane
 speeds
Message-Id: <174755477094.2823432.9028142829857242609.b4-ty@kernel.org>
Date: Sun, 18 May 2025 03:52:50 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 13 May 2025 14:03:41 +0300, Leon Romanovsky wrote:
> Add support for 200Gbps per lane speeds speed when querying PTYS and
> report it back correctly when needed.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: Add support for 200Gbps per lane speeds
      https://git.kernel.org/rdma/rdma/c/d00d16bcbc2553

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



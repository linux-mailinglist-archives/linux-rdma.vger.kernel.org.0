Return-Path: <linux-rdma+bounces-2427-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9F68C35DD
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 11:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3EA281635
	for <lists+linux-rdma@lfdr.de>; Sun, 12 May 2024 09:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984291BF47;
	Sun, 12 May 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW7ttcwT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A79E1865C;
	Sun, 12 May 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715506558; cv=none; b=P26ymH7sMXpLeV8xbgww59cD1f2Q9j6AsqenMLy/31iMRRzQroWdakiEMZwA42qwt7IZOGKrSSN9hnVmV4+si+sHSEH3Eqm4f4jX78oqNKANYqeu3gV8FMDpc/Hdu+TUyA8tBn+mK1Oy8uDEJvZpxHI1kTHn5SE5fsGPCP1jevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715506558; c=relaxed/simple;
	bh=PCHTMZ+fjytB5RLa9+V6lhUcpWrdVwb/2cnmNsA6uZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmP9kQDVNU3p5A/jGuR7fLYwmWGdvn+kTgqBfMXkJq5gfYoneybX0oMuXHX6nZAd7VAqblyfRXYBJRTGhijADNVi7snURGVeBj/k181Mu9I0oTfnAEMJavUZ/ddB7k8V/hwgPavNETaVpe0Uw1adDoK2RCDgEP3BRqSINjsxdc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW7ttcwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AD6C116B1;
	Sun, 12 May 2024 09:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715506557;
	bh=PCHTMZ+fjytB5RLa9+V6lhUcpWrdVwb/2cnmNsA6uZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cW7ttcwTY9xRSdzpXIxs2O4YBl5l2GAIBvvglHxMY7rLmM9ghHFqE6tbGUhFqDwJX
	 2a2N9cUVoxrsaojqb2c5xYD5ZxoPusBURe1zITHJ39b1mZyG8Fhy0ZRb/rL2d+5eNm
	 8h8PFyjifNczAc3j9nosoF1qVSHXgK4v1RzCcdfNFGDXHi49PLAF6ixvlRID9QPTtn
	 8RCywZ0qojSitm/M4IO7mouYBVTkNCmpr1K6eAsRn75g6dR4bC2fO0IABVHkwCXiXk
	 N58DI53GOzBwnxxqYecIVmzhv1QJqVAu6XmN3ESVFlrzwMADYrOL5cXos9u+7m+jmg
	 uk9QHUq5gW8RQ==
Date: Sun, 12 May 2024 12:35:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, sharmaajay@microsoft.com, longli@microsoft.com,
	jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 0/3] RDMA/mana_ib: Add support of RC QPs
Message-ID: <20240512093553.GA11697@unreal>
References: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715075595-24470-1-git-send-email-kotaranov@linux.microsoft.com>

On Tue, May 07, 2024 at 02:53:12AM -0700, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> This patch series enables creation and destruction of RC QPs.
> The RC QP can be transitioned to RTS and be used by rdma-core.
> 
> Later I will submit rdma-core patches with fully working RC QPs.

Did it happen?

I want to remind that we are not merging UAPI changes without relevant
userspace part.

Thanks

> 
> Konstantin Taranov (3):
>   RDMA/mana_ib: Create and destroy RC QP
>   RDMA/mana_ib: Implement uapi to create and destroy RC QP
>   RDMA/mana_ib: Modify QP state
> 
>  drivers/infiniband/hw/mana/main.c    |  59 ++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h |  99 +++++++++++++++-
>  drivers/infiniband/hw/mana/qp.c      | 165 ++++++++++++++++++++++++++-
>  include/uapi/rdma/mana-abi.h         |   9 ++
>  4 files changed, 328 insertions(+), 4 deletions(-)
> 
> -- 
> 2.43.0
> 


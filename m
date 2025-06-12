Return-Path: <linux-rdma+bounces-11238-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C50AAD6990
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 09:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0329B3AF1A9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF4622172C;
	Thu, 12 Jun 2025 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISAXdpDo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD521FF2C
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714647; cv=none; b=ehdVv5jYeRUH8H14nbMXurg3hzCeCryzheIQrXBUacPpFYrEQpL0Kc8wGBu8m6xjPbGwCxfmB5EF2LpKuBk2xk2/p7abPXbfNf4685Xd3tS3pU4qpuTuWNn4BbCqyTnlkh8QlkmVIcmm390UzHvkPfasJXJ7uEdEpMM/+CykSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714647; c=relaxed/simple;
	bh=uDs9tmqoaLS5rLwVgBrwHUKUcqZXb+QnvtpAIQFVOSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYTRu0dFnolDq4kmq2zMKGtLcIhvtci/3U9pIoqCa5RrEU07YJC/Qts+5INcBYqjU7FtN2IdmfdCIMkl1kJgiwv1egOE6wHPQEKpqmx0ardzqD0+j8b3wA+ykgWQsciiI58fAD8uYXAfpFfpww5mJbrD73jdJszmEE6J+t/w6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISAXdpDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFB2C4CEEA;
	Thu, 12 Jun 2025 07:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749714646;
	bh=uDs9tmqoaLS5rLwVgBrwHUKUcqZXb+QnvtpAIQFVOSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISAXdpDoeNoTbOyXt7tzc0/SaXldpY+40Tl9d5GeXHDIyhkaROaxRr8DaBhwPsAx6
	 rtNHWbxKp/JbKKLiwnrZpjJN0QiPqdCZPhxFB7STpHX83iXiOmTzrW8sxPKS0261qV
	 Pye2hzck/TDfFhZ9qam417xc31euKU+uLTtEwpDwKqpVjRQGPH9gTW8Z2FxOeIfhEh
	 QX1aYf+ctyVV71apl85O6g1YBTXrxAdlsodrJDrPfIDAZ+FXKPkZJ/Cqvtl1wrL1MV
	 9iY0P3nG2zlRgNqIFRDsddD45dI7y7fJd03hbd8OhMyNPJqFK6YO0lzUpkT3UIoElh
	 A1zNo7BoWIK0w==
Date: Thu, 12 Jun 2025 10:50:41 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/2] Remove ancient qib driver
Message-ID: <20250612075041.GP10669@unreal>
References: <174836066896.2436819.16982870133237201013.stgit@awdrv-04.cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174836066896.2436819.16982870133237201013.stgit@awdrv-04.cornelisnetworks.com>

On Tue, May 27, 2025 at 11:46:02AM -0400, Dennis Dalessandro wrote:
> Time for qib to go bye-bye.
> 
> ---
> 
> Dennis Dalessandro (2):
>       RDMA/qib: Remove outdated driver
>       Maintainers: Remove QIB

It doesn't apply, please resubmit.

Thanks


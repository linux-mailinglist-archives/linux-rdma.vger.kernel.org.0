Return-Path: <linux-rdma+bounces-11794-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47023AEF580
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 12:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737101BC7770
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 10:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074026FDBF;
	Tue,  1 Jul 2025 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/S+vour"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4C26463B;
	Tue,  1 Jul 2025 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366908; cv=none; b=MMl/sY1KbHjLvxolMshx5dJ8f6WXrFVozTJ2ItzmE11f1JHBzn2yoXGUx4df7JTZDNMdk/nNAmMV7vOK3y+4jQWU4CChdMlXxKHvPq4W0fB7keYP0cEpW8dFW2HM5ixutgmINcp+cQ3MglxqbNyPLRv1ItcGH/4VKW33QRLaPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366908; c=relaxed/simple;
	bh=ST+VcP/NIU6aXX00Iga/UYEd6VcXIfIPUgvWQ0V4EAc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PNn55UDY+pG55L+Tsw8PvAIWzSBk4Y9GC8uahLejpygvu5VlFgdWOXNEI/OsRrtOY/0dEO2Oz0qMlFBQEEct0XNoZD6NfwTpRSXzqrYPyCkVo3KMkWJ2r3WTv3IXFxL6wzHYia9TeF11Dq3oDeLddLrlpWMpvxkuarpEsYN3AA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/S+vour; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14448C4CEEB;
	Tue,  1 Jul 2025 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751366907;
	bh=ST+VcP/NIU6aXX00Iga/UYEd6VcXIfIPUgvWQ0V4EAc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V/S+vourTRkppuxnraHrH1ESbCuSM78evyJiKxL206Veh+QSu6KSiycdbUkUX5CST
	 fhzlns7hIvAPnVf9iYgPbMz4msQRLgoIIZrfh0qNAK54VE+KEDtN+4c2nVwUbSvrOK
	 Bs55Hqmalrr+dmHbt+kC5YKCqYSsu8+qM6+KOfR0L7Y4MxvpI5usvetX2B2FvI7kjj
	 gM8mzQGeoEyS6Ja5R3334dj03ojNS/VJsiMiQHdhqB4MzAeRXDzb9lb+HFQjrtyr7n
	 Vr2PzGs2HxHqZ2PNwSCPutzPCpJBLq/QYJhr03WGiPffAbRgJNSOBhm6cmTo8Hw6SF
	 2cvxiTit0qGHw==
From: Leon Romanovsky <leon@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Cheng Xu <chengyou@linux.alibaba.com>, 
 Kai Shen <kaishen@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250630092346.81017-2-fourier.thomas@gmail.com>
References: <20250630092346.81017-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH] Fix dma_unmap_sg() nents value
Message-Id: <175136690361.404812.15832818442513042908.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 06:48:23 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Mon, 30 Jun 2025 11:23:46 +0200, Thomas Fourier wrote:
> The dma_unmap_sg() functions should be called with the same nents as the
> dma_map_sg(), not the value the map function returned.
> 
> 

Applied, thanks!

[1/1] Fix dma_unmap_sg() nents value
      https://git.kernel.org/rdma/rdma/c/4d67f2ac89a892

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



Return-Path: <linux-rdma+bounces-10677-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9512AC32D2
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 09:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5468170C24
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFD917B50F;
	Sun, 25 May 2025 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mog7tTfb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8D1B808
	for <linux-rdma@vger.kernel.org>; Sun, 25 May 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748159540; cv=none; b=FbN6/M0A13FCmsOdwc5FklPOF9X2vJVMa4FyZMiu884aJ0OUsUJs4zbSTihk7HjsNMLEAL7np9ay6EGTlCDS6eF1juQa4YSR/3yTHSEDuZEtGgZjiTNnzP9g2jdIZFwfQe2LJZUb2hztq2CgF7hzOsVQ2A3AxNO3zkybP9y1QRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748159540; c=relaxed/simple;
	bh=6UFolWg9D/zmz6+pvqRwkx1DZo5wCvYzJmKzbwnXsVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hgr0qbnxljZuQvZULlrZfGk+JuuXOQW3hI1cIXx1hA6fe6iAlWdN70VPEOAb4+6977Nvyrc47SKSsVJkBWpCSnwJ+vvggNI+V6KucvL8qQuK5Zx8cDjCoVgTfFX/Vy0yQVcVgIpGTaxjjPsgCaXjdcuVrWOjLgi606AqgMPIxB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mog7tTfb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A070DC4CEEA;
	Sun, 25 May 2025 07:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748159537;
	bh=6UFolWg9D/zmz6+pvqRwkx1DZo5wCvYzJmKzbwnXsVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Mog7tTfbCVDLLDDEZCC8teno9K9rJW+rFseQOz/aDf7XbNKQQLcFrWXD4afeYgHpX
	 lSzA6aJBYRpxV/Oov44lWhOAE65YAhxojK/bX6lHx3wUG/+PBbFzcTLcNa9m7ol3gA
	 n86Y617mJ+4DDMO+fwj3EnBpBYKrqkHJTwmLJQyiZuWQJOapTjG35cNY+Of8zwl6Ce
	 5irL255WSsN/8Toj3dpsECV2bZM/4PMSLIb/DpkEPts6O/KOe65MmZb3NlZF9F+zTG
	 k0Htjw24UOVN5eZJg3F1qnTtDR5zN7U2ooUAb1XI3jsUKNYXt2DHWzTeK2k1B+I6oI
	 VPqlex69uvB2w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <7b891b96a9fc053d01284c184d25ae98d35db2d4.1747827041.git.leon@kernel.org>
References: <7b891b96a9fc053d01284c184d25ae98d35db2d4.1747827041.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Avoid flexible array warning
Message-Id: <174815953380.1055957.16164106385233511019.b4-ty@kernel.org>
Date: Sun, 25 May 2025 03:52:13 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 21 May 2025 14:34:58 +0300, Leon Romanovsky wrote:
> The following warning is reported by sparse tool:
> drivers/infiniband/hw/mlx5/fs.c:1664:26: warning: array of flexible
> structures
> 
> Avoid it by simply splitting array into two separate structs.
> 
> 
> [...]

Applied, thanks!

[1/1] RDMA/mlx5: Avoid flexible array warning
      https://git.kernel.org/rdma/rdma/c/de748d531c52a5

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



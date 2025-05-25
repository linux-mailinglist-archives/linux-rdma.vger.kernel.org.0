Return-Path: <linux-rdma+bounces-10679-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA5AC3340
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 10:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45623A8D8C
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6251A9B53;
	Sun, 25 May 2025 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+8IdcZM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8801A072C
	for <linux-rdma@vger.kernel.org>; Sun, 25 May 2025 08:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748163183; cv=none; b=KSsYHpSoBtVOzaTlANHGv8Qmh6CXGLuGenK3uwGfvgwP1AsdpcwoYJHsaUrI0NzkCTTbnUgZUhb8emf1QjJlpsBiOgCOLpkUCC0ZXvXsKdYtZN/4xx/3DToccjO35vdalcGa+oBj65vT0T6vvqAL5/0QqHJldpRzXgRIp/54VUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748163183; c=relaxed/simple;
	bh=iYnaG4A+5feB+sUs1m1iqtgYXJnxu/0xm1A+EIRckNw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dsmYH61/7kjuQM1hin/S2Nwob5O2KW5eZkpOF34CHDm0JI0g22J0sqw7VFme14BV/3ei96KFUsvtJHXR1bStY48nkK/BXoOiQcH8xYjzRsFPOWEVhcU2xmh9dz2FAq4mWeRkdcivhspRqZw8t/A16yJ07RG/Ar2JVbhVjgM0eEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+8IdcZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03EAC4CEEA;
	Sun, 25 May 2025 08:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748163183;
	bh=iYnaG4A+5feB+sUs1m1iqtgYXJnxu/0xm1A+EIRckNw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=q+8IdcZM5uBY54DNhsS97nSDGvO2o6DbkJsx4SYdjLZFCAQK99++6zjwBIdHXvKeW
	 yQvVWrKMU8Uoa5epUJHqfZOZJE3jqAkB+UFTxf+sqsJR6bLDrUM7R1UveFvwNMte07
	 VHEJUeJSGraTaFygImcplxUMIMuDu/XFSSsJCIA883ZdAqNP3+io6hVXF6MDLvFxG9
	 Nup8z+ryNZfbqC9e0ayGdG+AyExhbUfxah4NR/GPDK+3D2rbta36kIxmVvjz5sVwh/
	 rweg6McA922ernUNpzeuSCNw79Ht165tlhLpLNkFd9tg3DxffWreoj3gR82/ew7dX0
	 mZUB+YtY5+B7w==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com, 
 selvin.xavier@broadcom.com, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Shravya KN <shravya.k-n@broadcom.com>, 
 Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
In-Reply-To: <20250523075952.1267827-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250523075952.1267827-1-kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH rdma-next] RDMA/bnxt_re: Support extended stats for
 Thor2 VF
Message-Id: <174816317970.1334273.3782894884829709132.b4-ty@kernel.org>
Date: Sun, 25 May 2025 04:52:59 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 23 May 2025 13:29:52 +0530, Kalesh AP wrote:
> The driver currently checks if the user is querying VF RoCE statistics.
> It will not send the query_roce_stats_ext HWRM command if it is for a
> VF. But Thor2 VF can support extended statistics.
> Allow query of extended stats for Thor2 VFs.
> 
> 

Applied, thanks!

[1/1] RDMA/bnxt_re: Support extended stats for Thor2 VF
      https://git.kernel.org/rdma/rdma/c/216eb2d14866ad

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



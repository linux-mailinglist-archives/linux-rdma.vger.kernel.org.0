Return-Path: <linux-rdma+bounces-5407-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F2299F0A2
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 17:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F2C282891
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Oct 2024 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6801CB9F3;
	Tue, 15 Oct 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy9+0eb2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92B41CB9E8;
	Tue, 15 Oct 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004779; cv=none; b=Tl7TeI8TcJgeNudQIa2AypIUJrrnulmL496NS7m2+b8E1gfqVe0D7aCDVMuY4iRtN+hwQrpSYf2UhxxuE+dTkR9GeeYTfqvolaiGFgAK1Ih8qSpf4Es9Uc46dAs5jGcfmIwy/LZWSzBsa9brZjnmzCnIyyRiDJ7GxgmB8dJbRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004779; c=relaxed/simple;
	bh=uImCSNdhund+igqcoD5WUxcSCGxZ7vv+ZRfMpMpSSKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5vRBKzqgMZnpm+tRlqRewY6U2ZylghB5n6Gs6eRii1vPbzZMw0RJK+L5VbwbBb250wvX1UOT7MznBePfB4neNOaNb7z/8drEpBQxJde/B9Afx4bCRWEzvQhCJZVjQI/T28LSX29SQb/O0FUiaE3f/RajTMShQxhBz5gS86xFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy9+0eb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4993C4CEC6;
	Tue, 15 Oct 2024 15:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729004779;
	bh=uImCSNdhund+igqcoD5WUxcSCGxZ7vv+ZRfMpMpSSKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iy9+0eb2EGhIYLXh4Wwo5xYVbvAgsLAm+AVgN4q65m/vsHV/2gAY8fGwseG2D+K1O
	 8cVYMdKMaRCjljjIfAqdxyylhKGQIMAxZc7iIlx2Hw3Rrhk0RrZEuRMz/xdkeuT+oE
	 MTEWDvYUqYZ1/1TB+4xs0F0EI6VGggvz3in1TJ3Y4NUkUQpYelr7YNyWS1Z3TBBJql
	 w6vsmPk/8fkI+fvkZp85zvExEQCJeuzVdXUEz0FvgZ9QMLFixguWjmjcZrBld6lmCX
	 Ih70egbs7yXmSkfQayyeBR+tC+ThJaSYmKYa9tHipWaPUAWkVu1LDuFtqK2s69hEeR
	 FoIA8Kqwp/OLA==
Date: Tue, 15 Oct 2024 08:06:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: saeedm@nvidia.com, tariqt@nvidia.com
Cc: Til Kaiser <mail@tk154.de>, leonro@nvidia.com, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [BUG] net/mlx5: missing sysfs hwmon entry for ConnectX-4 cards
Message-ID: <20241015080617.79e90a06@kernel.org>
In-Reply-To: <bc8ba1b7-e4ad-40b5-b69d-9ea1e7a18a40@tk154.de>
References: <bc8ba1b7-e4ad-40b5-b69d-9ea1e7a18a40@tk154.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Oct 2024 17:11:21 +0200 Til Kaiser wrote:
> I noticed on our dual-port 100G ConnectX-4 cards (MT27700 Family)=20
> running Linux Kernel version 6.6.56 and the latest ConnectX-4 firmware=20
> version 12.28.2302 that we do not have a sysfs hwmon entry for reading=20
> temperature values.
> When running Kernel version 6.6.32, the hwmon entry is there again, and=20
> I can read the temperature values of those cards.
> Strangely, this problem doesn't occur on our ConnectX-4 Lx cards=20
> (MT27710 Family), regardless of which Kernel version I use.
>=20
> I looked into the mlx5 core driver and noticed that it is checking the=20
> MCAM register here:=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/dri=
vers/net/ethernet/mellanox/mlx5/core/hwmon.c?h=3Dv6.6.56#n380.
> When I removed that check, the hwmon entry reappeared again.
>=20
> Looking into recent mlx5 commits regarding this MCAM register, I found=20
> this commit:=20
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dv6.6.56&id=3Dfb035aa9a3f8fd327ab83b15a94929d2b9045995.
> When I reverted this commit, the hwmon entry also reappeared again.
>=20
> I also found a firmware bug fix regarding that register inside the=20
> ConnectX-4 Lx bug fix history=C2=A0here (Ref. 2339971):=20
> https://docs.nvidia.com/networking/display/connectx4lxfirmwarev14321900/b=
ug+fixes+history.
> I couldn't find such a firmware fix for the non-Lx ConnectX-4 cards. So,=
=20
> I'm unsure whether this might be a mlx5 driver or firmware issue.

Hi, any word on this? Sounds like a fairly straightforward problem.


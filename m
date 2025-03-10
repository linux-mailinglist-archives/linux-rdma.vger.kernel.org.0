Return-Path: <linux-rdma+bounces-8523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF91A58D53
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 08:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453D516A783
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 07:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85BB223320;
	Mon, 10 Mar 2025 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZVJ33TS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28E7222568;
	Mon, 10 Mar 2025 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593261; cv=none; b=CZ77AGwK5l93qsm6707NkL6dQpVzuG4ScHgWQO5tq2FgBnKdfHDvsZ5X5J3DKlHBugIdHC5kR9Q+Glgs11/cpUroKbcw3ZqdgNIlaR/HK1Nl4ZDrTIDB1cc6vydHpguQX+9DyN3jt7im3Gg7Gsyb5pPZbQqnqA6hrhu6jmRzppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593261; c=relaxed/simple;
	bh=rJQ24rCYvqInoPy14R5oWwnZjuDlsDS3MJ8/SPtukVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWfCbz8J4A4qZ6h+CW86ydJnduJa0BFd2bqQVTibVKBQASSXP1UXUVhBLL0X8DdXtqfH9DMTIpEp/es6DMO7MRJJFxk+TlgspwAqQHrKWWd/Q49YmBmDYJ5+dcuHRWqKQG0GoKDh+2LnGa2CiI2CTWYNvRgK51GMA4uHPgCfIkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZVJ33TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CE3C4CEEC;
	Mon, 10 Mar 2025 07:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741593261;
	bh=rJQ24rCYvqInoPy14R5oWwnZjuDlsDS3MJ8/SPtukVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZVJ33TS+qOVWtKqKl8dB1A1ENhbVt1l1hQJuQvhz132vRoreTDJG/3mKtbtNkweg
	 Cy+6gqYpZSl/9rbYj6fJA2wfp2BXeDnaeZrpozU9WFYb5XztYRuSA231cupJuKtDnK
	 zXMOqyEql3Z69HZgxvJY604wgauAMqurJ9BTF5IBpzCp2LJR8u3e7lo6iJ8vzeOWXc
	 XKFNPuG4Y7/fxUTv4q+Pl4MIG4JToQzvI7s6AupKaZ0fypVG1W2t4ac+OjerCBmaEs
	 KFjlKlEKr8v/yX1g54RrQ0/6PHwurAcWXfQOvbec7UmzwAP2z4CE2ESy+lwVEbgPZv
	 nr2lw6jYZYOTg==
Date: Mon, 10 Mar 2025 09:54:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Patrisious Haddad <phaddad@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-next 0/5] Add optional-counters binding support
Message-ID: <20250310075415.GA505188@unreal>
References: <cover.1741097408.git.leonro@nvidia.com>
 <174146229393.310407.731855525292951254.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <174146229393.310407.731855525292951254.b4-ty@kernel.org>

On Sat, Mar 08, 2025 at 02:31:33PM -0500, Leon Romanovsky wrote:
>=20
> On Tue, 04 Mar 2025 16:15:24 +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >=20
> > From Patrisious,
> >=20
> > Add optional-counters binding support together with new packets/bytes
> > counters. Previously optional-counters were on a per link basis, this
> > series allows users to bind optional-counters to a specific counter,
> > which allows tracking optional-counter over a specific QP group.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/5] RDMA/mlx5: Add optional counters for RDMA_TX/RX_packets/bytes
>       https://git.kernel.org/rdma/rdma/c/30c77a88e3ffe9
> [2/5] RDMA/core: Create and destroy rdma_counter using rdma_zalloc_drv_ob=
j()
>       https://git.kernel.org/rdma/rdma/c/3644e21c005fcf
> [3/5] RDMA/core: Add support to optional-counters binding configuration
>       https://git.kernel.org/rdma/rdma/c/df5f4ff6319a6f
> [4/5] RDMA/core: Pass port to counter bind/unbind operations
>       https://git.kernel.org/rdma/rdma/c/d73531da19eb56
> [5/5] RDMA/mlx5: Support optional-counters binding for QPs
>       https://git.kernel.org/rdma/rdma/c/7bcd537adb21b5a

Unfortunately, but I need to drop this series from our wip branches.
The reason to it is patch #5 which has layer violation of bringing
RDMA counters logic into flow steering code.

As such it caused to multiple kbuild errors, because fs.c is available
only when CONFIG_INFINIBAND_USER_ACCESS is set, while counters and
rdmatool (bind/unbind logic) is not limited to user space verbs only.

This series needs to be fixed:
1. RDMA counters logic need to stay in counter.c
2. Optional counters need to work on all type of QPs.

Thanks

>=20
> Best regards,
> --=20
> Leon Romanovsky <leon@kernel.org>
>=20


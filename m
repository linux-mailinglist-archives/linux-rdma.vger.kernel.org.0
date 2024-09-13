Return-Path: <linux-rdma+bounces-4941-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D6A978A42
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 22:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5CDB251BA
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Sep 2024 20:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40558149C41;
	Fri, 13 Sep 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W++lk1tl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81CE6E61B;
	Fri, 13 Sep 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726260913; cv=none; b=geblX7ZlntBoNmHgTiexMQy56oFMKfWkWRnoKtCc6MxrNf+dVAf2n2eBRK9iEXs0yWgY8zagW7BeCrOJfG1Tewm7Fq/I5Z1jnooDbGdyaFTPySW5cxE5IqIJ2E+2ehX+5SgqKqYTHz+nPs5s/87wFHMoGCbv20quyzmMOQHdcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726260913; c=relaxed/simple;
	bh=P5q7MqBzErHxmg45ke0CTl8LcG3B1qiMRvBoX/KmEKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uc5hTtzmeOyX3JnbQoeo4SwBGrCjJ2BkAXaEYeTMA3NdGJfHdiBJXPWqp5Y2fpslQm89LdoGpdg8MrNLLgBrhnOwDX/Tmc8TroV0QpOM77+uUPS+OwOBVFjHRO/iV6kPhKgYN4kXbgwZAdjcj6hwiGHtWyxR6n7Du37IMtbTLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W++lk1tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E619AC4CEC0;
	Fri, 13 Sep 2024 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726260912;
	bh=P5q7MqBzErHxmg45ke0CTl8LcG3B1qiMRvBoX/KmEKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W++lk1tli9B8/ALIXT22oIe2Wlx93IclQlXaK1G8Ngd2s3hhTk+iNKrflWZXzC+31
	 fgGBi8fmNKko88dv0tyDZU1EER//P6pX8c46HDn4Upl9A/pi8/43orIAK/d8l/VWhv
	 RjYolmHG2bMrGDtnaiLXwn7kYS7Hur4Z/njvoA1BcA9qqhjQQGsUfZ+b0ZTK1FK5iU
	 1pakA2Ovlx2w6BlHGi736lwsEwYszot0XhCiBkLw1vZzi0DEhIWPMAE0F18EHgBqam
	 z1FdEpQzjrEeJTspHn4Yv6OwGF1g9zbg167Zak0vV8WVlP2O7k/nXbtrQQlnZVA7qt
	 AdmeFtWpDRFpA==
Date: Fri, 13 Sep 2024 13:55:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof =?UTF-8?B?T2zEmWR6a2k=?= <ole@ans.pl>
Cc: Ido Schimmel <idosch@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Yishai Hadas
 <yishaih@nvidia.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] mlx4/mlx5: {mlx4,mlx5e}_en_get_module_info
 cleanup
Message-ID: <20240913135510.1c760f97@kernel.org>
In-Reply-To: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
References: <14a24f93-f8d6-4bc7-8b87-86489bcedb28@ans.pl>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Sep 2024 23:38:45 -0700 Krzysztof Ol=C4=99dzki wrote:
> Use SFF8024 constants defined in linux/sfp.h instead of private ones.
>=20
> Make mlx4_en_get_module_info() and mlx5e_get_module_info() to look
> as close as possible to each other.
>=20
> Simplify the logic for selecting SFF_8436 vs SFF_8636.

Minor process suggestion, I think you may be sending the patches one by
one. It's best to format them into a new directory and send all at once
with git send-email. Add a cover letter, too.


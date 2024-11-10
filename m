Return-Path: <linux-rdma+bounces-5884-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 296969C321B
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2024 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264EC1C20964
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Nov 2024 13:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F961547C8;
	Sun, 10 Nov 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyppfQNH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643614B950
	for <linux-rdma@vger.kernel.org>; Sun, 10 Nov 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731244076; cv=none; b=JtADfdodroEEg2Jwy7E70Zi0Uow38H7HKiHQiJwhC73fEav9DLOvolfzkC6wFGiVw3u3a7PH7wfsYj2P4m0b1mR4tc+khFo7AvMbCy1PVu/rBKlvvF2m8lBS31K1UqtJrbQ6zp3MnO43fLYc7Zmv93v1WGUO+/uo1vjTHZ4PC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731244076; c=relaxed/simple;
	bh=4x6xAlay1L7WjMieuqFRlgESEjGVXie9EEtef/zhLv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpRGOB/bmwXycNt5mpnuBsi8onVcaMDDhUpfMWVSjBX9My7BP6SHro9CcJM51GL8eOtxprGMbiH5W4uPdmdF0iMAScIfyXR0S8Ts3og3Ffmjpq9BYZPFJLb/8cffyLI52SXvnV359KcpsKuik1ckU9WjlDs62jEkWdLsuxagHrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyppfQNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80C5C4CED0;
	Sun, 10 Nov 2024 13:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731244076;
	bh=4x6xAlay1L7WjMieuqFRlgESEjGVXie9EEtef/zhLv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YyppfQNHy3wiYWkzGrZwq3Fql69uSloJe6tTSv2HxeSe20Yqb9qmuK1L9vyk6FndL
	 UybcJiG0dHmnoNBjmYIe+uOwijsW9rjistjb8QWAKaAgdOLzMvFBjWkFux59CJhqeq
	 A35MdbeSk8DuXYK7EnOVmtRpoRrGD7s0kyAgUNcKtksMMkcBJjz3q2JZBXLgjoHp+V
	 kpTQfO7V6UJ8PYoOYIRTrG+h8vs/r/RJgIZ5L/ydM1Y1kj0wDHfvMEcjTGZBD77mJF
	 b2COqBqYOmzfPM9Cv2IhHOur9Tq5tS9KWbsMHdnCwaj9irIzBRz912Xb+CT5kBW/RK
	 W1ETlwNFHPa1A==
Date: Sun, 10 Nov 2024 15:07:46 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: jgg@nvidia.com, linux-rdma@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH for-rc v3] RDMA/core: Fix ENODEV error for iWARP test
 over vlan
Message-ID: <20241110130746.GA48891@unreal>
References: <20241008114334.146702-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241008114334.146702-1-anumula@chelsio.com>

On Tue, Oct 08, 2024 at 05:13:34PM +0530, Anumula Murali Mohan Reddy wrote:
> If traffic is over vlan, cma_validate_port() fails to match vlan
> net_device ifindex with bound_if_index and results in ENODEV error.
> It is because rdma_copy_src_l2_addr() always assigns bound_if_index with
> real net_device ifindex.
> This patch fixes the issue by assigning bound_if_index with vlan
> net_device index if traffic is over vlan.
>=20
> Fixes: f8ef1be816bf ("RDMA/cma: Avoid GID lookups on iWARP devices")
> Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
> Changes since v2:
> Addressed previous review comments
> ---
>  drivers/infiniband/core/addr.c | 2 ++
>  1 file changed, 2 insertions(+)

This patch causes to udaddy regression. It doesn't work over VLANs
anymore.

# Client:
ifconfig eth2 1.1.1.1
ip link add link eth2 name p0.3597 type vlan protocol 802.1Q id 3597
ip link set dev p0.3597 up
ip addr add 2.2.2.2/16 dev p0.3597
udaddy -S 847 -C 220 -c 2 -t 0 -s 2.2.2.3 -b 2.2.2.2

# Server:
ifconfig eth2 1.1.1.3
ip link add link eth2 name p0.3597 type vlan protocol 802.1Q id 3597
ip link set dev p0.3597 up
ip addr add 2.2.2.3/16 dev p0.3597
udaddy -S 847 -C 220 -c 2 -t 0 -b 2.2.2.3

Thanks

>=20
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/add=
r.c
> index be0743dac3ff..c4cf26f1d149 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -269,6 +269,8 @@ rdma_find_ndev_for_src_ip_rcu(struct net *net, const =
struct sockaddr *src_in)
>  		break;
>  #endif
>  	}
> +	if (!ret && dev && is_vlan_dev(dev))
> +		dev =3D vlan_dev_real_dev(dev);
>  	return ret ? ERR_PTR(ret) : dev;
>  }
> =20
> --=20
> 2.39.3
>=20


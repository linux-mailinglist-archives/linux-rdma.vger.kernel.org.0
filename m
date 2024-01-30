Return-Path: <linux-rdma+bounces-814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19484842BC9
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 19:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30A91C22030
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jan 2024 18:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8F060B9A;
	Tue, 30 Jan 2024 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iDqkAWHp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24F114E2D3;
	Tue, 30 Jan 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639441; cv=none; b=Q52gbO6jQhmhpJwxRu+tvHe4X5Ja2HrVZLgyb2P+KPCy5kE8i/7wLc2TjQrRj6duyW7Kpiau/dcagjsBLmT/hUgbNgGt3ibfxzyuNfrwBqCTNb7DlFH/xHPXlK5TNZXZHJt0UtAsUZHLn9yYtWMI2aP0DNkr2B1jpzlvDdxxCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639441; c=relaxed/simple;
	bh=tA4/1H6w8n1bCK32kU8GUndlSG44o2ZLxb5ueu19rFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czHl7+dGrG8p6DAcvQn96GtiEgL1rMl1TrxMGiyXNPthj7vfLpNzbdv4M4qvntxao3xdRIngcgkuPAI335W2Fa/hUNU18TUvXXM2i+ei7BR1+pfCqbxHsSJXzMEhGozgUXrgIyHt50Co2LhdwjfjI2F1nVgFjPJ4azi+DbGclT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iDqkAWHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6F0C433C7;
	Tue, 30 Jan 2024 18:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706639441;
	bh=tA4/1H6w8n1bCK32kU8GUndlSG44o2ZLxb5ueu19rFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDqkAWHpt+bMTji+PSVRO3xNPVEYmK4jZisDaTBLo7yQF43AqYNI3vr6KCaUXhZka
	 77ntzIA6dKwZ0hrhryhEMoWbroufblQamp6kO3ceTiowU1UK4uFuOtg19Ck6kNk1rG
	 tbaBDWmc3jREiB0ckBU3/y0FJGV3b55ON1T8VRmk=
Date: Tue, 30 Jan 2024 10:30:40 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-stable <stable@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
	lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: stable-rc: 6.1: mlx5: params.c:994:53: error:
 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
Message-ID: <2024013024-overripe-serve-4e45@gregkh>
References: <CA+G9fYvYQRnBbZhHknSKbwYiCr_3vPwC5zPz2NsV9_1F7=paQQ@mail.gmail.com>
 <2024012915-enlighten-dreadlock-54e9@gregkh>
 <CA+G9fYs3_M9E3w+uWky5X1hEgoJU4e92ECqSywerqSkF8KVGvA@mail.gmail.com>
 <8c178bd1-e0c9-4e29-9b63-dd298298bc7b@gmail.com>
 <20240130071434.GA7169@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130071434.GA7169@unreal>

On Tue, Jan 30, 2024 at 09:14:34AM +0200, Leon Romanovsky wrote:
> On Mon, Jan 29, 2024 at 08:25:42PM -0800, Florian Fainelli wrote:
> > 
> > 
> > On 1/29/2024 6:52 PM, Naresh Kamboju wrote:
> > > On Mon, 29 Jan 2024 at 21:58, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > On Mon, Jan 29, 2024 at 09:17:31PM +0530, Naresh Kamboju wrote:
> > > > > Following build errors noticed on stable-rc linux-6.1.y for arm64.
> > > > > 
> > > > > arm64:
> > > > > --------
> > > > >    * build/gcc-13-lkftconfig
> > > > >    * build/gcc-13-lkftconfig-kunit
> > > > >    * build/clang-nightly-lkftconfig
> > > > >    * build/clang-17-lkftconfig-no-kselftest-frag
> > > > >    * build/gcc-13-lkftconfig-devicetree
> > > > >    * build/clang-lkftconfig
> > > > >    * build/gcc-13-lkftconfig-perf
> > > > > 
> > > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > > > 
> > > > > Build errors:
> > > > > ------
> > > > > drivers/net/ethernet/mellanox/mlx5/core/en/params.c: In function
> > > > > 'mlx5e_build_sq_param':
> > > > > drivers/net/ethernet/mellanox/mlx5/core/en/params.c:994:53: error:
> > > > > 'MLX5_IPSEC_CAP_CRYPTO' undeclared (first use in this function)
> > > > >    994 |                     (mlx5_ipsec_device_caps(mdev) &
> > > > > MLX5_IPSEC_CAP_CRYPTO);
> > > > >        |
> > > > > ^~~~~~~~~~~~~~~~~~~~~
> > > > > 
> > > > > Suspecting commit:
> > > > >    net/mlx5e: Allow software parsing when IPsec crypto is enabled
> > > > >    [ Upstream commit 20f5468a7988dedd94a57ba8acd65ebda6a59723 ]
> > > > 
> > > > Something looks very odd here, as the proper .h file is being included,
> > > > AND this isn't a build failure on x86, so why is this only arm64 having
> > > > problems?  What's causing this not to show up?
> > > 
> > > As per the Daniel report on stable-rc review on 6.1, these build failures also
> > > reported on System/390.
> > 
> > The build failure is legitimate here since
> > drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h guards all of the
> > definitions and enumerations under a CONFIG_MLX5_EN_IPSEC which is not
> > enabled in the build configuration that failed.
> > 
> > This is implicitly fixed upstream with
> > 8c582ddfbb473c1d799c40b5140aed81278e2837 ("net/mlx5e: Handle hardware IPsec
> > limits events") which relocates the #ifdef CONFIG_MLX5_EN_IPSEC below and
> > allows the MLX5_IPSEC_CAP_CRYPTO enum value, amongst others to be visible to
> > code that is not guarded with CONFIG_MLX5_EN_IPSEC. This specific commit
> > does not apply cleanly to the stable-6.1 branch, so maybe the best we can
> > come up with is this targeted change that does the same thing against 6.1:
> 
> Thanks for taking look into it. This fix looks as a best solution for me.

Thanks, will queue this up now and push out a new -rc


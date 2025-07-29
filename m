Return-Path: <linux-rdma+bounces-12537-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A32B15556
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Jul 2025 00:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C246817E7C3
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jul 2025 22:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D3284B59;
	Tue, 29 Jul 2025 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQj/4/lg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB30EEBD;
	Tue, 29 Jul 2025 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753828814; cv=none; b=B06LMOHlAH9nvXxwf4h2R4Gc42X/ZgfiuBifXDS3kCfyTwNOEw6Rg49rHOpD3dwOm9si7voCH1zitF2oOQ5NSEf9k6MRdAveG9m2hrfd8TpbHxMI6dMYi5xwH/A9VMHr1PHQv7BwQc7bBfVWd1HUWM14j00nli0uAfGU0CDs+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753828814; c=relaxed/simple;
	bh=jOb4Sdi1sdezTxme6oMaC1Z0bg39zMY/ScYy43NqNgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGtjdFanPIWtd2ydlbDHi5Tq6oVrKxbLubxlXE8VZ0zdZdRfpG2KQsTW9nhHxPODw3gZ3D6BczJaXE4+Pg8lxhpIrs+5hzD7qO0pVvISryqTSc0VdqxkXpVWQmoV1028iOyfhmaLqpGG09nQxuB6yA038QUxJb+yvTinhNIHc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQj/4/lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00290C4CEEF;
	Tue, 29 Jul 2025 22:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753828813;
	bh=jOb4Sdi1sdezTxme6oMaC1Z0bg39zMY/ScYy43NqNgM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EQj/4/lga5L/o4AivgawUq2S3Y9fzGDdrEG2ttFcUbNP2/yzgPOMovCgxsO+mSzEe
	 7skS0ZsH1AXoGRr/ZBVHCHZECE5PCeY+OCQe1jzTVWL4N9kJxTQB0HT8he2BEfyC6c
	 1UtZN5Xx5HFcSbqvhtWWGjDqJQrwlr72x9QIEbX/R0WuO85iNAZlBu3KvDtX+QAMxf
	 c1giWffl5kfd1Kn34pD1nuqcJlBJkvUxVJqoeoUNi2FNLjRCvX8lDIfUaalUNyepdR
	 qxDgia8ejX8UoGW+vbdI8xrUgtMX5fedvr7KXzydBI4JaPnLxW8VMeBmXtY8izD7mI
	 OtsV/zpI6Ka9Q==
Date: Tue, 29 Jul 2025 15:40:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] Support exposing raw cycle counters in PTP
 and mlx5
Message-ID: <20250729154012.5d540144@kernel.org>
In-Reply-To: <0c1cea33-6676-4590-8c7c-9fe1a3d88f0b@nvidia.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
	<20250721170916.490ce57e@kernel.org>
	<0c1cea33-6676-4590-8c7c-9fe1a3d88f0b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Jul 2025 09:57:13 +0300 Carolina Jubran wrote:
> One concrete use case is monitoring the frequency stability of the=20
> device clock in FreeRunning mode. User space can periodically sample the=
=20
> (cycle, time) pairs returned by the new ioctl to estimate the clock=E2=80=
=99s=20
> frequency and detect anomalies, for example, drift caused by temperature=
=20
> changes. This is especially useful in holdover scenarios.

Because the servo running on the host doesn't know the stability?
Seems like your real use case is the one below.

> Another practical case is with DPDK. When the hardware is in FreeRunning=
=20
> mode, the CQE contains raw cycle counter values. DPDK returns these=20
> values directly to user space without converting them. The new ioctl=20
> provides a generic and consistent way to translate those raw values to=20
> host time.
>=20
> As for XDP, you=E2=80=99re right that it doesn=E2=80=99t expose raw cycle=
s today. The=20
> point here is more future-looking: if drivers ever choose to emit raw=20
> cycles into metadata for performance, this API gives user space a clean=20
> way to interpret those timestamps.

Got it, I can see how DPDK / kernel bypass may need this.

Please include this justification in the commit message for v2=20
and let's see if anyone merges it.


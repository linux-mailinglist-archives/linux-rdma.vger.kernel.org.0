Return-Path: <linux-rdma+bounces-12571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B15B18816
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 22:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F386236E3
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Aug 2025 20:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892CF21ADA2;
	Fri,  1 Aug 2025 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epPK9Djq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425B0128395;
	Fri,  1 Aug 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079824; cv=none; b=qHnEN3CjsSpGM8SBQhbdTBumTFazhDQ2WA5uUkVidpbpwZ6ZKi9e2CYnGKFYJt9xYq2rzQjib6h2GDOlpXJ1423JUgucFLvTRbSodr0Z87pMLCpTYVuxZoOy8jaBRODezh/oCueUdCftIuzCtb1RRs9A+SJqQt02KH7TJeZ7y4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079824; c=relaxed/simple;
	bh=fthQXt9de8h8yk9ZNeBmjvQawcLsRN2+7oIi0y/MFLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poXyyCwjyJtie1otEpDxRKD3bWR65LBZzIZc/DVaOMVMScd1RNRzwQ65PURBMu50JnbEA+04hGpxOc6HA6lJVjDdOmoacDR9Lzyp4c+FOEDmoXwGp4mGPQAxVbYIU7sNy4jobooZ1MEjorympcBrWsGUQ8DAJPml6pTYl5WSmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epPK9Djq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C50C4CEE7;
	Fri,  1 Aug 2025 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754079823;
	bh=fthQXt9de8h8yk9ZNeBmjvQawcLsRN2+7oIi0y/MFLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=epPK9DjqPFPZwUy7ZfxPxj1AefCIJotbQdbjwGdKwB8rR65nFG/3+cTBFsfCXtfwm
	 afyW+OGvVwMBA3F0dgz8acatyXck35cURqwgIYLo18EqjvwCAMPR0ce+gfRFu02aCV
	 5FirFRi5qIT34G0l/Wj/CELNJMuxNANtaHW4m10ETKqxbH5RYIW15dezK+DEooG5Pp
	 S3xPY6HSLxV6fqpjKOh0CsTtgRmcbLVSaie88gigNxAGfflmrpSDJPn4vWXd9o2/ub
	 vQRidU1k/4rTnjxaqiWL5Qyr7ipYLML0p9GoMgPKpfwCK01wPVb4sZZXaHQOxgTjPX
	 2Ai+ZRth0KozA==
Date: Fri, 1 Aug 2025 13:23:42 -0700
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
Message-ID: <20250801132342.6ad4303b@kernel.org>
In-Reply-To: <c52004ea-16dd-4131-b58a-4a7f7c6be758@nvidia.com>
References: <1752556533-39218-1-git-send-email-tariqt@nvidia.com>
	<20250721170916.490ce57e@kernel.org>
	<0c1cea33-6676-4590-8c7c-9fe1a3d88f0b@nvidia.com>
	<20250729154012.5d540144@kernel.org>
	<c52004ea-16dd-4131-b58a-4a7f7c6be758@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Jul 2025 22:03:02 +0300 Carolina Jubran wrote:
> Additionally, I wanted to mention another relevant use case that wasn=E2=
=80=99t=20
> brought up earlier: fwctl can expose event records tagged with raw cycle=
=20
> counter timestamps. When the device is in free-running mode, correlating=
=20
> those with host time becomes difficult unless user space has access to=20
> both cycle and system time snapshots.

Okay, so DPDK and DOCA, got it.


Return-Path: <linux-rdma+bounces-6008-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F269CFA3F
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 23:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBFF1F29448
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Nov 2024 22:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE41917EE;
	Fri, 15 Nov 2024 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2x2Z5Nj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F818C33C;
	Fri, 15 Nov 2024 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710537; cv=none; b=G1XGDOsHk6mcAbnr18AIJMlmAJo02+H2VHZR1Xvmvm0y9Z/gqvTkP9pQdGrTxRK+MIywFkChJIfMdGzMtRjS1aRrXLioveIN6zj3ITxSQOlWEl98ese2lF0LG7+sPJ9XY1uACraKp8F30ZqIAyWI3qNkriSS/nl7mvGnWE8OWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710537; c=relaxed/simple;
	bh=sympt9edmCXPUVcUd/uAA+42AmjDQXBS4Rkc29BZ860=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FN/mcgJVIbbiUTvgcourGU9vJV0Qp9pkvf92p1xpb/VT0HuMQHlEtVrvy16nzhq5PbmQzElYGJcl/7Nyaiiw2oZTmaSA5yFTB/tsR0RTuWjiiME76PYwfmPL+MJsfL+ilhNXsyk0nOVwQR8NottVpKvWGZTdVVbOY4EYDDyC3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2x2Z5Nj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D410CC4CECF;
	Fri, 15 Nov 2024 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731710536;
	bh=sympt9edmCXPUVcUd/uAA+42AmjDQXBS4Rkc29BZ860=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M2x2Z5NjQo3eF4mgl0rBQGEIS1d2UQPMhWj8IzGkHQM/8qgb2Y432dlpMohBGeRSF
	 ZgRRdlHTAYk6e51gMn4RmbMThKHH0sWm/sILRaHciGvG4x40jkFSIoEoNCBg/XjkNi
	 ijvhMhDCJS8pv9WRDzWM0eINerBkRARZvuLCr8kpMypehv99UZVuUdA8MRcw9K5Ild
	 NIqlxYD9Xggd6lHHOhGG6uOxZPkoI6fSDakq6noj6eXjR6gjN6gyIV2BiwfAN/cwY4
	 qXYqXH0SvkMpRhuH7VUEC37dXrOVk5dSbWIa0q83SU5maJvcxkiRVj+CCK6XdRThMd
	 d/jYFwh/M/e8A==
Date: Fri, 15 Nov 2024 14:42:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Yafang Shao <laoar.shao@gmail.com>,
 ttoukan.linux@gmail.com, gal@nvidia.com, tariqt@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net/mlx5e: Report rx_discards_phy via
 rx_fifo_errors
Message-ID: <20241115144214.03f17c16@kernel.org>
In-Reply-To: <ZzfGfji0V2Xy4LAQ@x130>
References: <20241114021711.5691-1-laoar.shao@gmail.com>
	<20241114182750.0678f9ed@kernel.org>
	<CALOAHbCQeoPfQnXK-Zt6+Fc-UuNAn12UwgT_y11gzrmtnWWpUQ@mail.gmail.com>
	<20241114203256.3f0f2de2@kernel.org>
	<CALOAHbBJ2xWKZ5frzR5wKq1D7-mzS62QkWpxB5Q-A7dR-Djhnw@mail.gmail.com>
	<Zzb_7hXRPgYMACb9@x130>
	<20241115112443.197c6c4e@kernel.org>
	<Zzem_raXbyAuSyZO@x130>
	<20241115132519.03f7396c@kernel.org>
	<ZzfGfji0V2Xy4LAQ@x130>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:09:02 -0800 Saeed Mahameed wrote:
> >> rx_dropped: Number of packets received but not processed,
> >>   *   e.g. due to lack of resources or unsupported protocol.
> >>   *   For hardware interfaces this counter may include packets discarded
> >>   *   due to L2 address filtering but should not include packets dropped
> >>                                   ^^^^^^^^^^^^^^
> >>   *   by the device due to buffer exhaustion which are counted separately in
> >>                            ^^^^^^^^^^^^^^^^^
> >>   *   @rx_missed_errors (since procfs folds those two counters together).
> >>       ^^^^^^^^^^^^^^^^^  
> >
> >I presume you quote this comment to indicate the rx_dropped should
> >count packets dropped due to buffer exhaustion? If yes then you don't
> >understand the comment. If no then I don't understand why you're
> >quoting it.
> 
> I quoted this because you suggested to use rx_dropped. It's not a good fit.
> In your previous reply you said: 
> "but honestly I'd just make sure they are counted in rx_dropped"

The comment just says not to add what's already counted in missed,
because profcs adds the two and we'd end up double counting.


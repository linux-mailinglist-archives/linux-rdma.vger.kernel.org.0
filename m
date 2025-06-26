Return-Path: <linux-rdma+bounces-11681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EC3AE9D59
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 14:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25571768EC
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91542214A6A;
	Thu, 26 Jun 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf0qAKMg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B633F9
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 12:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940420; cv=none; b=rpJL3k62MewY1YWFDItYDnLYBkq5AYKg/atvF5qQDK2PD50/vcE852D31MEgwwlQlBCBkf+pgT3Z6Ft6deZr0QsOl2p3uumnhRTPkq50O38W6U55i5OgE0R949+P1OrpO/IVx5DFaCpYjM01WCOJY8NQh2OWHsnbZq1NK+Ip3Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940420; c=relaxed/simple;
	bh=VSlk57NRSA0Jk1IOY+MEs0AxeNrQQ9lgtVPGjrIk/O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cfd7fOqDUdK0X2TNsMGvN0TYeAL9NUV+D7N71vuC+9Pd2Bld/Rx1GjYymsRNgQpRc0ZHNZxdybj9JhDAvu5X9cerQAdVlfyFIBp61I6+Kxxy7C1wnDKaWKODYC4XwnKNuRD/unI6NG3glR8nKeu3QO3GtRdgU04iSbclko01hsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf0qAKMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F40C4CEEB;
	Thu, 26 Jun 2025 12:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750940419;
	bh=VSlk57NRSA0Jk1IOY+MEs0AxeNrQQ9lgtVPGjrIk/O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kf0qAKMgXpx+6oCS3rkDCd9JOsJZYtQM8OGbHxEs0Cr3uSdjUxz2YSlON3/FwBz3l
	 VCA9tqwYbsdBegtvUjfC/BozGnGqtS9jANHRGvUWKJCrEJlSapUmREE45OqjvaHYxD
	 r9VGroBpA5eBEN5/k+POu5OZz7WEMzSZ63piwRXbCbaC18AgVSvH+bQ2lj4AjY/XOH
	 LUZXGAsOUbNsaO6esM23vTlpmQ3QzHVIab9BVQvhyC40WxD/3d25q27EivHwCTtfA+
	 LKqJJ3x0oygVZi1xoarvMCk43fao3NqoshdN/AUt6vGSyccljj7cmVDNuumXy+JABg
	 AazCtk5VgIzRg==
Date: Thu, 26 Jun 2025 15:20:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	linux-rdma@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-next v1 0/7] Check CAP_NET_RAW in right namespace
Message-ID: <20250626122015.GJ17401@unreal>
References: <cover.1750938869.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750938869.git.leon@kernel.org>

On Thu, Jun 26, 2025 at 03:05:51PM +0300, Leon Romanovsky wrote:
> Changelog:
> v1: 
>  * Moved QP checks to be earlier. 
> v0: https://lore.kernel.org/all/cover.1750148509.git.leon@kernel.org

Please discard this version, it is wrong one.

Thanks


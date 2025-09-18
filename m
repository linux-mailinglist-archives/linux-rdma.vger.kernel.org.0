Return-Path: <linux-rdma+bounces-13472-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4465B83A70
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0304A5FF1
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21362FB96A;
	Thu, 18 Sep 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ24CUQ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760D62F4A14
	for <linux-rdma@vger.kernel.org>; Thu, 18 Sep 2025 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186072; cv=none; b=PpMl9I/RI/mpAFGSQzl32ezjFuGZJ4HFcYLXA52WeubygT/2KwLg0AmuIMX2jM5SdFuc5pIelaSSta9LdTxeskXBKP0gTyIPvWOLR5Pqu41dqmyZPHukynAtl4My5YLOqVzLJvTtk9ux7hSFGg5cft9xlL9X90Sq6wo02i9/LhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186072; c=relaxed/simple;
	bh=iA/uRVusLywIkDACcVGxZO+lzN/SIJuA7bgTUi37JDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fq3a431km5bBbxERki64HLaRKkFwsvGDOlGuE3tZLaz0JLZ2lPdFErIhu7d5UHPlzHMWR5ceVrLxSWdMnZPXUwiC03LFzRMtqAJRJquRxN9RK30n2jXCp3KhrddRLD8wWF6AZvRL5FOnKQH6iokAIz/gIm/ScKJlVMSimcGTdXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ24CUQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB4DC4CEE7;
	Thu, 18 Sep 2025 09:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758186072;
	bh=iA/uRVusLywIkDACcVGxZO+lzN/SIJuA7bgTUi37JDA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IZ24CUQ+fLfQbtUZdXmM5lHzkDumm8FN02oO5EXm7/CmewCgHsxInpudEdEveSwjK
	 OmL/W83wp1PSOcIjGw00yIYusXekXqSVwYsnqh5vmnsKoU8v4GAJiUHD08uO7kI1Pb
	 n38nArDzCDRCX+oo+6vU84NXn+ErN8cAVhxCFtjlWSVTigbgbaJ5kzbKs9Tg+HOG5O
	 HkvafwLNbQzK8qTrTE2R3nFVOr07xl45bgdxc1kCa9fWniLz3ZyAkXqdIj+A1mkWp5
	 G7/G/KjUZ9nznaGBw2XAcrCV61XvPy+IBTqjjDZPM6C9ZL6lWruKcbb5j55QCX71NW
	 E6GYr4Y7HRVbQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: linux-rdma@vger.kernel.org, krzysztof.czurylo@intel.com
In-Reply-To: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
References: <20250827152545.2056-1-tatyana.e.nikolova@intel.com>
Subject: Re: [for-next 00/16] Add RDMA support for Intel IPU E2000 in irdma
Message-Id: <175818606888.1951776.9255903727424977739.b4-ty@kernel.org>
Date: Thu, 18 Sep 2025 05:01:08 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 27 Aug 2025 10:25:29 -0500, Tatyana Nikolova wrote:
> From: Tatyana Nikolova-Gross <tatyana.e.nikolova@intel.com>
> 
> This irdma patch series is the last part of the staged submission introducing
> RDMA RoCEv2 support for the IPU E2000 line of products, referred to as GEN3.
> 
> To support RDMA GEN3 devices, the irdma driver uses common functions and
> definitions implemented by the Intel Inter-Driver Communication (IIDC) interface
> and driver specific IIDC functionality exported by the idpf driver. This
> interface is already in use between ice and irdma.
> 
> [...]

Applied, thanks!

[01/16] RDMA/irdma: Refactor GEN2 auxiliary driver
        https://git.kernel.org/rdma/rdma/c/0c2b80cac96e19
[02/16] RDMA/irdma: Add GEN3 core driver support
        https://git.kernel.org/rdma/rdma/c/d5edd33364a597
[03/16] RDMA/irdma: Discover and set up GEN3 hardware register layout
        https://git.kernel.org/rdma/rdma/c/7d5a7cc7b9989d
[04/16] RDMA/irdma: Add GEN3 CQP support with deferred completions
        https://git.kernel.org/rdma/rdma/c/c7db0abe5f2bbf
[05/16] RDMA/irdma: Add GEN3 support for AEQ and CEQ
        https://git.kernel.org/rdma/rdma/c/b800e82feba7bd
[06/16] RDMA/irdma: Add GEN3 HW statistics support
        https://git.kernel.org/rdma/rdma/c/da278cb29c41dc
[07/16] RDMA/irdma: Introduce GEN3 vPort driver support
        https://git.kernel.org/rdma/rdma/c/2ad49ae7330b8a
[08/16] RDMA/irdma: Add GEN3 virtual QP1 support
        https://git.kernel.org/rdma/rdma/c/d6ed4b69b8ea75
[09/16] RDMA/irdma: Extend QP context programming for GEN3
        https://git.kernel.org/rdma/rdma/c/87f413b6c930be
[10/16] RDMA/irdma: Add support for V2 HMC resource management scheme
        https://git.kernel.org/rdma/rdma/c/419afdd122ea39
[11/16] RDMA/irdma: Support 64-byte CQEs and GEN3 CQE opcode decoding
        https://git.kernel.org/rdma/rdma/c/9a1d68786393c4
[12/16] RDMA/irdma: Add SRQ support
        https://git.kernel.org/rdma/rdma/c/563e1feb5f6ed5
[13/16] RDMA/irdma: Restrict Memory Window and CQE Timestamping to GEN3
        https://git.kernel.org/rdma/rdma/c/eb31dfc2b41a1b
[14/16] RDMA/irdma: Add Atomic Operations support
        https://git.kernel.org/rdma/rdma/c/a24a29c8747f75
[15/16] RDMA/irdma: Extend CQE Error and Flush Handling for GEN3 Devices
        https://git.kernel.org/rdma/rdma/c/42f1d099093bc2
[16/16] RDMA/irdma: Update Kconfig
        https://git.kernel.org/rdma/rdma/c/060842fed53f77

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



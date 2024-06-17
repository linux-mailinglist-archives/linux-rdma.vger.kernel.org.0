Return-Path: <linux-rdma+bounces-3201-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3410690AD73
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 13:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F83284E14
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D99A194C70;
	Mon, 17 Jun 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0wo+DZF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361C194C6F
	for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718625387; cv=none; b=OD2bIzvoKtlGbwe6DEV9+eGTaxPJqKXvk/2baVxnpa6sgkVjzUynSM1tpgCUkQ8CsRljKiSwxqaR+MkwiwITedvAquHkGyzhi7mbYJ3zaECncP5VuMUjEbJTXjd7CSTzWVGHg8U9TE6yYyTjhPxeLQabpgCyIkjKkQJznMU+R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718625387; c=relaxed/simple;
	bh=xJafkIWg8v7ldbuYq8xKo890J6dDa5WftRgaW8K+p9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lS1dGYV6G6f2cDNu0ZtnuCXGLsUreegzdRMcTwQBQFjfSh5Yk4q/OsB6swSZdisccIsSPxzhhNqAgvlct/LF1s+TvbHCkdRvU9oI43zln0u0V7KWowBnZX+TymQC3wBrolKeehNtXAMkCkpqB55Zv0qQkTV8EMXnkUzIZpT0KTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0wo+DZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560D2C4AF1D;
	Mon, 17 Jun 2024 11:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718625386;
	bh=xJafkIWg8v7ldbuYq8xKo890J6dDa5WftRgaW8K+p9Y=;
	h=Date:From:To:Cc:Subject:From;
	b=j0wo+DZFG35bONMaBD2uTo3HXZQAImLjuFAGXt04iHkTUTJJUn9x2ih/qfOVtTWYK
	 954ixL9jzGP2GRGq7qvGc13luNflvwRK8KA8IwAM59aicTVzdcbGX7K0w2uaxdzUFE
	 Bgzyl9Z0aEk7CYRdpw9qYbHkyfAZoPe+mBRpc45dKFuxzEaxqRTiqLWmWGEx6URWYU
	 rJJQRK/qwPxfcS76zvyTcixe4xxnmg+JyDbcxVWbshQQY5MFiN8q8KM3posCxX7DD1
	 YIxN39+YOf8puJL2TkIzQHpsLnMJRj7k9KqW7OfvmoTp9hMZjRa8h4Kw9Ujo9SW4qG
	 Nm+Rz15/HN8+A==
Date: Mon, 17 Jun 2024 14:56:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Open-coded get_netdev implementation in MANA IB
Message-ID: <20240617115622.GC6805@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I looked again on the patch 3b73eb3a4acd ("RDMA/mana_ib: Introduce mana_ib_get_netdev helper function")
and wonder if it is correct thing to do.

All new drivers shouldn't open-code get_netdev() and use the helpers ib_device_get_netdev() and
ib_device_set_netdev() instead of storing netdev in the driver.

Can you please convert MANA IB driver to proper API usage?

Thanks


Return-Path: <linux-rdma+bounces-13188-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC7BB4A8C6
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 11:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3BBA4E2999
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E07E2D4B66;
	Tue,  9 Sep 2025 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbTYKV5X"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9012586E8;
	Tue,  9 Sep 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411369; cv=none; b=tpi+bxhqFZRLIWZKsDXtBT9LILYgyeU7oXjXTfY6DgTitFCESQ/GZaEPIiwR1e9T3M1EiS8mauBtkBpCQF1geMx5u0z/8VcAb/GCGkJygTOE2VOOZtsUxrC3ALqTofc0Mp0hWNIbhjc5shfi1mptBDG3ERUL8ffG5S+fvbML0u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411369; c=relaxed/simple;
	bh=TZP/VSi3T/xdBnPWh0UygxwRtrfEiXguKCLRC+rkjmQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iwLJr63cE6jh3eUZ2w7J2pQ5fZguM5B8fx8y6fW4QEAXyXTdWw99RnhGC2QqqOtC6XZ/28l6ua73zwYfyfJb4UrDdgZsHexqMQ6oKi89sHze0qNZ/yJBqT+hwRDmXDnwD175KYD37mdyQqBraPXvyar8S2c6Sgm5yCme/lh5f+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbTYKV5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101A2C4CEF4;
	Tue,  9 Sep 2025 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757411368;
	bh=TZP/VSi3T/xdBnPWh0UygxwRtrfEiXguKCLRC+rkjmQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=HbTYKV5XMcbjUyZF93oILqZ5Xs7HhHO4uWVGvVwokBR3lK8YRXZCPsSvqjNw9C721
	 zGtXdiRNCAQB8gzDIzwOkZDaIk4LuyAryqvpJ7Ql7BE+5UdZ88KEs7IiqsXpnL2mh5
	 eFmqbzU+pHSTLABt+WdayFpBzPn9olp3VtczTKPibylqqIxLyhWMkU+xIEGsIWSEbE
	 CYtRcLpJNHBBirDPpcuMqgwuTbpgIbw67NbyNyysa4Nyrcr4AzfepyRDAuZogkpADm
	 OgsgQwyiLMJzs/agpr9x3IXGyqD9D744sDmxlHze4qZarJR6TB60ygdfJ6u/Ji82Dx
	 iSn3yimVJ/NBQ==
From: Leon Romanovsky <leon@kernel.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250826150556.541440-1-rongqianfeng@vivo.com>
References: <20250826150556.541440-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH] RDMA/rdmavt: Use int type to store negative error
 codes
Message-Id: <175741136559.672925.13426644093210144698.b4-ty@kernel.org>
Date: Tue, 09 Sep 2025 05:49:25 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 26 Aug 2025 23:05:56 +0800, Qianfeng Rong wrote:
> Change 'ret' from u32 to int in alloc_qpn() to store -EINVAL, and remove
> the 'bail' label as it simply returns 'ret'.
> 
> Storing negative error codes in an u32 causes no runtime issues, but it's
> ugly as pants,  Change 'ret' from u32 to int type - this change has no
> runtime impact.
> 
> [...]

Applied, thanks!

[1/1] RDMA/rdmavt: Use int type to store negative error codes
      https://git.kernel.org/rdma/rdma/c/6768aee67b1bd6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



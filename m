Return-Path: <linux-rdma+bounces-10322-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA101AB53B3
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 13:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C17A6927
	for <lists+linux-rdma@lfdr.de>; Tue, 13 May 2025 11:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F5A28D850;
	Tue, 13 May 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhbnpTOp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDC823F424;
	Tue, 13 May 2025 11:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747135322; cv=none; b=cjUMF5ttr2DBQOBkNjyJ9XD0AiSBuenCiqCu+a0NfjMX38XwJ3wR+Zo1kcKfDYlJqOAZwDyop/kcRpwdDdJPDquTtvMHqfr3jopz/yrX2TyQqKynXETuZCdSj14jhuetqGjNAsjG+a6n3hJvsnSuCSJOr+j+cwXRCvtrj9Oeqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747135322; c=relaxed/simple;
	bh=AxOuVlY+e5hOa0nTcg6ESWbQWoTmDjPzDuHdePL7ZY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RvLmGfi6od7HgOL4XkMZUMXoIJ5TfjVtyLCSlkHZnNToQM36JcXVyQYympyNYPhhVZRvBQ3YZ8BDdfBQ++uFwr/4XZWhDGm9RsGAn42c//Ho7CdGmyIvf0zf+f5Gdp8mLDW9+6Ryzd2CqZ0W9547/O9IrAfnFGmOg2IiJXFPXkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhbnpTOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D88C4CEE4;
	Tue, 13 May 2025 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747135322;
	bh=AxOuVlY+e5hOa0nTcg6ESWbQWoTmDjPzDuHdePL7ZY0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lhbnpTOpyiWhEQeLFq2ZZ1ws9ruLrfrNTuyKUvQCsMtfgoB3ugek4G3/cRqd6ThGq
	 52iJ5c86Mlvz6zlYzOGLuwJLpXsikj3t00hLquUYlXh2JXBvLE1oydL7XtWqCqRXfz
	 2mU0Ugac7ORgwLAuCsj84e1NbJUPnQdpZxPivpT5O+mhf/b2/R5B9TF/27DQFXetG4
	 TDZ1nwo4b7RciIuecLsD6Z4gqR4u+3JII5VVU7dB25rPPnEfxHRL4/PfVBymZiyXZO
	 PWb5aJImY2vNZYZEoCsJRJo4162usdz9+sqzSUi1tjD85IYqG5J0UrkMuZjvOvYH0d
	 v4z851B39Ojcw==
From: Leon Romanovsky <leon@kernel.org>
To: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
 edumazet@google.com, andrew+netdev@lunn.ch, jgg@ziepe.ca, 
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: tatyana.e.nikolova@intel.com, david.m.ertman@intel.com, 
 przemyslaw.kitszel@intel.com
In-Reply-To: <20250509200712.2911060-1-anthony.l.nguyen@intel.com>
References: <20250509200712.2911060-1-anthony.l.nguyen@intel.com>
Subject: Re: [PATCH net-next,rdma-next v2 0/5][pull request] Prepare for
 Intel IPU E2000 (GEN3)
Message-Id: <174713531875.701878.11174495107114492909.b4-ty@kernel.org>
Date: Tue, 13 May 2025 07:21:58 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 09 May 2025 13:07:06 -0700, Tony Nguyen wrote:
> This is the first part in introducing RDMA support for idpf.
> This shared pull request targets both net-next and rdma-next branches
> and is based on tag v6.15-rc1.
> 
> v2:
> - Free cdev_info and iidc_priv in ice_deinit_rdma() (patch 5)
> 
> v1: https://lore.kernel.org/all/20250505212037.2092288-1-anthony.l.nguyen@intel.com/
> 
> [...]

Merged, thanks!

https://git.kernel.org/rdma/rdma/c/21508c8c972ca0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



Return-Path: <linux-rdma+bounces-5312-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D6A994837
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 14:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0769F282F6A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E59B1DB37F;
	Tue,  8 Oct 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAtptmNc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360B320F
	for <linux-rdma@vger.kernel.org>; Tue,  8 Oct 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389297; cv=none; b=mdOQQrsJQDvBhdAizYHMd+2dMrSZBAyew7U7SouNmd/uAXNjSFXmx6voey7z3XWYMjkA+JZpXzTtyrI46l/e7lzxWgYGEzpII3iHS1VgqeblcOm0HWoe5peAdzkA3psGLp6LTK4wCpIYWWvgAns8HR8oxCrAw9eovB1N4iN13w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389297; c=relaxed/simple;
	bh=aRFsO06JSgRiyq87wiS2hsnuLFouXIseTOn21v/H9GQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FrvVieoJhkimnugYHZ/kMhTqduk1upKblvn/saqzlDqstNU64+NL/ACXgIOUZG4XmUE7aBt7NFkRipp/9MdKj65IjkLKPg64G713cz2A5YHT2OzS49JBOr4/BM2bD23AcTspbue3mab0ITwKQLbxLnGmGMjOrJk++rEXQMHmoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAtptmNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21F1C4CEC7;
	Tue,  8 Oct 2024 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728389297;
	bh=aRFsO06JSgRiyq87wiS2hsnuLFouXIseTOn21v/H9GQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eAtptmNc5QKmiaUUl5py8nmYW6zvA7Mh85eP6xflQuhfa4/0T0rESCuq2/oXJHRh7
	 FFGZQWEjRAg1vaADbSxcEe79c4e46mJx/u02xgN3iqWYARZvaBfbIUAUHVOSixxDyQ
	 StFABtReqmEqJ1ttQsIqZUXbi5iq1o1npp+N7fyAQnvBUVs2o52fL4nIvtAF/8ZB2U
	 OwQgipItgu9lvfrjX6V2RDefL0CAw54LnidbJSBu6g6SvGR2jhC9Jb9PysJzItc/K4
	 bw1rswYXYwHP6GJUbk7n9i9EVxoTesCm6+e54LIZAph1GSQt58oPaMax/Ija25m4iy
	 4/x6fO5UZp9hA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: linux-rdma@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>
In-Reply-To: <20241008114334.146702-1-anumula@chelsio.com>
References: <20241008114334.146702-1-anumula@chelsio.com>
Subject: Re: [PATCH for-rc v3] RDMA/core: Fix ENODEV error for iWARP test
 over vlan
Message-Id: <172838929218.393287.16600819016272375300.b4-ty@kernel.org>
Date: Tue, 08 Oct 2024 15:08:12 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 08 Oct 2024 17:13:34 +0530, Anumula Murali Mohan Reddy wrote:
> If traffic is over vlan, cma_validate_port() fails to match vlan
> net_device ifindex with bound_if_index and results in ENODEV error.
> It is because rdma_copy_src_l2_addr() always assigns bound_if_index with
> real net_device ifindex.
> This patch fixes the issue by assigning bound_if_index with vlan
> net_device index if traffic is over vlan.
> 
> [...]

Applied, thanks!

[1/1] RDMA/core: Fix ENODEV error for iWARP test over vlan
      https://git.kernel.org/rdma/rdma/c/5069d7e202f640

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



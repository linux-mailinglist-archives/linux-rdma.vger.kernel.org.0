Return-Path: <linux-rdma+bounces-5572-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAB99B2A17
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 09:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17687281A12
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2024 08:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835B9190470;
	Mon, 28 Oct 2024 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jea3Z17U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4E16FF45
	for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2024 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103815; cv=none; b=pAFrFAzMaN2bl20FGZYhgYLTibxuiqO1T/cHinpgH3B8S7ROSMCuZSe5UGILvkxzNS1osNAEJ7QbXggakbFqdOD1Z8ZovQGw3JeFISswU7kB/Tbo8bPA7xJ9qmk/jp2Hxv1X5M9dJpRMdtH8fELyLR5p4l07Yr6QaWo4oAONC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103815; c=relaxed/simple;
	bh=AHTmP15V+b+9Pb5/GrSWQWENpH2ihdF9PaloUoBlWHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=swjDvCNk/rmyxuzjE1R/nczygGaCoauGA3h37Y5/8iU535yMAOPfS6tythxHBsKsBZPogk+aK8nfw05We7zqAHahSFIPUBWvMre12e7HFmXy17eHTmkPitkg4iw6GnGPTNeUdzCSDmupAHUWoh/zDHMb4uMbe0mpOeDEPqwvDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jea3Z17U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7B3C4CEC3;
	Mon, 28 Oct 2024 08:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730103813;
	bh=AHTmP15V+b+9Pb5/GrSWQWENpH2ihdF9PaloUoBlWHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Jea3Z17Ug8ScYtVJHwQi7PM493I8KT3bNaQzBi4tM0AblKQpOIAEXeQnObvgf1i/e
	 tNJSw554tvtcrvxxx05WLOi+L/mST6VmyYKOnmXK3t0w3dstbhp/rocWjKWkLJwdKe
	 8dI5JJ9cLGDL/gow2E9VUaJ8RZtpCZDbyrvsbBFpTui2pOrBbu55A6Z2YB6F2XbNUl
	 ZjnF+b9DCwrUYZLsx3nUM8cIF8uDFu8SYmXTNu7jl7sRdFfA7HcgJv2LF5mUbznSL5
	 3FzkvdtRlJ4eGOcMXq9hBJo9GwDKu7K/Ys5Dwfk9HCbvxHqm3cCh+kVV0sxX+eSQKK
	 3gfp0wFwbjulQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <cc97764b5a8def4ea879b371549a5867fe75c756.1728555243.git.leon@kernel.org>
References: <cc97764b5a8def4ea879b371549a5867fe75c756.1728555243.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/ipoib: Use the networking stack default
 for txqueuelen
Message-Id: <173010380662.1756184.6434927940858017688.b4-ty@kernel.org>
Date: Mon, 28 Oct 2024 10:23:26 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 10 Oct 2024 13:16:19 +0300, Leon Romanovsky wrote:
> There is no need for a special txqueuelen value for IPoIB.
> This value represents the qdisc size which is not related to the SQ
> size, and the default value provided by the stack (DEFAULT_TX_QUEUE_LEN)
> is sufficient for typical use cases.
> 
> 

Applied, thanks!

[1/1] RDMA/ipoib: Use the networking stack default for txqueuelen
      https://git.kernel.org/rdma/rdma/c/c11db1bf0ddc3c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



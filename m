Return-Path: <linux-rdma+bounces-8652-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 948B5A5F452
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 13:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A50CD7A4CEA
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Mar 2025 12:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B0B266B71;
	Thu, 13 Mar 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FE/pZsoM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D332571BF
	for <linux-rdma@vger.kernel.org>; Thu, 13 Mar 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868821; cv=none; b=lk4GsT4y4d1JlSfacK9YAfjQulM42oiFgj7AnNlwRhne2NbgOoMYzRBkly4hu2GtWgSt6swhymcNOF39+UlLqXHTa8i0lljvf1/iIcHx3LN9kos5Ju8wQuaJRTzNq+skX0hO1NWV0kt7SWQAyK1qYN34CfHoulf4dVd2zFtnumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868821; c=relaxed/simple;
	bh=imRqnKhrNLEGe+gUjVAPUyEmHvQ8+pyD/yro6HPUT1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fiIlEX2jomxz1+jlP6G5nafx2sPT+Ve1+1dL4X7+I8gpngLDfWggWInmbuM2jqWKKPJ6JWALN+Gr/TRqALUvFK+2jcQtAAirP8AbeWGBQcl0LP2f9IB8RzaC3pomgijbQ9zZFcqcmwwANnk2ufuGN3T5UXhQWpI1LmrjOzyWi2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FE/pZsoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42909C4CEDD;
	Thu, 13 Mar 2025 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741868821;
	bh=imRqnKhrNLEGe+gUjVAPUyEmHvQ8+pyD/yro6HPUT1M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FE/pZsoMypQbGb/8VTfGsOpKPmNZSNQo4eQTCBbQpnNoIClZqXDaVjK0zdl8M39I+
	 VvZVyyZE0Yd4skopmQ90JbqdD8X7XkWqIH23ysuRxjqODF1WG+nLt2Gx6gqlELcdl+
	 VBp24VHRir6FQvoVulYMZ+PHOOhDYWup4yfq6h0AF5ZBC7hGFzj9LKpWG8Y7vG4KqP
	 3ctz1PWD2vx5ionvPvEr5on9Rgfiow4v4++nbEZ2pLIVR8p/Kh46tyg19qJ7voxOhV
	 DBqZ5Z7ZmM2eYnJxj0M+NGfltm2e8AyNiHDvs8g1YkALri/vbuLyy5LmwY/AVVHvBw
	 TG14AHV2wvCig==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Maher Sanalla <msanalla@nvidia.com>, linux-rdma@vger.kernel.org
In-Reply-To: <64f9d3711b183984e939962c2f83383904f97dfb.1740577869.git.leon@kernel.org>
References: <64f9d3711b183984e939962c2f83383904f97dfb.1740577869.git.leon@kernel.org>
Subject: Re: [PATCH rdma-next v1] RDMA/uverbs: Propagate errors from
 rdma_lookup_get_uobject()
Message-Id: <174186881737.533355.13926406691275120339.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 08:26:57 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 26 Feb 2025 15:54:13 +0200, Leon Romanovsky wrote:
> Currently, the IB uverbs API calls uobj_get_uobj_read(), which in turn
> uses the rdma_lookup_get_uobject() helper to retrieve user objects.
> In case of failure, uobj_get_uobj_read() returns NULL, overriding the
> error code from rdma_lookup_get_uobject(). The IB uverbs API then
> translates this NULL to -EINVAL, masking the actual error and
> complicating debugging. For example, applications calling ibv_modify_qp
> that fails with EBUSY when retrieving the QP uobject will see the
> overridden error code EINVAL instead, masking the actual error.
> 
> [...]

Applied, thanks!

[1/1] RDMA/uverbs: Propagate errors from rdma_lookup_get_uobject()
      https://git.kernel.org/rdma/rdma/c/81f8f7454ad9e0

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



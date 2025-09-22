Return-Path: <linux-rdma+bounces-13580-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D824B939AD
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Sep 2025 01:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030C2481382
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 23:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F702D5427;
	Mon, 22 Sep 2025 23:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mbah3QxT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBD260583;
	Mon, 22 Sep 2025 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758584202; cv=none; b=lsy8mWjZMDJwaoC4WeXCPYygbACDIoxIADHLEVQPM7MYCzN3Cy3cx2bc9FxsFHJgNLpMAeKEHqokYRW+RAZ3BECTeqmiKtvg8xdAs1pqZiJKRlivsireCZF3OVT9sq9WyqU6l7SQ3LJREHuxnq+6B+DYVp1okVuHxiI9KboqB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758584202; c=relaxed/simple;
	bh=QeuRrV0v+yB9NH3xmx+Y4CRYP/Vppq+zRFRPlfbQ+MA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2nCDO42HHk8A/TGK3inlfdPCv0T7JEonbsIu1PWL2DbDihtZRndi6GWb+7ofsBySNMbR2A+Vl6r15ua2aMpKEk29Rii3BxxFM7sQAXNX+RopXhgz1vcujc7Fmf+ZuyFEZQJCOkkGmemTHXX8HiXYsRyhWvUmp/e4MULsm5J8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mbah3QxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82915C4CEF0;
	Mon, 22 Sep 2025 23:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758584202;
	bh=QeuRrV0v+yB9NH3xmx+Y4CRYP/Vppq+zRFRPlfbQ+MA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Mbah3QxTzFBIvH7XVept/nzwoq5gK8MDEwQHE7ym78wga5i6lsTIV1a5oVkUAAwrl
	 oXw0BxjYvhNC6ECJXqTV28ducyJrqfahDkAmagM8WTPEgzEIWzWYyCJY5ZtqHCuT2U
	 Got7JIvcOwIAUNPTHLegTnlQtfpUJFdPEgx/NgYQg9zmAHmUN30+37bY1qhncw/kID
	 GgFtxaXh94zebz69fddhlLXBIYfgoRwVN7O1l4Gt7DmLhuRCoHii9q5Fti9Dv/C4NS
	 zeJtXpLSGBCnc55dBB9Fj7qcVej0+tvUp7sfbmbba9z9k46aPsGcQxJ4cEFJwb8aaj
	 lOJeXJxc4s/ng==
Date: Mon, 22 Sep 2025 16:36:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Julia Lawall" <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Richard Cochran <richardcochran@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <cocci@inria.fr>, "Gal Pressman"
 <gal@nvidia.com>
Subject: Re: [PATCH net-next 1/2] scripts/coccinelle: Find PTR_ERR() to %pe
 candidates
Message-ID: <20250922163640.2fc887e4@kernel.org>
In-Reply-To: <1758192227-701925-2-git-send-email-tariqt@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
	<1758192227-701925-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 13:43:46 +0300 Tariq Toukan wrote:
> Add a new Coccinelle script to identify places where PTR_ERR() is used
> in print functions and suggest using the %pe format specifier instead.
> 
> For printing error pointers (i.e., a pointer for which IS_ERR() is true)
> %pe will print a symbolic error name (e.g,. -EINVAL), opposed to the raw
> errno (e.g,. -22) produced by PTR_ERR().
> It also makes the code cleaner by saving a redundant call to PTR_ERR().
> 
> The script supports context, report, and org modes.
> 
> Example transformation:
>     printk("Error: %ld\n", PTR_ERR(ptr));  // Before
>     printk("Error: %pe\n", ptr);          // After

Hi Julia, Nicolas,

would you be willing to give us a review tag for this script?
Would you prefer to take the script via your tree?

https://lore.kernel.org/all/1758192227-701925-2-git-send-email-tariqt@nvidia.com/


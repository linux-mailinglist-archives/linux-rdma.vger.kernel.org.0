Return-Path: <linux-rdma+bounces-1838-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD44C89BD50
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 12:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF191C21225
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806356464;
	Mon,  8 Apr 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOgqV28a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2455C07
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712572411; cv=none; b=GRAJBukc/ebVY3yHNlAileW1ug1CvMf0px8XCKzjmN88f9IaSA5XHZ6KojF6ZZ6d5HiPM53cjmDYcOXyapUepHpsciYqgRWAvctx+AsSqQbullx+5DfF7rJrGuPmM+aeKywPtE8YvZhp5j1xJlROlZ7yquFG/kGCX1PgZgK1Lik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712572411; c=relaxed/simple;
	bh=HFDQxzzaKXw1qIJ04LcvwpAYxSfGA0p1Sxe9l7yy+SA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qrprPGbvmRV8VkPAv/ekZFu8+7oL24oa28VKn/ol9WjD8m1nNYXer0mQwVeoHeEsmVhDZlXcPKmAn+wyPC63iqqDCcn90utb7ZGsBPfDPtvQIFW/NRUN2CNOe3AWVEsWhARtq0Iy6Tc99XJUrHJTWaYQaHtsRq70/3caTQe+Hhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOgqV28a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C497C433C7;
	Mon,  8 Apr 2024 10:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712572410;
	bh=HFDQxzzaKXw1qIJ04LcvwpAYxSfGA0p1Sxe9l7yy+SA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uOgqV28as3SAUH6EzgXebvsFdLfifs04+oc+V+H8vZDXsHKjtGx88Er2RkkfK1t7R
	 662YHeAoFoNOSHylY+hDYqeCo60oPSJ7c/CYH+H4mc5OQ5JhtuoVf1FojsLaEUhPNa
	 Ir5H2auMsBMuChTFVK2xuks3hV2y7Ba4cKnwK73E++xU68zdk9eg6CAJHOO7D8e9k4
	 iE/mWcT3BUhVj3S6gQjaore+RNpGpVQchjLQx56IqBEC9sgMIbtwcNd1z/+V2bcWSX
	 vE0dQEG02pYeoGf6RKz2mpYFAI1CPXDsQADgTGQJ2LZZhyUXTKyImStV4+K6kv+I0A
	 AmTdwCrs0nkLw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Michael Guralnik <michaelgur@nvidia.com>, Chris Mi <cmi@nvidia.com>, 
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <9bfcc8ade958b760a51408c3ad654a01b11f7d76.1712134988.git.leon@kernel.org>
References: <9bfcc8ade958b760a51408c3ad654a01b11f7d76.1712134988.git.leon@kernel.org>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix port number for counter query
 in multi-port configuration
Message-Id: <171257240708.53338.7660509036900404767.b4-ty@kernel.org>
Date: Mon, 08 Apr 2024 13:33:27 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Wed, 03 Apr 2024 12:03:46 +0300, Leon Romanovsky wrote:
> Set the correct port when querying PPCNT in multi-port configuration.
> Distinguish between cases where switchdev mode was enabled to multi-port
> configuration and don't overwrite the queried port to 1 in multi-port
> case.
> 
> 

Applied, thanks!

[1/1] RDMA/mlx5: Fix port number for counter query in multi-port configuration
      https://git.kernel.org/rdma/rdma/c/be121ffb384f53

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



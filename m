Return-Path: <linux-rdma+bounces-10465-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E41ABF0F6
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 12:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBB93B04AC
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B131A9B4C;
	Wed, 21 May 2025 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwnWUlTT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8763C25393B
	for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822141; cv=none; b=ipWrpPtQaOSkDORM1Rl7cZSoeBhRTy5sEMaDktEtXDApE7apVzdXNYrQVhhC26RB03GUvRY/pqt/Bpb+nxZ5MXlDOuYDscf6AfpYeSHNU8bTv8UaKthZ2qV9tGp1BlBkhc7mU5HM+gsc4i7fNPfmdFJd84T93ITSMYGwI7r0YmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822141; c=relaxed/simple;
	bh=JhzSc59QfE2ATXn2ptXjI37mlLBDm0ToLCLzPLUTYPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRo/irpixs5Jz/bmkc1hGEG2S2P77OjOwO9K5so16TgMglA7wUZSYjn4D92URG/HJY9f5JtJguG/aPueAak+LP33Td7MnapEZWd2RcjpxxRIT0azb0lc9ofBy9I5S/aT3qsWC05/QMNfJDDTXZzUVhFix/aTipm7ARtzU84y7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwnWUlTT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DABC4CEEA;
	Wed, 21 May 2025 10:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747822140;
	bh=JhzSc59QfE2ATXn2ptXjI37mlLBDm0ToLCLzPLUTYPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwnWUlTTg+RbF5HGF1nPrpBjiDVSBRN1a2zhFThzaF/CPTHNo8AB6mZCG6P5apU8T
	 eW6HzEYddR3/TgwA960/Pg3yIZqjezCnEp9j354AdV+TQvXw9qdgjBAUfCKofx4rcB
	 c9UdCcNsxvc5UmXBty4BSQlbJzl6QjT07vuhYZW8x6fjTUkPZD8F1NaHrc14+Ky5M0
	 juavtLbYPbCGrLJd+7rnwTBen0RCyQ5fCZhtABmAQbHG4VauqHMEgyJiFQFzu+Hhjm
	 6QUlSjsAZTpGJjgY2IKcypZqFdsKJW2tGzuj6RcfXHN/fuCxqijyaUPu+bkMYa6Icf
	 X8lsyVKi0CoCw==
Date: Wed, 21 May 2025 13:08:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-rc 0/4] bnxt_re bug fixes
Message-ID: <20250521100856.GJ7435@unreal>
References: <20250520035910.1061918-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520035910.1061918-1-kalesh-anakkur.purayil@broadcom.com>

On Tue, May 20, 2025 at 09:29:06AM +0530, Kalesh AP wrote:
> This series contains bug fixes related to debugfs
> support in the driver. One fix is for preventing
> a NULL pointer dereference in reset recovery path.
> 
> Please review and apply.
> 
> Regards,
> Kalesh AP
> 
> Gautam R A (2):
>   RDMA/bnxt_re: Fix incorrect display of inactivity_cp in debugfs output
>   RDMA/bnxt_re: Fix missing error handling for tx_queue
> 
> Kalesh AP (2):
>   RDMA/bnxt_re: Fix return code of bnxt_re_configure_cc

Applied to -next.

>   RDMA/bnxt_re: Fix null pointer dereference in bnxt_re_suspend

This bug needs to be fixed in bnxt core driver.

Thanks

> 
>  drivers/infiniband/hw/bnxt_re/debugfs.c | 20 +++++++++++++++-----
>  drivers/infiniband/hw/bnxt_re/main.c    |  2 ++
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> -- 
> 2.43.5
> 


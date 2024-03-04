Return-Path: <linux-rdma+bounces-1200-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2DF86FAEC
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 08:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8F8281E24
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 07:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FE113FFD;
	Mon,  4 Mar 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBoTdBnP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC38134A1;
	Mon,  4 Mar 2024 07:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537752; cv=none; b=aDCvskx8TQQ99krzwnfbPcdrfiL7l7fRdaY2QNmlCKGqnx5WJLvkXF6GPxRl4pR3WoHk/KeYrq1K60qQ8Nqg68Z6+5OCNUPPYRZNZV5JuImDRcpIjSKrc4hFtawyNwfW8aPbfM2peqg+w2hwWoP9dQe1Q7WLP/hNVUmKRBh9bPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537752; c=relaxed/simple;
	bh=sR7Z3aF6MOnEgrGDelR18ny95bcpBeCc2Pf69bZcZOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHpXB/W0eA4MELK+S/tFbu8DYE4CQPae/RnqfyjZvk4eDiLAUQjSMcF4Q8DOlBLN4Dyz39IC0Cnu9wRyuF4un+G2E0eagGVM68yEFlQ3/RqSFksHlLzzkecsKyB2nu5gQmqIUBrlnTIJYmEMtfb1ZJQWt+S7gIb2kqB591DLOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBoTdBnP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66744C433C7;
	Mon,  4 Mar 2024 07:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709537751;
	bh=sR7Z3aF6MOnEgrGDelR18ny95bcpBeCc2Pf69bZcZOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBoTdBnPWUj+1vjWoLwwhXGdOTfvhOSpzYFkHUym0QKc9tIOQqNsAwxw2p+djbQfM
	 O1OvlI0jLJWHFIR2KALOnSI0zMA06uMudSXzomUkCRCGBqDI/dHhEyPL5PTi1bzOm7
	 HXWV63Srwu4AgVW280+sqAzDVyQ4Scwp9se+6OxsAaER3MmaTrUvnIAi0dRuoZKKEg
	 PoM3GYD9l1CzLzLs197AyaqGlwHIRB2Arm8/twoibVSowJ2h+mIa7czXjvkno0NEj+
	 eCc4wAofKIx7pCSJBFIiLi2fSYrN96Bl9OwfL2Hhov1OsI5RhdEu/nAxttLLzF4V6N
	 DXBOQSoUWYkJg==
Date: Mon, 4 Mar 2024 09:35:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Wenchao Hao <haowenchao2@huawei.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/restrack: Fix potential invalid address access
Message-ID: <20240304073548.GA13620@unreal>
References: <20240301095514.3598280-1-haowenchao2@huawei.com>
 <20240303125737.GB112581@unreal>
 <a7b2409c-4a3b-472d-a23a-87b12530be6d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b2409c-4a3b-472d-a23a-87b12530be6d@huawei.com>

On Mon, Mar 04, 2024 at 11:21:19AM +0800, Wenchao Hao wrote:
> On 2024/3/3 20:57, Leon Romanovsky wrote:
> > On Fri, Mar 01, 2024 at 05:55:15PM +0800, Wenchao Hao wrote:
> > > struct rdma_restrack_entry's kern_name was set to KBUILD_MODNAME
> > > in ib_create_cq(), while if the module exited but forgot del this
> > > rdma_restrack_entry, it would cause a invalid address access in
> > > rdma_restrack_clean() when print the owner of this rdma_restrack_entry.
> > 
> > How is it possible to exit owner module without cleaning the resources?
> > 
> 
> I meet this issue with one of our product who develop their owner kernel
> modules based on ib_core, and there are terrible logic with the exit
> code which cause resource leak.
> 
> Of curse it's bug of module who did not clear resource when exit, but
> I think ib_core should avoid accessing memory of other modules directly
> to provides better stability.
> 
> What's more, from the context of rdma_restrack_clean() when print
> "restack: %s %s object allocated by %s is not freed ...", it seems
> designed for the above scene where client has bug to alerts there
> are resource leak, so we should not panic on this log print.

Can you please share the kernel panic?

Thanks


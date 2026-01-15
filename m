Return-Path: <linux-rdma+bounces-15576-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EADB9D23FB1
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 11:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7CC83019E32
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853B536BCFC;
	Thu, 15 Jan 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noMN0T40"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4851A36BCDC
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473742; cv=none; b=ekWQ8HCj5N/INbbjFiKWWOMkhVoMkfMP2LV7sWd2qOfxY06mZP276mkc+PrbIg38sUyeIHTgYS3CU2kGTr6nnjXYsYJNjLjIIu+tmPF0u4J8rwpp2ochaUmKDnXXsB/qqpvhYKeMERuC8D4F7g1IuAzubLXLW4Y/IiQ7vYOsW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473742; c=relaxed/simple;
	bh=ZnOeJ6Tph2MeXhSXrnVMH4kRTPw7M2/dMCuDsnBRAsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiVtSEPFktMXHnhbgTRaC3Ucfvkg+m5DaRPxSi2+akqSA41Yo0uaGUWdmlcnrKcpkG3/6jIMSgvOcn/IKkNQOJ8Ia4Urbujs7vKAT/C0x4oNxczjgfkehoH2JfcZNgzcHb+hTH3T85JvG8crKv/FEFEc7kjif8Fz7BTYrOEzoPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noMN0T40; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F6EC116D0;
	Thu, 15 Jan 2026 10:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768473741;
	bh=ZnOeJ6Tph2MeXhSXrnVMH4kRTPw7M2/dMCuDsnBRAsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=noMN0T40H4u/O7Wfb4EWBB8tSaignycMjDwBB5s55Vo+fjZSfpv/1Bt4oSGV+Y1Oj
	 0wGqtO8xuKUVxXQ3EAxMx5gcjEJ5yveKZvfUcd5VlqVPyO+sY12COzZnb5mOtYIjqZ
	 wkeaHmjjVVdqS5PRHLP+ef9n+O4IVlR8EoRgqlyhH16TGJdt3KWoWINtNFosbyV5tu
	 XDAGBO3kv6kIFKuSEB79sKaAb6gBVaKHgTCLlpLnKSedEp9QHfIYAB/y5fP6CYrJHF
	 Z4bpNX53ATjXn2RfIq5kexlZADkZdwdxFdXkJLKnTA3BtR0pQu89wDwwMjbyPyb03L
	 u47pN+5YQ2qKw==
Date: Thu, 15 Jan 2026 12:42:18 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Add 'static' declaration
Message-ID: <20260115104218.GD14359@unreal>
References: <20260115024154.1825736-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115024154.1825736-1-huangjunxian6@hisilicon.com>

On Thu, Jan 15, 2026 at 10:41:54AM +0800, Junxian Huang wrote:
> Fix the following warnings:
> 
> >> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:964:6: warning: no previous prototype for function 'hns_roce_v2_drain_rq' [-Wmissing-prototypes]
>    void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
>         ^
>    drivers/infiniband/hw/hns/hns_roce_hw_v2.c:964:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void hns_roce_v2_drain_rq(struct ib_qp *ibqp)
>    ^
>    static
> >> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1001:6: warning: no previous prototype for function 'hns_roce_v2_drain_sq' [-Wmissing-prototypes]
>    void hns_roce_v2_drain_sq(struct ib_qp *ibqp)
>         ^
>    drivers/infiniband/hw/hns/hns_roce_hw_v2.c:1001:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void hns_roce_v2_drain_sq(struct ib_qp *ibqp)
>    ^
>    static
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601150334.jRDP5xSy-lkp@intel.com/
> Fixes: cfa74ad31baa ("RDMA/hns: Support drain SQ and RQ")
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I squashed it and rebased my wip/leon-for-next branch.

Thanks


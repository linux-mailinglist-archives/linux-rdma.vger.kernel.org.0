Return-Path: <linux-rdma+bounces-9383-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2497A86528
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 20:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD6E189FF9F
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1776420F08E;
	Fri, 11 Apr 2025 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpQ2vSQu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF01D9A5F;
	Fri, 11 Apr 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394517; cv=none; b=tv5JahRtEY2ECgsvy/WyFMEvMzUcNqA55qkN6+uD1KOHL7EuSgTMPiTHzYL5Oc1zQcmMT62J3M0MVShWjPDUHCk7OW8HpOI9fSE/2Yqvj73upxdq8gHbfY9gIYBektPpkCdkZOH99Ii0bGhFv295vMOsFRmJ7P7hYsJ6MO+AdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394517; c=relaxed/simple;
	bh=jPqSQEgdetj1cQhBqh5DPo/z29J5ovjpZyUv7yi8J7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtlcFMEC7M6w2izLibVOGm2AEGzbzeIzFz+jkiqF0+Vrl69ZOYpzpOyRcoIoe1TSMySXWguEeCujIX+1WZh/vphxwjW+oQutotUQlt+zI/wlvHaN6m2QZ+Dj1qElsVBjO3lmp0cfdLsl6ItHQar6ZQyOrbj83IbjW7M9is6pg6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpQ2vSQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA48EC4CEE2;
	Fri, 11 Apr 2025 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744394517;
	bh=jPqSQEgdetj1cQhBqh5DPo/z29J5ovjpZyUv7yi8J7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZpQ2vSQuBBjrX+xwNs0LTLsSaiExNoc5yDBAksFFdEyIC4ijhyVQK/OE7LygcCHlN
	 +b+rwzLjYU3ad2sDQPpGsly9EwYCXr5Z5ODKxUzfjljakpt34OtycgQ/KK2EmOZpr9
	 3wjfN1k7sESNJ38iMavxoA8w3yE78R9VJRAZ3UAMn4GhNfF3g/1/5P12NwgKSKEmLS
	 EDh+8su4tjEDSU5WniO5xb+t+M9xiV9Ths07KG2aJJkPV52gAIz1kZhcKfA+fTsh7X
	 G6Ys4Mzo1xTrI3t9KagX/v4jdx5vhJqcEhNsGXQjX61Oio3gwOqkOxv1/EgtdnwOXL
	 VkwxAwiE/iaiQ==
Date: Fri, 11 Apr 2025 21:01:50 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Chen Linxuan <chenlinxuan@uniontech.com>
Cc: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Winston Wen <wentao@uniontech.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/7] RDMA/hns: initialize db in update_srq_db()
Message-ID: <20250411180150.GY199604@unreal>
References: <31F42D8141CDD2D0+20250411105142.89296-1-chenlinxuan@uniontech.com>
 <20250411105459.90782-1-chenlinxuan@uniontech.com>
 <FF922C77946229B6+20250411105459.90782-5-chenlinxuan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF922C77946229B6+20250411105459.90782-5-chenlinxuan@uniontech.com>

On Fri, Apr 11, 2025 at 06:54:53PM +0800, Chen Linxuan wrote:
> On x86_64 with gcc version 13.3.0, I compile
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c with:
> 
>   make defconfig
>   ./scripts/kconfig/merge_config.sh .config <(
>     echo CONFIG_COMPILE_TEST=y
>     echo CONFIG_HNS3=m
>     echo CONFIG_INFINIBAND=m
>     echo CONFIG_INFINIBAND_HNS_HIP08=m
>   )
>   make KCFLAGS="-fno-inline-small-functions -fno-inline-functions-called-once" \
>     drivers/infiniband/hw/hns/hns_roce_hw_v2.o
> 
> Then I get a compile error:
> 
>     CALL    scripts/checksyscalls.sh
>     DESCEND objtool
>     INSTALL libsubcmd_headers
>     CC [M]  drivers/infiniband/hw/hns/hns_roce_hw_v2.o
>   In file included from drivers/infiniband/hw/hns/hns_roce_hw_v2.c:47:
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c: In function 'update_srq_db':
>   drivers/infiniband/hw/hns/hns_roce_common.h:74:17: error: 'db' is used uninitialized [-Werror=uninitialized]
>      74 |                 *((__le32 *)_ptr + (field_h) / 32) &=                          \
>         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   drivers/infiniband/hw/hns/hns_roce_common.h:90:17: note: in expansion of macro '_hr_reg_clear'
>      90 |                 _hr_reg_clear(ptr, field_type, field_h, field_l);              \
>         |                 ^~~~~~~~~~~~~
>   drivers/infiniband/hw/hns/hns_roce_common.h:95:39: note: in expansion of macro '_hr_reg_write'
>      95 | #define hr_reg_write(ptr, field, val) _hr_reg_write(ptr, field, val)
>         |                                       ^~~~~~~~~~~~~
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:948:9: note: in expansion of macro 'hr_reg_write'
>     948 |         hr_reg_write(&db, DB_TAG, srq->srqn);
>         |         ^~~~~~~~~~~~
>   drivers/infiniband/hw/hns/hns_roce_hw_v2.c:946:31: note: 'db' declared here
>     946 |         struct hns_roce_v2_db db;
>         |                               ^~
>   cc1: all warnings being treated as errors
> 
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> Co-Developed-by: Winston Wen <wentao@uniontech.com>
> Signed-off-by: Winston Wen <wentao@uniontech.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to rdma-next.

Thanks


Return-Path: <linux-rdma+bounces-8713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB71A62076
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 23:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11DAD1B61851
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 22:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001CC1C860B;
	Fri, 14 Mar 2025 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N76LKjBC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB93A17D2;
	Fri, 14 Mar 2025 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741991653; cv=none; b=umaV7OITYaHSJFnrb5fW88DZWxEWWdX23VXCcWhv/NOuxF5/ms/oQJymVZXR+muUQZRlDMF4RzAkRwiJL98L1wHbgXXHQWchWLHj2vHUI4Shm8iKUT2iWqp/Tq8+3kht1AQ71mIqUhI368MB/dLTtPm+EgToPQvCEZ/a01NGlm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741991653; c=relaxed/simple;
	bh=cxzm5zYY1l1bmlJvkobgWA6eYT2vP60f0sOLuMzfz3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aj68CvqcW65+hOw82fO7YMGSB/2yNMg2OhlY7ajO8fr9P0hOcxe/xNuNaab99AU3DAL2I+kpivtixkF4a1txN/WIo2YKAxzytbqijubpeWPVJkPUHgWKrg27MSb4RMbFe7oVn+wc/H3UkqCDUmBXLqpS+wKIMK6th5X/+w2A7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N76LKjBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86015C4CEE9;
	Fri, 14 Mar 2025 22:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741991653;
	bh=cxzm5zYY1l1bmlJvkobgWA6eYT2vP60f0sOLuMzfz3Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N76LKjBCyMduvUrbtCeEPqDsscXWs1R9nK/zj8bCDBOor1U0FwClA04kVBI+3xxT0
	 bCPdF0M71MmpGPss64+jSxj0luB1Hk8wxbkfi1cyl8DWjBJE9ulUthibb9/07newUi
	 InuE7pF+iaFH5Z9w8i1eRGdMj75Jjg9gcIKpWR6ydIqjMt1G3OUMloKcfqQC3XE3t3
	 9FvH3qPi1wB1KhX8mDTrEHp27iCiAU2vfs4IU2qPN8FIo5cYPQtsedttMyG2Xvzks5
	 8+ObQACokxuuTAeuobtWjEaGk44zzHO9ijIi/uLyZpSEUWIxYUBJob9zUmBl2y4QyY
	 /ay9dX5bW1hFQ==
Message-ID: <553dff52-f61a-4f16-af4c-72d2d2c6bc3d@kernel.org>
Date: Fri, 14 Mar 2025 23:34:02 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Content-Language: en-US
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Saeed Mahameed <saeed@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Jakub Kicinski <kuba@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 "Nelson, Shannon" <shannon.nelson@amd.com>
References: <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
 <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal> <Z8i2_9G86z14KbpB@x130>
 <20250305232154.GB354511@nvidia.com>
 <6af1429e-c36a-459c-9b35-6a9f55c3b2ac@kernel.org>
 <20250311135921.GF7027@unreal>
 <4c55e1ae-8cc1-463e-b81f-2bbae4ae4eed@kernel.org>
 <Z9FjJAgdmWcepxkg@mini-arch>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <Z9FjJAgdmWcepxkg@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/12/25 11:34 AM, Stanislav Fomichev wrote:
>> More specifically, I do not see netdev APIs ever recognizing RDMA
>> concepts like domains and memory regions. For us, everything is relative
>> to a domain and a region - e.g., whether a queue is created for a netdev
>> device or an IB QP both use the same common internal APIs.  I would
>> prefer not to use fwctl for something so basic.
> 
> What specifically do you mean here by 'memory regions'? Ne

netdev queues and flows are a subset of RDMA operations, so I mean MRs
as in:

IBV_REG_MR(3)  Libibverbs Programmer's Manual


NAME
       ibv_reg_mr, ibv_reg_mr_iova, ibv_reg_dmabuf_mr, ibv_dereg_mr -
register or deregister a memory region (MR)

SYNOPSIS
       #include <infiniband/verbs.h>

       struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr,
                                 size_t length, int access);

       struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd *pd, void *addr,
                                      size_t length, uint64_t hca_va,
                                      int access);

       struct ibv_mr *ibv_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset,
                                        size_t length, uint64_t iova,
                                        int fd, int access);

       int ibv_dereg_mr(struct ibv_mr *mr);

DESCRIPTION
       ibv_reg_mr() registers a memory region (MR) associated with the
protection domain pd.  The MR's starting address is addr and its size is
length.  The argument access describes the desired mem‐
       ory protection attributes; it is either 0 or the bitwise OR of
one or more of the following flags:

...


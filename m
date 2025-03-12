Return-Path: <linux-rdma+bounces-8621-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C47A5E3BF
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 19:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416903BBF15
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Mar 2025 18:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F201CD20D;
	Wed, 12 Mar 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQMU5t6s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D313D81
	for <linux-rdma@vger.kernel.org>; Wed, 12 Mar 2025 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804632; cv=none; b=JTV/Dt14qi+qixYuqn2z1ZEyGQla6h5bn5CFCGKwwJfSTxxuIf+Ixuag8efnVtgQ8LBAiaOc+eATHKeIpXqfW6QA9GRnSEC1N907BUb4tdwQTO5s1gYlVNdUTxPqpgOnkMzrjgSj9LRbxkthWtzyeqGfJX1ropaHH2Dybf6qzJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804632; c=relaxed/simple;
	bh=7FA2ye0Hs2A/fnF9huQD/9Itftbdu6z4v7dEKf2gvzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7AwGL3IPVgus5LNdyX1j2DmGgx3ssABXCjl5pgANfAcFg6nRyt4ty4d6OWLjYjGhH3MgfqEfdKI4QqhrUE+hzVZiQ0yq3ut8p3/iMbudQka1iwAvx19odJ1aSmT5/A6CCHx4IuDjGW6cYOs2cHGYuCvFsRkeuZVCdBEHrZIH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQMU5t6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6653BC4CEDD;
	Wed, 12 Mar 2025 18:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741804631;
	bh=7FA2ye0Hs2A/fnF9huQD/9Itftbdu6z4v7dEKf2gvzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQMU5t6sWzuxXzWAx6lIpW40lBbZT3sUxDdh5S34dinnDDChfCiF64iU+WQ4Tj8Xq
	 iFfSU+OFJMXicy5EA7RdmWpMTau3Ahxx2ygQxehBvQP7VmlxYIP4w86rYj+Uu5njFv
	 YzLRVpKnaxfmDM2X0K3aqNR193W+0cYFvHTYIACDJpl9GhPHJctshhgvqht3+2lV+f
	 /w/w6tMPFaqaHihIkrwMnSxLugl4yg0IADXcXi0ahKU0D11NmQiKD2kqpozrmFCir7
	 tJOFd2zuod/7PoJjHIhlz3DxGR8hrCnPwLE7l9Epr10/xfKE48Nj/Z6T/s3/9xFmCI
	 SHphXcdkFjPpQ==
Date: Wed, 12 Mar 2025 20:37:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
	tangchengchang@huawei.com
Subject: Re: [PATCH for-rc 0/7] RDMA/hns: Cleanup and Bugfixes
Message-ID: <20250312183706.GF1322339@unreal>
References: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311084857.3803665-1-huangjunxian6@hisilicon.com>

On Tue, Mar 11, 2025 at 04:48:50PM +0800, Junxian Huang wrote:
> This series contains some recent cleanup and bugfixes for hns.
> 
> Guofeng Yue (1):
>   RDMA/hns: Inappropriate format characters cleanup

Applied to -next

> 
> Junxian Huang (6):
>   RDMA/hns: Fix soft lockup during bt pages loop
>   RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
>   RDMA/hns: Fix invalid sq params not being blocked
>   RDMA/hns: Fix a missing rollback in error path of
>     hns_roce_create_qp_common()
>   RDMA/hns: Fix missing xa_destroy()
>   RDMA/hns: Fix wrong value of max_sge_rd

Applied to -rc.

Thanks


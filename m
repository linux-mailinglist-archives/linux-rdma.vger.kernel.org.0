Return-Path: <linux-rdma+bounces-13474-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DB0B83C81
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270AA587F6D
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB73002D4;
	Thu, 18 Sep 2025 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YN1Xx/vR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C202EF670;
	Thu, 18 Sep 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187597; cv=none; b=E8qiPBHiu3mS27pc1q6eNnyb0SB+4cNUCg33Ix0veab1E3k+0bPLuTECh8RVFx9x73bIs4xHQhsfIrayYVfzO2W10lYmzpXp/8Gv4FmHJbUTHvYRn2EoN38Y9aYt0TqP/XILWHwwPSlpZoPbDh8TWOVSj19duhz406jJEJQTk3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187597; c=relaxed/simple;
	bh=uK8K+McimdqfVysQIcucW40VdesqNWFbdgb2B2jmf8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XTkZrdS3xFZhL/Qn0grDTOLF/1HQQKvMI/0/lvtkpzPudqyESvZIzM3UP95Uq3Es+dnmY6gaftB+LLKBx5kNeNEpC6swxzJ5w/rlpluyveGV3/Jhn4KcMBmjRgFE866mbdcWwBrjhouL/2iJEeeoqUT6xrCJJmQJV6AiBeEHYg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YN1Xx/vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD49AC4CEE7;
	Thu, 18 Sep 2025 09:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758187597;
	bh=uK8K+McimdqfVysQIcucW40VdesqNWFbdgb2B2jmf8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YN1Xx/vRNo7d0mncD5CfN5aEoWJPXWNVfikNeazO4WCPw/koQz9IpiB5qdp9+y06w
	 kIzh+WTnEYX3envCYC80xvFTzNE3VHGtziljHuYkEqKTD5NhiIbJ9NIqsluS/y/5nN
	 X6vNrmp8l/IAIXvsiC5PaYC6bxeg5x6Qzo0aZNDaOgq7TTySCoaYOR/dE/AYbALYWm
	 dzrgiPuFZHY4Um8bsT9Khgi6CU688v3ip0wfUh+ZTSA0XUbaHnk0+tcEnOZeSklhaJ
	 wrB5aIzWb9iSjDvW7XbkQ0xPp8lCo9xN4IwOnucGUB3BB+KGJstnnlysz5g7X4IsfE
	 00wtRloSIqqDg==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Edward Srouji <edwards@nvidia.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vdumitrescu@nvidia.com, markzhang@nvidia.com, ohartoov@nvidia.com, 
 ira.weiny@intel.com, kaike.wan@intel.com, dledford@redhat.com, 
 john.fleck@intel.com
In-Reply-To: <20250916163112.98414-1-edwards@nvidia.com>
References: <20250916163112.98414-1-edwards@nvidia.com>
Subject: Re: [PATCH 1/1] IB/sa: Fix sa_local_svc_timeout_ms read race
Message-Id: <175818759420.1954322.16553906868936878178.b4-ty@kernel.org>
Date: Thu, 18 Sep 2025 05:26:34 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 16 Sep 2025 19:31:12 +0300, Edward Srouji wrote:
> When computing the delta, the sa_local_svc_timeout_ms is read without
> ib_nl_request_lock held. Though unlikely in practice, this can cause
> a race condition if multiple local service threads are managing the
> timeout.
> 
> 

Applied, thanks!

[1/1] IB/sa: Fix sa_local_svc_timeout_ms read race
      https://git.kernel.org/rdma/rdma/c/1428cd764cd708

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



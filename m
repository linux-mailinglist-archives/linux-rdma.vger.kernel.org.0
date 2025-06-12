Return-Path: <linux-rdma+bounces-11244-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CCDAD6A94
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A81B16936B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E804D1B043E;
	Thu, 12 Jun 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7I/d8Vx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C448F5C
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716625; cv=none; b=BcVmBr4qeUA0mJHFz+06v9Ar9RQGYrTRRYePjWlk2yZsVLxZrGwyY4zKyTY/KOQcTa/Im47/4IGZPda5cPutxrI8CBDWqtfLGVR53v/9j2oNryHIiCTWg/5M5rnMjutE6gz2Ox/P89zj07YE7WRmpKomsp8ZMni8QuiXhCE8hDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716625; c=relaxed/simple;
	bh=NUVuUJCGytNAa/LgwOVdFX7tDnIrkGFBLN7yQc60TvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Va1EYUy/q+ifbQqFn0wcTefnQZ2MZ04E29Q9SY6nTY/JRKTlSKw3D/G+SRlYVPQ3nPnURjPbQJ7YhYkOtAKA1rzTCBAZBTGkHCLg7gQn71q39riO1vHV/nwcICsBOIJEyqYhA6ywBAcqxLLSgPGsU88WkpzLLkdC4QRNlETiQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7I/d8Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3981C4CEEA;
	Thu, 12 Jun 2025 08:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749716625;
	bh=NUVuUJCGytNAa/LgwOVdFX7tDnIrkGFBLN7yQc60TvE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=m7I/d8Vx3en9NnjGrJJCMp/Q6Oq0CkSmV/sYzWEhgqSFp6z3VFqoH4jST4ilcQf/g
	 2fYP3mRvz8JQ/CqdowxQ/8LrVJP4gKqucUCVcp8Et/F1TRAixTcRDhJiuOvmiQeQCJ
	 1FzsxDqLEdW1VnMhipPCLNcAAYXL1SzefHQ75lmX9HjM3oH3pIPpj8Y8DDE4GkomM7
	 gD5UgylfD3riMYzpd39GtgoRa/zHvlZ+nwMS5C0mdtKGyzpNNKgRoNH+f288A3Rbxf
	 JsCe2pfUvmml1NvZkFB+fTL6PbtsrfLA0F6lDzaFdX5sci1cRpnAKfzr2LfEf2ALr0
	 T5cVogYpnXYZw==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20250605024917.1132393-1-huangjunxian6@hisilicon.com>
References: <20250605024917.1132393-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next] RDMA/hns: Remove MW support
Message-Id: <174971662191.3782452.1560484120842611835.b4-ty@kernel.org>
Date: Thu, 12 Jun 2025 04:23:41 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 05 Jun 2025 10:49:17 +0800, Junxian Huang wrote:
> MW is no longer supported in hns. Delete relevant codes.
> 
> 

Applied, thanks!

[1/1] RDMA/hns: Remove MW support
      https://git.kernel.org/rdma/rdma/c/8f077ba91b593f

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



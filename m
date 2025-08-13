Return-Path: <linux-rdma+bounces-12705-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DCBB24875
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 13:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6771A27449
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D12F6570;
	Wed, 13 Aug 2025 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/EsR+QY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422F212547
	for <linux-rdma@vger.kernel.org>; Wed, 13 Aug 2025 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084535; cv=none; b=Cfol5CFxrbTNirJgSdbY2UMwflVfpvN0117bLy7VWQar97lVryigzizpZKw/dMI8V7hJCv7cnxsUuq4adm3Y1Bgui6G4TGTGQJSrT92ixp4RAB1o9YBj13NkFo2V1ztBgzdBm+nSgFBDO1N9Tc3CxzFfR8c1hiUJBiKh0162wGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084535; c=relaxed/simple;
	bh=b+BJwdXJ+U5tM2Yoabd+rBocoKqS0m7lwEuUWh70Uow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j0wQFWQgPj3qNs9BkEcbSOj770sfP7MrWxtLSl/1mZ2UWc9ubZHM8b8B3PHOtpTj1nck8lZpW3GXJU1+/iWuHgD/Kgwik32JqYTUrrJYw0Bmvy5cMMoU2EmF6+QkvkMLLqyurqviVUy7vwVtcqx/aNgBq84xCZqFCCe17NF9inA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/EsR+QY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9855C4CEEB;
	Wed, 13 Aug 2025 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755084535;
	bh=b+BJwdXJ+U5tM2Yoabd+rBocoKqS0m7lwEuUWh70Uow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n/EsR+QYDr76skhDNoPnu96DNr7aUKOaifg0/UWkjE9un16V7HutpXeBDLkuUQwZe
	 vJ/SV6eB7BxHlkvUVuP1PmHxbjcDU1Qk7I0mnfWcc8+nQPTztU1MqLbMKclRQ0nU3y
	 onmbxEHA0w1psySemibfFjIb0a4+0N3FHbccr4foD873C/FndE2+o2KVatToDXqXAo
	 fLKHl/YdJumBTezW0PDxEnb8NXM0cvdqWO22/gIWR7OBV7XEn47uEBTof/bjZQkuav
	 5mWma1jywH/1iJDlQQBj0iXKDo4zh7t0Uvgq0jAG33+z0deZY8Eso0HLyi8YxU9mqM
	 V+xbIQD1WAqCQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com
In-Reply-To: <20250812122602.3524602-1-huangjunxian6@hisilicon.com>
References: <20250812122602.3524602-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-rc] RDMA/hns: Fix dip entries leak on devices newer
 than hip09
Message-Id: <175508453196.201413.2328539322104230853.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 07:28:51 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 12 Aug 2025 20:26:02 +0800, Junxian Huang wrote:
> DIP algorithm is also supported on devices newer than hip09, so free
> dip entries too.
> 
> 

Applied, thanks!

[1/1] RDMA/hns: Fix dip entries leak on devices newer than hip09
      https://git.kernel.org/rdma/rdma/c/fa2e2d31ee3b72

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



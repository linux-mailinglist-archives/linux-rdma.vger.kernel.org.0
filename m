Return-Path: <linux-rdma+bounces-10291-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF3AAB329F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 11:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A57AA7AEA69
	for <lists+linux-rdma@lfdr.de>; Mon, 12 May 2025 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2831B25A62D;
	Mon, 12 May 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plk7nQkp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58B25A357
	for <linux-rdma@vger.kernel.org>; Mon, 12 May 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040553; cv=none; b=tdfD9lTJZfgUfS9l0z3bvW1ygFXFRcp/rNynbyd1YZlqNwaE+zhkyQiJmAQYIiCPHeyS+cS16mz8XaoEj7zT3jdPzxzG/gLmpDajL/OZRX0wj896qbKAsI+UOCxugIJ2FdWX8+2x+FTK2aZK3CIJ116pfX3wk6cLXCq5uhSS8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040553; c=relaxed/simple;
	bh=FwVbfe4WeG6M4OhWk0ehpgyI2WPSVhDR5MZsSIcC3OU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XO6E1RzprkOupv7sWJ37O3zn8ve+qaFINoEbZejI+tD9gLNnUkAqWQ3iXsN7VXUdKUbRziFXiOAG4DC7Ts1PylPQC6o+npa8ALALwehfbC6EcxV6K18HvD6VlQZ/8LLUbSNhxnICBhclbLmYbt+fhru/8/PIHLaBs2JYV2h12Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Plk7nQkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B51C4CEE7;
	Mon, 12 May 2025 09:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747040553;
	bh=FwVbfe4WeG6M4OhWk0ehpgyI2WPSVhDR5MZsSIcC3OU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Plk7nQkpxJhW+ool2GhnaEkXgIcEFEuVYF0BCMYzlVN9X4UJvjE+dRYs4Xc5sdFO+
	 Xpv16YdojujPrLY0dd093pTZPZJp58x6Wi2nP5BWF1/5GyTL+4Is4UPqRznU//1Vw5
	 V3tnrvxAb/jVCyAwaWIIbozg84jjhCbV73blTyKXveu7X6KZ+3mUrMSmVWq3dJBKhk
	 Hj6sdoHWLfxa4MVKZFR+AQB4DeHK9nutb138XGMSy9b3fv0ZwwTFmoA2WvcM8MSMuT
	 f8QdaptSHjpEz2rnf9Dulu1WpgouIvshT7fmkw3KnNFfZJYTZH0QcFE+BqDiLPwJ6d
	 w7kfrq+LIbPFQ==
From: Leon Romanovsky <leon@kernel.org>
To: jgg@ziepe.ca, Junxian Huang <huangjunxian6@hisilicon.com>
Cc: linux-rdma@vger.kernel.org, linuxarm@huawei.com, 
 tangchengchang@huawei.com, paulmck@kernel.org
In-Reply-To: <20250507033903.2879433-1-huangjunxian6@hisilicon.com>
References: <20250507033903.2879433-1-huangjunxian6@hisilicon.com>
Subject: Re: [PATCH for-next] RDMA/hns: Fix build error of hns_roce_trace
Message-Id: <174704054955.547926.17952486467201868736.b4-ty@kernel.org>
Date: Mon, 12 May 2025 05:02:29 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 07 May 2025 11:39:03 +0800, Junxian Huang wrote:
> Add include path to find hns_roce_trace.h to fix the following
> build error:
> 
> In file included from drivers/infiniband/hw/hns/hns_roce_trace.h:213,
>                  from drivers/infiniband/hw/hns/hns_roce_hw_v2.c:53:
> ./include/trace/define_trace.h:110:42: fatal error: ./hns_roce_trace.h: No such file or directory
>   110 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>       |                                          ^
> compilation terminated.
> 
> [...]

Applied, thanks!

[1/1] RDMA/hns: Fix build error of hns_roce_trace
      https://git.kernel.org/rdma/rdma/c/4ffb62fa8925c1

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



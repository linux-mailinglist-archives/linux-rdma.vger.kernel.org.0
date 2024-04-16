Return-Path: <linux-rdma+bounces-1959-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ECB8A6A0B
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 13:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCB102827A3
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Apr 2024 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50F712A166;
	Tue, 16 Apr 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kU5OOEj2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A648A12A153
	for <linux-rdma@vger.kernel.org>; Tue, 16 Apr 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268771; cv=none; b=hB7oa0E3bexrV1UgDJrHLewUEd0ZXjZiBn6K5bJ4I9yghrC7K/RQTKCnQuPmqPo1+ZRf0Q3cVS0noml+OGrdL5dX4c4zhr2fcZKvpNsK9J6SoShk6nChEqUAUZN/ybkMPNGcZ2tem54rMpv+B9OBkXSo0xlfougogSU6//dxwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268771; c=relaxed/simple;
	bh=6ykrYpm9WdpKrq/IxSTJ7s2BR/MfRmk23MYJUrIKI5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AJZ/L5KYXZlDadjyPc9hOpCpgTEsIXqIItLxBX7wqc1pReLTd6Ckbf8tAH/UAbyBOWnyjigxnM1XrNIuw2Xt6cfLBdThXxeuBWSf04wzxjheUI+uKi70lT8jgW5ycD5joz3fvtWq/o4MTy32uL/wS6aHytxpAolZrsSgDvFVSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kU5OOEj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A523CC113CE;
	Tue, 16 Apr 2024 11:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713268771;
	bh=6ykrYpm9WdpKrq/IxSTJ7s2BR/MfRmk23MYJUrIKI5Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kU5OOEj2YtEsCkOAotPdJQaYXY8VcG3uzyVpD6doVwnSXcyLoc0phvF+sq/tDD5PK
	 mJOWSR0Cj/EaK6WkxxlbQZBoZhhfsslekJNqudd0+ig90dimq1gq1MH7GEc45ka3JP
	 2n0rmVOWyX6ZwqaEk43cJ2t9UtB5GkIAwGve/DKm7ipMmmSRs3C7aqYPPNfCZoNCXy
	 T1YeX35RpmFYWn6pZtGVHMjiQQT1jP4glf4kQ/W38WVD7f6pTZy1TCO8uZGRhnvyce
	 vohhnyY4oogBhd7KTP+sU717UxraI5HBvncZ7U5S3I79x4gyy3nxYsMowVdyboxvVb
	 xIZ6NRBrEUvMA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-rdma@vger.kernel.org, tangchengchang@huawei.com, 
 huangjunxian6@hisilicon.com, Zhengchao Shao <shaozhengchao@huawei.com>
Cc: jgg@ziepe.ca, chenglang@huawei.com, wangxi11@huawei.com, 
 liweihang@huawei.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
In-Reply-To: <20240411033851.2884771-1-shaozhengchao@huawei.com>
References: <20240411033851.2884771-1-shaozhengchao@huawei.com>
Subject: Re: [PATCH v2] RDMA/hns: fix return value in hns_roce_map_mr_sg
Message-Id: <171326876705.752004.8039826272359636944.b4-ty@kernel.org>
Date: Tue, 16 Apr 2024 14:59:27 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Thu, 11 Apr 2024 11:38:51 +0800, Zhengchao Shao wrote:
> As described in the ib_map_mr_sg function comment, it returns the number
> of sg elements that were mapped to the memory region. However,
> hns_roce_map_mr_sg returns the number of pages required for mapping the
> DMA area. Fix it.
> 
> 

Applied, thanks!

[1/1] RDMA/hns: fix return value in hns_roce_map_mr_sg
      https://git.kernel.org/rdma/rdma/c/203b70fda63425

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



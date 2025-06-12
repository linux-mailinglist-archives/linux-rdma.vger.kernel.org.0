Return-Path: <linux-rdma+bounces-11242-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6FFAD6A12
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 10:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944553AE66C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Jun 2025 08:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1CD1A3172;
	Thu, 12 Jun 2025 08:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhGU+v7d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0D15573F
	for <linux-rdma@vger.kernel.org>; Thu, 12 Jun 2025 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716056; cv=none; b=YftEayDpxhr+VDRw3rHrsrfW9AnGLaCv7hO6kg+c2vZLqGcLk6zis9ocCbhy4ysB27GJLrWP04Cn9sf5/sdwHDX+Cfg0UeAnuN67RfBdjp5hHpXWBycyzpHcb9n5rFw2VE3QA181xt1sZbAefRqfoOECWeWugL+vA9ynQ7q6X7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716056; c=relaxed/simple;
	bh=P1snybCflsNdN9nG3w2eUzaTJCu9aSscnSyPse00Sec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Itc3xTf+WN3+R+TbOdVrG9P78IW/scWF4tdwXoe2Y2KByalE4IGeA5XMVeGxBKhNmzwRXo3LR+th27y671E03/GulA0FSOJS8ZFfFiWwMX6UwZv0m1iBUJ9ARdrHo9nfBAVTdls50ArteUYS3CwS7QCYc1anZ0jyTTN5Etsdda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhGU+v7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EA0C4CEEE;
	Thu, 12 Jun 2025 08:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749716055;
	bh=P1snybCflsNdN9nG3w2eUzaTJCu9aSscnSyPse00Sec=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WhGU+v7di04MLa19nUC7T+SgKXY4lcAgwBuDfZ6yCNZ4/ReBHAzndOyYvL6mVAY+T
	 lDeIh3+N0P/wL58qnlL+csdbLT2fmOaNNfNDvzC4yWpxirKvWyHY4jIAXBuHv0YuKU
	 UZBZS614Ek+j2i7vkCIymG1c3T32AjhQBnAV2O47DjBCdqdMVj2rzH50iErclxuBdc
	 tjGhpB9xVWGnzyRrPgNNmGTTY5wJCB10FRvQMg/Ad8lgitEe+48+Lfn9fKZPeHJ7np
	 dcgGslIm9EjNLnF94pvsXShueN4SzMPwuRBSAdF/pNHHgaKLG8fCMZiByByarcFVqv
	 8hjlMfhZT/S1w==
From: Leon Romanovsky <leon@kernel.org>
To: huangjunxian6@hisilicon.com, luoqing <l1138897701@163.com>
Cc: tangchengchang@huawei.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
 luoqing@kylinos.cn
In-Reply-To: <20250605034918.242682-1-l1138897701@163.com>
References: <20250605034918.242682-1-l1138897701@163.com>
Subject: Re: [PATCH v2] RDMA/hns: ZERO_OR_NULL_PTR macro overdetection
Message-Id: <174971605183.3643588.9028124185083393557.b4-ty@kernel.org>
Date: Thu, 12 Jun 2025 04:14:11 -0400
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Thu, 05 Jun 2025 11:49:18 +0800, luoqing wrote:
> sizeof(xx) these variable values' return values cannot be 0.
> For memory allocation requests of non-zero length,
> there is no need to check other return values;
> it is sufficient to only verify that it is not null.
> 
> 

Applied, thanks!

[1/1] RDMA/hns: ZERO_OR_NULL_PTR macro overdetection
      https://git.kernel.org/rdma/rdma/c/1f505a4a425079

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



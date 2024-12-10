Return-Path: <linux-rdma+bounces-6377-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F689EAB6E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 10:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C587286772
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7D6230D2C;
	Tue, 10 Dec 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QH46w5TG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76D22616F
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821727; cv=none; b=DDmvhoFQtvZygx1RLzKIHL3aQNAklaMWOHDB46uG8WGqLjhZ9/txlqAN2UFt8tQ6JdfgK+fpcyUC22H4TwtVKU9OuEicM4BpFf7Ky7TJpHAqSqI0MlRLnbjGgBNDN+vVPOSf7qnGJ4PzPrvKHw6oZF/f7SeC7ogZ2RjW5W7MJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821727; c=relaxed/simple;
	bh=yQd/j9QVRhXSylqkhInktyqDcBh5CyqGVm3mr3//eB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dat0weBl9LcfyPT8s7K/6EGkPLvJKs6F8ilXUsD1GdkyLhAr5gJdw9kE4KYXMJ7o93zKSKj5AX7JxahyekT8ZtbVn6m1r11Roy6dr6t1Ddt9xCnXJ36KRCTTL4kztG8Q6xUFdrXTX3DbN+mmvv8M98lGRBz2S7nlwbtyggRUMoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QH46w5TG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58D0C4CED6;
	Tue, 10 Dec 2024 09:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733821727;
	bh=yQd/j9QVRhXSylqkhInktyqDcBh5CyqGVm3mr3//eB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QH46w5TGOyPGvcYYpmjAEvKanYhMlAbDCieJ3h9iLgoKXveCVDy7LDTkADMMPn4y/
	 WHZQ8JWXyOLSdGkPlKhqktP7vugc0/f0RUIknPOMQn5gcj2cqth7uR6X3YsfI0yDi/
	 99BcDCWE+w7QTVtO6eDVaGNsKD/dbuZc+LReY0Arf3LxOQVQ1GP/LMbK5HOQ3bk45C
	 RNExSj/xxM2NKk3yI6XNeCID+cGesf7CR9KpeqcFxYXIsjFjg7sU/KWSjgK12g3GQp
	 f1RFR2wqzv70ght/MDjyHHaxZlRQRQ6hb1ca7Rk9g3sOs3qTHsqjQayjhG7kaSx1bq
	 CcRqbyTO4u7RA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>
In-Reply-To: <c39ec6f5d4664c439a72f2961728ebb5895a9f07.1733233299.git.leonro@nvidia.com>
References: <c39ec6f5d4664c439a72f2961728ebb5895a9f07.1733233299.git.leonro@nvidia.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/mlx4: Use ib_umem_find_best_pgsz()
 to calculate MTT size
Message-Id: <173382172440.4112092.3800225649578804212.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 04:08:44 -0500
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Tue, 03 Dec 2024 15:42:25 +0200, Leon Romanovsky wrote:
> Convert mlx4 to use ib_umem_find_best_pgsz() instead of open-coded
> variant to calculate MTT size.
> 
> 

Applied, thanks!

[1/2] RDMA/mlx4: Use ib_umem_find_best_pgsz() to calculate MTT size
      https://git.kernel.org/rdma/rdma/c/d31ba16c4331d1
[2/2] RDMA/mlx4: Use DMA iterator to write MTT
      https://git.kernel.org/rdma/rdma/c/f5afe060b1031a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



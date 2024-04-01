Return-Path: <linux-rdma+bounces-1702-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B217893AB8
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 13:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF1CB213C6
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E1721340;
	Mon,  1 Apr 2024 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1SNqevJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E3D26D;
	Mon,  1 Apr 2024 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711972187; cv=none; b=s2SA3QQjvQA7PAvZpIysuOu5X3uFvrghTTM7nMm84jOHRFIIn4jWITor+6b9q3b5RjuR4LpYCE/tiRYJzJMHVr2PVr9q/Ibp2BH7CPGMYn66YHywAimUdjqGmdVrKtamX4VE+hI+dtc1u+umpRIbh4lamLJRs87qiD1CCpfFGdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711972187; c=relaxed/simple;
	bh=IJNWYYDtEscr+AqSsuEYlRoJ5OSEelynNTrybl13oJg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PO1s9S9kkUlHjBChID58FpsPw9BFnIyWrZwbuyM7xeh5oOanIwVblI+JgM1tr/el/rwvrh0VLR2BpSyIZk6AvKgF8DC3+iGP7gZFsqZk783TW7wXc1FzG3+kFcapQavCfcZsfVkQIgH5KKDKiBo/79LF1z0uOJsre3X0nJ5tL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1SNqevJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3784C433C7;
	Mon,  1 Apr 2024 11:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711972187;
	bh=IJNWYYDtEscr+AqSsuEYlRoJ5OSEelynNTrybl13oJg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=o1SNqevJ1dfz7qifpVIpKIeKaNTgySK9DvwoM6UWpcd2CEAOXkCvefYw7+W4/3Ibq
	 Zb8A/I05BmzoGCcrYMdz1u4sRKlPczpU8AiNmU1J5BVPAs7AkCQpB+Xfw7Qt+v380m
	 tjsAfsgr/k5UdN5nAmia/NMXbTbAZQGJu+qmPZvui7HAKmjn8Jikw3amvmarBp9YVF
	 cbrIuoxK9rxfXS0zdbyD0ASn/gcIfwKquJGzwWNDNM+z2Gt1mP1jBH0+L0uxW7KYpD
	 bfxmdEbSPO5X3EJNWGa8fEcpVPkDyJ7TjIP0pIBy19UzEUqje+g31NBfgeOPqx0OoV
	 QB0GOXkAE7Xcw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Wenchao Hao <haowenchao2@huawei.com>
Cc: louhongxiang@huawei.com
In-Reply-To: <20240318092320.1215235-1-haowenchao2@huawei.com>
References: <20240318092320.1215235-1-haowenchao2@huawei.com>
Subject: Re: [PATCH v2] RDMA/restrack: Fix potential invalid address access
Message-Id: <171197218379.76491.12221042581191709272.b4-ty@kernel.org>
Date: Mon, 01 Apr 2024 14:49:43 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Mon, 18 Mar 2024 17:23:20 +0800, Wenchao Hao wrote:
> struct rdma_restrack_entry's kern_name was set to KBUILD_MODNAME
> in ib_create_cq(), while if the module exited but forgot del this
> rdma_restrack_entry, it would cause a invalid address access in
> rdma_restrack_clean() when print the owner of this rdma_restrack_entry.
> 
> These code is used to help find one forgotten PD release in one of the
> ULPs. But it is not needed anymore, so delete them.
> 
> [...]

Applied, thanks!

[1/1] RDMA/restrack: Fix potential invalid address access
      https://git.kernel.org/rdma/rdma/c/ca537a34775c10

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>



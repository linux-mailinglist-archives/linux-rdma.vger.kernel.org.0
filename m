Return-Path: <linux-rdma+bounces-1743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB74B895B03
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 19:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA191C22794
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3AC15AAC7;
	Tue,  2 Apr 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgzbQL2Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE2D15AAC5
	for <linux-rdma@vger.kernel.org>; Tue,  2 Apr 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079940; cv=none; b=n/QXWhQqfONWAhgEZlilvLpphAxjAkSjwXEXFa49zMwgY4NAsL8kIyZaO9ia3f1kUcEhLC8x54TJgjv2qOSzEO567vu3eSMyrwMjBL9uMB7px+k6cT0QGR2HuU3kI74cFFJMrYIlrAqVS2VvZ/CkWX0XCFtCr7j2ztXSdbVRpFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079940; c=relaxed/simple;
	bh=h10PT0xKyhvbrUXhynStvJpcItwBwQpcPazSd6ZC5To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMfWt7tAzK4TWomcM9gH1gxXq5ZlH5nLOmljcfSGiwRBLAT+jM+QnWdS2B++erZdDmBlD4zugdC9yPaH84FlPOfUPGextIEctpjtrExlsIMr2a9f5KwYwFeoDtLI0tFAnw1OgM5S9vd+Zq28qINxw2/BQA97d0AJdzyUTxmoxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgzbQL2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01B3C433C7;
	Tue,  2 Apr 2024 17:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712079940;
	bh=h10PT0xKyhvbrUXhynStvJpcItwBwQpcPazSd6ZC5To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgzbQL2ZiU3tfTp3QiRjglhaR2gTh8M9qC5IoWwKtivylsMnqp82+KPH0EE9kZbYg
	 q5EJZZRLrf19MKZCIKC6fPwEAwRVXWB3o5jKteffBjfngVGq23NPbNPJ16hiGtYbRm
	 2SclKJTiujdeiqxnL7sA0wxPHIuTw5Ri6QnzvUXTCj5sUwaxSpI36MwUqjS+DAd+DZ
	 x2eEHglehYbsxIq/OhhJ70Vi1uwkQLFE3NSAg/kxtXqH6t+z45OfAqP/bNUXrgMVyq
	 bxOAij5j7zyCGTIujJJW7A7y9Kp/PSNYa2w94opgO2n4SLzYmFNeRvyFnrKpjMdQLK
	 KrjPpwDBsY/Iw==
Date: Tue, 2 Apr 2024 20:45:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Make pr_fmt work
Message-ID: <20240402174536.GL11187@unreal>
References: <20240323083139.5484-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323083139.5484-1-yanjun.zhu@linux.dev>

On Sat, Mar 23, 2024 at 09:31:39AM +0100, Yanjun.Zhu wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> If the definition of pr_fmt is before the header file. The pr_fmt
> will be overwritten by the header file. So move the definition of
> pr_fmt to the below of the header file.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Let's just convert RXE to ibdev*() prints instead.

Thanks


Return-Path: <linux-rdma+bounces-4711-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF0096954D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 09:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C193F28416D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 07:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915E11D6C72;
	Tue,  3 Sep 2024 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OC7KCze5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C21D61A6
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348396; cv=none; b=OCeV6E3O8Mh33qypUIa+E6RjFUqXIuxY9+Uhppen2ebePwSJaMn/uLI/i9Bu5WP9JZkeYc0knYTOavbRQEl92CRcTrv/X7+wUfwNoSb5YahPAP/0NefJsQgB5xoWEdTQ9c0uB+mkIBbc0IdKU4bYk8OlSy7A+ui9UGBojwbUyak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348396; c=relaxed/simple;
	bh=0B0acEppqTKbxxDS/SbciDsdxL0x2WVsTrxlF3DGbeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWCqJtqcM3ZykLP0eAXFm1UarDr5pP6Aw1t4i0Y+W2PbmYKa9uZm1Ro1Matc5lEPdCB8puIXsHF4xxyseYBEyqe/4Gs+f6KOvJ5vwTSLCLaOsPu/bxQXoC8D9RTLmXbIL0c8Mmf0crLbZdEdfLdmDWP/DmmVv8PooCKXJwL59k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC7KCze5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A39FC4CEC5;
	Tue,  3 Sep 2024 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725348395;
	bh=0B0acEppqTKbxxDS/SbciDsdxL0x2WVsTrxlF3DGbeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OC7KCze5AxgvHtg5KbYHeh+C0t7v/XxICeTbZP5ed8BEVKtip882+VNtPsj74Hfau
	 JvaaU2p6mB8HGZafWMU5EjoGqqOe3iT4+zhWjBKQy3Fh6iDqSLKQZspbiilWE7ZxLm
	 fWAyibec6ngLdDMiwhH7qL1z0dxx6VEEJUJIAD677hVS1gcsLGsXvafUUfl32dasAf
	 dn2zF4hC+FcpVf70EHrmoEbbxeAwbNwFxp/Yd6URSb9r1TX7RGj2WcpfAcWWdIOkaY
	 uRIEq6fa4Zc/cJ5rZ3WGyHSlrr0/7aHqbY25TDThLJ1Bd0tDXThV2PjgAFQcH/PU8O
	 NWZnN1lzuJqAw==
Date: Tue, 3 Sep 2024 10:26:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	syzbot+b8b7a6774bf40cf8296b@syzkaller.appspotmail.com
Subject: Re: [PATCH rdma-next] RDMA/core: Skip initialized but not leaked GID
 entries
Message-ID: <20240903072631.GJ4026@unreal>
References: <7cce156160c4da8062e3cc8c5e9d5b7880feaafd.1725284500.git.leonro@nvidia.com>
 <4e8eab89-da4a-446e-bc17-e405494a5093@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e8eab89-da4a-446e-bc17-e405494a5093@linux.dev>

On Tue, Sep 03, 2024 at 06:46:24AM +0800, Zhu Yanjun wrote:
> 在 2024/9/2 21:42, Leon Romanovsky 写道:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Failure in driver initialization can lead to a situation where the GID
> > entries are set but not used yet. In this case, the kref will be equal to 1,
> > which will trigger a false positive leak detection.
> 
> I have also delved into this problem. And I agree with you. This is a false
> positive leak detection.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks for the review.


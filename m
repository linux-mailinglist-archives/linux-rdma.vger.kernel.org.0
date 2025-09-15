Return-Path: <linux-rdma+bounces-13357-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9EB5726A
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 10:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873E63BED93
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 08:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4862EFD95;
	Mon, 15 Sep 2025 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uorC5lsH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061212EE617;
	Mon, 15 Sep 2025 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923360; cv=none; b=Z7MEY9+MOUDu/LAc6zoXsUMcEZzNXGaZ7Rz4iw79h6Z8YfBcWfHiKGjVsj21Dqv05T11XTa4xXzxsB4XREeRikWz5W5Sm/znL+QEWE/arsgkfZTZLqiV/gLaGgab0h+i18sV+PgW9pC3b+QXUU1yWA+PJWh+OUVFigG/zoWnyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923360; c=relaxed/simple;
	bh=yEm2bzoiP+h/01QXVowc2unEj0br7/I+82JQsjglZt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFYF1X2NgALhEtsxNFqNxx/Ff1w3ULRLdqvhPVTzNM4V6OQyDMD3OCrFJaa82EURH3bx4oCa4AIBleoof17cuaaCqWLhOBR6MP7HOOmTO2+gpqcjEKQlYKRVGZPkHF8NfzoPFVwseHEA+aJFSI7rGVYNndfspOEFdAva06VBegY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uorC5lsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C793C4AF09;
	Mon, 15 Sep 2025 08:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757923358;
	bh=yEm2bzoiP+h/01QXVowc2unEj0br7/I+82JQsjglZt4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uorC5lsHLES+BCYb8oEHYS7RGXDtLY0MYCZlFj/JgkPCIg7eVxjft9QeVc/O4+JiD
	 VWYAyx/HXk8vuDOvoaIgZawtwa7duDJUL5RhO+mPaWfVAsoDevA1cGNVR4oNVVaZaj
	 zP7GONv5P2+Dh5H5tX8dqDa7NKGy2bVK9xZdHmyGX74mM/HxaEDBkUF4rMo+8fdvIi
	 0j7rMpquFaNuK0jESLtzfC8vpVbd1j8L4pSt9q/vo1RNoqqVHG53783DBRKtDO21cx
	 pMIX6YzQ0hTN2NMj4FI2o1D8ZWJ4dcq5cULVdz8VN2jb+34BuQKN9RANHzY56C9zpQ
	 sYnvOFrD8+IyA==
Date: Mon, 15 Sep 2025 11:02:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: Kriish Sharma <kriish.sharma2006@gmail.com>, alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] net/smc: replace strncpy with strscpy for ib_name
Message-ID: <20250915080232.GA9353@unreal>
References: <20250908180913.356632-1-kriish.sharma2006@gmail.com>
 <20250910100100.GM341237@unreal>
 <24ced585-1b7f-4577-9cb5-8d6e60ecb363@linux.ibm.com>
 <20250912090713.GV341237@unreal>
 <947756ad-f9aa-479f-b463-4c97ff23a936@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <947756ad-f9aa-479f-b463-4c97ff23a936@linux.ibm.com>

On Mon, Sep 15, 2025 at 12:24:16PM +0530, Mahanta Jambigi wrote:
> On 12/09/25 2:37 pm, Leon Romanovsky wrote:
> > On Fri, Sep 12, 2025 at 01:18:52PM +0530, Mahanta Jambigi wrote:
> >> On 10/09/25 3:31 pm, Leon Romanovsky wrote:
> >>>> --- a/net/smc/smc_pnet.c
> >>>> +++ b/net/smc/smc_pnet.c
> >>>> @@ -450,7 +450,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_name,
> >>>>  		return -ENOMEM;
> >>>>  	new_pe->type = SMC_PNET_IB;
> >>>>  	memcpy(new_pe->pnet_name, pnet_name, SMC_MAX_PNETID_LEN);
> >>>> -	strncpy(new_pe->ib_name, ib_name, IB_DEVICE_NAME_MAX);
> >>>> +	strscpy(new_pe->ib_name, ib_name);
> >>>
> >>> It is worth to mention that caching ib_name is wrong as IB/core provides
> >>> IB device rename functionality.
> >>
> >> In our case we hit this code path where we pass *PCI_ID*
> >> as the *ib_name* using *smc_pnet* tool(smc_pnet -a <pnet_name> -D
> >> <PCI_ID>). I believe PCI_ID will not change, so caching it here is fine.
> > 
> > If I remember, you are reporting that cached ib_name through netlink much later.
> > 
> > The caching itself is not an issue, but incorrect reported name can be seen as
> > a wrong thing to do.
> 
> In what case we can see this incorrect reported name, could you please
> elaborate.

Did you open net/smc/smc_pnet.c?

Everything that uses ib_name in that file is incorrect.

From glance look:
1. smc_pnet_find_ib() returns completely random results if device is
renamed in parallel.
2. SMC_PNETID_GET returns wrong names. It returns cached name which
doesn't exist anymore.

IB devices have stable indexes in similar way to netdevice. The code
should rely on it and not on the name.

Thanks


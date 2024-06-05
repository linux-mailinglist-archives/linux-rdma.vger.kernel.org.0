Return-Path: <linux-rdma+bounces-2885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453A28FCA43
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6111E282019
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80233192B82;
	Wed,  5 Jun 2024 11:19:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B919149D;
	Wed,  5 Jun 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586380; cv=none; b=Ju2F2xn+EeGhaBDgduH+vgKUtZjl12Ms5551YDjQ/JMhB/hKux5QO7t07Q1LEic0UMkACS+d7pENM7dpRB4jWtwwgyngkkReNNHuaQix+ehELoD5rz0PJW7hXNCmDvQBEM+6GabNISV9ZEpE9fjfoO+3o/iZNRYeTpJ0Zr4zhr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586380; c=relaxed/simple;
	bh=/c9bGc9vR1qfc4FdwpglO0c+WhOKMAYNFwE89PFlW1A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwFSLyTVKLQLwXkUMNPOqD36bn/mS/TQ4lcXgwFYVOIlwY4Tw3J8CpXQvbShFpRELuJsAV5+ZDVRHX/Q/0CAK78iXpFxv3UuQLquaXlEmKJqNK0NykikmyovJL3mlpjp7lUuSH9Rc3Vf7Nk3pa06TB33CRW95muwGpgJL3uvcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvPyD5yB2z6JBCV;
	Wed,  5 Jun 2024 19:15:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F44D140A87;
	Wed,  5 Jun 2024 19:19:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 12:19:34 +0100
Date: Wed, 5 Jun 2024 12:19:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, "Itay Avraham"
	<itayavr@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
	<andrew.gospodarek@broadcom.com>, Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, "Jiri Pirko" <jiri@nvidia.com>, Leonid
 Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240605121933.000035b5@Huawei.com>
In-Reply-To: <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240603114250.5325279c@kernel.org>
	<214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
	<20240604070451.79cfb280@kernel.org>
	<665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


>   One of the release valves in the CXL space is openly specified
>   commands with opaque payloads, like "Read Vendor Debug Log". That is
>   clear what it does, likely a payload the kernel need never worry
>   about, and the "Command Effects" is empty. However, going forward there
>   is a new class of commands called "Set/Get Feature" that allow a wide
>   range of vendor toggles to be deployed which will need an upstream
>   response for the driver policy to vendor-specific "Features".

Irrelevant rat hole time ;)

I don't see those Set / Get feature as any different from other commands.
I see them as a convenience mostly there to cut down on spec duplication
and enforce some consistency across multiple similar commands, but they
are just commands like any other, validation is just one step further
into the payload.

There are already a bunch of them in the main CXL spec and like you mention
above if someone brings a well documented vendor feature (or feature from
another standard etc), then if appropriate we could let that through the
filter as well.

Same will be true of tunneled commands (I think we can ignore the cross
host security aspect of those). Ultimately we can sanity check the payload
much like a top level command.

So I mostly agree with rest of what you've said, but think this detail
doesn't matter.

> 
> So if fwctl, or something like it, can strike a balance of enforcing
> integrity and introspection while encouraging collaboration on the
> aspects that are worth upstream collaboration, I think that is a
> conversation worth having.
> 
> [1]: http://lore.kernel.org/r/CAPcyv4gDShAYih5iWabKg_eTHhuHm54vEAei8ZkcmHnPp3B0cw@mail.gmail.com/
> [2]: http://lore.kernel.org/r/20240321174423.00007e0d@Huawei.com
> 



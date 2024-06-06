Return-Path: <linux-rdma+bounces-2949-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A58FF054
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 17:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C09B29FA0
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A511196DAF;
	Thu,  6 Jun 2024 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcjBPwSS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD64947A;
	Thu,  6 Jun 2024 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685901; cv=none; b=GJoMnHx0NWyWQQHyWBneN6vYkG7vjeIQRaBj0VaA4IqIPbtRUZ5cTgEKstUSF2SGwd0BSsUHtosQyK4qlH+QcAYEp61b6OfIsIg4QpYnEc2VB7vYjkhpZHx+VCvLxu0KAL9GfHbOLRdJ3F5w7L+bfOzexn94cdDkSEvHIL6sbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685901; c=relaxed/simple;
	bh=wUyTk2XCcfIgQiOCG5VskfpJs0gkjKHOkmBTY7ZiuMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owiXrBMlZcOihGavmt7+dVTaEq664oqQP3fGN1G2cs9IW2mbawN/fUDP82dIhm7FWB+7Rq1oQm1L0UV8XRTBuBJ+ja6fj1A4Y8Z+RAvx1YLsr2VzRqju5F1eicvSajFegY//iKZQyKqfhpm4ZlEhVW7iBuMI7i39uUCqDpbxZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcjBPwSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B827C2BD10;
	Thu,  6 Jun 2024 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717685901;
	bh=wUyTk2XCcfIgQiOCG5VskfpJs0gkjKHOkmBTY7ZiuMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JcjBPwSSdzr5td/KOY0/p5smNdNTakmoFkhLTiUlsOOB8Svz5s/YfdbPZr7ldWEAt
	 PuUAFKPLPS+/fTmE6D+54msse/YFG9fqt2djgzU/g41yP9urWJvp1IDrSAUqaEcHga
	 FnPEk70yeJfL+fpuKVpQwosEWJwgGcofn/OxNUA7kRmMYhIOPWEVcVdomGwXbNNQCT
	 TnZRYo9f8neqIAYasLEIMqiJ7C6JqEXi6XIO0PbEGV333ejtexEtUHm4sttnYhReJ+
	 4UEz0VecWvvs8ZHf4qoZzZLTLAUW4zgEav08ieyN2IVfqJ/l2PN5lwCvZyn7s8nn3l
	 ArVauj3uuxHaw==
Date: Thu, 6 Jun 2024 07:58:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, David Ahern
 <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Itay Avraham
 <itayavr@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Aron Silverton
 <aron.silverton@oracle.com>, Christoph Hellwig <hch@infradead.org>, Jiri
 Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, linux-cxl@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240606075819.00795275@kernel.org>
In-Reply-To: <20240606144102.GB19897@nvidia.com>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
	<20240603114250.5325279c@kernel.org>
	<214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
	<20240604070451.79cfb280@kernel.org>
	<665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
	<20240605135911.GT19897@nvidia.com>
	<6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240606144102.GB19897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Jun 2024 11:41:02 -0300 Jason Gunthorpe wrote:
> In my view it is wrong to think the kernel is the only place we can
> make generic things or that allowing userspace to see the raw device
> interface immediately means fragmentation and chaos. The industry is
> more robust than that. Giving people working in userspace room to
> invent their own solutions is actually helpful to driving some
> commonality. There are already soft targets in the K8S that people
> need to fit into, if the first few steps are with abc/def tools and
> that brings us to an eventual true commonality, then great.

Yes, this is the core of our disagreement. And one which is quite hard
to resolve with technical arguments.

I believe kernel may not be a great place to keep all the controls,
but it is in my opinion the most healthy open source project among 
the available options. You mention K8S, but I'd give SoNiC (the NOS) 
as a more relevant example. A hyperscaler or another trillion dollar
company can certainly have a swing at creating other open layers of
commonality. Together with its other trillion dollar friends.

Removing the minor inconvenience of having to ship an out of tree
module for out of tree tools is not worth the loss.


Return-Path: <linux-rdma+bounces-2808-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F18FA8A0
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 05:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3324CB22345
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 03:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92D113D50F;
	Tue,  4 Jun 2024 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6qGZICI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8064822066;
	Tue,  4 Jun 2024 03:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717470121; cv=none; b=EFY8ldlV9KEOkOJwb/10YEQLHTfr6AoyQ/QW73+2IkpQFz9pico48XYzgTth+xlPclZ98Xq1ZFV18lkS8WPA+4qzfQjTHpOY4RhAd5GwjQdLynJY9WEuFVUfC/X0iFTQ7OTh42qiLg5gz25TAbBfyKrmrOp2rWY1h8xJcs90d2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717470121; c=relaxed/simple;
	bh=tFypGxxnMGIv+NNLghPSJ5V0kL2OPk5U2xXcu3mTl6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Od32PYWRbr2av0CgYUtTYVRS4yiyAvDQgtcH7vDmIqtS/qYZffTtV0GAwYBP+Dz9uwGTP/JBco7qkHcwdT0nF0KylCFn87zJzwEiT36o9yCw9uMySZkB3wNUIysLaQMWRyiqXl7ot29dooOXzaQxVEFypMPh8QvvhvhyDFRF68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6qGZICI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06276C2BD10;
	Tue,  4 Jun 2024 03:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717470121;
	bh=tFypGxxnMGIv+NNLghPSJ5V0kL2OPk5U2xXcu3mTl6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m6qGZICIthnVF5i6OZIu+ZvfLpKqP5B+j0pCtihanuvYf1e1dw0jyeg3XsOj0GW1P
	 CvF7Dwj1MQNS8N+RkuUqmWe9wUevnENotrma3cte1DmaO2+IAuiYWbpwqNH0NiARRr
	 qiYsQC/DHJCIlsY/8Yc7QeaMJF4hCJ6C9Dt+NwevpRSzs7d1tk7jPb0m5LL1T0+ekT
	 Nf7Xjkq6qjZtImoLhVuhcp+gbGE9cpw6KdgwhgBW3QCY757u5NwSyP1iPX916O23cV
	 JgIqogKv3PfxDF2sObjWNqIv3of2uz60MA5OcUnxIt8WN8JfBot2j4lX+5l8e6L/W0
	 DAjzDZW610qRw==
Message-ID: <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
Date: Mon, 3 Jun 2024 21:01:58 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Aron Silverton <aron.silverton@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 linux-cxl@vger.kernel.org, patches@lists.linux.dev
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240603114250.5325279c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/24 12:42 PM, Jakub Kicinski wrote:
> Somewhat related, I saw nVidia sells various interesting features in its
> DOCA stack. Is that Open Source?

Seriously, Jakub, how is that in any way related to this patch set?

You are basically suggesting that if any vendor ever has an out of tree
option for its hardware every patch it sends should be considered a ruse
to enable or simplify proprietary options.


Return-Path: <linux-rdma+bounces-2932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3F8FE19A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9CA28311C
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 08:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F1B13F435;
	Thu,  6 Jun 2024 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLcvwAcY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0019D8B5;
	Thu,  6 Jun 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663839; cv=none; b=DTxJ7vVF+m9Dm8dSSmbJdwE6sZa8Qm81H7DEPkRK3AfeWR4whUrHVS2PKAlZlDiQD2prPev5586iIKs6beea8xMeLWPIHH6lHGta2NGkpwm0NG3DcxjB1I3b0sR5EonGhpnHQN/q1W/zqmtGSqZXnmhw0s3v3biKm1F6jqgHRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663839; c=relaxed/simple;
	bh=lOpeMaqXRioNWzloS7xPP8YoU3oVFhf2Rg3MbuLI+7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlaDYF1EkQEeLcVEpYEngNZHDEQlTf9j6gBsKiWvlyNM29s5ybUK/vsTDcMwFOMJUjrpu44URrPss4Vtsv1iF+/mWwt+lEnSWDjMv8D6EcgcPI0K81o5rZ4VKXg3Wo8YjkGh6hnKWbwfAJo1FL4jveNn0lMBcvsRWtCMySVx+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLcvwAcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758F3C3277B;
	Thu,  6 Jun 2024 08:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717663838;
	bh=lOpeMaqXRioNWzloS7xPP8YoU3oVFhf2Rg3MbuLI+7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLcvwAcYp7ZPfyI3CN9hmph4jyryPaaFuIQHwZRjQDj5wyAY7TkR8LdsbVY8Cpg+I
	 N2Xk0hkzYofB8yup3Rmc3QwFyd00tXB29k6qDSJ3yjyr84cgOtaC+7+zWnhCnP2gwN
	 5qdsptb3j50eYmT6IKLEHb+K/6szrdXBEM3nKUaZKeXYwGF5LqJCWOCey9YaSXKfEF
	 uOjETHvXe8ET7tAhaZbfcMDsN9LR3HSRktmA/NjPL0+rghQs04U/5XMhKEexSE88/W
	 GjfUoCy24KVVVBfHMIIAZPQyeBXYHC/jq5h8+X6lqtdgtZ7kog7dXKebcVY+6g9f9s
	 KJoeCdQ+pYqgQ==
Date: Thu, 6 Jun 2024 11:50:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <20240606085033.GC13732@unreal>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6661416ed4334_2d412294a1@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Wed, Jun 05, 2024 at 09:56:14PM -0700, Dan Williams wrote:
> Jason Gunthorpe wrote:

<...>

> So my questions to try to understand the specific sticking points more
> are:
> 
> 1/ Can you think of a Command Effect that the device could enumerate to
> address the specific shenanigan's that netdev is worried about? In other
> words if every command a device enables has the stated effect of
> "Configuration Change after Reset" does that cut out a significant
> portion of the concern? 

It will prevent SR-IOV devices (or more accurate their VFs)
to be configured through the fwctl, as they are destroyed in HW
during reboot.

Thanks


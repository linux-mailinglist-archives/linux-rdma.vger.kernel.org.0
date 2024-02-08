Return-Path: <linux-rdma+bounces-973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F32A84DC15
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 09:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A65F1F21093
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 08:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3606BFCD;
	Thu,  8 Feb 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msFDYrFl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD06BB5B
	for <linux-rdma@vger.kernel.org>; Thu,  8 Feb 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382354; cv=none; b=m28gxHV5QghJNba++1D6b1W79ZrVrMsFZuEh/14vRWNC5wQkaO3Vb+fLKkjQ8h7qpBsiSizc0KCuUxekzBI9Su1VSvtvG5UPucIC6TcIqPqJ4I+ypYmaZeLNeIJD1W5G7PGYgkWJiqH81e0fQP3/efOJmYvk2v3jqRXym4kYHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382354; c=relaxed/simple;
	bh=BCCiE90YZeXBdNiRV3yexJQ5SEa/ukOQG8fQ8Zlz38k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkOuur/+FG8lINO3ptVzep+9Gmq7pOD+9Bbln98rp8loFJc7VJi9Kqt7JJ2dcpyegXF1GEsQUsoiZCCqpYGrclyNPSaOk0WwesIDTR56fPOyZ6vJOF8ltyaBixxN8vK3tzMoXINreqcx7A5TzlubXgY5DxOfTNE1MEGYwMa+tpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msFDYrFl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3603C43390;
	Thu,  8 Feb 2024 08:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707382354;
	bh=BCCiE90YZeXBdNiRV3yexJQ5SEa/ukOQG8fQ8Zlz38k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msFDYrFlhSzl7DUnr52eM3lJD/gyUOszG/V5YSOa2ZpulV9eCyVYgb8otZUeZ0hE9
	 HUWYt7fHfju+jWSrxi28GY0RI0931mVnRtgIArwyLnnLkWVoitDRJUmKEKG+YCULUX
	 MoJjvU2adwByWF6uiHjQZnHftIE91IY5ug0yIkmspkTYfHgyTEt/XqdlpgV4YnUfHC
	 o0i68BPM6XlGFNNoBg8O6XiKObm2mNDNr743rISHQ8ZY2grZuosWrVP8QKuXmmPUsZ
	 gyvPcJ5NLliS7sO4/iNjuLnUDuZl5tJKNWfC5YN3XnkEuDZ7hxGgfWskc1dSRgOFhh
	 973mvd2ZjIDzQ==
Date: Thu, 8 Feb 2024 10:52:29 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Rehm, Kevan" <kevan.rehm@hpe.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
Message-ID: <20240208085229.GF56027@unreal>
References: <E25C1D96-0FBF-44AB-A5B5-71CDA49E73D1@hpe.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E25C1D96-0FBF-44AB-A5B5-71CDA49E73D1@hpe.com>

On Wed, Feb 07, 2024 at 07:17:01PM +0000, Rehm, Kevan wrote:
> Greetings,
>  
> I don’t see a way to open a ticket at rdma-core; it was suggested that I send this email instead.
>  
> I have been chasing a problem in rdma-core-47.1.   Originally, I opened a ticket in libfabric, but it was pointed out that mlx5 is not part of libfabric.   Full description of the problem plus debug notes are documented at the github repository for libfabric, see issue 9792, please have a look there rather than repeating all of the background information in this email.
>  
> An application started by pytorch does a fork, then the child process attempts to use libfabric to open a new DAOS infiniband endpoint.    The original endpoint is owned and still in use by the parent process. 
>  
> When the parent process created the endpoint (fi_fabric, fi_domain, fi_endpoint calls), the mlx5 driver allocated memory pages for use in SRQ creation, and issued a madvise to say that the pages are DONTFORK.  These pages are associated with the domain’s ibv_device which is cached in the driver.   After the fork when the child process calls fi_domain for its new endpoint, it gets the ibv_device that was cached at the time it was created by the parent.   The child process immediately segfaults when trying to create a SRQ, because the pages associated with that ibv_device are not in the child’s memory.  There doesn’t appear to be any way for a child process to create a fresh endpoint because of the caching being done for ibv_devices.
>  
> Is this the proper way to “open a ticket” against rdma-core?

It is right place, but I won't call it "proper way".
For anyone who is interested in this issue, please follow the links below:
https://github.com/ofiwg/libfabric/issues/9792
https://daosio.atlassian.net/browse/DAOS-15117

Regarding the issue, I don't know if mlx5 actively used to run
libfabric, but the mentioned call to ibv_dontfork_range() existed from
prehistoric era.

Do you have any environment variables set related to rdma-core?

Thanks

>  
> Regards, Kevan
> 
> 
> 


Return-Path: <linux-rdma+bounces-9291-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41C0A82373
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 13:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1777A23C1
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Apr 2025 11:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4432825D537;
	Wed,  9 Apr 2025 11:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hsg5jC/L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFB241107;
	Wed,  9 Apr 2025 11:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744197781; cv=none; b=nU0w/ztVfP5lOP8oHeuVLtMoR1wJ4+C0Skk2Yk2mtXR65MBagwYiJbsgt9l1ontC00MBv9dSBzd32p8OzAPeaVGEYvVv0HfKl2qa7qDOCLGVymfZ9rR66rqn0jJcN/r+GLbfkBX89IhNIHO/1cafNy4a/4NHc2NcP01iuLGjz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744197781; c=relaxed/simple;
	bh=pi0WMsJLoykdjZe73nbr4+UgAHAmDF2AYES9ra/chZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N88JJmHYGeCa1MMPxrCS2R2TaF4bYp42/MDZq1Xh4WYZ/tXhsms6ucQLsNNhPgS6VMO7rgfGVKYVO1hjVj2WDRo0PWqhxtHI1GeWZr24JWnrUh/aZ69bYIin4NSgjwvG4WDdQ7F8NInXbsVh5eeMSJtksIow11R9iVSqPPXkz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hsg5jC/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A55C4CEE3;
	Wed,  9 Apr 2025 11:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744197780;
	bh=pi0WMsJLoykdjZe73nbr4+UgAHAmDF2AYES9ra/chZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hsg5jC/LSj52/WVMMsr6q8ux4IIeVTWcyIx7nIQIwMP2BaFz8gAykr9NPyHECulmw
	 v0/Apf5tf3Ow9WWfHE05fLu3haUz/l5y53514VLdV1/KtkxhRqaVD46e2LQ0HpB2VV
	 IOxjGfrrKM4Le3oqg+bWZxBozFlIkHQNo9w0xQl9q+tECHTKZdWJkxcH4yu9OBH4a/
	 56gx35k6fviezJC1uBqUhxHq9UsuHaK/vouecN2GGz7ELwXJXPU7QLlkwXmp+SuM62
	 uP5IMDBB4M/JWJQG9lyffxCyHbc+ms04iBauCxmR+zP0lXuyXYMEZfEpWsIcNk/8pC
	 Tf+EcoxdvSCqQ==
Date: Wed, 9 Apr 2025 14:22:51 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Sharath Maddibande Srinivasan <sharath.srinivasan@oracle.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"phaddad@nvidia.com" <phaddad@nvidia.com>,
	"markzhang@nvidia.com" <markzhang@nvidia.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>
Subject: Re: [PATCH v2] RDMA/cma: Fix workqueue crash in
 cma_netevent_work_handler
Message-ID: <20250409112251.GJ199604@unreal>
References: <bf0082f9-5b25-4593-92c6-d130aa8ba439@oracle.com>
 <D90F918E-A69B-434C-9593-D1E253F150F4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D90F918E-A69B-434C-9593-D1E253F150F4@oracle.com>

On Tue, Apr 08, 2025 at 01:17:39PM +0000, Haakon Bugge wrote:

<...>

> > Fixes: 925d046e7e52 ("RDMA/core: Add a netevent notifier to cma")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Håkon Bugge <haakon.bugge@oracle.com>
> > Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> > Signed-off-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
> 
> A gentle ping on this patch.

Sharath sent this patch during merge window. RDMA is closed during that period.

Thanks

> 
> 
> Thxs, Håkon
> 


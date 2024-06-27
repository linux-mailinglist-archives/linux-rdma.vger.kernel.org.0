Return-Path: <linux-rdma+bounces-3555-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6976891AF38
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2027F284F2F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2024 18:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3C219A29A;
	Thu, 27 Jun 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhN8BxQ4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5782033A
	for <linux-rdma@vger.kernel.org>; Thu, 27 Jun 2024 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719513806; cv=none; b=NAM/6FKhvFL5W1ur00D0Kipe+QCvfNcM2lZDJY3zKpUBEPdspMCbz6/UC9laWUGQvXh3D8gImHK7X1vd3DFCXK9snZh4mleWncr6AjSbG3Djp2cOg5gLZVxSXB+za+AwcW9poRdDZCiYwAW2/AKNK5b9M3AQ4sYd4bOh+Sz6T2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719513806; c=relaxed/simple;
	bh=Kv4j1wPfBSnjwOA4ZbMqTWANsSVrjrK2J6msii+Ts2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkJWVHx8DLVDItCjh0c5Siw6QHNPU/TeE+DisnepwDDMya7bbiUrK97dhBxwNwLZM8Ne4fGhf0MJbdOsnPG13BXYnbux2xpLu5H/LLMuK8Z9frG3HJ0qz9OzRpvavSBPJGYflECm0/2l3jv0RmrmDjwFMQD/pRv63a4qmamVt70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhN8BxQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687EBC2BBFC;
	Thu, 27 Jun 2024 18:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719513805;
	bh=Kv4j1wPfBSnjwOA4ZbMqTWANsSVrjrK2J6msii+Ts2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bhN8BxQ4bJtanbtF5WZU40Y2iXEDC/bkjdca4xCs2RVr1Sz6XE0Is1wWbTzAr03xj
	 3Qc7R3vxPqT9x9ATYnrh7jJHByYN9yBddY9SIm2n3cTwGmVpLrWflRL/0pG/FSyizl
	 65FRfbkR4v2+pb7UaYVuU7GPkaQJQvxDNp/7OW3fkXw/+pOimYcE9TG7+UxqeLp5Mh
	 Ecp4MHquo4+/yHpAkX/QZDbbBC4+Ol29z8p0pUS7LrxCPvVWi+iaGedlLuR/CTkC2h
	 wOAwCNL7UZ04Rz1kXVU9d9zRTQ0MopP1QllRTFX5BLfhs/7rpTSHejuJRGKSyT+wgO
	 UJKc7Jxsf3osg==
Date: Thu, 27 Jun 2024 21:43:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
	Firas Jahjah <firasj@amazon.com>,
	Yonatan Nachum <ynachum@amazon.com>
Subject: Re: [PATCH for-next 5/5] RDMA/efa: Align private func names to a
 single convention
Message-ID: <20240627184320.GT29266@unreal>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-6-mrgolin@amazon.com>
 <20240626153834.GA3233164@nvidia.com>
 <6310c5d0-e72d-4b4a-9b78-b19b622fdb92@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6310c5d0-e72d-4b4a-9b78-b19b622fdb92@amazon.com>

On Thu, Jun 27, 2024 at 07:57:17PM +0300, Margolin, Michael wrote:
> 
> On 6/26/2024 6:38 PM, Jason Gunthorpe wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Mon, Jun 24, 2024 at 04:09:18PM +0000, Michael Margolin wrote:
> > > Name functions that aren't exposed outside of a file with '_' prefix and
> > > make sure that all verbs ops' implementations are named according to the
> > > op name with an additional 'efa_' prefix.
> > That isn't the kernel convention, please don't use _ like this
> > 
> > Jason
> 
> AFAIK there is no single kernel convention for static functions naming and
> it also seems that the underscore prefix isn't rare in the subsystem.

Underscore at the beginning of the function name is a common practice
to mark that function as locked variant.

Thanks


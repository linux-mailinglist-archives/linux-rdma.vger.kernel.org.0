Return-Path: <linux-rdma+bounces-3477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A528916A0A
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 16:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EB2281716
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2E16D4C5;
	Tue, 25 Jun 2024 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxVJyGlb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8016A397
	for <linux-rdma@vger.kernel.org>; Tue, 25 Jun 2024 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324984; cv=none; b=ohhpSH+THTy39oGjzbh5r4KtX8UQqCvnnPXwmP94Rq98USJrpVLxS+8Dp2srJeqeBoLi2ruJCIc1liCwvTlMqjni74vSAXF1zR4JWbrcSEeN3TRFOxOi0mkVTw8vi8CsJBB1kZcYToxez0YskGGQ891mcR6htC0ERV4wl14ndRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324984; c=relaxed/simple;
	bh=o7h28tMfOVCtcYrx9u5U9j/4qzlvI5ACoebPTkDAxr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko4ODZRN9fX5b5HAdzz8HAaW6UqZKBhW6mk+JDq0+Our9rJuerM9JCVsADap5FIhqqIkWWL9SdVaZQet8HDpUJF3rWaeaBIQ5cBgfKdEtEGukPFWs7UTDA2YhmLoPrHXHhvG+hXBsxfCNFNB7PlV2q2C2lR6kUUo29JXLY+iQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxVJyGlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D50C4AF07;
	Tue, 25 Jun 2024 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719324983;
	bh=o7h28tMfOVCtcYrx9u5U9j/4qzlvI5ACoebPTkDAxr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxVJyGlb0CKyzb9A6+4FQj8rVcN8P/JZYy8zD7cNP2t9LYebBIs8AuSYzSKI9H4Xx
	 HwMFuTUh3L1dbGdr2iavyK5EXORM35Y3yGVHFxieUNCx8MbcSFjnjdzCRERHJaDCIE
	 79GJLPO5PCViLEpUs4L9BAor9J88CECQldDcb+APkzgtJAKa16/AICyA+9AYKvd9cj
	 F60khmTJLQrMa+BI28sqNz4pAVUjJzoCPelKTvEgcKwWPyTFaV+79Dtex771Qub2qc
	 cvSXNAjsWw91kf9gSpqKj92CbUkOG9zc7RN/qkEe8o4c56xzt/2mLQaLLs7lOrC9Mp
	 XmVkPSxeoyPVg==
Date: Tue, 25 Jun 2024 17:16:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Gal Pressman <gal.pressman@linux.dev>, jgg@nvidia.com,
	linux-rdma@vger.kernel.org, sleybo@amazon.com, matua@amazon.com,
	Yonatan Nachum <ynachum@amazon.com>,
	Firas Jahjah <firasj@amazon.com>
Subject: Re: [PATCH for-next 3/5] RDMA/efa: Validate EQ array out of bounds
 reach
Message-ID: <20240625141618.GK29266@unreal>
References: <20240624160918.27060-1-mrgolin@amazon.com>
 <20240624160918.27060-4-mrgolin@amazon.com>
 <bfd4cbb0-baee-4762-a0d3-8734df36e3d0@linux.dev>
 <eab3899b-25b8-4e4f-8c85-38188a30a6d8@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab3899b-25b8-4e4f-8c85-38188a30a6d8@amazon.com>

On Tue, Jun 25, 2024 at 02:28:24PM +0300, Margolin, Michael wrote:
> 
> On 6/25/2024 9:33 AM, Gal Pressman wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On 24/06/2024 19:09, Michael Margolin wrote:
> > > From: Yonatan Nachum <ynachum@amazon.com>
> > > 
> > > When creating a new CQ with interrupts enabled, the caller needs to
> > > specify an EQ index to which the interrupts will be sent on, we don't
> > > validate the requested index in the EQ array.
> > > Validate out of bound reach of the EQ array and return an error.
> > > 
> > > This is not a bug because IB core validates the requested EQ number when
> > > creating a CQ.
> > Then why is this patch needed?
> 
> Mainly as best practice of validating the index right before array access to
> avoid hard to catch bugs.

If you know about the bug, please fix it. There is no need to add code
"to protect" low level from incorrect upper level.

Thanks

> 
> Michael
> 
> 


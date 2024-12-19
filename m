Return-Path: <linux-rdma+bounces-6649-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EF59F7AA8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 12:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBD617067E
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386C223E83;
	Thu, 19 Dec 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKdgdSj4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3864223E74
	for <linux-rdma@vger.kernel.org>; Thu, 19 Dec 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608785; cv=none; b=JnOLDLM6sMKuYRj1gbGCsK3mB6L3/evWt3IZkWL84w8rTKf6v9Rkr2ODONMIzPCHaC+keEmRPzwn6qpXoal5CLRNx11Jd4eb3O22BMDzctzi5XJCnvcLuESI0gOsI6jr3Triz5TJ5h4ychMDP00L7ablTvMARfmD4XiTpRmuplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608785; c=relaxed/simple;
	bh=TZDF7ZgkF60cFLiI1p09+OfN9Yn/Ok6FQsDgodJClnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiP9Ss1elD/Gp8IUDKoItBlcvorbBOuo5QqCfhQ2CJbjCECNvS8YnXbcKuHhDhG4SI4eP1lBm5RecOhDPFtMhfPpZbzkr8cL0DZSITKvdgGOyQS0UxZP3eNz8NVF/lxv7ad/3EWVSNYHSnteZ0GhZdq2HWxeBHfKwpX0mY3YMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKdgdSj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD90C4CECE;
	Thu, 19 Dec 2024 11:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608785;
	bh=TZDF7ZgkF60cFLiI1p09+OfN9Yn/Ok6FQsDgodJClnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKdgdSj4Ojh/xi9CUVKjSmGpi/bQzDw3/oUyO/yVNpQlMF0qe5/mUJjLTeIsf1DU8
	 UA85NLGCtqsbK6aFOZRs/ahMFiKLJuDj8tZbgPA8wwyEVmF6xXcQ4WHS3GkuEVlKGh
	 lY7Y8w/8SxtJAFe2Rpxyv/ARuIUV4jzxsivyf/1UMa8FhpI7AaYe/+IMUaCCos7iJa
	 QCgvuDU/aiU+5I5TyoPXTJBZuCyTVW6cOLcawZICnAasGAIJO1RLJSytSZ2Fte9ueY
	 u1UhdDqDijO8kNTN203YCFwvFh3ngx98natZIH9S0yTzg1FLk1VIQ50g2E5+/ifKh5
	 XYJC8MKufNRLg==
Date: Thu, 19 Dec 2024 13:46:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: Re: [PATCH for-rc 4/5] RDMA/bnxt_re: Fix error recovery sequence
Message-ID: <20241219114621.GC82731@unreal>
References: <20241204075416.478431-5-kalesh-anakkur.purayil@broadcom.com>
 <20241205090716.GU1245331@unreal>
 <CAH-L+nN0C=0ZoJmAgBTbjCUcwoQO00WoUc3d3BKn_tGPdk5UbA@mail.gmail.com>
 <20241205113841.GY1245331@unreal>
 <CA+sbYW21nc0JPs-N0rmR-DgUvX0pydCY_bZXUC57aA0rXUst1A@mail.gmail.com>
 <20241210114841.GE1245331@unreal>
 <CA+sbYW0n5CPupxByysd7Dc9=QLQm33ivC1YH5T2UbvG6MBVymg@mail.gmail.com>
 <20241211155610.GL1888283@ziepe.ca>
 <CA+sbYW2kuQjbUKtKrWkcSTTM3NZL9miBjf=OCRP+LCxFEZsH4Q@mail.gmail.com>
 <CAH-L+nPCCyCiDQLMoBmvMrjRqMFvkBYeWCObqAFfVFOBi9-rjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH-L+nPCCyCiDQLMoBmvMrjRqMFvkBYeWCObqAFfVFOBi9-rjg@mail.gmail.com>

On Tue, Dec 17, 2024 at 10:53:08AM +0530, Kalesh Anakkur Purayil wrote:
> Hi Leon/Jason,
> 
> Are we good here? Or, do you still have any more concerns on this
> patch? Please let me know whether I need to push a V2.

Yes, if you make sure that your newly added check is not racy.

Thanks


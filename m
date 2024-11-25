Return-Path: <linux-rdma+bounces-6085-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F25679D7BE6
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 08:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB96B217CC
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2024 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C015F41F;
	Mon, 25 Nov 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MonNEusR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C4013CFA6
	for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519341; cv=none; b=pnNUEC8a+2OmapGhAedkuAE4fL8aAgSvq9xY+0POmkGxUpCBstwCQWrpcv3It6BOomMdahthUVU5L0Cz8e6/8PkbdJGPCvUcUGmroWR8Nb/g2hgvWRmizbF77n5Q5UD/ypc5zKcVHnWy0J5I3i/SXFj9w/mUNtXbNXQiQaEwtvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519341; c=relaxed/simple;
	bh=KE2up/TMmdSuLWwBX18pErgPGsRceiRCiCy1he2yFKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL0od2qszz6jftXDGCdR43k2KiSxOkPsO7NoAgZG3DeSSHOD7gfYFaI8TWxfwzHf+YtClAB35jjISpw/zhhq9myfXDYORNZOjurbbHJ5bSDgX9Pipcl9TNDu2eqpzETv/eZbw6b1xrNJ77aqRK04KqwSQQfw1abCt32PNEm+/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MonNEusR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEB3C4CECE;
	Mon, 25 Nov 2024 07:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732519340;
	bh=KE2up/TMmdSuLWwBX18pErgPGsRceiRCiCy1he2yFKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MonNEusRDOWpGsf3XnbwmPM5vEithwDBt7Gu6nZFtzw4nnj/4D84C4fgvzvFM63HW
	 aOzQjaraLBjuSytl4e8r71e7mExQvPh1kpBGXnHCaiKovitsKt3IkgN+easY+/DBd8
	 h8HbxyYgkhRrvB2y8uB6lL188hueyezK/i9eVNnRHNbBsIGK96JAtAF6Bq9SKaoxHI
	 blo5tuYOxwWAOOzl/A4w9qIkTbFoGPnmGVdgK5eeYTOdyzFSR7ZFoGk84hm51UYCiu
	 lJGM3nwsTDKbzCiTqL+ZTyvEZ9BA9DcCPxiAYBJ3xftytvVRgtlPO13LXANuCZBC6y
	 c496utPQku6oA==
Date: Mon, 25 Nov 2024 09:22:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Mohammad Heib <mheib@redhat.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma] RDMA/bnxt_re: cmds completions handler avoid
 accessing invalid memeory
Message-ID: <20241125072215.GF160612@unreal>
References: <20241112134956.1415343-1-mheib@redhat.com>
 <20241114100413.GA499069@unreal>
 <CA+sbYW1cp17tH-p8ffjtgBecyMP_fECmes9RN9Bj=bdNPD_W2g@mail.gmail.com>
 <20241114114521.GF499069@unreal>
 <CA+sbYW13g5f-CW=QEt-SKtpssw1=Qbqp6d=055a=v5N-r2C9sA@mail.gmail.com>
 <Z0CGDwp32NDOsweB@fedora>
 <CAHsXFKEVkwjOsjdnmzsv5jZNJD83jKBbSXsJgenP+7a=f0kcsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHsXFKEVkwjOsjdnmzsv5jZNJD83jKBbSXsJgenP+7a=f0kcsQ@mail.gmail.com>

On Fri, Nov 22, 2024 at 07:15:10PM +0530, Kashyap Desai wrote:
> Hi All,
> 
> We will work with Redhat for final go.
> 
> For now this patch is on hold and not urgent.
> 
> Leon,
> 
> Hold this discussion for now.

I marked this patch as "deferred" in patchworks for now.
https://patchwork.kernel.org/project/linux-rdma/patch/20241112134956.1415343-1-mheib@redhat.com/
Please resubmit once you get Acks from Selvin.

Thanks


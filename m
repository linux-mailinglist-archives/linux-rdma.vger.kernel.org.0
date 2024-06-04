Return-Path: <linux-rdma+bounces-2863-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564678FBE09
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 23:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1497C284256
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 21:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3B314B97C;
	Tue,  4 Jun 2024 21:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr2NIPV/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A48174E;
	Tue,  4 Jun 2024 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717536487; cv=none; b=h0ixMyUb+MMFfLJomZuJw1byyD+KE7ukSKm9617cPvmycUDSgqX0ZAb59toZ3VenCOA8FBwME2gliX5fKcmGd/cXU492q1SX3kt3qeQQkTft1QmSaWoW1aQjHNM/YAGUqLW4Uj9SYIYL2KkrVzQ7RNaIh3dJlU6z4Wzu+/byYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717536487; c=relaxed/simple;
	bh=T52kcXJ7mL4Q4PqNXSfJ7Kdnz9pHXcZRoLVIr7LNdKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dorcuH0pJQ5c9PjxKJiA7PAcvS3uuZ71rHudJcblXz7HDuWa4SYMUl3dDkSJLBODmg8cqizgOz5NN7JQa8vgEqBsA+cW3hQkICw+PHvcoJN3oP1N64kq8ceruXgJFZxRkeKDABtXu87/4Vys1UxlWGVWnd2uF+WWuAYjeP1TiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr2NIPV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BCA3C2BBFC;
	Tue,  4 Jun 2024 21:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717536486;
	bh=T52kcXJ7mL4Q4PqNXSfJ7Kdnz9pHXcZRoLVIr7LNdKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cr2NIPV/oQGKb92AMrQQcg2dZTKnQS0n5ymAAgJVUt2i4U6ikH2V+13JFun/U8G5+
	 ov6jr2E2HN69k+07HS9uU33fse0K+fLl9v+ANdVOF0emNH63EVsVf430yOTuaeI7MP
	 Px/rgXmwEluM2uo4RvIau0IkYhXlFKD1aOQLJyfMDiJ+/7bo2SKLvNp2/buqr6RGsG
	 hDeR6LbqH08PSVjNUNor6Kcq6tCdVDLsDl/UW5HZpGEa5/RxjiOwxVgQE5aVaOWzEZ
	 PdI3TdxcXNJl5KB4vTVJ2dQNBCfchIu2BoNaqr3HxIKP9CHihbg7TDDk5gy0hyMKUC
	 1wCpZHxtXfArw==
Date: Tue, 4 Jun 2024 14:28:05 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <Zl-G5SRFztx_77a2@x130>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240604070451.79cfb280@kernel.org>

On 04 Jun 07:04, Jakub Kicinski wrote:
>On Mon, 3 Jun 2024 21:01:58 -0600 David Ahern wrote:
>> On 6/3/24 12:42 PM, Jakub Kicinski wrote:
>> > Somewhat related, I saw nVidia sells various interesting features in its
>> > DOCA stack. Is that Open Source?
>>
>> Seriously, Jakub, how is that in any way related to this patch set?
>
>Whether they admit it or not, DOCA is a major reason nVidia wants
>this to be standalone rather than part of RDMA.
>

No, DOCA isn't on the agenda for this new interface. But what is the point
in arguing? Apparently the vendor is not credible enough in your opinion.
Which is an absolute outrageous grounds for a NAK.

Anyway I don't see your point in bringing up DOCA here, but obviously once 
this interface is accepted, all developers are welcome to use it,
including DOCA developers of course..

That being said, the why we need this is crystal clear in the 
cover-letter and previous submission discussions, bringing random SDKs
into this discussion is not objective and counter productive to the
technical discussion.

>> You are basically suggesting that if any vendor ever has an out of tree
>> option for its hardware every patch it sends should be considered a ruse
>> to enable or simplify proprietary options.
>

It's apparent that you're attributing sinister agendas to patchsets when
you fail to offer valid technical opinions regarding the NAK nature. Let's
address this outside of this patchset, as this isn't the first occurrence.
Consistency in evaluating patches is crucial; some, like the fbnic and
idpf, seem to go unquestioned, while others face scrutiny.

>Ooo, is that a sore spot?
>
>I don't begrudge anyone building proprietary options, but leave
>upstream out of it.
>


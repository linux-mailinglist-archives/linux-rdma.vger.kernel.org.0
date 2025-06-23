Return-Path: <linux-rdma+bounces-11549-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F925AE48CB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 17:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07B94446FB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21355275865;
	Mon, 23 Jun 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="eZL+NQZG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038F1F94A;
	Mon, 23 Jun 2025 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692713; cv=none; b=m2T+NN2H5z66fnFEnZ401ZVWmz3kSZeIyiEpiZyjAa1JY5AJ6RzfdpCTIW4ILeVwnrsK9W+E9wTVupNxLwtdiA1dPzVJM0H0vRVczH/Fa/gYmamAVHKWxV8yc00Y+qvhFRKsCh09gjILTNmoVRYTR3PnEme3FGOAoUBUrHAmmPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692713; c=relaxed/simple;
	bh=G6wrqc9lN2Z5Thmk3+XuaIFvHY2mEtO+5WPLfjlHn8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s34W6UJQUrslbT9sIK8qYn+Q3w3VgLxaWQl/gAt4/WMOydF1R48l6PnzPG0e6lulbywwypusPKhfmhi9oYCN1IpMPKIEhYIYyfNjeIJHF3p2Why/DlFRZ0dlAxKU6BjlZy9Ap0PRl2sc1hF6P8szDRQes27fVI+wo6pcROc5zGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=eZL+NQZG; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bQsWW2v7TzlgqVb;
	Mon, 23 Jun 2025 15:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750692709; x=1753284710; bh=LUZ0qEHJJTDt+6aIIR3vZylC
	zvIVqJUC6YYRJKPqtSM=; b=eZL+NQZGZLsNiCK2wIV4/2FRBKRTCcqq4hr38jhb
	hig3Bu82/hSmX0cfUVv4LEle0upeK3RVUw5x28RB355aJ/9uzz20RFWmrkwWVXXA
	FrI5i8VTlfTW8BkN2c1FWgr9FsehDWIHoIXYt+xld1bjdJfwVTdbWtTb1RbjKHAT
	X1zdJXvPihAlyKKNvOMKntdhpfqR/M4tNaJFUMe2R7RACJHyEDn8/ZMmra0uuXGs
	39Y23hW2Czpa/DbYjFCOqXopQiVh4RjEU5UqjPQXGkU33pZIpKtAddJjGIfm1A/2
	ZiSpkK2oPXtSIBGmI1G2BV+fnOq9JEFRbfIhRS3zZUedZA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qfbmONVdDI45; Mon, 23 Jun 2025 15:31:49 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bQsWH1z25zlgqVY;
	Mon, 23 Jun 2025 15:31:38 +0000 (UTC)
Message-ID: <8eae59ce-1d46-4c9c-af6f-0f6bb39a8286@acm.org>
Date: Mon, 23 Jun 2025 08:31:37 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] RDMA/srp: don't set a max_segment_size when
 virt_boundary_mask is set
To: Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Ewan D. Milne" <emilne@redhat.com>, Laurence Oberman <loberman@redhat.com>,
 linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250623080326.48714-1-hch@lst.de>
 <20250623080326.48714-2-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250623080326.48714-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/25 1:02 AM, Christoph Hellwig wrote:
> virt_boundary_mask implies an unlimited max_segment_size.  Setting both
> can lead to data corruption, and we're going to check for this in the
> SCSI midlayer soon.

Please make this patch description more detailed and mention that
__blk_rq_map_sg() may split sg-lists such that the virt_boundary_mask is
not respected if max_segment_size != UINT_MAX.

Thanks,

Bart.


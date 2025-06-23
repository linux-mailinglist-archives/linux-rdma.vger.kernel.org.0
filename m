Return-Path: <linux-rdma+bounces-11544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D801AE445C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 15:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58539189C598
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 13:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569352566E2;
	Mon, 23 Jun 2025 13:35:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01C253F20;
	Mon, 23 Jun 2025 13:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685750; cv=none; b=mvYTVcMfGVkZgbB79AUE/kFueVQyczkuKXl4K/2CLKaxi4cgQ1xQmmfTv/okzXDl1pAhda2dhU3cgrQkIpcdydIkKhURY+BFaM2JEvv/3XqVHhb8UYxZtrH3h4RxoR5KZ0UY+nCYNtsdXpAlvDlv71u85DI4HkuTn87d8pxx124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685750; c=relaxed/simple;
	bh=vnOYB7qJM0a7wBUsgOPfboaRlAqA83EXjpXhngzC9B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYdcP/GaowxntkMg5fdkyCtzaNDg53T2QyRn33tIadbRPuIQhjAcFxljzvBd7ol9PECD5dqoCpU0gIbDjHRaSREc27auTKGp+U24z1MJlZpiphr/e9sBMBcRqm+2naRRoTFZewL5b4j2A97HaxmjOBvqy74sJqoJvkm6Hw3WnVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2A79768B05; Mon, 23 Jun 2025 15:35:43 +0200 (CEST)
Date: Mon, 23 Jun 2025 15:35:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, "Ewan D. Milne" <emilne@redhat.com>,
	Laurence Oberman <loberman@redhat.com>, linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] scsi: enforce unlimited max_segment_size when
 virt_boundary_mask is set
Message-ID: <20250623133542.GA27271@lst.de>
References: <20250623080326.48714-1-hch@lst.de> <20250623080326.48714-3-hch@lst.de> <447ba437-9742-4686-b159-bc2086c9b814@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447ba437-9742-4686-b159-bc2086c9b814@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 23, 2025 at 09:37:10AM +0100, John Garry wrote:
>> -	else
>> -		shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
>> +	if (sht->virt_boundary_mask)
>> +		shost->virt_boundary_mask = sht->virt_boundary_mask;
>
> nit: you could just always set shost->virt_boundary_mask = 
> sht->virt_boundary_mask

I could, but it would change behavior and break drivers.  The SCSI
midlayer allows overriding the template provided values in the host
itself after allocating and before adding it.  For the
virt_boundary_mask that features is used by iser and srp.

>> +	if (shost->virt_boundary_mask) {
>
> Or combine into a single if-else statement.
>
>> +		WARN_ON_ONCE(sht->max_segment_size &&
>> +			     sht->max_segment_size != UINT_MAX);
>> +		shost->max_segment_size = UINT_MAX;
>> +	} else {
>
> else if might be nicer, by maybe not as (I think) {} should be used and 
> that is not pretty for single line statements.

I also really want to keep the virt boundary vs non virt boundary cases
visually separe as that's the main branch.



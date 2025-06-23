Return-Path: <linux-rdma+bounces-11546-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F54AE461C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84FDC4476F6
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 14:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5216145323;
	Mon, 23 Jun 2025 14:06:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AE676410;
	Mon, 23 Jun 2025 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750687563; cv=none; b=a24XMc6ITBqi/D2kNy1vYwiTX9EZRKNK6oGggxzd16Wp+nz7odywqLg5ubrjxdzupl+PpKgyWaiPdCduOZB1TAc0DCc7KaHPNwBSF4MdhtbFDhCevPWXovwpGRb6OXvbRjmdr32iEzPZLqonWDtcFWPh2uw4GLuSjUayqvprWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750687563; c=relaxed/simple;
	bh=pPFsSr/HF259Qv5RYzoni9W0+hMMj3aZgoKC2GjdHv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NtSEEyNYXTtOrJ3J9nInGLCduXKN79u1wzdvfatvOnAo+kem3IrDntMQ+1vN9Dd3x5weNDMx9wiW+Nbix/wsMmz/wZgZ9fFZH/02E45pFKZ0T21+oS3kgInHPc55vWDq0IFwiROxy9O2E4+5i8/TtvLyp+VmLKG1z475ODLjToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 650C768BEB; Mon, 23 Jun 2025 16:05:53 +0200 (CEST)
Date: Mon, 23 Jun 2025 16:05:52 +0200
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
Message-ID: <20250623140552.GA27893@lst.de>
References: <20250623080326.48714-1-hch@lst.de> <20250623080326.48714-3-hch@lst.de> <447ba437-9742-4686-b159-bc2086c9b814@oracle.com> <20250623133542.GA27271@lst.de> <63895c91-47d3-400b-a32a-093342b95cca@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63895c91-47d3-400b-a32a-093342b95cca@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 23, 2025 at 03:03:27PM +0100, John Garry wrote:
> On 23/06/2025 14:35, Christoph Hellwig wrote:
>> On Mon, Jun 23, 2025 at 09:37:10AM +0100, John Garry wrote:
>>>> -	else
>>>> -		shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
>>>> +	if (sht->virt_boundary_mask)
>>>> +		shost->virt_boundary_mask = sht->virt_boundary_mask;
>>> nit: you could just always set shost->virt_boundary_mask =
>>> sht->virt_boundary_mask
>> I could, but it would change behavior and break drivers.  The SCSI
>> midlayer allows overriding the template provided values in the host
>> itself after allocating and before adding it.  For the
>> virt_boundary_mask that features is used by iser and srp.
>
> Since shost is zero-init'ed, I did not think that my suggestion for this 
> minor simplification in scsi_host_alloc() logically changes anything.

Oh, you're right - I thought we did the sht assignments in scsi_add_host.
So the changes would be fine.  But that also means we don't catch
conflicts added by the direct shost manipulation.


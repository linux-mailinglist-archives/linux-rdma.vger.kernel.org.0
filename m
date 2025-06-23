Return-Path: <linux-rdma+bounces-11536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2CBAE3B1C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 11:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597021891DE3
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jun 2025 09:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79806218E9F;
	Mon, 23 Jun 2025 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qb2LBru6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977B2367C3
	for <linux-rdma@vger.kernel.org>; Mon, 23 Jun 2025 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672273; cv=none; b=QpBwXxMO0Bmo72xhFZ0upjUNLgM8jgUR8r+1ZAuQFeWp1byBGxfJAgkJT1OqMQdW0ZmnDV+bfwqx+GrARL/sAAp2cLEOXyOZ5Vc+0el0obvZP7NAd3TU/nRFKclLu3Ge4iTS/ws/P4HJSK03g0koQrjI63SOawcR0LAOb0+5TJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672273; c=relaxed/simple;
	bh=Rot3KbRbxTNHNEHqeFGYz9FZiaV8DjwC59KSip1uUA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU8S1Pwi4l4tHCH1ktVh7OndLl4cV4z8SRGagQm+AdV34dDMSG5HQp8nrqD9t26poQPtT4Gr9U85E4TL3Oi9HaKFyFS4IjRTAe3o4InDCUVniznebMrezdmikzWXN+bH9ydyRvgC7Ydd5sS6Z7pratsU/pu+4tDjNPimm5Ma140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qb2LBru6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750672270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+dw2VEOv18UATXVau5i3FVFgwclvcj3uT4MGBkEcAkg=;
	b=Qb2LBru6gdTWlj+We43GdDqpmsyHoB493l6XbXlsXbyd8pqZYa/Ye5W2oT+itwInuAnHPG
	ttqDqKFa2cQaOCxcpSUQpCoIbQH7B/htHn139dR4jsa/74GonOy9d3OjnUvVO+oF7y60Xx
	GxH/Nllzqjfx+NLEowYSi7fySnxMBlE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-ig4664WMMa-ZThUNNl2h6A-1; Mon,
 23 Jun 2025 05:51:07 -0400
X-MC-Unique: ig4664WMMa-ZThUNNl2h6A-1
X-Mimecast-MFC-AGG-ID: ig4664WMMa-ZThUNNl2h6A_1750672265
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B06581956095;
	Mon, 23 Jun 2025 09:51:05 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6181180035C;
	Mon, 23 Jun 2025 09:50:59 +0000 (UTC)
Date: Mon, 23 Jun 2025 17:50:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, "Ewan D. Milne" <emilne@redhat.com>,
	Laurence Oberman <loberman@redhat.com>, linux-rdma@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] scsi: enforce unlimited max_segment_size when
 virt_boundary_mask is set
Message-ID: <aFkjfv67LK0EpAC3@fedora>
References: <20250623080326.48714-1-hch@lst.de>
 <20250623080326.48714-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623080326.48714-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Jun 23, 2025 at 10:02:54AM +0200, Christoph Hellwig wrote:
> The virt_boundary_mask limit requires an unlimited max_segment_size for
> bio splitting to not corrupt data.  Historically, the block layer tried
> to validate this, although the check was half-hearted until the addition
> of the atomic queue limits API.  The full blown check than triggered
> issues with stacked devices incorrectly inheriting limits such as the
> virt boundary and got disabled in commit b561ea56a264 ("block: allow
> device to have both virt_boundary_mask and max segment size") instead of
> fixing the issue properly.
> 
> Ensure that the SCSI mid layer doesn't set the default low
> max_segment_size limit for this case, and check for invalid
> max_segment_size values in the host template, similar to the original
> block layer check given that SCSI devices can't be stacked.
> 
> This fixes reported data corruption on storvsc, although as far as I can
> tell storvsc always failed to properly set the max_segment_size limit as
> the SCSI APIs historically applied that when setting up the host, while
> storvsc only set the virt_boundary_mask when configuring the scsi_device.
> 
> Fixes: 81988a0e6b03 ("storvsc: get rid of bounce buffer")
> Fixes: b561ea56a264 ("block: allow device to have both virt_boundary_mask and max segment size")
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming



Return-Path: <linux-rdma+bounces-17505-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIdbA2D9qGmD0AAAu9opvQ
	(envelope-from <linux-rdma+bounces-17505-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 04:49:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 506D620AAA5
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 04:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EBAA3013A4D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 03:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE67C280309;
	Thu,  5 Mar 2026 03:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJYnScmU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zsuvrq8W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281F20C461
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682588; cv=none; b=WDyyn2mfaG+IxxERJizCB3QDriFgPSQv3dzOp5HRUd+W9Z2n3gmk/dE9EHHKcOOsQhetMbgSe/tYsRCA2mLodBSBIF4twCQTgxRAG9InlfO1xPeKxAmMIq8LwoKXDN2r2k7ug/lnut/rug99G207pO/v7BBjqoJowC44/vd3KVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682588; c=relaxed/simple;
	bh=HzvI7v2uCNMcHvZyzRR7Zw1NGWpAU2U3VmMxS0+RUzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlEwvVjj2pcQEUFbScZNDBQYQKGGJr86qFWPhS4SRyRXbpYJBrd+0WxSLy9+ZXAR/oyNKce8L8C43LZWTInu7hkNCi70m6Uk+phUUMU+tUxjYrWRdwaFImk/gRkkwaW3xGmGTY0LlbXQQ4jLD2zmKtsBILL6YOQ9nLoW04P1DEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJYnScmU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zsuvrq8W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772682586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=74+P5uoCPoPHFvVbcSWpLrLXj229WmoszuE2boMHBwM=;
	b=OJYnScmU0yJiflerAThQC1/7ftGQi9vC3n7apAwyukAJ7rZzOzKCq8DE5R9bJ4GD1+aFRW
	nzeLMy65z0CMgFVM+ojKlyEjgfqQQh5nHrXliOj6V5FyRDlJit4F4mBcsHnn44SsdvWsxE
	y5EgyEhiudzl8UaA+21mI6AkxQi96Tg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-bj9FUjo9M9SG_N82yE-oWg-1; Wed, 04 Mar 2026 22:49:43 -0500
X-MC-Unique: bj9FUjo9M9SG_N82yE-oWg-1
X-Mimecast-MFC-AGG-ID: bj9FUjo9M9SG_N82yE-oWg_1772682582
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-506a07740bdso80601151cf.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 19:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772682582; x=1773287382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=74+P5uoCPoPHFvVbcSWpLrLXj229WmoszuE2boMHBwM=;
        b=Zsuvrq8W6NZon7hXC3NxbTnj3U2MZOd/6q0QmyaBV0AHOeW/r6i8SzAJT8SmaCenx9
         R1H+aVQI5KD2N4jij6fBekFyRyN1x426xEuzDD+e1NCSW6ilTBWd27pxzFIBcVZP32gx
         3lhg/Ljbf9L3cAFs8+6gxAHPUjRlxwe55+q+CZ2WxW30DbqMrBXNdOgiFVw9mfkdzN2x
         ywVo3GZ++vwblDEy4Zq8Y0oRhAlfkmVzQ4ISBER5Ye0A7vZ1a9ahcgLVWeyOIU8/rFic
         xXtEJWBKtZBqt/PvhS8hyYITrgO2oSqOHAgZjzdoDMcaMpgzsb8OFs5UGv4rCd21rEkm
         DTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682582; x=1773287382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74+P5uoCPoPHFvVbcSWpLrLXj229WmoszuE2boMHBwM=;
        b=j009ERt1GXkvDspYx3XqhMVTdLc+skB9X91ePd9ZQEs4wcOD9lZC/8vm5hrqav6Bj9
         sUW6ysvOI5g3yQt2r3SC5UwkQeLh8ruUkBujb9geVlOLQaG77L7s+pbGObPVHqYs9hZJ
         uWiDkAQbehqEQcTOfC5Kirw5PlxkLJqM2a9A7cXNlTPZKbaeCXFthG+ScH4+R34Mr6FL
         3G8Z55EouPLDlCLM5v1a7+P5/YURHm3fj3GS1ccd8gUGC27bEOeiAuMcRIbZOU2RDgvw
         3TeDYmDFAl38KYFUb/f2RPEg1LWp6Lf0+xJRp0HJvlWwtUYZxenvT6Qr1q2hOCdYsEay
         41VA==
X-Gm-Message-State: AOJu0YyBNhMzQ535O+ZLQbxfZQVdCXWwz1gm4+hxYOKMknEqqhQxe/s/
	oxcvAOpjN6DTWI2lTZAVg6Zth2kKyqRcy1GrTHP0QRT8aay8Sxn2nOa+H5Z+UUxqCOUHNBtIwPQ
	1UvgcosWmxaQAWWHBxPH9VIh3bg0wBUPl47QSLA0Mwsm3/y5gwGngDT4GgItj/hw=
X-Gm-Gg: ATEYQzxBakCAj6+U6a+lJIgSt7lBHpXkpUnSjgJ/n9oKmMy42/jbZDqaco1Ra2WKCyA
	+fEPGDqkjxGXW0Oqs3oHPLdx2Pd4gzDB1sWOrZGKxCclTUUUz3SIsJ2jHTnZOOZOwn7OB5Wnfh4
	lpAThImzS3CTC/qTg2v9LrD3J6N7/H4t0DiLs45Do1l5xcR6QB99A1v0DJ05zjDwQ/mDIrEWojd
	nC+GiqPILojyDoRlmOlryWHZtiRTFKkNIaVdoITBbG+aKnKnrQ9HkmYml0hCeRTueV1VN0TC2hd
	KLvX+RoQd79Dndnwe9Fl+8meMhKoWivL4VbAeweBX6G9frN+AJ/DdMYAAh0MK/0eIJeQ/Ipq18i
	P/purWM415RDurok0CpKcEB4RyoOISeGu4UzKgpruXYOJ89CT+Ux+SsbUsnXgYjbRxfQ4PUj9C1
	hnvZpv0RDklEJn5S+0mrC/JPR1OsnBP8sb2nBwMlm+OBCJYZoRqDDXokY6wwPtB8WxDvcbvkHDt
	I8ixw==
X-Received: by 2002:a05:622a:142:b0:507:3d1:1dd6 with SMTP id d75a77b69052e-508db241b22mr61825641cf.5.1772682582574;
        Wed, 04 Mar 2026 19:49:42 -0800 (PST)
X-Received: by 2002:a05:622a:142:b0:507:3d1:1dd6 with SMTP id d75a77b69052e-508db241b22mr61825461cf.5.1772682582197;
        Wed, 04 Mar 2026 19:49:42 -0800 (PST)
Received: from lima-fedora (bras-base-london1622w-grc-27-70-50-94-240.dsl.bell.ca. [70.50.94.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c716cbf5sm196309006d6.16.2026.03.04.19.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 19:49:41 -0800 (PST)
Date: Wed, 4 Mar 2026 22:49:40 -0500
From: Kamal Heib <kheib@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-rc] RDMA/bng_re: Fix silent failure in HWRM version
 query
Message-ID: <aaj9VLGLHWESm0kw@lima-fedora>
References: <20260303043645.425724-1-kheib@redhat.com>
 <20260304153707.GG12611@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304153707.GG12611@unreal>
X-Rspamd-Queue-Id: 506D620AAA5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17505-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kheib@redhat.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 05:37:07PM +0200, Leon Romanovsky wrote:
> On Mon, Mar 02, 2026 at 11:36:45PM -0500, Kamal Heib wrote:
> > If the firmware version query fails, the driver currently ignores the
> > error and continues initializing. This leaves the device in a bad state.
> 
> Can you please elaborate what will it cause?
> 
> Thanks
>

If bng_re_query_hwrm_version() fails, the code returns early and leaves
cctx->hwrm_cmd_max_timeout uninitialized. This parameter is subsequently
assigned to rcfw->max_timeout, which is used by __wait_for_resp(). Later,
when the driver sends firmware commands and enters __wait_for_resp(), it
passes a zero timeout to the commands being sent, which can lead to a
lockup.

Also, cctx->hwrm_intf_ver is left uninitialized, which will likely
be used in the future to determine if a specific feature is supported
or not (like how it is done in bnxt_re).

Thanks,
Kamal
> > 
> > Fix this by making bng_re_query_hwrm_version() return the error code and
> > update the driver to check for this error and stop the setup process
> > safely if it happens.
> > 
> > Fixes: 745065770c2d ("RDMA/bng_re: Register and get the resources from bnge driver")
> > Signed-off-by: Kamal Heib <kheib@redhat.com>
> > ---
> >  drivers/infiniband/hw/bng_re/bng_dev.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
> > index d34b5f88cd40..17147175a9b0 100644
> > --- a/drivers/infiniband/hw/bng_re/bng_dev.c
> > +++ b/drivers/infiniband/hw/bng_re/bng_dev.c
> > @@ -210,7 +210,7 @@ static int bng_re_stats_ctx_alloc(struct bng_re_dev *rdev)
> >  	return rc;
> >  }
> >  
> > -static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
> > +static int bng_re_query_hwrm_version(struct bng_re_dev *rdev)
> >  {
> >  	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
> >  	struct hwrm_ver_get_output ver_get_resp = {};
> > @@ -230,7 +230,7 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
> >  	if (rc) {
> >  		ibdev_err(&rdev->ibdev, "Failed to query HW version, rc = 0x%x",
> >  			  rc);
> > -		return;
> > +		return rc;
> >  	}
> >  
> >  	cctx = rdev->chip_ctx;
> > @@ -244,6 +244,8 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
> >  
> >  	if (!cctx->hwrm_cmd_max_timeout)
> >  		cctx->hwrm_cmd_max_timeout = BNG_ROCE_FW_MAX_TIMEOUT;
> > +
> > +	return 0;
> >  }
> >  
> >  static void bng_re_dev_uninit(struct bng_re_dev *rdev)
> > @@ -306,7 +308,9 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
> >  		goto msix_ctx_fail;
> >  	}
> >  
> > -	bng_re_query_hwrm_version(rdev);
> > +	rc = bng_re_query_hwrm_version(rdev);
> > +	if (rc)
> > +		goto query_hwrm_ver_fail;
> >  
> >  	rc = bng_re_alloc_fw_channel(&rdev->bng_res, &rdev->rcfw);
> >  	if (rc) {
> > @@ -392,6 +396,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
> >  nq_alloc_fail:
> >  	bng_re_free_rcfw_channel(&rdev->rcfw);
> >  alloc_fw_chl_fail:
> > +query_hwrm_ver_fail:
> >  	bng_re_destroy_chip_ctx(rdev);
> >  msix_ctx_fail:
> >  	bnge_unregister_dev(rdev->aux_dev);
> > -- 
> > 2.52.0
> > 
> 



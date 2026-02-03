Return-Path: <linux-rdma+bounces-16461-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEBoJIMLgmmCOQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16461-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 15:51:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B197ADAD08
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 15:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FE6430028DD
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592D3ACA63;
	Tue,  3 Feb 2026 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OY2UksvU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AEF513
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130303; cv=none; b=ffoqYg9x01vrrM7VSDxd2+l9331/ZzLb4wf7VPPO5+5t27pDqsO2J30LiENtxrqJrtXsJVlIq4x5WvJEaa/tJho+gwBMrJx7vFmozjfB1d7157mBcmo3VXkN6uMu3E5cc82Xb6IYgR2xq4gOUS4S4Xaksi/v4htmjC1ew1ykp9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130303; c=relaxed/simple;
	bh=KzHzoKKSe/7HE7HJI6bDRnfX3aanOyCR3su3kgOgfwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1q7pudDcV1jBXjKkpX0K3TzqE5r93UgJ2NC8RIay0ZaVuc5Np7kMawBziEMW5dv8MSqVmFSJ2z+1DkV0cT8NpRKSIwPcDLy5PaoZmuCdmIoZjTUdvFR2BTUu83zIRvq4bZuaH7YXswTJm7yGasrLsBRp5Z/t0FcpqvdLjpc+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OY2UksvU; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c5349ba802so593859285a.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 06:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770130300; x=1770735100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7fZlfdOVHw055VmTolHqDtEtnpy4ywRxTSVdpDATpM=;
        b=OY2UksvUo1NjPY47gFJMEMigQUE4riqvR/kwj8NhPDLq4aXnJHLeValftZbWPVzn9k
         eCUdhoKZS2QB4jqE2wYHXmWiUf5lshIMBPXGISCVx5gA/rK145pYk5s1fMXkXf4nMoDD
         v5eITBze2JOTuehWqtp6om0HXkmb7/t1c2yUdVKEZtvjnCRztP3b2lusS6dIR0vH9WYA
         eZDkTTpXTtU+jOsizf5p2skGLZu/s/F5JxuRhC25A7OLjVQgtQ5xiriX9kSNK7FOBhLM
         +f+mxxnCKqJDWFsMVtwiIc4TfMr5IXtWqHRuhSstXYsrOnokdmJiKa8hh5uwGPrkAJKO
         MkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770130300; x=1770735100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7fZlfdOVHw055VmTolHqDtEtnpy4ywRxTSVdpDATpM=;
        b=TrKauFrWfmz+3fi97r4EPfJpWVxN7eC1otdVXgaErQNeARVc9gdHtMpTjPWCvecC50
         SrfG49pNoPfUggx/D5hZ9Ry3rAj2sILnYXE0G0jHSfB386iZkZp9eG9vI67vUxSDXJ2U
         qOBxtM2KUpFW1nWdhtY149kFbM4UIVxnbHbtYGctVrX5r46wNcwge3OgVrUttWUFT6kk
         w8kNd0FxnDP8u/SdKLTGq0YF/MI5PszCzkXPtrfxdZ6z4bW7ai92JMDfVKvVDK8i6sjL
         9GWn9pUbaVH0XZbuihG9rrLw8X9OOSgd5J4F2PjnbMpGcudzJ59ucGMVL1FFyoU2e7jD
         zKNQ==
X-Gm-Message-State: AOJu0Yz4xsGRlYnMglNIJmPhmEBJHBwKnDp0qy8wGIjQPF9D1ObxpNci
	SvuuLFnGHvggCfKf3m066q33uK5bP7tHWe32bCjqtrLaTr/Rjc5K7pFd3hA1r4xYC7M=
X-Gm-Gg: AZuq6aLGFezJTAb3Pr8G+u/4TBC/5fDoMuSStxpFWjmEPND3RublHsRgP4gYq7u/ubf
	tQcXpf4/K3GxJCmMFbeZpAQqjU5li+rWu1ygweRy21GMY0TUhO+MzqFdbcv/gchVzTAG25LyE/0
	TXyRdAmVSudAOytKIFJ1090Q1AivFwks9/ecLamOokh6ezZlOM6WuaE331bh6zr3waSyIw8IaJx
	k/rD1CTAASqk721ikhU20U6nzNz7KOHZia5udtgLiaHhNyQxRITT8LElYZCZOV53VG3dDPFPokD
	/H9fQWEMUj3sKZ+GCFgupQehWEFrvLT5Ob+WiYmlHP2A/CHyo5ldMWIBfN1JfyaVd5bhr7SBkrI
	093mxPb6dcteVHtb0CIrEpAq4NE6AiRHdB1Ovm+aT5yJPr7U56nOeRkFVfQdUz92uB9CYoltbig
	/GaqW8HVsuOmo/uMQotCvn/P9LGxK6X9yJJl88ux2kvJoyJAsFH5MhAuv24ub+1BMDejA=
X-Received: by 2002:a05:620a:254c:b0:8c6:f7ee:b334 with SMTP id af79cd13be357-8c9eb311964mr1878196485a.65.1770130299890;
        Tue, 03 Feb 2026 06:51:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b95acbsm1429270285a.12.2026.02.03.06.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:51:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vnHkg-0000000GW3p-3kwh;
	Tue, 03 Feb 2026 10:51:38 -0400
Date: Tue, 3 Feb 2026 10:51:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, wangliang74@huawei.com,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com,
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com,
	edwards@nvidia.com, sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <20260203145138.GQ2328995@ziepe.ca>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203085003.71184-2-jiri@resnulli.us>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16461-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: B197ADAD08
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Introduce reference counting for ib_umem objects to simplify memory
> lifecycle management when umem buffers are shared between the core
> layer and device drivers.

I admit I have reservations about this too.. The flow should not be so
convoluted that a refcount is necessary. The lifecycle of a umem is
not uncertain at all.

I imagine'd it would be like:

core code:
  if (ops->create_cq_umem) {
     umem = umem_get
     rc = ops->create_cq_umem(umem)
     if (rc)
      umem_free(umem)
  } else {
     rc = ops->create_cq()
  }

Driver:
  create_cq():
    copy_from_user(drvdata)
    umem = umem_get()
    rc = driver_create_cq_umem(umem, &drvdata))
    if (rc)
      umem_free(umem)

   create_cq_umem()
     copy_from_user(drvdata)
     return driver_create_cq_umem(umem, &drvdata)

   destroy_cq()
     destry_hw
     umem_free()

This basically moves all the working code in the driver to the
driver_create_cq_umem() which *always* gets a umem as a parameter.

If the user uses the drvdata path to specify the umem then the driver
helper create_cq() creates the umem from the drvdata parameters,
otherwise the core creates it from the common UATTRs.

We can keep things so the umem is always freed by the driver on
success, which doesn't require any driver changes.

It should never be "shared", this is just a very simple unwind on
error kind of pattern.

I think the challenge here is to unwind the drivers into the above
three functions so they don't have a mess of convoluted error handling
around the umem.

Jason


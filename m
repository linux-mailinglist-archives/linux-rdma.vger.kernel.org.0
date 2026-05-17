Return-Path: <linux-rdma+bounces-20842-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDL2HZbMCWq2qAQAu9opvQ
	(envelope-from <linux-rdma+bounces-20842-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:11:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EC656181C
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 710B4301FA6D
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3927C2E1F02;
	Sun, 17 May 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CHemMt+k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197942D46CE
	for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779027062; cv=none; b=Y2g8VmdiUmEfJcJQnAbGywpO81jsMaoxFBLwRbExsxyoLHhTzeDu4GjjpCl50ryUBdEuW58lBGqQPALAe3vdvtLFkp8kbdTi+bSoPO41IsP3zgH073X3hQqZyf+YFDLqZbTLEfE/Mkq9A7CDAYWrAjcnwFhYeRNp9K6/ZNtEXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779027062; c=relaxed/simple;
	bh=G2plrwZtxal/SI7IvH5/VW3UJ9hM6oqZnKxTcZP7/nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYGfERzH8p5tRCiSEQPkIT7LXfDcbgl5XlhWqc+rIsM77Rjcjjbtv2S/yPYXwi2xedYlHfHtG5ldfbb5HK0BmGtlQlJ/Nikxn6TUBUId3tODyI4cMxF8jNUcVbNKbqTq+8YMU04dhyO6Qn+rv8q3VTa9zz6D1yCzPPZ7f8CdQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CHemMt+k; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50e97863425so18441061cf.0
        for <linux-rdma@vger.kernel.org>; Sun, 17 May 2026 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779027059; x=1779631859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HbsEGrjVMTax80UWydbFcmuVU8XwXlkCJp5AmXuZcNA=;
        b=CHemMt+ku/WV1WaSqqBGo8v8Rwjua+Yv8ieyKg/0h1pmWq/xQfC9yDAuU3fJWZ5SlQ
         ReFwzejLp/B3vy7IVIpkJKEHO9WQIkNPqwkoqeoLdykp9GuhCE1bcpefj88NaFgWd2gm
         ua/QMapysa0zeexBWEobMbIVRrik0Ra4u9ii1cuUJlSzrYNjPPC6oZtDr43wclwTntTj
         JtaaUW7GAA3NmLC4UWNdZC9rivJ78+kxBY2yE7zXgwWlJlV77z0QFXBYnMM4UiOwu5Yg
         736ihTLYIPov+gmIWGRYEpQDsTWPT5iSzGsxnAGrZzJN/OY4qSbt73ZcWIbGfYl2XdyG
         t62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779027059; x=1779631859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbsEGrjVMTax80UWydbFcmuVU8XwXlkCJp5AmXuZcNA=;
        b=OQJlTTVkW6tqMojcLAyrLEMjkoZ2IJ0ujeROyScYoI8vP4Q2y+BRSMLzFCDRfXjcDl
         3eusr6/lZK628TdN0OCuZD6pdqeJq8ak9EnzVKJK48J5fdfzTAuCRc3nR6RWDYtD3mtO
         2WfCJs+qdqsFfhG7ldmfBn5XKaflobcO7dTeiDCTBBC9pEAVLwy1GjHVvyfKzIlO4pV8
         tcXUl69L/b0izf3p9++x5JmGHDrSGWdmTZq8z2uSjyjiTmNzz49Wx1pd0/CK94CERDd1
         SANP+2HK9DefZRmoaXfNJ1xtfI9FlSzLkzP5186oFm4S1zyD5OrS8425Y/8Hc9QM+YP9
         b7SQ==
X-Forwarded-Encrypted: i=1; AFNElJ836e89NbPjlpzOWT20dHTh7wg+uN1jsmzpQGHroMF4x6i2KY8PYife6MSIYIf8s1za+1asniZOcklC@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFfCIJ9czSdAVOOOu/2Bk6dT1STbEUtBk6/I7UKvR3/RUmuM5
	MVLjIR3SKjeMddHDidH1s7SL8jHLO9xOW/iN2+wXS3S9zcT333nbtaeDp06Sz9nwthi32NMmsc2
	mQQRw
X-Gm-Gg: Acq92OFC8aGW+CaIHotzoHMIWFIb49Vz1vaQPERjU5/FIBNZ2XKZvpglrKoHwRRxzli
	snqG/XTTaIJ2Gjk8PXatCRiaP/XBGNErCaIRpalnSEjfNlbWJF3/teCXBOwKPsUblf2Z+x4WgT6
	tlJeF43gO6v7ckl5YPLYgHUIJgOtJw3JYiD9duNr6RIHIgDOEEO7ciOwYhteZuhPTphKPQByon6
	7NnlzKYgHYGqK9Ro6LFQbJS/LDDO9KIvC6Oyv7aATmNx1r4TGza1jeOzIDjl7e5gT9N1+sJ0wD6
	TUqc+XRa/boGhsAwnvwwK5dWWULNNYjU6Wa/TtrahMnC1/Fe/aB3J+A4I9Nm1lovpLZk5uDtS05
	XWumOUpjvxeVXa8FjLzf3cHp5wGm7m5js41VIpKXRdgp6nQ5ToeGyhNNAbMlo4oF2fnJITFM4mn
	JYXN56brnDsuGLmwAh2+YAAJcpmyfzh9SPZzqpOqzCzU8cLCi9+HIAGfVCfgPy7BcyuX7W2y+zF
	YXUEqjiYIOlTqbd
X-Received: by 2002:a05:622a:59cc:b0:50e:feee:76c3 with SMTP id d75a77b69052e-5165a0255afmr160665761cf.18.1779027058550;
        Sun, 17 May 2026 07:10:58 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645856d4esm102856821cf.27.2026.05.17.07.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:10:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wOcCm-0000000BKkA-3QP6;
	Sun, 17 May 2026 11:10:56 -0300
Date: Sun, 17 May 2026 11:10:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com,
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com,
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com,
	edwards@nvidia.com, sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 00/16] RDMA: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260517141056.GR7702@ziepe.ca>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260512192319.GM7702@ziepe.ca>
 <20260517114755.GF33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517114755.GF33515@unreal>
X-Rspamd-Queue-Id: C7EC656181C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20842-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 02:47:55PM +0300, Leon Romanovsky wrote:
> On Tue, May 12, 2026 at 04:23:19PM -0300, Jason Gunthorpe wrote:
> > On Thu, May 07, 2026 at 02:52:15PM +0200, Jiri Pirko wrote:
> > > From: Jiri Pirko <jiri@nvidia.com>
> > > 
> > > This patchset introduces a generic buffer descriptor infrastructure
> > > for passing memory buffers (dma-buf or user VA) to uverbs commands,
> > > and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
> > > bnxt_re and mlx4 drivers.
> > > 
> > > Instead of adding ad-hoc per-buffer UAPI attributes for each new buffer
> > > type, each command declares dedicated UVERBS_ATTR_UMEM attributes that
> > > carry one buffer descriptor each. Each descriptor specifies a buffer
> > > type, covering both VA and dma-buf. A consumption check ensures
> > > userspace and driver agree on which attributes are used.
> > > 
> > > The patchset:
> > > 1-2,4. Plumbing: rename ib_umem_get() to ib_umem_get_va() and re-route
> > >    it through the new central ib_umem_get(); no behaviour change.
> > > 3. Introduces the core buffer descriptor infrastructure and UAPI.
> > > 5. Inlines the const attr helpers so ib_core can use them.
> > > 6. Factors out CQ buffer umem processing into a helper.
> > > 7. Adds the CQ buffer UMEM attribute and driver wrappers.
> > > 8-11. Converts efa, mlx5, bnxt_re and mlx4 to use the new CQ helpers,
> > >    with drivers taking umem ownership.
> > > 12. Removes the legacy umem field from struct ib_cq, now that all
> > >    drivers use the new helpers.
> > > 13. Adds optional whole-QP, RQ and SQ UMEM attributes to QP creation.
> > > 14. Converts mlx5 QP creation to use the new attributes.
> > > 15-16. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
> > >    doorbell records.
> > 
> > I think it is OK looking, Leon?
> 
> I have a strange feeling that we have too many ib_umem_get_*()
> functions. For example ib_umem_get_cq_buf() which doesn't accept
> anything CQ specific. Or this general ib_umem_get_attr_or_va().

The cq function is needed to extract the CQ specific uattrs..

So I imagine a couple over different per-object helpers for the
different groups of driver needs.

> IMHO, the in-kernel API started to be very messy.

It reflects the uAPI :( We will have a helper function for each
variation of combination of uAPI flow the driver supports.

Jason


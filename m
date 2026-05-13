Return-Path: <linux-rdma+bounces-20568-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +B9qAO1jBGq6HgIAu9opvQ
	(envelope-from <linux-rdma+bounces-20568-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 13:43:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C89532759
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 13:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8250E303C9E9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894143FE655;
	Wed, 13 May 2026 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="mrFU5vO6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E93FCB37
	for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672618; cv=none; b=NEhUZtJTp5YBHpJd6ntPjNOdkdtHS59Ix9IRWRuyYe0pGVvinMw/nGdwhpRRxhLKYAjS44gC+coKtQyYiqhqpPC3U2U/+ttCe/Cp34c/Z/Lt7a/acYFxBOLFS3tRIhqZBRqHiP1Q8F129U5Dpxcqjhc6q4VxZuuqnYCFrAkJ2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672618; c=relaxed/simple;
	bh=MnK1f9iUL/q93xImgKEeAlAwrAhiCoBTsXzNpGyWRzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOZ/ppx0cZtDE4MynW7VCW4YPecoiLRu5SIxf186xw2X5XbLntPgBhSxNPv+Pkpk4QRiXw2QCUTOswhTHAPX7B9eYSEKjvbL0KIdz8oGlvWkwC0LXToR7io6tntmCECAh/lWCM23UY36US2C6VLxUsTMVk8XtqfHUVMfP4TuvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=mrFU5vO6; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e82c23840so30107135e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778672613; x=1779277413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a8Jnx2VqDbXRR941wxc2WBWuitrdRFHWzwhLID1lZtM=;
        b=mrFU5vO6fjjMHvZkuatrcMGSywBkNC5x3sL01GTTqrHFECSZSLyyJ59vT12KLhUVwk
         7IwA6iICfYSHkJF0AidrbltVyX3gXbIdQfADuhqJu1b8Zm2DejXa0/mB0WR6KoMkExqp
         OKa0hB+JCvGfabjPEX9k/c7Y5xm+zYF9kJ/XrWdVMK1iWKQzoZIfnlwDwxC5LYW/d6pb
         SaPmey7o96kDaPoC0f3AP3d3Jqr9Rlalca73dghljZFN8LUZw5Qghgsc95lKY/xI6f09
         DeGZPelXHu+xgoZFnLXHT5CpP0a1JfG8O76oN/oFBONtQ+zaY608yEv3nNH7vVB7o8HW
         Ng/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672613; x=1779277413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a8Jnx2VqDbXRR941wxc2WBWuitrdRFHWzwhLID1lZtM=;
        b=l7WnHrpfZdhkMGHQ4bDzrF/PJkMgxFgd+Pl2g/KqHompFMzXs6a5fBV8N6V/5KAPRx
         SaCHI2GPaTTzCFoiLI1Uy6C90+/M+3QEpPnvbr1QjEy/KR2hTPsxs7Rul2xsySerlvRD
         EjnSBwWQylS8foanVUuWeb4uzS1zkUkIDsDm1tUS4udgSg3RmeIMOLNNOAc+bJP70Mlu
         C8q1FOdsy1mMNwDGzo852dVRV5Iy4+4UxGUO5cZawUO4E5fr1JntGYDir0iLtGRiBDVj
         gs7AZT0Ieid5/f0EgDFLrltYzRiRbSNC4gOyHF+57UeoBkr94fdz1WcHEj1VFksoLb6I
         S35g==
X-Gm-Message-State: AOJu0YxIa7fRedCdiGGCEXYvc/fq0BjSqAneK/CvAe18tzRrX030V14j
	tjzVIb+sNteCCEmKRlGcuS2fNQOkxzgsbLRETeImC3tdcDDpYd4mu+rTV5JkpFLrH4A=
X-Gm-Gg: Acq92OHy5U1znL3pDXGIjNFO4YpsDOIgzcsJj9U4alyKRHF+Q1ZYqs3j4gzxgXD9P5x
	Jz1wPtkuHP6ZGeBZzGGB1Pyba5S6WmksE99ugLAgDd0yMSwwETYp4mUem7WevjQxyDxBLBREriD
	DXCwGuipA9abOeMT0Jz6oEGwLQT1N3WnmklXazZFfsOmu6JnqdbSOQjMgcoTRwTau2Sf4rJggHK
	JwCGOn47gIsQRmo7m9YBPDDJjFwzSkmKn+AxJ6+WlLrGKOBMRJoMW50af+8ag2H+T3Ne0hRcJQ6
	fMycR9S6IbVWbm5xlFEK/91zrfJSkAYleHX8KsyYidxI4c/iUvCXIrunk3K9yImUPDylvH9EvIq
	+u1KkkB4Fdfc1LLJc8AFAGiP70/2KLMnwmZwHmiN3g8w+RacX8lp8lvNrH1ZW8CwcHSpKKBOj9T
	D/cv5MqNg9IFMBiUV391Jpxa/S0W7eCs0=
X-Received: by 2002:a05:600c:a318:b0:488:a977:8d6 with SMTP id 5b1f17b1804b1-48fc9a371e4mr30303665e9.19.1778672613342;
        Wed, 13 May 2026 04:43:33 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e566cf7sm68470505e9.0.2026.05.13.04.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:43:32 -0700 (PDT)
Date: Wed, 13 May 2026 13:43:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 05/16] RDMA/uverbs: Inline
 _uverbs_get_const_{signed,unsigned}()
Message-ID: <agRj4QyKHBUI6yum@FV6GYCPJ69>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-6-jiri@resnulli.us>
 <20260512175142.GH7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512175142.GH7702@ziepe.ca>
X-Rspamd-Queue-Id: 91C89532759
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20568-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 07:51:42PM CEST, jgg@ziepe.ca wrote:
>On Thu, May 07, 2026 at 02:52:20PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> uverbs_get_raw_fd() and the related const helpers expand to
>> out-of-line _uverbs_get_const_{signed,unsigned}() exported
>> from ib_uverbs. Callers outside of drivers (for example the
>> about to be introduced CQ buffer-desc filler in ib_core's umem.c)
>> therefore cannot use them without unnecessary extra dependency.
>
>oh. This is actually a systemic bug, the intention was no driver would
>depend on ib_uverbs.ko because it was supposed to be loadable
>independently of the drivers. This has become slowly messed up over
>time.
>
>The file ib_core_uverbs.c is supposed to have these functions. There
>are many. So many..
>
>I sent an AI off to fix it, lets imagine we won't need this patch..

Plan to send it soon? I would like to respin the patchset and send v5 as
early as possible.

Thanks!


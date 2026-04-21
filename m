Return-Path: <linux-rdma+bounces-19450-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJcaCxNz52ke8AEAu9opvQ
	(envelope-from <linux-rdma+bounces-19450-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 14:52:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FF243ADF1
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 14:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AA4C3011131
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 12:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B997B382F0A;
	Tue, 21 Apr 2026 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JtQN5e71"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A892D7D2E
	for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775935; cv=none; b=ojyO6dsFGOc4i3+XipxYdz4PCp/pJms/gVjmN81SbVUfgUGwtzelD5LpDVB4STIByitYdmEaIKCVDUHzWipZqqctnC3A9CJgV8SP0TOKw0dKDHSbO4zYHrSkBGj+Dxczsi3RmoPhFDhR69h3wpxsr7bMxvea9wbyTHaJvWNeICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775935; c=relaxed/simple;
	bh=879D4+ai+ia2UJXl5+g771ePw+HZgxnXr+06C63wL3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR19KR+hVLea+OGOREQT9efv434GT+YGgeVQaOVL4u4crCHgwvBhtKEMt0RFvXW7BWnPouiyomoKFzydGJ5tfU4WIG4QCs5lcQy1Bjt2xQAqpn4v/csOUBGpLay44l9ie2M7s76FCZYSvWvPeorFp3hB/D1B52JWRU00+mOQJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JtQN5e71; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a151012558so46443606d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 05:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776775933; x=1777380733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bb7qEWu6Uk2h7hUK6xR8yWsMRgJbRrt8B6bNk9/o1J0=;
        b=JtQN5e71NDjZLNNQDtElnDKw3ZtAugSplahSPFEu6Yt2RdhrP5aRMsA1l0XBSNtfbC
         BRQ+AbpJ/sYrYb8KbhoQTUvmhtnsRiYmUCxSiqh6aYXJTgM3+rtvdVjsbn5WNuKB/6JB
         MeZRNZkFAGceTTGzG1QUlzqAerCjswBjP9QNp+SmjMeFFusNEtZBPbch5mb55rNM83BW
         CFUF4I+k3mwiVi2i3u0nGf6vO1spu+oUT3rK8wOdRQsMwMJtBQWod2kjn3KckGrKEfHb
         NyBmquRZpKIpU6yEsCibFV5ruf/9x1M7480ms2VcetrDsl2gbbLz2x8UgPw3xsB7sKYw
         9hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775933; x=1777380733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bb7qEWu6Uk2h7hUK6xR8yWsMRgJbRrt8B6bNk9/o1J0=;
        b=OA+86onSqDC+HxAcjWsdGI38MCa3bUoSAyb8htU7AzfXerludYId1fWqWy0hn29oTP
         xOJhUE6sKeNJPMvyLg48RCVlwRYqc+S11gu3VpLtBdHLvuWMLfi/Wgfrc6AK/exppIWC
         1pd2JHheymoBhE7JK0njZEqX9VwpaS+/DEP5qCFzCZTHLULWKFyRoiL23GBSgRBUG013
         5vVcA92F1oCCZJ/sKC8XYLinhOvLca/+zgyTLhoY6fy1E453o35xiJgL2n/knARMDNGI
         U6jjSBhb5SgZfKC3AY20Uv89/bRXgEBogBml/WnwkEh6o8Z0JodPen+qyuCDXVjC4r4z
         F/3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8C2gHZ+n97tdsywQAhVT9X5pgDTGvRpS5Hp3WLX0lzZw5Olc5Qlzo6VckY948dbiWPpIyC6utnIKMZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyj98UMkVe1UbI+uw9C6Pe9nvkklfRwH7/X1DZ11kz/inxlLJl
	I8T8HtzUugcbh2v3br5O3H8H20ihyZ4TuXAD8BU4IHFOVMh0OV9C6JAlByq1Tskpi5I=
X-Gm-Gg: AeBDiesKbfvmxMeJU0cHnXo9jQIi95xUpp51ZFIyNfkNXMJR1r4LvDKSJRpk0gBKOog
	vRi1CRuQuSmBVW5P9//s/7sblGrOvoP6U4QCT6gvLVTWWnMy5EEwyiUaxKfxs/A9ro/sbTXXOqe
	a1kNkZ20tZEGjgLUpi+lmYlB+3Po29TaYTMXNy2wv44roKvo/FvTX/yKEKvpA/TvYgAJLVDLwLV
	LzhvmhH3yerThp/ONKPEjsa57GR8wfipZ5qeIi9wJYu4OA43ZZ7c/PTAO34lYC16I2N2Je9knMQ
	65/iqfpz6PRRtIrsjyF7N2mPltVBOghA2HjepnO0SoIC3cPvLmJCb9bPEL7KNDr48K4OCydn9eu
	HS2h9eWTcbWStMWimnvkY2ca5zwixsi8SrBSdQe8SkMPBidwNRgnLRfNFBu6H6ggKEELS5owu6V
	CkwoVlXGQK5FyMiBBORGFqckr6BskXkwzfmH0u6u732tyrTCKUnOoE2zQD7nQyzzLOwijFbgA2j
	NbSinSQsiI5XAHpSAUQVCuCyTg=
X-Received: by 2002:a05:6214:29e9:b0:8ac:bae5:7477 with SMTP id 6a1803df08f44-8b0280eddd8mr293978226d6.26.1776775933355;
        Tue, 21 Apr 2026 05:52:13 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac429e9sm101583626d6.3.2026.04.21.05.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:52:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFAaK-00000001RZ5-1aNJ;
	Tue, 21 Apr 2026 09:52:12 -0300
Date: Tue, 21 Apr 2026 09:52:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Margolin <mrgolin@amazon.com>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	leon@kernel.org, gal.pressman@linux.dev, sleybo@amazon.com,
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com,
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com,
	edwards@nvidia.com, sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 01/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <20260421125212.GF3611611@ziepe.ca>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-2-jiri@resnulli.us>
 <20260412123322.GA5166@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <fzughzkkr5zkr436pdzu6p2j4sdlphtxpbbpztxoerbms6a37f@4dzcxphdyjg2>
 <20260413160232.GA21984@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
 <dy6nbf2vibl3aeopeb7im7fksh5436isqcmcarghkm5e2ontoi@unvvimhthp53>
 <20260416121000.GA20519@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416121000.GA20519@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19450-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[47.54.130.67:received,100.90.174.1:received,209.85.219.53:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84FF243ADF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 12:10:00PM +0000, Michael Margolin wrote:
> > >> >> @@ -64,6 +64,7 @@ enum {
> > >> >>  	UVERBS_ATTR_UHW_IN = UVERBS_ID_DRIVER_NS,
> > >> >>  	UVERBS_ATTR_UHW_OUT,
> > >> >>  	UVERBS_ID_DRIVER_NS_WITH_UHW,
> > >> >> +	UVERBS_ATTR_BUFFERS,
> 
> I don't think you can add anything here as it overlaps with driver
> specific attributes. I suggest defining per command attr id and passing
> it by caller into ib_umem_list_create.

Right, the expectation would be to have a ATTRS_QP_BUFFERS

Jason


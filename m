Return-Path: <linux-rdma+bounces-15854-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL22F70YcWmodQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15854-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 19:19:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 051A95B2F0
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 19:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 47F25822041
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FED23A9BD;
	Wed, 21 Jan 2026 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nn8u06bo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B960495531
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 16:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014341; cv=none; b=iPYIds7W5SB8+xlBvayq7LUZAI6cX0YjeVA8VMUOHLtWff/px0VNs2qktsMVQAEtiE7YiAxGSNFfvh2rgj8HyaeOeg4Oew852Ny9NDyvJ1/3MRuvQs/5AAe2Q+UWmWPRQ/Pzwan6YvNqkyobN2cBfhn02WcsWT9r5ypM/TQT1xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014341; c=relaxed/simple;
	bh=9zHSgbuUMZ+PfkKVuVZRJrDeeobKWIkyI6fFw7r90WM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEdWMuEVvPLtjlUN7mVJKDtQ7aotPMLBmUh/muQNfWZD1Nkg3DvYHQ3mdadB+6zfJVaoAlXD69M7l2CRQKGBOMIXtZEfveXDOW7nXpa5iUn6mDj+xc4Ih+SeF6/ougSDvt6hfT/cGefI2HrNCdsPegtF+bwFfO0He4wUoFRICVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nn8u06bo; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c6a50c17fdso2365485a.2
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 08:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769014338; x=1769619138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HL5eI3fGGqE2aIP06XV4gTJ+BcrssH/vCWAe4DyEJSI=;
        b=nn8u06boFZfIPeQvYGk/2+PaHo08NcbKT6KeZ8DbAFvQMwT5Bpi0pGHkBLW0A2zbgn
         RO5pcS46IxnzRlOteDGT7sjcw1i8H3VFfreUhRC8ttCaWIotVjuR2zTge2cUlftF/HIr
         SbnSIbQ3GKe6ae2DCB8o7C1PU6d70hg5v/HNJgvZ9CoTP08c8SgQQoxnwd7FV+q8m8NP
         xwyjpSBZY+O4GCHE1Sq52UlNq1T1nT36mmG6fh/XQ5h9PuiBSAo7yaRrNrZer2j0SPss
         BfjPRoJZsyU/qDRxY7lDmPRsrwdEk87t4pVbQEKgnMy2/OjaNUt3/gfCiyMNKemyiaB2
         JjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014338; x=1769619138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL5eI3fGGqE2aIP06XV4gTJ+BcrssH/vCWAe4DyEJSI=;
        b=C/RfTVp8s4RdJ+kKKNNpXTW5wIntgM7QtI88SYRzUQ2AG8fF6ytKcA6M/1PHMbTsyO
         jcGZoBMXKOdmkKFUv05qb108z2J+pd2u1b4QMzx6lD0vk6w05p3rUl23+UUNJ8WZJsU9
         NHlnPVvfuPqoSA934+jpeWT3Rq5ehbbPhUnx43OJRHTOuyJCPAHwXGujd/FjLV7DOSAA
         93FqpbzGZkCR57cTGQbnY7QQfuHI+sKGQu4YBM2bDLlWBpKH1CsJnmJ88RcgOioKOTP8
         Bc1AmLPqmQp2J9zSnL8oK8rIEJgaYnj0Vu8udKUNGlR9PYbOwjjI0PtNfZIP6+Kg5Uzk
         GWsw==
X-Forwarded-Encrypted: i=1; AJvYcCXGoVolz6dzqjAD9hym9X1n2On6Phw7Hvp8KPwpbE4CdiPUwdtYeq3QPJsW66sjsrcoQHHIGD51yLpE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2HvKEp5x/Ag6wtPFgyT/WKVzEw6johgd1JzWlyPOgdCdk+kpU
	ZcU9UHHH5TItTVsR8oxEToUzvDlJ9TsZQ2Zpx+kexhEP8tdpgIg2p3q6Q0JL1w9pOIY=
X-Gm-Gg: AZuq6aLGeaXP/IcPd0LzHazk7pfTuCY3id+QO+D8sWei718ZfROgVvQFPw/rjGkLa9w
	OzQiWTOZJ6zj2kFwABVyN23A7Qajqw6095CdMdxDMTuOOMVQQcQ5tCrb6+X95y3w2e1/oWa5uBw
	u6iytdXQkPd+JOOIcDy8FlUf3eh2A/oeuPVAc0aPQtKx1m1+Pd88u5vW90eHoLPrz5Ll+sORXdZ
	fjcdAZYhPShlf5w/Mv6w4WCxkTV2SgmNWOKhE1Q8EAiiIhTUGbp3GmjmMaw36hylXCpLE/2JHzr
	ltOMM/L9Z54j3wmcITyvR6yrinIfqIp5n1UZhfVTdPI307Cj5rHB+/3yk0HvnnwgPI9KETVbWFv
	nbWAXpPOe/x3b/cWsRYJGt3f1JEofGEIm3/CSpXnI5TIe/sgXQm8CG+ick6FVrx+lfYItDLU4qi
	AL9wtoLkuJ1hBUlczdUIFFMXE3E9i8KOIHSlxA19+CtfSxzGC0FhUrLnspuiGCq19mTJk=
X-Received: by 2002:a05:620a:458f:b0:8c6:a59b:243e with SMTP id af79cd13be357-8c6a68bb374mr2525115585a.12.1769014337746;
        Wed, 21 Jan 2026 08:52:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a728f2f2sm1269767685a.47.2026.01.21.08.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 08:52:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vibRI-00000006FDn-1THv;
	Wed, 21 Jan 2026 12:52:16 -0400
Date: Wed, 21 Jan 2026 12:52:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v8 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20260121165216.GH961572@ziepe.ca>
References: <20260117080052.43279-1-sriharsha.basavapatna@broadcom.com>
 <20260117080052.43279-4-sriharsha.basavapatna@broadcom.com>
 <20260120185419.GU961572@ziepe.ca>
 <CAHHeUGXtiDezOVwmFJ3y-0daHD_3ENayqtDJUSHnDE9rVRiAKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGXtiDezOVwmFJ3y-0daHD_3ENayqtDJUSHnDE9rVRiAKA@mail.gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15854-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 051A95B2F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 07:32:36AM +0530, Sriharsha Basavapatna wrote:
> > For instance CQ did it in the above function:
> >
> > static int uverbs_free_cq(struct ib_uobject *uobject,
> >                           enum rdma_remove_reason why,
> >                           struct uverbs_attr_bundle *attrs)
> > {
> >         ret = ib_destroy_cq_user(cq, &attrs->driver_udata);
> >         if (ret)
> >                 return ret;
> >
> > int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
> > {
> >         if (atomic_read(&cq->usecnt))
> >                 return -EBUSY;
> >
> > So this patch should be doing the usecnt check as well, otherwise it
> > won't work right.
> The consumer of dbr, which is qp, is in the next patch. So the actual
> usecnt logic (incr/decr) is in the next patch.

I saw that, but nothing in the next patch *reads* it. This is the
point it should be read.

Jason


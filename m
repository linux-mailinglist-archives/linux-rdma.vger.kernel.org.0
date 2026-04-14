Return-Path: <linux-rdma+bounces-19342-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMsWKkZa3mmLCAAAu9opvQ
	(envelope-from <linux-rdma+bounces-19342-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:16:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD2F3FB9AA
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 17:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CF783019D4E
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Apr 2026 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9493E6DDB;
	Tue, 14 Apr 2026 15:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LAUnyFb5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC230DD22
	for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179353; cv=none; b=Zjmf8SUln33RSg5z4LHUw4DkhFsJNRQpTnM31UHRkD8s44SssDvEwX8qEQL1QXx7zaAx/20pjmg3DFWTBStuqwc15rs2UqZJWRoDt44V4w2yOrh83jVONDcatUAEg2K3VRbRu7JmhLJyGppRVHAW7paU42+aP0CUTchvNqpzO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179353; c=relaxed/simple;
	bh=PrUSlIOesK1lbsqmSqzt3to7qBt4jZ3e1qlgnC5113w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m68Q1SanH/DS1k7+0Vlm9UTGVU2krsw+/knhkN6ZRZOPYveIF9SuJaF4+EJGqIVn30Q03V2NVeK7DLy7kBFvgKVAthlY8dUHGweLHSL7ny4rzkKWIii841U0oGx13qXngOJA30jIwW9ukjmKJaGFuP3ZpSm9Pyb3qLpC6EVXKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LAUnyFb5; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5675d609621so4372459e0c.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776179350; x=1776784150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PrUSlIOesK1lbsqmSqzt3to7qBt4jZ3e1qlgnC5113w=;
        b=LAUnyFb500pr23WiGIBOR2JLb5frdMVYnFMvr0XVgt5LQXJslUoLw9yFH7vqQViCzN
         T1HvYvE2C00o99t+wJLW1mlw1aPgXJllZ+O8Xi4exuAjemnGxyG/MgyN0v6HOxpVhSBY
         52p5ZxfsY7GuRbCqET0ZESo8fFOPdL+gCEJQPGsttSbf5yYV2uBq2Is7Z7UKiDB56fAJ
         gSGuJP6Dn7mdLbOdhW/BGEFqb01YGCbXstGnBjfFP831DMPkozPP7tTUYcT5MF5D783i
         XdkCUOxUzvY+gncTMgtGuUkgJ4XtHahnutFirJPWeFmNQh35sEU1ZIB+ffQpsqqqwTzH
         uRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776179350; x=1776784150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrUSlIOesK1lbsqmSqzt3to7qBt4jZ3e1qlgnC5113w=;
        b=rjJvKOXFfQIMUe3TxZr8sJt3wJvjX5cjm46/uq3zkSAiCkS4RsXQQIDl6op28R3in+
         7kwtDarPiq2Con3Nd6qkuMqqG6Cx//Ad6mlO1Nh39mIsl5vMKg4DoNtiutAoaNsHgvy0
         L1cdaykC9c0qsIE4Q5o/nKCVnkbNo12w1Fah8RKywpN0JlnqzYqvG/UuCV28b1/eT3pi
         2x8dJUd68lYxuw/EkMT47enYPYz9qpd3/uWJvfMbVWRHJmexn6CE7oeG5YEq+dNEqvOo
         dWswZVfvz2D6nHLI5QCLykbTjBUZWY2DjqygvNu5/OjHbAZg7FhC+hyKLW8qslpcpSv6
         aKdA==
X-Forwarded-Encrypted: i=1; AFNElJ+dee706qcd3hr9BGz3QxNnHqSYwN+xry6OdRiVoU6mB49hpC1h06pK3Wdw8sYXEpew8ucFvgfbxva8@vger.kernel.org
X-Gm-Message-State: AOJu0YyH+QWFA8RZNjU7aVtJiciuGbBBwiv+dO6SFfnq8uew7StXuuFv
	tERUbfyZARNcn0qsZKpM2036fcm0pgH7FsX5H/Sg5JrtQtuuZIXa5n6eW6q1Bxn7K5e6aKwxwJc
	r5CWh
X-Gm-Gg: AeBDievdhP0h7z0tEpoZ8qF4sIt10Sq0e43IKZ1U4iPss2pR1up4Y3/8axBuggQvOL6
	kkOFxoIfoezm6kaGaGvQZxpYu0r71TGbJrsTl4JVm2qZSEzyRATEQ0uY63dPaBTLpuVb1FWHKNH
	yOpDQGUFCxEwzg8a+lZjUl3TbGD+V3Ezl8igHVR4Gb5914cNh4AaSCWtUoVX/4Bl07ruKYvKhuw
	m2MPSU+V0iymRkkUnDPjw31wRTtGiWeKRQilrYIKTMJsQEpL37LCjBf/kSYBNWxCbWUMTJ4FW5n
	eruqJYNexXERL63lLbJSqqjZ/WqO7k0j4YDXJhiLUcAxCL7YMr9r0+M0W0ihIa2Zd6n2AxcUpjX
	xPOHb1WsdJLAXIOXfFFt2Ui2MuwoFxxzOxrIrSThrrO0FCsEV1MKUEoH7yBjKE/0nOA9rSe4h42
	9o5YIba/z0jkS8yU0LTRgB5e+jPWUwypakmxfNAzm7jYS2qD4GVm4354lV/mx4YX+OOTdOmmWQ5
	imPDQ==
X-Received: by 2002:a05:6122:29ce:b0:567:4e8a:fb13 with SMTP id 71dfb90a1353d-56f3bbf8947mr9695457e0c.8.1776179350464;
        Tue, 14 Apr 2026 08:09:10 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8acac5373c6sm58238556d6.35.2026.04.14.08.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 08:09:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCfO1-0000000BN3c-1Uq7;
	Tue, 14 Apr 2026 12:09:09 -0300
Date: Tue, 14 Apr 2026 12:09:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v2 8/8] RDMA/bnxt_re: Enable app allocated QPs
Message-ID: <20260414150909.GE2577880@ziepe.ca>
References: <20260327091755.47754-1-sriharsha.basavapatna@broadcom.com>
 <20260327091755.47754-9-sriharsha.basavapatna@broadcom.com>
 <20260410152752.GY2551565@ziepe.ca>
 <CAHHeUGUwCBjho3oJLJdOeTSF3cp1U_DYsN_satsCo4_aEKLWOQ@mail.gmail.com>
 <20260414123434.GX3694781@ziepe.ca>
 <CAHHeUGVTsMSCrVQ2uSa4_1DfctNYL7Cy2y2QRPF67nW0mPFXzQ@mail.gmail.com>
 <20260414135438.GC2577880@ziepe.ca>
 <CAHHeUGW_be95eHW55tFszfC753Zp2sJFJA781ywsXtSD+6XArQ@mail.gmail.com>
 <20260414141940.GD2577880@ziepe.ca>
 <CAHHeUGWwQHTfrURo7Afbw7Ec0gCbsO-nq4VpQtMgPbgSJQkP4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGWwQHTfrURo7Afbw7Ec0gCbsO-nq4VpQtMgPbgSJQkP4w@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19342-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:email,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 5DD2F3FB9AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 08:04:22PM +0530, Sriharsha Basavapatna wrote:
> On Tue, Apr 14, 2026 at 7:49 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Apr 14, 2026 at 07:36:48PM +0530, Sriharsha Basavapatna wrote:
> > > On Tue, Apr 14, 2026 at 7:24 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Tue, Apr 14, 2026 at 07:10:41PM +0530, Sriharsha Basavapatna wrote:
> > > >
> > > > > > Yes, and it's fine, you added app_qp and the only thing it does is
> > > > > > check that userspace set VARIABLE. Why?
> > > > > No, app_qp (boolean) is used to make other decisions too. It is passed
> > > > > down to other routines and all that logic is in earlier patches (2-7).
> > > > > This patch just enables it.
> > > >
> > > > So list what it actually does?
> > > That is described in the commit messages of prior patches. To summarize:
> > > - update rq depth
> > > - update sq depth
> > > - update msn table size
> > > - update hwq depth
> >
> > What does "update" mean? All these parameters already exist in the input.
> Yes, they are existing variables, but they are set differently if
> app_qp is enabled. We don't need to compute their values (such as
> adding extra slots or rounding up, etc). The application handles that,
> and the driver just uses those values. And so we "update them
> differently for app_qps".

So your comp_mask setting is more like "RAW VALUES" for those existing
inputs, similar to what you did in CQ

Jasoon


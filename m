Return-Path: <linux-rdma+bounces-16654-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALyTBa3/hWnUIwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16654-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 15:50:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C702FF2B5
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 15:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B40443010B81
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 14:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EF53E95B6;
	Fri,  6 Feb 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mfYgOY8G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C7F36C0DC
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389414; cv=none; b=V2CJ1EJqLhP7JodoxvltAeNA+Wn3fjPImd+WuX8Wx7GJ+M6IFHweJYT+ja16EjnXbrGwjUJlgjK5GQ4HWlEdsQWNm5f/mmPMN0MzMw4Df0BkBRbogROGMeFqpo6XqezURU9HTQVmHoo0toBvYmvngtje6xp78zj8wX/Q4Z65SlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389414; c=relaxed/simple;
	bh=uR/zgv/BmDTbzZQkB2mZgmVBz/u77baHbK0LMrgqdH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baqtuchqC4CMEglREP/WWez4hxjczUmPFlnzvuzze5sywucqmL8aN1jUP652ksc97BM5E+YxnKeOA11b8jKg759fTV16ppJrGpOLEDG+ah+MlNxLH3io1ItiDzhL+eO7sC2ToMFXYKaSDIABqnpVxE7t3kUQsYrRORkFuuWRDJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mfYgOY8G; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c70ab3b5fcso103375185a.2
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770389413; x=1770994213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KlLHrttethhEOXqb6xM0efxI53oNrC9LReBMANRr3YM=;
        b=mfYgOY8Gp+uYVhSMIU2cjDxXAQlO+QJIz4spyZmX1p33XU/7xgv/mlvLXn/HiYqDo5
         /EqhFzUXRkHCbOgaeIivu9t2QaERqt7pdKn3j1Nz1ijfNkx9HQd0AiZ+9MB4s7xItJ41
         ai9lClZ3b29u06M3wtc/dT4dD+UAAnBhtu6jqAeADq1mD9yAi0SiLsX6ACgVlUeH0xMd
         n546EoL4qfGZZ+2kU2f941FR5VBoiF56JYuIg9etaxWsQtKp1Pseb7UicNZQormwAYO1
         Aubr8F5Zq8I2GM03GCM7TaIypPBINsjsgVIDS41uKTIoJi9bU6h00TyJElrbAYknIcy2
         c5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770389413; x=1770994213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlLHrttethhEOXqb6xM0efxI53oNrC9LReBMANRr3YM=;
        b=KcEl7w+NYQMtXy+Kv9IrxG2E+j6K0Gya0w+TQ9X4R7J9giJG6zZohn8GBOkIq581FH
         eas0e+I77Hsmo8As5rqX75HLizUTxa7BQjaxqrgCB52Thgri+NwFA+jsrp77FM01OMvS
         BWhhon9TY/5sO74JtLq7SlpLagVyeQXcdQndrJHrY4UbdKw+DXcP9ea0CRx7W0vcFhEK
         3nQFRAugCCbvKgdbY3UT4/37vBH78fhc6205oVkgKvou+bVCFaaNq3EakVSfdhNkOZeQ
         alVExbwtiqeVboLT2Yrq3ORtQN9l2+V2dFFHMuRGza5odZ9TD4CBeqgnFZKOJUNIWXLf
         dUfg==
X-Forwarded-Encrypted: i=1; AJvYcCXF4CiCCTAzueDzUsUxxP87qlzW2knDKfWW4gdTBwPehMP9t3akZUZdKeakcdRo0qyXTdsTKqOHEce4@vger.kernel.org
X-Gm-Message-State: AOJu0YzbrotXh97DpN/VMrRfZc1W2zFeFDx7pcINGSxtkr2f5PXJAc3C
	d/9umMnMur2I1XrX9TBUjUZF/pz6yjeG5mBO4sjpMb5Xh3UB4UraLKRwb2pikG+Av4s=
X-Gm-Gg: AZuq6aJoxfTnSagHprzF9df0V26nM6N1rKok982GT+Z5s2aky/yYBwZyBCjdkwLYdx7
	rICiHaOKcldc6j33Vqbaw+fYcY7OYS+5OvmOcPb5jMDyDC3Z72xP5GQArnHN5/XhNO+fvngzDHu
	h9I2xnMOVYrMPVRKkL7o/xvkJWiS0zjahBIZfxDuEL2JX53ymZjHnoFqgFZUc/I1TPfG1Xlo98p
	Kulcm5UyUeiaG7mmtJN4BDv8QwLQWQqL2qjfQ2Q6Ou3W1AGScYJhm2ju6G4yWZiuadZwGgdMVaq
	0zCu+HI27sFDaiBrQcBE4gah6LSn3xmpgbRa5CFlx+dZVIV30ughAO8ZiGAjrEb9HBkor7Mg7m1
	Md0rudnIQPsd25TfsYbxEj4rSWNkmiA/kqItN/W2bRKrUR8NERsB92vMDm+yHWF3XRjB2HMs4oz
	Hjoenj6ZCqxuc0WrbmIeVsU4I4Oiv0mAP3G8iERsWD+9O03lB26Adwz5JzlwxG8P5Q7EA=
X-Received: by 2002:a05:620a:1729:b0:8ca:3c67:8922 with SMTP id af79cd13be357-8caf1acd8camr355449185a.85.1770389413178;
        Fri, 06 Feb 2026 06:50:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf7aef19asm172371185a.21.2026.02.06.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:50:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voN9v-00000008UEG-2ahA;
	Fri, 06 Feb 2026 10:50:11 -0400
Date: Fri, 6 Feb 2026 10:50:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, leon@kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 1/1] RDMA/mana_ib: return PD number to the
 user
Message-ID: <20260206145011.GJ943673@ziepe.ca>
References: <20260206143646.989247-1-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206143646.989247-1-kotaranov@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16654-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C702FF2B5
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 06:36:46AM -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Implement returning to userspace applications PDNs of created PDs.
> The PDN is used by applications that build work requests outside of the
> rdma-core code base. The PDN is used to build work requests that require
> mentioning the PD. The MANA HW still ensures PD isolation using PDN attached
> to MRs and WRs, therefore the PDN mentioned in the work request must match
> the PDN of the used work queue. The work requests can fit only 16 bit PDNs.
> Allow users to request short PDNs which are 16 bits.

Okay, if you say so.. What a crazy thing to do, and not enough bits to
boot.

Anyhow, same comment as broadcom, the driver has to implement the
driver data forwards/back compat protocol properly before you can add
new drvdata extensions.

ie if userspace sends MANA_IB_PD_SHORT_PDN the current kernels will
just ignore it without EOPNOTSUPP, that is not OK.

So you need to do the mana version of this series:

https://lore.kernel.org/linux-rdma/0-v1-89ea7d615ba4+636-bnxt_re_uapi_jgg@nvidia.com/

And I have already written alot of the required mana parts here:

https://github.com/jgunthorpe/linux/commits/rdma_uapi/

Feel free to pull them out and make mana changes matching the broadcom ones:

  RDMA/bnxt_re: Add compatibility checks to the uapi path
  RDMA/bnxt_re: Add compatibility checks to the uapi path for no data
  RDMA/bnxt_re: Add missing comp_mask validation
  RDMA/bnxt_re: Use ib_respond_udata()
  RDMA/bnxt_re: Add BNXT_RE_UCNTX_CMASK_UAPI_COMPAT_SUPPORTED

We can take it after the merge window closes in two weeks.

Jason


Return-Path: <linux-rdma+bounces-19467-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMEhN5Sp6GnEOQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19467-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 12:57:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F218544507B
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 12:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B22813011D4F
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2026 10:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4FC3CD8A2;
	Wed, 22 Apr 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="tkPaPnvI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C38C3BED56
	for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776855419; cv=none; b=a3feKx6BwbPbmbxae7HAE5ZtCANB8MUWVCDTyn5i2e+RVLYc8tLczKA6ShrwJoN9KB0mWSnNtZzaEE4cL/frAE8KjeDBwAC8h+2o/gyrdgEnkK6PNhPmDlXbNqiXAfeEs7RZYtbTPAzabKxd/YmusmNO0YcXWs/wG03oxELKEjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776855419; c=relaxed/simple;
	bh=6Y80RHuR/ATqFnS+pqsk8XA75E228gx75Mt4R1vqkh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STM7fDsOP4bLx85Q7RYQpoSf3FZl3pE30S6GP7niJMCUP2aC9gGNkPfb2b8qiAP+XLlefOxh//VcT/IN/O0f2rc68WrC101j/weCuzy32eftl1fQeXl1WmneVCr1SAVFo1u4Q1ZItJVbMzTdXMe2GRsRameaH3g/3ZqCZuEFSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=tkPaPnvI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ba840146so48853765e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 22 Apr 2026 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1776855415; x=1777460215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uaf6KSxagz8WZxoypgJbdEJbIMgWWZxRaU40qt3gDMY=;
        b=tkPaPnvIMvusfdC5eVaSlLiXlnVX3FhnNeg8UWFm1gqeRFAMmaVv5Iw7T14iTxbBt6
         JT94EHQ2qMQkjwzbvc0fFPghWkABWC134WVdMq/FsD3N/pNnIDfdqIED1tzed9J0V5Bf
         g2SzFqII3yOPgcLeAbTkhicTBO1N9KVyqQFKKWKxLhh0yMh6V9DALSgmdVP7PcVbq2P/
         WE3eUfQqv0sxqVbAL9np/vwwsasJLwfHsWlewaE7MawioRphrM9gGYRlk5uopjsL1dJZ
         YEAVb8hr3D5QVqjNPJhJziYiuPeusWCIRipXaQbADExJqJSnWLUoyn0neqrT6DUTJF/f
         gA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776855415; x=1777460215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaf6KSxagz8WZxoypgJbdEJbIMgWWZxRaU40qt3gDMY=;
        b=F6SUkDeRmQX6cee/UPxuKfKpaSmXGa2RDWqr+I0+ENHxMEWICdQ6XuVBYNTURnOg4M
         7xUugQfcQ70fie1Jb9kVHc+WSEXo1IH5udIyv9NaR11C5En81TN1D7bueUXXcfuojImR
         fqa8cepxD7n3dlLYdcvS2RQ5kMjv1s9R/yTY0CWSmjKb7WyoD56XqIX3wFNbGnpQYOaJ
         iZigEW2EIUJV/PvNQ9Be+YKgQSEF5PkDczeZBigrKjxPPvSnaFEXSkseUDQJQu/7sqSm
         chWsYij82i167m+wshNWWiQnv4Le4oOP14Td0qNjhnIF2i0VdWrsR61W9nCNchh9Swbg
         q8XA==
X-Gm-Message-State: AOJu0Yy1HZJQ0YDseSjpo/yFgsXxO6AAUAtXQUiOWuuu8KGm9v823Wgp
	oIqltxSGY/55xHH4kStwOZPURSNzaTfsAlOSrt79IWJ4Yfh/7X7fqybc2+PyhMlI/iw=
X-Gm-Gg: AeBDievBEPKoZmGlcKdeRPatt3iSkEHjGRrPtD6trgVrBIo6HCnkMw/QNLmh5gWbdyh
	gm6oKXGp+IC9DfREjXA82YpENPc2brQpPiomc1427IzryUvPhL7nl7cvS2buT79XwB+JUeUaTSM
	HIqgNshFtekFWHg+GQ0IfMPK9N58YEwKDsh3Wlz3QrR25Klm3WRcFnTbwDT2ZvpoJC+BhIHVdVH
	Or+FWBFLpjqq8VdL5MPcYyKkLS2heJfCshPT+j40wo1WQAs/7QNhnZVO2RUkY/gdJ+tu1n+pCXx
	LYduuKtVi1CwVpVnJjTLDGhlTcGxT55AVzVK1+2bl9ZBKWfOGJBBwca3ojMgSfrthABCcn4WMZc
	3tJsWIRfTe+7SOYg3gVZgGOb/+/N94W5vtGkp1MKInrAqpqCMv2RtM0sEZ8gF6Ml1AX6Xx6AZOL
	WTf8RR98vvCgIujlBvHohDZNOQiocyuuwmxAuAoNkPFeOarw==
X-Received: by 2002:a05:600c:1554:b0:485:439b:683f with SMTP id 5b1f17b1804b1-488fb775fd5mr295836315e9.20.1776855415000;
        Wed, 22 Apr 2026 03:56:55 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a18csm51039410f8f.20.2026.04.22.03.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 03:56:54 -0700 (PDT)
Date: Wed, 22 Apr 2026 12:56:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v2 02/15] RDMA/uverbs: Push out CQ buffer umem
 processing into a helper
Message-ID: <7hbhqdwc4vboiwi5d2yqpqgxhvouqmuxzar3dzvkxhll2eb23s@43ftpwsavstd>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-3-jiri@resnulli.us>
 <20260421132532.GA360923@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421132532.GA360923@ziepe.ca>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19467-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,ziepe.ca:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: F218544507B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, Apr 21, 2026 at 03:25:32PM +0200, jgg@ziepe.ca wrote:
>On Sat, Apr 11, 2026 at 04:49:02PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Extract the UVERBS_ATTR_CREATE_CQ_BUFFER_* attribute processing from
>> the CQ create handler into uverbs_create_cq_get_umem() and separate
>> buffer acquisition logic from the rest of CQ creation.
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  drivers/infiniband/core/uverbs_std_types_cq.c | 127 ++++++++++--------
>>  1 file changed, 69 insertions(+), 58 deletions(-)
>> 
>> diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
>> index d2c8f71f934c..4afe27fef6c9 100644
>> --- a/drivers/infiniband/core/uverbs_std_types_cq.c
>> +++ b/drivers/infiniband/core/uverbs_std_types_cq.c
>> @@ -58,6 +58,72 @@ static int uverbs_free_cq(struct ib_uobject *uobject,
>>  	return 0;
>>  }
>>  
>> +static struct ib_umem *uverbs_create_cq_get_umem(struct ib_device *ib_dev,
>> +						  struct uverbs_attr_bundle *attrs)
>> +{
>
>I suggest making a function like this:
>
>int uverbs_create_cq_to_umem_desc(struct uverbs_attr_bundle *attrs,
>                                  struct ib_uverbs_buffer_desc *dec);
>
>And lets focus the umem code on working consistently with struct
>ib_uverbs_buffer_desc.

Okay, makes sense.


>
>Ie as a general plan lets try to convert all the different
>descriptions we have in the uapi for umems into a
>ib_uverbs_buffer_desc and convert that to a umem?
>
>Broadly I'd imagine introducing a new uattr for CQ to pass the
>ib_uverbs_buffer_desc as well so the end result of all this churn has
>the option for every umem to be described by ib_uverbs_buffer_desc at
>the uapi boundary.

Wait, I'm missing something. I'm already introducing the BUFFERS attr
that passes a list of ib_uverbs_buffer_desc. What exactly do you mean
here?


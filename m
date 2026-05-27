Return-Path: <linux-rdma+bounces-21379-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBFIM/8kF2qu6wcAu9opvQ
	(envelope-from <linux-rdma+bounces-21379-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:08:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C58AD5E8295
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 19:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBC11300622E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 May 2026 17:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABA83B0AFC;
	Wed, 27 May 2026 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="ApNO4Vaw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0A915687D
	for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779901688; cv=none; b=OH+RKNfvNeyEf+oWFF5OFZBmsUInth0EeLnQeJfBxXfy/Ond8iwQtbtSuEQlzfdi1v25cMOhQsNJ154BB74Yc3AgxT11yEY2xzWMvudWthT20e8E3IWXsTuk8yN8W3LKQyT6tmnv3SG0Pr4BPciDmJl8aT4Xqb+Jk+oZpC1IDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779901688; c=relaxed/simple;
	bh=hU3NwwKQbVmGOEXbnjlZCX/HGLGerzNVoPOe3Yk984c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5vUhZKZWswn6GnZU/esvTRFNBx12BMILfmmXvD5otlaqd6G1tmU6xCNkH+ldkn/6gq8StD6CO78m1uny5f0yuRw9aoRS60E7TEYudC/WstDi3xTN11A/cvR8awbTXGwWv8KL2cLhr4xiL51khuIXzxlbd5xwM9o5FgbXyPrwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=ApNO4Vaw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49039a8851fso64141825e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 27 May 2026 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779901682; x=1780506482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nprdi52di+PkyLIXBuIbLbCxORB7jXxmsx4y+otFOTM=;
        b=ApNO4VawEs+L/DbyuYPI0v4kTlH0HacKneBUaJP8VG06FNAjM6Shf6itzLKpsiWWje
         MynWJ0tCdEkY1cc07s5KlAnN0xEiasV4/SYFtVp1rRAWqsjFskMc74GL/ta7s+r/Vw1a
         OmwJqw8M5GFsnDV6kME7Wgt3JNvqmskcfxo5gkuQIxuxaldSNIONvteK3/QB/jRSX05D
         xTjM9ZiwgOavzG0Rw1AwA3dSXL2qNHzcLf+8qcLVR0CYvusN2zV0jCGkuE1lbBRR0sX1
         Q0kiqf1AOWDL/HtUhSlgcaKC3pAdmItn53jyZgry/pV0QXlAOhFhsEq/2W8dcNJFvVxo
         xyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779901682; x=1780506482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nprdi52di+PkyLIXBuIbLbCxORB7jXxmsx4y+otFOTM=;
        b=bIIeWcYyJXc++ARgWW0iR0xo5Jb0AOKO5h90QnQ4DJDYoNT4ikZdTnJ5Ksjhnt1idL
         q77QQqMGpYgaeSQ0Ri+CrQB/M7eh27SFYJnqrCeR4C2DKdQnSbYFtmlnvUsxZunAohZ+
         Qw3rnwGPhJX/nXhusm72/55VVT+x43tnIxwFlypI6l1FUEwGDoYnH7xA7IwoyShxFaTt
         KWbWy7olOMxf3TCsekqb7C5lGeYp49Idjyw0EvyJpdofQxOH6MJBJesQKekOvO6J/9Nb
         qkAkHLd7UfEnwIwo5lKrUZPM2ss6eU+XfJuAh/2hv0U9p76A6sjdloUdcws7LZEuh85F
         gxcw==
X-Gm-Message-State: AOJu0YxPXRDUrBlbFZe30cjxqi+eWWgA9cId70UXQ55R/weqxAEkCzdi
	/iQbweIuS7Cv1pzT2AKwH0gUsjhg3S5bR9GVQazsyLtGqmsUWTjKSInNtxIgH8WNI28=
X-Gm-Gg: Acq92OEcOAWqOsYGiTUFItC7tPabEiVE61KrX2vN2qMP39UjYlm84rNgoarSucMR8HO
	akuBulCtJHAl0deIO3t15ehikE7eHNiKWOsLuTGRBo2SdBoy+Cc4QWLeuV57+ZrlM9NRMf/ALrR
	BfqvtJPNffoB0owd+wqyvLRJQSw1gAmJ6+Irm/DJG06onUWos38uCb2Ti+49yUcAdSDurUapniy
	NEjrehTGQRwiVIXgY2A+geOABSQyo1+Y9fLQV4t6y0+ElQEHnI/RrnHkmpLVmEyx5HI0Ye1KG3u
	vg8vlRvqanQA+JxJQ1dNRDalR0U3PMytp8W1IVIwQxUw/AMLJbfTo9tX7p5kQxEXwHMVv+EqSXl
	zRlN+oidY6uB8img4XjAtrUXWH2JHsdB+/0TE7PozoivRjcsjMezhPrvx2MEtlho+DFOQZQjRjc
	u0B+jl6z/Dr9WB1eUrxzMOUgd/jrxbhs4=
X-Received: by 2002:a05:600c:8b86:b0:490:58f4:ba2f with SMTP id 5b1f17b1804b1-49058f4bb2fmr305210725e9.23.1779901681759;
        Wed, 27 May 2026 10:08:01 -0700 (PDT)
Received: from localhost ([128.77.52.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908098f8c8sm21006335e9.15.2026.05.27.10.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:08:01 -0700 (PDT)
Date: Wed, 27 May 2026 19:07:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v7 03/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <ahck2d2pkw-dSNKd@FV6GYCPJ69>
References: <20260526144152.1422310-1-jiri@resnulli.us>
 <20260526144152.1422310-4-jiri@resnulli.us>
 <20260527155031.GA3528738@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527155031.GA3528738@ziepe.ca>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21379-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C58AD5E8295
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, May 27, 2026 at 05:50:31PM +0200, jgg@ziepe.ca wrote:
>On Tue, May 26, 2026 at 04:41:40PM +0200, Jiri Pirko wrote:
>
>> diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
>> index 6a78288e27a1..457c49d44467 100644
>> --- a/drivers/infiniband/core/uverbs_ioctl.c
>> +++ b/drivers/infiniband/core/uverbs_ioctl.c
>> @@ -597,6 +597,31 @@ void uverbs_fill_udata(struct uverbs_attr_bundle *bundle,
>>  	}
>>  }
>>  
>> +/**
>> + * uverbs_attr_get_buffer_desc - Read a buffer descriptor from a uverbs attr.
>> + * @attrs:   uverbs attribute bundle.
>> + * @attr_id: id of an UVERBS_ATTR_UMEM-typed attribute.
>> + * @desc:    descriptor to fill.
>> + *
>> + * Return: 0 on success, -ENOENT if @attr_id is not set, -EINVAL on a
>> + * malformed descriptor.
>> + */
>> +int uverbs_attr_get_buffer_desc(const struct uverbs_attr_bundle *attrs,
>> +				u16 attr_id,
>> +				struct ib_uverbs_buffer_desc *desc)
>> +{
>> +	int ret;
>> +
>> +	ret = uverbs_copy_from(desc, attrs, attr_id);
>> +	if (ret)
>> +		return ret;
>> +	if (desc->flags & ~IB_UVERBS_BUFFER_DESC_FLAGS_KNOWN_MASK)
>> +		return -EINVAL;
>> +	desc->optional_flags &= IB_UVERBS_BUFFER_DESC_OPTIONAL_FLAGS_KNOWN_MASK;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(uverbs_attr_get_buffer_desc);
>
>This function has to go into ib_core_uverbs.c if umem is going to call
>it:
>
>ld: drivers/infiniband/core/umem.o: in function `ib_umem_get_attr':
>umem.c:(.text+0x783): undefined reference to `uverbs_attr_get_buffer_desc'
>ld: drivers/infiniband/core/umem.o: in function `ib_umem_get_attr_or_va':
>umem.c:(.text+0x82d): undefined reference to `uverbs_attr_get_buffer_desc'
>make[3]: *** [../scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1

Correct. Already fixed, sending v8.


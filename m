Return-Path: <linux-rdma+bounces-16464-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCRxOJMXgmmZPAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16464-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 16:43:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F91DB6C2
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 16:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 959B930C8388
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 15:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118A53B95E0;
	Tue,  3 Feb 2026 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="u8Oby3k6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66832DB7AE
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133201; cv=none; b=OuZsz9Zc3SfS90P/aVZhaQaGAGcDj6m0LPLOzHVichFlDrXggs9+wlycVnvu1Fb7bJfKGuZu9WuyLgS707U5thpETT7C5Sq9pJG5gsV4Hkmj9TjaCPCL92pkRVSgscsIE+Hyt5jgHe5w1Pv4HXXm1Wh/rXQ2k6PH1g0RHz/c4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133201; c=relaxed/simple;
	bh=BXNa0qws6MxOwhe9m25wg1GipVtc2y/ksKNrHKx3k10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEmkj5eqe+4qHzx0Th3W5hKYVeQwB4GtCcWaaadOkz6+9EhMmybEeYh8jl8KEIyCf2FSOH6fNq2txbNCja87m546rFM7r1LOAmEtz2VwTCHKcRQbEJ+aeBU+W36L28IxHXoJSlBya+/GtZ7rxDaKsIdTF9eXaVNKsF0lcBZHGC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=u8Oby3k6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43246af170aso608922f8f.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 07:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770133196; x=1770737996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LazFGnb6TEq5mUA8faEVJ27Tyt92KP3a4oc7y3ITuQ=;
        b=u8Oby3k6CkNbb+zbD53YWPTkWPiK25TQH9s1sC+m2Z2aLffYEUpZmr8WU7vTEVir46
         dB76Ttgh4nvqK0u7SqvcOFB7LlvdukaJmPXrt7D/qov+lQUoYtiBvNAXSLjFydDYmUpu
         pNIOkW1f3CifXbQzs3setG/c/mgrBHXjFACYEMVUgYPQ8NrXF0y6cu/xa13GOfOGKsiP
         UCWa4i8vxhDzClafa6eREaWSg6nCW9aIrRIyme/U8wWhhvarQSCSiqzpOFDjK+ByVYv0
         UQtr9l+KqKY7HHHIbOBb9E5TN5y1w82XXRxV3i/0Tt5jGxihKKLs/63d0SwKpfm54WEB
         3kIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770133196; x=1770737996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LazFGnb6TEq5mUA8faEVJ27Tyt92KP3a4oc7y3ITuQ=;
        b=OOZlAIzdU0ZRPAwSMcAMfwd9OzaISYTHDh5l+IN9s8s1YT2Ncj6uZUoyg6Eh6k5MLz
         7GvGlKjZyZiozwfXgDO6IBXHS1B5QVHcR2x+zwOPPp4sdywCga0TRai5/5DIK4QM7n7p
         47DDuE6CQ3b74cI+UweQWZOiiitTTMeyzBH9WI/rQaLOV83loG4AcIvh8yv2Vso3pNSb
         XuNzmE8ejoDL+lzDm51/u8WgzrdhBMd0A9XTGiukZs0Gdyx60TT7v1NGhxWD3QJICZIi
         hVWRv4oEb9MQJ9mIWCwnTRgUlqKuAarIqUX6oRAF3sgT8kb3fSwSBfm+ArTiAN3Go74Q
         v85w==
X-Gm-Message-State: AOJu0YwjdQJdqSD7DE8qyNFD+E3YSoRFhOg8KAPfMv1ZCIQJkqGzFms5
	+t0nbJdf/9LdCVoylPi7rVPL0xcrJnxQR4LjP0gV4JrfVX+YZJuYaeZPriTdArSiXtk=
X-Gm-Gg: AZuq6aLugZb7Jd8g31G3r3fP/0JMGJC204M09tyP+s/cXh8a+u3o4AduzGfYzA41RZy
	Ug+ccvGJ38+/BPbimrKCrf0ER9+stUwFrvzZbGTkvHx6qE+RgnXiqJi6lOi3m1j3hyzypEC9ipL
	MuKn7+f0zdJPLs4xhFeBkMCw4fZoC9QevArZZGnbtsprKgm/R8CEJWFyNL5QznWxDp/3GVF5laC
	fvoGkXSrhtVCYaxBE3vXmqZXrgeMqOUt4h5Iwi+0t95TEXdLsqQL3I+MPX2YcQXVyrWICDbq4sQ
	rVOuc5Ad/abDfokcDYBpy5PbWodJ82PpWNXS2KZ2/b0lkrcW+l2jTm5RvtrqraKOfOLkhcZFsY0
	2oQZ8kZuymCEpPGg5J6hU5XYMpMkDuyZdsGT6HoDyHtUd5z1soWRd8Y2ssiJEt7GB+ce122PxGz
	T0PQpapJLPMp3KLcDe42xm8Uc=
X-Received: by 2002:a05:6000:4028:b0:435:9144:13fe with SMTP id ffacd0b85a97d-43611453d48mr4324985f8f.26.1770133195972;
        Tue, 03 Feb 2026 07:39:55 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm50496207f8f.17.2026.02.03.07.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 07:39:55 -0800 (PST)
Date: Tue, 3 Feb 2026 16:39:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, wangliang74@huawei.com, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <424kifntiluu2rrsqea6k3aatduoqemjccmsun5z6rvx67xo43@6q4t3r44ql3e>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203145138.GQ2328995@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203145138.GQ2328995@ziepe.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16464-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 39F91DB6C2
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 03:51:38PM +0100, jgg@ziepe.ca wrote:
>On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Introduce reference counting for ib_umem objects to simplify memory
>> lifecycle management when umem buffers are shared between the core
>> layer and device drivers.
>
>I admit I have reservations about this too.. The flow should not be so
>convoluted that a refcount is necessary. The lifecycle of a umem is
>not uncertain at all.
>
>I imagine'd it would be like:
>
>core code:
>  if (ops->create_cq_umem) {
>     umem = umem_get
>     rc = ops->create_cq_umem(umem)
>     if (rc)
>      umem_free(umem)
>  } else {
>     rc = ops->create_cq()
>  }
>
>Driver:
>  create_cq():
>    copy_from_user(drvdata)
>    umem = umem_get()
>    rc = driver_create_cq_umem(umem, &drvdata))
>    if (rc)
>      umem_free(umem)
>
>   create_cq_umem()
>     copy_from_user(drvdata)
>     return driver_create_cq_umem(umem, &drvdata)
>
>   destroy_cq()
>     destry_hw
>     umem_free()


This is how it is now. However there are couple of challenges about this
flow:
1) umem usage. For example, create_qp_umem at the end of the set gets 4
   umem pointers. sq,rq,sq_dbr,rq_dbr. Some driver may use only one of
   those, 2 of those, 3 of those. Depends. mlx5 actually uses 2 or 3.
   If what you suggest, the current approach stands, the user has to
   always take all pointers, store them and eventually release them on
   destroy_qp path.
2) error path. I found the error path quite odd. Then create_cq/qp_umem
   returns !=0, core releases all umems. However, standard cq/qp
   destroy path takes care of releasing umems. Since a lot of code on
   error path and destroy path is shared, it has to be informed to
   release or not release the umems. That is not nice.

That is why I tried to make this more elegant using reference, which the
driver takes when it takes responsibility of the release.
I admit that if the umem_get/release will not be possible to do in
drivers, just core, that would solve this issue in the most elegant way.
That I why I would like to wait on Leon to do that and rebase on top of
it.


>
>This basically moves all the working code in the driver to the
>driver_create_cq_umem() which *always* gets a umem as a parameter.
>
>If the user uses the drvdata path to specify the umem then the driver
>helper create_cq() creates the umem from the drvdata parameters,
>otherwise the core creates it from the common UATTRs.
>
>We can keep things so the umem is always freed by the driver on
>success, which doesn't require any driver changes.
>
>It should never be "shared", this is just a very simple unwind on
>error kind of pattern.

Not "shared", more like "taken over".


>
>I think the challenge here is to unwind the drivers into the above
>three functions so they don't have a mess of convoluted error handling
>around the umem.
>
>Jason


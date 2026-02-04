Return-Path: <linux-rdma+bounces-16537-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LilNPOFg2niowMAu9opvQ
	(envelope-from <linux-rdma+bounces-16537-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 18:46:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 777F1EB1A1
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 18:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FF12300C0EF
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7740438B9AF;
	Wed,  4 Feb 2026 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RF3xkgC1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBD34CFCB
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227179; cv=none; b=Og85LpVt4HU5Qw5rND5TBgr5kc8CO6/fqrv+KWcJ0zJM8yqWAfM0eb8DROqHoBJ60e2mJ1YCJn0NVupH+nYou4XwxgZggLH9WbqDTKvLs4Tv9FQM6GU5nCzjVxEE8aiaKZhHxTyNFa95Ebwv7ofm8sYKy2KV+d3CtgKzlLBQyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227179; c=relaxed/simple;
	bh=9QuWAxkiWxjGPzMHNv8b6l5nujSSH5qIU/sHA3i4MAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUNh0kB4RtlfG/zr7CGNSBRhMv/L5EuGqKsKB7hcdEsxE75idpsTxZcWdXtVZowB92MOdXxIOS0fRi+cT3jB5QQX901p3MCuf8BNLeMT6Akxg53I5kgm8u8JS+YzMN37VavQtVhtkRU1g9xDqyS3BffvDWOANQFo3LjXvGfZiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RF3xkgC1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5014600ad12so637711cf.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 09:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770227178; x=1770831978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLAqKui2g+0PVyg4ZlSb0DSydF8HR2bawQMMVntyQ/A=;
        b=RF3xkgC1XCIm0HO6l6ExcV7mRo306oMIWMlz2mKcUA34hqmotH/uAi72y5dM4fo7dx
         IDVThOaSYNBhMH6iWIGlBb07FYQcaYwdcCy1wpcrASBkG/rP8b6z4Y5vYJ8VhzuL7xJo
         +l67KQztKkhmN71vRno59Ox3AS0lttLYqqAXxauyqIqZ1dPuxY0/NN2osxZXreZVsVsI
         V5dY0GBSbgntp4b3v8kofPlIKmM5HrQcOuGxQT5RlwHzQ8D4YsD7R6NglgjWO/aIXRg1
         gramXSeDzwKHLvDjtLUdyXQlAaNCFl3pwXSMrd8z2LWmU3wvu54K8wCQ0w1Ve+sersqZ
         1zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227178; x=1770831978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLAqKui2g+0PVyg4ZlSb0DSydF8HR2bawQMMVntyQ/A=;
        b=iur+Z4tQPO0Ok0UVzN3xashldwjsDrxHueHy+HYxfkT8taKfnvRi1wDQeZWysTuXag
         qe6/OMrnn3oF4iCp63m2qSQZKJv254Sqi91zQLlRSENXqcvPhe5k7bvkmAsH4gpREJMN
         DtO++PymtjFCQygs+EnIlpvOg17qszApXIqC6g55RsySaHYSGtxKWiIPTaLdkaDi+IJ3
         QjzLkrHK/uiJdiAnKUHS3nUNFYyoTltnjTBW4EMlyzS2mNF1d9GAODlJNg1czR/zdIOG
         Byjg3MSFRJdXB8AQJCvPhtRj+iSRhHHjln6vU8ptrZvPqKnInE1iAbm7q0g99kigR0DO
         KYQw==
X-Gm-Message-State: AOJu0YwcvNaAt5+5Yx4uiO6Xqmdu48gqeB/cWxA70vIigtapwPzLFMFY
	W1EOHrocsQLypbMLtxp1VPSk6u2QDjVdqI1WSte2ZwIGaGS5HNOyaxNZmwioypE1TuM=
X-Gm-Gg: AZuq6aIxyG2R/+U6LBC//Qcywx2xTOeb3IFBijiF8ftp5ptijAQ/a6kVsGq+u3/Ig5o
	3+Zuj7S7tTkDIWuZBp7FhvFNabDEjRAaSiRWA+u8bjQPbfg2fPTd04cYs5YoHgZBTepm06dRsnV
	vcUm6qgVD0OXDGu3CLX9Pms2SZBL0BWoHd39to9d4CGt7zRNb9LTiwGNMBfUK5tie44hVfCjnaS
	Y6VDN/LO15muEdCX3u4bfhNsCxymyHWVACyn2s0RBm/LNNAEa6Af6Ktd078JikettOTXUNocua1
	IeFoSzUM8rHZJJsoImd0jG/qQhYZNk8aNq47TixLwMyTbSLxiPAyTwb7tC6DVNa7Z7lP33aVYyb
	/TsOpAj8p6cW4XPhBlEBmX/WlHqPk9t4U8RyQL8KpTOz3vAph7PetoCZRupMOiv1ps42lKwYd+Q
	r8K1LB666psjHDRKst208dRtxNFsqZmrCFPzDBV33j6IDKjsNSKS7C4m3h5AkJ2N9a8bw=
X-Received: by 2002:ac8:7507:0:b0:506:1edb:2cf6 with SMTP id d75a77b69052e-5061edb2f8cmr23776871cf.49.1770227177638;
        Wed, 04 Feb 2026 09:46:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c20b8f0sm21145181cf.28.2026.02.04.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:46:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vngxD-0000000HJwM-46fL;
	Wed, 04 Feb 2026 13:46:15 -0400
Date: Wed, 4 Feb 2026 13:46:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to
 ib_umem
Message-ID: <20260204174615.GI2328995@ziepe.ca>
References: <20260203085003.71184-1-jiri@resnulli.us>
 <20260203085003.71184-2-jiri@resnulli.us>
 <20260203145138.GQ2328995@ziepe.ca>
 <424kifntiluu2rrsqea6k3aatduoqemjccmsun5z6rvx67xo43@6q4t3r44ql3e>
 <20260203165938.GS2328995@ziepe.ca>
 <q4cc35lcpl2xrziu7c7hkebib6mc4bnapztckk3duzv5uzyjv7@f4nqhsi57wi7>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q4cc35lcpl2xrziu7c7hkebib6mc4bnapztckk3duzv5uzyjv7@f4nqhsi57wi7>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16537-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 777F1EB1A1
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 04:38:22PM +0100, Jiri Pirko wrote:

> >Generally I would not assign to the driver's umem storage until the
> >creation is completed to avoid this. ie it stays null until committed.
> >
> >But looking at mlx5 that looks like quite a maze there.. Yikes..
> >
> >So maybe mlx5 adds some NULL assignments on its error paths and less
> >convoluted drivers can use a simpler option?
> 
> How about we have:
> 	int (*create_cq_umem)(struct ib_cq *cq,
> 			      const struct ib_cq_init_attr *attr,
> 			      struct ib_umem **umem,
>                                              ^^
> 
> 			      struct uverbs_attr_bundle *attrs);
> 
> And instead of taking ref in the callee we just do *umem = NULL? :S
> 
> This would help to cover the error path vs destroy path differences,
> Tt could also be used to make sure the op consumed all umems; all
> should be NULLed on success.
> 
> Makes sense?

I'm ok with that, though never seen the pattern before. If the core
code fails on !NULL it would be pretty hard to use it wrong.

Jason


Return-Path: <linux-rdma+bounces-15713-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D291D3AFD3
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 17:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C7FB309670F
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EC61F91E3;
	Mon, 19 Jan 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gECYWQVX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6F38BF73
	for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838202; cv=none; b=KmLYgyrPsz8/h4Cg3Dcsi/efoCNU0MIxVQ41XuZNGaeUkC1kZfiBELYR2JgtoGp7iE3VQ8/inoXNV2WDTk835XgZu9HipAGL81TdoAqbEWAcwUmJd/vinir4iydLonj48LoS0tfUEdX64bZaj5LuDRRWGCXCVehePfzSwP+4Q1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838202; c=relaxed/simple;
	bh=2Xxc1Uec9Btausmle+BpODuK6Jk55TuTcNypc6J7udA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJzYfO080dldVrUd8+H/lmH9DPcYGDJ2JWFfVtVRBndLDkWRuROpK6Q3/HBAdfruCpoaXCrLXsHLa2VN5Vtj1NG9mgWDz9Ob+Q//CIe+8oNC6EUUt8dlsgsxINzxKcOgQgpD8Pn5543JpSxJd79+tib+mmP2o6+pOZlvJSLr6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gECYWQVX; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-45c8984fac8so1313944b6e.3
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768838199; x=1769442999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xxc1Uec9Btausmle+BpODuK6Jk55TuTcNypc6J7udA=;
        b=gECYWQVXXstNM5TTbqDJI/yc/OlcHgkOehyrE+cZjGxEzkV1oXImAFYkn2/VqmVlal
         6vSTLLzSpVhdvmpogxy1w5npWXqJEOVC+BSzymsxefF/Asvt/FnXVUZ+VcMA9BR9Qb6c
         8wytTlbd3ivdBXGvTLj12MfTPOZYuKDx6YmjKEHUPCwurzrfeWqA3hhWxoUxOnE7/3E6
         QJgiTRo97IasJiSrFpFLGXb4DifS9M+Ox2RaXAHBS2v2I2i0GFdvrUKX821XtpDgpekV
         gR7W+j8nSGJIW0X8JBD5qmd+m1eW5b3kaOVv25A7FZ5p00PYB3UuPlewAbCnrhuQfkMq
         4YdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768838199; x=1769442999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Xxc1Uec9Btausmle+BpODuK6Jk55TuTcNypc6J7udA=;
        b=rPkExwBXAvzZ/E6UG9EjZoQVgzdLb5VrV6hPE+iILD+d+aGqZBFpurcoJBhOhHXL/v
         kvqNpeqF8LcUFY/57WIf/qVp9OuU9Cg4k29gXLrIsPpHpZUdqJ5Epu3EuZ1Uw7dI1jFP
         rEsIxIVzySiC03NEbNlllaznkkMJiOk798UdAXjAiRY+UccvH4SCicr/R9Nq2DsDM74L
         hQBANUuIBt90yBAC5Y3mlRM9+KbzBt+4hmP+uP8dMW8pUywUDCCmU1IFkgi2W+PxnH4W
         Ork28GGPisdXYhPUZlU53gnN60CqKiOYVv0v+AR3TDfs+/IRn/gvqOPnzxebaIP8scVU
         4v8g==
X-Forwarded-Encrypted: i=1; AJvYcCU9bsJw7Iuer/nnjIvWT0eyU1nFVAwXVgbV+S8Hwr0a2poFP8zV4lSigqiXuJzl6I/R3zjDfDuU6BHS@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2zOgAeYzKUdzC3A9bOjLlrSALfGblojURn0MDvSJSyebD7H2
	S6Tor5fkcLvBTlt2iYe+124xNi9Q7fXkIJ5YFpI23nDrupgKBbhs7JlOw3E1nhdX/3pe0o+mZK/
	wuSsjqX5DwKp421hDIdJ1rYUOtcbhSbcBQisdgYrP
X-Gm-Gg: AY/fxX7fpOFznmKHGTYKYgoqBrIjDInu14ClGOmVFiPBSUw6YZpwTJMe6+KUSEMQ3f7
	kvQOe8HW+1e4CI/MrQHLzCwpTi2wTeYRCx6Nd07rQbjnusLiR8sTILfGidWNU8ecORm3RbQsnJC
	xypOMD27nE3dKYHawRffblr9rQikY/eNaNzrEW6gAQbwbtA/ovrj7wxoPPBQXIdo9l5MWv5jEYu
	r5KNNk1QKtNRI3CxeOpO1Ima/fi0Vv/TwH+DbBWBIwQVOQZUPWnbWNpoIcELnA0v4OO0Bwm
X-Received: by 2002:a05:6808:5086:b0:455:db31:a680 with SMTP id
 5614622812f47-45c9c3354demr4667721b6e.63.1768838198402; Mon, 19 Jan 2026
 07:56:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118012500.681672-1-jmoroni@google.com> <DS0PR11MB7736349A3D51CDE681CFBD4BEB88A@DS0PR11MB7736.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB7736349A3D51CDE681CFBD4BEB88A@DS0PR11MB7736.namprd11.prod.outlook.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Mon, 19 Jan 2026 10:56:26 -0500
X-Gm-Features: AZwV_QiXC8Fw6aruxq2FjLPEHt1-l7eL6DWDam3upK1swEFrfJ1VQfvlVdlDX5M
Message-ID: <CAHYDg1QRh5dGd6B5C0N96PNkXzKguTNggQzFcbaw6PtCAPVTQQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next] RDMA/irdma: Convert QP table to xarray
To: "Czurylo, Krzysztof" <krzysztof.czurylo@intel.com>
Cc: "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"leon@kernel.org" <leon@kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

I agree that this is a small optimization in the sense that if a system
has enough memory to actually use 1M QPs, the savings here may get lost
in the noise. No worries at all if you want to disregard this patch.

My rationale:

I am thinking of CQs as well (yet to be changed over). In the case of
a NIC with 1M QPs/2M CQs, these arrays end up consuming 25 megabytes,
regardless of how many QPs/CQs are actually used. This is of course all
multipled by the number of NICs in the machine. It's not huge, but also
not insignificant, IMO.

> then system admin can reduce max resource limits

There may be a decoupling between system admin and user. The admin
in this case may be passing a VF through to a VM that the user owns, so
they can't make assumptions about the workload.

> Finally, the xarray was intended to replace radix tree. This is not
> a vector-like (dynamically resized array) data structure.
> Not sure if this is the right application for it.

It's just really easy to drop in place of the existing array for cases like this
where the array is being used as an ID->pointer map and the IDs need
to remain consistent for the object. It seems to be the go-to for many RDMA
drivers.

Thanks,
Jake


Return-Path: <linux-rdma+bounces-20033-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIRhHDU0+mlLKwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20033-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 20:17:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D41984D28E1
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 20:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0CFD3024A3A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC8847DD67;
	Tue,  5 May 2026 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjijxrqB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEB2EDD58
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005040; cv=pass; b=ht/g0mUQDq9op65KULz0Bmc3jUnfFF5IUeyT0RltSwgCeO6lmm8awADQypZorYOl6m28syA+yDT0hMS8UuY4xr814A5vAdN5GZ1WCitxJG2o5j4JfGz+YmnF3eHEhW4y+57rctS6moH0+uitIVyRBfaW4+dzUTRH969LNuPUACM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005040; c=relaxed/simple;
	bh=cmhqILGEd5qLLh6dNDNKgm7aiTK4wKmiofSyHUHPbQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kp6Wyw29GWYre7BHOsaqliEdtOXvahq/aKjIGZkGILIxV+C9Wr96IyFUXOcjSlFIdUcI9NEszd2IGUqhFsaLxKhooSs+9Wf7WMSZ3AkGtSSMqtjMgxBkKNSzHhX+zP368OC8N0yGSPJs9+5Bbt66Ai3GaPeNWF2CeHSx3mbucWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjijxrqB; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-479d68a9063so1958091b6e.0
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 11:17:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778005038; cv=none;
        d=google.com; s=arc-20240605;
        b=evlQfKpKLKXbUYMy+dPZxvBzxtv4wRWO3DJ7/VEds3bewdc0c6Y3xGHnSICklivGJc
         GbtN2P6rqoFDwk3Wlr1HWSnHQlzJr8NVgpwhtipcBvGBo6csmXK1ohDZvRc7cryth6ER
         2sBdLDy8epOi+kB2HlCGBTM2bVVmTjeaK8XGsddkWJ/eyNySz01Ko8qo+sBpwBwNF//5
         Paf8kdayBnVeTdLWzB4WPnyEN6HbKgq6l3do2BmKZQDJ0xcrcbcyBaR5FtrQbA7gfWyC
         Q5ItJk+hzRVF+3Uo8IjpZpmghGLFZCqFUHHIuFqNd9+Dfw1HbLM5MlvPxmUBYEUeZtru
         NzWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cmhqILGEd5qLLh6dNDNKgm7aiTK4wKmiofSyHUHPbQ8=;
        fh=dkNVL9g+XabVGerQH+wrcQr313lnS6FS3BgoBec7XfE=;
        b=TZt9wqp1VboPtIFJth+yS17vFAGZCDICIxje1SxN30USb1IzamKwSh7C2nTo9kHgm4
         m4b4d7NWKMLwxHyQ7gB2ijQbtAAykoa7ETNOaaLnZEKKEYYy/wHiZu9jVf9t6AAobJGm
         Y6nWlLniieg39vDnRA6ct2AMPvYJZ5gM/unjvBmC1APBZMAmmmwt76xCTLncfYPNL1o6
         wea2Op5/Kwgh/wCelTI0Cd0bpw7XAnAwUzJxbgeV8eFtpYtb89bUVkOY4ym20gxxof9u
         osRcAOQA10rY4T5paDGRu6TZK7SfByh+zyG7HgqeYPhVv/3i2w52YmVnKpQW+T2oOPFt
         CSLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778005038; x=1778609838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cmhqILGEd5qLLh6dNDNKgm7aiTK4wKmiofSyHUHPbQ8=;
        b=LjijxrqB2AaSBN6x3rcmXh+smj+t5vaz2DPi3qXuk918US4T7u18h7qTkB64y7Z+7E
         fnouMTR8dYqCUTO/G2pui18EvU5qShF2TG7OJPV7FRfW3TS/z3lzwbEcqEnd5i0PGOUV
         Ed8rFuCuSowGGsJGzAeR+Nfp4fSFFLXUKrWQd0HQbIcCoaHZWvoIXnL8NapKbG2DwTt7
         9eUlK9OGYABxFVUayCviND3g/hmgRjMTlxyaQ+W9elTCmwdWkAia3BMRt1MHFrZdRDS+
         EAvR5PY4ZSCaznkLrgh+THi7528FihHudC9YhRsJ4bnJcQ2Au4hHtG5pZJuQPnw3UX8p
         VBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005038; x=1778609838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmhqILGEd5qLLh6dNDNKgm7aiTK4wKmiofSyHUHPbQ8=;
        b=XMdidY9Xjtg7U9zFxi9wByJThw7CX76xBTBVVawULEf5cQGUmm++mrcBIOvxWgNy73
         PhH7cD8i04nNj4T7g3mVDdvVEiNI0m7tou0N0MXdOcbGaVeQk6A+M6y+/Nzv8o+zCqph
         0N8WbXg8AzjZFYmj53+7qlBh4HIJY0BDAyBt5WD+Aox+Ypvb0FogTs9LG+W+3OCP8QTy
         HYxOpuQeCJZdSOxnDHBHvlN8OH5fzjFdWgEoNS2GAZdsF1AMQ176si178Tya3EnROX/p
         UIYgjEhPmxYx/PiN+D2oDAyocozVkJRZccBMgP3MoRHEQu/HlUx7WLpga+DGZfMW8Yvb
         DwPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jvSergXpc+FOs1RkttDCzBZtLeR7cGmBAYdWYB4juTyQDMbkSgS4NroqAGy303Ihi5ltcyiFfP8GG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuj2V3BYH9RD/cs5EljONiKXFTsPO0BX81ssUZLqDA4rpmJs66
	+yNdxNXrTXVoA2p3jsLycEjsGrsCliUpcdNXfTDYfslwjTsdXv8jxt3X8Q4ncNORwUjn06w5NB1
	YUtrLZUXqwMlwATstVBoM8kthaF9ES+3ox0nnzS9C
X-Gm-Gg: AeBDievjkKzB4ygZHrmFM+Y041vJmAf4Wnq+U7Vrd9sm8GthHunZ+D1Ok77tX9Ynfwd
	rzb/HdN1b7qZscuDeM594mA1Q20R9xeFSKsTKxs4xWg4o0IjPSqUpsU0CRB93UIlB5zr+VpE0UU
	8KB2kuECQsNTMWYvgPjyy7f3vZphm+iXSyf3MK7V5+F7hYcnyMC3zkiHHwSTEavvICMkFBflXgn
	xmUWtDZil5ugcJ5DDG72b8YrLNyStfU5HTp1hb+ekeiTnmvImsAocyt6ulcLKJM34edm0FfXX/c
	aGj5xxDQQK5SxhBsm8rMkVo56X36sg==
X-Received: by 2002:a05:6808:e642:b0:467:1c6b:ee14 with SMTP id
 5614622812f47-480424c8fc4mr73825b6e.33.1778005037983; Tue, 05 May 2026
 11:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505061149.2361536-1-jiri@resnulli.us> <20260505061149.2361536-3-jiri@resnulli.us>
 <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com> <afoUqiDgZmhE4Kog@ziepe.ca>
In-Reply-To: <afoUqiDgZmhE4Kog@ziepe.ca>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 5 May 2026 14:17:06 -0400
X-Gm-Features: AVHnY4KeUiplxxSrMAX_m4bCwvyjpFsBT4HFUs9fVOkaXTFfVwqhEC7xy_LUTYE
Message-ID: <CAHYDg1RpqHxz_hYzHvsYzPpHG-WQA+7L_OPauB2DTuSJTuq1ZQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org, leon@kernel.org, 
	edwards@nvidia.com, kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com, 
	yishaih@nvidia.com, lirongqing@baidu.com, huangjunxian6@hisilicon.com, 
	liuy22@mails.tsinghua.edu.cn
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D41984D28E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20033-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+]

> Jiri has been looking at both options, but kernel side irdma must be
> upgraded to accept a dmabuf for every kind of userspace memory.

I think changing the irdma kernel driver to support dmabufs for the rings may
be a relatively straightforward change if we can adopt an approach similar to
how it's currently done using normal mrs (which are explicitly registered during
the QP/CQ creation process). If so, it may just amount to adding a ptr attr to
pass a struct irdma_mem_reg_req and using ibv_cmd_reg_dmabuf_mr instead
of ibv_cmd_reg_mr.

Thanks,
Jake


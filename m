Return-Path: <linux-rdma+bounces-17185-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLqYFp1jn2lRagQAu9opvQ
	(envelope-from <linux-rdma+bounces-17185-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:03:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A175E19D90E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0ED0730314CA
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 21:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD15530FF3C;
	Wed, 25 Feb 2026 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/NCCRYh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165B30EF83
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053348; cv=pass; b=LLV3UxCqyVmIEBn9KKhPrxmkAkcesHw6lqw2Ous6U55dZ+oyy6/5sCslR59Gp2cEoBzdL8+L9rObIZk8jehVs/4K3KXKTaSmvh8IaAB09xp7/c0oLPHv/eU5M349+KkAHmYNFWilwuNH2m8pric6M2P8dISgLSedqTcmNeX7m4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053348; c=relaxed/simple;
	bh=86XqXdLsa95eHkwl12oTbaX+rhJOKqC4WvGoajzjuko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFKL4MZOuzQKP0ZzvJGesVyGniKaHQ2yNYGc0pr90f0qIIppSvP+TUDsFTOPNdlXVn6pzTWX6Rm83NpjtEOjSIQs/ue7+8pYZcJe5RDPCLF7byl+D0RhSghZTA7WTnH1EWDvPM2msaHeBnoqZVaEyZ+LD/u2BRgktYtBjeaAYwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/NCCRYh; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b885e8c6727so30491766b.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:02:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772053346; cv=none;
        d=google.com; s=arc-20240605;
        b=CbPugPzjnOff2rDHCmMThI4gjpZ21gLozGGFTIbKGuLqQosw6OcqJ9UT2rLwmnjvjc
         eaydrC8u8zZV9GuuqR+lmI5u0HIEW05MgvnfxbjYHWIeTkfmp2RGHtGYYM3oPyUo9Juh
         4s4ShK9bNlk+o9hlXCKZsYCCpDylIyHduPz+lSMGHSHPE7pS2ptgwhuYTysBzzyWg5Fm
         2a+9KN6EwBx3YYtmuHVCngDRqdXof6PpWTNNnA6VSSRFLomwJ2ygWbuiOy23dw8qNJxK
         SpM2DEwnbuZ7jp2C8RXixCLYjeQoA8/BOUW33ts5TYBMAfZitjk3eI+oXcl29xzNYCQy
         l14A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=86XqXdLsa95eHkwl12oTbaX+rhJOKqC4WvGoajzjuko=;
        fh=geCFilUaPSVTYaI72nf4KKQ4vB1y60tEPvdd1I84WaE=;
        b=XtrybF2dGtQOs5Evik6Wpi2onbYBiliAMneR4mgPKPR62sqfWbeG/H84+pEp9Du0lw
         349YD23JcvVXBAtGlwZT8UteC6ynBV0gUnj4mEnvNpSxa/jH/K5+QkK3aux9Jcispqod
         faNwNa9bHhGsZnA/ftNwy78UpdJ0nVgxbBVw97wWIOV14rYso+PEYLDbwIP9qO6O0IL5
         DIzEZjUtqL8XQxvGJ+lWIFBymWJ8LlMrIY9IZGN1nMJ4vLeGZ9HDfP9xP4z76OS9FTwJ
         WKLdC3K9ZBaG/2FUSuz6MrasYgLm/DSqt4BT5DJpvo3JsopBqLC7CRypsTQVJyYPVMhs
         mOlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772053346; x=1772658146; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=86XqXdLsa95eHkwl12oTbaX+rhJOKqC4WvGoajzjuko=;
        b=I/NCCRYhBc4/0e4eqomSy4AXiUvAvj9mjuqlEvl5fGlwkpN7I+lUJ1sd/zlydNgD+i
         OmFqmio2c5XsZS4ezulARdm1/wJ+Jk4IXMOFDbx7SWcl/u7LsVcmiQ4zcZ5cGYjgw9+Z
         wsC4A1FKtuOen12Ju99V1G/E3fDuKLK0ij/T7Tm98+AdAdCqcdAT7rVlTggMszOVLbsO
         thLsL/BKJQy7BC6TJcBarHadycSI6SHvaphu8sDDv4Ra/P7TzmHF4PZNN8sAq2f/Bwac
         EpuqdgtOHf/NLxqWg4qfSEuwCMUTb4y6Pi9CHpuBOTVGy0kgJXRfC5eBRNi28W9XqHkN
         o/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053346; x=1772658146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86XqXdLsa95eHkwl12oTbaX+rhJOKqC4WvGoajzjuko=;
        b=JI0ePYB6CiXjo6gf+Tcq+wybQ7kb8bnANCvtz1O4HHrSUq+UbJi7S4LYW31Ef2ZjYT
         DZveApofW4Cc9IqFUyyjeZuHkdZYsBDNYyHtCJCTYjZ/17cqUTfIlEr+BE58r6468Z22
         efOgRMaUWkdMbYNpN5HAVB2iQo5aXW3+xYxl0PHjwJTwYYKZEWX7zGuVVk7hM13Qp2B2
         Pul++jBpQj1onSYISiKyFOc0gtHeUN4Vl3VjWjXudPjEvmN9UkFP4Nnm5HUdTn/B8y8V
         4BwoLx0mFAAJs9txBz8QFyNW8Ob4xgZmZ512Skq6DoiotrqlU5dmkbTI4ERScSU5ZOqv
         ew3A==
X-Forwarded-Encrypted: i=1; AJvYcCVhcyR5/ToowmrvsPAZHi0dNubVSuC869elULXpfgQPGYNUB5ubopMaZVeoE88/7Whgg3MZvyE1b07+@vger.kernel.org
X-Gm-Message-State: AOJu0YyaG918h9q5NCqbf7PeSAkzwgAE4BVS46Tmzmnotcw8JmcOYwuh
	kTHdMu4CHEEsFxqXBtwadATID701L9c648ApiGmUQqP6SbHaXeGDJfFwi3INTxLTypjm16osiIE
	hcBf1jlbm8BXPCBduQmcWpumzfqIcoSFcklkup2VExvpXi4D9tzL7pxC6
X-Gm-Gg: ATEYQzwUomq2vZgn8Vh7ScEcUT76I6dDdlbmIUgxiit40lqjqGV+glqZ8025SCGj1dv
	xioaogSpvnlqpuB5CwUj0W83qdQhJjrSHsg2NmtGWS3oY9sKasB3BzahUcTSwQf1FUY0xnSEajl
	Y/or9HFm2K3wDuKJASJVoWOt06yAzmQvbo/fUt/eu6bY1XropR0SiqHGjFjZKKxjWpCjopAhVT8
	SND8Z82qvJQHQY7CeCd1gqmi2gCMqSQcZ2uoxRzmINRqnquM9FwFYp1E38K4dFmircfA4RPkg3o
	VUYGBIAZZF9/wytrBW05hsQlWnyBP6pw6t0Z
X-Received: by 2002:a17:907:7ba3:b0:b8e:fc90:7119 with SMTP id
 a640c23a62f3a-b93572b8103mr27022366b.30.1772053345326; Wed, 25 Feb 2026
 13:02:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223195333.438492-1-jmoroni@google.com> <20260223195333.438492-2-jmoroni@google.com>
 <aZ3zGrWl19jrlL+w@ziepe.ca>
In-Reply-To: <aZ3zGrWl19jrlL+w@ziepe.ca>
From: Jacob Moroni <jmoroni@google.com>
Date: Wed, 25 Feb 2026 16:02:14 -0500
X-Gm-Features: AaiRm53v9e8rs_ERVNuqlcZAXfMoBLg-OfPxegN66UOtwi8yK99i9f7PkizkNkw
Message-ID: <CAHYDg1SfKfVJk2SOjxWD0YkaiZE32Z2PxQZcE7VwenTWif_Tgw@mail.gmail.com>
Subject: Re: [RFC 2/2] RDMA/irdma: Add pinned revocable dmabuf support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, leon@kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17185-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,209.85.218.44:query timed out,2600:3c15:e001:75::12fc:5321:query timed out];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: A175E19D90E
X-Rspamd-Action: no action

Thanks for reviewing again.

> Is it OK to call irdma_hwdereg_mr() before this? Seems really sketchy

This should be okay because irdma_hwdereg_mr won't be called unless
is_hwreg is true, and it's initialized to false when iwmr is allocated (prior to
the callback being registered). This will become less sketchy if we use the
approach you described below though.

> I think if revoke is being used you have to use a protocol where the
> dmabuf reservation lock is left held for the caller to complete setup
> so you don't have revoke races.

> Maybe it can be some two step process:

Yeah, that would certainly make things easier on the irdma driver side, both
by avoiding races and also by not forcing the MR to exist at the time of the
call (many drivers do have the MR allocated at this point, but at least bnxt_re
doesn't from what I can tell).

I've created a new revision; I will send it out now as a formal patch series.

Thanks,
Jake


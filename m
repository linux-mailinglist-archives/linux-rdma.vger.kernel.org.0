Return-Path: <linux-rdma+bounces-23133-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id duNbMMn6VGpEiQAAu9opvQ
	(envelope-from <linux-rdma+bounces-23133-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 16:48:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF95A74C94B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 16:48:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=mbMcYpft;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23133-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23133-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D305A301BB25
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512D143440F;
	Mon, 13 Jul 2026 14:22:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70703D091D
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 14:22:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783952524; cv=pass; b=kEQbh2ESEatlfgRk8yOk1yDic7efIRpJ7cFhujmmFfOgUUWqJ7EItAXIMcWOhgzo0Et5fRsjkfuNu9Amrf/YQfcwzs4N678ozSoXdxkOE0JMcwpBXidGcU+IsiCctKkexeYb8zrw7qwe+LYK0AiDWCLHkvpPoMN/RTSjpd/5M3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783952524; c=relaxed/simple;
	bh=+8aCNjO6idn1FztFD/o7UxjwPCou6GcYvMWm2B5he7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoeZCQlLtntbOpZWqfHw6UB2DJ8h24dyTlszJuAdsNRpPvmixTaXcTsRSAKn5FnLUT76HpT/yrbQWoPVBAYOHRD2vu/bkn9UCqSSJKgfcON2hOM8ZkcS/oSO5EOwAIqinyK9yEFVMsE41RV/xTdnPbupRNebwBkLwbyEkfxrfOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbMcYpft; arc=pass smtp.client-ip=209.85.210.45
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb64085c45so1953464a34.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 07:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952522; cv=none;
        d=google.com; s=arc-20260327;
        b=mOa87Cm4bmEYljkrsWjf9GI1nO3pG8FQiQQPYjD1+3f7/wfW0h0U7h3HhIT53jRlsV
         NlFBJ7oK4uQ7UamHTSOD8Yt64usQ1CITcyS7Ju3Uc5UDcs0TbIphiaZ5Krrsl23WcURR
         jJuahDVE9dmZnf53F461ks+wlyVRR1qxtiGB7uc5wQAAP7nqT4/WOYu16pc7DOYFWDEJ
         5cbj39Ol5Ro58GC+HxZzH5Z4DJOML/tZKUZFVMu7U0tJMQ3IfY3wDa6ho7MMqBhHnokX
         /gIoUZK9nDJIuEhOa/yvfwCNQPpdlcZl1xlMP4o68okpQwY+MEAIfXnbKOfnMVQpDF9j
         oEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+8aCNjO6idn1FztFD/o7UxjwPCou6GcYvMWm2B5he7U=;
        fh=irwTEyaDiSnbaFYVL8uunjLC0JYoF3PFHthQo2GdJiM=;
        b=KEkEfH0QP+H4nlx9XYFVJoC9Y5soXXgJhURsbgrbUK83JTfpAEecC5wGbz2sf8EWvt
         blDO8dk2ATQhFAankrDV50POm7GT8rRnxQ9h4gA865F30zXo7rIsEiJrfeBdEkbDyzhi
         LpU+tGs36ApAafSgwlOheKs3qSOPIDWce+ezpxU2YtFS5GDTgDMviCnY9lewX0PJF1el
         N6qklwNFJppu+M//MTIsqfWBTNDXKYENB7NjwumxHSv9CDAjKvTOI8xsVEMFJgxhcKcq
         ELPhR2mHeb3oSthc2DyJC2xWZl0n8DxJy76mi5N+mhDTSW3X11/iCPSItoTCDFqO3q93
         okbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783952522; x=1784557322; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+8aCNjO6idn1FztFD/o7UxjwPCou6GcYvMWm2B5he7U=;
        b=mbMcYpftkDZ2ZtLZh4m0AogZrclCBh2dI5bsx34XXCKC89vh/6RvkLRc7r9AQTt6WG
         aJHic08kjKADhXf3TDme7J2Kry1G5J8sqoiZmeSCt/BY9gLrYNcXcZHqZWbeospx0k40
         rbLv22rd0CnrxjY7KssB1n5e110n8KzfVjKep1iO/pKmvTQ0M3U4gv1szdw7EfwhsjY0
         JUN45n2CEZlsvF8QUhfPaMKWi0IosrjZ/KU6t9a77G2JXPI/KgSG5rGW7Q0q4yQL+3gY
         OFLWJF/WOIuCbBAwLd7HIFSB6WDfQ7ylba+ALeE9VPfv+Ml5tkUuCkk1ENSt6EsZtrPH
         dP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783952522; x=1784557322;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+8aCNjO6idn1FztFD/o7UxjwPCou6GcYvMWm2B5he7U=;
        b=JU3MlYqk7KvbaLUErdJH7mM67HrqKsEU+vftlTl42Ebjso3NL4CSo9IzcOP7QpgnYR
         DXLyavGT5gbwuWfxY+BDaTdQ/M3hynkokIBZT1Oa0y/0fZrB9jJk9I+4Lh2nqV9zjfKP
         BzGE+PGcA5RHWkzxfM2qv7dG/PpYrPTWbPPWF9mK5KI8GPT9ZXoFxeYe2IwpAiJkle1q
         QszTYl2Ni57JaZORrl+0YYDtC/SI1VEaunBEWRIvTKz3+0Q3QjAVFsGjNIxZftbfchEp
         JPUJuqxz9woSg8IKyADc2QeBRsSJbrCWSFwAxYouIeOOWBITA4TJRjcFnRaIBeIT7zcT
         bP1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+1jio1PPtlBaofTvc3my7Jk5UdMVc/cI6Ft45TV2e2Cxjrh5BRZ3TefvtqurZOWwK6DDOn7Nc6bkdR@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8HWhiViWqZ9qra+jsKrl9NOjSUv5j9Qx7rJNFXhICsKixZhR
	CxRBm9fNGdpTqQAYghlVpp+vhf0Hw/Pp4fZV2gVWcbaeHcnZnjlofAQw8/FmF+PVaRYzvqmThNq
	seJtdNuxPo86pciqeaLd/GMTm/R+Qrnd0RzRvKrPf
X-Gm-Gg: AfdE7clVmbUsA+3HtLPrLzuGcj/b2jUz8PRdxCgXx3PGUFbHGDjMFyjIwy0u9TIuyuN
	SNshsOzL2BQE9ZICYGcpDBGW+lrifFWomFjS8gCjb3xmb5+YVyd3dt4i9hSbFh2b3IA8QXOGTeX
	042G6SDHodn6LPNQ3VdLKAQIT7n5hW35aB0eiAijKSExmr7b9K5aYvt5J+L9cp/cqF9vUkiwAqo
	tlRD8UkZqbWvuYkeUz9DwEuu/Q0NMznSLi1oaZv4OweIL7a/HKFndKSw7z7vilODns6o6eb0w==
X-Received: by 2002:a05:6808:1b0a:b0:497:e619:56a with SMTP id
 5614622812f47-4a42ae75c67mr6356591b6e.25.1783952520941; Mon, 13 Jul 2026
 07:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com> <20260713-fix-destroy-no-udata-v1-1-fcca2e34fd57@nvidia.com>
In-Reply-To: <20260713-fix-destroy-no-udata-v1-1-fcca2e34fd57@nvidia.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Mon, 13 Jul 2026 10:21:49 -0400
X-Gm-Features: AVVi8Ceov_xTc7vx5G47OmxMYew4NiGS4svgZ9NnqFn3IOne2mO01SvVqYQIyGE
Message-ID: <CAHYDg1S5jpZY=CRmbcH8MYHzyV4ro4MdzJ2gAj2fhaFfQo-yXA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/2] RDMA/bnxt_re: Validate udata before
 destroying resources
To: Leon Romanovsky <leon@kernel.org>
Cc: Selvin Xavier <selvin.xavier@broadcom.com>, 
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Michael Margolin <mrgolin@amazon.com>, Gal Pressman <gal.pressman@linux.dev>, 
	Yossi Leybovich <sleybo@amazon.com>, Cheng Xu <chengyou@linux.alibaba.com>, 
	Kai Shen <kaishen@linux.alibaba.com>, Chengchang Tang <tangchengchang@huawei.com>, 
	Junxian Huang <huangjunxian6@hisilicon.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Long Li <longli@microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Michal Kalderon <mkalderon@marvell.com>, Nelson Escobar <neescoba@cisco.com>, 
	Satish Kharat <satishkh@cisco.com>, Bernard Metzler <bernard.metzler@linux.dev>, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:selvin.xavier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:jgg@ziepe.ca,m:mrgolin@amazon.com,m:gal.pressman@linux.dev,m:sleybo@amazon.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:tangchengchang@huawei.com,m:huangjunxian6@hisilicon.com,m:tatyana.e.nikolova@intel.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:yishaih@nvidia.com,m:mkalderon@marvell.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:bernard.metzler@linux.dev,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-23133-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF95A74C94B

These changes look good but there is also a call to ib_respond_empty_udata
in bnxt_re_resize_cq (but that method does take input data).

Is that one a problem? I guess the resize could complete but the upper
layers would think it failed if the ib_respond_empty_udata call fails?

Reviewed-by: Jacob Moroni <jmoroni@google.com>


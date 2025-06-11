Return-Path: <linux-rdma+bounces-11214-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A63AD6066
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 22:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5105173486
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Jun 2025 20:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A8289E02;
	Wed, 11 Jun 2025 20:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8SLhoe2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C81D618A
	for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675245; cv=none; b=SpvjOG+BLDFQX2e3iDYwDM9EkMZa8fmlHdoccP0WQ3Qw4fNG3pUWOjiU2gp5C0x+A5BWQmQfeL84COq7oWwUHXcfhTRs9qRI0CZih7UtkQOrzHsAhRZ5clRCiGuFmt2/La5JrM40bJY45/6nlsWWi8ajaztQHs2WEn+fo9kmyrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675245; c=relaxed/simple;
	bh=AYq8n/v+tXT+VUaqslKMjVLnkmeNw2RH4xUUmbvnOTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftRkF8a6EZ+yl2XxF3piP3N3tOKBsIkPdA7ZbaX425aUgc0INp9WW4ZpR28yNd65mN5x4wc4oD6pjwQIgqvXWEmFYT1Y5cIqnQ149RC/dIVhWreZyBIioqqpOph4jtvMGDQ8pJLSucMVoHalN+cywB4WsR0OoOThHEoScolRD0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8SLhoe2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e389599fso58875ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 11 Jun 2025 13:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749675244; x=1750280044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9ODZSh8S7aCPsxn2p/L7r5lbam9F8rTMEAJ1T+T72E=;
        b=O8SLhoe2xdpv1TU4IcPMtxP24QwZe9fL667FTUvmw2Rx6aF65AsfHenEAOX3DMeOl1
         CbysfEvve6rnPfDTFXzMENge1ywPBti1NOvNRMKWN7rlhSDlaxqa3CYc26H14XZAl3/h
         7CfOT9cqDOvXMVWaMk1beKr4vbbWdyK8Vy1Elzb7ShqnM4X7vB0g5DaWrsrsIPhzorY+
         +7YE1XQ86uMn8EAJS+po9NIpsfFIQgBMXKKChuGEHwwdAbQoUfwkhY5w61V7dYIbsL6n
         hxmkhYTPKm/JYH2rD95qJ/A3pedYP5LAf8Nt8UjbtlaDXJjHt7+TSXmzAF8sgwExkiOU
         9YVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675244; x=1750280044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9ODZSh8S7aCPsxn2p/L7r5lbam9F8rTMEAJ1T+T72E=;
        b=N7rpCSkA14Wh8dDNEf+RZgW/4EIHQJDGXT1cKy4lk8GI3neC7cqcalvBI6Hfi6Q0KM
         BWDdVMQwF1ZgvMSUudR2oIX7jHHduS2Kd2aRa2OxzGnqWSydbd/c3PB6y+6kGM5P8Ril
         iliaieWKW9PLsrr/77FhJDhZ3aPqIcV7wxPbDSpPdk5jiRdw1MUVZipVbfqPlWC9r05o
         u8d8FOjLt1+CqRel7f4MIId9vJe3aQVCITE9h2GCYEO+ujuvf87ZRVwWzVckHkRld9iN
         aIqwnmYWSxXRP/gvcyMD+jyvNL0obR+4Q0ZpwINMJQVjYKAin4O3kfmrpXkwJc4MYFUJ
         CNdw==
X-Forwarded-Encrypted: i=1; AJvYcCURDkqerAiNhaZypGZUVsPEchrr0PpiQU/CqUZDAuI1Xcc2KN0S1Yn1l+HUYdmPSGo//7xNhDrbMl30@vger.kernel.org
X-Gm-Message-State: AOJu0YzorSV9virjBn96HlSnt0P0r6+pxDnO4QuqNoSSkB5etUXUJumm
	yRMWyq33v7UirBe/WmAmJl2lrUclqatRiI8SQwXKQTb+BDYnqLVin4DSzodyCFl/B0JoJz2ahhP
	2EtgOH70m0jcNRy+3PrlibKx202AYgO1n3St5WnZ/
X-Gm-Gg: ASbGncsAy1VnbfHKRUeuIAu80lRXf9U3EBoVe2MphaQH8o5CF1ZuTsfabUezuEinBD1
	i+9Cfp+xfztRfGegFkPsHhzfeZxzdXs/K2WFBePB7iZxDEXLd0Pht3zL3548X/VumCh5WdoRLs8
	6AJW0DfGONaLF0Hv5U0XhcCZSFVsN+kcH7PLt7pmcIQzwUpK8lI55jJmztogPf0TG1A0B6+Nnd
X-Google-Smtp-Source: AGHT+IGNxlwvOT/63E8WfH8fOvLo/kbNgZNIZ0H/0cRMTD73xz3o38k6hHpr4p4XXDFuDJGxNZhFeuEoTw2UanOyEww=
X-Received: by 2002:a17:903:4b03:b0:224:6c8:8d84 with SMTP id
 d9443c01a7336-2364dc4e0d5mr581215ad.4.1749675243498; Wed, 11 Jun 2025
 13:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org>
In-Reply-To: <20250609123255.18f14000@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 11 Jun 2025 13:53:51 -0700
X-Gm-Features: AX0GCFs86j-gs5jhCZgm2IbPRLCZG610-Y9bqwTkXzjafc_yCgYbSIAlkglSp4o
Message-ID: <CAHS8izP2Y4FMfHyTU6u5NRT45raM9isXJZPY4LMC8c03dGUPJQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
To: Jakub Kicinski <kuba@kernel.org>, David Howells <dhowells@redhat.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 12:32=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  9 Jun 2025 13:32:17 +0900 Byungchul Park wrote:
> > To simplify struct page, the page pool members of struct page should be
> > moved to other, allowing these members to be removed from struct page.
> >
> > Introduce a network memory descriptor to store the members, struct
> > netmem_desc, and make it union'ed with the existing fields in struct
> > net_iov, allowing to organize the fields of struct net_iov.
>
> What's the intended relation between the types?
>
> netmem_ref exists to clearly indicate that memory may not be readable.
> Majority of memory we expect to allocate from page pool must be
> kernel-readable. What's the plan for reading the "single pointer"
> memory within the kernel?
>
> I think you're approaching this problem from the easiest and least
> relevant direction. Are you coordinating with David Howells?

FWIW I did point David to this work in a tangentially related thread:

https://lore.kernel.org/netdev/CAHS8izMMU8QZrvXRiDjqwsBg_34s+dhvSyrU7XGMBuP=
F6eWyTA@mail.gmail.com/

I think yes it would be good to get a reviewed-by or acked-by from
Matthew or David to show that this approach is in line with their
plans?

From my end I tried to review to:

1. Make sure the changes are compatible with net_iov/netmem_ref.
2. Make sure what's implemented here is in line with the memdesc
effort Matthew lists here[1]. In particular the netmem_desc struct
introduced here is very similar to the zpdesc and ptdesc structs
mentioned as an example in [1].

[1] https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

--=20
Thanks,
Mina


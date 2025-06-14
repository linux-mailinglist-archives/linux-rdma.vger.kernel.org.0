Return-Path: <linux-rdma+bounces-11321-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5214AD999F
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jun 2025 04:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A1718964BF
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jun 2025 02:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC378528E;
	Sat, 14 Jun 2025 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xo7VZeOu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1571C695
	for <linux-rdma@vger.kernel.org>; Sat, 14 Jun 2025 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749867563; cv=none; b=T0Lqkl4Nx5tC9LBHh/EB/N23wxE0ZjSrlIuESTEXUKEIMUTF8QXMuYUeJvEk8u04vhl13QPmDpxA+2n8HsndR6y3JGznzsWJcY72TYaSkD3S/nJDTkLbzNCp3R2Hfw3aqCUpdspzJcT7KW5NLV3Egui/yN55FF40KRbER95CYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749867563; c=relaxed/simple;
	bh=AJuRSop8QkkGDZ8RIYWjeGO7mDVPmBvjRxvlq1diPXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQMt4qzLryGUd7i9AstJJ/rHeNTzRL2O6/LqNVNAFjIwPHgbNeAqlowu0hylsZLIhL9QR59kt0UGV2IRmMVzprvy12OHcmIDTuYz1h+pFSaZsQujLWudtXbw/05kBtpXj8UgoRZImhY3Vhe61Sxe+EP4kJjV85jYjYBsAvvjBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xo7VZeOu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235e389599fso89175ad.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jun 2025 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749867561; x=1750472361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn7hQ4tKQxqRQgt1sWefNjIs0nazm1nLsrkpL0FkOCs=;
        b=xo7VZeOudDM4r+wd5+/fzdH81NYY+LWRalknQIWQvKTM/W341oJaoA/bbu6P6K4053
         Q4V/4RpKLufIV03VXq4YzjwetNrswpvBFfOmqRTe2n/mlx6gfb/B9p9fUNe1CyOR5O49
         nesQD97Lqz8rhPiCNX+XV2jvIIX/QBLXSNyYkZ31GOTQInKtxEI1KBRor02j6FTw1lmz
         BvPBdREaNo/ZR6mPr96/cAv8yCl3t7ZJkK/VbIerCDtjZ0ogPS8mZWnFsxZxahi1e7zp
         Ir/3NV+BK9rfbPXR5UE8rrEYKtQ5Op5Qi8CeQlUKoPRJZR5Ffalufbzrh/Q7SS+x7b+f
         73OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749867561; x=1750472361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn7hQ4tKQxqRQgt1sWefNjIs0nazm1nLsrkpL0FkOCs=;
        b=uI04z1UC8I60OcUIoEkltJ+H3QoW5M7Gct9b5eb5vHecD4eUxwKI7VPk7SIV/lVjle
         PO+ZcnprDevYRwBoKujK+1YOyjgAKwi1lfWrz74muwGJmkk1wM8rmcQvP9n6H7g0Rcep
         YcY2tFIRozrSCVugT5j7pkrLK5icBtZaZgYcQti+hQfx4PXw2lY3zIbNAaB5+8mokjBQ
         fmx0gKxlvOP6sHNwo34MH23AUNzNJGMTkaqsyGdXlmqiH+lCgbTgDCeu/Z5Z3rr+uVaJ
         1bj8czv97CpiqcyX9ox3YhNllZ4E7e+mLFgQBRLlI7A6NSEsqb0+2pfs5ZZrTu0onVpH
         BNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6EbNqelDlDSu5DNbBo0hhlPrw8fHRGnzM1GiRHj/HtaqtKCy36QVFo1hlbou+72VPmMjyJalSWCUA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8HJ2hsMR1RhsqNEa31LZmFgmbGL1VIl2PoACbZ51dwA4E3P+1
	vNq9UAr7rg0oR2VDsFSPRBG+TgHOrHET5s9lcVRtIT8vDVLns/+dF6kL6Uma3MXoFKoSw8wENam
	1D1RLXsgzNgC3SRnql1ZRJtpmT7ajM0wYo/h/cqiD
X-Gm-Gg: ASbGncsbg6AopThkxPTka8UOsRjmnYrYbzUMfPFAW4zGJpNiJ2dTMyq1Tj2j720GMy7
	jCnnzHb2ZbTFxrcQnOEOFpiXTthVAJON35InDvvjNugFMMZaF1hB7Szre6jeUW3YO7q83PgyJjJ
	L5rIJrAmctjDJ16DF8OB5tnfX0DdQPBstPeMKfLJq7eRs8
X-Google-Smtp-Source: AGHT+IGYdXYi+poo/RbTJj3aTyp+thNZAzJ5yQqSIcmi+S8nbDQIjlrXV7TRD/xqSf9eS1uYlnMXOLt+1LwilFumYxA=
X-Received: by 2002:a17:902:ef08:b0:215:65f3:27ef with SMTP id
 d9443c01a7336-2366c5a25dfmr1048025ad.12.1749867560457; Fri, 13 Jun 2025
 19:19:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609043225.77229-1-byungchul@sk.com> <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org> <20250610013001.GA65598@system.software.com>
 <20250611185542.118230c1@kernel.org> <20250613011305.GA18998@system.software.com>
In-Reply-To: <20250613011305.GA18998@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Jun 2025 19:19:07 -0700
X-Gm-Features: AX0GCFuFHl8rGE_NSTG6eYqMKv1bvWBwteyyrelqyPJ0hyn_uDtWnwn8gbn2YYg
Message-ID: <CAHS8izMsKaP66A1peCHEMxaqf0SV-O6uRQ9Q6MDNpnMbJ+XLUA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
To: Byungchul Park <byungchul@sk.com>
Cc: Jakub Kicinski <kuba@kernel.org>, willy@infradead.org, netdev@vger.kernel.org, 
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

On Thu, Jun 12, 2025 at 6:13=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Wed, Jun 11, 2025 at 06:55:42PM -0700, Jakub Kicinski wrote:
> > On Tue, 10 Jun 2025 10:30:01 +0900 Byungchul Park wrote:
> > > > What's the intended relation between the types?
> > >
> > > One thing I'm trying to achieve is to remove pp fields from struct pa=
ge,
> > > and make network code use struct netmem_desc { pp fields; } instead o=
f
> > > sturc page for that purpose.
> > >
> > > The reason why I union'ed it with the existing pp fields in struct
> > > net_iov *temporarily* for now is, to fade out the existing pp fields
> > > from struct net_iov so as to make the final form like:
> >
> > I see, I may have mixed up the complaints there. I thought the effort
> > was also about removing the need for the ref count. And Rx is
> > relatively light on use of ref counting.
> >
> > > > netmem_ref exists to clearly indicate that memory may not be readab=
le.
> > > > Majority of memory we expect to allocate from page pool must be
> > > > kernel-readable. What's the plan for reading the "single pointer"
> > > > memory within the kernel?
> > > >
> > > > I think you're approaching this problem from the easiest and least
> > >
> > > No, I've never looked for the easiest way.  My bad if there are a bet=
ter
> > > way to achieve it.  What would you recommend?
> >
> > Sorry, I don't mean that the approach you took is the easiest way out.
> > I meant that between Rx and Tx handling Rx is the easier part because
> > we already have the suitable abstraction. It's true that we use more
> > fields in page struct on Rx, but I thought Tx is also more urgent
> > as there are open reports for networking taking references on slab
> > pages.
> >
> > In any case, please make sure you maintain clear separation between
> > readable and unreadable memory in the code you produce.
>
> Do you mean the current patches do not?  If yes, please point out one
> as example, which would be helpful to extract action items.
>

I think one thing we could do to improve separation between readable
(pages/netmem_desc) and unreadable (net_iov) is to remove the struct
netmem_desc field inside the net_iov, and instead just duplicate the
pp/pp_ref_count/etc fields. The current code gives off the impression
that net_iov may be a container of netmem_desc which is not really
accurate.

But I don't think that's a major blocker. I think maybe the real issue
is that there are no reviews from any mm maintainers? So I'm not 100%
sure this is in line with their memdesc plans. I think probably
patches 2->8 are generic netmem-ifications that are good to merge
anyway, but I would say patch 1 and 9 need a reviewed by from someone
on the mm side. Just my 2 cents.

Btw, this series has been marked as changes requested on patchwork, so
it is in need of a respin one way or another:

https://patchwork.kernel.org/project/netdevbpf/list/?series=3D&submitter=3D=
byungchul&state=3D*&q=3D&archive=3D&delegate=3D

https://docs.kernel.org/process/maintainer-netdev.html#patch-status

--=20
Thanks,
Mina


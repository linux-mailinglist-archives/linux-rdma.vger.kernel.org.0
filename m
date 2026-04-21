Return-Path: <linux-rdma+bounces-19462-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Sf7UBers52mhCwIAu9opvQ
	(envelope-from <linux-rdma+bounces-19462-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 23:32:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7350343FBFF
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 23:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3606305E9DD
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 21:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22D23559F5;
	Tue, 21 Apr 2026 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFVvlEHf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4FC311C1B
	for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807140; cv=pass; b=NqG3F0jlUmHccyjau9TEXD/rkV6+Oe92y8svwrMaaG5TZfgdFpY+WafDThcjS8eDS2/vkegUN2j8o3AB4uT1bUAu5ftlm9Waqa7HnPy5rAB3CBaQAdaEjBPNGykhNGQKvQJrSQvm71uEcvMX/LcpkRbglqZGJaUCwDY9E5bWskA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807140; c=relaxed/simple;
	bh=e2dTBEBF2DpMuaxH9JnrPGVtVJpxB5dE/off6LVwPmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7bWeNpjXlb83OTxXUFphH0fLyuM8hJsWfGu/KwhR3C12Mn/hMdKkfspHN2EXF2AHaFvPkgvtDteCIykYEFeUDJctQjZLcyJ2PFT/Yc2GaxewzWC0cJZDqdmR/x4YZdA/3ocwlnQTvy1OrMBmQR1RbxYjSxCc5STKpeboAajwP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFVvlEHf; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-baa8c78ac7fso85259866b.0
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 14:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776807137; cv=none;
        d=google.com; s=arc-20240605;
        b=iWiFZDbggNzPMWn0DSOi3/rIU1XeUxW9tn7AG1rkTQA4+jmeMi/CXKGw/uo/e2auvw
         ou+TXAWdfu+NDiGSiSqiwJvm5eb5QmmV9aY8bCY8FGI4vRj571fw1qI4+mKttHDawbWS
         NI0dN17rs8kKVb6rma2sdHiQEhfPDRy2g6ajL0wwu0G3seSXW88iaj2U99vBQhJLdwfT
         3BSqL8y80kEoTQxXonxMHH09w11BsSvIbM7hfGt3xIp3UxLz1xH5bH2+N9iOsyaHVgHJ
         cdOW5dnxyyGjVgzlCXhBGlcmRYgnDVqj1YerU1ncBnXjF6AEZLJP/hXZ5e/XMLRkiL4f
         sFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=509HgufiFm1U9Z0bXsfgdDqWo9zS9gLN8tGS8zCi5FE=;
        fh=Qg3BfYbJTMkdCcR/r/YtvHidwWDquBn+r5wIOH5Ljus=;
        b=QzkPeYD8Yyc49RaOoFmNs9W+0YeK/3jiCZXrbaql9JX/iw2FQIUr54VK6kj0dlpqz6
         asfEKPOn/SAfFVzQjHw3Z7QA90U7sl4d1TMxGE6q8JGMfyCBjEm5s/cpzl22uY6moNFZ
         2Mis1DKWBTKOGijvoC/hxji0CXFyYCtwgRj3VzUKNz/Bt4HTT5wDDkjO+7U2hztrwlB6
         mXoCAKiM9QZ979r+D+egyYxsrAxrCODblk/i6rpPrt7O2NzsNGI7w29gq5O4cgdN1h4p
         cpKrxa6ZhfKtDYj5yPqfOBd2m6VxvoSMNxCpuZUhKb7oHb/JgsJ5gVIUY3KvnPApuYKK
         /fCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776807137; x=1777411937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=509HgufiFm1U9Z0bXsfgdDqWo9zS9gLN8tGS8zCi5FE=;
        b=SFVvlEHf53cn28LJ5i0np/lqigVeERbrrvfU5wLgcer9IXlQuuh5xvc7mTJYgK0cfO
         x+JOnFV2g6LCCW4WBylxsEjYOcYTGhXG0AH37OB658uRmVFALvzKW5N0398SmsK42J1N
         g+a/KYbrnX/O0si2NKA8Ow5crS7uwGWXJshFxHJy4CvRHhn0oDp73MwL8f5+Dr63Ux0w
         6jXXdjXzssH4W4HDrA8BRWMA6J+Wj/AV7Jm8qRuBC1+1OgI14zKcZQpzoGLP2/bDZvc8
         3ozCYkj+l/DcnOaZn5yXSeMwKqGnUv7hM3Okne279YSDTKNHlMdWul9/deN5VmoJhh9e
         pJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776807137; x=1777411937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=509HgufiFm1U9Z0bXsfgdDqWo9zS9gLN8tGS8zCi5FE=;
        b=W9c1PnXzXBlitfFjKue107o2aA3tNNyCftwHQs8Tpk4l8yUCJMV7ZS8RW05RbDg7Uk
         J6oV6DwCDNDVWSuOzCWJCKlJ535xmuNso1WHBUBHpo6uY894I2pTa4xTD3L8ulHPw0Xp
         qF1ptvYb4PS2Bzgpz5vJntce7qPF4b3VDrRNNl9oQOh0f9PXTdeHHqtC09zUdNTUnv93
         OukRPvQtDIVZgQEhVadg7LgmRiRJ6YnCW7EX+QOF+RvxJrOZ1PMoy7gBeA6nObynez0j
         hgYvhA1AX4+FJCPfKMM3e509COV+tac+YJZvevgMBgNPCAMWf9Y5s4onQz7BstxKQJhp
         LMng==
X-Forwarded-Encrypted: i=1; AFNElJ8fQjtlXA8R8QXQcedK0ptcePrlkgYpiX1lvaLAl3u1YlUhFiUJxZl01+dfpZvI7cwUN+X7LpdwSJym@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJ2LeNOkqEA6fTJs+w/Zc6OC/9bvituDImRML/4O3kp87s/8H
	XxRI8Ch3nXtN/FaFQDxBkq0QOHouI7axptYwbjP5fKictJhFYj0DISGoLsp+Uwz9Cd7V4QD2BoR
	/2BA9+0H1vpedEcq95MFX672krUMu5/f9VA==
X-Gm-Gg: AeBDieuGnZFbo2gVI9IMKPrKh0y1RutMeHvnYPv1v9YxGyGGnSA/7RMZjcc6yxxqvFN
	YYfRQgjRTDUsWSuBEGSCe2OvAdF07BBXWHw+SwnlpC5OKmcGG/t2TX655wLRadBPFDvRFHDCiKs
	7A1o7O1Vm34HFervRjcYJc7aoMBUfHqzs9nMZ/rdqjeuekwG2Nr5CgzMmbN0NnfBgeCWVU5pjzn
	rK3bOzlMhcDerlft31ETMfbCXq6sKLCVSZ8n5RJaeEBborUFtkuAJIQbqanAD8YPHSK2a+ohNcc
	Gqvc43T8pmkSQLcqwwrhaDKLVxB5VNSWfAfDxbN1Ir+hV6631EMS8kEe2vfb1snXn5x3l+1e2A6
	G2TykQMxQj9+L84QR
X-Received: by 2002:a17:907:f497:b0:ba9:7898:c0b8 with SMTP id
 a640c23a62f3a-ba97898d6c8mr266092366b.11.1776807137138; Tue, 21 Apr 2026
 14:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421192821.2305-1-bernard.metzler@linux.dev>
In-Reply-To: <20260421192821.2305-1-bernard.metzler@linux.dev>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 21 Apr 2026 14:32:05 -0700
X-Gm-Features: AQROBzCeqaH7PVB1MgwDhfm7VQ3bRDu3UafjoV5RXH3RVnvhAfpVzFoUp4iZeCM
Message-ID: <CAKxU2N99X7619nGiNMHFRjSsMpYTQoRYgF4d9m9vX7Qq+kx5ew@mail.gmail.com>
Subject: Re: [RFC PATCH] RDMA/siw: use kzalloc_flex
To: bernard.metzler@linux.dev
Cc: jgg@ziepe.ca, leon@kernel.org, kees@kernel.org, gustavoars@kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19462-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7350343FBFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 12:28=E2=80=AFPM <bernard.metzler@linux.dev> wrote:
>
> From: Bernard Metzler <bernard.metzler@linux.dev>
>
> Simplify umem allocation by using flexible array member.
> Add __counted_by to get extra runtime analysis.
>
> Suggested-by: Rosen Penev <rosenp@gmail.com>
> Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
LGTM
> ---
>  drivers/infiniband/sw/siw/siw.h     |  4 ++--
>  drivers/infiniband/sw/siw/siw_mem.c | 19 ++++++-------------
>  drivers/infiniband/sw/siw/siw_mem.h |  2 +-
>  3 files changed, 9 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/=
siw.h
> index f5fd71717b80..a4088caec2ae 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -119,9 +119,9 @@ struct siw_page_chunk {
>
>  struct siw_umem {
>         struct ib_umem *base_mem;
> -       struct siw_page_chunk *page_chunk;
> -       int num_pages;
> +       int num_chunks;
>         u64 fp_addr; /* First page base address */
> +       struct siw_page_chunk page_chunk[] __counted_by(num_chunks);
>  };
>
>  struct siw_pble {
> diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/=
siw/siw_mem.c
> index 98c802b3ed72..56d24db729d0 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.c
> +++ b/drivers/infiniband/sw/siw/siw_mem.c
> @@ -41,16 +41,14 @@ struct siw_mem *siw_mem_id2obj(struct siw_device *sde=
v, int stag_index)
>
>  void siw_umem_release(struct siw_umem *umem)
>  {
> -       int i, num_pages =3D umem->num_pages;
> +       int i, num_chunks =3D umem->num_chunks;
>
>         if (umem->base_mem)
>                 ib_umem_release(umem->base_mem);
>
> -       for (i =3D 0; num_pages > 0; i++) {
> +       for (i =3D 0; i < num_chunks; i++)
>                 kfree(umem->page_chunk[i].plist);
> -               num_pages -=3D PAGES_PER_CHUNK;
> -       }
> -       kfree(umem->page_chunk);
> +
>         kfree(umem);
>  }
>
> @@ -347,16 +345,12 @@ struct siw_umem *siw_umem_get(struct ib_device *bas=
e_dev, u64 start,
>         num_pages =3D PAGE_ALIGN(start + len - first_page_va) >> PAGE_SHI=
FT;
>         num_chunks =3D (num_pages >> CHUNK_SHIFT) + 1;
>
> -       umem =3D kzalloc_obj(*umem);
> +       umem =3D kzalloc_flex(*umem, page_chunk, num_chunks);
>         if (!umem)
>                 return ERR_PTR(-ENOMEM);
>
> -       umem->page_chunk =3D
> -               kzalloc_objs(struct siw_page_chunk, num_chunks);
> -       if (!umem->page_chunk) {
> -               rv =3D -ENOMEM;
> -               goto err_out;
> -       }
> +       umem->num_chunks =3D num_chunks;
> +
>         base_mem =3D ib_umem_get(base_dev, start, len, rights);
>         if (IS_ERR(base_mem)) {
>                 rv =3D PTR_ERR(base_mem);
> @@ -385,7 +379,6 @@ struct siw_umem *siw_umem_get(struct ib_device *base_=
dev, u64 start,
>                 umem->page_chunk[i].plist =3D plist;
>                 while (nents--) {
>                         *plist =3D sg_page_iter_page(&sg_iter);
> -                       umem->num_pages++;
>                         num_pages--;
>                         plist++;
>                         if (!__sg_page_iter_next(&sg_iter))
> diff --git a/drivers/infiniband/sw/siw/siw_mem.h b/drivers/infiniband/sw/=
siw/siw_mem.h
> index 8e769d30e2ac..86af61d422d5 100644
> --- a/drivers/infiniband/sw/siw/siw_mem.h
> +++ b/drivers/infiniband/sw/siw/siw_mem.h
> @@ -61,7 +61,7 @@ static inline struct page *siw_get_upage(struct siw_ume=
m *umem, u64 addr)
>                      chunk_idx =3D page_idx >> CHUNK_SHIFT,
>                      page_in_chunk =3D page_idx & ~CHUNK_MASK;
>
> -       if (likely(page_idx < umem->num_pages))
> +       if (likely(chunk_idx < umem->num_chunks))
>                 return umem->page_chunk[chunk_idx].plist[page_in_chunk];
>
>         return NULL;
> --
> 2.50.0
>


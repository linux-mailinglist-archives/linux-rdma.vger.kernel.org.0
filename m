Return-Path: <linux-rdma+bounces-8869-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FFDA6A8CE
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 15:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F411885CE8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Mar 2025 14:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06F71D79B4;
	Thu, 20 Mar 2025 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9RZUt1O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15636A33F
	for <linux-rdma@vger.kernel.org>; Thu, 20 Mar 2025 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481255; cv=none; b=GBxoYduh0hVMaVHiP3gXRC3IXJfLe2hfSGzECaIstoCsimiaTQ6pYvSlZTo0bqTsN0V39oBKSFfJX+dj22HOXGdkjfYgbHkAkdHN2D/o3Q6JUrWof9t2TcGk5RCPfhlRqJNOjrRKYNuiEz5FXBkALdCz9K/abDS4uK5yguzV/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481255; c=relaxed/simple;
	bh=aLsT93dSweyrf+qk2uXM1EK4iaVizTPbN4c8paMt31M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bz12At3sJsTfypQVGEkp4RR8YMucj6hTZcU8F6L6L640NbAjKIrDS9Bd3hXEMlQ7JktqQHQQ072HU+i8LhWh922AKmi7WwQITDH7/I+O8AAfyE+x5RZrcor4MBdbBZvWPv2hoFYO796U2eR6HoQeyTqVnzZJ84phhBg4h8z+4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9RZUt1O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742481252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLsT93dSweyrf+qk2uXM1EK4iaVizTPbN4c8paMt31M=;
	b=O9RZUt1ORTdQNvzZg6v1n+SlSFxmoLqrcrWZAj/395HhPClsxVOca8UoeDvm9hjcYbeT0H
	B8kUyF0aXnKO2lNGNj6uiEyQx7lJfxQTHODf60e40ot7JBRuojjmYlWuB+YXi87zoNNwyR
	wdZZ2mzqtXgcKtQtJh53YCTh8C+3eck=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-_JUxUju6O8uQ_ANr1KgTGA-1; Thu, 20 Mar 2025 10:34:11 -0400
X-MC-Unique: _JUxUju6O8uQ_ANr1KgTGA-1
X-Mimecast-MFC-AGG-ID: _JUxUju6O8uQ_ANr1KgTGA_1742481250
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-549971b3247so411627e87.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Mar 2025 07:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481250; x=1743086050;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLsT93dSweyrf+qk2uXM1EK4iaVizTPbN4c8paMt31M=;
        b=e1D1FdjkLHp9D6nt6LhfTOI5QeaiikuPjCopP4RiREpVdvy0BFbfNb8eNaryrA/lmY
         BjSUJeORL/ZQIfXtJHQ1OwoYNWfkn5lyoQFpotNL+ObvJbD4oZ9AfP56QKfBR9BX73mZ
         WCZ1pt82JxraqJs1CDj0gpVci/42kRgOY+wkWD5xWpdohRwpz3VzA/emfuCHTIId0JQ8
         qWaNGWcdu5ulDB05Rvh6aZ5oCVyp+civ3N1atPgPsb636Dots2VcBiDUlyPTHVjdRnVG
         61m0MqW69+EWR7TEFi63GPrdDEI6VChaIVjEBSs/mmosRWgxeBW1BiyV/l6vUgpSeKaa
         G+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2/V/F2Y/Lt4eSBMc6av9TEvAhA61l87ZlXmb4WTMNzLu8UQDKBshZKV8N8DviZUogpJj4SDGA3Ft/@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTQMdILw+FoPa5OctkACK7ooHnF5/dkWxeDEB7Tpxx+PMxSF2
	CuHaRJy1mDPokoomB+9YnQfD4SJKD+5txKVvrbqb+AKpyDNM8MDJ+FBA+Y77tR2XN3AzS5oYroL
	SYmYAQu58VDr1J0EDmU2kTkE9s/Rmq21H0xFm6VTxD7KuPa6GxATbBlEu3GI=
X-Gm-Gg: ASbGncvmBrCF/Fs0WAm9fB43fCz+wweWbRN/Oj3gplH6fm0+VR57BLaJMzywaUmUFST
	bSU7nu/hIRA7S/R94FQ0mpCEVrk4DsaB3gdz5AoeupPeCqYYDECUVbDRvgP9khdGlT//3m8i8tY
	nSnHroxFxr0uFRWw306fXnL4pBEIuGelU05Xn2g3qMutfwG/1H2T+l/dyT7yUByHxMAmmGOdep+
	wI2C7m+7WTo90hkx+HemTDa8u9X8Clxvj+SR70rpdBg7hj50dM2qJKikdwt7tzSLfGt4YFo+Jrx
	ErN1cflm7/eN
X-Received: by 2002:a05:6512:2392:b0:549:8e54:da9c with SMTP id 2adb3069b0e04-54ad0619d9cmr1163972e87.4.1742481249715;
        Thu, 20 Mar 2025 07:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP5MKiRxkFgKG3EdSlhgqaV6W6DjuZ/y68FT+nnGB1qw2EVv6jr9Oog18ux0YhIZ7JDKVH0g==
X-Received: by 2002:a05:6512:2392:b0:549:8e54:da9c with SMTP id 2adb3069b0e04-54ad0619d9cmr1163951e87.4.1742481249052;
        Thu, 20 Mar 2025 07:34:09 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8a9219sm2230109e87.249.2025.03.20.07.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:34:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 202DA18FC2E6; Thu, 20 Mar 2025 15:34:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Yunsheng Lin
 <yunshenglin0825@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, Robin Murphy <robin.murphy@arm.com>, IOMMU
 <iommu@lists.linux.dev>, segoon@openwall.com, solar@openwall.com,
 kernel-hardening@lists.openwall.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <7a604ae4-063f-48ff-a92f-014d1cf86adc@huawei.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-3-c212e57a74c2@redhat.com>
 <db813035-fb38-4fc3-b91e-d1416959db13@gmail.com> <87jz8nhelh.fsf@toke.dk>
 <7a76908d-5be2-43f1-a8e2-03b104165a29@huawei.com> <87wmcmhxdz.fsf@toke.dk>
 <ce6ca18b-0eda-4d62-b1d3-e101fe6dcd4e@huawei.com> <87r02ti57p.fsf@toke.dk>
 <7a604ae4-063f-48ff-a92f-014d1cf86adc@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 20 Mar 2025 15:34:06 +0100
Message-ID: <87o6xvixep.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/3/19 20:18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>
>>> All I asked is about moving PP_MAGIC_MASK macro into poison.h if you
>>> still want to proceed with reusing the page->pp_magic as the masking and
>>> the signature to be masked seems reasonable to be in the same file.
>>=20
>> Hmm, my thinking was that this would be a lot of irrelevant stuff to put
>> into poison.h, but I suppose we could do so if the mm folks don't object=
 :)
>
> The masking and the signature to be masked is correlated, I am not sure
> what you meant by 'irrelevant stuff' here.

Well, looking at it again, mostly the XA_LIMIT define, I guess. But I
can just leave that in the PP header.

> As you seemed to have understood most of my concern about reusing
> page->pp_magic, I am not going to argue with you about the uncertainty
> of security and complexity of different address layout for different
> arches again.
>
> But I am still think it is not the way forward with the reusing of
> page->pp_magic through doing some homework about the 'POISON_POINTER'.
> If you still think my idea is complex and still want to proceed with
> reusing the space of page->pp_magic, go ahead and let the maintainers
> decide if it is worth the security risk and performance degradation.

Yeah, thanks for taking the time to go through the implications. On
balance, I still believe reusing the bits is a better solution, but it
will of course ultimately be up to the maintainers to decide.

I will post a v2 of this series with the adjustments we've discussed,
and try to outline the tradeoffs and risks involved in the description,
and then leave it to the maintainers to decide which approach they want
to move forward with.

-Toke



Return-Path: <linux-rdma+bounces-8752-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE02A6547A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 15:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC7A7A488C
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5F424888F;
	Mon, 17 Mar 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6VW8HI4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715E2459DC
	for <linux-rdma@vger.kernel.org>; Mon, 17 Mar 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223328; cv=none; b=HnV4gf/wT6bemrvH/0vzl5mPLj+R/JIKy/BDdpslNT5fEoDPY6q6I6zJqz7fsjmwIny0znXwrFfcevmkm90jA6k6jmz1xAeDKkyJTAHjka0IF9DHWmPtstO+eWGg+PGm5Jk5XEdJwFG2OBCoNWv3ki+JbJvFRv4P/lmpWhRt2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223328; c=relaxed/simple;
	bh=xNnWO/K1u8WG4XUZJxS4WUVdfdhF3mjZ+5wwJk9E/4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XBkIcntVZehSJNS8zS37TxDC0ERs1PDkVqzqWNfwC+kUWz/staI9Nda0ce45mSIMv1eoYo9HQuf/tPAJADvZe2ZjCID0xil+UImN9I8Rm8E629MMW/z9p/t5jxkVrlCCaGhZCE1VijY8Pi3xSqSGQinUEDtWH9LmNP4epnGQ8BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6VW8HI4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742223325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNnWO/K1u8WG4XUZJxS4WUVdfdhF3mjZ+5wwJk9E/4M=;
	b=M6VW8HI4VWEWTe/ynqN6bORakSLTwXTWIa7ZpOIF4q+WJtyNBmyIofLhGhwqSEJkDxBwj9
	Dz5BNlIUyT01shAFRD54DkqrXP1+9+BxvNbg5aswVKdjQgBukobmBQqYXZ9Ejeh5mK6huR
	rCByUPmFovAvKn0nDnf5IpCW0LtT9Hs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-nHF7escEOU-cW1RmKj2Iqg-1; Mon, 17 Mar 2025 10:55:23 -0400
X-MC-Unique: nHF7escEOU-cW1RmKj2Iqg-1
X-Mimecast-MFC-AGG-ID: nHF7escEOU-cW1RmKj2Iqg_1742223322
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-54996792145so2009187e87.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Mar 2025 07:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223322; x=1742828122;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNnWO/K1u8WG4XUZJxS4WUVdfdhF3mjZ+5wwJk9E/4M=;
        b=wh8uOls+a6sVzRdW1Ksc+aK0fAv2eNquiCh0ySFUj4zhvh3OvNxzeRupqvek1FF8VA
         /AcPl34B36rPoUszWOmP5OVJWWOpDooP7Eo+uujZe60U2L9RUfmO3v0Jeak7eXEVMlAT
         PggPFcif9YFCpaG3wGOU5o2FIKLPt4PfexJTtpjG7XKiGl4zbcAWsLLTpkxIs1cz8uX6
         ZyfbVHAYhShCgTeGhtFUSp15s3diU2Eqadd8C/vzG07l0fXYhSMBrjSIPdMPo9EIjQY0
         PHTcpx2zO85GJxWIW5qgOA7uJAV6+/awAZ+YRFuay99v3j8N0A3P6M6//LzbcvcAlQyz
         syBQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8LpGcFF7xP0Kp1AGzfXxNl5PO0X7u1PnybovUItRYaYj9NfBGJrd3gkhSNqcOpmjwMP73W1Ja0958@vger.kernel.org
X-Gm-Message-State: AOJu0YwwnG7a4aB+JTzQKRdfTriJSppJRFQ5htqqvQzCGMTHzyqB37yE
	rVHGQ0EZ04oeaAtwYRzhilvftTiSiB2S1wivBLrYBwc61dh9+F7YU6JBrQwZWXranRpdOHGy+gl
	gRX+Ecj4mvRpMoSocwIxWun36AiUJZH+t84fVKWUYV3PnTxlHZimYAKNzeRU=
X-Gm-Gg: ASbGncv+VuujqHsQsnS7A13+OkhxoKWvtz/ecAAuU5GeQZQB9FsG25HMvcGovSwxtAh
	+D3Y0DY8LmjvNg9uVldAZTdi69J2Pmk03LB7wd1tfG9CWCYTzkwQuU6vPLKEaJEw19Ir++YiB4N
	MpC0+nbmc2C9WCF60o4K6y8ButMVXOunsGHUNGZz9qJ09eynDlSQwYEM575RT13o62rZ9QLjI7k
	eURM+3NqKjBVpA7soYPUz+tRcp5lBAi7A37KPsVReYF+TGjExpf7WvoITsmbaVKHD/FcTb+ohpr
	Y+kYwavLe+yj
X-Received: by 2002:a05:6512:2256:b0:545:2eca:863 with SMTP id 2adb3069b0e04-54a03cf6675mr26262e87.42.1742223322297;
        Mon, 17 Mar 2025 07:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkU4EGv0nYoD/ziKJsZtzUZRRSbpyRPe5/A4qyQD074afFL4/ETFCYpbFS8GyZgIxIK6weCA==
X-Received: by 2002:a05:6512:2256:b0:545:2eca:863 with SMTP id 2adb3069b0e04-54a03cf6675mr26237e87.42.1742223321810;
        Mon, 17 Mar 2025 07:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a86c1sm1374403e87.21.2025.03.17.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:55:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B523218FAEC4; Mon, 17 Mar 2025 15:55:18 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>, Matthew
 Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next 2/3] page_pool: Turn dma_sync and dma_sync_cpu
 fields into a bitmap
In-Reply-To: <b0636b00-e721-4f21-b1c5-74391a36a3be@gmail.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-2-c212e57a74c2@redhat.com>
 <b0636b00-e721-4f21-b1c5-74391a36a3be@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 17 Mar 2025 15:55:18 +0100
Message-ID: <87msdjhfl5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <yunshenglin0825@gmail.com> writes:

> On 3/14/2025 6:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Change the single-bit booleans for dma_sync into an unsigned long with
>> BIT() definitions so that a subsequent patch can write them both with a
>> singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
>> side into __page_pool_dma_sync_for_cpu() so it can be disabled for
>> non-netmem providers as well.
>
> I guess this patch is for the preparation of disabling the
> page_pool_dma_sync_for_cpu() related API on teardown?
>
> It seems unnecessary that page_pool_dma_sync_for_cpu() related API need
> to be disabled on teardown as page_pool_dma_sync_for_cpu() has the same
> calling assumption as the alloc API, which is not supposed to be called
> by the drivers when page_pool_destroy() is called.

Sure, we could keep it to the dma_sync_for_dev() direction only, but
making both directions use the same variable to store the state, and
just resetting it at once, seemed simpler and more consistent.

-Toke



Return-Path: <linux-rdma+bounces-2059-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F2B8B1983
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 05:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3105F1F21764
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Apr 2024 03:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6AB2110F;
	Thu, 25 Apr 2024 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoPQYCu5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269AD381A1
	for <linux-rdma@vger.kernel.org>; Thu, 25 Apr 2024 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015670; cv=none; b=r6cHFnsPJlzTpPcM6D/PVRat0XN75FyWenPTqKv4xxcceyoeKEMAlU9KzM2inawCl1iesB4263JGHUF24S1n/MyGWU2l7N91eA9ewyOdD8uadQ5DVvupCJpv9kMFrAet5gxr3J+XWmbbRsLCJ6VLSgQ8jpHtnbndx0B47VyWzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015670; c=relaxed/simple;
	bh=bWSmUlxpy5chU36ujG9zh3zLE+Cbg/C6ozI8EtQmNdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3WZsJ1yut/wOPe608mFpGa7Iybns5oL8nJiyCRpp/5holIuRdrbQpy5CAPQwfEruM/iPDoAg3UKocjUwbcy+hdsw/sKIUytdhkledWwMgaZbzFT8O8DWFCYS/qWu42RUfTUeRPY4inQ81+M0b5hl8EWKJ//7n3xvemhipjAskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoPQYCu5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714015667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bWSmUlxpy5chU36ujG9zh3zLE+Cbg/C6ozI8EtQmNdo=;
	b=DoPQYCu5ryTjUugjNN4Nqd9BvtefR7YVLixNdtYsz0fetJQjvvpxtbK8fF6rdTR0oPPAT1
	isFzcboe9rB0sXfdwLmGMX5g5vmEZbcgO9bHYdPA+tifJ8jAqk2sHYx4bab4EOICC6vzYh
	T/YuUQWpzDlR/DBGjISFAZV5+HkVzBo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-p9SdE5TBNl6YCAp7LFmCFQ-1; Wed, 24 Apr 2024 23:27:41 -0400
X-MC-Unique: p9SdE5TBNl6YCAp7LFmCFQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a559bc02601so30320166b.0
        for <linux-rdma@vger.kernel.org>; Wed, 24 Apr 2024 20:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015660; x=1714620460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWSmUlxpy5chU36ujG9zh3zLE+Cbg/C6ozI8EtQmNdo=;
        b=MqF3LVtQTiMSE2PVUNO5hPLNxFEE4z2U4xrpLexkWE15ETtRUyJBoT6zX3StbPhgJf
         dop81DA225dsQoBIJNmyggye6IcQkKo/qKIlohKxQp7AhyAENBP12UWjHx/d408eBIcv
         7JqOKposvzNfKq1v3/7aJ/NdhikoqDW3NAcJRh1MPVihPhCnQcpr7sKkpizwiU26UKS3
         IrpDWFxDifdjNrx96JbzMRxZCYH2oPeqEckVvEcXdvxr/JFKqLanxFOHS9VwKITqJO8J
         kblm0XYA/Uv910yVOod6yPWFlvWMnS5RDSxtl6ekTr3d3YDDcn0fAtExfRIrLMr/Xu4u
         6IMg==
X-Forwarded-Encrypted: i=1; AJvYcCVNi9Usn7t/sEN2j1s49Y/zNfUIhSbg5Aw6HGnytIPljbEJTdBfiTl1w8/7D9BWZW5kEOGoD+a9/QueglhK14tCw4oEquTCRxX1oQ==
X-Gm-Message-State: AOJu0YwgrENIRYfTLF7Txn665rKGMMGRPJOnABxQ1d371U17QwPonZzJ
	yJYGgqqNRGPpV3V5pc3npiK1sBhSZBM9zTlJIz+LRFJhw41skD9j+xRfFiVTTi9jRRGqqZz/MHi
	ICGv5CnuXf8GucCpIZQfe/C7ytTxKb+37oZMGPMspqwlzyo8uZ7NwWILIIpLmGzvVh+e6e90/u8
	YW6G5cTJPDDuA5ehp54SUuFIsITqtCidEvvQ==
X-Received: by 2002:a17:906:480d:b0:a51:d204:d69e with SMTP id w13-20020a170906480d00b00a51d204d69emr2791131ejq.7.1714015660132;
        Wed, 24 Apr 2024 20:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPtP2jLSqClgtPj4M56kdlZeBO+5l40Gy1g8sabQb/6hAodyZM3zbt7TnPaVinyQrLiG6LY+/bY5NEzTPbikE=
X-Received: by 2002:a17:906:480d:b0:a51:d204:d69e with SMTP id
 w13-20020a170906480d00b00a51d204d69emr2791116ejq.7.1714015659871; Wed, 24 Apr
 2024 20:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev> <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com> <20240326153223.GF8419@ziepe.ca>
 <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com> <20240403154414.GD1363414@ziepe.ca>
In-Reply-To: <20240403154414.GD1363414@ziepe.ca>
From: Tao Liu <ltao@redhat.com>
Date: Thu, 25 Apr 2024 11:27:03 +0800
Message-ID: <CAO7dBbX0ZBwSzvi=ftNHe73hPP6Ji2WWTsKKYmD2tZENMjH_bw@mail.gmail.com>
Subject: Re: Implementing .shutdown method for efa module
To: Jason Gunthorpe <jgg@ziepe.ca>, "Margolin, Michael" <mrgolin@amazon.com>
Cc: Gal Pressman <gal.pressman@linux.dev>, sleybo@amazon.com, leon@kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jason & Michael,

Kindly ping... Any progress for the efa .shutdown implementing? Thanks
in advance!

Thanks,
Tao Liu


On Wed, Apr 3, 2024 at 11:44=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Apr 01, 2024 at 04:23:32PM +0300, Margolin, Michael wrote:
> > Jason
> >
> > Thanks for your response, efa_remove() is performing reset to the devic=
e
> > which should stop all DMA from the device.
> >
> > Except skipping cleanups that are unnecessary for shutdown flow are the=
re
> > any other reasons to prefer a separate function for shutdown?
>
> Yes you should skip "cleanups" like removing the IB device and
> otherwise as there is a risk of system hang/deadlock in a shutdown
> handler context.
>
> Jason
>



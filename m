Return-Path: <linux-rdma+bounces-408-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677868110EC
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 13:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E1DB20D27
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Dec 2023 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3096228E0B;
	Wed, 13 Dec 2023 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="foOo+nZT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33662EA
	for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 04:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702469945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OenjaI252jDFm5tBCpqUj00k8gqMRMfXOu979QIu3U=;
	b=foOo+nZTkUPAao+C+cTR2NZHnTh8hbcuCE1YqChtgLE4OZ/ZiNFBFSoQnz+yW17vdzs+KP
	FF/2DMHfBHvgJOTzRDyJwHIUDsh0GSv2bQfQz5ilUkDPvWCIg1Ur0SvGi0gK1L2+fV2Cnn
	qydGSIVDyeMTPwZhDFUVBN/jZ1hrYdw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-CoMGF1QUOIuclS71ATkyqw-1; Wed, 13 Dec 2023 07:19:04 -0500
X-MC-Unique: CoMGF1QUOIuclS71ATkyqw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c659339436so3395857a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 13 Dec 2023 04:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469942; x=1703074742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OenjaI252jDFm5tBCpqUj00k8gqMRMfXOu979QIu3U=;
        b=N80zYnQXEZ4taB1KwItygWgJXH6KPyrfBHjhXcj3O+wAcDy6LxDIAWpLF3/LGz+1bi
         X6yh2UFVmh4D10erTlIFqAaodwfwOtQ0j7pNlFU177KPl1c2rE3MF4GscfU3IBCrvlpu
         mmoiTJNz3i3lTvIYNMWGRtRCdCRLECqmoCccEq0K3yddYVux6uMviZ0z2A4xlvnYPUS/
         67LJVCptPsCOIPeJcXMJCRo2QE3/2x2DpUXPEn2i9d+jDupKvf2ioy7FnB7if69JbOyl
         466kYtO0oeBiwQXpNK0vT7MW6xvG1zwHUZt/egi/mDd7bTIAm1t7tmVbwe83mRSP6EYF
         SXbA==
X-Gm-Message-State: AOJu0Yz5zH2FJOO2eYEhDkkphLZ+3SoSqniHxXO+2IpTS5sHb2RxpCIT
	ublPJalhoZBvB5xdM21dadDVBAvyKwkea4YYri3B+5k7eZGctQAx42O4IQNkTDtQbvH5jQAecIJ
	3j3KsDq/ME1pOftw0d3quk0Lu/UL98r3iWBqQjpViuiRkqUFI
X-Received: by 2002:a05:6a20:9495:b0:188:973c:ef84 with SMTP id hs21-20020a056a20949500b00188973cef84mr3763245pzb.9.1702469942715;
        Wed, 13 Dec 2023 04:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHR0T2JL9fDDpIZW3CvJFbOq91R6/I3nKFKh+DB9JS2YSkxLRf4rwRBOee7a1V8bWk6KRdgp2nKczpoEqW+zZs=
X-Received: by 2002:a05:6a20:9495:b0:188:973c:ef84 with SMTP id
 hs21-20020a056a20949500b00188973cef84mr3763242pzb.9.1702469942430; Wed, 13
 Dec 2023 04:19:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211130426.1500427-1-neelx@redhat.com> <170236977177.265346.10129245400198931968.b4-ty@kernel.org>
In-Reply-To: <170236977177.265346.10129245400198931968.b4-ty@kernel.org>
From: Daniel Vacek <neelx@redhat.com>
Date: Wed, 13 Dec 2023 13:18:26 +0100
Message-ID: <CACjP9X-Ez80KXtquy-g1wqPwRr-orW8uBy=rvowh2hvJT1s_Nw@mail.gmail.com>
Subject: Re: [PATCH 0/2] IB/ipoib fixes
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:29=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
>
> On Mon, 11 Dec 2023 14:04:23 +0100, Daniel Vacek wrote:
> > The first patch (hopefully) fixes a real issue while the second is an
> > unrelated cleanup. But it shares a context so sending as a series.
> >
> > Daniel Vacek (2):
> >   IB/ipoib: Fix mcast list locking
> >   IB/ipoib: Clean up redundant netif_addr_lock
> >
> > [...]
>
> Applied, thanks!

Thank you.

One small detail - I was asked by Yuya to change the "Reported-by" as follo=
ws:

---
Reported-by: Yuya Fujita <fujita.yuya-00@fujitsu.com>
---

Would that be possible? And if yes, could you amend the commit
yourself or do you want me to send a v3?

--nX


> [1/1] IB/ipoib: Fix mcast list locking
>       https://git.kernel.org/rdma/rdma/c/4f973e211b3b1c
>
> Best regards,
> --
> Leon Romanovsky <leon@kernel.org>
>



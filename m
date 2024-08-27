Return-Path: <linux-rdma+bounces-4595-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC759618DF
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 22:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CA11C22C0A
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Aug 2024 20:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC5185931;
	Tue, 27 Aug 2024 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzY06fhu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56858156C5E
	for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724792258; cv=none; b=DpfVI99Q/KC+9cckMepFbXlJoyW35fWCDO6i3DcUbWGwVkRu5g2BagNxTkWeCdfnDO60nIqPU689oT7QAoGbVpjR653XjIHvBdVaLBL0H0Z0MCvvuKXLrxykF+2c/BYPxE3p3SZ2fcNO8kGNq+9a2rvrR6vVSUaXL4uDtMsts7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724792258; c=relaxed/simple;
	bh=a+Hx3HSx7SP9gOw3dRyzdxi1PmIjbrmqv/wAqFLVKm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1ZLOu8qEcgvLQn60K46mIoVS5UljqLiqb9MeMhUTe7ylISiqF4huPSo+9PXoG0NEtAC1v1DYwlsiqTs+Amd05DYhfISQdrFlAXUo+HONj6/iKFNSWjQmusW1d7R8XtdKy/axnmhhLSHO5f5ZD6Q/r8gyEKQ3EXLdyqerStC8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzY06fhu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724792255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zlOAZ1ucvHWMwTxy2YsSKGk/n9U1bb66io97vZemYtY=;
	b=LzY06fhu8weaGoEtmPGhL4ElSuql1cFYnNd9vWy4PUNdQKPGj8G7Pj550prfz5+rhsUAjs
	9gaSF/Uj7H1s3rUBmg0BMtsdSVd0ECMtkMB+lhYWLg/hYDVbiwTMv6wXIH9VTFp3MR2WaV
	W5jOd80tNNfPscXLrBf3oOsw7AkGozI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-7wFKeQjhNYubawBY21YtzA-1; Tue, 27 Aug 2024 16:57:34 -0400
X-MC-Unique: 7wFKeQjhNYubawBY21YtzA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a867bc4f3c4so10044966b.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 Aug 2024 13:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724792253; x=1725397053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlOAZ1ucvHWMwTxy2YsSKGk/n9U1bb66io97vZemYtY=;
        b=Y9gy0X17zqicyNKjuGXSiUCMAyw5E/h+cwMTav8d7ovKdehP29x0R5CkjdJY4PsfeB
         ExxjIzP1V3mJTD9Hq4Cm2CjshWP/NA2rE02Y/zyrjdeScYzcKy4/H7LxNm35PW4i8tGt
         CZiDphuXRzK5BbvKKPJBs6KX2bJThc+JZu3IxJi6uUoVIsNALYfMrEpjwlkmQAA6srRV
         8qGf9DeSY1OtwfAcUOt2Ng/asolmDmx2eUFru+qNt5Sn7gYGeQdB3cr4wx7x7aeUUHB5
         MFM7kqaaPxk+5hieiJHLI1IZ1dVQIY+1kG/GCZEo84a0qFr1rpn3/OXkBcvWMdmutIPC
         ae/g==
X-Forwarded-Encrypted: i=1; AJvYcCUbOBYN96QklEcN9+el//eNTf3mw9Apk3N3k6d8RuTb0NsypWrLsexhwdfv0DRHX4ggVVlnomShiy1h@vger.kernel.org
X-Gm-Message-State: AOJu0YwWD6VM9OhWndb1iEga1q9PXiqt7oWeFrOOFEwRdIpK6PLrJBTo
	qI7sG5pDaOvR7LSVtsy4TGKVl6w2VMbdVqcJmb4o6qaWDJzzEQmdxoQIoTy00F5FrTLL63b1Gz+
	UOl5zCQ8vDreEUmr4YWl56owLymoHEtg/gz9KlbTlHTLSVDX54d81XEsQmmk=
X-Received: by 2002:a17:907:1c0a:b0:a7a:a4cf:4f93 with SMTP id a640c23a62f3a-a870aacfb3emr3589166b.32.1724792252810;
        Tue, 27 Aug 2024 13:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvz8X1NRdbe71G1MI+rmGk2Z5MQfxwDUYa0pzzMRwHy3MVTTxGM73affdMmWF0lH1Fx948SQ==
X-Received: by 2002:a17:907:1c0a:b0:a7a:a4cf:4f93 with SMTP id a640c23a62f3a-a870aacfb3emr3585966b.32.1724792252028;
        Tue, 27 Aug 2024 13:57:32 -0700 (PDT)
Received: from redhat.com ([2.55.185.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e548967fsm155557966b.19.2024.08.27.13.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:57:29 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:57:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org,
	yu.zhang@ionos.com, mgalaxy@akamai.com, elmar.gerdes@ionos.com,
	zhengchuan@huawei.com, berrange@redhat.com, armbru@redhat.com,
	lizhijian@fujitsu.com, pbonzini@redhat.com, xiexiangyou@huawei.com,
	linux-rdma@vger.kernel.org, lixiao91@huawei.com,
	jinpu.wang@ionos.com, Jialin Wang <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <20240827165643-mutt-send-email-mst@kernel.org>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <Zs4z7tKWif6K4EbT@x1n>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs4z7tKWif6K4EbT@x1n>

On Tue, Aug 27, 2024 at 04:15:42PM -0400, Peter Xu wrote:
> On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> > From: Jialin Wang <wangjialin23@huawei.com>
> > 
> > Hi,
> > 
> > This patch series attempts to refactor RDMA live migration by
> > introducing a new QIOChannelRDMA class based on the rsocket API.
> > 
> > The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> > that is a 1-1 match of the normal kernel 'sockets' API, which hides the
> > detail of rdma protocol into rsocket and allows us to add support for
> > some modern features like multifd more easily.
> > 
> > Here is the previous discussion on refactoring RDMA live migration using
> > the rsocket API:
> > 
> > https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linaro.org/
> > 
> > We have encountered some bugs when using rsocket and plan to submit them to
> > the rdma-core community.
> > 
> > In addition, the use of rsocket makes our programming more convenient,
> > but it must be noted that this method introduces multiple memory copies,
> > which can be imagined that there will be a certain performance degradation,
> > hoping that friends with RDMA network cards can help verify, thank you!
> > 
> > Jialin Wang (6):
> >   migration: remove RDMA live migration temporarily
> >   io: add QIOChannelRDMA class
> >   io/channel-rdma: support working in coroutine
> >   tests/unit: add test-io-channel-rdma.c
> >   migration: introduce new RDMA live migration
> >   migration/rdma: support multifd for RDMA migration
> 
> This series has been idle for a while; we still need to know how to move
> forward.


What exactly is the question? This got a bunch of comments,
the first thing to do would be to address them.


>  I guess I lost the latest status quo..
> 
> Any update (from anyone..) on what stage are we in?
> 
> Thanks,
> -- 
> Peter Xu



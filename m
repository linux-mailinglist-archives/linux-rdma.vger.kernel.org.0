Return-Path: <linux-rdma+bounces-11595-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6259DAE6C2D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 18:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A223AF3F5
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 16:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843E52E1756;
	Tue, 24 Jun 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvBKYg0d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29BA2E173D
	for <linux-rdma@vger.kernel.org>; Tue, 24 Jun 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781598; cv=none; b=FgUILirXIhEqOUpEryqP92DsVWoQNvg4T6NGrYkIx2QvrY+p3QRV8f08ooAySScahC50jYUgLoL/zlmo0fMm5v58MociuV1EafEproeZ6trcbYdbSZ/lISgPU5dVEF+/EMk6pmjf1/C3waHZlzypy7eW9fpwjMKR1t6lvodbTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781598; c=relaxed/simple;
	bh=tYG5jTcIc6lkYrhz7J10TtWJVbsSBH0IkVNYKqBZoK8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gFFOKRAi7gmpKYgx2CKFN8hYQ4yaAMlp8H1+bD27dCo50FQs9n0KCF4ny6hGvvujHc6sTg8FYx6ghUfdQkEnfJp5TFy/RKJb9HrZ52/x3PTlh8wcTxwjF8gp+0mRl0eZAXKQyiANyDNl8m8ThohIQpCSLZsiKb0aSq+noCGXO8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TvBKYg0d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750781595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x5R79lIc79qw+LwnY8ZeG/QCJ7Vln6rRrb23eTtbbts=;
	b=TvBKYg0dHKQH6RXZYwKQWvDns1jm04lRZElZy36Wfvh0TE1HzvDpjUg5uuM+YK2ZPn+1Jl
	EYlGd65jwz5YrH4nS3SBC2lDgtGx1Jg89xKrDeGERJxzMe/smzgo78LWF/1ZxQeukaI9/R
	Tm3qpTxWtoOgwsVVug+hBDOvcQKnJwQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-3vYxQUK1OyaU83oIQabf0A-1; Tue, 24 Jun 2025 12:13:14 -0400
X-MC-Unique: 3vYxQUK1OyaU83oIQabf0A-1
X-Mimecast-MFC-AGG-ID: 3vYxQUK1OyaU83oIQabf0A_1750781594
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fabd295d12so10975296d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jun 2025 09:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781594; x=1751386394;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5R79lIc79qw+LwnY8ZeG/QCJ7Vln6rRrb23eTtbbts=;
        b=cVyusrWagxUHB1NawhpyJtQLPWFeBIWNTACyGqUiH2GUwXGgVV4kuWpAMQZSfqXk+/
         LTiExNnLSV9oJ5A8P72CieniLJgjmNqSq6nuYgSDRFIaGABIaKn5FwiFwnxX0ePizvpS
         HTvke/yW8rMDAz61KgtCymk2botfGXwC2Hmdqsypl/kBNo5yqZ8xlPU80wiupmsgOoc4
         cVG71wUWdFEEfn/EQKZat2NQXwXg84gexH6dS2GaxnhbuEC6ZalzK8qanWipyusSwhQB
         Q7mLS8wBW7O+RvAaC51q9Pjqz2JgEk4FX140/WPRmWiqgMuZnHV/JOTKxi0AQRe6cr1K
         SSuA==
X-Forwarded-Encrypted: i=1; AJvYcCUDmrkWr/r6TS+xlB4IX/tqvvUlWfxu1jvf0gSVcDwmKLqhO5GJRMSDPJvGw8byq25HjuGLIg0Yp6bn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn84S8VO9xM8M0Si1tr0bVRFtUsZM0iFsHvh76H2wIHRpdyitc
	/utx9xgRKHdr3aC/KcjstbBKpu3JuQKVjknT+KcKObO6+uYSixjhSVaBFm2//707TNoMlCLznqE
	cLgFXsHYee1Mp8x6zL8tg7pwDyeM7HlDpjTX0LbqyQwnSc21nSACTk7uTSeIEhVw=
X-Gm-Gg: ASbGncux8MGWp9CQmBEoGNGWmD3NaeBPbFqMVrlPgQOrUU57MvG2kd9PJy7Or4bb3+4
	ffESghgQzo00eZ3cPIPNAdo8D/9YaMLMcgowtsm1IXuYruI9lKvz50aXwlYWeUU9AfdYcqlYY3t
	eLUceSQhAVH3Q/UYCbLUci04+u3a1K1LyhhbY6f5fYQz4dBsKLl4s4Q5i9IDDJ0uMF10S+l6brW
	fOI7wo5rJ3XHy7D6Y9DvMSpttqL346z2alvdfge+RHQVJLj+zjBwQQwaAsemBI1UOMo1/lY9m9b
	1SoXW6L2EbUJwbbtDW9DOlMgc6CxAoHUo2QxCDE/Vg90SUdL6/LOzpGPEAGzPR5vT14OXZGYyE4
	ciwrciwU6FN0gTN9p
X-Received: by 2002:a05:6214:20e9:b0:6fb:f10:60e with SMTP id 6a1803df08f44-6fd5e0c0c8bmr3725236d6.40.1750781593504;
        Tue, 24 Jun 2025 09:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCm31O5u32zNkqCRW8pO6mkfdRgGmr0pw1SUCu9UJ/KjZ0LHdt89nkuXO+YjDtpESggATGMg==
X-Received: by 2002:a05:6214:20e9:b0:6fb:f10:60e with SMTP id 6a1803df08f44-6fd5e0c0c8bmr3724586d6.40.1750781592875;
        Tue, 24 Jun 2025 09:13:12 -0700 (PDT)
Received: from syn-2600-6c64-4e7f-603b-9b92-b2ac-3267-27e9.biz6.spectrum.com ([2600:6c64:4e7f:603b:9b92:b2ac:3267:27e9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd0945183dsm58565886d6.44.2025.06.24.09.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:13:12 -0700 (PDT)
Message-ID: <017f14924a49b76148fb4cfd9c6107d423e6cb2c.camel@redhat.com>
Subject: Re: fix virt_boundary_mask handling in SCSI
From: Laurence Oberman <loberman@redhat.com>
To: Christoph Hellwig <hch@lst.de>, "Martin K. Petersen"
	 <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>, 
	"K. Y. Srinivasan"
	 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	 <wei.liu@kernel.org>, "Ewan D. Milne" <emilne@redhat.com>, 
	linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Tue, 24 Jun 2025 12:13:11 -0400
In-Reply-To: <487a4646387595383bf8ae24584c5b54ec6aa179.camel@redhat.com>
References: <20250623080326.48714-1-hch@lst.de>
	 <a665dead67bf4f3432cf1bddf29d2c573ab71673.camel@redhat.com>
	 <487a4646387595383bf8ae24584c5b54ec6aa179.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-11.el9) 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2025-06-24 at 12:11 -0400, Laurence Oberman wrote:
> On Tue, 2025-06-24 at 10:21 -0400, Laurence Oberman wrote:
> > On Mon, 2025-06-23 at 10:02 +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series fixes a corruption when drivers using
> > > virt_boundary_mask
> > > set
> > > a limited max_segment_size by accident, which Red Hat reported as
> > > causing
> > > data corruption with storvsc.  I did audit the tree and also
> > > found
> > > that
> > > this can affect SRP and iSER as well.
> > > 
> > > Note that I've dropped the Tested-by from Laurence because the
> > > patch
> > > changed very slightly from the last version.
> > > 
> > > Diffstat:
> > >  infiniband/ulp/srp/ib_srp.c |    5 +++--
> > >  scsi/hosts.c                |   20 +++++++++++++-------
> > >  2 files changed, 16 insertions(+), 9 deletions(-)
> > > 
> > Grabbing latest and will test tomorrow and reply
> > 
> For the series looks good.
> Same testing shows no corruptions on storvsc for the REDO so passed.
> For SRP initiators generic testing done with fio and passed, unable
> to
> test SRP LUNS with Oracle REDO at this time.
> 
> Here it is, enough reviewers already so just the testing
> Patches were applied to a 9.6 kernel because I needed such a kernel
> for
> Oracle compatiility.
> 
> tested-by: Laurence Oberman <oberman@redhat.com>
> 
> 
> 
Nit, fix my email, dropped an l should be loberman@redhat.  com of
course



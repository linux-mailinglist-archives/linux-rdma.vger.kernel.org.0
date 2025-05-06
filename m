Return-Path: <linux-rdma+bounces-10095-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEC1AAC7C1
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 16:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D1A1BC7F19
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1A2820C6;
	Tue,  6 May 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZOhMnslr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5C0280333
	for <linux-rdma@vger.kernel.org>; Tue,  6 May 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541326; cv=none; b=oG1DEVRFVaoxYERsapzolaCAP9p8GqrBe28CrVFVVh15eTqGQOZziLgv4l+ugKZylB5iAqQm5GO5hKi2NKfoNzwTByc116WjCmPWRqqfufDMEsq73PM7LsDjEKcALAMXmTSvbSc4rDjf7BhkpOZmHA8O7bkkYTjqiFzKYQmEHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541326; c=relaxed/simple;
	bh=J+mg6cEpXyQQIWs6kbcnPXhgAhiUqyGZFrGo/eaz0PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie+Am24N7O/0yIUO2yV6zCxue9EVKej1jYb//VAXAlr0/TmPa/ZyvevQDO8lziP0y716ozZSx4Ns1nKRK/WzeqYyySzqtPbcukuB3SozeaUrYchuX0WFQllPFVCHY3G04hHSu8fSNpXzJABFtUPKRx/zPHL7nSs329BG/PVMPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZOhMnslr; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c58974ed57so614261385a.2
        for <linux-rdma@vger.kernel.org>; Tue, 06 May 2025 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746541323; x=1747146123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jdO/xzSRxYVpKMGXriepq+O9+XVFu9E8u5yhtKyYDnI=;
        b=ZOhMnslr9UmXEj/zb5CyM+Uv09zHyn8EmKr/L2E+LZLycY48L/BlzLVK66560wI6n/
         jmn1jAYwnMS2b/pWIUlYJCfqeF3tbBKly/taq1pNZVyyB1sxujvdE+TA1HXKMh6kl7fk
         UI0ny2OcCAINk0gvoQ0Rqt8Cg04tVa3hmaqYLr/WI731yYoLVSkrKghItYw7GNVz7+ol
         vgNXJQnRAlW92dWwsLdPfkdfnBmNb7VKQr7sPtF0yH5dX/A6leN4BMWfEWVzCDISPYmv
         dfFoB/ilC/hIDHmvL5mtD7QbJiSAybjePMjZN7OwWp26CKxqA7d8jtzrxPsyztDtsObn
         FwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746541323; x=1747146123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdO/xzSRxYVpKMGXriepq+O9+XVFu9E8u5yhtKyYDnI=;
        b=FHhd0K8qUOCo8fNuv4E1OScYZb1ZBPMwu3bQvKY0tMaLLn+0NZXdyyV6fBcUk8gY+A
         ZWZiT9fA80A1PZQHn0KJVVRq2Vmb1zYxOOKoQrgZAJwIphX3EiWxqbF0Vz48dPwocag9
         v9UMmtgY941AS1rVMogVj37osCHC6GVPH3uJ7gytvCPCyI2CtcBh9cDOJKWuiviMIbas
         UeXc6n/x2qkIuZTtIKICAfPXI5PAPP/gRmMbJx7ZPpawGz0cVLyocjvJlN9xITzvZYvV
         P0jhuOuCeqQTb6oHsTP17ZAOudHvsaHHXnZPns6LndKwSWUXkL7UBuesj1Ycp0YTRsJZ
         q3Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUy+twkBQ/djFEOD9WwXlOqPQyFy4LkPOmKwCqfqVPtd9+ph+6cCTxIjS/Az9X+832boiygrTSu18FX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9hbaU44sJ6W5Vwu5ZVN13wogLOBhtfkkicSmGn96xQ5zGs9JH
	RjynlOSz9MTeqfKuL67qetHJFhL24lQ4lzxKaciKhO3UBnsxXEwLBMgVSQCN4KY=
X-Gm-Gg: ASbGncv0mTgfowWq0adUsA2yH2J2dvH0Gg38xWwUXbFHv7GYLc4ho6wu73+GsFNayrz
	pMGRL0eBuoN6WL2zf3VgsHeiNGkxMOZTfQD/d7iX45Gp4g+q5qQrAt4BvAnHlrp5WEJaZsBDiJk
	ekao4J3Q0pdVZNzNXJvhisFNGSgZhIL3I2pZywyjnycjZQMe1MHdCQbF2lNA+815R7DxjzF4dDm
	41fCn3aqZFiGuErjbm3pT6QPTpv2b+R2f/+bB1lhxQe54KLmT6Vy3ceu2ooKLsZAqLRIzcvFMcJ
	ZCHz8hKFAkV+S3TCN7MbCxe5KYLs9lSEd7eUNRXSBSjVd7mWmn7iM9JbsG1JX60XUia4QULXMmI
	jICP2t/6qPUFYvguT7s0=
X-Google-Smtp-Source: AGHT+IEf9c6kwoiIpN+a2MZ0HbS9Mmr9K12+N98aGW0tMtHt4ybp37bnK02L8TRsbNfmOUe+ef7j0w==
X-Received: by 2002:a05:620a:2953:b0:7c5:3c0a:ab7e with SMTP id af79cd13be357-7cad5b20805mr2276438785a.5.1746541323354;
        Tue, 06 May 2025 07:22:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad243f477sm715703285a.96.2025.05.06.07.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 07:22:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCJBK-000000006iP-1U2Q;
	Tue, 06 May 2025 11:22:02 -0300
Date: Tue, 6 May 2025 11:22:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
Message-ID: <20250506142202.GJ2260621@ziepe.ca>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org>
 <aBoJ64qDSp7U3twh@infradead.org>
 <20250506131722.GG2260621@ziepe.ca>
 <aBoRSeERzax5lTvH@infradead.org>
 <20250506135536.GH2260621@ziepe.ca>
 <be740f28-8d68-400c-85bc-81cc4e48ccc6@kernel.org>
 <20250506141705.GI2260621@ziepe.ca>
 <d7115cd7-c34c-4212-b244-e5247ac68fcc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7115cd7-c34c-4212-b244-e5247ac68fcc@kernel.org>

On Tue, May 06, 2025 at 10:19:06AM -0400, Chuck Lever wrote:
> >> In this patch I'm trying to include the reg/inv multiplier in the
> >> calculation, but that doesn't seem to be enough to make "accept"
> >> reliable, IMO due to this extra calculation in calc_sq_size().
> > 
> > Did ib_create_qp get called with more than max_qp_wr ?
> 
> The request was for, like, 9300 SQEs. max_qp_wr is 32K on my systems.

Sounds like it is broken then..

	props->max_qp_wr	   = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);

So it is ignoring the wqe_size adustment.. It should adjust by the worst
case result of calc_send_wqe() for the device..

Jason


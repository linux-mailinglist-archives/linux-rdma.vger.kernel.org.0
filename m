Return-Path: <linux-rdma+bounces-10081-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E638AAC5A0
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 15:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12EC1BA402C
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72190280A4C;
	Tue,  6 May 2025 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R18qfL3/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824FB280A5F
	for <linux-rdma@vger.kernel.org>; Tue,  6 May 2025 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537448; cv=none; b=G0ViF5Axt7zPBTXFkM4C+HRPosMx8fDbQwYaA86o5XYdsAzf4Beqozeh+eELytCwgmODbqKOWsoau7B53RvVRaKmI8DmB+HBHU+TXBSWQhDjlWVdOA+sG9nA//emNQvNXEiWOAVPzSC0AZEjbzub9tWFqzPrdvffYMT5VnDJIRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537448; c=relaxed/simple;
	bh=zOWPFcMg5/rUXVQilTNMWhWzXB/DXnHjtYE89ddoAPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiftbLudbkzVhDPXGlktmZFNaMraRUckh7yvPU5kZdbcDgVlsf3qWXcUQfT1EXjMsukFMO1+p0dO6wcjA9reFtQge05MfrLufC4ew04RgaeQ+pwqZ4h43LsIdSTurFebHqwPdAy0+JF1LkYQKr98uhiLhT/NhxTUUOL6UlKpQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R18qfL3/; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f5365bdbaeso6751406d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 06 May 2025 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1746537444; x=1747142244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWRXmwgxF9LGLQEORNHNmU3tywRIiY/1OxxdWmpHbjc=;
        b=R18qfL3/yQ/lWL0dZlgyCBE/yqkhE2rPdRRy0vgs9eGffCn2N9gb025qSwOMLRMftJ
         qFSMMG38HPgIRNWYisUOeit1HAXaWMqi1y+NRMEjLTgOQwjehWBHbvIOvRGrD6Er+4lS
         KasqfuwtH2NVgOlQk2PaooDqc93OXuq81BAlWhl2D3vf7kd6xMM9XW8WT1IbEGLqj5bV
         rABDSlWfERGQ0P5UiRq4hjHaqg8y3pFzmqH6aaxlC1miJzbHPoGI2CWWgF5Ow2smsW6m
         I2CiNKPVHe8IBlsu8estGe5IuGGJBGka3ynSl6UVHZvulZSl7Ixog5e0ugBeU+X/5KdR
         7FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746537444; x=1747142244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWRXmwgxF9LGLQEORNHNmU3tywRIiY/1OxxdWmpHbjc=;
        b=Ly1shYXHFr4L8TsQseeAnH6wzbMLrrln2LVsmS4akevZfF+xooHpmvUc9t8qpVFqaL
         saGB8Lx8bwrFwG3em9M43eJImFQ00nnF7fqXi8tO1NVi6phoFBLTwluR8p+AiYCdO5np
         ymdI35TqsqySTVvbKD/Ks+A0nvbu455Lq8Wu7RFJQmx7Cbr7vD+rMC52/TGzuiG5E4K/
         UQy3C0c5ES6zMCelDvZKjnrHqmsvvcR6uXu5R4VI2GC5hOnozum4T/Oi3LbEpQC1Wa4I
         hLWw7bH7BqPwGm8rrZA+XmQVF5lSVdu6n/JfX6idt9tyNgm57KXQT/jOl9G6Fi/MHCOL
         UWhg==
X-Forwarded-Encrypted: i=1; AJvYcCVqDZTl48i2Lza+rw4OlNMJiF6BENDkQ1R0+yCm+7be/SrhN9fSL5VscZd+MjZ2geHo+K5bo+kjQpA1@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYz5cJQNZOMcHG76/ZfoiQbE/72hnKfBQP9SkVzTwmVTeY0+7
	Au0UfPOww45lO4+s+6k+LZmM8939B1rnuirMd0ucDud6g2WnY8veh03U1ggrobY=
X-Gm-Gg: ASbGncuqe6t8j4qs2gjTjwMdKWQP+NWzixRSzexVINqBKHw3u9Q+FJWW+svRpsMs04a
	VTVX+Hb3SJgvGM5hBavKGPJg/h2bRon3Ur/0fGfpDOOb4tjkxbymc+fHhsIHB3Jb3aB+Lxdu5aG
	IVkL05mycYMKwbF0UpbVJvPTt5CJJDteAukmBJfhSbfqIsXv3E9Uwn4MpbkU2M+j2z9OfyniDgL
	MaWUQA4rNNxNYKlzD4kq86jFUkcPG5LbyibdnLygGgvzYG4YUkYzMbSKTMLWhVcyMZF+gexgrZ1
	jVb4NVAH/ZPe4Lf/dcqqpSzSikpHd0Tp+mZsSkd5rNzl7poqrO1iGY8o+83wzs8gOLvLEyaFOMA
	CfzemA/LvcH2DrPuCdFM=
X-Google-Smtp-Source: AGHT+IFrBttW6itqiNoiRlayMr/qVUGoDyIojTM9Jzrprpd8/OG72m57yCuZOFflW75AZeQ89djoeg==
X-Received: by 2002:a05:6214:b67:b0:6d8:b115:76a6 with SMTP id 6a1803df08f44-6f5353718ccmr61216306d6.0.1746537443839;
        Tue, 06 May 2025 06:17:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f53dc56902sm4006276d6.50.2025.05.06.06.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 06:17:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uCIAk-000000005KX-2ead;
	Tue, 06 May 2025 10:17:22 -0300
Date: Tue, 6 May 2025 10:17:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: cel@kernel.org, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
Message-ID: <20250506131722.GG2260621@ziepe.ca>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org>
 <aBoJ64qDSp7U3twh@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBoJ64qDSp7U3twh@infradead.org>

On Tue, May 06, 2025 at 06:08:59AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 28, 2025 at 03:36:49PM -0400, cel@kernel.org wrote:
> > qp_attr.cap.max_rdma_ctxs. The QP's actual Send Queue length is on
> > the order of the sum of qp_attr.cap.max_send_wr and a factor times
> > qp_attr.cap.max_rdma_ctxs. The factor can be up to three, depending
> > on whether MR operations are required before RDMA Reads.
> > 
> > This limit is not visible to RDMA consumers via dev->attrs. When the
> > limit is surpassed, QP creation fails with -ENOMEM. For example:
> 
> Can we find a way to expose this limit from the HCA drivers and the
> RDMA core?

Shouldn't it be max_qp_wr?

Jason


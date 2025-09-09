Return-Path: <linux-rdma+bounces-13211-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FFAB50185
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 17:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39ACD7A5EE4
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B894F26D4F9;
	Tue,  9 Sep 2025 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YhT1NqWn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A62690D1
	for <linux-rdma@vger.kernel.org>; Tue,  9 Sep 2025 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431898; cv=none; b=fmd8olK7OSKpzOyJ4wVsSDLjZQKJGX6/lJ02tPPiuv02M3t1dktIhQ8h9V86JXCQtpzr1rNXsMK4GpDD7KEpXwMcyfC/60vVynJ5t/+ukajEUjObJyNxK9M6qqj3wFnZUXWSDPFoDHKN+URPmNr7fI3v/8j4OL+UowYUsS76WMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431898; c=relaxed/simple;
	bh=ZiFhYdl2bjOWEjo1NqUMAnXwgT2PaGixslQiYutgRy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn1pCEaYwfXDhx54RCsnLvKuJM5SEHYlsNIEmnorkL/e8NCs1MfOWJ4GzT4SbVIxGfrPTmQqw2XgtlFkkwnRHyIdtqew1bvzBo6FJb86pkZEX7wvG7pCUvtCcQ3iMy+6rjVr/ycJjO477fKbO9dhQC8XiaFr2t+werR2YLU9zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YhT1NqWn; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b490287648so93930141cf.2
        for <linux-rdma@vger.kernel.org>; Tue, 09 Sep 2025 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757431895; x=1758036695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=498dEo+KF6gTc379XcLxpYOuwK2LCxMHvU+qZ/OXUfM=;
        b=YhT1NqWno+hgmBaBASpVCoyWjg2pvukMr8WzMjOQpwMofq8SZBnKETFAyBi8f6wDdA
         RqVQ43oqY0ylrBg7Fq/2m1eAplq069JCVIQYBPcXqSOvOwqstPdD4lEyKhxfISghJuov
         aAHdtVN8GL7m0xIZ+hGPT7VwHhdZJPW4/cXQXTOP8cGagfQ984mCxa5oXa5egzjUCiLA
         fCDZ1lAYhJPWIk8L8UXnPSzG1XkZ4/1J1o+Uxl+cYj6aoTgHBNfd8yNDm3j4ppbpo1Y+
         Qu2O8tuQAkHNXI0gFF2iE/6qkrkAP0SoqUdF5bx6M5AfNJcL9NAV1oeT3tHtkAE9awFm
         xWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757431895; x=1758036695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=498dEo+KF6gTc379XcLxpYOuwK2LCxMHvU+qZ/OXUfM=;
        b=EUkCyz9SLB14ZCi9MAexQNrGA423Pqzvz6mHOmBx5ZzJy9uPGfmexhD0iAAzJ5eDZU
         GwHMbeGTBz2lTH4h0Br50TZlty57WavpUejvu83PGvKX0HfNjg2nl7uC+gFRRxKcebi3
         FsrKTTBE2GVW3359CD+TNYEI9qJuWsfi75l41upBTXfkaiyo9FXKgFms8nFeYdYlzJFC
         UxWWPpYP/xRHJxrMUjiWD9OYhmJTZ3h2yUBcffXmtjbNoL/5F+F3lCF7pQ3LokeKlLWG
         ddSl3WYeWuS7+1sfo/imAyftKcON41aP5fxwI8P/c+zCFUSYxlEQ7vOkcsjFF3GxZqVO
         i0+A==
X-Forwarded-Encrypted: i=1; AJvYcCVJWfkBu808dUAUux4JmZK4UnoJM5mnOZulAl8QEOX5EW0vHQ7A1kTdcLaqT20QKyQZTdXL6uMmZlTH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8ftf6Ci4Yz8E5eGd+aTPhFMU3Q7/YoDScZvZ32SmbJjuLCFf
	pAO8/TiTNVYB1+HPb+I1Crnybqp/Rd1AUFfBPlVKj+E2tjaX+OmaJqPsRMHmXZQDzzo=
X-Gm-Gg: ASbGncvp9SqjtzA8mx0J/sHjyBSPQurBDj7A00+prhe1N5ySovUH0v0rVpgEs1WdE1g
	67ARSRYLpFuqakxjZdp9e2W4A6W1MXWOU35RhFoxkcm+YsSRYTA2PfyFR5TlsqaCCtLnuXjotKA
	u1ek4n9LvplNJW0HwGtsp9nwYDXm4yImHHwV5qYUmo6AVJKcd22ZM0jFDbv4mn/4aU70NmWvqj/
	Yi5ClsTFQ89vOT1OTik9OUQF4Bb/Vq1OOXCI8xb2qBuVKQrPD/d07WXu+n17Ir+QnGTrI8Wx2Ag
	W6rsEgngP+KrUgoaugtNZiFH9r4Hvzv6IifMglA7d8OmZBdQ7oOk4uJfPe5SPDsFsvE6BY9GP34
	Q+yGQxRkuZh63B6/XEfhcfMzpQNBrslnV8r7c2EAMkgoSlLMCwx84Uwym+u26e8R1T53J
X-Google-Smtp-Source: AGHT+IH7K1XIyNvmlwRcafXwBvIsTn6HhCOCwW9mXvrQDKTlxF6E0GAU/aFQzWje+0RX4kjUPitS3g==
X-Received: by 2002:a05:622a:5796:b0:4b2:ecfd:be0d with SMTP id d75a77b69052e-4b5f84b6e2emr137778461cf.81.1757431895263;
        Tue, 09 Sep 2025 08:31:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61ba8c52dsm10541271cf.20.2025.09.09.08.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:31:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uw0Jh-00000003i1N-3Pgp;
	Tue, 09 Sep 2025 12:31:33 -0300
Date: Tue, 9 Sep 2025 12:31:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] rdma_rxe: call comp_handler without holding
 cq->cq_lock
Message-ID: <20250909153133.GA882933@ziepe.ca>
References: <20250822081941.989520-1-philipp.reisner@linbit.com>
 <20250908142457.GA341237@unreal>
 <CADGDV=XNrmNo5gNZ1cX4eGUi+0xgAcQzra+pNHNGuQbc0DrpKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADGDV=XNrmNo5gNZ1cX4eGUi+0xgAcQzra+pNHNGuQbc0DrpKA@mail.gmail.com>

On Tue, Sep 09, 2025 at 04:48:19PM +0200, Philipp Reisner wrote:
> On Mon, Sep 8, 2025 at 4:25 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Aug 22, 2025 at 10:19:41AM +0200, Philipp Reisner wrote:
> > > Allow the comp_handler callback implementation to call ib_poll_cq().
> > > A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> > > And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
> >
> > Can you please be more specific about the deadlock?
> > Please write call stack to describe it.
> >
> Instead of a call stack, I write it from top to bottom:
> 
> The line numbers in the .c files are valid for Linux-6.16:
> 
> 1  rxe_cq_post()                      [rxe_cq.c:85]
> 2   spin_lock_irqsave()               [rxe_cq.c:93]
> 3   cq->ibcq.comp_handler()           [rxe_cq.c:116]
> 4    some_comp_handler()
> 5     ib_poll_cq()
> 6      cq->device->ops.poll_cq()      [ib_verbs.h:4037]
> 7       rxe_poll_cq()                 [rxe_verbs.c:1165]
> 8        spin_lock_irqsave()          [rxe_verbs.c:1172]
> 
> In line 8 of this call graph, it deadlocks because the spinlock
> was already acquired in line 2 of the call graph.

Is this even legal in verbs? I'm not sure you can do pull cq from a
interrupt driven comp handler.. Is something already doing this intree?

Jason


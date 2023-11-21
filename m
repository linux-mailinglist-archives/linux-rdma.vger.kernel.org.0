Return-Path: <linux-rdma+bounces-1-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56047F2208
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 01:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDDA1C218C0
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Nov 2023 00:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4217FB;
	Tue, 21 Nov 2023 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="E8mzQ1ag"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA26B9
	for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 16:16:43 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1f93d0cd2ddso853045fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 20 Nov 2023 16:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700525802; x=1701130602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eFIDOIZsi4Wp7oSoauvgti2UNaRlz40bEKInfExUSl4=;
        b=E8mzQ1agD4OiizKdvlyvflB8Ec592vi/SVEm89JnlS/KWHvT1sOT9wXE0iTxqw0dX0
         DlpVTR0Cb+woohP/ahK/X7ZnLdXNS7oYlaMbMGGIUtr31LzsTT+9KAVGM4tmamerrfSw
         YLTM6Vw6m757LaiPJu5aYBu5Tmbpq55WUAcKreTYW1ostNgi9jLWvbYw/DA8UMb/bmU2
         CweZkGKqunOi04er9E+g3CUIXGz+jxB+9DWlHL8p0DGnrqtbq99riRG8LMAyUpiVW8Gn
         hww7Lbl7YzUQ54pIq53RTRuLwCaj5l40CUDH4U70Wveg8Uei/v26hxrnhKXxLr9yp1Wi
         7UGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700525802; x=1701130602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFIDOIZsi4Wp7oSoauvgti2UNaRlz40bEKInfExUSl4=;
        b=I8Jnxkz6RYv1YYJrOCuDKyTRMh2p9apO1seYOZzhyzyS1c8iZunEttGPpngXBlVJkg
         xEjlodLULGIvK59nUjwcCXJeiimDD/ewO3UH0RQ0T9mFUiOs0puG7Tinu5+K1YPVxmGh
         tj5YJAXYwGOVdbwnlfG8sKC5ekQtkMIIIRJ4WrUcjtPWYKEnas8eP3mNrNmB6EZkEE68
         dfiURWwGTxB5+gUteiv1VMWlitSRfuSnZyPxvmdm9SIX9pL5YUyeU/jaD5yxbvNYugAQ
         mRcihoRKKGhLopoVY7CBV1GplGgbBydXS3CKiD0cmv9Ohwo8nM6phA58zmBFM7Rv5vO6
         zNmQ==
X-Gm-Message-State: AOJu0Yw2Z5ALplpkXg2bN1N3JRWHmbVmx93cIl41++zZjd4nmQ6nPAMi
	h+xJBsYvHCa9qsbaE4iQea0d1w==
X-Google-Smtp-Source: AGHT+IGHBgDIDnvFKEoz/MeB0eCJt5O8fUmDLPwFr4y78jkH4qLhWr/Far/iLLwJvcNOQ63cFJeUdQ==
X-Received: by 2002:a05:6870:239f:b0:1e9:c7cc:df9a with SMTP id e31-20020a056870239f00b001e9c7ccdf9amr10019008oap.11.1700525802253;
        Mon, 20 Nov 2023 16:16:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id cj3-20020a05687c040300b001e11ad88f7csm1553651oac.30.2023.11.20.16.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 16:16:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r5ERU-0019uY-Tg;
	Mon, 20 Nov 2023 20:16:40 -0400
Date: Mon, 20 Nov 2023 20:16:40 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jack Wang <jinpu.wang@ionos.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH 0/2] bugfix for ipoib
Message-ID: <20231121001640.GG10140@ziepe.ca>
References: <20231120203501.321587-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120203501.321587-1-jinpu.wang@ionos.com>

On Mon, Nov 20, 2023 at 09:34:59PM +0100, Jack Wang wrote:
> We run into queue timeout often with call trace as such:
> NETDEV WATCHDOG: ib0.beef (): transmit queue 26 timed out
> Call Trace:
> call_timer_fn+0x27/0x100
> __run_timers.part.0+0x1be/0x230
> ? mlx5_cq_tasklet_cb+0x6d/0x140 [mlx5_core]
> run_timer_softirq+0x26/0x50
> __do_softirq+0xbc/0x26d
> asm_call_irq_on_stack+0xf/0x20
> ib0.beef: transmit timeout: latency 10 msecs
> ib0.beef: queue stopped 0, tx_head 0, tx_tail 0, global_tx_head 0, global_tx_tail 0
> 
> The last two message repeated for days.

You shouldn't get tx timeouts and fully stuck queues like that, it
suggests something else is very wrong in that system.

> After cross check with Mellanox OFED, I noticed some bugfix are missing in
> upstream, hence I take the liberty to send them out.

Recovery is recovery, it is just RAS

Jason


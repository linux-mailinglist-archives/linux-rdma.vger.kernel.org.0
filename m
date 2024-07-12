Return-Path: <linux-rdma+bounces-3848-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC1392FAE6
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 15:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD561C20F9C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 13:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B19116F29A;
	Fri, 12 Jul 2024 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="R2KyjV6r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6E14EC5E
	for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720789740; cv=none; b=QDeNAkARE2JjpUpuAwn1C1cJxMlhfojVxADMFVSJjD1pL1gbVSWMwEHaE8bR4QbCx1QQRcJt+NlyAURBFN+l/NMgXGo9xCbYIj3t7LUsj3isscR8lzFNnZJxoImTRPYzvhhdceb8qsC/srYT9/3dt7JgvZAOPcCiVe9YkM3F26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720789740; c=relaxed/simple;
	bh=3AmsmophFLKT3bJXWf1OtdfGj5X9gQP2Z52esz+0lGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEZMoPwFz7EwhIwZ/GWxP/GhekC9cC/RKdn/K4GUAQJcSYNvPC1IxRzIqBrV03yu+KH5HP+evVzclQMP+nF/VTiKNLk+YPTRcHXuZJrnF13JGaD4BC6OZyg/gMOpyXv+n4WcQEA+SJf+Dq+png52kMTEOTgbwFcD9ERY0jxaXcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=R2KyjV6r; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b5f128b18bso11640136d6.0
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2024 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720789737; x=1721394537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4jYmwN/QXFZLbYovizkcE85YvZFmyIlwRDsiMLcnTs=;
        b=R2KyjV6rwsuu+X4NshNd2w33RropfVMMzywkLf2+Vn8abcdTYxt0pG1mYkQ4rmLQ6V
         2u8/6sl3/9rMaDyK0Ys46vTOR5GUOCYw8wBkJ3pkFDjPgeziUxCDLGIleAk3l165B9ne
         Hi4d0sV4Kll5GFNwhvP5EGgh3GDJrNb6mBs0BtqPIhbadr2pC1z7WBIl0GzUbfS4nhZt
         OeEK3+KA9qy/6dDdYbuzjtWTdkHlmoWKuOwJvBhlZR4BMl2UAyE4s5n0+8BAZ8HvTPE5
         aWxfCG/Uglwd/mhUJ4tcTtty29KCirADW+lSI7dVRTHhj1fv9rH5/BTIr8bKFTp77n2c
         GcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720789737; x=1721394537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4jYmwN/QXFZLbYovizkcE85YvZFmyIlwRDsiMLcnTs=;
        b=QIApxSYcwIbDaFJrRzC0QGFSU7IFwpqFfXD/ow7Url28/j6cvUAL9hexV2I4/2WMOP
         mN33tvwVPu4y1TLHrN8K0EqnCG5RaC2JyDomupQSn6zu1k7UiaMn+W3zCR6G2S7/s2l/
         5q17kAj2xvrIx5+U2FfXvB85JvbLtuwb9J6G23nABVdjVLzX3oTf57Cqkeo2FqAnn5Qf
         E6a8OTi6wFrz+1on4eT4XdTCSph5qH3vHalMExieZUAHn/LgShXjqXASswRElpac9+1q
         sSDzBqxWZzhsLqxYShz21iEMVzd1LZNiSEBuS6jK5BI/oLgTaoCFkbL3KndnCzd2bgdW
         JVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXjC/hi1N79ymKj1VEtxJuPSSduvAQkl+5vwixcwMB0nZCIj3Nn9iT8OZXa/wxksjYFeO2r2XwYeW8pLPy4IFKjH5WOTDEBELnSQ==
X-Gm-Message-State: AOJu0Yz0MotrOMJOh3fiwMs7WT8O+CCEvT5NtMrPUPnaWkXsJita8B/P
	duuFI4f0HhKQG237HVdKCnpQaJpMN7Daj7AEKxO5+zkuVUiDJbC/ICHnUcm9jdU=
X-Google-Smtp-Source: AGHT+IFoKtdu5vK1LEfozhtRvZwJjwwZjN4Ys9l4HkSqkcIyDGM+PoG745Jm0+Iu/Vp9ngs915k4vw==
X-Received: by 2002:a05:6214:27ee:b0:6b2:d335:e914 with SMTP id 6a1803df08f44-6b61c219e19mr144274106d6.52.1720789737313;
        Fri, 12 Jul 2024 06:08:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4daasm35005856d6.18.2024.07.12.06.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:08:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSG1A-000Kbx-Bd;
	Fri, 12 Jul 2024 10:08:56 -0300
Date: Fri, 12 Jul 2024 10:08:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Leon Romanovsky <leon@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 11/15] RDMA/hbl: add habanalabs RDMA driver
Message-ID: <20240712130856.GB14050@ziepe.ca>
References: <20240613082208.1439968-1-oshpigelman@habana.ai>
 <20240613082208.1439968-12-oshpigelman@habana.ai>
 <20240613191828.GJ4966@unreal>
 <fbb34afa-8a38-4124-9384-9b858ce2c4e5@habana.ai>
 <20240617190429.GB4025@unreal>
 <461bf44e-fd2f-4c8b-bc41-48d48e5a7fcb@habana.ai>
 <20240618125842.GG4025@unreal>
 <b4bda963-7026-4037-83e6-de74728569bd@habana.ai>
 <20240619105219.GO4025@unreal>
 <a5554266-55b7-4e96-b226-b686b8a6af89@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5554266-55b7-4e96-b226-b686b8a6af89@habana.ai>

On Fri, Jun 28, 2024 at 10:24:32AM +0000, Omer Shpigelman wrote:

> We need the core driver to access the IB driver (and to the ETH driver as
> well). As you wrote, we can't use exported symbols from our IB driver nor
> rely on function pointers, but what about providing the core driver an ops
> structure? meaning exporting a register function from the core driver that
> should be called by the IB driver during auxiliary device probe.
> Something like:
> 
> int hbl_cn_register_ib_aux_dev(struct auxiliary_device *adev,
> 			       struct hbl_ib_ops *ops)
> {
> ...
> }
> EXPORT_SYMBOL(hbl_cn_register_ib_aux_dev);

Definately do not do some kind of double-register like this.

The auxiliary_device scheme can already be extended to provide ops for
each sub device.

Like

struct habana_driver {
   struct auxiliary_driver base;
   const struct habana_ops *ops;
};

If the ops are justified or not is a different question.

> module reference counter. But we also get the ability to access the IB
> driver from the core driver (to report a HW error for example).

Report a HW error seems reasonable to me

Other driver have used notifier chains for this kind of stuff though.

Jason


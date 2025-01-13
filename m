Return-Path: <linux-rdma+bounces-6993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DE5A0C27E
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 21:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD53A6F9D
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jan 2025 20:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFBD1CDA3F;
	Mon, 13 Jan 2025 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lMmUGG/U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D41B422D
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736799376; cv=none; b=QIwIbFCrElNXPQha8HsHhSaWQQ0D69jyPI8ilLO4X+OqcexF0pa3HUMBlHgbPK4AnD5okBvE83dU8GiFGTbLHd2/vSwGLnz6WaUChoT4Vlff1I7otbt9KEPejIvUWCdRYxq1aAPRuDGSowcHHZF2kmYYzl6chBEq1zaCSasmLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736799376; c=relaxed/simple;
	bh=MyEof7sewwTZqWH0oZekNraGwzL6R7PK6gkhxRccXmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4VUyNJZOUzDLGwDtDj0uUha6Zk1wAOEK3hvITpZveewzFclEfA38o9jFjVA0Cc8Wh02zb5Mng2cwJ1Tqph8EbwJsZL9xx0kbfH1lD9DdH8qrkVCsKnrB/lxefB3xqU5qUGR7IH1Lb/RWmmFmHxDxvz6ydAgeVCtdYH8yVNCBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lMmUGG/U; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6f19a6c04so430274185a.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jan 2025 12:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1736799373; x=1737404173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAji/BaEzNe2xaZcTtq4Gz2pQcrkRBfA3gTcPpODPhs=;
        b=lMmUGG/U//MJpAZh6XsN7pdxXRp8qqxmgu/mrVXYhhRbeGVWanSDvYRp5PWMz0my8f
         1lqETD2obLoBh2xZ7fWvWHRaWEW9qvLq66nd3lJdsev6VjX6FJliUAJKvPJdEXWlC5aO
         yrcwMM95EaAklFWMXzf5LZLLC4SkE/jW5Cj/Piw8E6ppkM6a+Nz1WEYkQ5+agrfJDtKW
         5QuxzJoQKnMPHWxJpxW+72t3qCX58oXBzHOBYtKPU9OpcZ8sse8wTfjYYJpJgnL1qqLu
         OfQ3j7IdXa6AqsK7N+nnyhD2S2qYTyoXe+VIzK1QfHTC4rEiV5/s8YvvHC3mE1QtfKGM
         xs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736799373; x=1737404173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAji/BaEzNe2xaZcTtq4Gz2pQcrkRBfA3gTcPpODPhs=;
        b=YCL3b/jB/jq4bCWliZD35g+gBvJqYdPWSNkeyx8CLygck0/jq3pJvVdW7PI4p1gOLW
         x8mk6YdstHIecay1DvEc3oyNWjQfO6B7ThwO236swB76r8xwL/w8K07GJ6B3OLIAF/+G
         IxGb4C1KBS9MDdmGTFNRl66x5GWMnw+iwBU/8AdaWt2d9F0yK7JWiMWGYsiMlYMmXH8P
         vPSwFy4tpvPoUL8OSSGleyOvy4Ma90EJPcN6pfbXdfxA4mckXZjM8YGk6hfO7t8MgNLh
         X45s8AiscQLMn8ohPvBxDsm6RgSpDcpvt78qZsTxfWgZ8Uhtj+ECuNt3jM0cvgxJU/K7
         8KHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbGFqeif5ZOQAGhDao4snv+hsOSxeMkFGmIF6aKOzY5NjKosk06lNRPl4moYopom86Jhi6V/YZndEZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw33LbGYTE481zSvfSfa5LItVrFFM8eh1Ghf88CLDXKgCsUPTU
	SRx0SUcLMo9Pz/AIfGSm5e4fwtLvazpU6cJ4M+XgYYB+I8UR7hI74hjn9qMhFIY=
X-Gm-Gg: ASbGncsGVOg5mp+PoQ2joIjUWluajnCDYy16xELRnDev3UTIR/AHuxGOQjktYknVIke
	aJm3SR2LmVrab/r0UNKOrKhU6BKnNpL99xbboh09yLKNOvaXRnjh7aIXzhGymXDvjLkW82MNv+Q
	3MRTKd/06Va3xSYi9qRxy2pUfeSvDvnpOV1hpY5oG9lkMN20tI82agpI0am6CX3DsSmCkjAEzjH
	+w2TTSzx8t2rKSeHUNYV/XQIo3GPlWrOK9ILt531WPuCO/Av593J6gS9hTBMoDuf96P3RMY4Whr
	BK6to7d1yWfnEfLEhdM7ynETBvItOQ==
X-Google-Smtp-Source: AGHT+IHo3Mz1vKNcokkBbim1vP9RGO6dYA3VuUNg2gKiMYSRYvapHAAT5GEF83WyW8n11joAx/p95Q==
X-Received: by 2002:a05:620a:6601:b0:7b6:c486:c4fc with SMTP id af79cd13be357-7bcd9727aa6mr3444940085a.4.1736799373040;
        Mon, 13 Jan 2025 12:16:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516004sm525855085a.101.2025.01.13.12.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 12:16:12 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tXQr5-00000002HNX-1oNN;
	Mon, 13 Jan 2025 16:16:11 -0400
Date: Mon, 13 Jan 2025 16:16:11 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joe Klein <joe.klein812@gmail.com>
Cc: "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>,
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-next v9 0/5] On-Demand Paging on SoftRoCE
Message-ID: <20250113201611.GI26854@ziepe.ca>
References: <20241220100936.2193541-1-matsuda-daisuke@fujitsu.com>
 <CAHjRaAeXCC+AAV+Ne0cJMpZJYxbD8ox28kp966wkdVJLJdSC_g@mail.gmail.com>
 <OS3PR01MB98654FDD5E833D1C409B9C2CE5022@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <OS3PR01MB9865F967A8BE67AE332FC926E5032@OS3PR01MB9865.jpnprd01.prod.outlook.com>
 <20250103150546.GD26854@ziepe.ca>
 <CAHjRaAfuTDGP9TKqBWVDE32t0JzE3jpL8WPBpO_iMhrgMS6MFQ@mail.gmail.com>
 <CAHjRaAd+x1DapbWu0eMXdFuVru5Jw8jzTHyXo2-+RSZYUK9vgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHjRaAd+x1DapbWu0eMXdFuVru5Jw8jzTHyXo2-+RSZYUK9vgg@mail.gmail.com>

On Mon, Jan 13, 2025 at 02:15:27PM +0100, Joe Klein wrote:

> > > > Possibly, there was a regression in libibverbs between v39.0-1 and v50.0-2build2.
> > > > We need to take a closer look to resolve the malfunction of rxe on Ubuntu 24.04.
> > >
> > > That's distressing.
> > >
> > > > In conclusion, I believe there is nothing in my ODP patches that could cause
> > > > the rxe driver to fail. I would appreciate any feedback on potential improvements.
> > >
> > > What am I supposed to do with this though?
> > >
> > > Joe, can you please answer Daisuke's questions on what problems you
> > > observed and if you observe them without the ODP patches?
> >
> > Will make tests and let you know the result very soon.
> 
> Need time to complete the test scenario configurations.
> 
> We made tests again. Some memory errors are from RXE ODP.
> The whole tests can not be complete with this patch set.
> Without this patch set, all the tests can pass.

Can you share your logs so that Daisuke can resolve whatever the
problem is?

Jason


Return-Path: <linux-rdma+bounces-538-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A48918241E5
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jan 2024 13:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD61BB23E02
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jan 2024 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA68C21A1B;
	Thu,  4 Jan 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BudWBaX3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911922094
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jan 2024 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ba14203a34so328555b6e.1
        for <linux-rdma@vger.kernel.org>; Thu, 04 Jan 2024 04:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704371849; x=1704976649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hf/WO7dpSxOwRzBOXg5oe62I+hQuDL4PKjYM4SM/3gc=;
        b=BudWBaX3rXZ32flH1YDE5MSwR7DrNYSqH9VGDWO4+Q8Dbcjv1ERLA6gUQxGrS640Sk
         PKEviOs5cGxil6ziJXC8nIi4Ft4AKnlB+aYO8JDuhrAa9lF5UuD760w2M582j30isq+3
         IqGjiiSjE+t6Iuhai2axIhLEqUbZYe9gVG/tzzWbRPnbIjcS+3nJhTfouevW2DHFR7U8
         Q0YvHZ5jL1OULtv7kALZ6R6FOV8kWJhcRfS4v4er7iaUQd0S/uttoc62azUQfPALoMEE
         7xBuRFNGL+0xj6LlJTUDT4B8lQLAw+xEO+FbpeuETIo/IA27imMPEMJGeDDO04e0Facf
         2JUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704371849; x=1704976649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hf/WO7dpSxOwRzBOXg5oe62I+hQuDL4PKjYM4SM/3gc=;
        b=OvzssnN9LOQSih4035lkqVpcnZ97NkJSPtlEzVf9ZsK2KKjsXq40Ae4u4xnIYY4zvw
         PeQCDqUGX8o8JMLZSkBLJC1Ixzp6J73WJoRGpdPKIhu+mgvyRmSah1AjgkQMDV9mlxfT
         RbzAKbfI2riYWj0EZAB6WL0uWrX+Aqm0r2OhHhptY2e9sSfIekYWCIV6MVFdfxp2ievN
         6OOvm0dV+9SNQ86AgFD2pef3DDU5nAY7IYaKr80FrOA5sXYRxRvgPKIkfXzla1I5a2EF
         DLogLhriyvzwDuhAzjlTkcyNNJluhUASBPEZtVJkBD1VEiVEIE6y6szXLaZnnAuJzHEu
         hHgw==
X-Gm-Message-State: AOJu0YyXMiR/BCycp3rbayjM7JWkKMFZBQFVyoMH6mv2QzyAgaACCBDT
	AdD4cOj7F8Rt4W+BnI4R5qOVIsopgVfeNg==
X-Google-Smtp-Source: AGHT+IGHenxmOLwVI1m0q3Nd7JBq+/yjCUMw/euLk5orZbJN6ioJA9VMp0JTTfG1Gf+gJgKnh1+Khg==
X-Received: by 2002:a05:6808:2918:b0:3bb:d7ff:982d with SMTP id ev24-20020a056808291800b003bbd7ff982dmr462984oib.98.1704371849776;
        Thu, 04 Jan 2024 04:37:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id z8-20020ad44148000000b0067f7e41de80sm11660650qvp.46.2024.01.04.04.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 04:37:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLMyW-0017pG-9U;
	Thu, 04 Jan 2024 08:37:28 -0400
Date: Thu, 4 Jan 2024 08:37:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shifeng Li <lishifeng@sangfor.com.cn>
Cc: leon@kernel.org, wenglianfa@huawei.com, gustavoars@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shifeng Li <lishifeng1992@126.com>,
	"Ding, Hui" <dinghui@sangfor.com.cn>
Subject: Re: [PATCH] RDMA/device: Fix a race between mad_client and cm_client
 init
Message-ID: <20240104123728.GC50608@ziepe.ca>
References: <20240102034335.34842-1-lishifeng@sangfor.com.cn>
 <20240103184804.GB50608@ziepe.ca>
 <80cac9fd-7fed-403e-8889-78e2fc7a49b0@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80cac9fd-7fed-403e-8889-78e2fc7a49b0@sangfor.com.cn>

On Thu, Jan 04, 2024 at 02:48:14PM +0800, Shifeng Li wrote:

> The root cause is that mad_client and cm_client may init concurrently
> when devices_rwsem write semaphore is downgraded in enable_device_and_get() like:

That can't be true, the module loader infrastructue ensures those two
things are sequential.

You are trying to say that the post-client fixup stuff will still see
the DEVICE_REGISTERED before it reaches the clients_rwsem lock?

That probably just says the clients_rwsem should be obtained before
changing the DEVICE_STATE too :\

Jason


Return-Path: <linux-rdma+bounces-15019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 455FDCC066C
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 01:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D66A5300DC98
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Dec 2025 00:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B471C23EA81;
	Tue, 16 Dec 2025 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CG+ZPN/2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F622DF68
	for <linux-rdma@vger.kernel.org>; Tue, 16 Dec 2025 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846629; cv=none; b=b7iNudZLCvQ/3kxGiTodC/Y+pfWh4SeNmEAdjig/iEk5Z2o5djJsplRU7p/PpXwr24WBezqUWlCRG7SQsjHeoo3JWLc74JgXgCcLpDpfYhah8bWDv5sQ65ZipBnxgupupu/Bgp8CxXxlbdVEfsCXVG6OVp/A7V86Lkkkpdd59cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846629; c=relaxed/simple;
	bh=QezPYSYTY8jyA8T5MiPTniswqhsfgFbCDuDyZ1kn3s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2eX3sjL+mroVdSqP2eZW+l7ESK6sqGTIt00ST0GMO0YhQAqOYBkcGlwjWT8zTRZ/X2oeJ8C8WwEVxQPeqks3nPAC8sUr9LvjERBM5BUowIPSbGN75jBcby2Jjbyb0nfwEQ1622G9n2oMbdJgqDM0ZWQigD26/I/hVjgSkpd7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CG+ZPN/2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b602811a01so450991085a.2
        for <linux-rdma@vger.kernel.org>; Mon, 15 Dec 2025 16:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1765846626; x=1766451426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IPpXEBgVWwdvOViYbZAfQ/0F+69tA1X6CeobJwJ6WR0=;
        b=CG+ZPN/2t2pJNeNDIIurpWpFOgs1v//P3tVTr156tjbQLlPupLFEVg3JPN/i3ilOu4
         5zYgUImy9YnAOSp+t1MFFMWIBR3MlZqzSw0BbRx0biQoaLHmsKJNtcXgV78oYqD+o3+G
         sWiLi8MdETK796lIStu2YcoYHqE9r6nTTXBj5+b1V7lPb2i3UyWsdhv//UeMYknbwKKK
         QfZUNr8J0IkDAVJMWyXqdFQJBmfQNdoaRdzMBBHzmDd65o2XX4reNlLjoSg6xwpEFJtQ
         l7fso7aL3MnR6VwLRu95i4ui5OdSgjMxh/dBbbFGrls5BMVQ2wzG4GJwEzH1wLExcgwR
         zZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765846626; x=1766451426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPpXEBgVWwdvOViYbZAfQ/0F+69tA1X6CeobJwJ6WR0=;
        b=FbKNNHEHZnMokzsZxAdrhLqQZWzuaifiQEFd3iOcgA8ZKxrv6TO0egvEh4ukQ/ob+M
         CT7/O7l5tKen+SqUNzRmd8zbBiqUWLR4wcq23tKP8y8CBNOO7NVzWm3bD4F8L0beHVAk
         368AC6GWsagSyeL4yXwpzJ89FXIDb6b4CGvn+Bk1RE0TAX9y7By2HmtxqhOY0z3Kxngc
         XgYykfzSrTcoWIBD4J+vNOKGKbLZUlfQFDoKTIpzqzcG40aTRhHEilu/hwbHhuHxBeut
         YInaDasx0dJfQ8OUsjH54scP7kFUyj6IcOI1RQVYqNKZp9etG6ympes8kvV+nlGbtDmz
         Qk1A==
X-Forwarded-Encrypted: i=1; AJvYcCW0ppjexeXN85lMT5s+N7YNPfKix5czHA39LR3k979gvZDYyfbSv4lccEXOJn8qBAsHD9n5HBIfEV13@vger.kernel.org
X-Gm-Message-State: AOJu0YyYs2uwp7ww8z3bK3HGoT56FtCkmRc4JLgQym4ahqg/noLlj2SN
	4+xL5Tabqa/WAWkXpyTJ8adQXe/ychzlRY1wpTYBK4/oklc0x6b9jOr6nfKWXie2Okw=
X-Gm-Gg: AY/fxX7TUPOYVMyc5whwJuJqjN6IJ9czRWFXGuT3044MAeBSFm+nRqissgTc0PWj/09
	LAFYSKtTiyn3ODAzbaHHcfJ3O1LNkUbBbLfnUv8zfnJDj9xwCiN4gErmwxsMmtYdPpk9gIdulH3
	JuF9NKCnQlwWaRWGov28UxagsPE01aegIdCIq+/MjZkB5gAfIZV7pm5NfsIptChKyNSZY/VG8Ky
	PsO1WoZ32mJkzlDh1/lKZ0Cdcrr4cd4gyP6TFxn5X2tSiwDL0TG/2e8Y2pm9vJe2AxPKc9Uz1X4
	YrUbrhHVufvpDoTBpn3ihuV/dxg4t6Jl3yclqF7BlvBK0TDSC2wUkmu/b1p3O1uet7G2Fx0+sVR
	oQ3F5RjytUB5gZ4NUH+IstwAIDMgJ2OPQiOvWoIBkaUN5VG+YtH9HU0vIEbjMtYp+k4cnk/OOYH
	mAGobg0iZjYjbDIHk42uceszJyX+Oqr1/WdsA12aRhxdW0n3Jp+X/qbmrJZ3sovAKmxVM=
X-Google-Smtp-Source: AGHT+IFNRf5SYkdPtX8YbOp8FcLkqV1bOWRJhWcEbpFL7AiAOiWiOC2cyMdz9cLiPNPjgwCt2PsvcQ==
X-Received: by 2002:a05:620a:44d5:b0:8aa:f08:bed0 with SMTP id af79cd13be357-8bb3a39df6fmr1819982185a.79.1765846626202;
        Mon, 15 Dec 2025 16:57:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88993b59838sm63654226d6.13.2025.12.15.16.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:57:05 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vVJNB-000000008Lt-0Rrp;
	Mon, 15 Dec 2025 20:57:05 -0400
Date: Mon, 15 Dec 2025 20:57:05 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: wujing <realwujing@qq.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH] IB/core: Fix ABBA deadlock in rdma_dev_exit_net
Message-ID: <20251216005705.GB31492@ziepe.ca>
References: <tencent_96252FF6CE27E9F41F13AC73CCC1BE350905@qq.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_96252FF6CE27E9F41F13AC73CCC1BE350905@qq.com>

On Thu, Dec 11, 2025 at 04:08:13PM +0800, wujing wrote:
> Classic ABBA deadlock due to inconsistent lock ordering between
> rdma_dev_exit_net() and rdma_dev_init_net():
> 
> Thread A (cleanup_net workqueue -> kworker/u256:1):
>   rdma_dev_exit_net():
>     down_write(&rdma_nets_rwsem)  <- held at line rdma_dev_exit_net+0x60
>     down_read(&devices_rwsem)      <- waiting (shown in rwsem_down_write_slowpath)

This isn't right, it unlocked the &rdma_nets_rwsem:

        down_write(&rdma_nets_rwsem);
        /*
         * Prevent the ID from being re-used and hide the id from xa_for_each.
         */
        ret = xa_err(xa_store(&rdma_nets, rnet->id, NULL, GFP_KERNEL));
        WARN_ON(ret);
        up_write(&rdma_nets_rwsem);  <------

        down_read(&devices_rwsem);

It is not nested and there is not a dependency.

> Thread B (stress-ng-clone processes):
>   rdma_dev_init_net():
>     down_read(&devices_rwsem)      <- held at line rdma_dev_init_net+0x120
>     down_read(&rdma_nets_rwsem)    <- waiting (blocked by pending writer from Thread A)

This one is nested though.

I don't know what your bug is, but it is not some trivial ABBA
deadlock, lockdep would have found something like that ages ago.

Jason


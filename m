Return-Path: <linux-rdma+bounces-3398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EEC912653
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46A91C20E20
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 13:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0C153835;
	Fri, 21 Jun 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VJo2Zis7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611B14F13F
	for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2024 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975154; cv=none; b=gLV5/+u13nGVPFFkrgQ2LtmzAtBTiaPvC+txm3DchY4ku6QRCvVQz33bOcBI6dmtI6E4PLAOVTIEefNXVtmGzBJcUwV/K6agHwwPod/RDHhwBfrhdu7WDsXnSYOF9PImywXxE/3+lJXp2RsXb5wpqdNu4WvbZJDMWewdM8fqWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975154; c=relaxed/simple;
	bh=Yb7Yvj1YgzjQRwDXPO286zPR/Ef3eehL0+s0q76BX5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5sIAZv+skGV0D8oxgFjUnEXPgqNLRALznNaSTeabVmPXIleaVoTflnFZTwZQx9vcY0TAQX3ZFckOs2JZo+Csm9MHXZDP6Q9XhE9eO6IS/7ykRqEpMTgCoQa5y2Ylp2qnrvfq9csAvl+bBTqhewaKG3prbRxMkGYA1d/1wkT8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VJo2Zis7; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-797a7f9b52eso152247085a.2
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2024 06:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718975144; x=1719579944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJK2yOT9FIqROi+Egt9eFviTEDPEGVADU23Q3cHDMEA=;
        b=VJo2Zis7OHeDdQery+XSM6+89CsaIHOdoNWIoaXvacR/m/bpMrHYC2MhUkaTCADJV6
         lUI6cShb+vlIAR1rJYjV8MgYMx8O8iqZvaMxyNZ2scBbTLzbhdXg8aZr9jtOBBB8dcTK
         35MGvFkneuimZSa4sECZpUpaMdRIl+gO1g4y9NLcmjRsBLnfyWiAR91An/3+k+TfSNjl
         s7h/eht5fvWH2Iy0CFQw2MIiEgX4DfTtnhyaaEE1NBKFdfhpj2DU7z4+Yn5GCMRKaLpR
         qNf/O3FwNiKOQ+FuVtBs03AENdCSJf1FaZW39UpSpxGR+kQ5iYB6T1N1cAzlgDuyYoMO
         AgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718975144; x=1719579944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJK2yOT9FIqROi+Egt9eFviTEDPEGVADU23Q3cHDMEA=;
        b=o/BRao+50j/4U46aEA4BSmz/MZsv6gHS+Tv6Ak3ACCNXXJaB3K3oaerRrSPJWJPnxO
         AhKzeZS/D1dxHWF3zM9dAx3eBYaJ2DEADPVJxCGYQ6/xQ/m5x79FLyx4syjqzAr9YyuA
         CFxuBVcwm/Kka1qPhjA+IkTSoq41bPY+IL15KAcgQ0S1M9JryCWNUSDE/I7oFQPgVTkO
         uU/1rIyWzFMpOKXrEr+1ZE43Il1Ei/PlRIMFfumwgN9XFJY9n798xjYnP2pVpfWEFSnf
         jLKPcxefkMX0g3b7zad26BfmPzqXuhJwkJeFcd1Kw6cAqtqgiSF++v0kCEONDUVr0rj1
         aZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiK35fxOhqhi6CnMtjjjTV8oBF5SFWiBYxWjz1jzbk/jaM/r5HTyL/CLcvFuQ9nW/4hBS/9Wck1mwEwD5aEt63tELgRRZ3J8AoXg==
X-Gm-Message-State: AOJu0Yx2mlyH5PGCPpq+V5pkB7QnQIHhMuu1kfCe9niNZJy2KiiMLshJ
	G3TIxxefUMZN9PiGMrbA5rAMsyGcjEQoDhJNpw5X11k2184B4nGIqOTgdT0KvAQ=
X-Google-Smtp-Source: AGHT+IGC6sZXSWKAGPHY/uyr89DZ9iZnRZxdRUjwa1W19Nf+VKCN9pvnvkoUjMCqTg/1PhtYsBAS3A==
X-Received: by 2002:ad4:5508:0:b0:6b2:9e65:2246 with SMTP id 6a1803df08f44-6b501e0a68emr84339226d6.1.1718975144122;
        Fri, 21 Jun 2024 06:05:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef678ebsm8545166d6.132.2024.06.21.06.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:05:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sKdxW-00HUFW-GK;
	Fri, 21 Jun 2024 10:05:42 -0300
Date: Fri, 21 Jun 2024 10:05:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: syzbot <syzbot+a35b4afb1f00c45977d0@syzkaller.appspotmail.com>
Cc: leon@kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rdma?] WARNING in gid_table_release_one
Message-ID: <20240621130542.GQ791043@ziepe.ca>
References: <0000000000000d0237061b4c6108@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000d0237061b4c6108@google.com>

On Wed, Jun 19, 2024 at 11:25:19PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a957267fa7e9 Add linux-next specific files for 20240611
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15a085de980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9a880e96898e79f8
> dashboard link: https://syzkaller.appspot.com/bug?extid=a35b4afb1f00c45977d0
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6451759a606b/disk-a957267f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7f635dbe5b8a/vmlinux-a957267f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/33eafd1b8aec/bzImage-a957267f.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a35b4afb1f00c45977d0@syzkaller.appspotmail.com
> 
> infiniband syz1: ib_query_port failed (-19)
> infiniband syz1: Couldn't set up InfiniBand P_Key/GID cache
> ------------[ cut here ]------------
> GID entry ref leak for dev syz1 index 0 ref=1
> WARNING: CPU: 1 PID: 12182 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
> WARNING: CPU: 1 PID: 12182 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x33f/0x4d0 drivers/infiniband/core/cache.c:886
> Modules linked in:

Oh look, we changed a dev_err to a WARN_ON and syzkaller immediately
reports that there is some kind of memory leaking bug in rxe :\

Jason


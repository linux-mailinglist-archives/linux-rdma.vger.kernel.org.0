Return-Path: <linux-rdma+bounces-2940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CF98FE561
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 13:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B901C22D43
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9FC1FAA;
	Thu,  6 Jun 2024 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGOAURs2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3057145C14
	for <linux-rdma@vger.kernel.org>; Thu,  6 Jun 2024 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673487; cv=none; b=uIZBtE+rKWWP0ljoDVCqnoc7rfeUdqzEdjy6Fi6KTeFmqs4llPmVZp9ASWrdDK5q8LDRMahZgVQqdM1Q2LfXFZNM6WkwE4qSETywVYIVevrDNvCo3RCcYDePHtWidJaA4sQvHt4n+a2NqxmdpZ5/tS9sgPkmcc/mzTzuQmVCLS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673487; c=relaxed/simple;
	bh=c21ncF4LD5w9wgc+ddGeBjKuWf0dlNtci4uPHd+IY2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8f4tNnozrKPrSZPnuXAjezFCW6/VSYnrUp8BUPKIpckPGkbkkB3fl3LwPOqKgGGFC+9WBvbHiSC8l9Up1wV5+rxtp+6nNC67pBPVIr0Nt1jM0OWbwY9lhE6UF78AjRBs7sYfQEGxd47P/ztcgNiaNxO1gRT4KQY6Zdv5mgQ9vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGOAURs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C9BC2BD10;
	Thu,  6 Jun 2024 11:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717673486;
	bh=c21ncF4LD5w9wgc+ddGeBjKuWf0dlNtci4uPHd+IY2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGOAURs2j0aZkDsyaieY0mM/zXrJ0Dad6nPMtcVbw9019FN/ipQyfsuD2NkwUxLIB
	 U9ADCDF50tVDgDKil00GsiebiRpYMpbTxZtCBO9ufQgqm6lJljKW1cTzyfmDfsudJi
	 BzDe3uJJr6pBslypGwwSsdfCj5mFrxJOXKSpo6TxyYG3lKItvzjxbiGHp8QmEYeUbm
	 Iadmercg+2S6/893cLhO0hgMeEchOkyITz1PVcJhQvELbQqJhyRZDvXOhOLfrwa8yD
	 YoZ4bBOf4BUAztC3ib9hCz9I7HFqNdMezG7gbN+bZZeT7W7KVZ1iFieWNs70shjwNC
	 R6DsCUm/+iJCQ==
Date: Thu, 6 Jun 2024 14:31:22 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"yu.zhang@ionos.com" <yu.zhang@ionos.com>,
	"mgalaxy@akamai.com" <mgalaxy@akamai.com>,
	"elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>,
	zhengchuan <zhengchuan@huawei.com>,
	"berrange@redhat.com" <berrange@redhat.com>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	Xiexiangyou <xiexiangyou@huawei.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"lixiao (H)" <lixiao91@huawei.com>,
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
	Wangjialin <wangjialin23@huawei.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
Message-ID: <20240606113122.GG13732@unreal>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <20240605035622-mutt-send-email-mst@kernel.org>
 <e39d065823da4ef9beb5b37c17c9a990@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e39d065823da4ef9beb5b37c17c9a990@huawei.com>

On Wed, Jun 05, 2024 at 10:00:24AM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Wednesday, June 5, 2024 3:57 PM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>
> > Cc: qemu-devel@nongnu.org; peterx@redhat.com; yu.zhang@ionos.com;
> > mgalaxy@akamai.com; elmar.gerdes@ionos.com; zhengchuan
> > <zhengchuan@huawei.com>; berrange@redhat.com; armbru@redhat.com;
> > lizhijian@fujitsu.com; pbonzini@redhat.com; Xiexiangyou
> > <xiexiangyou@huawei.com>; linux-rdma@vger.kernel.org; lixiao (H)
> > <lixiao91@huawei.com>; jinpu.wang@ionos.com; Wangjialin
> > <wangjialin23@huawei.com>
> > Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
> > 
> > On Tue, Jun 04, 2024 at 08:14:06PM +0800, Gonglei wrote:
> > > From: Jialin Wang <wangjialin23@huawei.com>
> > >
> > > Hi,
> > >
> > > This patch series attempts to refactor RDMA live migration by
> > > introducing a new QIOChannelRDMA class based on the rsocket API.
> > >
> > > The /usr/include/rdma/rsocket.h provides a higher level rsocket API
> > > that is a 1-1 match of the normal kernel 'sockets' API, which hides
> > > the detail of rdma protocol into rsocket and allows us to add support
> > > for some modern features like multifd more easily.
> > >
> > > Here is the previous discussion on refactoring RDMA live migration
> > > using the rsocket API:
> > >
> > > https://lore.kernel.org/qemu-devel/20240328130255.52257-1-philmd@linar
> > > o.org/
> > >
> > > We have encountered some bugs when using rsocket and plan to submit
> > > them to the rdma-core community.
> > >
> > > In addition, the use of rsocket makes our programming more convenient,
> > > but it must be noted that this method introduces multiple memory
> > > copies, which can be imagined that there will be a certain performance
> > > degradation, hoping that friends with RDMA network cards can help verify,
> > thank you!
> > 
> > So you didn't test it with an RDMA card?
> 
> Yep, we tested it by Soft-ROCE.

Does Soft-RoCE (RXE) support live migration?

Thanks


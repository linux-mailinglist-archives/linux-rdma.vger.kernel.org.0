Return-Path: <linux-rdma+bounces-6400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1315F9EC1BF
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 02:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20DF284FC5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 01:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C71DF258;
	Wed, 11 Dec 2024 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOBzB53I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196744384;
	Wed, 11 Dec 2024 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881959; cv=none; b=ds40uEP+4JX8oQbIBHwExwT9x8rfy8TFqgGf5MSxQhhQlaV7eMytVrvI8txSDZcK8BvIBql15M9NwdWyDLWHrYYBTv2IYw5nxmW4Jy7y9/JJSroHcLJt3r/puab8NGc6JNgYeoqmZdeZnl/vDsW31RCSmo3WZL+bBwSv/2bGhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881959; c=relaxed/simple;
	bh=V0eXPilT/Fmh3RWixb5MQCJ4Ns2P6B8ChPIvbx9WZOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVXNW1sroy9H2zsZ/7hT+ZsyAVRwKTVxNvqiBeH5p+IjXMbpU/aTvobd30Q3I4NG6nn/F4jj9NbyBPOsDHh73ibkLdoEFWs7H9K29Q6OYO5TSOXdK5lgaO8sZf9kNX+NAEs1zuxuEXb+gpXjG1AF8kmHcroQbd6oyOuGisRORkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOBzB53I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEC3C4CED6;
	Wed, 11 Dec 2024 01:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733881958;
	bh=V0eXPilT/Fmh3RWixb5MQCJ4Ns2P6B8ChPIvbx9WZOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oOBzB53IUc9Wg6MGvdWoc2zZGOsL3KveCFivZxJnG2F2eNBXXSNIYsvNURP0lmB8B
	 ENeR32e3v3dJSMwgkizb5h4ABIx9G/09f7PNwK/FGel8EvRe9XAPWTdx6DlrhHkohN
	 L22O/MO25yMPuB8MdkIEoHQBy1oqzgj+UUZTeSDJ3mMm5vb3VR4CTB7Q+tDWBF4MgT
	 8CYhoWZeMfvT34hq86oDmvUh7XFxqJ5lLEckXI0l08l8w95FJOIs9XmsX3piyn89NO
	 qvewEiDMuroahGsocWyFbwTtK+3U5J6QxQDXrd3nlq4b40tpqArKfkveVmrkmWwKoz
	 9qnaoj1ZVBBxw==
Date: Tue, 10 Dec 2024 17:52:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bernard Metzler <bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org,
 leon@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com,
 syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/siw: Remove direct link to net_device
Message-ID: <20241210175237.3342a9eb@kernel.org>
In-Reply-To: <20241210145627.GH1888283@ziepe.ca>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
	<20241210145627.GH1888283@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 10:56:27 -0400 Jason Gunthorpe wrote:
> >  struct siw_device {
> >  	struct ib_device base_dev;
> > -	struct net_device *netdev;
> >  	struct siw_dev_cap attrs;
> >  
> >  	u32 vendor_part_id;
> > +	struct {
> > +		int ifindex;  
> 
> ifindex is only stable so long as you are holding a reference on the
> netdev..

Does not compute. Can you elaborate what you mean, Jason?


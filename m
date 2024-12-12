Return-Path: <linux-rdma+bounces-6480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FC39EEB62
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 16:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224D42831E1
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA7721639E;
	Thu, 12 Dec 2024 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWhVBFRN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F202D1487CD;
	Thu, 12 Dec 2024 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017060; cv=none; b=b9BJz8rq7cNLeVYpkU82bCSXUHp9sru+z/tB+fYv9aGKU6dFbYiQn+h0JtdBtk2jCSVlKTxxYGV5VQ+QT+C/DJaGBfH4+5TeL6SM7E4QnUoxG1V8kvJSa/dudeJ0QiNjQllIzaxzdYib56upfpQrO3Y0A7K6M4TQmtlkIH2Q92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017060; c=relaxed/simple;
	bh=IgaPRt6UGnOUgvVNV55BpJytuFE2bMtPsWTFqck832U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fkri5TQoi/57WCWKODEhpFOzQ+aeNhxn/3bWowJLgadLzxo+BlSJHKm3Gt9ot8oSf4VHWiPiXuWI+BGiWNlP4y+rpJaDnKyznsDWmO9r1vWut51jm829pmt/OkLpAWDa6rM8XEZz1YRynsd+jN8G/lNeJszvGdh2QtkzobYmGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWhVBFRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3746FC4CED4;
	Thu, 12 Dec 2024 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734017059;
	bh=IgaPRt6UGnOUgvVNV55BpJytuFE2bMtPsWTFqck832U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWhVBFRNxQYau3e92b+yvNBCn1sdFXyysvnM4Cci4AIZBapysXFNvFF0NI704pWfp
	 YtgJS6JGdMRZwYjlCXGHyUBxr56R6ERJXHHx65pw48BGDM0d9IAbdzCKNj+5YXZOBF
	 rIlv4KWbBPO5Dq4eLDUmqLFzd11Q2dgyVJ8MMBTbvNfYDMNieOqEWOALmtiTzmhq8H
	 niG48e6TP3RXLfRYFJ031+EDXsm9IVvWfsSXB06Yfp/F4J38KilKdt3+2ZNofKs7yn
	 MiidT7LIfHUvQfVTPwp7XPvz9N9GHXTsATV+STYFuPNK9keQg1zs46Bu2VFn8uC6Qw
	 UGhOeUavN7wLA==
Date: Thu, 12 Dec 2024 07:24:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
 "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
 "syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com"
 <syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com>
Subject: Re: [PATCH RESEND] RDMA/siw: Remove direct link to net_device
Message-ID: <20241212072418.4ffc20f5@kernel.org>
In-Reply-To: <BN8PR15MB25136BDDF98EFEC020AAB44A993F2@BN8PR15MB2513.namprd15.prod.outlook.com>
References: <20241212143629.560965-1-bmt@zurich.ibm.com>
	<BN8PR15MB25136BDDF98EFEC020AAB44A993F2@BN8PR15MB2513.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Dec 2024 15:17:15 +0000 Bernard Metzler wrote:
> The sdev is no longer needed. Sorry for not catching it.

if you're CCing netdev, please try not to send more than one version
within 24h.


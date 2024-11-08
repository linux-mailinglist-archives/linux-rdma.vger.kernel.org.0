Return-Path: <linux-rdma+bounces-5873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 188C79C2489
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 19:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38B41F2356D
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 18:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF2A1A9B24;
	Fri,  8 Nov 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9xbZGPU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B247233D67;
	Fri,  8 Nov 2024 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088753; cv=none; b=Xuxx5jn/+VLZkqsnlZFymsvCFlLFmvXqlOfT+UVoi37YtV/RbhR/IQAF4Mm+Fr8u7D81vOPoOgRgLeOefmp/zDvsQDGaFUaSxdXrgNiitHkCjg3s+xuIY6lessj5VtHDXM78GikhkKz5jcpNOzCXclbPktY+CW9YEGr92EGCN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088753; c=relaxed/simple;
	bh=njRHL3LaliikKZctNZcbQmlhWG5PDd/sxP2CVB4KNl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFUjp1ajSdus5ed4RSbm/X1QpJSHp/mJbYNQN1RJtM9O3o4EpVpNSV9GM7UEbi90sOzTI0kexluoWmpNqys/ogmeb3QhjLzBwDYWgEhZrJs6CuJkFJAw1GEXgyd/I2+Llm5K9FtEf1WvbL+kJ0GxvaYemXMX0bHigwzZZ56qAtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9xbZGPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CCAC4CECD;
	Fri,  8 Nov 2024 17:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731088752;
	bh=njRHL3LaliikKZctNZcbQmlhWG5PDd/sxP2CVB4KNl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9xbZGPUoEDjcljiuA04F7V2sPGjbnBqOHkxiJIqWEC8kQP3ScBiINGTeelI13nDE
	 rOgX8Cb9wPFHBVq+tppbBl26ZQbrPs2+9XOZu+CpobBs0CSB7tCdCypWqxo4BfpqUj
	 IGbdma8WYKUwdtwXoeIGIKFbR6/1CGUXlVfF5wrBL6Svn1aHNBonQosJgHbJVwcF9H
	 32xT46rGOfSJs4enLRTS45FOOYLrl/yZRNmh88IRyc2UVezJR5thxLc93qXT+MbLbZ
	 +c1i2XO4EDDewVeqxdYV6k35H+6ewPFbMJChCPBEbMvJM0IyWenSY0tsmNvF61w4ej
	 LggrNLE0sJ5NQ==
Date: Fri, 8 Nov 2024 19:59:06 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Halil Pasic <pasic@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Nils Hoppmann <niho@linux.ibm.com>,
	Niklas Schnell <schnelle@linux.ibm.com>,
	Thorsten Winkler <twinkler@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Stefan Raspl <raspl@linux.ibm.com>, Aswin K <aswin@linux.ibm.com>,
	linux-cifs@vger.kernel.org,
	Kangjing Huang <huangkangjing@gmail.com>
Subject: Re: [PATCH net] net/smc: Fix lookup of netdev by using
 ib_device_get_netdev()
Message-ID: <20241108175906.GB189042@unreal>
References: <20241025072356.56093-1-wenjia@linux.ibm.com>
 <20241027201857.GA1615717@unreal>
 <8d17b403-aefa-4f36-a913-7ace41cf2551@linux.ibm.com>
 <20241105112313.GE311159@unreal>
 <20241106102439.4ca5effc.pasic@linux.ibm.com>
 <20241106135910.GF5006@unreal>
 <20241107125643.04f97394.pasic@linux.ibm.com>
 <CAKYAXd9QD5N-mYdGv5Sf1Bx6uBUwghCOWfvYC=_PC_2wDvao+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKYAXd9QD5N-mYdGv5Sf1Bx6uBUwghCOWfvYC=_PC_2wDvao+w@mail.gmail.com>

On Fri, Nov 08, 2024 at 08:40:40AM +0900, Namjae Jeon wrote:
> On Thu, Nov 7, 2024 at 9:00 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> >
> > On Wed, 6 Nov 2024 15:59:10 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:
> >
> > > > Does  fs/smb/server/transport_rdma.c qualify as inside of RDMA core code?
> > >
> > > RDMA core code is drivers/infiniband/core/*.
> >
> > Understood. So this is a violation of the no direct access to the
> > callbacks rule.
> >
> > >
> > > > I would guess it is not, and I would not actually mind sending a patch
> > > > but I have trouble figuring out the logic behind  commit ecce70cf17d9
> > > > ("ksmbd: fix missing RDMA-capable flag for IPoIB device in
> > > > ksmbd_rdma_capable_netdev()").
> > >
> > > It is strange version of RDMA-CM. All other ULPs use RDMA-CM to avoid
> > > GID, netdev and fabric complexity.
> >
> > I'm not familiar enough with either of the subsystems. Based on your
> > answer my guess is that it ain't outright bugous but still a layering
> > violation. Copying linux-cifs@vger.kernel.org so that
> > the smb are aware.
> Could you please elaborate what the violation is ?

There are many, but the most screaming is that ksmbd has logic to
differentiate IPoIB devices. These devices are pure netdev devices
and should be treated like that. ULPs should treat them exactly
as they treat netdev devices.

> I would also appreciate it if you could suggest to me how to fix this.
> 
> Thanks.
> >
> > Thank you very much for all the explanations!
> >
> > Regards,
> > Halil
> >


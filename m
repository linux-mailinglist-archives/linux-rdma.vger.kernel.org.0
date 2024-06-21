Return-Path: <linux-rdma+bounces-3403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2570F912C9F
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 19:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487721C221B1
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818B1168484;
	Fri, 21 Jun 2024 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL/I/Hv+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949431C14;
	Fri, 21 Jun 2024 17:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992165; cv=none; b=CeAVtqcoL57t5vPWqhz+AKoFyox9SCEmgESTmQlzcP1RUk4eTr3M4+YJNd25fOMFV2Bigcqe97L+6fNtkG07tKA1co7ifHTrQQpb+AZtWglY6C8cmJP+LnqV//u0IPxJJ99OMuNk3wInXk1SWRyKj9vdxZJpfobMcDlgkqV4MS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992165; c=relaxed/simple;
	bh=16Q7UL0YhkM2EiDSjw0enmCXlzuHQdUMucuuffEQB5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sST5+VmoSa21LXH17Dxe1xEC30yZyHgW1bq0B+crQ0cnljPcslkIMznHMD0g2jp6jRXxFbRWwqCsSLrC3Opfqz48khUtv2iabGVa/Mo9sZqwrtAhMg/gEUl0uikel5+TiPKmL2gh6AOHV+cuJj5TvvnZA6AQbdQo3vRXSPzPk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL/I/Hv+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f09eaf420so265180566b.3;
        Fri, 21 Jun 2024 10:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718992162; x=1719596962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd59nbjK5mxx2t+S2o2mRnCCr+mXTEe9t7Rxfuo2GxU=;
        b=GL/I/Hv+WkNccOUVyVEskJoq96vytPnRYYI0EzrkJRssyBKSRCuseTnHQmUonxz5kM
         VxxhHNxJnzmJv288YTe/stnFuWS4yjas88L/yj/HhKoCrXN71g3GUWFWZsIsAch0/mGO
         CRVjTQqUTdMC3GDC3lR6FlQ8309zY6e3qU87dG350LyTBOqI2/5QDTPFFEhOXNqDqxPC
         WHyYhNXL7FD7wfFztZQFRoG5juyeBM5rvA6G/FR96L4eqROWQPoEb4TGRXHrS1l2lJ5i
         Uvr2TBCjearcmRl2IJCsS4LHrtK4lVsxX5DGHEnK7f6dYnBc4aAxKqFK+7ZPTrK4ylkv
         LFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718992162; x=1719596962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dd59nbjK5mxx2t+S2o2mRnCCr+mXTEe9t7Rxfuo2GxU=;
        b=ZUJLtp1B9R2HJFsygn83Ppip25EBNGHI9eOrqPvpsl2XQtECNT1fvsHpHIfw27+MbS
         iop+waijIAhgBzZM8ik0s5wNTeipob1/Wg6MwDYqLrncc1vihI1Fg0SRmwY137SWNrt5
         lmCl15gR/HAk+RPslHFfbrKS1vz7U/r7m+D45UZXKJD6DT3kDOahqdX+NjjEhzjvzGML
         SYE7ggzpAfoUwmv0kwqOhY5wccOhzr5wpKbn1O5c+wPCnK6KoGeU5Rwm//y7knTqkNd5
         w1EnVuqRSthF/Vf8PmRqmyDue8ewhWpurSL9jCMKniEcZmItYF9uvejUbd55vXHWcjUG
         4n8A==
X-Forwarded-Encrypted: i=1; AJvYcCW9ncCGIloZW9j7Gufa9B3APq0ze6HVN6jitgXOVpdG0ogU/gRUJa5H3+EMimNtMHYlQ2SVXCtTomeoQPo2FmhPVr6pr4xI+yBESC1LamQ315U6nRESoQdheFMjjYorBwmD69joVvObbA==
X-Gm-Message-State: AOJu0YzL5KHfACkprLEDINNjVgyz0G3JprJOjk6Cx2//hMox4nAbwG96
	w5j5wT0ROHjd4lzNaTdl2FrRQNyhY5W6EW9GW65kAJDIF+r1IjFBm3oXHQ2fc0FC+vZbaInR5vW
	akyUKw8OO78JIlBWicT1x67wf7SM=
X-Google-Smtp-Source: AGHT+IHuxXRp9oMpOcE6TOMJCZu9K/BXWS3ZbVFC9+KQ7nQaPPN+hSsVK1nMG8Wok8Lm7VJZ1yfqKBzvbhRANY/cPkA=
X-Received: by 2002:a17:906:4092:b0:a6f:6d98:d4d4 with SMTP id
 a640c23a62f3a-a6fab60bad6mr524907266b.11.1718992161614; Fri, 21 Jun 2024
 10:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621050525.3720069-1-allen.lkml@gmail.com> <20240621082525.0def003b@hermes.local>
In-Reply-To: <20240621082525.0def003b@hermes.local>
From: Allen <allen.lkml@gmail.com>
Date: Fri, 21 Jun 2024 10:49:09 -0700
Message-ID: <CAOMdWS+Z_vvcrJE9ug3dYe033te-EW7eBdygJ9hbe6R6e37yzQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] ethernet: Convert from tasklet to BH workqueue
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: kuba@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, jes@trained-monkey.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	kda@linux-powerpc.org, cai.huoqing@linux.dev, dougmill@linux.ibm.com, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, 
	naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com, tlfalcon@linux.ibm.com, 
	cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com, mlindner@marvell.com, 
	nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, 
	lorenzo@kernel.org, borisp@nvidia.com, bryan.whitehead@microchip.com, 
	UNGLinuxDriver@microchip.com, louis.peens@corigine.com, 
	richardcochran@gmail.com, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acenic@sunsite.dk, 
	linux-net-drivers@amd.com, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

>
> > The only generic interface to execute asynchronously in the BH context is
> > tasklet; however, it's marked deprecated and has some design flaws. To
> > replace tasklets, BH workqueue support was recently added. A BH workqueue
> > behaves similarly to regular workqueues except that the queued work items
> > are executed in the BH context.
> >
> > This patch converts a few drivers in drivers/ethernet/* from tasklet
> > to BH workqueue. The next set will be sent out after the next -rc is
> > out.
> >
> > This series is based on
> > commit a6ec08beec9e ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> >
> > First version converting all the drivers can be found at:
> > https://lore.kernel.org/all/20240507190111.16710
> > -2-apais@linux.microsoft.com/
> >
> >
> > Allen Pais (15):
> >   net: alteon: Convert tasklet API to new bottom half workqueue
> >     mechanism
> >   net: xgbe: Convert tasklet API to new bottom half workqueue mechanism
> >   net: cnic: Convert tasklet API to new bottom half workqueue mechanism
> >   net: macb: Convert tasklet API to new bottom half workqueue mechanism
> >   net: cavium/liquidio: Convert tasklet API to new bottom half workqueue
> >     mechanism
> >   net: octeon: Convert tasklet API to new bottom half workqueue
> >     mechanism
> >   net: thunderx: Convert tasklet API to new bottom half workqueue
> >     mechanism
> >   net: chelsio: Convert tasklet API to new bottom half workqueue
> >     mechanism
> >   net: sundance: Convert tasklet API to new bottom half workqueue
> >     mechanism
> >   net: hinic: Convert tasklet API to new bottom half workqueue mechanism
> >   net: ehea: Convert tasklet API to new bottom half workqueue mechanism
> >   net: ibmvnic: Convert tasklet API to new bottom half workqueue
> >     mechanism
> >   net: jme: Convert tasklet API to new bottom half workqueue mechanism
> >   net: marvell: Convert tasklet API to new bottom half workqueue
> >     mechanism
> >   net: mtk-wed: Convert tasklet API to new bottom half workqueue
> >     mechanism
> >
> >  drivers/net/ethernet/alteon/acenic.c          | 26 +++----
> >  drivers/net/ethernet/alteon/acenic.h          |  8 +--
> >  drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 30 ++++----
> >  drivers/net/ethernet/amd/xgbe/xgbe-i2c.c      | 16 ++---
> >  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c     | 16 ++---
> >  drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |  4 +-
> >  drivers/net/ethernet/amd/xgbe/xgbe.h          | 10 +--
> >  drivers/net/ethernet/broadcom/cnic.c          | 19 ++---
> >  drivers/net/ethernet/broadcom/cnic.h          |  2 +-
> >  drivers/net/ethernet/cadence/macb.h           |  3 +-
> >  drivers/net/ethernet/cadence/macb_main.c      | 10 +--
> >  .../net/ethernet/cavium/liquidio/lio_core.c   |  4 +-
> >  .../net/ethernet/cavium/liquidio/lio_main.c   | 24 +++----
> >  .../ethernet/cavium/liquidio/lio_vf_main.c    | 10 +--
> >  .../ethernet/cavium/liquidio/octeon_droq.c    |  4 +-
> >  .../ethernet/cavium/liquidio/octeon_main.h    |  4 +-
> >  .../net/ethernet/cavium/octeon/octeon_mgmt.c  | 13 ++--
> >  drivers/net/ethernet/cavium/thunder/nic.h     |  5 +-
> >  .../net/ethernet/cavium/thunder/nicvf_main.c  | 24 +++----
> >  .../ethernet/cavium/thunder/nicvf_queues.c    |  4 +-
> >  .../ethernet/cavium/thunder/nicvf_queues.h    |  2 +-
> >  drivers/net/ethernet/chelsio/cxgb/sge.c       | 19 ++---
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  9 +--
> >  .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
> >  .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  |  4 +-
> >  .../net/ethernet/chelsio/cxgb4/cxgb4_uld.c    |  2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/sge.c      | 40 +++++------
> >  drivers/net/ethernet/chelsio/cxgb4vf/sge.c    |  6 +-
> >  drivers/net/ethernet/dlink/sundance.c         | 41 +++++------
> >  .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |  2 +-
> >  .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  | 17 +++--
> >  .../net/ethernet/huawei/hinic/hinic_hw_eqs.h  |  2 +-
> >  drivers/net/ethernet/ibm/ehea/ehea.h          |  3 +-
> >  drivers/net/ethernet/ibm/ehea/ehea_main.c     | 14 ++--
> >  drivers/net/ethernet/ibm/ibmvnic.c            | 24 +++----
> >  drivers/net/ethernet/ibm/ibmvnic.h            |  2 +-
> >  drivers/net/ethernet/jme.c                    | 72 +++++++++----------
> >  drivers/net/ethernet/jme.h                    |  8 +--
> >  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  4 +-
> >  drivers/net/ethernet/marvell/skge.c           | 12 ++--
> >  drivers/net/ethernet/marvell/skge.h           |  3 +-
> >  drivers/net/ethernet/mediatek/mtk_wed_wo.c    | 12 ++--
> >  drivers/net/ethernet/mediatek/mtk_wed_wo.h    |  3 +-
> >  43 files changed, 273 insertions(+), 266 deletions(-)
> >
>
> This should also go to netdev@vger.kernel.org

My Bad, I thought I had it marked. Thanks for pointing it out.

       - Allen


Return-Path: <linux-rdma+bounces-3401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C95912991
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 17:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E8A281C40
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C974079;
	Fri, 21 Jun 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IXpxWbJn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02C548F7
	for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2024 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983531; cv=none; b=G2T2bGMXB7OkMMZI7xeTgaTkjcLtKADMBhcQjRbpSeXs5FknViL09br+Tv6oYKxm/1akrZQvwLaF1yGnrD7vS5eEr1eclJv3GZpkyXbqslvBaHcQUGHgFi68tjPDyUUB+9x9a0ttnwm4Axqn5O1PnDluShlhP/hwjNPZN6hUDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983531; c=relaxed/simple;
	bh=HZEeTINutptEU0lhQpxdRR6DoHtHY3p+yc0zzfwYTKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yuhz7zb6hVntePxNRYj41o5pAdvM779fc6RqupD1Zqx44fy4DKB05k/qAVi/+xTc0DgZixdaBZNauFelcnwm3acDR28qoX3nF/h/zt3FX0YLLKyGmmTVuCTbSlEXG6wLX9u4godRDPSxl5ak8THZZhvDyAh5tnRZd/nGYjf+o1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=IXpxWbJn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f44b5b9de6so17401035ad.3
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jun 2024 08:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1718983528; x=1719588328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYlNHWP11x6QNKTXlbmUex1BD8XP8iF4g+JbpwM+d2E=;
        b=IXpxWbJnTsCsV+baMz8lKeVtDVk91ge6oxA2ieOwDDoLuPk1SCI2IaffBH44AiHPfQ
         tlKPtdr7E+0UNhZeyVN3uOBK8Z6vNCugNAk0ccoZ0sF5sMXDOnPPhA2p+dRiJvGWhlLY
         k9vIylP9JirZM3cDs2FI+VRnRmjuLQyJgQz14/jL7M1jovk2tkShPn7ol1a2nJ+VeJyt
         RBr57oJSOpFH2zYNfFw2XLyX+pmeNeUE8RfT8DC8kMQ6o3bl4wvVSyscBKAiodUN5L5O
         muqYd6tpx9lUjFRHSjqPCrWSCqyrnxR3nuYJyuBvb8njNRISjHUTXdbLBzjqluTqX8dI
         7GcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718983528; x=1719588328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYlNHWP11x6QNKTXlbmUex1BD8XP8iF4g+JbpwM+d2E=;
        b=voJKIyGPpxaNpFzAEHjJJ0ZyNFlO8NWVrKu1K60oazAmxUUjT/wudu47fPnrnA9WER
         xxwEpR/fdnCNIOEVV2JxTBubCn9Mn5JR78WjXyRDPDnfCyxM7Q0Irn0mnaLAmMndcqgK
         TtScVvcObLf4v/HGLNGwO/3S2z87pQVsx+agymOR5mrZII+g5z1urVY3+vAlQkpvGTgf
         9pKXNvxzo0aN507WkY+QFDo232p5I5bO9JlXA13mru1dC/vWF7nv47YFeSzYSncgHPi6
         7VlCOR4EeFPnMh3wSRl+UhovsZUvQrGJzjq+uaxEGNkzR24n27Zu1jg3AJAlj5cgB0HN
         2yYw==
X-Forwarded-Encrypted: i=1; AJvYcCXIDcZuHDfmoDaxweC1oJf6f66RYbeDW5Hj6u+yCs4Ki0U0X+v/txI8dBC1YWCHElxqS1VsHoLy6+2O8zNDVt3HipOzDy+q6116sw==
X-Gm-Message-State: AOJu0YzDbdaVkVV+z7rnt894r7YYCAwzQxPdFAhiqt2Pu8aSxPylYWrO
	mvxvO3EzePOBiUPiACzCxaReL3y/nvcyfXPMn4fzut/Kqr4RzEuHpQfx7FYOhyI=
X-Google-Smtp-Source: AGHT+IEC/+dU28AaumAmbjdJPumvT/Gnd4v11fgIaQOE3Q5JRhFPBwxb0aR0CmD13L3R1bpzIYHY8w==
X-Received: by 2002:a17:903:244d:b0:1f9:f021:f2ea with SMTP id d9443c01a7336-1f9f021f686mr22307065ad.63.1718983528046;
        Fri, 21 Jun 2024 08:25:28 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb8c8960sm15313065ad.227.2024.06.21.08.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:25:27 -0700 (PDT)
Date: Fri, 21 Jun 2024 08:25:25 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Allen Pais <allen.lkml@gmail.com>
Cc: kuba@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 jes@trained-monkey.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kda@linux-powerpc.org, cai.huoqing@linux.dev,
 dougmill@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, nnac123@linux.ibm.com,
 tlfalcon@linux.ibm.com, cooldavid@cooldavid.org, marcin.s.wojtas@gmail.com,
 mlindner@marvell.com, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, borisp@nvidia.com,
 bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 louis.peens@corigine.com, richardcochran@gmail.com,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acenic@sunsite.dk, linux-net-drivers@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 00/15] ethernet: Convert from tasklet to BH workqueue
Message-ID: <20240621082525.0def003b@hermes.local>
In-Reply-To: <20240621050525.3720069-1-allen.lkml@gmail.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 22:05:10 -0700
Allen Pais <allen.lkml@gmail.com> wrote:

> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts a few drivers in drivers/ethernet/* from tasklet
> to BH workqueue. The next set will be sent out after the next -rc is
> out.
> 
> This series is based on 
> commit a6ec08beec9e ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> 
> First version converting all the drivers can be found at:
> https://lore.kernel.org/all/20240507190111.16710
> -2-apais@linux.microsoft.com/
> 
> 
> Allen Pais (15):
>   net: alteon: Convert tasklet API to new bottom half workqueue
>     mechanism
>   net: xgbe: Convert tasklet API to new bottom half workqueue mechanism
>   net: cnic: Convert tasklet API to new bottom half workqueue mechanism
>   net: macb: Convert tasklet API to new bottom half workqueue mechanism
>   net: cavium/liquidio: Convert tasklet API to new bottom half workqueue
>     mechanism
>   net: octeon: Convert tasklet API to new bottom half workqueue
>     mechanism
>   net: thunderx: Convert tasklet API to new bottom half workqueue
>     mechanism
>   net: chelsio: Convert tasklet API to new bottom half workqueue
>     mechanism
>   net: sundance: Convert tasklet API to new bottom half workqueue
>     mechanism
>   net: hinic: Convert tasklet API to new bottom half workqueue mechanism
>   net: ehea: Convert tasklet API to new bottom half workqueue mechanism
>   net: ibmvnic: Convert tasklet API to new bottom half workqueue
>     mechanism
>   net: jme: Convert tasklet API to new bottom half workqueue mechanism
>   net: marvell: Convert tasklet API to new bottom half workqueue
>     mechanism
>   net: mtk-wed: Convert tasklet API to new bottom half workqueue
>     mechanism
> 
>  drivers/net/ethernet/alteon/acenic.c          | 26 +++----
>  drivers/net/ethernet/alteon/acenic.h          |  8 +--
>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c      | 30 ++++----
>  drivers/net/ethernet/amd/xgbe/xgbe-i2c.c      | 16 ++---
>  drivers/net/ethernet/amd/xgbe/xgbe-mdio.c     | 16 ++---
>  drivers/net/ethernet/amd/xgbe/xgbe-pci.c      |  4 +-
>  drivers/net/ethernet/amd/xgbe/xgbe.h          | 10 +--
>  drivers/net/ethernet/broadcom/cnic.c          | 19 ++---
>  drivers/net/ethernet/broadcom/cnic.h          |  2 +-
>  drivers/net/ethernet/cadence/macb.h           |  3 +-
>  drivers/net/ethernet/cadence/macb_main.c      | 10 +--
>  .../net/ethernet/cavium/liquidio/lio_core.c   |  4 +-
>  .../net/ethernet/cavium/liquidio/lio_main.c   | 24 +++----
>  .../ethernet/cavium/liquidio/lio_vf_main.c    | 10 +--
>  .../ethernet/cavium/liquidio/octeon_droq.c    |  4 +-
>  .../ethernet/cavium/liquidio/octeon_main.h    |  4 +-
>  .../net/ethernet/cavium/octeon/octeon_mgmt.c  | 13 ++--
>  drivers/net/ethernet/cavium/thunder/nic.h     |  5 +-
>  .../net/ethernet/cavium/thunder/nicvf_main.c  | 24 +++----
>  .../ethernet/cavium/thunder/nicvf_queues.c    |  4 +-
>  .../ethernet/cavium/thunder/nicvf_queues.h    |  2 +-
>  drivers/net/ethernet/chelsio/cxgb/sge.c       | 19 ++---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |  9 +--
>  .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  2 +-
>  .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  |  4 +-
>  .../net/ethernet/chelsio/cxgb4/cxgb4_uld.c    |  2 +-
>  drivers/net/ethernet/chelsio/cxgb4/sge.c      | 40 +++++------
>  drivers/net/ethernet/chelsio/cxgb4vf/sge.c    |  6 +-
>  drivers/net/ethernet/dlink/sundance.c         | 41 +++++------
>  .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |  2 +-
>  .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  | 17 +++--
>  .../net/ethernet/huawei/hinic/hinic_hw_eqs.h  |  2 +-
>  drivers/net/ethernet/ibm/ehea/ehea.h          |  3 +-
>  drivers/net/ethernet/ibm/ehea/ehea_main.c     | 14 ++--
>  drivers/net/ethernet/ibm/ibmvnic.c            | 24 +++----
>  drivers/net/ethernet/ibm/ibmvnic.h            |  2 +-
>  drivers/net/ethernet/jme.c                    | 72 +++++++++----------
>  drivers/net/ethernet/jme.h                    |  8 +--
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  4 +-
>  drivers/net/ethernet/marvell/skge.c           | 12 ++--
>  drivers/net/ethernet/marvell/skge.h           |  3 +-
>  drivers/net/ethernet/mediatek/mtk_wed_wo.c    | 12 ++--
>  drivers/net/ethernet/mediatek/mtk_wed_wo.h    |  3 +-
>  43 files changed, 273 insertions(+), 266 deletions(-)
> 

This should also go to netdev@vger.kernel.org


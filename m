Return-Path: <linux-rdma+bounces-2251-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27D88BB366
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 20:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57571C20F30
	for <lists+linux-rdma@lfdr.de>; Fri,  3 May 2024 18:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E6117C64;
	Fri,  3 May 2024 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ePikg0wS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B472E646
	for <linux-rdma@vger.kernel.org>; Fri,  3 May 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761814; cv=none; b=FeDpMP4Nc0OGEtGBex1tkHnbtSsTOeyU39z9SCYDUu2kvTDUy9OEIYcOYxUL6G+xbz7rtT39dwO+m7BEUnhxcB7Q3mBUVP4mXAMUCxzuWDJGtaTr5EOeK4KyESWbWDUYOmNnoh/N7n+kaj+Rxs89gu4rx99+aAfz99mrini9n/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761814; c=relaxed/simple;
	bh=PcHI2mXSjOY4NXtmW1TqHHOIJEHPiSVx2p/CZ40zV8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGyhvbaXGmo08IQeffMprgpwpFnpErLE07gQda7u4AFBw4g3TYctJZgW1KB0OYeYqMElVCM482AKN5w+mItoqXyfnA9wMilpeWfiZQjdfexksluOh6wlx02NkgTdPqYBIbJngRveisHNsrfA+jynVHpF/8Jfr1ZCfXiGWNkKTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ePikg0wS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e4266673bbso86199655ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 03 May 2024 11:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714761811; x=1715366611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFXylIM8Lgjr0fl64+mxvP0VZact2yQlaPnfxj1/4U0=;
        b=ePikg0wS7nTpjPmUR9Wbw6vKzXEnI/bGfNsx6oJ7FIjeCLMXrduM8RQj+wa/5iCWUZ
         I9qpk0rwSPpR/1riJIpwK/BXbbp4QM//XGQKS6TaaddmJOG0VIOmkSRyqOdNixS7QFW2
         9C7kyvoyJI4gZJyD9NIIW2aPH0ae0WsAfVdNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714761811; x=1715366611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFXylIM8Lgjr0fl64+mxvP0VZact2yQlaPnfxj1/4U0=;
        b=tLkY4nCXp+pbliwhw5dFe/hs/7StJWkhRxuteTSW8Q/H9u4xOKi+3BFhoOAk6rTZ1I
         SFmdjBFPRvPnGemsrGM1siq/5bBY6WGH90xsGgjve8VqNJ2Bf6BzHho/G3i5cnO3g+YW
         Ge3/kO554KdzGeImRxjSlQvPN7g79W5XAIsjQNMuUPai/nu6tejzWlk2FKgTAhL8N2dG
         OuFXPePj6ed6WYgMUT+NQLqOdERtiMepak9TNHYoKWg+XRAuQnAzn2lgkv8LGLLKty87
         lgIeW0aUgnW/RCTcb+6SGIx0gOyIDdeACIwb9BGzAShBeGiPdAuKVkUVZUh2yf6XUP1K
         +Tdg==
X-Forwarded-Encrypted: i=1; AJvYcCWqA/ZUNoplvBKmhYgFHi0RHkMGiZUjhCeMQPiAcA1nECUdSqdf9+HYPyB55VSwjaiCRkbb/46PQ1ItffGGtec/otwREYl80GE8OA==
X-Gm-Message-State: AOJu0YzLihx1a4ARQ4b0cZXSRsaj+jYwQXCMppUVPJTAM7Ctm+zEIYlL
	tzkwR1q+3rwD0TzZqQKqfpWi5tGM/vV1WrKuJ1G4kvFEk/xx+wxPQeDHbQZcAho=
X-Google-Smtp-Source: AGHT+IELQNadSxtn2qD7K4UmKbShRX1xBPsnrbEvAT1ulySbjcsBh1/3r1nD5X/Dflgo+e9sRpoYKA==
X-Received: by 2002:a17:902:7612:b0:1e6:622c:7bb4 with SMTP id k18-20020a170902761200b001e6622c7bb4mr3161044pll.19.1714761810756;
        Fri, 03 May 2024 11:43:30 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902ee4200b001ecc9a92e1csm3562096plo.267.2024.05.03.11.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 11:43:30 -0700 (PDT)
Date: Fri, 3 May 2024 11:43:27 -0700
From: Joe Damato <jdamato@fastly.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <ZjUwT_1SA9tF952c@LQ3V64L9R2>
References: <20240503022549.49852-1-jdamato@fastly.com>
 <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>

On Fri, May 03, 2024 at 12:55:41PM +0200, Zhu Yanjun wrote:
> On 03.05.24 04:25, Joe Damato wrote:
> > Hi:
> > 
> > This is only 1 patch, so I know a cover letter isn't necessary, but it
> > seems there are a few things to mention.
> > 
> > This change adds support for the per queue netdev-genl API to mlx5,
> > which seems to output stats:
> > 
> > ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
> >           --dump qstats-get --json '{"scope": "queue"}'
> > 
> > ...snip
> >   {'ifindex': 7,
> >    'queue-id': 28,
> >    'queue-type': 'tx',
> >    'tx-bytes': 399462,
> >    'tx-packets': 3311},
> > ...snip
> 
> Ethtool -S ethx can get the above information
> "
> ...
>      tx-0.packets: 2094
>      tx-0.bytes: 294141
>      rx-0.packets: 2200
>      rx-0.bytes: 267673
> ...
> "
> 
> > 
> > I've tried to use the tooling suggested to verify that the per queue
> > stats match the rtnl stats by doing this:
> > 
> >    NETIF=eth0 tools/testing/selftests/drivers/net/stats.py
> > 
> > And the tool outputs that there is a failure:
> > 
> >    # Exception| Exception: Qstats are lower, fetched later
> >    not ok 3 stats.pkt_byte_sum
> 
> With ethtool, does the above problem still occur?

Thanks for the suggestion, with ethtool it seems correct using the same
logic as the test, I understand correctly.

The failing test fetches rtnl first then qstats, but sees lower qstats - the
test expects qstats to be equal or higher since they are read later. In order to
reproduce this with ethtool, I'd need to fetch with ethtool first and then
fetch qstats and compare.

A correct output would show equal or higher stats from qstats than ethtool
because there is minor delay in running the commands.

Here's a quick example using ethtool of what I get (note that in the output of
cli.py the bytes are printed before the packets):

$ ethtool -S eth0 | egrep '(rx[0-3]_(bytes|packets))' && \
  echo "======" && \
  ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"scope": "queue", "ifindex": 7}' \
  |  egrep '(rx-(packets|bytes))'

     rx0_packets: 10799916
     rx0_bytes: 4949724904
     rx1_packets: 26170804
     rx1_bytes: 12694250232
     rx2_packets: 11901885
     rx2_bytes: 5593129387
     rx3_packets: 13219784
     rx3_bytes: 6151431963
======
  'rx-bytes': 4949927222,
  'rx-packets': 10800354},
  'rx-bytes': 12694488803,
  'rx-packets': 26171309},
  'rx-bytes': 5593321247,
  'rx-packets': 11902360},
  'rx-bytes': 6151735533,
  'rx-packets': 13220389},


So you can see that the numbers "look right", the qstats (collected by cli.py)
are collected later and are slightly larger, as expected:

rx0_packets from ethtool: 10799916
rx0_packets from cli.py:  10800354

rx0_bytes from ethtool: 4949724904
rx0_bytes from cli.py:  4949927222

So this looks correct to me and in this case I'd be more inclinded to assume
that RTNL on mlx5 is "overcounting" because:

1. it includes the PTP stats that I don't include in my qstats, and/or
2. some other reason I don't understand

> > 
> > The other tests all pass (including stats.qstat_by_ifindex).
> > 
> > This appears to mean that the netdev-genl queue stats have lower numbers
> > than the rtnl stats even though the rtnl stats are fetched first. I
> > added some debugging and found that both rx and tx bytes and packets are
> > slightly lower.
> > 
> > The only explanations I can think of for this are:
> > 
> > 1. tx_ptp_opened and rx_ptp_opened are both true, in which case
> >     mlx5e_fold_sw_stats64 adds bytes and packets to the rtnl struct and
> >     might account for the difference. I skip this case in my
> >     implementation, so that could certainly explain it.
> > 2. Maybe I'm just misunderstanding how stats aggregation works in mlx5,
> >     and that's why the numbers are slightly off?
> > 
> > It appears that the driver uses a workqueue to queue stats updates which
> > happen periodically.
> > 
> >   0. the driver occasionally calls queue_work on the update_stats_work
> >      workqueue.
> >   1. This eventually calls MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(sw),
> >      in drivers/net/ethernet/mellanox/mlx5/core/en_stats.c, which appears
> >      to begin by first memsetting the internal stats struct where stats are
> >      aggregated to zero. This would mean, I think, the get_base_stats
> >      netdev-genl API implementation that I have is correct: simply set
> >      everything to 0.... otherwise we'd end up double counting in the
> >      netdev-genl RX and TX handlers.
> >   2. Next, each of the stats helpers are called to collect stats into the
> >      freshly 0'd internal struct (for example:
> >      mlx5e_stats_grp_sw_update_stats_rq_stats).
> > 
> > That seems to be how stats are aggregated, which would suggest that if I
> > simply .... do what I'm doing in this change the numbers should line up.
> > 
> > But they don't and its either because of PTP or because I am
> > misunderstanding/doing something wrong.
> > 
> > Maybe the MLNX folks can suggest a hint?
> > 
> > Thanks,
> > Joe
> > 
> > Joe Damato (1):
> >    net/mlx5e: Add per queue netdev-genl stats
> > 
> >   .../net/ethernet/mellanox/mlx5/core/en_main.c | 68 +++++++++++++++++++
> >   1 file changed, 68 insertions(+)
> > 
> 


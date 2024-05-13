Return-Path: <linux-rdma+bounces-2466-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C858C471F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 20:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3143F1C21353
	for <lists+linux-rdma@lfdr.de>; Mon, 13 May 2024 18:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774893FE5D;
	Mon, 13 May 2024 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GZha+N5Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B24206A
	for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626024; cv=none; b=bBsN5qO6ibhQvo3EU85kAb+9XkyYVM2aT7AeTQ5PduCN2fTAoowtPVDIaMoFKCnLXUBR2lI37vBnrRoWd3uCp7IDC6YwAXrxLlMBriueogAhDccY5ipYy/6TB0ztJcgQjtFX2Iul9Uv3c2dvsIQyNvggLvYuqhQh4d8euR4AP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626024; c=relaxed/simple;
	bh=1u9/b9gk/Tl5ozsdOKNx/td/R95i1KBWjQylrJWvc1k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRhsY2TZvS9VPUsaO1NQUKPLVe1bqrSCggQHEep8KjrhaJdwR9lA/K6GLaj1+mBjQ9htdlM7A4I3pszHm8SI2L22hGq4Acv+uKKbJx8o/99AlwfPmdifVFWJN8ZZoqDwPjk7d1y/SJ6YBSUaej0q5xwUtB9AcgipHrqRfUj2PKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GZha+N5Y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eeabda8590so33661115ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 13 May 2024 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715626021; x=1716230821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4/YpgsmxEh7NnZ1zRADZ2HbHM07VTZzuSca8drjzUhU=;
        b=GZha+N5Yez+iTz/TJMB89wFfdlYKZVoMOL6XtCKFwXwvnC9bK+icU4rmf7z0o5xRtI
         YJhwmdcng42I136HEmlU6AhQpa5HJHx/uJTPh20EewuS+/5YCurgrqQ8/2rGf53Blzup
         15FMB9VxAHNF0PugoirJhF4ti2jn+lJP92tcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626021; x=1716230821;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/YpgsmxEh7NnZ1zRADZ2HbHM07VTZzuSca8drjzUhU=;
        b=cryOzE+YDRR0RKPdqc7ESF7eKBGb7aataEk2R2FHOl/bodfkoUKT6xFQrpyas5njfi
         PbvCePm9e4v67mQ7uljnU6SSEpYyjgKPOTGxQhwz972Z0XRDipvTy9ujtTc8vEt7etgv
         0ndL2+zS/LXCxF0YRKrYWMe8Yqzc/AuGhN2uaVzgrD+GUywqQhR4a+m5M0U0Ot4Zi8V/
         +7z8AQcXBLZMblKDdvDg807Ws6kfzRNTmoYkj+IpRcpl+5ToGAVR+4L7SIetU2kzy6jV
         kn3Dd33EVXwku3aQCbcrn0xg4rbj5c7wNkQNu19QIz7vf4rJ3XQ+yOEDhV9Am0L8Cetb
         Cpuw==
X-Forwarded-Encrypted: i=1; AJvYcCVd2tyeNH1Fq3Xj2YChdHNnPlE2VM1faMYpGtL2posnhEsu+D4NK1PT83yDdF28JKZTqVktZkZJ9oh+8HdCObfCP5kf302IdjvU9w==
X-Gm-Message-State: AOJu0YzLOmM5baCcB6YQFGEjlnQlvyNbnho8QYvL9XqF+WO0HcidG+d9
	KLZZKgCwsbxVOTyF9g0aYpaBSlkwlWIQ6qg5GACq0P+m5Op2OCgYGYnq1XP3uZw=
X-Google-Smtp-Source: AGHT+IHbSrhUBqN1/ZWPPfyWlFBVdHyHLIR+khL/KKrN4dLXG5CPpLVAkZ3pgSvHmoFsy/dhzVKAsA==
X-Received: by 2002:a17:902:f552:b0:1ed:1d37:267e with SMTP id d9443c01a7336-1ef43e281b0mr137384885ad.16.1715626020880;
        Mon, 13 May 2024 11:47:00 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d168esm82664875ad.32.2024.05.13.11.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:47:00 -0700 (PDT)
Date: Mon, 13 May 2024 11:46:57 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	zyjzyj2000@gmail.com, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/1] net/mlx5e: Add per queue netdev-genl
 stats
Message-ID: <ZkJgIe71mz12qCe1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	zyjzyj2000@gmail.com, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240510041705.96453-1-jdamato@fastly.com>
 <20240510041705.96453-2-jdamato@fastly.com>
 <20240513075827.66d42cc1@kernel.org>
 <ZkJO6BIhor3VEJA2@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkJO6BIhor3VEJA2@LQ3V64L9R2>

On Mon, May 13, 2024 at 10:33:28AM -0700, Joe Damato wrote:
> On Mon, May 13, 2024 at 07:58:27AM -0700, Jakub Kicinski wrote:
> > On Fri, 10 May 2024 04:17:04 +0000 Joe Damato wrote:
> > > Add functions to support the netdev-genl per queue stats API.
> > > 
> > > ./cli.py --spec netlink/specs/netdev.yaml \
> > > --dump qstats-get --json '{"scope": "queue"}'
> > > 
> > > ...snip
> > > 
> > >  {'ifindex': 7,
> > >   'queue-id': 62,
> > >   'queue-type': 'rx',
> > >   'rx-alloc-fail': 0,
> > >   'rx-bytes': 105965251,
> > >   'rx-packets': 179790},
> > >  {'ifindex': 7,
> > >   'queue-id': 0,
> > >   'queue-type': 'tx',
> > >   'tx-bytes': 9402665,
> > >   'tx-packets': 17551},
> > > 
> > > ...snip
> > > 
> > > Also tested with the script tools/testing/selftests/drivers/net/stats.py
> > > in several scenarios to ensure stats tallying was correct:
> > > 
> > > - on boot (default queue counts)
> > > - adjusting queue count up or down (ethtool -L eth0 combined ...)
> > > - adding mqprio TCs
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > 
> > Tariq, could you take a look? Is it good enough to make 6.10? 
> > Would be great to have it..
> 
> Thanks Jakub.
> 
> FYI: I've also sent a v5 of the mlx4 patches which is only a very minor
> change from the v4 as suggested by Tariq (see the changelog in that cover
> letter).
> 
> I am not trying to "rush" either in, to to speak, but if they both made it
> to 6.10 it would be great to have the same support on both drivers in the
> same kernel release :)

Err, sorry, just going through emails now and saw that net-next was closed
just before I sent the v5.

My apologies for missing that announcement.

Do I need to re-send after net-next re-opens or will it automatically be in
the queue for net-next?


Return-Path: <linux-rdma+bounces-2322-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 816258BE7D1
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 17:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083191F28FBD
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2024 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAED168AF5;
	Tue,  7 May 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JVu7CEfJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3E165FD4
	for <linux-rdma@vger.kernel.org>; Tue,  7 May 2024 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097192; cv=none; b=cQMKdY/8ZOPa0qiNIaauIbG4Eo49i4N/Ul6HWk+AmvI0X3O+Ykzb9aTF3ufXznriXdtsck1/FW2aAB+sy24f09Ytk3RBEgiCHMoRIBBikg4bVYi/WNiaFTyK9+OaEBxqg8U1dvUaab9iMqRnj2TYwP36Xqt0wKLBi0CDslZszjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097192; c=relaxed/simple;
	bh=qLWsgQtbBtvs94ItOt9M5e4lJPvBuWWvYvSfSarFvB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxrXQihTuXnhJ3N1cMTrSppQQNqzybIrVi5uVTN3RXtfwshgkABS0Yj2IqbsqYTRSes/R7Wx/kl8kKw9LqdyL9CFT8ePFej8aqXGvnZC4dQEWULO25o0VLxwnEoB66ia3m2TphZpzCRNlnUt6vzD+/mjNm3LeLmP27ErAVRAG08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JVu7CEfJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6f453d2c5a1so3094117b3a.2
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2024 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1715097190; x=1715701990; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOHm2DakIrhZcNVck4viPIx9YeHbZbB/CZturHo1oZs=;
        b=JVu7CEfJFm5GfRrZcJwB3BV42NqlhBeL1vwr4jr5WkdtAXHyhQYn+ZEdqWkvXKI4ux
         0+ikDBFNCjIKzzbEHe0EopwcoZrE79MuBFrWcpa21yV30A5HH+QKY6v5KefYkXFYMBU6
         Ex7qOEdRVC7RmN/Kv+3uqfKkCjZVAShkHlS1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097190; x=1715701990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOHm2DakIrhZcNVck4viPIx9YeHbZbB/CZturHo1oZs=;
        b=JIjgK1GaIkozxRcxW47XqWp4sK2Sw+OvaVYiW7tm4NI0/2R68ZWjJtxeVDhsz80jG+
         hyWd8/P1U1nR0zBOkHA8rr4KM8W3j52ytxKGKSQuhhskjVIRAYran8w+T7jBmtAkcs9u
         E6gZdka5XwrfnY2LNSGt/McQMI2ih9YJKVpbI9uOZc5tEzwqNKegv9SKNIGtwWvy+CWA
         zxW3ihlqaB28m+JbYAQiul/MjB3mj6OzP0FB/bct+10GigRKvT90r11p7/rRVl3S67FJ
         DFP92bLJhdOYCcxZaF+lLtmSsJJJNKzwo/nyzoNh5ZLW8rG2fBowh6dAsjRwGQsWRH/B
         WZPw==
X-Forwarded-Encrypted: i=1; AJvYcCWq1+QZaVRci1+xo+x8yeHNmcfJ71ei5o5KEFt7Tv5Q4/9KdfVBMzCtegrXy74wjZ75zytxqkM9MXuuCJ0VN/n3RjW+UdYpZhaGOA==
X-Gm-Message-State: AOJu0Yz7q0tytbmlZkPcmo1m5kSMfNsLIMr/pIFqXVpZlFSHFEmTOuzH
	pm7YRJm15ijhhuBjGj8vNRJ5pdQ5ptlULkpb53vh3R0SITJv8DzcJlFT+/uaw9YCT6udi8BtO/d
	a
X-Google-Smtp-Source: AGHT+IFVr4swRlKhpNWtKXte+NmZTl8T548Ki1zg8M51GULQ9pwbRExIpW7LVzMelr0rEGLFFcwCHw==
X-Received: by 2002:a05:6a21:3d87:b0:1a9:cd98:5cd7 with SMTP id adf61e73a8af0-1afc8db5bbcmr92325637.39.1715097190098;
        Tue, 07 May 2024 08:53:10 -0700 (PDT)
Received: from cache-sql13432 ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b001e28f7c4233sm10142992plc.236.2024.05.07.08.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:53:09 -0700 (PDT)
Date: Tue, 7 May 2024 15:53:07 +0000
From: Joe Damato <jdamato@fastly.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <20240507155307.GA39934@cache-sql13432>
References: <20240502212628.381069-1-jdamato@fastly.com>
 <20240502212628.381069-2-jdamato@fastly.com>
 <ZjpMW7KKdtfXv2dd@lzaremba-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpMW7KKdtfXv2dd@lzaremba-mobl.ger.corp.intel.com>

On Tue, May 07, 2024 at 05:44:27PM +0200, Larysa Zaremba wrote:
> On Thu, May 02, 2024 at 09:26:25PM +0000, Joe Damato wrote:
> > mlx4_en_alloc_frags currently returns -ENOMEM when mlx4_alloc_page
> > fails but does not increment a stat field when this occurs.
> > 
> > struct mlx4_en_rx_ring has a dropped field which is tabulated in
> > mlx4_en_DUMP_ETH_STATS, but never incremented by the driver.
> > 
> > This change modifies mlx4_en_alloc_frags to increment mlx4_en_rx_ring's
> > dropped field for the -ENOMEM case.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > ---
> >  drivers/net/ethernet/mellanox/mlx4/en_rx.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > index 8328df8645d5..573ae10300c7 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > @@ -82,8 +82,10 @@ static int mlx4_en_alloc_frags(struct mlx4_en_priv *priv,
> >  
> >  	for (i = 0; i < priv->num_frags; i++, frags++) {
> >  		if (!frags->page) {
> > -			if (mlx4_alloc_page(priv, frags, gfp))
> > +			if (mlx4_alloc_page(priv, frags, gfp)) {
> > +				ring->dropped++;
> >  				return -ENOMEM;
> > +			}
> 
> Correct me if I'm wrong, but ring->dropped is added to rx_dropped stats in 
> mlx4_en_DUMP_ETH_STATS(). You have already established with Jakub that 
> allocation error does not mean dropped packet, but the counter contributes to 
> dropped packets stats.
> 
> Also, I do not think that using a `dropped` counter for something that does not 
> neccessarily result in a dropped packet is plain confusing.

Fair enough; I could add a new field called "alloc_fail" to
mlx4_en_rx_ring and increment that instead as it is, according to the
earlier thread, an alloc_fail as far as netdev-genl is concerned, I
think.

FWIW: I had spoken to Mellanox about this off list many weeks ago and
they had agreed at that time to this general approach. I haven't heard
from them in some time, but I am open to something else if that's the
blocker here.


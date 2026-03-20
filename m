Return-Path: <linux-rdma+bounces-18478-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDsSDyrTvWktCgMAu9opvQ
	(envelope-from <linux-rdma+bounces-18478-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 00:07:22 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F52E236E
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Mar 2026 00:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E16C303B5E9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 23:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6705D38E5DA;
	Fri, 20 Mar 2026 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="QJDVKa8I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D94B2EC0AE
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 23:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774048038; cv=none; b=pfHvN7544hCu3ZsVhtLX7WG60NiIw4jfXbt6ANV9dNbeCOni5V74j3S6NZ52p6d+f0v6qARunKHWubwBIw7FF54x74K512BUtUzdZTEyrCAIQJSLTEFsdngI+a8CeGcHF/abiNtf1LBcZ/MluXFBEhADHw2Bx806p9CiF+Kvhbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774048038; c=relaxed/simple;
	bh=vhh5f8BqOR3BFunaitjCFZrf/5fr92Up0kE/ShR83xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+xNwZ+n4KNQ1Gp0Vdv7XrEE1Zq7y1Ooe+IWrRpwAz4YVSReb6jZMLifJpjTadAR5H/m+LaeGhFQFPHGuJw2451l61rM7fVZ0uoEo9z71AO+ENgMzLFA/PAZM/VX8UPcav73qTlEr2CMESgvj4bHV7RqlWgrsIXWg+8Cl/hMFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=QJDVKa8I; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82ae379000fso517135b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 16:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774048036; x=1774652836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugrzy8U5XE3BV62lT1DuXlpfaQDw7/+LVR9/vo3V/dM=;
        b=QJDVKa8I1lMY07t7Jx3QthrguGLUvXakud5129meyXJSqHVqjGL8nfvnHrJdIxywAS
         WuJqakLpIsnHQAN8obxIyYCukQ4kxbr+Bu3/V3yq6N0FXvaW7ixfAPzv5kPmJazqNH2T
         CEopalODfpWYeBmHFZB+bFpVidMaCyaA2fTgHp7lWDUwtUvNsR0sxKdv8CS/p/AjtN2U
         sxSKAPLMeHwQb9o4yML30AR64l0up+ejJDu3MbFV2Ma98K9vMUrQDQRxlIEkUTmg+5So
         pJrgYzOoLkgmuPlvFXIKFiEid6VA7ufevHO3Kz7c46rE02YzCyb041O4SCM/UmPSAnZe
         gnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774048036; x=1774652836;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ugrzy8U5XE3BV62lT1DuXlpfaQDw7/+LVR9/vo3V/dM=;
        b=sUJfg+wfFUxesSNUXFlzXND5+dOy/am2KCCGc0QDTiDnQvyEqkd4KRj2ILvJt9Ltj0
         Vc25d/djHNA5qyCe+KnfeIr70Kf4OV37wtf5LH6eStdsIU7mW5S2FsrU98/V3U6ER3dB
         KbGhfS6a9tsbV6T18HzHgSEv5KScPxCWxmjZNJpxbDmCNJWYfTBJ7Pjy62TK8HGUlPlz
         gyy48etglewLyC2l3OTuVLZs9NrVaCRk+y8eP894S92L0qFx7GOnQ/ZoZ4/4VKU0dn6y
         F8J2NfH/jsJaCifTHfjPUvoqO8/woSK8FJh6JZ8BGu4iWWQmRRLwwkm/tIGmsSnHsoZr
         9d8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVlpmyUK3Ird/xd9Gfx0UYUCpbftNNLmpnnWcmq+LJBKCjIiS/YnRZhTl2SSMraYybzSbEJzpijhw0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1XL/VYjV9NikxoQmmbEuK5wsUspK4Mu7BjIA5MueZD+G84gj/
	3CQqWV4EukB5ycpffMrUzFmttoNwVzFQncftPDJqUu3+vY2uApw4ykRwDX9UeKV/kNs=
X-Gm-Gg: ATEYQzzFSxakg2qfGUjYdZS6FlCaW+RYD+X2JEQvCVQPBsu7w2RSG0oSdugzgIBjjR/
	8EIZHI2jl130gK/1f70KVDM7dR1Whqtg1xYB8IGG2PHKmnyY89ITsIvmvMDZG8eOhn28TQGUY39
	1IG7BhyUsyRrWNEDPHv9/WcLB/I0IOc5KzlPjUUqB11JsSL249eXMZjspQWD1Uf9HerJ1fQ/Re3
	rwNAQVypWWuQhJahjYM9E/VdR1hQYtfm6xPkskmENwhNFyJSLslT5nlo4jU69+XyCFw4F+ktKZf
	vre9c2lD0yN8Xf6z+WfBCzYBHhirAvcWGVcLxYKhFEIgag8iIREWEfh/kdTDHxkn60LTgaM7clq
	RliUYokVQ7b2MgTkciWtNEQxZtrVTbnne6D3yRMxVOHxe4MXqx1FImGW/x6vQbbDtcK57r4xpbg
	oNkTM=
X-Received: by 2002:a05:6a00:4197:b0:824:b03f:2f65 with SMTP id d2e1a72fcca58-82a7a7e5f12mr6357881b3a.7.1774048036628;
        Fri, 20 Mar 2026 16:07:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03aa79c6sm3145726b3a.10.2026.03.20.16.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 16:07:16 -0700 (PDT)
Date: Fri, 20 Mar 2026 16:07:15 -0700
From: Joe Damato <joe@dama.to>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Simon Horman <horms@kernel.org>, Shay Drori <shayd@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH mlx5-next 2/2] net/mlx5: Add vhca_id_type bit to alias
 context
Message-ID: <ab3TI1YgV4Lo6Xfe@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Saeed Mahameed <saeedm@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Mark Bloch <mbloch@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Simon Horman <horms@kernel.org>, Shay Drori <shayd@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
References: <20260319122211.27384-1-tariqt@nvidia.com>
 <20260319122211.27384-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319122211.27384-3-tariqt@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18478-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: A36F52E236E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 02:22:11PM +0200, Tariq Toukan wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Add vhca_id_type bit to alias context which allows indicating the
> vhca_id_type to be passed at vhca_id_to_be_accessed, which can be either
> HW or SW, note that SW_VHCA_ID must be used to allow alias to work
> properly after migration.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  include/linux/mlx5/mlx5_ifc.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>


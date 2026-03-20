Return-Path: <linux-rdma+bounces-18466-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIG5KEBrvWnL9gIAu9opvQ
	(envelope-from <linux-rdma+bounces-18466-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:44:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1C92DCD23
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 543E1305DD33
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB73C199F;
	Fri, 20 Mar 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg8+E2Hv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC51314D07
	for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021333; cv=none; b=S7MwPMvZGf7Lkc27Yab3KF77HSEmKoOLXox9DcYsBxFLGENVGMa99/o21PsjU/2094KmC4Yco0KQCgRMcNERB8WW1AMoeenhgDjhvAjBnZzP7EtDpo1GQrjY2C9H7rmW6O+sv7oTJx95Jsd1l4ySEbUshnFQAoKbdMhLX6ztwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021333; c=relaxed/simple;
	bh=GlvAavZbqeljA8Sa2OJilqymV+4h9KyZBFsyNSU1R2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9ySOyQ466PdZC6HPRvmyrogMA2vD8z0CY4ltEuuI7syR18i2vyCjK641iL0wCyBXbjJcSzV9Jn+gKQ1jgiCwmi0TR2It0axX38JKGyEVCRuOaFzVAFOEeW0qRyngPenqE1rvQRRzCCUDJ88Y526hCeexXxm133unBSCSIbLEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg8+E2Hv; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so153015eec.1
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2026 08:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774021331; x=1774626131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qhx7QtPFHsmhBqKEQ6XlDZutQ+YSTAHptMBIGgI83fw=;
        b=Vg8+E2HvQBxYjm95Khh3/xH1Lq+QBhfWxH2NMRDDA0kVO3MXpnkcPN54GjnBKp4JpR
         +WnCIfxYCdMRAiu0UHu8WRZ/lnNlJ6eV9DLlAQ3e27TbJ9tf+gq5wEcqKu1khQ5GqeZq
         cfauEPV9SctzJPs20QSBV20efJAuXFkQFSS1oNo5s8/XFTsuLacCSSJ6v71NFtf7s/WQ
         6pcucWOqi4Ws35jgBcv6o0wlP5ayZ0uLUBKu2Y9/Q/H5mjM2gv3zEdl66dQhAkHqmK7Y
         T2veQZpvxMNlxoDOhsr5e7SHlNabrnaLfWjGCqyy3ed9HaqnLvksIOYg6W47R0Bh/KMf
         yXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774021331; x=1774626131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qhx7QtPFHsmhBqKEQ6XlDZutQ+YSTAHptMBIGgI83fw=;
        b=f3YHbLSDSpZyJ3tgW0ih5reqeslsh63s1oYPJHksz/9c0ALOe66nQF1Qbxhk9aIuRd
         7AubbzcdF6SDTmXrCi932EyxOh356Qs3Rs1WKJ8X9MJR0GpDl6XpyfZ5xt47lFqJDVja
         DKT9+H612bgYG+AXBxKkYS956bNKvETkLJDDoyAUUQQLpF1Ipb0YBo234SLm6kHIDBoS
         n88LIHdoKqxi2dSvzx3AyXiuaNFphPMCOIPVKS/YvKz2q6e8daowYr0GmLW5lI3EqRA+
         +oRIfRTdcda8/v0XpsQOCdbJqJa7sphqcgnxul/4nhyQCKAzG3zbhHHgMYIVGMv5fpOO
         nIpA==
X-Forwarded-Encrypted: i=1; AJvYcCWBNPcvBD+6o5mJlGoW3nCcvdPKvNPRJaWH8xBLQvBFxvc6AxH3/4RqtYJj8vF03xwhhMANyqB+hdrF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8zLaZ1iipQAF1oJMoMdKdfZgU+bPFqYE2kd46+FpEgNSIRFpW
	VrXEOacxta5MnzfzCQx4RKNfXD7OJgMptiiVAbmoRkWPsAkq8MUPhYQ=
X-Gm-Gg: ATEYQzznBxaghoR2UIHduZvy1FmLffvvGT9FocKkTY91ZmgFUkLxmoK46Olh2ORCfcY
	7ECjwV/72H/Eluvq6hwiNjnH/jq8SqpGb/yJYTP0y7kkEnRszw/wVsG0SZV/TcXEu3cFRb/vOVf
	1UTmKXlE7o3JbiRX8veLe0SVB6Z3TfOCEnoaClCe3Px60VeTfLbAL9I6AvsIympPrIj0Dq1nA55
	LYHmgupmnSnFyDb5+lie8K1weiGazJQ26+UB+gLVhoe7NVfhEFcNPkSz1DSo9jT3WbgO7tffdh5
	ZBwPSSIS6dGD6dIgOGcmugIia0gUqEVb3fhQIAtq39DW1TpSZOxYf2et6n6yec4XbLkDWchXCyo
	MurngGwkX8Rp2jxraPyk/QGyTIQoSejCVG+A8e7y0tiR4TErJM5pwNKMaRyxstlDwFjnBtqhw0W
	cjW30E8o4P5hLx3E/DQJ2obRK2rBKKm5e4fZr+/F2Hx6m/9o4lWXnq35KtRDOoGy/U79B3kcBM+
	Vsza3GlXoNXSpKIFQcFlgWCGmgj
X-Received: by 2002:a05:7300:5b88:b0:2b7:32a6:82d1 with SMTP id 5a478bee46e88-2c10962a891mr1874265eec.13.1774021330366;
        Fri, 20 Mar 2026 08:42:10 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14bac4sm4502825eec.4.2026.03.20.08.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:42:09 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:42:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"willemb@google.com" <willemb@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skhawaja@google.com" <skhawaja@google.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"kees@kernel.org" <kees@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	"alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"leon@kernel.org" <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	Mark Bloch <mbloch@nvidia.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH net-next v3 06/13] mlx5: convert to ndo_set_rx_mode_async
Message-ID: <ab1q0aEaGmocJogG@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"willemb@google.com" <willemb@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skhawaja@google.com" <skhawaja@google.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"kees@kernel.org" <kees@kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>,
	"alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"leon@kernel.org" <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	Mark Bloch <mbloch@nvidia.com>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"aleksandr.loktionov@intel.com" <aleksandr.loktionov@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20260320012501.2033548-1-sdf@fomichev.me>
 <20260320012501.2033548-7-sdf@fomichev.me>
 <c0915086dc876f59e3c69886a8629efa3540d737.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0915086dc876f59e3c69886a8629efa3540d737.camel@nvidia.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18466-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,fomichev.me,lists.osuosl.org,gmail.com,meta.com,intel.com,davemloft.net,redhat.com,kernel.org,lwn.net,google.com,nvidia.com,fb.com,lunn.ch,broadcom.com,queasysnail.net,linuxfoundation.org,sipsolutions.net];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.739];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B1C92DCD23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/20, Cosmin Ratiu wrote:
> On Thu, 2026-03-19 at 18:24 -0700, Stanislav Fomichev wrote:
> > Convert mlx5 from ndo_set_rx_mode to ndo_set_rx_mode_async. The
> > driver's mlx5e_set_rx_mode now receives uc/mc snapshots and calls
> > mlx5e_fs_set_rx_mode_work directly instead of queueing work.
> > 
> > mlx5e_sync_netdev_addr and mlx5e_handle_netdev_addr now take
> > explicit uc/mc list parameters and iterate with
> > netdev_hw_addr_list_for_each instead of netdev_for_each_{uc,mc}_addr.
> > 
> > Fallback to netdev's uc/mc in a few places and grab addr lock.
> > 
> > Cc: Saeed Mahameed <saeedm@nvidia.com>
> > Cc: Tariq Toukan <tariqt@nvidia.com>
> > Cc: Cosmin Ratiu <cratiu@nvidia.com>
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  5 +++-
> >  .../net/ethernet/mellanox/mlx5/core/en_fs.c   | 30 ++++++++++++-----
> > --
> >  .../net/ethernet/mellanox/mlx5/core/en_main.c | 16 +++++++---
> >  3 files changed, 36 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > index c3408b3f7010..091b80a67189 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
> > @@ -201,7 +201,10 @@ int mlx5e_add_vlan_trap(struct
> > mlx5e_flow_steering *fs, int  trap_id, int tir_nu
> >  void mlx5e_remove_vlan_trap(struct mlx5e_flow_steering *fs);
> >  int mlx5e_add_mac_trap(struct mlx5e_flow_steering *fs, int  trap_id,
> > int tir_num);
> >  void mlx5e_remove_mac_trap(struct mlx5e_flow_steering *fs);
> > -void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
> > struct net_device *netdev);
> > +void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
> > +			       struct net_device *netdev,
> > +			       struct netdev_hw_addr_list *uc,
> > +			       struct netdev_hw_addr_list *mc);
> >  int mlx5e_fs_vlan_rx_add_vid(struct mlx5e_flow_steering *fs,
> >  			     struct net_device *netdev,
> >  			     __be16 proto, u16 vid);
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > index 55255fe6e415..a9daefbd8f8f 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
> > @@ -609,20 +609,26 @@ static void mlx5e_execute_l2_action(struct
> > mlx5e_flow_steering *fs,
> >  }
> >  
> >  static void mlx5e_sync_netdev_addr(struct mlx5e_flow_steering *fs,
> > -				   struct net_device *netdev)
> > +				   struct net_device *netdev,
> > +				   struct netdev_hw_addr_list *uc,
> > +				   struct netdev_hw_addr_list *mc)
> >  {
> >  	struct netdev_hw_addr *ha;
> >  
> > -	netif_addr_lock_bh(netdev);
> > +	if (!uc || !mc) {
> > +		netif_addr_lock_bh(netdev);
> > +		mlx5e_sync_netdev_addr(fs, netdev, &netdev->uc,
> > &netdev->mc);
> > +		netif_addr_unlock_bh(netdev);
> > +		return;
> > +	}
> >  
> >  	mlx5e_add_l2_to_hash(fs->l2.netdev_uc, netdev->dev_addr);
> > -	netdev_for_each_uc_addr(ha, netdev)
> > +
> > +	netdev_hw_addr_list_for_each(ha, uc)
> >  		mlx5e_add_l2_to_hash(fs->l2.netdev_uc, ha->addr);
> >  
> > -	netdev_for_each_mc_addr(ha, netdev)
> > +	netdev_hw_addr_list_for_each(ha, mc)
> >  		mlx5e_add_l2_to_hash(fs->l2.netdev_mc, ha->addr);
> > -
> > -	netif_addr_unlock_bh(netdev);
> >  }
> >  
> >  static void mlx5e_fill_addr_array(struct mlx5e_flow_steering *fs,
> > int list_type,
> > @@ -724,7 +730,9 @@ static void mlx5e_apply_netdev_addr(struct
> > mlx5e_flow_steering *fs)
> >  }
> >  
> >  static void mlx5e_handle_netdev_addr(struct mlx5e_flow_steering *fs,
> > -				     struct net_device *netdev)
> > +				     struct net_device *netdev,
> > +				     struct netdev_hw_addr_list *uc,
> > +				     struct netdev_hw_addr_list *mc)
> >  {
> >  	struct mlx5e_l2_hash_node *hn;
> >  	struct hlist_node *tmp;
> > @@ -736,7 +744,7 @@ static void mlx5e_handle_netdev_addr(struct
> > mlx5e_flow_steering *fs,
> >  		hn->action = MLX5E_ACTION_DEL;
> >  
> >  	if (fs->state_destroy)
> > -		mlx5e_sync_netdev_addr(fs, netdev);
> > +		mlx5e_sync_netdev_addr(fs, netdev, uc, mc);
> >  
> >  	mlx5e_apply_netdev_addr(fs);
> >  }
> > @@ -820,7 +828,9 @@ static void mlx5e_destroy_promisc_table(struct
> > mlx5e_flow_steering *fs)
> >  }
> >  
> >  void mlx5e_fs_set_rx_mode_work(struct mlx5e_flow_steering *fs,
> > -			       struct net_device *netdev)
> > +			       struct net_device *netdev,
> > +			       struct netdev_hw_addr_list *uc,
> > +			       struct netdev_hw_addr_list *mc)
> >  {
> >  	struct mlx5e_l2_table *ea = &fs->l2;
> >  
> > @@ -850,7 +860,7 @@ void mlx5e_fs_set_rx_mode_work(struct
> > mlx5e_flow_steering *fs,
> >  	if (enable_broadcast)
> >  		mlx5e_add_l2_flow_rule(fs, &ea->broadcast,
> > MLX5E_FULLMATCH);
> >  
> > -	mlx5e_handle_netdev_addr(fs, netdev);
> > +	mlx5e_handle_netdev_addr(fs, netdev, uc, mc);
> >  
> >  	if (disable_broadcast)
> >  		mlx5e_del_l2_flow_rule(fs, &ea->broadcast);
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > index f7009da94f0b..e86cf1ee108d 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> > @@ -4108,11 +4108,16 @@ static void mlx5e_nic_set_rx_mode(struct
> > mlx5e_priv *priv)
> >  	queue_work(priv->wq, &priv->set_rx_mode_work);
> >  }
> >  
> > -static void mlx5e_set_rx_mode(struct net_device *dev)
> > +static void mlx5e_set_rx_mode(struct net_device *dev,
> > +			      struct netdev_hw_addr_list *uc,
> > +			      struct netdev_hw_addr_list *mc)
> >  {
> >  	struct mlx5e_priv *priv = netdev_priv(dev);
> >  
> > -	mlx5e_nic_set_rx_mode(priv);
> > +	if (mlx5e_is_uplink_rep(priv))
> > +		return; /* no rx mode for uplink rep */
> > +
> > +	mlx5e_fs_set_rx_mode_work(priv->fs, dev, uc, mc);
> 
> While this chunk is correct, I think there's a logical conflict waiting
> to happen with Saeed's pending patch touching this area ([1]).
> 
> You have inlined mlx5e_nic_set_rx_mode here, but after Saeed's patch
> the mlx5e_is_uplink_rep condition added here should be dropped.
> 
> Not sure the automatic merge will do that.
> 
> [1]
> https://lore.kernel.org/netdev/20260319005456.82745-1-saeed@kernel.org/T/#u

Thanks for the heads up, will try to wait for this to be pulled before
reposting!


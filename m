Return-Path: <linux-rdma+bounces-18402-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M3qEgofvGkvswIAu9opvQ
	(envelope-from <linux-rdma+bounces-18402-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 17:06:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5782CE57B
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E89C330FB288
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5420C3E4C80;
	Thu, 19 Mar 2026 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+8mmbCo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501843E8C77
	for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2026 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935673; cv=none; b=UfW9NJ3QNj5dNwcFE6fcsvxl5dTrGkQ9VA7lU86+T5QpyqkGtQTPadUEa1o+w7R8DXpNcfj4g++TaCLjdz6MF8tq5pso90PoOGimNr68Tr+zv6Lkg6eYt7WDdZd2Oi8ohaIKozR/xcV/ag6ynsOQEYDvLF1Q4lea0ekEnlij5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935673; c=relaxed/simple;
	bh=R8P+nzrGUnHar1fqbHTHhRFzTZN26dppzSbv7zUS0FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtRcZLGU5QtDUsbvOct6Qvee7aZ9b40DHbbySk4bTsyGjttlWMYb9xeE3iACGGEgYR3V6hh+Dhs/0QNdtsZ529O7EWqGBrsAHG4xv1adkG0AFpYixmXnIJ0zokEaTvmUTBuOdaDUBqHFrkMB2oSJP19GH/Bn5mr1e1vazUT6frA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+8mmbCo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82987437624so671061b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2026 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773935670; x=1774540470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=flkM1UPgnzZIIWUPlhpYdE/CMruOMnml9ArMjCoVGE8=;
        b=m+8mmbCoDRXID1BSDq4Yo8bF2vMzor2WqvMm9Nw0Y2AJ63KQ206DCRziTdiW6BuDBa
         l+3E5e+hcL9SDO6+it1cO13CRo3sa4QYguChCHGKFBQQhZMsvRiNm0vpukn293Wesyw5
         NyhmpGeXMjIp52E4EiVka+WgbJIHq1h2wd1RegjH5L/RoZ29l8se8WoEOvKNAHhmRw1l
         ZSVEx2JAz5+O4cjZI1sVEGiqv0IXjbsOj8VtE0s8fsH3mR1Nho6okKKHAWGpQ6rXOUfK
         atalspuIyLhm79iWEeJCJ4L3dLxGToieE5iZjdmC+/p8rGo1NxzcAFaCVSlx+p11o04x
         S8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935670; x=1774540470;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flkM1UPgnzZIIWUPlhpYdE/CMruOMnml9ArMjCoVGE8=;
        b=RIXcKkLPP/YMgZs+hkwQXB730KIj61gTTDCFDNmBKLOafhkVoDBMyYa/n8SFHHlj/e
         tEkXn6i1/dVc4l2N3WjXrybwr8ZTrgWLtVQhwZJJZQRZpZEhPFKIPbUw5AmakY0FPa+n
         zbEwifA7/tUdSYpkFsiZn99TRSUZJcORaCeydmAlIfr0sdw0a6IiShxYoV0RG94im9IB
         Asr0b9uBmhzZ1xi/f4jwh3BCg4RXwE2uUuYoiTeiT1cYJnKqTGP5n5EVWSEr/7Az+L6q
         XbrU8lxMtnfCw+l0TrAbArCOqKg6vIhprib9OHl/2uSxoiDVWO6JiWKalUYbTX9GYaf1
         Ef4g==
X-Forwarded-Encrypted: i=1; AJvYcCVAkhkxcIEx7+FqFgIVX9Q6DfWivTROXthQSjze/t+Xmbrx3rDymPXaDzBHUeXXxIYDivcXnaJnj3nd@vger.kernel.org
X-Gm-Message-State: AOJu0YwzcxDsRefFsdwtgsgx7wYCi+O7XL2uTzFR4OaNKeguWkrCvf0t
	B5LxAcpro52E8Jgv7PF7sxdVskKdzBjoM6+7Pu3Q5q1eq8fauvTH9yY=
X-Gm-Gg: ATEYQzzYFkdaI5JnvoW5vex0M/N4z8DbEh1eIUuNZzfrsyHbTcE4jJYDLQLRGpEy7TJ
	CilSCupMvx0q/664zJDhwIGLOZ/U0sKB8RnmQBnT/amvkKk3bOcWsMjjCKw+XqzZZ44jjEG6M1j
	PBb6bPrAaOfYa7SIZsiwnKhu0t58UVBROs2mW/WsHPLiAzyEm3dj1F9qWEF60/ynv3hSxQ9A7dL
	eQ0VAHXHbAwgul6oxXJAw9AJMkqvr0/WeylIKfvg7wpxKwsYupvXFfnXvwzbhXsN1U5GJQDgBEq
	NVXbRQSpdtw9i3RemGUjz8FpsFcbS0YkmgV/dcf3yZyBVndRzYh/OAP0JFS5PpC2UX71/MXexpl
	QiV7zBeAytmvXGathQt8eanZ2KX+EtdV3ZKs0Ob7oXitqBgVkqkVYTtFQ23ca5HhN6iXgux8x2x
	VUqQEk+nsKhmqFYxIl0VFSiqKZfb8+mrqu54DUIdclpRxGZPWAc9MO81m5p3hXMouraFxFUyUhX
	VamsS/gNkS1T8BHxg==
X-Received: by 2002:a05:6a00:a8c:b0:829:f777:dad4 with SMTP id d2e1a72fcca58-82a7a97b202mr3053986b3a.29.1773935669410;
        Thu, 19 Mar 2026 08:54:29 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb51d1sm7913205b3a.28.2026.03.19.08.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:54:29 -0700 (PDT)
Date: Thu, 19 Mar 2026 08:54:28 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>,
	"dtatulea@nvidia.com" <dtatulea@nvidia.com>,
	"mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"willemb@google.com" <willemb@google.com>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 08/13] bnxt: use snapshot
 in bnxt_cfg_rx_mode
Message-ID: <abwcNMcZHW0ThCkW@mini-arch>
Mail-Followup-To: Stanislav Fomichev <stfomichev@gmail.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"pavan.chebbi@broadcom.com" <pavan.chebbi@broadcom.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"saeedm@nvidia.com" <saeedm@nvidia.com>,
	"tariqt@nvidia.com" <tariqt@nvidia.com>,
	"mbloch@nvidia.com" <mbloch@nvidia.com>,
	"alexanderduyck@fb.com" <alexanderduyck@fb.com>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	"jianbol@nvidia.com" <jianbol@nvidia.com>,
	"dtatulea@nvidia.com" <dtatulea@nvidia.com>,
	"mohsin.bashr@gmail.com" <mohsin.bashr@gmail.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	"willemb@google.com" <willemb@google.com>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"bestswngs@gmail.com" <bestswngs@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"leon@kernel.org" <leon@kernel.org>
References: <20260318150305.123900-1-sdf@fomichev.me>
 <20260318150305.123900-9-sdf@fomichev.me>
 <IA3PR11MB89866985981DB64EFEBDF0ACE54FA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89866985981DB64EFEBDF0ACE54FA@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18402-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[fomichev.me,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.827];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DC5782CE57B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/19, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Stanislav Fomichev
> > Sent: Wednesday, March 18, 2026 4:03 PM
> > To: netdev@vger.kernel.org
> > Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> > pabeni@redhat.com; horms@kernel.org; corbet@lwn.net;
> > skhan@linuxfoundation.org; andrew+netdev@lunn.ch;
> > michael.chan@broadcom.com; pavan.chebbi@broadcom.com; Nguyen, Anthony
> > L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; saeedm@nvidia.com; tariqt@nvidia.com;
> > mbloch@nvidia.com; alexanderduyck@fb.com; kernel-team@meta.com;
> > johannes@sipsolutions.net; sd@queasysnail.net; jianbol@nvidia.com;
> > dtatulea@nvidia.com; sdf@fomichev.me; mohsin.bashr@gmail.com; Keller,
> > Jacob E <jacob.e.keller@intel.com>; willemb@google.com;
> > skhawaja@google.com; bestswngs@gmail.com; linux-doc@vger.kernel.org;
> > linux-kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
> > rdma@vger.kernel.org; linux-wireless@vger.kernel.org; linux-
> > kselftest@vger.kernel.org; leon@kernel.org
> > Subject: [Intel-wired-lan] [PATCH net-next v2 08/13] bnxt: use
> > snapshot in bnxt_cfg_rx_mode
> > 
> > With the introduction of ndo_set_rx_mode_async (as discussed in [0])
> > we can call bnxt_cfg_rx_mode directly. Convert bnxt_cfg_rx_mode to use
> > uc/mc snapshots and move its call in bnxt_sp_task to the section that
> > resets BNXT_STATE_IN_SP_TASK. Switch to direct call in
> > bnxt_set_rx_mode.
> > 
> > 0:
> > https://lore.kernel.org/netdev/CACKFLi=5vj8hPqEUKDd8RTw3au5G+zRgQEqjF+
> > 6NZnyoNm90KA@mail.gmail.com/
> > 
> > Cc: Michael Chan <michael.chan@broadcom.com>
> > Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 ++++++++++++++--------
> > -
> >  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> ...
> 
> > -static int bnxt_cfg_rx_mode(struct bnxt *bp)
> > +static int bnxt_cfg_rx_mode(struct bnxt *bp, struct
> > netdev_hw_addr_list *uc,
> > +			    struct netdev_hw_addr_list *mc)
> >  {
> >  	struct net_device *dev = bp->dev;
> >  	struct bnxt_vnic_info *vnic = &bp-
> > >vnic_info[BNXT_VNIC_DEFAULT];
> > @@ -13623,7 +13625,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
> >  	bool uc_update;
> > 
> >  	netif_addr_lock_bh(dev);
> > -	uc_update = bnxt_uc_list_updated(bp, &dev->uc);
> > +	uc_update = bnxt_uc_list_updated(bp, uc);
> >  	netif_addr_unlock_bh(dev);
> > 
> >  	if (!uc_update)
> > @@ -13642,7 +13644,7 @@ static int bnxt_cfg_rx_mode(struct bnxt *bp)
> >  	if (netdev_uc_count(dev) > (BNXT_MAX_UC_ADDRS - 1)) {
> >  		vnic->rx_mask |=
> > CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
> This limit check uses the live device list, dev->uc.
> In the new async model, the live list can differ from the snapshot.

Oh, yes, good catch! Will do s/netdev_uc_count/netdev_hw_addr_list_count(uc).


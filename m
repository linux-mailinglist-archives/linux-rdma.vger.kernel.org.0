Return-Path: <linux-rdma+bounces-20255-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB/tDkwN/mm2mQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20255-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 18:20:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D33D4F95A3
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 18:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C25E130528AC
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982FA3FD12A;
	Fri,  8 May 2026 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="daEkcEoH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843893DA7F2
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257166; cv=none; b=TAK2Doco0E7CtVS4msc2Cirf0qn+LBJ3HMUigxEf14S2aDUdxeMvUQk6Ox2fZ+p1xtGEoIQOxTeKWJYsP8VnGKUc2LZx94mzUPDxqWalMVfk5X37W+6ZBLz0sOVXV7sfh0kQdccADcK6IcQoG7mshspPS8HAYjuEngQzwdhSQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257166; c=relaxed/simple;
	bh=uc3jnip+H+oiJSYneTaQeBj5rHlfyX/72RGhkpqkc34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhQ9n1UyhMAVomV9+c3cY5b7k4ibOkdpAfa4yHUIX7AoHjbxUWe5TCg1zaBokAlRbNxLjIGslCv5HrJnNfQN+UEHgFiWyMQ+qMqXNG9eufI1mrN9c3Qj0H7GfZ49accs+lI/tJcinHtVGOm6+NESqFQ/L4kGyL3rulZtXZoST4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=daEkcEoH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8e0a768331cso343355585a.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 09:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778257160; x=1778861960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4bkqlCvbruBHnLjafR3XguFKTezYBeYRy/KbFBaQEw0=;
        b=daEkcEoH1UhQuK+JpnN1jrE/KdqXkddeyf858Hm0b8tLuc0/CJEGBoPTjizNAgLnIA
         vhElmBKzNi8+wLbmNYYtHbu+EARdyEWCwNGFdn5GUwIA1oqD+D70Vwm+Lhnv9KMuM7qs
         27/p7UZFnH13LGY0bIcihBOBsfMmoJXDhKsETkXEEvCiT1BCgmg6HQ0bVc7cDstTDk02
         X0KCPgEpGzQs5gCSbVgBC/eI+DFTK9QDmU0K19YQDem3IPv9FR3gJJYJAh4ePtUn/d3A
         qE//px4aaoaZM55Dytc/NGh/AwIPe+6myMJSgx9S/W6O8frsgCGgKflLJMW2NzOuzJhV
         qoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257160; x=1778861960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bkqlCvbruBHnLjafR3XguFKTezYBeYRy/KbFBaQEw0=;
        b=g/Gs8AG5Us6S48l2uk0L273vZAjQ2/ZbmjbsTetUx7j5ToGctIBnbWI/d2ragSi1cs
         fzDZ9l3kL/2vwVMhgibin4Pu0mrpC2Qplhh1PuuNyrNP0iJp1vrs41WFl9A7UaEQu2HB
         PcxReDhbX3Cd/Ev9UvU/cect0rOjKjD98Xtg2fL7qJ2p57o44pRjwZvTGE3BVkoZEqHo
         jmGHUG6EavzOYsl5q6AqagLNcKu6nNnulVb/6gMHgJQDm5m4M5U6Ddy0C4DOv5UjZLvZ
         E8Srf17wFktKy0VUBlsnzyUhn6CBKba5IGnjHATGhd7Z7ar1Svj/VbYusknzLzaALDdQ
         T9Lg==
X-Forwarded-Encrypted: i=1; AFNElJ9V+63Ko/Ga9/bsTDNyyWKlvfmxxaLPaaz9bYJDKG23H3eHQ2AS1895Bkd3LQVwzZjMJQdqlAsWdF0e@vger.kernel.org
X-Gm-Message-State: AOJu0YwIl7EQcEfYHFHSm5sRh5vlmcgoF1x8FMaBG/n/OGGtxFxDH+YI
	R6W/1cgJxyfI+Ds97UoswEicWIwnBqhJhu/s6GuGbVh7SpESYp34dyRY
X-Gm-Gg: AeBDieuUTyZcDKxToiOJBURHRCjup5LzTk9X/vhH0i7PHodvX038aTsrc0sZsV98hrz
	qKuV0SfiStMJ0G8MmWPIXZXofUxRfkFEUFVvGhMIdtHOeeU9VP9G2foHypJAk1V/r4sX1uqQUzl
	lKh2zq5Gayc/fUAzxd+51Jx2YGgIQuLVFjDv1Ircj/TNpNt42r41Qi70P1Wn1bBct1KWZNJZHQW
	nlkkqIkaAQrK0bSOxNKS1BgqRPf7WixQT21nKTaUwMYiiM7VCU34fWxvJ10OJgadQcDN+P2Wo2D
	TD+ZG3284MKmeGOjHm0PpuLFQV8mbeOakqSp9J+v1+P2ryXKyKAer/qRgNuvOV+D1ceQaMMvNSB
	EtLHwYohf2jM2hA6tTSfMp9xxq4j89tbqTjld+11ptw4GZp5TGo6vaKS+rq0YEng6Yj3T/+uvHZ
	1nhNyZqGK42pPrDe5dWD6fslwAgfIFZtaV5MQTIes05ZIn2JpJyLBwhhSw8Q==
X-Received: by 2002:a05:620a:4554:b0:8cd:94f9:1bc5 with SMTP id af79cd13be357-90650ef5401mr1076760685a.12.1778257160389;
        Fri, 08 May 2026 09:19:20 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:1b::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b986aeccsm228049085a.4.2026.05.08.09.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:19:19 -0700 (PDT)
Date: Fri, 8 May 2026 09:19:13 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk,
	mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <af4NAebQLJbdCB6p@devvm29614.prn0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
 <af3593dYeiEeMzC2@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af3593dYeiEeMzC2@devvm7509.cco0.facebook.com>
X-Rspamd-Queue-Id: 8D33D4F95A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20255-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm29614.prn0.facebook.com:mid,meta.com:email,fomichev.me:email]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 08:01:17AM -0700, Stanislav Fomichev wrote:
> On 05/07, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > When a netkit virtual device leases queues from a physical NIC, devmem
> > TX bindings created on the netkit device must still result in the dmabuf
> > being mapped for dma by the physical device. This patch accomplishes
> > this by teaching the bind handler to search for the underlying
> > DMA-capable device by looking it up via leased rx queues. The function
> > netdev_find_netmem_tx_dev(), used for finding the underlying DMA-capable
> > device, can be extended to support other non-netkit NETMEM_TX_NO_DMA
> > devices in the future if needed.
> > 
> > Additionally, this patch extends validate_xmit_unreadable_skb() to
> > support the netkit case, where the skb is validated twice: once on the
> > netkit guest device and again on the physical NIC after BPF redirect or
> > ip forwarding.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v3:
> > - Fix validate_xmit_unreadable_skb() bug for non-devmem
> >   unreadable niovs (should not be dropped)
> > - Major simplification of validate_xmit_unreadable_skb()
> > - Fix prematurely released lock in bind-tx handler (Jakub)
> > 
> > Changes in v2:
> > - In validate_xmit_unreadable_skb() to check netmem_tx mode before
> >   inspecting frags (Jakub)
> > - Lock bind_dev around netdev_queue_get_dma_dev() when bind_dev !=
> >   netdev to fix lockdep (Sashiko)
> > ---
> >  net/core/dev.c         |  3 +++
> >  net/core/devmem.c      |  6 +++--
> >  net/core/devmem.h      |  9 ++++++--
> >  net/core/netdev-genl.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++----
> >  4 files changed, 72 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index fbe4c328a367..268417c9ef22 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -3999,6 +3999,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
> >  	if (dev->netmem_tx == NETMEM_TX_NONE)
> >  		goto out_free;
> >  
> > +	if (dev->netmem_tx == NETMEM_TX_NO_DMA)
> > +		goto out;
> > +
> 
> Since this is a good case, maybe fold it into skb_frags_readable check above?
> 
> 	if (likely(skb_frags_readable() || netmem_tx == NETMEM_TX_NO_DMA))
> 
> Otherwise it's a bit confusing to have:
> 
> if (xxx)
> 	goto out;
> if (yyy)
> 	goto out_free;
> if (zzz)
> 	goto out;
> 
> (or, reorder to be out/out/out_free)
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Makes sense, will use the combined conditional.

Best,
Bobby


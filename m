Return-Path: <linux-rdma+bounces-12304-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFD6B0A563
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 15:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7441887AC8
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0B414A60D;
	Fri, 18 Jul 2025 13:42:54 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE162AD2F;
	Fri, 18 Jul 2025 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752846174; cv=none; b=ILDbnRKs3Pr1Sua7Fm9Z592AQsBYlYxLR54qrRtMoN5JyXrcphS4h05c851vlnAaOr3JtylnCyAb1U9Bz0m8N2KodOyM/JWRwAxuv/f049Mqp0Djm3jwRZqXBoytrMlEwpBBoFZ9Srfn8p1byx/ZhJzBCeZd3oD91Jl756bfhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752846174; c=relaxed/simple;
	bh=lV1nwsPTJfsJJGOsNP7H/houicUwMhl6uPB07Snem7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivMKht8jI7I4pFNBAPqF3QbEwqcRW76Q3Y5M0uiLECqvf2R8kHqykQcZjU1q7eemRUgz2gxItahxF9W8kIKwSDPgu3StCTJztFcL6eJIID3S5EyEXXA1D9jzw84iK4u+7e6VEqcXP3ZiggIhwHr89V+79O4WrsD9h43WktPDfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 623FC61E647AC;
	Fri, 18 Jul 2025 15:41:41 +0200 (CEST)
Message-ID: <7ae9f1ad-0882-4c33-9979-fafb03f7de18@molgen.mpg.de>
Date: Fri, 18 Jul 2025 15:41:39 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 1/2] ice: Don't use %pK
 through printk or tracepoints
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>
References: <20250718-restricted-pointers-net-v4-0-4baa64e40658@linutronix.de>
 <20250718-restricted-pointers-net-v4-1-4baa64e40658@linutronix.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250718-restricted-pointers-net-v4-1-4baa64e40658@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Thomas,


Thank you for the patch.

Am 18.07.25 um 15:23 schrieb Thomas Weißschuh:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> Switch to the regular pointer formatting which is safer and
> easier to reason about.
> There are still a few users of %pK left, but these use it through seq_file,
> for which its usage is safe.

The line length are a little uneven.

> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c  |  2 +-
>   drivers/net/ethernet/intel/ice/ice_trace.h | 10 +++++-----
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index af68869693edf6004e70caa4e952794439d800ab..76d67b39a0c1af02293ef2df06a6735b46c6679f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -9153,7 +9153,7 @@ static int ice_create_q_channels(struct ice_vsi *vsi)
>   		list_add_tail(&ch->list, &vsi->ch_list);
>   		vsi->tc_map_vsi[i] = ch->ch_vsi;
>   		dev_dbg(ice_pf_to_dev(pf),
> -			"successfully created channel: VSI %pK\n", ch->ch_vsi);
> +			"successfully created channel: VSI %p\n", ch->ch_vsi);
>   	}
>   	return 0;
>   
> diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
> index 07aab6e130cd553fa1fcaa2feac9d14f0433239a..4f35ef8d6b299b4acd6c85992c2c93b164a88372 100644
> --- a/drivers/net/ethernet/intel/ice/ice_trace.h
> +++ b/drivers/net/ethernet/intel/ice/ice_trace.h
> @@ -130,7 +130,7 @@ DECLARE_EVENT_CLASS(ice_tx_template,
>   				   __entry->buf = buf;
>   				   __assign_str(devname);),
>   
> -		    TP_printk("netdev: %s ring: %pK desc: %pK buf %pK", __get_str(devname),
> +		    TP_printk("netdev: %s ring: %p desc: %p buf %p", __get_str(devname),
>   			      __entry->ring, __entry->desc, __entry->buf)
>   );
>   
> @@ -158,7 +158,7 @@ DECLARE_EVENT_CLASS(ice_rx_template,
>   				   __entry->desc = desc;
>   				   __assign_str(devname);),
>   
> -		    TP_printk("netdev: %s ring: %pK desc: %pK", __get_str(devname),
> +		    TP_printk("netdev: %s ring: %p desc: %p", __get_str(devname),
>   			      __entry->ring, __entry->desc)
>   );
>   DEFINE_EVENT(ice_rx_template, ice_clean_rx_irq,
> @@ -182,7 +182,7 @@ DECLARE_EVENT_CLASS(ice_rx_indicate_template,
>   				   __entry->skb = skb;
>   				   __assign_str(devname);),
>   
> -		    TP_printk("netdev: %s ring: %pK desc: %pK skb %pK", __get_str(devname),
> +		    TP_printk("netdev: %s ring: %p desc: %p skb %p", __get_str(devname),
>   			      __entry->ring, __entry->desc, __entry->skb)
>   );
>   
> @@ -205,7 +205,7 @@ DECLARE_EVENT_CLASS(ice_xmit_template,
>   				   __entry->skb = skb;
>   				   __assign_str(devname);),
>   
> -		    TP_printk("netdev: %s skb: %pK ring: %pK", __get_str(devname),
> +		    TP_printk("netdev: %s skb: %p ring: %p", __get_str(devname),
>   			      __entry->skb, __entry->ring)
>   );
>   
> @@ -228,7 +228,7 @@ DECLARE_EVENT_CLASS(ice_tx_tstamp_template,
>   		    TP_fast_assign(__entry->skb = skb;
>   				   __entry->idx = idx;),
>   
> -		    TP_printk("skb %pK idx %d",
> +		    TP_printk("skb %p idx %d",
>   			      __entry->skb, __entry->idx)
>   );
>   #define DEFINE_TX_TSTAMP_OP_EVENT(name) \

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


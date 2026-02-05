Return-Path: <linux-rdma+bounces-16557-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCkyGmUphGna0AMAu9opvQ
	(envelope-from <linux-rdma+bounces-16557-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 06:23:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F358EEEB15
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 06:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893AA3010BA6
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 05:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ADC10F2;
	Thu,  5 Feb 2026 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0cMBLpO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A32367AC;
	Thu,  5 Feb 2026 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770269016; cv=none; b=E9fF6Kcj4rj7g7c+ZFOhZLWoAacPi750hwEr1jTbJGfcFMU8CCRoV0VV5oXHR2wPBO5Kh8DY1dFAGlTgTOQusQQTGBqjGeoXiM9X6qsP580vcA2sAU6J/AtAyc6M1Ws7IkgN8T1brkvKXoomTiD/RqJQ5tTeyWgV+3/9nIOwzAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770269016; c=relaxed/simple;
	bh=rpQgaMbYOmoPSA+lSQAE3dsBM1LM68YW/eZGMaQU2BA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWJ4sx1gjqhyVxlMcrrXDtmAKeh0kgkaDISwEe0YTTqM5VLu65kiJMqeo3JLYy3gQs1zI+cYRXDCv1m5KXUdGCozv44XnMh5tpCOCFXf9EOdm1Ux3u9qb8w8hGFtO9ACvYJvaxdUBlzpyjEy368Hzzd7/azP7vTK8qbmLcJfUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0cMBLpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714C4C4CEF7;
	Thu,  5 Feb 2026 05:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770269016;
	bh=rpQgaMbYOmoPSA+lSQAE3dsBM1LM68YW/eZGMaQU2BA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i0cMBLpO5CB0sXlAtjWjv/4YsBOYhiXX7/geSoUpEVRX0WKsd5TpTsNGxoX3s7sZr
	 1uDIqBoNTjbaG2VIipFUoCd6TCLqAb+x1Ri7gQfDRC7RTbjCxi2xK8zDwQO3FLcXuE
	 wFOzzOqDUcn4R6rSKdfWT2NcGYmgQjDo5iPoPxvjNN1v77PMd3d9Imjr8gXIe/ekC5
	 kdCj9GN747pDAiBqpS20PZIDghzQfn5UKGej2zmKgek1UosLWsFD7xx9waxw55nn2R
	 +XYt1OwG8CFsiNSXRVGtGLJmL2fTxL1o/t6ZNkL0dUT5oddbZZX9vlC2aWEgKeC/mt
	 xaC3i2kIRD9SQ==
Date: Wed, 4 Feb 2026 21:23:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>, "Mark Bloch"
 <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe
 Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 2/5] net/mlx5e: Report hw_gro_packets and
 hw_gro_bytes netdev stats
Message-ID: <20260204212334.72b392af@kernel.org>
In-Reply-To: <20260204193315.1722983-3-tariqt@nvidia.com>
References: <20260204193315.1722983-1-tariqt@nvidia.com>
	<20260204193315.1722983-3-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16557-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F358EEEB15
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 21:33:12 +0200 Tariq Toukan wrote:
> +	stats->hw_gro_packets =
> +		rq_stats->gro_packets + xskrq_stats->gro_packets;
> +	stats->hw_gro_bytes = rq_stats->gro_bytes + xskrq_stats->gro_bytes;

Doesn't look right.. 

mlx5e_shampo_flush_skb(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match) 
{                                                                               
        struct sk_buff *skb = rq->hw_gro_data->skb;                             
        struct mlx5e_rq_stats *stats = rq->stats;                               
        u16 gro_count = NAPI_GRO_CB(skb)->count;                                
                                                                                
        if (likely(skb_shinfo(skb)->nr_frags))                                  
                mlx5e_shampo_align_fragment(skb, rq->mpwqe.log_stride_sz);      
        if (gro_count > 1) {                                                    
                stats->gro_skbs++;                                              
                stats->gro_packets += gro_count;       

And:
      -
        name: rx-hw-gro-packets
        doc: |
          Number of packets that were coalesced from smaller packets by the
          device. Counts only packets coalesced with the HW-GRO netdevice
          feature, LRO-coalesced packets are not counted.

      -
        name: rx-hw-gro-wire-packets
        doc: |
          Number of packets that were coalesced to bigger packetss with the
          HW-GRO netdevice feature. LRO-coalesced packets are not counted.
        type: uint

Your gro_packets are "gro-wire-packets" and "gro-packets" are your
gro_skbs.

I really wish the AI was clever enough to catch uAPI mis-reading :(
-- 
pw-bot: cr


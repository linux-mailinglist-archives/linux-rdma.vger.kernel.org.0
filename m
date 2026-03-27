Return-Path: <linux-rdma+bounces-18736-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMRJLHVvxmmkJwUAu9opvQ
	(envelope-from <linux-rdma+bounces-18736-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 12:52:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A246A343D28
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 12:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55F6B30682FC
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 11:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD4D37DEA0;
	Fri, 27 Mar 2026 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="Fut8Pt2f"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD030BB83
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611913; cv=none; b=GQL6s181StHrTV+cS6mEe+1BJ4CRrMIeoyWybUoUiIoCW0/Guz57StNnd8bcLoGSxonhSzClJxCo1FXJzSFSKRUABpHUg339gAUBFJRfJ7aJUA0cKGnwiCqUmGT3Bh9q3G+Cb4Eoffdr0/lEVSsSsoHg47RCzf9HWJ0R7bRLuJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611913; c=relaxed/simple;
	bh=S4w9Zb/UHoXsyxuEK/vrnzwO9gR74SVBfRFOdTg8F5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbYpkIuEeFDV9iuhxOCmK81AU/yZxam41n4iSYhke3cIjLeJOi/DT5+CFsdDCeQaxJj7dMc2n63GBw6cI3w6b+3qQHZQ70NykfV6az6YVKXHq5kpYBIyBuM2OQCow+ArF3F7u0bnnu/Yzs4fCaciqWBpvj4L2uYEWFXl1DQJqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=Fut8Pt2f; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 26322 invoked from network); 27 Mar 2026 12:45:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1774611903; bh=ClyMAST5Ou9swdngfYyP3nxlyzXf+yDAbxpymoT0Rjk=;
          h=From:To:Cc:Subject;
          b=Fut8Pt2f2FcKLZeKZU6PsuAH1IcmaM6XxqTkZQ8XewDKGzJKsPg+X/Axp2vAWRCc3
           3qnAY22THiRL5JSsDnOi6LQ5NhDheTCBhr6BOTjaYeOZ6LBEdep/O+evxzNJJbYD04
           K6A0diSmzXF22FjSBUU+0UZq99GX+WHfShkvuWqv8mc7O75d/HgkPLFkPzouFhag4n
           1YaqJDXLW+SaLHU1+xH4m1VlwmeT/qC1MOuFnaj01GZlMeDtJD8dOe/Dc4s25FKJFi
           OYova3fSHcfORauEu1dzJScFTX/KaH+Jbztse2qvin+3/6KGVc+cqlQ0xYFlhoy3qE
           i1MDyFUefqg3w==
Received: from 77-236-5-223.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <jackmanb@google.com>; 27 Mar 2026 12:45:02 +0100
Date: Fri, 27 Mar 2026 12:45:02 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Brendan Jackman <jackmanb@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Subject: Re: [PATCH v2 2/4] iwlegacy: 3945-mac: Fixup allocation failure log
Message-ID: <20260327114502.GA16800@wp.pl>
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
 <20260326-gfp64-v2-2-d916021cecdf@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-gfp64-v2-2-d916021cecdf@google.com>
X-WP-MailID: a5b414377b8f46f1eed9309472d3c6e9
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YTOh]                               
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18736-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,google.com,linux-foundation.org,oracle.com,davemloft.net,redhat.com,lists.freedesktop.org,vger.kernel.org,googlegroups.com,kvack.org,oss.oracle.com];
	FREEMAIL_FROM(0.00)[wp.pl];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:dkim,wp.pl:email,wp.pl:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: A246A343D28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Thu, Mar 26, 2026 at 12:31:58PM +0000, Brendan Jackman wrote:
> Fix 2 issues spotted by AI[0]:
> 
> 1. Missing space after the full stop.
> 
> 2. Wrong GFP flags are printed.

We should also initialize gfp_mask = priority inside the loop.
But this can be done as separate patch.

> And also switch to %pGg for the GFP flags. This produces nice readable
> output and decouples the format string from the size of gfp_t.
> 
> [0] https://sashiko.dev/#/patchset/20260319-gfp64-v1-0-2c73b8d42b7f%40google.com
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> index c148654aa9533..88b31e0b9568c 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> @@ -1002,9 +1002,9 @@ il3945_rx_allocate(struct il_priv *il, gfp_t priority)
>  				D_INFO("Failed to allocate SKB buffer.\n");
>  			if (rxq->free_count <= RX_LOW_WATERMARK &&
>  			    net_ratelimit())
> -				IL_ERR("Failed to allocate SKB buffer with %0x."
> +				IL_ERR("Failed to allocate SKB buffer with %pGg. "
>  				       "Only %u free buffers remaining.\n",
> -				       priority, rxq->free_count);
> +				       &gfp_mask, rxq->free_count);
>  			/* We don't reschedule replenish work here -- we will
>  			 * call the restock method and if it still needs
>  			 * more buffers it will schedule replenish */
> 
> -- 
> 2.51.2
> 


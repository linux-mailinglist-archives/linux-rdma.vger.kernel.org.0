Return-Path: <linux-rdma+bounces-17418-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGohIX3ApmlDTQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17418-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 12:05:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C9D1ED5AC
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 12:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C6DC310C3BC
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 10:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE73CE4BB;
	Tue,  3 Mar 2026 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyNR9zUU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tJ7L5XIw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F03CC9E3
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535401; cv=none; b=f7DVJXtA3LVUUZVKELa13n1TBFHbbMCFFFquQ6GaxE5Q//QkrNo/o7jT8A1HelNZ7coflkUE2y4mpy8U+m0rQcVxcfov/EQj9EKpryAC38NL78Sdd9qB2mzb1gHKOxaFAY5cpXCBX4srlUdkdHAhwbAPyplVoxv46Te/Eps4t5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535401; c=relaxed/simple;
	bh=sxxVfVpOS6gefLhTyaSzi6d8tpJBgjZuKKmC8M1vrOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S+Gv2wAT2sfgsjirA2VVcsBNHpSYdhBhOYdpiArjuuvuqziZaka52OE+QMVwXjpciL86QMVVP6yjN6QWiURb+Gg5cymGrtSD9uyEO10LvwKdMZbleyRvFnCtgDx7Nv0O2O3fPu9tr6+PBfhSeyq7izfxYAaz8sRXByejtwj88+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyNR9zUU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tJ7L5XIw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772535394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unnFcg3oz6A6y1pxfDBz1S5V10XOha7AqEFUFjOVM58=;
	b=YyNR9zUUpccpsFUaTj732mTcfyJHgW2+rfD/cOqa5aCc7iYzUCHlCBCcHiINOohp6EtGFB
	gcSSCRFQ489N3QUlXlZxORXnfy9FVQvtv5kqfn/pu2x01eKmXdsl8WwJKqb5izK/iNo1lM
	O0+TWj+EX2l86aA2/Wwn4fAnrpHsQZ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-R-cdkhuOM4auutqjJQbtrA-1; Tue, 03 Mar 2026 05:56:33 -0500
X-MC-Unique: R-cdkhuOM4auutqjJQbtrA-1
X-Mimecast-MFC-AGG-ID: R-cdkhuOM4auutqjJQbtrA_1772535392
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836fbfa35cso29905855e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2026 02:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772535392; x=1773140192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=unnFcg3oz6A6y1pxfDBz1S5V10XOha7AqEFUFjOVM58=;
        b=tJ7L5XIwnOWSLAs/1WjlOmuHEMBX48JwdwZ97rzru1iDBmQpWs9G6fAVSVuWr/Jukl
         8W8VAP9woRjyHkodR4XzR3zHT4bilT3dO8Mtv4iFkEgSFT7y+WxlwzweDgopWsi6dRbV
         5DFKgefDAijxCtDAlMNPd4e8fzVpK70a++aWpxNF2oU7u8xKGj8/6dVMXVLraOfwZfHW
         hq9Mx6Rf84hYYfgiB4uL2HN6S/ZQ58K6kzPzxR/GPQBIcFoFO0L8Zv2+OGoYIHHZqjWL
         k5BHksItHA564XnFhL1fQoqvtN1O5AV8by5ncYm05U6EX+T1XR+BuP5O49T14SwiLk6Q
         CIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772535392; x=1773140192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unnFcg3oz6A6y1pxfDBz1S5V10XOha7AqEFUFjOVM58=;
        b=KIg7pQNx8IitMig/S4fQxrm7IR20pu2BEus9UVY9BRmyW2OTbXaRzvxG6qDLr1GjBm
         SVmvoymUBm2mhoIP1SOo845OIleNaFM7UKQk5LhWfu4D/63bTeqK6pQrupfksE9bBrpJ
         hrSiPp5jF2SLxR5yoABfWktOITgwWyE8CJXWX1+F+FJgcSjtKHkReTdqTFEvodDuRsTG
         FNG0/0Ixl28VUgbjXRG+wkOUGSB4ZL+Bavv5GJceboVJ6rQJZCu+Cyo/txnKEnt8JAIC
         hslDSfx9aFYBQJCMTmoX5bUG46S3zVdYOocqEn9Uu4Cn6LxPjphbpNqwCGLHtaMdjIBH
         dHjA==
X-Forwarded-Encrypted: i=1; AJvYcCUmOd8A1TX6sySz3NSJzZBZe1iByR/XYtuUr5/Ztj8wAVyxk3iLeSmNSWf7kFnuWLcqLTYlsKLeHpEo@vger.kernel.org
X-Gm-Message-State: AOJu0YwPfBCq5NPZcgX+KoHxGs94TCHDC81GXTdKoyQhub9b710gekxm
	pmI1xgdAVDYm8oeHmBxJ2CqhJI6O7eA8poTR/xrSTiGylXzkq0fTagCuYlHLSjnLmVY7zp1YVx8
	Dt7l65xynSEKnpabDBRAWy15+fK/ya9suYQnPpFNAbCzWHC7HyVvMVfM8XcSh1FI=
X-Gm-Gg: ATEYQzw2p9ORZSUX5zh09aAgPmhAlupiq9SVIT5A+KH5iJslMi5vy+ScVYX4uZAhucW
	ufzK8/U+h+qIBwqNXWuRJk/Zx2huyeyF8yLFNVNt3b89RQpJFx1U9ghBnSn9trdo43z4eDY1nMI
	b+U/w/GTBwNRHUGmideSca0miIvW7br3Ed/8sVCuBmxVTNFHZqnJZ+XmEzXNFNKZstPGQElT5mj
	rEaO3TOXOVqfAaGYb1m6RpNgW3x53SGhiaMXp+aKGg0cj2fVuI2vTmLcSZd7gIhtHj+5WhfueOk
	AuLaFWT5G2wAtYZVk8Y9ThYornVqrlVNBG7b1KOjFCUiWEVyo0UiVmSALCEZ7lYcPll+00MeczK
	vP9JYKjtdi1ABducv6gU/T7Gm
X-Received: by 2002:a05:600c:6812:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-483c9ba3af1mr238405755e9.6.1772535391875;
        Tue, 03 Mar 2026 02:56:31 -0800 (PST)
X-Received: by 2002:a05:600c:6812:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-483c9ba3af1mr238405265e9.6.1772535391377;
        Tue, 03 Mar 2026 02:56:31 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd750701sm492414275e9.11.2026.03.03.02.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 02:56:30 -0800 (PST)
Message-ID: <81b7e296-0cfe-4c24-ac97-7f6c712aa0e9@redhat.com>
Date: Tue, 3 Mar 2026 11:56:29 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Force full-page RX buffers for 4K
 page size on specific systems.
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, dipayanroy@microsoft.com
References: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aaFusIxdbVkUqIpd@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 16C9D1ED5AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17418-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2/27/26 11:15 AM, Dipayaan Roy wrote:
> On certain systems configured with 4K PAGE_SIZE, utilizing page_pool
> fragments for RX buffers results in a significant throughput regression.
> Profiling reveals that this regression correlates with high overhead in the
> fragment allocation and reference counting paths on these specific
> platforms, rendering the multi-buffer-per-page strategy counterproductive.
> 
> To mitigate this, bypass the page_pool fragment path and force a single RX
> packet per page allocation when all the following conditions are met:
>   1. The system is configured with a 4K PAGE_SIZE.
>   2. A processor-specific quirk is detected via SMBIOS Type 4 data.
> 
> This approach restores expected line-rate performance by ensuring
> predictable RX refill behavior on affected hardware.
> 
> There is no behavioral change for systems using larger page sizes
> (16K/64K), or platforms where this processor-specific quirk do not
> apply.
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 120 ++++++++++++++++++
>  drivers/net/ethernet/microsoft/mana/mana_en.c |  23 +++-
>  include/net/mana/gdma.h                       |  10 ++
>  3 files changed, 151 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 0055c231acf6..26bbe736a770 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -9,6 +9,7 @@
>  #include <linux/msi.h>
>  #include <linux/irqdomain.h>
>  #include <linux/export.h>
> +#include <linux/dmi.h>
>  
>  #include <net/mana/mana.h>
>  #include <net/mana/hw_channel.h>
> @@ -1955,6 +1956,115 @@ static bool mana_is_pf(unsigned short dev_id)
>  	return dev_id == MANA_PF_DEVICE_ID;
>  }
>  
> +/*
> + * Table for Processor Version strings found from SMBIOS Type 4 information,
> + * for processors that needs to force single RX buffer per page quirk for
> + * meeting line rate performance with ARM64 + 4K pages.
> + * Note: These strings are exactly matched with version fetched from SMBIOS.
> + */
> +static const char * const mana_single_rxbuf_per_page_quirk_tbl[] = {
> +	"Cobalt 200",
> +};
> +
> +static const char *smbios_get_string(const struct dmi_header *hdr, u8 idx)
> +{
> +	const u8 *start, *end;
> +	u8 i;
> +
> +	/* Indexing starts from 1. */
> +	if (!idx)
> +		return NULL;
> +
> +	start   = (const u8 *)hdr + hdr->length;
> +	end = start + SMBIOS_STR_AREA_MAX;
> +
> +	for (i = 1; i < idx; i++) {
> +		while (start < end && *start)
> +			start++;
> +		if (start < end)
> +			start++;
> +		if (start + 1 < end && start[0] == 0 && start[1] == 0)
> +			return NULL;
> +	}
> +
> +	if (start >= end || *start == 0)
> +		return NULL;
> +
> +	return (const char *)start;

If I read correctly, the above sort of duplicate dmi_decode_table().

I think you are better of:
- use the mana_get_proc_ver_from_smbios() decoder to store the
SMBIOS_TYPE4_PROC_VERSION_OFFSET index into gd
- do a 2nd walk with a different decoder to fetch the string at the
specified index.

/P



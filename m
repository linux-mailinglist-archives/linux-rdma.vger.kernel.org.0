Return-Path: <linux-rdma+bounces-19790-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOSaCThu82m42gEAu9opvQ
	(envelope-from <linux-rdma+bounces-19790-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 16:59:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2EA4A4590
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 16:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 195083008241
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Apr 2026 14:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560C436344;
	Thu, 30 Apr 2026 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZ7cU/cS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35878436341
	for <linux-rdma@vger.kernel.org>; Thu, 30 Apr 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561142; cv=none; b=rTRR1WPb+RVpUzMXJhRGz5q12MxC45wG4WcpQGInkkyJ47ufBF56yc6r63hnXATmSu6pDUmW62+K+asxXjdWC59FjPiA+6vyhj48p+fMIrmZ5QIPmssUg/Vlf2RkjMSCVRTmiIS42Soh9LpRMHu3DCdqWNeSLwGGLMJxZVTT4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561142; c=relaxed/simple;
	bh=Qz5Jt0NLcw/CHQdPoqk28nrS/jgP5xrSiN2p0WHFcSM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iCSLfMDrLkMdtDKGZmosmxjXGvWby5GLxQr20DIKsub0uLy6WJWmc3sl6R2cnDCYw9HIh9lQFOyAJC41cpi7XFA2Sdr+W9X47vHqZIu0MRzraJLMHd8AL5Wd4PFBhlLDPgiP3R/gUZdcvWu6Ld8dQ8JTAJkvl2xW/R7Xyj7N4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iZ7cU/cS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFsLQaXt9E1BoxB2u4w8hFiRsin5lzaaJSXFo+bNxMc=;
	b=iZ7cU/cSV21NtwSy9Di53SDg1DzR7ANQIj78aGfgQIF4U17xpolHqhDZA0pMtiewv2ad+5
	M5hVKn3EsYRg27EtQ6bQDwtUIajiQS+qUqj2KDtNIZNZSbEnmvw7bHRN5d2LOQWiP9Jp1R
	UL5oHOWx1M8JInGpB1fcwzfHdq6kpEY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-2Zp1chH3Pa-zS4a6bqiIPg-1; Thu,
 30 Apr 2026 10:58:56 -0400
X-MC-Unique: 2Zp1chH3Pa-zS4a6bqiIPg-1
X-Mimecast-MFC-AGG-ID: 2Zp1chH3Pa-zS4a6bqiIPg_1777561132
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8C5D18001FA;
	Thu, 30 Apr 2026 14:58:51 +0000 (UTC)
Received: from [10.44.49.13] (unknown [10.44.49.13])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6619A1953944;
	Thu, 30 Apr 2026 14:58:45 +0000 (UTC)
Message-ID: <e1e35bf4-19af-4d69-b310-993b3fef24a4@redhat.com>
Date: Thu, 30 Apr 2026 16:58:44 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] dpll: rework fractional frequency offset
 reporting
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260429150817.3059763-1-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260429150817.3059763-1-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: BD2EA4A4590
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19790-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]



On 4/29/26 5:08 PM, Ivan Vecera wrote:
> Rework how the fractional frequency offset (FFO) is reported in
> the DPLL subsystem.
> 
> The fractional-frequency-offset-ppt attribute is moved from the
> top-level pin attributes into the pin-parent-device nested attribute
> set. This makes it consistent with phase-offset (which is already
> per-parent) and clarifies that FFO PPT represents the frequency
> difference between a pin and its parent DPLL device.
> 
> The two FFO contexts are distinguished in the ffo_get callback:
> dpll=NULL for the top-level RX vs TX symbol rate offset and a valid
> dpll pointer for the nested pin vs DPLL offset.
> 
> Patch 1 restructures the DPLL subsystem netlink handling, updates
> the YAML spec and driver-api documentation, and adds NULL guards
> to mlx5 and zl3073x drivers.
> 
> Patch 2 implements the nested FFO for zl3073x using the
> dpll_df_offset_x register with ref_ofst=1, providing 2^-48
> resolution. The old per-reference frequency measurement is removed
> as it was redundant with measured-frequency.
> 
> Ivan Vecera (2):
>    dpll: move fractional-frequency-offset-ppt under pin-parent-device
>    dpll: zl3073x: report FFO as DPLL vs input reference offset
> 
>   Documentation/driver-api/dpll.rst             | 16 +++++++
>   Documentation/netlink/specs/dpll.yaml         | 11 +++--
>   drivers/dpll/dpll_netlink.c                   | 34 ++++++++++----
>   drivers/dpll/dpll_nl.c                        |  1 +
>   drivers/dpll/zl3073x/chan.c                   | 31 ++++++++++++-
>   drivers/dpll/zl3073x/chan.h                   | 14 ++++++
>   drivers/dpll/zl3073x/core.c                   | 45 -------------------
>   drivers/dpll/zl3073x/dpll.c                   | 34 +++++++-------
>   drivers/dpll/zl3073x/ref.h                    | 14 ------
>   drivers/dpll/zl3073x/regs.h                   | 15 +++++++
>   .../net/ethernet/mellanox/mlx5/core/dpll.c    |  4 ++
>   11 files changed, 126 insertions(+), 93 deletions(-)

After merge of "dpll: add pin operational state" this needs to be rebased...

Will send v2.

I.



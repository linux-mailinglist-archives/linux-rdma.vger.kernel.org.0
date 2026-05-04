Return-Path: <linux-rdma+bounces-19965-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEt2LLQg+Wmz5wIAu9opvQ
	(envelope-from <linux-rdma+bounces-19965-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:41:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DA14C47C4
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 00:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5971301CCE2
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2026 22:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673738757B;
	Mon,  4 May 2026 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXEFVUOR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A785037C915
	for <linux-rdma@vger.kernel.org>; Mon,  4 May 2026 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777934476; cv=none; b=ff+wkCbsZRIQMihcC6eOlpnuygbrs7FTIIMPQUtjDZEk4TtOQxvAAF66twWUM4VideVGOuxWhDKbuUNiMs3f5+MSDx2Ik17z1OO1CLBG6EWxsRO8O21NZBoFKZ+CjCJIcxLDDsbGExDOAPGvD7+N5UateWf1ogpEa/nH2Df17mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777934476; c=relaxed/simple;
	bh=RzOqRkn/R0QNDsfK7K++CoXWWR3SbKNw/NPdyEFB+4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHN8EbXOnQzlB4IeD137NpdbAFuqhYMUKb07h9996gPP6nskQFnkq7oPE0Sw+WtxITcNE4dfUzY/2OTCEf/jgncROQwKaVN8lzJ34wrMqWTa4zBusBVuhau8Zw9np17zHyVIcw3K6MG48FxmVhR0cMC9Dvhj1PIFYKgqO2K0QWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXEFVUOR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3650453fb28so1833478a91.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2026 15:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777934473; x=1778539273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5BrO7xosGb8uYxA7cSQfYj/uPUPleoSCzn2z5rA8SqU=;
        b=aXEFVUORW+VWRWX9PZ4Dj88eFq/r3Qi8qperJz4m5LEGZ1aPVScvbXQ2Ac1jckISiY
         6JCWu+p+s7UdfbqGa5GuPE3YhmiWfW5S0DurA3EYhgt4S9m+DrwwF3FiiAP0f3eYgU9A
         5yOEg830m3ph2AUyCO9u9nf9ZqyPX+UrKxLPOiSSJ9OZJvnyXabZZOPFiY3rjhmLPw+M
         Rq+bCCUG1m5g1hespIECc86mxR80ghIupUnkGQhjq+OGjsS7OOPcK62JgrPBCZkMMyMz
         o67a6r/hn6qzbhQN9usdHlGxclrTa7VZY3k8bLhcYV8bVFlz2eRKo+VP2CxuDoFLGM7k
         HToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777934473; x=1778539273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BrO7xosGb8uYxA7cSQfYj/uPUPleoSCzn2z5rA8SqU=;
        b=Mf1f90Y7mU8W0Zu8aj0W5kSeXUwle6HVTDjddQ1SZTMquOUT8t+PL7ubVk0hdpVK7R
         VuDti9WJ783n1OgSLWIovPANsVzfbT96h6AVmwcu1/PMYJRk+Ks0r5xOh8a/FmSk4Ci7
         dXVJYJHASQ5k8Cd/oNP5XwPy/svSvZyQANU9UKM6Ii/9besSnhbqpwrO991yCBDR9oB4
         Nys10kc62RzhnROkU8/gtWgnk/UFCKlt5C77Xw2DBUTPBoyLzh05OTR9PXu/CFTNzIzZ
         5UC/hq2b5ipGZky7UsqUNdamL7utXD+oB50bBrUhh/RScL3oCf3p3RGbzot1CblTixFE
         Higg==
X-Forwarded-Encrypted: i=1; AFNElJ/zYHdSAwWRPBzFelROkUGwBVssqdwi+QrNwnO5BOWFz/aTI4+7C75Hd48pLoQdUDwXhNoXe704lLbY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk7ZfMQmVYvhpLo+zdGPjOV53KRxD0g3pj6ayrNIrRV/Kbl+Hm
	jD1jLqUCMJE03xck2sx5tcFMu195zR3T78CzhBnTKIA0y6+bqqc/7Zxr9Ikhz/GZcw==
X-Gm-Gg: AeBDieteEGwi+q0Xi7CqrCorWxSD7xauzWwQC4lAeG9SwusMD1ILPpkF2tPVnXQex2D
	J/zEiiTsTaN70EGgf+62iaAHOyIkowI6QfVLuwhEU98obCpN3t3chZiD4Jg/7UNXq01NT2xnyES
	dnTtyElmHZcIq/fG1WEBqVCAdrPSOfA905gl+H64RoIXsYAlX68EuMPJ4NGBCusmlfKq9P/T199
	n2u92hRVqX0x0NFiPr/TRJXJMLKcofhkAuP+OBQzxuQY8GijTOGbYW4xU4VEv7Yto+ZrsGc00Xu
	bg3d5HjKnF+Ox0sdNykbaxfToMkowxT0or51LIjQgpljHIMM8rY6pCm4uHLqG17iIiGw7Vx73K7
	P2kN6Op5gFp6u7Buy8hs3FaAfplXqfc96ULOwsSpmck3PBVLPDtVzYi5uzR0Jg5DmqAK4mHDUpm
	GO/X873SJ8Gxlmyx7LURxph3llzsNOGngCGWQHCLy6EJimYKI5Dqdo4QNQzBdBmJiiWig+G9Z23
	Kltp6ckzHFL6ciN
X-Received: by 2002:a17:902:e547:b0:2ae:6259:5aff with SMTP id d9443c01a7336-2ba535ae6c3mr4752285ad.6.1777934472389;
        Mon, 04 May 2026 15:41:12 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7ee38sm111789655ad.16.2026.05.04.15.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:41:11 -0700 (PDT)
Date: Mon, 4 May 2026 22:41:08 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 10/11] vfio: selftests: Add mlx5 driver - data path and
 memcpy ops
Message-ID: <afkghFm9Vo-SfF5c@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <10-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
X-Rspamd-Queue-Id: 61DA14C47C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19965-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:

> @@ -1368,6 +1716,11 @@ static void mlx5st_init(struct vfio_pci_device *device)
>  	mlx5st_alloc_pd(dev);
>  	mlx5st_create_mkey(dev);
>  
> +	mlx5st_setup_datapath(dev);
> +
> +	device->driver.max_memcpy_size = 1 << 20;
> +	device->driver.max_memcpy_count = SQ_WQE_CNT - 1;

What are these limits a function of? e.g. Is the 1MB size a hardware
limit? Can we change SQ_WQE_CNT in the future to increase max count?

I'm interested in this because for Live Update testing we've found it
valuable to keep the device busy for several minutes so that it can do
DMA continuously throughout the Live Update.

> +
>  	dev_dbg(device, "mlx5 driver initialized\n");
>  }


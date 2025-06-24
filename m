Return-Path: <linux-rdma+bounces-11564-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38411AE5C37
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 07:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C917AE694
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 05:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF32367AD;
	Tue, 24 Jun 2025 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b43uv2/H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U0xAvH2c";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yDW7BEbV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hEyMtFRo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAAC2343CF
	for <linux-rdma@vger.kernel.org>; Tue, 24 Jun 2025 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744650; cv=none; b=AsoeBb/ivQ/sb3UMqH4HVur9tOf+g1TG0B0AkdnJmjk2s5hWb7lX0g4wt+PX4ez5axq88ruC+H32CDRsJ4LIguEkl395aZgFqRKvZ+kYwhJMb4ZQYDvNKjbPq4ezU67z7yE01xo9R7j7v7HPEG7o/U5OwVwfPbosaTpaPtXHRNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744650; c=relaxed/simple;
	bh=ZCEaHHbvGFmHlhEgMB1oY0uHtx1+FRxydCL277Vh1yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bgd7Ta1KnXbe2dAzXwUMJBqLZBk1baZZfb7rzvanJcaNDwXqdLX9U7nhvvmLUTAj2aZf1EIUGAJdjrs7UVwThg7dcynWJyi5Ay3gvQbVi06t9ZFpxoF7Jr+vmAXeUSnUWpG8Ce5oSxvmGl9m8FA6b4EPzVlMb1FiO2ZD8htg/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b43uv2/H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U0xAvH2c; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yDW7BEbV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hEyMtFRo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DB084211AC;
	Tue, 24 Jun 2025 05:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750744646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maxTRfu8agyldfpH8NN8W68ZTiSlasbnmecpZeLiTuc=;
	b=b43uv2/HFTDU5U6EpLO1KaO/tAd0PGXx8cWvAwJioEIugRvTqwNm+eNu1svO8056zKClh+
	RHYD80WJLpgB1L6zCzUoD6/aL7VIxmBAqeGrHsak1AzglHrsoTSsqYh0AMf0mMF0LGUmwR
	4ZleTVQWq3EKoaAVLuwWYYMtSrS0O1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750744646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maxTRfu8agyldfpH8NN8W68ZTiSlasbnmecpZeLiTuc=;
	b=U0xAvH2cXdAusgaGwCnJYSdDf8q29EG+LRPXvJl/Idm7DdTniGyjH9r2GzDcDQwrmeQscL
	0X+li8cEKsvwYCDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yDW7BEbV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hEyMtFRo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750744645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maxTRfu8agyldfpH8NN8W68ZTiSlasbnmecpZeLiTuc=;
	b=yDW7BEbVYhnsdAklK8dyNF6MYgZ9JAYUcsPfMVowYIISHTvDe57IujR4e0snKTX/uidmSm
	hjmO+zQiz99vLKo/mmVIwmWa1xeJUGMGPF6H+AdoVKnDoUNWaHX/4rJV/UbmIRabqMV6t3
	n7WtoosnFEtS90CjSqu0nVsLPCkoNSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750744645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maxTRfu8agyldfpH8NN8W68ZTiSlasbnmecpZeLiTuc=;
	b=hEyMtFRoe3MZv6Q7gB43VbKGco/8jsAGLbpeaWEWBAZj4c9DF4RroITQb1RbrJkxvKAJaR
	j0gyTqjFLamPMwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CCBD13751;
	Tue, 24 Jun 2025 05:57:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g1ZJF0U+WmhbXAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Jun 2025 05:57:25 +0000
Message-ID: <00e46f70-0976-43be-a8c7-ffe690c5d677@suse.de>
Date: Tue, 24 Jun 2025 07:57:24 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] RDMA/srp: don't set a max_segment_size when
 virt_boundary_mask is set
To: Christoph Hellwig <hch@lst.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Ewan D. Milne" <emilne@redhat.com>, Laurence Oberman <loberman@redhat.com>,
 linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20250623080326.48714-1-hch@lst.de>
 <20250623080326.48714-2-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250623080326.48714-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,lst.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: DB084211AC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 6/23/25 10:02, Christoph Hellwig wrote:
> virt_boundary_mask implies an unlimited max_segment_size.  Setting both
> can lead to data corruption, and we're going to check for this in the
> SCSI midlayer soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/infiniband/ulp/srp/ib_srp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 1378651735f6..23ed2fc688f0 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -3705,9 +3705,10 @@ static ssize_t add_target_store(struct device *dev,
>   	target_host->max_id      = 1;
>   	target_host->max_lun     = -1LL;
>   	target_host->max_cmd_len = sizeof ((struct srp_cmd *) (void *) 0L)->cdb;
> -	target_host->max_segment_size = ib_dma_max_seg_size(ibdev);
>   
> -	if (!(ibdev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG))
> +	if (ibdev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
> +		target_host->max_segment_size = ib_dma_max_seg_size(ibdev);
> +	else
>   		target_host->virt_boundary_mask = ~srp_dev->mr_page_mask;
>   
>   	target = host_to_target(target_host);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


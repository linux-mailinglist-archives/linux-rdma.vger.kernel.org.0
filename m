Return-Path: <linux-rdma+bounces-11565-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BB0AE5C3B
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 07:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D0E37AE5D7
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 05:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1623E347;
	Tue, 24 Jun 2025 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ky4xv6Yq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pFGgy11G";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ky4xv6Yq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pFGgy11G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217123AE93
	for <linux-rdma@vger.kernel.org>; Tue, 24 Jun 2025 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744680; cv=none; b=hyliK+AeuiXKjuWnCifEkvnDcdoDpGbt1M0Ycazxetu317N9gw/6r3jLGFH6Y2ukkHy7dXjGO5MMRBklqKM2cT7ZWLUQsHjSmautJ1xLvjKgtR8LyfIQ8HEUPrBycKVfuDqaiUyzV34I6Q10Xfzm83JDNTV0/93xUqamSxzISlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744680; c=relaxed/simple;
	bh=7OO0zVMBn2QvNf8Qajk4JtDnlTDNgAnVi1O4yy2Z3ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTXewVXj8a0Xpv9rWX4HTQWpJPCgn7gKE+O8151FRThekcbDSUUVZOduVIoJ7XljYz1XEYz56fDJMRb8wP2QpJydi19GFL7uuBl70OzlBCRY8DDvfEkzFJt6JfMhX7xtggYbb6h+G7yFeE4dxr8q1o2otNLZzT4O9coYGlSs40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ky4xv6Yq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pFGgy11G; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ky4xv6Yq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pFGgy11G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 283F51F785;
	Tue, 24 Jun 2025 05:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750744677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJoyx986F+AhB0f90x+WHoTjZ4gb/HP6KX5rYDhU+/A=;
	b=Ky4xv6YqSc1kDxXm1eRnl/yOHPBySFBCpy8Q3JxWxA+eP85m6yj8tqfKo4tPoI88nd6oZe
	Su1B84mVZ2XnWJsR01/Hh1ReYzMNeqjHNFV5lS9U/7uHBJwXoraQyy35TcbWHzQ5tXunKb
	pnZ+tW4FZmJyIusa4K93fY0ShpGlFm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750744677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJoyx986F+AhB0f90x+WHoTjZ4gb/HP6KX5rYDhU+/A=;
	b=pFGgy11GeI2eQNrjmiFe+6X99/eWin4Y045/JZo3Apd4Zl74irDfWwDGHmUzpwls0LQh/Z
	ljHd/pXdoiFO7+Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ky4xv6Yq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pFGgy11G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1750744677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJoyx986F+AhB0f90x+WHoTjZ4gb/HP6KX5rYDhU+/A=;
	b=Ky4xv6YqSc1kDxXm1eRnl/yOHPBySFBCpy8Q3JxWxA+eP85m6yj8tqfKo4tPoI88nd6oZe
	Su1B84mVZ2XnWJsR01/Hh1ReYzMNeqjHNFV5lS9U/7uHBJwXoraQyy35TcbWHzQ5tXunKb
	pnZ+tW4FZmJyIusa4K93fY0ShpGlFm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1750744677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJoyx986F+AhB0f90x+WHoTjZ4gb/HP6KX5rYDhU+/A=;
	b=pFGgy11GeI2eQNrjmiFe+6X99/eWin4Y045/JZo3Apd4Zl74irDfWwDGHmUzpwls0LQh/Z
	ljHd/pXdoiFO7+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9182713751;
	Tue, 24 Jun 2025 05:57:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yOjIIWQ+WmiaXAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 24 Jun 2025 05:57:56 +0000
Message-ID: <8b439279-9e50-423d-ab87-4c65e2e21919@suse.de>
Date: Tue, 24 Jun 2025 07:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scsi: enforce unlimited max_segment_size when
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
 <20250623080326.48714-3-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250623080326.48714-3-hch@lst.de>
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
X-Rspamd-Queue-Id: 283F51F785
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 6/23/25 10:02, Christoph Hellwig wrote:
> The virt_boundary_mask limit requires an unlimited max_segment_size for
> bio splitting to not corrupt data.  Historically, the block layer tried
> to validate this, although the check was half-hearted until the addition
> of the atomic queue limits API.  The full blown check than triggered
> issues with stacked devices incorrectly inheriting limits such as the
> virt boundary and got disabled in commit b561ea56a264 ("block: allow
> device to have both virt_boundary_mask and max segment size") instead of
> fixing the issue properly.
> 
> Ensure that the SCSI mid layer doesn't set the default low
> max_segment_size limit for this case, and check for invalid
> max_segment_size values in the host template, similar to the original
> block layer check given that SCSI devices can't be stacked.
> 
> This fixes reported data corruption on storvsc, although as far as I can
> tell storvsc always failed to properly set the max_segment_size limit as
> the SCSI APIs historically applied that when setting up the host, while
> storvsc only set the virt_boundary_mask when configuring the scsi_device.
> 
> Fixes: 81988a0e6b03 ("storvsc: get rid of bounce buffer")
> Fixes: b561ea56a264 ("block: allow device to have both virt_boundary_mask and max segment size")
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/hosts.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


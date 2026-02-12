Return-Path: <linux-rdma+bounces-16777-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D5LLap4jWl63AAAu9opvQ
	(envelope-from <linux-rdma+bounces-16777-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 07:52:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F712ACF5
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 07:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43E630AA217
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5D0288513;
	Thu, 12 Feb 2026 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJamO0mA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C051D2264CA
	for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879143; cv=none; b=ofqfQRFnMN/AensC8z3NK9o46JdgFJGyKUj4ndiNr+6XGZGuiMzKOibRdrjVHfNTNjI2RKy+vYnCnxywpVSQauAymsSPxBtYDdj9xepphMz6+vkeOrvm7PxqZ0S+cjlbAzH+paUmUXP2hWd0xWhCjP9dHNCWf2NskG8hB0Hwv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879143; c=relaxed/simple;
	bh=wMMNsnPPjYhDrLFdc8m/9wbuGtv9ue13ToOdHk8kA14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dObAAfGRXH2c7oRbxAjPtjOmsAk8JXn+omD1/729fGUVxiARRXnsGzoitbqAJzxPF7QREnGDV5ElkPuj1+/66qLQ05PnBlvLpY2S5H4uWOIM+nPQJVBew3hzQ+aQxf7C0yJq8WKMwYcoT0AtHvcT2WOONyOrxHJo5ArfbJ8L1as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJamO0mA; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7f42c2e7-25bf-4b20-a464-939aa2552bfd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770879140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iov5tWEr2sIM+mUTJt9s3dw2K1Rdbl3k6j8CV2rPhc0=;
	b=BJamO0mARr/eRSOuE295APioFVxhRlorkRqmCjiWCYYaAyFxyvJhM1WxVlK15IPFQ8MmV+
	+Tw/dtNN/ZM+mF/qRdhxH5yM1NbJ+hMjtZH2KN1VwtqbzOhIjNexVTvXfNGknViZNIyeKo
	ubfj69N6TGpiyvCAFCsSIZw/I0XbSUM=
Date: Thu, 12 Feb 2026 08:52:14 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
To: Tom Sela <tomsela@amazon.com>, mrgolin@amazon.com, jgg@nvidia.com,
 leon@kernel.org, linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Yonatan Nachum <ynachum@amazon.com>
References: <20260211131048.36217-1-tomsela@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20260211131048.36217-1-tomsela@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16777-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal.pressman@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 103F712ACF5
X-Rspamd-Action: no action

On 11/02/2026 15:10, Tom Sela wrote:
> +static int efa_add_ah(struct efa_dev *dev, u16 ah)
> +{
> +	unsigned long refcount;
> +	void *entry;
> +	int err;
> +
> +	xa_lock(&dev->ahs_xa);
> +	entry = xa_load(&dev->ahs_xa, ah);
> +	refcount = entry ? xa_to_value(entry) : 0;
> +	if (refcount == 0)
> +		atomic64_inc(&dev->ah_count);

What happens to this increment if the store fails?

> +
> +	err = xa_err(__xa_store(&dev->ahs_xa, ah, xa_mk_value(refcount + 1), GFP_ATOMIC));
> +	xa_unlock(&dev->ahs_xa);
> +
> +	return err;
> +}


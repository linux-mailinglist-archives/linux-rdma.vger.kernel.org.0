Return-Path: <linux-rdma+bounces-16778-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGYKNc54jWl63AAAu9opvQ
	(envelope-from <linux-rdma+bounces-16778-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 07:53:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 326C912ACFC
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 07:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE7ED30A96A0
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 06:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF44288513;
	Thu, 12 Feb 2026 06:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TWv3yRuf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C71DED5C
	for <linux-rdma@vger.kernel.org>; Thu, 12 Feb 2026 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879180; cv=none; b=nPvSJJn/7BQhmLCPFizgxeOia6TZAf1/T93tLMAw1O7/LiiZaXJvmxTi+ypo7c7wfdj58CuQv1zcIc8xbkaYflw50QhIZweGWVoQ4FgdkLUIE0qgljf+fxoe/BR8Dv1yNhn2ORUb0VFrAXSK9IyHMk0rwrn26CUKFUivVbscrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879180; c=relaxed/simple;
	bh=CbpLpNN5wfeJcXegEF/e67sBpIetlZClp3lL09lxafc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pX4IaYdfS1dHBbQh6eMJ7Hf9spxdQwzhVh/aSpQjofqya9ZwCa7c8bAXz+CLs/JZIL5BdrGR810noFaOvZFnYXQX8FFCTJpewhGxS838YEXaoajYbcpJ+02XmEzx+DKs9v/u1tgRsvWKcN94nXDXvZSatdq01wkg5Eyraq1mkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TWv3yRuf; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef07b718-0198-4f8c-86c1-56149c7fd239@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770879176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IohK9R4CIwFlOy8fUFFaLBzoXEmG7dWkV4tj9GLeH4U=;
	b=TWv3yRuf36SEqJfVrwOgeKzvAvG0+L6l89JtiZgNdzyXCDktAA/5T13xs+41FW5JMcTAAL
	Vv+vravNThCzLKEbRJ1wLEnmmyLeYLu+FSkJyEts9m7bdu7C2hILSLF+Ks1a/SuL8JkXZ3
	SWgxfroYWkS8ANUBvgAmISwwzint+xw=
Date: Thu, 12 Feb 2026 08:52:41 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Add AH usage counter with sysfs
 exposure
To: Jason Gunthorpe <jgg@nvidia.com>, Tom Sela <tomsela@amazon.com>
Cc: mrgolin@amazon.com, leon@kernel.org, linux-rdma@vger.kernel.org,
 sleybo@amazon.com, matua@amazon.com, Yonatan Nachum <ynachum@amazon.com>
References: <20260211131048.36217-1-tomsela@amazon.com>
 <20260211131338.GA1218606@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20260211131338.GA1218606@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-16778-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 326C912ACFC
X-Rspamd-Action: no action

On 11/02/2026 15:13, Jason Gunthorpe wrote:
> On Wed, Feb 11, 2026 at 01:10:48PM +0000, Tom Sela wrote:
>> +static ssize_t ah_count_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +	struct efa_dev *efa_dev = pci_get_drvdata(to_pci_dev(dev));
>> +
>> +	return sysfs_emit(buf, "%lld\n", atomic64_read(&efa_dev->ah_count));
>> +}
>> +
>> +static DEVICE_ATTR_RO(ah_count);
>> +
>> +int efa_sysfs_init(struct efa_dev *dev)
>> +{
>> +	struct device *device = &dev->pdev->dev;
>> +
>> +	if (device_create_file(device, &dev_attr_ah_count))
>> +		dev_err(device, "Failed to create AH count sysfs file\n");
> 
> This is not the right way to use sysfs in rdma drivers.
> 
> Also we have netlink counters as the prefered approach why are you
> using sysfs?

Yes, and EFA already supports stats reporting, the sysfs choice is strange..

BTW, isn't this something that can be added to restrack?


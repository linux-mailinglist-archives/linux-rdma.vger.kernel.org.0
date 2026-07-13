Return-Path: <linux-rdma+bounces-23124-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9SJGKnTZVGpJfwAAu9opvQ
	(envelope-from <linux-rdma+bounces-23124-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 14:26:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6C74AED0
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 14:26:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=W2tAy5hL;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23124-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23124-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1775301436B
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jul 2026 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B553126AD;
	Mon, 13 Jul 2026 12:26:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738662D2381
	for <linux-rdma@vger.kernel.org>; Mon, 13 Jul 2026 12:26:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945584; cv=none; b=bYuHbwkWKUe0BvaG/eTahK3+2mg876DCvV7GSb9gxLarm0d8w4JG5mcixKsMB4sUuLFu/BAYMdfWs+2y4ATLfyPIzjz7qMuGAbNTksM7yv3iPJN8chaR5HgYp0/NBZhh8D5SSJJ5ctHJkIxid3xlOB81LnbYa6ENvHiPkd30MhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945584; c=relaxed/simple;
	bh=0k4Gkc2lSaNlg3yelePb+YUuOKPa2uEegCxdpabFhF0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ByQTG7dbWbgCEpG91Hq3PCF+xFAcQS2vsHxRAjFJQl92E8GRpn88ntRy+ZiEt02fwhoiV7SEF/n/iMvLrPH71h4Wmt6l6OHvqzl5X3KGGZGUo6A0+7J9GtAksj254mFLpVwImjXUAinRTluZ81Nvz3VQc/Wmi33GoSfbGttcacc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W2tAy5hL; arc=none smtp.client-ip=95.215.58.176
Message-ID: <f16a6ca2-c528-471d-83f7-8327a3d9bfbc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783945579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=21Y5q/ufuGUVxfworezwmSuvfxf6tIT8XyWioTVY+/E=;
	b=W2tAy5hLOR7PJmBMxdpQ11rwhZcbENOjxGhuDmixuEmr5SApAqrcST66rdJTM7ukRqUKCa
	h88LDWojufEhQ8HpN2yo5Q6pF1pmx44scF+xt2QrHkuvmBLgytudC82nURw515EwXPmhLK
	BliUeHnCwNT3Zi+99/wAr9VO8/8Vb5U=
Date: Mon, 13 Jul 2026 20:26:09 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, dsahern@kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [PATCH iproute2-next v5 1/2] rdma: update uapi headers
To: Leon Romanovsky <leonro@nvidia.com>
References: <20260710011759.378893-1-cui.tao@linux.dev>
 <20260710011759.378893-2-cui.tao@linux.dev> <20260712090325.GF33197@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260712090325.GF33197@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:dsahern@kernel.org,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:cuitao@kylinos.cn,m:leonro@nvidia.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-23124-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32D6C74AED0



在 2026/7/12 17:03, Leon Romanovsky 写道:
> On Fri, Jul 10, 2026 at 09:17:58AM +0800, Tao Cui wrote:
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> Update rdma_netlink.h file upto kernel commit 5911f6d6e7ce
>> ("RDMA/nldev: Add resource summary max values for usage display")
> 
> This SHA-1 is incorrect.
> 5911f6d6e7cc ("RDMA/nldev: Add resource summary max values for usage display")
> 
Mhm... sorry for that
> Thanks



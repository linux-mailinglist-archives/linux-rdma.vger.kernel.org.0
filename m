Return-Path: <linux-rdma+bounces-20852-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M6PCw/aCWr/sgQAu9opvQ
	(envelope-from <linux-rdma+bounces-20852-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 17:09:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B98DA561E5E
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 17:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E8B730041F7
	for <lists+linux-rdma@lfdr.de>; Sun, 17 May 2026 15:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B41B364933;
	Sun, 17 May 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BLDrEVGr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2F329C57;
	Sun, 17 May 2026 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779030537; cv=none; b=BPWY7Vzzs3O7Nr2yioEqw+lYRvgzIySvcXN5avB+2miM8EKwZT5y2mgJFMhT4QVixlGzqgs0awyWUqMZgMC7oVcRbWl1hWXPkPcUmhC5YKtyCDI3vGTqG98kMB9kzFiOkewwePwLrSVk+WrkiT3Arh8nzjXB9za+3a3f3Sc00hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779030537; c=relaxed/simple;
	bh=WbC5V1eLmSjbNKzONoDR6pDca6tg+TweoUUxx61qfuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCqnJWLNlJRPPwEROriyeCfaEdY/CWkiFxzzWm3rR1nYAXqge88BzhINzN7g7g+2bkRpT6TqAFoDCXaonw80U2Hi4Y1zQYIJ3rHtHCowwWioWZ5G5HwGrl0cqmQQOIZkrUg01RS0rL3akAyBRFycf2Ruvrvi3cJ4cVNWfmISWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BLDrEVGr; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779030526; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=6qqHubNw6Ffthb2a69vjor3nIUJMVYWSf99a0QRVW3o=;
	b=BLDrEVGrEvYV8Qk83z2VvTgT/CKepuKPxRtC79hELCLjcZVuXGZlXFqqNB8h/fy3Rt0CfC77BbPSDOV+A7dTmPTke+Z+PHjm7aV9Y5kt2PV/AKqPQhHcBsx+I+9i+Q2SHMPiL2fDPeaufI6rEDAOLNBqs1eyuqncXnxILf3HXvY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X31y.BW_1779030524;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X31y.BW_1779030524 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 17 May 2026 23:08:45 +0800
Date: Sun, 17 May 2026 23:08:44 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Leon Romanovsky <leon@kernel.org>, Xiang Mei <xmei5@asu.edu>,
	alibuda@linux.alibaba.com
Cc: netdev@vger.kernel.org, wenjia@linux.ibm.com, sidraya@linux.ibm.com,
	tonylu@linux.alibaba.com, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, bestswngs@gmail.com
Subject: Re: [PATCH net] net/smc: avoid NULL deref of conn->lnk in
 smc_msg_event tracepoint
Message-ID: <agnZ_G9_9jZFS2An@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260510222640.1230720-1-xmei5@asu.edu>
 <20260517084513.GA33515@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517084513.GA33515@unreal>
X-Rspamd-Queue-Id: B98DA561E5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,linux.alibaba.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-20852-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dust.li@linux.alibaba.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_REPLYTO(0.00)[dust.li@linux.alibaba.com];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 2026-05-17 11:45:13, Leon Romanovsky wrote:
>On Sun, May 10, 2026 at 03:26:40PM -0700, Xiang Mei wrote:
>> The smc_msg_event tracepoint class, shared by smc_tx_sendmsg and
>> smc_rx_recvmsg, unconditionally dereferences smc->conn.lnk:
>> 
>> 	__string(name, smc->conn.lnk->ibname)
>
>My comment is not directly related to this patch, but it was triggered
>while reviewing it. The ibname should not be cached, as users can rename
>it through rdmatool or udev.
>
>For example, this function is racy:
>   552 static int smc_nl_handle_smcr_dev(struct smc_ib_device *smcibdev,
>   553                                   struct sk_buff *skb,
>   554                                   struct netlink_callback *cb)
>   555 {
>   ...
>   582         snprintf(smc_ibname, sizeof(smc_ibname), "%s", smcibdev->ibdev->name);
>
>Thanks

Hi, Leon

OK, I'll submit a patch removing all the ibvdev->name in SMC.

Best regards,
Dust



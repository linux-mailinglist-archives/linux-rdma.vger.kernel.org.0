Return-Path: <linux-rdma+bounces-16300-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI7kMCqifmmybgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16300-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 01:45:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6708BC4870
	for <lists+linux-rdma@lfdr.de>; Sun, 01 Feb 2026 01:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D2D302171E
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Feb 2026 00:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFCA1D5CD9;
	Sun,  1 Feb 2026 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7bY3VXT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964BD3EBF1F;
	Sun,  1 Feb 2026 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769906719; cv=none; b=OlNwRV7bBYQPxhvxF+DVgdiw3CmZkTq2VQwCZgUBMTymfGI7cXXTT4cAhj9CN8cmytc5vpIQPwnhhHFnMEoMWo2M/YFBwWFmS8s7QENJcZ2s5s35fpj3EAJlgyP0MKxGqff26FjnYMxjMFUxK5hdnC9mh17nqhWc/4+Lo7PB9ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769906719; c=relaxed/simple;
	bh=3H50njZHf/MxF1LMF+V5Pv639i4KiMLWrfP4zBIYZyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFSlELtCOYrfIVXq1ybsR55Zi0wfEEaM8bBuKqp/yfx04GDMqKCoTpEmyvp4D3IRcYjOWQrmX9vURq0a4X7my5A3cMHjVX3In5SGh/VkOF1a6QjO9q+lHfvFnYtzMKbuL/9PyL1xmOtcIsmX693ppHyRdyRX7kzW0ES+Y3sS4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7bY3VXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165EBC4CEF1;
	Sun,  1 Feb 2026 00:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769906719;
	bh=3H50njZHf/MxF1LMF+V5Pv639i4KiMLWrfP4zBIYZyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S7bY3VXTi93jajlzzf9u55uwY1CbLXh0X1C+sbA+21hInHUw0Fpej/aYRhSU3/jXh
	 nBooIc/RlWsgFA/cGDkdsLhGmVYdaNWGpjHaWxhjtx4sMbsZcqB5HAQtYYHzIOJdhm
	 lrkfaUHOyP5Vf6mqT/2D3UFb/0eGVCbrSV9yENRYzeN5a5FEJpzGjms7dHoravUEi/
	 B05bkLXi+uGuGGJ5x1xp8hbG3dZFgWdNAsgNoCWEHTs7/m/EsK03somqEOGxIrna83
	 xZHPgiuGZS5Wd8T2nPL9S3XufRfuaV1SRvpVzRDh0v0lK25et8Bkl0zgfD/id0oj3/
	 TSKJyytk0CGZQ==
Date: Sat, 31 Jan 2026 16:45:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: tariqt@nvidia.com, linux-rdma@vger.kernel.org, shaojijie@huawei.com,
 shenjian15@huawei.com, salil.mehta@huawei.com, mbloch@nvidia.com,
 saeedm@nvidia.com, leon@kernel.org, eperezma@redhat.com,
 brett.creeley@amd.com, jasowang@redhat.com, virtualization@lists.linux.dev,
 mst@redhat.com, xuanzhuo@linux.alibaba.com, pabeni@redhat.com,
 edumazet@google.com, parav@nvidia.com, linux-doc@vger.kernel.org,
 corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com,
 jhs@mojatatu.com, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v1 net-next 0/3] ECN offload handling for AccECN series
Message-ID: <20260131164516.4a423230@kernel.org>
In-Reply-To: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,huawei.com,kernel.org,redhat.com,amd.com,lists.linux.dev,linux.alibaba.com,google.com,lwn.net,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-16300-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[47];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6708BC4870
X-Rspamd-Action: no action

On Sat, 31 Jan 2026 23:55:07 +0100 chia-yu.chang@nokia-bell-labs.com
wrote:
> ---
> v2:
> - Replace VIRTIO_NET_HDR_GSO_ECN with VIRTIO_NET_HDR_GSO_ECN_FLAGS

For the future:

Quoting documentation:

  Limit patches outstanding on mailing list
  -----------------------------------------
  
  Avoid having more than 15 patches, across all series, outstanding for
  review on the mailing list for a single tree. In other words, a maximum of
  15 patches under review on net, and a maximum of 15 patches under review on
  net-next.
  
  This limit is intended to focus developer effort on testing patches before
  upstream review. Aiding the quality of upstream submissions, and easing the
  load on reviewers.
    
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#limit-patches-outstanding-on-mailing-list


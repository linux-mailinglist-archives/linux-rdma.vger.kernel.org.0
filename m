Return-Path: <linux-rdma+bounces-18545-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I66CF/MwWm4WwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18545-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 00:27:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1662FEF26
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2026 00:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C1C530F363C
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 23:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA52385514;
	Mon, 23 Mar 2026 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdlTOt1M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2993845CF;
	Mon, 23 Mar 2026 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774308056; cv=none; b=o3Bb8u0b/X3yevYYWURi/i/RBeSql4T9WUwCPAQvaSXRKgB7Yw96ovQmyQH8UeQKRBQcAfi+p3uexUPR71zIZp9Sv1JigyKdUIpdC1ZJnW9BwykQQA2Q0B/MUh5vcp+Ei9qK0bomnzhoYJNtVpGzL5xQL6XxRMYM+54riruD1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774308056; c=relaxed/simple;
	bh=CXejRXkyFv8rzwbuR+qRhnfSeAcHAubW4BagLISel5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGkl6vLDavXf8oBX12g63rvz7MHG3YV2IzvggddLP092It8GIr52NqTcFlZAEQALqz7MFjPx489ybQshs2eN87N+u4ffmdhgb39IpU/U25FUEmBdXWS6C9EPZA5BF2rCIZvIZrpDwMQvNC6U62gpCJ3vp9qpawc5nqAnXoNDvf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdlTOt1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CADCC4CEF7;
	Mon, 23 Mar 2026 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774308056;
	bh=CXejRXkyFv8rzwbuR+qRhnfSeAcHAubW4BagLISel5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZdlTOt1MVA50vXHQJe1+nFkk5CqbYNEGEHbm1Jh/Zbvbs8K08YUviCmu7EibRkZV6
	 bb94ryBxk95AElS9QWgt1wWP4P56O+KGnzsw82Xa+o01uMWuZO5JoppSrVCl/Q5HL0
	 gt/Ey6dGjRO74d3MSJTkpnGBtzNnC/+5id2o7yo5y4zVDEAb20PmUtL3Z49BWLoggk
	 NgHoF07Tg5iV8d0qblBTT7euugeW2kFY7bWgWqqb/uo/TqF2b9N37m0QwIfpnqi0ac
	 N8psFvp2TG+lYLONfU0ghuKdwV/PRZc4greILDVF7Hq42eLVp7jZf/ZjtnXodPzF4L
	 o08Gjtn9Br5Ng==
Date: Mon, 23 Mar 2026 16:20:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, andrew+netdev@lunn.ch,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 alexanderduyck@fb.com, kernel-team@meta.com, johannes@sipsolutions.net,
 sd@queasysnail.net, jianbol@nvidia.com, dtatulea@nvidia.com,
 mohsin.bashr@gmail.com, jacob.e.keller@intel.com, willemb@google.com,
 skhawaja@google.com, bestswngs@gmail.com, aleksandr.loktionov@intel.com,
 kees@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kselftest@vger.kernel.org,
 leon@kernel.org
Subject: Re: [PATCH net-next v3 01/13] net: add address list snapshot and
 reconciliation infrastructure
Message-ID: <20260323162053.62a148c2@kernel.org>
In-Reply-To: <20260320012501.2033548-2-sdf@fomichev.me>
References: <20260320012501.2033548-1-sdf@fomichev.me>
	<20260320012501.2033548-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18545-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,gmail.com,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C1662FEF26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 18:24:49 -0700 Stanislav Fomichev wrote:
> +EXPORT_SYMBOL(__hw_addr_list_snapshot);
> +EXPORT_SYMBOL(__hw_addr_list_reconcile);

Why?  For the kunit tests?


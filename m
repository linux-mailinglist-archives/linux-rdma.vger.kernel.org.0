Return-Path: <linux-rdma+bounces-17792-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCAsL4XjrmmsJwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17792-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:13:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF623B70D
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 16:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2836830266CE
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 15:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171AF3D34B3;
	Mon,  9 Mar 2026 15:12:50 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F703A961A;
	Mon,  9 Mar 2026 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773069169; cv=none; b=SwCCFpoJv9VEGCvrzYBP99N5lt/wX7cnXME5yKVybatvg4dal3nyJZejzSLyEITx+mSBzNZm0epSEclhHeKp8+3D9EXTPoJyPPax3J8AKTwoMRt6QmZRUq9o1iwOJDN3SHaWD1zNbDvX+MpU+Ri5CArphGeQXEY0X0Grsjoej/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773069169; c=relaxed/simple;
	bh=swUfh0NQhhVfY93QVLa+1FDKUQiFHhqSTKP70PRQwJU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f1zwojIdnY4zCSB+/y5uWYoTB1O6a6kTVrznedHPg/2NNjfzJNKl7pK03kzJvu2310GpwtuYwRxejL2HojJhaZUV07YpRrEv3b3zoAyCZSZTokoioPp6VpxRBu2xTV+AbPRAG1IA/Mw0rio2G4QsfDkyrgjKNH2jRSpLqKzZwKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fV0qt3m4yzHnH6v;
	Mon,  9 Mar 2026 23:12:42 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 73EBA40585;
	Mon,  9 Mar 2026 23:12:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Mar
 2026 15:12:45 +0000
Date: Mon, 9 Mar 2026 15:12:44 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, Dave Jiang
	<dave.jiang@intel.com>, <linux-security-module@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Chiara Meiohas
	<cmeiohas@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>
Subject: Re: [PATCH 3/3] fwctl/mlx5: Invoke fw_validate_cmd LSM hook for
 fwctl commands
Message-ID: <20260309151244.000022c1@huawei.com>
In-Reply-To: <20260309-fw-lsm-hook-v1-3-4a6422e63725@nvidia.com>
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
	<20260309-fw-lsm-hook-v1-3-4a6422e63725@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Queue-Id: 92FF623B70D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17792-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.516];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,huawei.com:mid,huawei.com:email]
X-Rspamd-Action: no action

On Mon,  9 Mar 2026 13:15:20 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> From: Chiara Meiohas <cmeiohas@nvidia.com>
> 
> fwctl is subsystem which exposes a firmware interface directly to
> userspace: it allows userspace to send device specific command
> buffers to firmware.
> 
> Call security_fw_validate_cmd() before dispatching the user-provided
> firmware command.
> 
> This allows security modules to implement custom policies and
> enforce per-command security policy on user-triggered firmware
> commands. For example, a BPF LSM program could filter firmware
> commands based on their opcode.
> 
> Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



Return-Path: <linux-rdma+bounces-17624-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM5cLiRHq2lcbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-17624-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 22:29:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BBC227F05
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 22:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F929305C6DC
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 21:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA01333A708;
	Fri,  6 Mar 2026 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xSXPhP4r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232B2BEC3F
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772832545; cv=none; b=MUVGP7VMNNpkNbdYt/ULh413L9CsmXDOOcBLXhWahNrdf6HeSbAafqU76Iyt75Skbz3+EV0J2axCTeITCLQzy6Yb8RzAeFl7RAlGm7FoDm7/rTZzc5Sw4pX2kgJGIShPVs3OSM7oD45sp4yz5+IjutsgiSxYp+NvCVTNSyL0HxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772832545; c=relaxed/simple;
	bh=+NF3mFz52hezxKpAyhXhRTGDdqKBhLHa2w2NvjiuPw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f73DTUy/5Rhm2FOhxB41hmBYXM5kWfKrzxreWz+NwEiZtcRCXdUC5X+D1/FvKUeIHixMofQOPNhi33dfPfV0IJGCoMt+UP/UEKTOdLe7txS5BKdhjeHyXf+PnX6sgRr4ctdgZygumnKE3IKWQaKGYJgu/3aGWtVZBMKr6FAgC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xSXPhP4r; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6cdc68c2-8fde-4882-9369-cb7c64a523e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772832541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4YJPbmxJzJ+emDMSdaGGgr3h8r0R6f4f/zaEYN+u/kg=;
	b=xSXPhP4rgLV6FqEFPh33x048yA9gKwJuR8BiGaGYctqG7FBgvi2RU5QofuYNZ8Iu+vBDiR
	fV1yt6QWwqD/ijPnSkBlsFm/SKLYjzVZ//e6LjzvDVcdNvhv8h1BBmtX+ENRbCKvB+sLkM
	ZhGHpr2bdonoSWCJPJFRIJ+twzGP5Yk=
Date: Fri, 6 Mar 2026 13:28:57 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Add the support that rxe can work in net
 namespace
To: kernel test robot <lkp@intel.com>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, dsahern@kernel.org, linux-rdma@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
References: <20260304041607.11685-1-yanjun.zhu@linux.dev>
 <202603061015.zwXUa3OS-lkp@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <202603061015.zwXUa3OS-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 14BBC227F05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17624-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.913];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url,git-scm.com:url,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

On 3/5/26 6:58 PM, kernel test robot wrote:
> Hi Zhu,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on rdma/for-next]
> [also build test WARNING on linus/master v7.0-rc2]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Zhu-Yanjun/RDMA-rxe-Add-the-support-that-rxe-can-work-in-net-namespace/20260304-121951
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> patch link:    https://lore.kernel.org/r/20260304041607.11685-1-yanjun.zhu%40linux.dev
> patch subject: [PATCHv2 1/1] RDMA/rxe: Add the support that rxe can work in net namespace
> config: x86_64-randconfig-014-20260305 (https://download.01.org/0day-ci/archive/20260306/202603061015.zwXUa3OS-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603061015.zwXUa3OS-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603061015.zwXUa3OS-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):

With W=1, I run the latest commits, this problem does not occur.

Zhu Yanjun

> 
>>> WARNING: modpost: drivers/infiniband/sw/rxe/rdma_rxe: section mismatch in reference: rxe_namespace_exit+0x7 (section: .exit.text) -> rxe_net_ops (section: .init.data)
> 



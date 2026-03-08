Return-Path: <linux-rdma+bounces-17702-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJLsCaYnrWnlywEAu9opvQ
	(envelope-from <linux-rdma+bounces-17702-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 08:39:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 814AB22EF39
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 08:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BA9230180BE
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 07:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48F8336EEE;
	Sun,  8 Mar 2026 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ONgoRx9t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8C336ECE
	for <linux-rdma@vger.kernel.org>; Sun,  8 Mar 2026 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772955554; cv=none; b=Hqp8tdLift7Su7z34U5CAd8ywAa/bRk2/qItnJYDHEMVpXbOfsyrCA6xFJzJ/6ugvy+Un1SUmOgfxdK8PuHjOwlqStr0UbvJNiJ9motRVCn+YLqV4eP1EywZbEQ+Cek4OXlr6wxskzQq+6xym4mtCw+zWfro0117RTAzsjSdQ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772955554; c=relaxed/simple;
	bh=brzk/7kHtLEwzasG2nuLUjY737UAzMYaN01SbYXMOnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XKszndwshGaMikljsRW9X+cexh7ndU6zoiUI3pgXneEXVeaBrcOH0xZ9zHm7gMRje2LWb6u/I11+SDOXDursO0ZaL8gm3BBbttWU2qxNEn2gPMIQ4ptb5VSh4aDGkMoDDs96X2ZUS6V2Zr9RNhv0f2AYsS3quziH53VSNdo519o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ONgoRx9t; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b29736c-f1ee-4d03-946e-378b8fd31435@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772955540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFsNHEzjn6jDUjiqgIyzr/XizL8xAfoPUxGroDwFjz0=;
	b=ONgoRx9tipBkJO4i+KkW2SJ1xNejhcRkq1IREECaKJl0NRdA+u8QipRbDhsJh328ClVy8u
	H/rklPFtdOgDQBUtCDv38Tpz73sTAED/5YwDC1cjvOAbgkG3topF2dDp5ehVEkqyf50I7j
	RbhiDVCALQCptcWbfnR61djmfhq/yso=
Date: Sat, 7 Mar 2026 23:38:49 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] RDMA/rxe: Support RDMA link creation and destruction
 per net namespace
To: kernel test robot <lkp@intel.com>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, dsahern@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260307075611.3410-4-yanjun.zhu@linux.dev>
 <202603081310.Lo0y72dG-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <202603081310.Lo0y72dG-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 814AB22EF39
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17702-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.914];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action


在 2026/3/7 22:09, kernel test robot 写道:
> Hi Zhu,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on shuah-kselftest/next]
> [also build test WARNING on shuah-kselftest/fixes linus/master v7.0-rc2 next-20260306]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Zhu-Yanjun/RDMA-nldev-Add-dellink-function-pointer/20260307-155949
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
> patch link:    https://lore.kernel.org/r/20260307075611.3410-4-yanjun.zhu%40linux.dev
> patch subject: [PATCH 3/4] RDMA/rxe: Support RDMA link creation and destruction per net namespace
> config: loongarch-randconfig-001-20260308 (https://download.01.org/0day-ci/archive/20260308/202603081310.Lo0y72dG-lkp@intel.com/config)
> compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603081310.Lo0y72dG-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603081310.Lo0y72dG-lkp@intel.com/
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
>>> WARNING: modpost: drivers/infiniband/sw/rxe/rdma_rxe: section mismatch in reference: rxe_namespace_exit+0x0 (section: .text) -> rxe_net_ops (section: .init.data)

Thanks. This warning is fixed. I will send the latest commit out very soon.

Zhu Yanjun

> WARNING: modpost: drivers/infiniband/sw/rxe/rdma_rxe: section mismatch in reference: rxe_namespace_exit+0x4 (section: .text) -> rxe_net_ops (section: .init.data)
> ERROR: modpost: "sysfb_primary_display" [drivers/video/fbdev/core/fb.ko] undefined!
>
-- 
Best Regards,
Yanjun.Zhu



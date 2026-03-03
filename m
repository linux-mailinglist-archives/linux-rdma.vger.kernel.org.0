Return-Path: <linux-rdma+bounces-17423-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMRCFKIvp2kLfwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17423-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 19:59:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD971F590D
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 19:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 810A83029243
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A20A372683;
	Tue,  3 Mar 2026 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHHicrHM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2EA372660
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564383; cv=none; b=M54SF2m7VNgxtINb6qzppyMbN4sGBmg57B0SJ99cINQ0DkzUc7a/QqZqowef8bosupeXKxD6NR+WCvY5cThnJRzgguBWEtV7lcSR++32F8BinAsOTkYoj4gYFMHx9swDZRofs6B9EuYkfOD8QGTulUV6in3/XPzRc02FGeYeIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564383; c=relaxed/simple;
	bh=zTzRfoLch+M22pXfVnlxxSZowPvrnHWk2XFKkFTxV10=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ibAosdIxzSOGGKfNhgRestCvfl9b+WrknHPlQQXvLt0knunpeZHhIAXxpC+UMejPu914fb3u13WBFdPg0t0q27ppXpmzJwiC4+Y8BblhUL/Zs8mFRt7dl+wIBVN2SwwFRnwhLs9o3KrBrxQQRV2tHcLz40J+zMLGnhXefJ2PT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHHicrHM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772564382; x=1804100382;
  h=date:from:to:cc:subject:message-id;
  bh=zTzRfoLch+M22pXfVnlxxSZowPvrnHWk2XFKkFTxV10=;
  b=cHHicrHM8QFSSwce5biVmCZAJ0D3h0BOVwDV8TznjdQoyE7006Y8IaGQ
   /RtcAo8nAk1TxdcknxhygCOxBQ0ZRbgtlyFdzEy5NTKEq48lrx0TqFgPR
   nhUXWSFKV8g0BXE+5/XGkSI7HAsucF8QEtSuwBxTO09EoFJVjEZRI0AHq
   1A5mp9d2mRsrol0nHq+GC2E+7zs6cjPxnubPM13o+oejR1kW4HuwR26NL
   anLa8eBrJYlfb9ObXBfZKisWwzPn38pZpBlOhfkflL2g03lhNEuz0NdwQ
   r3LDwdVOIGjrkPgjV7R0U+AtCqE3jeJ0L+09QxJGzM/4lBmGc3xTNC/Dj
   w==;
X-CSE-ConnectionGUID: 3TvbjBDQR4u5YIeQruRTcA==
X-CSE-MsgGUID: KMcWFNQrQJShrlBerQDZIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="84958172"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="84958172"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 10:59:41 -0800
X-CSE-ConnectionGUID: 2T3waRhWTMuDyiJ8sF+gEg==
X-CSE-MsgGUID: d1X8qoeGSrKnFQxnbEIt/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="218045213"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 Mar 2026 10:59:40 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxUy1-000000002hs-2cvp;
	Tue, 03 Mar 2026 18:59:37 +0000
Date: Wed, 04 Mar 2026 02:59:27 +0800
From: kernel test robot <lkp@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: [rdma:wip/leon-for-rc] BUILD SUCCESS
 cbbdb148c62814b2d60b3f49e10696093c57a987
Message-ID: <202603040219.h7Z9IjIq-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 1CD971F590D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17423-lists,linux-rdma=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lists];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:mid]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-rc
branch HEAD: cbbdb148c62814b2d60b3f49e10696093c57a987  RDMA/ionic: Preserve and set Ethernet source MAC after ib_ud_header_init()

elapsed time: 1381m

configs tested: 53
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.2.0
alpha        allyesconfig    gcc-15.2.0
arc          allmodconfig    gcc-15.2.0
arc           allnoconfig    gcc-15.2.0
arc          allyesconfig    gcc-15.2.0
arm           allnoconfig    clang-23
arm          allyesconfig    gcc-15.2.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.2.0
csky          allnoconfig    gcc-15.2.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-23
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-23
m68k         allmodconfig    gcc-15.2.0
m68k          allnoconfig    gcc-15.2.0
m68k         allyesconfig    gcc-15.2.0
microblaze    allnoconfig    gcc-15.2.0
microblaze   allyesconfig    gcc-15.2.0
mips         allmodconfig    gcc-15.2.0
mips          allnoconfig    gcc-15.2.0
mips         allyesconfig    gcc-15.2.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.2.0
openrisc      allnoconfig    gcc-15.2.0
parisc       allmodconfig    gcc-15.2.0
parisc        allnoconfig    gcc-15.2.0
parisc       allyesconfig    gcc-15.2.0
powerpc      allmodconfig    gcc-15.2.0
powerpc       allnoconfig    gcc-15.2.0
riscv        allmodconfig    clang-23
riscv         allnoconfig    gcc-15.2.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-23
s390         allyesconfig    gcc-15.2.0
sh           allmodconfig    gcc-15.2.0
sh            allnoconfig    gcc-15.2.0
sh           allyesconfig    gcc-15.2.0
sparc         allnoconfig    gcc-15.2.0
sparc64      allmodconfig    clang-23
um           allmodconfig    clang-19
um            allnoconfig    clang-23
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


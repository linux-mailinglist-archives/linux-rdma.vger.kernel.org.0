Return-Path: <linux-rdma+bounces-20234-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAKmFOvI/WkpigAAu9opvQ
	(envelope-from <linux-rdma+bounces-20234-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 13:28:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8794F5C42
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 13:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEB6130382AD
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511C639A063;
	Fri,  8 May 2026 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jQeoPxec"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C113539900C;
	Fri,  8 May 2026 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239490; cv=none; b=S52zQ5LGaTQ9BB4b4b4eKi7AjpkVB+py55NZN+euJatis+83xs3de3LZChaHFot2AKGJ5GvvBbBUsRHSuYgkXYEtzoXY+5BHS6bFDaIkrD9V9MGHPAFZ3Y7zqvXoI5TMRkKshb0J11M2fABlG3/w5rVpwX7M7t+YsL6YMLema10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239490; c=relaxed/simple;
	bh=LmcXKGmix6NqzwFcXeQHOfXRs3XmSPEct8iSLJAkMJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsQd+xsEUVBIz6YHX226lcwLi1ZyDEH6C+OZXGyAZcHeSmJESgmoMMu/9RyqZDIfSGKim+L0izaJVghn7rVhB3wchb/JxNcalVZWXuc0N++4L7cvkV4Dp5Wu0X0yHyqT/JZ9Se255czizd9KXDLEKXX98YUG1Y68QdiI1DwBgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jQeoPxec; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778239489; x=1809775489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LmcXKGmix6NqzwFcXeQHOfXRs3XmSPEct8iSLJAkMJQ=;
  b=jQeoPxecYsf2bqW/Uh/OrHNjZjY7bZGjv4gXLzQSKiZERNstM2fdkmw+
   WNNTiVg+8xApSJwmos2TiylqX+txF++sEzzPLkqKjEe6NLdmlhK1kFBoZ
   tDraMxp9Hpl+6sF0hEm6gFm+7jXO1WRQQFnHo/908yFMuSwvFq/qzMOfS
   86SisxrAkDRYaT1ZBqgTxKyLZOno+pKcejvbZexc8XB6PcTY0n+PbjzPu
   ZwPljS8uN2Qs8SHT8kuA4r/EumzRElBZPvKvdKl3peZ2RyxziQy92nCJz
   TyDV34TdUH/CWeaKw1wnAv3jS8uEHVvIogR/5MMBsd2j2rXUsfH/rkiKc
   Q==;
X-CSE-ConnectionGUID: ksSTN0FgSI6JjCkCrbcAwg==
X-CSE-MsgGUID: /H84a1XUSryt491aOlCY7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="83076772"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="83076772"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 04:24:48 -0700
X-CSE-ConnectionGUID: 2sIEqEivS8WgVEGEnW1aAg==
X-CSE-MsgGUID: C0v1TcwcSAGEJrX9tV4Ykg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="260472007"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 04:24:46 -0700
Date: Fri, 8 May 2026 19:24:43 +0800
From: "Lai, Yi" <yi1.lai@intel.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi1.lai@linux.intel.com
Subject: Re: [PATCH] selftests/rdma: explicitly skip tests when required
 modules are missing
Message-ID: <af3H+/9cdaUTEgi1@ly-workstation>
References: <20260507125106.3114167-1-yi1.lai@intel.com>
 <63aa67fb-5c8b-42be-a38f-cd5a92ac528a@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63aa67fb-5c8b-42be-a38f-cd5a92ac528a@linux.dev>
X-Rspamd-Queue-Id: EE8794F5C42
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-20234-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yi1.lai@intel.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 09:21:09PM -0700, Zhu Yanjun wrote:
> 
> 在 2026/5/7 5:51, Yi Lai 写道:
> > Currently, the rdma rxe selftests fail with an exit code of 1 when
> > required kernel modules are not present. This causes spurious failures
> > in environments where these modules might not be compiled or available.
> > 
> > Include the standard kselftest 'ktap_helpers.sh' and replace the
> > hardcoded error exits with '$KSFT_SKIP'. This ensures the tests are
> > properly marked as skipped rather than failed.
> tools/testing/selftests/rdma/rxe_rping_between_netns.sh:30:modprobe rdma_rxe
> || { echo "Failed to load rdma_rxe"; exit 1; }
> tools/testing/selftests/rdma/rxe_socket_with_netns.sh:29: modprobe "$m" || {
> echo "Error: Failed to load $m"; exit 1; }
> 
> In the above script files, if modprobe fails, exit 1;
> 
> I am wondering if we need to replace error code 1 with $KSFT_SKIP.
>

Thanks for the review.

At this point, the module's existence is already verified using modinfo.
In my opinion, a failure at modprobe here implies an active operational
error, so returning 1 to highlight the malfunction seems reasonable.

Regards,
Yi Lai 
> Except the above, I am fine with this commit.
> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Zhu Yanjun
> 
> > 
> > Signed-off-by: Yi Lai <yi1.lai@intel.com>
> > ---
> >   tools/testing/selftests/rdma/rxe_ipv6.sh                   | 6 ++++--
> >   tools/testing/selftests/rdma/rxe_rping_between_netns.sh    | 7 +++++++
> >   tools/testing/selftests/rdma/rxe_socket_with_netns.sh      | 6 ++++++
> >   tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh | 6 ++++--
> >   4 files changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/rdma/rxe_ipv6.sh b/tools/testing/selftests/rdma/rxe_ipv6.sh
> > index b7059bfd6d7c..32dad687a044 100755
> > --- a/tools/testing/selftests/rdma/rxe_ipv6.sh
> > +++ b/tools/testing/selftests/rdma/rxe_ipv6.sh
> > @@ -8,6 +8,8 @@ RXE_NAME="rxe6"
> >   PORT=4791
> >   IP6_ADDR="2001:db8::1/64"
> > +source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
> > +
> >   exec > /dev/null
> >   # Cleanup function to run on exit (even on failure)
> > @@ -21,8 +23,8 @@ trap cleanup EXIT
> >   # 1. Prerequisites check
> >   for mod in tun veth rdma_rxe; do
> >       if ! modinfo "$mod" >/dev/null 2>&1; then
> > -        echo "Error: Kernel module '$mod' not found."
> > -        exit 1
> > +        echo "SKIP: Kernel module '$mod' not found." >&2
> > +        exit $KSFT_SKIP
> >       fi
> >   done
> > diff --git a/tools/testing/selftests/rdma/rxe_rping_between_netns.sh b/tools/testing/selftests/rdma/rxe_rping_between_netns.sh
> > index e5b876f58c6e..e7554fbb8951 100755
> > --- a/tools/testing/selftests/rdma/rxe_rping_between_netns.sh
> > +++ b/tools/testing/selftests/rdma/rxe_rping_between_netns.sh
> > @@ -8,6 +8,8 @@ IP_A="1.1.1.1"
> >   IP_B="1.1.1.2"
> >   PORT=4791
> > +source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
> > +
> >   exec > /dev/null
> >   # --- Cleanup Routine ---
> > @@ -27,6 +29,11 @@ if [[ $EUID -ne 0 ]]; then
> >      exit 1
> >   fi
> > +if ! modinfo rdma_rxe >/dev/null 2>&1; then
> > +    echo "SKIP: Kernel module 'rdma_rxe' not found." >&2
> > +    exit $KSFT_SKIP
> > +fi
> > +
> >   modprobe rdma_rxe || { echo "Failed to load rdma_rxe"; exit 1; }
> >   # --- Setup Network Topology ---
> > diff --git a/tools/testing/selftests/rdma/rxe_socket_with_netns.sh b/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
> > index 002e5098f751..9478657c02c1 100755
> > --- a/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
> > +++ b/tools/testing/selftests/rdma/rxe_socket_with_netns.sh
> > @@ -4,6 +4,8 @@
> >   PORT=4791
> >   MODS=("tun" "rdma_rxe")
> > +source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
> > +
> >   exec > /dev/null
> >   # --- Helper: Cleanup Routine ---
> > @@ -26,6 +28,10 @@ if [[ $EUID -ne 0 ]]; then
> >   fi
> >   for m in "${MODS[@]}"; do
> > +    if ! modinfo "$m" >/dev/null 2>&1; then
> > +        echo "SKIP: Kernel module '$m' not found." >&2
> > +        exit $KSFT_SKIP
> > +    fi
> >       modprobe "$m" || { echo "Error: Failed to load $m"; exit 1; }
> >   done
> > diff --git a/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh b/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
> > index 021ca451499d..8c18cea7535c 100755
> > --- a/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
> > +++ b/tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
> > @@ -5,6 +5,8 @@ DEV_NAME="tun0"
> >   RXE_NAME="rxe0"
> >   RDMA_PORT=4791
> > +source "$(dirname "$0")/../kselftest/ktap_helpers.sh"
> > +
> >   exec > /dev/null
> >   # --- Cleanup Routine ---
> > @@ -19,8 +21,8 @@ trap cleanup EXIT
> >   # 1. Dependency Check
> >   if ! modinfo rdma_rxe >/dev/null 2>&1; then
> > -    echo "Error: rdma_rxe module not found."
> > -    exit 1
> > +    echo "SKIP: rdma_rxe module not found." >&2
> > +    exit $KSFT_SKIP
> >   fi
> >   modprobe rdma_rxe
> 
> -- 
> Best Regards,
> Yanjun.Zhu
> 


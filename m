Return-Path: <linux-rdma+bounces-20096-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBbKLiZy+2m7bAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20096-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 18:53:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB904DE5ED
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3102230117F7
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF614611D7;
	Wed,  6 May 2026 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UdmvDoKt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912FA274B28;
	Wed,  6 May 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086364; cv=none; b=f6ibGUOavbinFotsZDDJzZfRAtX2ZtDi5YUkltocgz+HJSmJxIUr3v0eKhfa45qlr5JP85symt32xeQoar0E/s/815Exs00ZC9UlCUc6yle2oT4ioPJmXoyTW+/BjUt3Diw/NARwZJvo8Kf5c7mgpmHreFNZfb/2g1tGSiOTP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086364; c=relaxed/simple;
	bh=zLgo2hlPL3BFc2poeW/lY/orC7GUuzmLfWWK1cnK3Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/e1/RZYRA4ABGMm4AtJ0faH2Ymh2kPI9+oRz3TeuV+eAOTshpR/OEwdbhJadYGINK4i+RGyx3Ni0JRC+vVmYTv6QiFYUxyfvIkhXrHdEWUy4syewVI9j8G7M7hGkhA25boYr8ULxJKNktb27VMgRr7cSl2n2+dfcxSfoGJYMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UdmvDoKt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 9531D20B7165; Wed,  6 May 2026 09:52:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9531D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778086360;
	bh=PCz+S4dgNQoTGyML6uFElTl2NXVVtXB+dmI/tbDc9rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdmvDoKtA0Li2wRZEF0U8Ea6XMbMrIBKbO44mzbwqc017t05dcSwx+bEHku+eR+XP
	 +c4Xc9wmHW3DH57K81YhDHQDTSamHwEr6ZsyW9Kw0nUxErCDf0/ZghiwhZunkS9Dv6
	 TTtQjboUhEueYjX/iyXl2Yn7HzOYtvMOmDUceSZw=
Date: Wed, 6 May 2026 09:52:40 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Wei <dw@davidwei.uk>, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	leon@kernel.org, longli@microsoft.com, kotaranov@microsoft.com,
	horms@kernel.org, shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
	shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, stephen@networkplumber.org,
	jacob.e.keller@intel.com, leitao@debian.org, kees@kernel.org,
	john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
	dipayanroy@microsoft.com
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <aftx2E1ZARV55DrR@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
 <20260409183509.0b24dea6@kernel.org>
 <20260412125917.4fa8fc8d@kernel.org>
 <ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260416083146.0bb94d2b@kernel.org>
 <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <685d7bf9-062d-4bd2-8448-f7714bb05302@davidwei.uk>
 <aex119OtL8CEGXkb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260427131745.2eac52ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427131745.2eac52ef@kernel.org>
X-Rspamd-Queue-Id: 6FB904DE5ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20096-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	FREEMAIL_CC(0.00)[davidwei.uk,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]

On Mon, Apr 27, 2026 at 01:17:45PM -0700, Jakub Kicinski wrote:
> On Sat, 25 Apr 2026 01:05:43 -0700 Dipayaan Roy wrote:
> > Hi Jakub,
> > with this new data from David, is it convincing enough for a mana driver
> > specific private flag, which can be set from user space by a udev rule
> > by detecting the underlying platform? If not then I will send the next
> > version with the other rxbuflen approach. 
> 
> I think so, thank you both for the testing.
> Please look out for the net-next opening up and repost the patches.
> (The reopening is delayed, it was supposed to happen already but I
> can't get a clean run out of our CI, sigh)

Hi Jakub,
I have reposted the patches now.

Regards
Dipayaan Roy


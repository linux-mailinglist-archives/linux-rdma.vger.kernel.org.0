Return-Path: <linux-rdma+bounces-9812-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56350A9CFAF
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 19:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7931BA78E8
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADA20DD7E;
	Fri, 25 Apr 2025 17:35:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF61F76A8;
	Fri, 25 Apr 2025 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602508; cv=none; b=Ds4MxxA3tOdh+Fj0Lf3Ka34HwreLfU32gymHJkeUcm7OS+vgyJLB+gKfvXQMM+zoRE/wDPpphux6fP/JOA+JKMkAV2xDObVJK6aFYoHAz94lKzQlChOUuhcgtOrrxoylW6SfBfVMsGY5PvHeIRkUJADKaOxA+97xg7DgV4P9lng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602508; c=relaxed/simple;
	bh=Jod3jvEqvnUFb/rKkYTYamqLS14smKBuX57O2hEOnhA=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=bH+4AJZGCMCKF520KduhZ6rivOgyrsyODIYdBIUBvk7sNGy/3uzxm0rkKphE+0DOe05lIecOlnUS2ImcJ9pBxyehYG/VPioG+doVUgK9pHhk9PZSoqe1vAgGAumdU5ta7sKVjI7fYJllso80LJTJarA1hf+6x0VfhBh7bN0Lzrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:33412)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u8Mx4-005dXj-DV; Fri, 25 Apr 2025 11:35:02 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:52424 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u8Mx3-0022Zw-C7; Fri, 25 Apr 2025 11:35:02 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,  Parav Pandit <parav@nvidia.com>,
  "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
  "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,  Leon Romanovsky
 <leonro@nvidia.com>
References: <87msc6khn7.fsf@email.froward.int.ebiederm.org>
	<CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250423164545.GM1648741@nvidia.com>
	<CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250424141347.GS1648741@nvidia.com>
	<CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250425132930.GB1804142@nvidia.com>
	<20250425140144.GB610516@mail.hallyn.com>
	<20250425142429.GC1804142@nvidia.com>
	<87h62ci7ec.fsf@email.froward.int.ebiederm.org>
	<20250425162102.GA2012301@nvidia.com>
Date: Fri, 25 Apr 2025 12:34:21 -0500
In-Reply-To: <20250425162102.GA2012301@nvidia.com> (Jason Gunthorpe's message
	of "Fri, 25 Apr 2025 13:21:02 -0300")
Message-ID: <875xisf8ma.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1u8Mx3-0022Zw-C7;;;mid=<875xisf8ma.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/bIEDBgRt27auvnDnaqMbLo4oZIvmUpKQ=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  1.7 FUZZY_CREDIT BODY: Attempt to obfuscate words in spam
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Jason Gunthorpe <jgg@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 532 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 14 (2.6%), b_tie_ro: 12 (2.2%), parse: 1.78
	(0.3%), extract_message_metadata: 19 (3.5%), get_uri_detail_list: 2.9
	(0.5%), tests_pri_-2000: 15 (2.9%), tests_pri_-1000: 2.5 (0.5%),
	tests_pri_-950: 1.31 (0.2%), tests_pri_-900: 1.04 (0.2%),
	tests_pri_-90: 71 (13.3%), check_bayes: 69 (13.0%), b_tokenize: 10
	(1.9%), b_tok_get_all: 9 (1.6%), b_comp_prob: 4.0 (0.7%),
	b_tok_touch_all: 41 (7.8%), b_finish: 1.16 (0.2%), tests_pri_0: 392
	(73.7%), check_dkim_signature: 0.76 (0.1%), check_dkim_adsp: 3.0
	(0.6%), poll_dns_idle: 1.18 (0.2%), tests_pri_10: 2.4 (0.4%),
	tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: leonro@nvidia.com, linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, parav@nvidia.com, serge@hallyn.com, jgg@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, Apr 25, 2025 at 10:32:27AM -0500, Eric W. Biederman wrote:
>> > That seems like splitting nits. Can I do current->XXX->user_ns and get
>> > different answers? Sounds like yes?
>> 
>> Totally.
>> 
>> current->cred->user_ns (aka current_user_ns) is the what the process
>> has.
>
> Well, this is the head hurty bit. "cred->user_ns" is not what the
> process "has" if the kernel is checking resource->netns->user_ns for
> the capability checks and ignores cred->user_ns?

resource->net->user_ns CAP_XXXX is what the process needs.

current->cred->user_ns and current->cred->cap_effective
are what the process has.

> How does a userspace process actually know what its current
> capabilties are? Like how does it tell if CAP_NET_XX is actually
> available?

It looks in current->cred.  In current->cred it finds bits
set in cap_effective, and a user_ns.

Ultimately all capable calls make their way down into
cap_capable_helper.  The cap_capable_helper checks to see if the user
namespace that is wanted (aka from the resource) matches the cred's user
namespace.  If the namespaces match then the bits in cap_effective
are checked.

There are a few more checks that make nested user namespaces work.


> What about something like CAP_SYS_RAWIO? I don't think we would ever
> make that a per-userns thing, but as a thought experiment, do we check
> current->XXX->user_ns or still check ibdev->netns->XX->user_ns?
>

Oh.  CAP_SYS_RAWIO is totally is something you can have.  In fact
the first process in a user namespace starts out with CAP_SYS_RAWIO.
That said it is CAP_SYS_RAWIO with respect to the user namespace.

What would be almost certainly be a bug is for any permission check
to be relaxed to ns_capable(resource->user_ns, CAP_SYS_RAWIO).

>> > Is it the kernel's struct ib_device? It has a netns that is captured
>> > at its creation time.
>> 
>> Yes.  Very much so.
>
> Okay.. And looking at this more we actually check that the process
> that opens /dev/../uverbsX has the same net_ns as the ib_device:

At which point I see how different the ib_device model is from
everything else..

ib_dev only sometimes belongs to a network namespace
(ib_devices_shared_netns).  The rest of time they are independent of the
network namespaces.

I don't know what an infiniband character device refers to.  Is it an
attachment of a physical cable to the box like a netdevice?  Is it an
infiniband queue-pair?

Given that the character device names aren't properly attached to a
network namespace it seems reasonable to ensure that you can only
open infiniband devices that are in your network-namespace (when
that is enabled).

The names (device major and minor) not living in a network namespace
mean that there can be problems for CRIU to migrate a infiniband device,
as it's device major and minor number are not guaranteed to be
available.  Perhaps that doesn't matter, as the name you open is on a
filesystem.  *Shrug*

> static int ib_uverbs_open(struct inode *inode, struct file *filp)
> {
> 	if (!rdma_dev_access_netns(ib_dev, current->nsproxy->net_ns)) {
> 		ret = -EPERM;
>

> bool rdma_dev_access_netns(const struct ib_device *dev, const struct net *net)
> {
> 	return (ib_devices_shared_netns ||
> 		net_eq(read_pnet(&dev->coredev.rdma_net), net));
>
> So you can say we 'captured' the net_ns into the FD as there is some
> struct file->....->ib_dev->..->net_ns that does not change
>
> Thus ib_dev->...->user_ns is going to always be the user_ns of the
> netns of the process that opened the FD.

Nope.

There is no check against current->cred->user_ns.  So the check has
nothing to do with the credentials of the process that opened the
character device.

> So.. hopefully final question.. When we are in a system call context
> and want to check CAP_NET_XX should we also require that the current
> process has the same net ns as the ib_dev?

I want to say in general only for opening the ib_device.

I don't know what to say for the case where ib_devices_shared_netns is
true.  In that case the ib_device doesn't have a network namespace at
all, so at best it would appear to be a nonsense check.

I think you need to restrict the relaxation to the case where
ib_devices_shared_netns is false.

The network stack in general uses netlink to talk to network devices
(sockets are another matter), so this whole using character devices
to talk to devices is very weird to me.

Eric


Return-Path: <linux-rdma+bounces-9887-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B5A9F763
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 19:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FE21A84974
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA9C2949FB;
	Mon, 28 Apr 2025 17:35:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E9291143;
	Mon, 28 Apr 2025 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861743; cv=none; b=F0ZXRIjRDmFhw/CZZAzQC5XemSWNZEAgNAaInw7xjN4f86VW1G5MVfHdQjhgNxpBan26ZXemTnmJCfWmtnvyTvBOJ7SqATjsczGI/9umFl3Fhaz5EzTs3BIMUvGWCol9eB1I+3YxpOOMz8yfwkW2uuLcUH56T1IUUYcR83Fkx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861743; c=relaxed/simple;
	bh=s6xrYVbX0RSIwHJOuUEdz5BddCI80t03zN2GQm4RmPU=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=DSqzfjaiEaoErvDSj5jdN/Ur5A315Mgg7GVfnDrlZBs+G+UYKCH9CdtOrp1SRJ/KcivfFlfS4UL18Lt+9YgkNB/3MgQkQvr6KKu+iyL/BSNnV5VMSDAgRvglg7d3tjdMhxZdBWz0MmOWyh+6VIto6obJQPBAvK4E/4jaEl7j5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:39418)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u9Ru2-00HJAO-9e; Mon, 28 Apr 2025 11:04:22 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:39012 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u9Ru0-001QR6-Tu; Mon, 28 Apr 2025 11:04:21 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,  Parav Pandit <parav@nvidia.com>,
  "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
  "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,  Leon Romanovsky
 <leonro@nvidia.com>
References: <20250423164545.GM1648741@nvidia.com>
	<CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250424141347.GS1648741@nvidia.com>
	<CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250425132930.GB1804142@nvidia.com>
	<20250425140144.GB610516@mail.hallyn.com>
	<20250425142429.GC1804142@nvidia.com>
	<87h62ci7ec.fsf@email.froward.int.ebiederm.org>
	<20250425162102.GA2012301@nvidia.com>
	<875xisf8ma.fsf@email.froward.int.ebiederm.org>
	<20250425183529.GB2012301@nvidia.com>
Date: Mon, 28 Apr 2025 12:03:47 -0500
In-Reply-To: <20250425183529.GB2012301@nvidia.com> (Jason Gunthorpe's message
	of "Fri, 25 Apr 2025 15:35:29 -0300")
Message-ID: <87tt68cj64.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1u9Ru0-001QR6-Tu;;;mid=<87tt68cj64.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+lh1UrU3ibx8d0li2I/z8xuQxRqjiHIko=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jason Gunthorpe <jgg@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 737 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 11 (1.5%), b_tie_ro: 10 (1.3%), parse: 1.02
	(0.1%), extract_message_metadata: 14 (1.8%), get_uri_detail_list: 3.0
	(0.4%), tests_pri_-2000: 14 (1.9%), tests_pri_-1000: 2.4 (0.3%),
	tests_pri_-950: 1.19 (0.2%), tests_pri_-900: 0.95 (0.1%),
	tests_pri_-90: 251 (34.1%), check_bayes: 248 (33.7%), b_tokenize: 10
	(1.4%), b_tok_get_all: 10 (1.4%), b_comp_prob: 3.5 (0.5%),
	b_tok_touch_all: 220 (29.8%), b_finish: 0.96 (0.1%), tests_pri_0: 428
	(58.1%), check_dkim_signature: 0.56 (0.1%), check_dkim_adsp: 3.1
	(0.4%), poll_dns_idle: 0.98 (0.1%), tests_pri_10: 2.1 (0.3%),
	tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: leonro@nvidia.com, linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, parav@nvidia.com, serge@hallyn.com, jgg@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, Apr 25, 2025 at 12:34:21PM -0500, Eric W. Biederman wrote:
>> > What about something like CAP_SYS_RAWIO? I don't think we would ever
>> > make that a per-userns thing, but as a thought experiment, do we check
>> > current->XXX->user_ns or still check ibdev->netns->XX->user_ns?
>> >
>> 
>> Oh.  CAP_SYS_RAWIO is totally is something you can have.  In fact
>> the first process in a user namespace starts out with CAP_SYS_RAWIO.
>> That said it is CAP_SYS_RAWIO with respect to the user namespace.
>> 
>> What would be almost certainly be a bug is for any permission check
>> to be relaxed to ns_capable(resource->user_ns, CAP_SYS_RAWIO).
>
> So a process "has" it but the kernel never accepts it?

Exactly.  Most capabilities possessed by root in a user namespace are
never allowed to do anything or at very rarely allowed to do anything.

Semantically the only things root in a user namespace is allowed to
do are those things that the we only disallow because it would confuse
setuid programs, but are otherwise perfectly fine for an unprivileged
process to perform.

>> I don't know what an infiniband character device refers to.  Is it an
>> attachment of a physical cable to the box like a netdevice?  Is it an
>> infiniband queue-pair?
>
> It refers to a single struct ib_device in the kernel. It is kind of a
> like a namespace in that all the commands executed and uobjects
> created on the FD are relative to the struct ib_device.

Unfortunately I am not familiar with the infiniband kernel abstractions.

>> The names (device major and minor) not living in a network namespace
>> mean that there can be problems for CRIU to migrate a infiniband device,
>> as it's device major and minor number are not guaranteed to be
>> available.  Perhaps that doesn't matter, as the name you open is on a
>> filesystem.  *Shrug*
>
> I don't see a path for CRIU and rdma, there is too much hardware
> state.. Presumably if anyone ever did it they'd have to ignore that
> the major/minor changes.

At this point I would be surprised if there was sufficient resources
being put at the problem.  In principle the hardware state is a
simplified version of a TCP/IP connection and some DMA transactions,
so it isn't an unreasonable thing to imagine.

Especially as it is usually the folks who have long running jobs on
clusters (because no single machine is big enough) that are both use
infiniband and are interested in checkpoint-restart.

The CRIU question is always relevant to ask in a namespace context
as that is very much part of the goal of namespaces.  To abstract
out the names so that migration of resources from one machine
can be implemented in the future.

>> > static int ib_uverbs_open(struct inode *inode, struct file *filp)
>> > {
>> > 	if (!rdma_dev_access_netns(ib_dev, current->nsproxy->net_ns)) {
>> > 		ret = -EPERM;
>> >
>> 
>> > bool rdma_dev_access_netns(const struct ib_device *dev, const struct net *net)
>> > {
>> > 	return (ib_devices_shared_netns ||
>> > 		net_eq(read_pnet(&dev->coredev.rdma_net), net));
>> >
>> > So you can say we 'captured' the net_ns into the FD as there is some
>> > struct file->....->ib_dev->..->net_ns that does not change
>> >
>> > Thus ib_dev->...->user_ns is going to always be the user_ns of the
>> > netns of the process that opened the FD.
>> 
>> Nope.
>> 
>> There is no check against current->cred->user_ns.  So the check has
>> nothing to do with the credentials of the process that opened the
>> character device.
>
> I said "user_ns of the netns"?  Credentials of the process is something
> else?

Exactly the credentials of the a process are not:
	current->nsproxy->net_ns->user_ns;  /* Not this */

The credentials of a process are:
	current->cred;  /* This */

With current->cred->user_ns the current processes user namespace.

> It sounds like we just totally ignore current->cred->user_ns from the
> rdma subsystem perspective?

Since you don't allow anything currently to happen in a user namespace
that is completely reasonable.

Once ns_capable checks start being added that changes.

>> > So.. hopefully final question.. When we are in a system call context
>> > and want to check CAP_NET_XX should we also require that the current
>> > process has the same net ns as the ib_dev?
>> 
>> I want to say in general only for opening the ib_device.

The information I don't have to give a better answer is what
an ib_device actually is from a hardware perspective.  That
is why I was asking about queue-pairs above.

>> The network stack in general uses netlink to talk to network devices
>> (sockets are another matter), so this whole using character devices
>> to talk to devices is very weird to me.
>
> It isn't that different. In netlink you get the FD through socket, in
> char dev you get it through open.

It is just enough different that there are no good examples I can point
you at to say what needs to happen here.

For netlink it is totally clear that all of the permission checks need
to happen at open time.  Because the sender of the netlink message
may be on another machine.

For a FD opened through a character device everything is local and
you are still in the context of the requesting process so permission
checks can still happen, and aren't completely silly.

Eric



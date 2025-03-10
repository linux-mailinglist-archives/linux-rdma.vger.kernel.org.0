Return-Path: <linux-rdma+bounces-8536-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E639A5A1D4
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 19:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90013AEF46
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 18:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2506233721;
	Mon, 10 Mar 2025 18:14:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B922FF4E;
	Mon, 10 Mar 2025 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630441; cv=none; b=GqbVBl2M/Gc0QcjezOYYYVbCm3H8nt1ApKNDzEUQ+MIwBkzNOu+u+Yr3fOiYcbrFsbho/I6YpGKveSmMRTHLQa9QRI3OWETkkgkQsQZdcINVAs07yNQoBhLYThs6iVUCPT+VBUSZ+xVobWp+F5LjuL9+rpz7h7DRDtJij4a9Ng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630441; c=relaxed/simple;
	bh=9bh2JNFFHz0JRbysQXTvCMFdfKTtKbs/sMlwHye0JzY=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=j6bOlSgUABjYDmOmVGHhe1mzX5fgxJUqeeKlJ3CWLlxd148BkDB1YBDkgfgMXXndWsf0b2f8EpLimMEPKPD37FNIq+y5VwU0imiUG/IWVDKuN4XGRv9pn63VBfZkoiloQ1Ui/eCsS9CV5ClxN5s8P87C60q2hACMYwhxyAKLPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:34004)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1trhdQ-00GHKY-Gb; Mon, 10 Mar 2025 12:13:52 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:39900 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1trhdP-009nsv-6N; Mon, 10 Mar 2025 12:13:52 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
  "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>
References: <20250308180602.129663-1-parav@nvidia.com>
	<87ecz4q27k.fsf@email.froward.int.ebiederm.org>
	<CY8PR12MB71959E6A56DACD7D1DC72AC8DCD62@CY8PR12MB7195.namprd12.prod.outlook.com>
Date: Mon, 10 Mar 2025 13:13:45 -0500
In-Reply-To: <CY8PR12MB71959E6A56DACD7D1DC72AC8DCD62@CY8PR12MB7195.namprd12.prod.outlook.com>
	(Parav Pandit's message of "Mon, 10 Mar 2025 17:48:32 +0000")
Message-ID: <87msdsoism.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1trhdP-009nsv-6N;;;mid=<87msdsoism.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19q1558Ve6heZBOBj7k/D89Q0HPMO5dSho=
X-Spam-Level: *****
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4999]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  1.5 TR_AI_Phishing Email matches multiple AI-related patterns
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Parav Pandit <parav@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 737 ms - load_scoreonly_sql: 0.13 (0.0%),
	signal_user_changed: 11 (1.5%), b_tie_ro: 10 (1.3%), parse: 1.28
	(0.2%), extract_message_metadata: 20 (2.8%), get_uri_detail_list: 4.3
	(0.6%), tests_pri_-2000: 26 (3.5%), tests_pri_-1000: 2.5 (0.3%),
	tests_pri_-950: 1.30 (0.2%), tests_pri_-900: 1.03 (0.1%),
	tests_pri_-90: 88 (11.9%), check_bayes: 86 (11.7%), b_tokenize: 13
	(1.8%), b_tok_get_all: 13 (1.8%), b_comp_prob: 4.5 (0.6%),
	b_tok_touch_all: 51 (7.0%), b_finish: 0.99 (0.1%), tests_pri_0: 562
	(76.3%), check_dkim_signature: 0.77 (0.1%), check_dkim_adsp: 3.0
	(0.4%), poll_dns_idle: 1.12 (0.2%), tests_pri_10: 3.3 (0.4%),
	tests_pri_500: 16 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in
 user namespace
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, parav@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Parav Pandit <parav@nvidia.com> writes:

>> From: Eric W. Biederman <ebiederm@xmission.com>
>> Sent: Monday, March 10, 2025 9:59 PM
>> 
>> Parav Pandit <parav@nvidia.com> writes:
>> 
>> > A process running in a non-init user namespace possesses the
>> > CAP_NET_RAW capability. However, the patch cited in the fixes tag
>> > checks the capability in the default init user namespace.
>> > Because of this, when the process was started by Podman in a
>> > non-default user namespace, the flow creation failed.
>> 
>> This change isn't a bug fix.  This change is a relaxation of permissions and it
>> would be very good if this change description described why it is in fact safe.
> As you explained below, it is not safe enough. :)
> I will improve the change description to reflect as I follow your good suggestions below.
>
>> 
>> Many parts of the kernel are not safe for arbitrary users
>> to use.   In those cases an ordinary capable like you found
>> is used.
>> 
> Understood now.
>
>> > Fix this issue by checking the CAP_NET_RAW networking capability in
>> > the owner user namespace that created the network namespace.
>> >
>> > This change is similar to the following cited patches.
>> >
>> > commit 5e1fccc0bfac ("net: Allow userns root control of the core of
>> > the network stack.") commit 52e804c6dfaa ("net: Allow userns root to
>> > control ipv4") commit 59cd7377660a ("net: openvswitch: allow conntrack
>> > in non-initial user namespace") commit 0a3deb11858a ("fs: Allow
>> > listmount() in foreign mount namespace") commit dd7cb142f467 ("fs:
>> > relax permissions for listmount()")
>> 
>> It is different in that hardware is involved.  There is a fair amount of kernel
>> bypass allowed by design in infiniband so this may indeed be safe to allow
>> any user on the system to do.  Still for someone who isn't intimate with
>> infiniband this isn't clear.
>> 
>> > Fixes: c938a616aadb ("IB/core: Add raw packet QP type")
>> > Signed-off-by: Parav Pandit <parav@nvidia.com>
>> >
>> > ---
>> > I would like to have feedback from the LSM experts to make sure this
>> > fix is correct. Given the widespread usage of the capable() call, it
>> > makes me wonder if the patch right.
>> >
>> > Secondly, I wasn't able to determine which primary namespace (such as
>> > mount or IPC, etc.) to consider for the CAP_IPC_LOCK capability.
>> > (not directly related to this patch, but as concept)
>> 
>> I took a quick look and it appears that no one figures any of the
>> CAP_IPC_LOCK capability checks are safe for anyone except the global root
>> user.
>> 
>> Allowing an arbitrary user to lock all of memory seems to defeat all of the
>> safeguards that are in place to limiting memory locking.
>> 
>> It looks like RLIMIT_MEMLOCK has been updated to be per user namespace
>> (with hierachical limits), so I expect the most reasonable thing to do is to
>> simply ensure the process that creates the user namespace has a large
>> enough RLIMIT_MEMLOCK when the user namespace is created.
> Ok, but if infiniband code does capable(), it is going to check the limit outside of the user namespace, and the call will still fails.
> Isn't it?

It depends on how the check is implemented.  My point is that
RLIMIT_MEMLOCK has all of the knobs you might need to do something.

I don't know if the checks you are concerned about allow using
RLIMIT_MEMLOCK.  Given that some of them require having root in
the initial user namespace they might make a lot of assumptions.

But rlimits are related to but separate from capabilities.

> May be the users in non init user ns must run their infiniband application without pinning the memory.
> Aka ODP in infiniband world.

That sounds right.  I don't remember enough about infiniband to say for
certain.

Basically anything that uses ns_capable should be treated as something
any user can do, and so you need to watch out for hostile users.

>> > ---
>> >  drivers/infiniband/core/uverbs_cmd.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/infiniband/core/uverbs_cmd.c
>> > b/drivers/infiniband/core/uverbs_cmd.c
>> > index 5ad14c39d48c..8d6615f390f5 100644
>> > --- a/drivers/infiniband/core/uverbs_cmd.c
>> > +++ b/drivers/infiniband/core/uverbs_cmd.c
>> > @@ -3198,7 +3198,7 @@ static int ib_uverbs_ex_create_flow(struct
>> uverbs_attr_bundle *attrs)
>> >  	if (cmd.comp_mask)
>> >  		return -EINVAL;
>> >
>> > -	if (!capable(CAP_NET_RAW))
>> > +	if (!ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_RAW))
>> >  		return -EPERM;
>> 
>> Looking at the code in drivers/infiniband/core/uverbs_cmd.c
>> I don't think original capable call is actually correct.
>> 
>> The problem is that infiniband runs commands through a file descriptor.
>> Which means that anyone who can open the file descriptor and then obtain a
>> program that will work like a suid cat can bypass the current permission
>> check.
>> 
>> Before we relax any checks that test needs to be:
>> file_ns_capable(file, &init_user_ns, CAP_NET_RAW);
>> 
>
>> Similarly the network namespace you are talking about in those infiniband
>> commands really needs to be derived from the file descriptor instead of
>> current.
>> 
> This now start making sense to me.
> When the file descriptor is open, I need to record the net ns and use it for rest of the life cycle of the process (even if unshare(CLONE_NEWNET) is called) after opening the file.

For the rest of the life cycle of the file descriptor.  Don't forget
that file descriptors can be passed between processes.

> Something like how sk_alloc() does sock_net_set(sk, net);
>
> Do I understand you correctly?

Yes.

But first.  The permission checks need to be fixed to use the cred
cached on the file descriptor.  So that the permission checks are
not against the current process, but are against the process
that opened the file descriptor.

Otherwise a non-privileged process can open the file descriptor and
trick another process with more permissions to write the values it wants
to have written to the file descriptor.  Usually that is accomplished by
tricking some privileged application to write to stderr (that is passed
from the attacker).

Most of the time you can fix things like that using file_ns_capable.
Other times you encounter a userspace program that breaks and something
else needs to happen.

>> Those kinds of bugs seem very easy to find in the infiniband code so I have a
>> hunch that the infiniband code needs some tender loving care before it is safe
>> for unprivileged users to be able to do anything with it.
>> 
> Well, started to improve now...

No fault if you haven't lots of code that only root could use no one
takes seriously with respect to security issues, so it tends to be
buggy.  I have cleaned up a lot of code over the years before I have
relaxed the permissions.

Eric


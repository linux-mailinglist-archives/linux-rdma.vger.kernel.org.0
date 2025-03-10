Return-Path: <linux-rdma+bounces-8531-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CE9A59B90
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 17:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB67A3A4401
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083FD236A7B;
	Mon, 10 Mar 2025 16:46:35 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BC236453;
	Mon, 10 Mar 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625194; cv=none; b=uSaIZK2MVEDnR5Og2eFNSpOyuTaOwT0Yd2FASj0Ho84RUV4YUjh3GmJFkeqvsWQNX6tIX8FSecJjCQhirQCvLEWNf00TfSB3MJswAoLdWlqg0wo7Nhifvzk+lXsMLQIU3dq8w58O/PF1NFd3o3xc67xRroowMxyuGI/41CTg3HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625194; c=relaxed/simple;
	bh=WxYjed70KmC9+uQoTeTnkqesuIHE+yu2dDi8pwO6O5M=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=he6duOdJk5Qt3QnAHv2tLBoNWXQbc59yTGYCrY042QoZKBfKjltAyo3Wi1ZceUOecNeC6HJo/+GbvvgM7jJloa4wo3y5vAE6NqxgPiiWIM6vTPmoueiRAfhSe3WHFeq0/SxfpktonpeLLgrU6Bc0zoBTtIzXjTStBcD82k1ZJ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:37274)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1trg0W-003YOZ-5z; Mon, 10 Mar 2025 10:29:36 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:57096 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1trg0U-009VZn-UE; Mon, 10 Mar 2025 10:29:35 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Parav Pandit <parav@nvidia.com>
Cc: <linux-rdma@vger.kernel.org>,  <linux-security-module@vger.kernel.org>
References: <20250308180602.129663-1-parav@nvidia.com>
Date: Mon, 10 Mar 2025 11:29:03 -0500
In-Reply-To: <20250308180602.129663-1-parav@nvidia.com> (Parav Pandit's
	message of "Sat, 8 Mar 2025 20:06:02 +0200")
Message-ID: <87ecz4q27k.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1trg0U-009VZn-UE;;;mid=<87ecz4q27k.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/GoTdbT7XU1CQAoBLZ3qlsFSPPowM+yUE=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Parav Pandit <parav@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 671 ms - load_scoreonly_sql: 0.09 (0.0%),
	signal_user_changed: 11 (1.7%), b_tie_ro: 10 (1.4%), parse: 1.78
	(0.3%), extract_message_metadata: 17 (2.5%), get_uri_detail_list: 3.1
	(0.5%), tests_pri_-2000: 15 (2.2%), tests_pri_-1000: 2.3 (0.3%),
	tests_pri_-950: 1.25 (0.2%), tests_pri_-900: 0.98 (0.1%),
	tests_pri_-90: 165 (24.6%), check_bayes: 163 (24.3%), b_tokenize: 9
	(1.3%), b_tok_get_all: 9 (1.4%), b_comp_prob: 3.0 (0.5%),
	b_tok_touch_all: 138 (20.6%), b_finish: 0.98 (0.1%), tests_pri_0: 436
	(65.0%), check_dkim_signature: 1.29 (0.2%), check_dkim_adsp: 3.4
	(0.5%), poll_dns_idle: 0.95 (0.1%), tests_pri_10: 2.2 (0.3%),
	tests_pri_500: 14 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Fix CAP_NET_RAW check for flow create in
 user namespace
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, parav@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Parav Pandit <parav@nvidia.com> writes:

> A process running in a non-init user namespace possesses the
> CAP_NET_RAW capability. However, the patch cited in the fixes
> tag checks the capability in the default init user namespace.
> Because of this, when the process was started by Podman in a
> non-default user namespace, the flow creation failed.

This change isn't a bug fix.  This change is a relaxation of
permissions and it would be very good if this change description
described why it is in fact safe.

Many parts of the kernel are not safe for arbitrary users
to use.   In those cases an ordinary capable like you found
is used.

> Fix this issue by checking the CAP_NET_RAW networking capability
> in the owner user namespace that created the network namespace.
>
> This change is similar to the following cited patches.
>
> commit 5e1fccc0bfac ("net: Allow userns root control of the core of the network stack.")
> commit 52e804c6dfaa ("net: Allow userns root to control ipv4")
> commit 59cd7377660a ("net: openvswitch: allow conntrack in non-initial user namespace")
> commit 0a3deb11858a ("fs: Allow listmount() in foreign mount namespace")
> commit dd7cb142f467 ("fs: relax permissions for listmount()")

It is different in that hardware is involved.  There is a fair amount of
kernel bypass allowed by design in infiniband so this may indeed be safe
to allow any user on the system to do.  Still for someone who isn't
intimate with infiniband this isn't clear.

> Fixes: c938a616aadb ("IB/core: Add raw packet QP type")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> ---
> I would like to have feedback from the LSM experts to make sure this
> fix is correct. Given the widespread usage of the capable() call,
> it makes me wonder if the patch right.
>
> Secondly, I wasn't able to determine which primary namespace (such as
> mount or IPC, etc.) to consider for the CAP_IPC_LOCK capability.
> (not directly related to this patch, but as concept)

I took a quick look and it appears that no one figures any of the
CAP_IPC_LOCK capability checks are safe for anyone except the global
root user.

Allowing an arbitrary user to lock all of memory seems to defeat all
of the safeguards that are in place to limiting memory locking.

It looks like RLIMIT_MEMLOCK has been updated to be per user namespace
(with hierachical limits), so I expect the most reasonable thing
to do is to simply ensure the process that creates the user
namespace has a large enough RLIMIT_MEMLOCK when the user namespace
is created.

> ---
>  drivers/infiniband/core/uverbs_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 5ad14c39d48c..8d6615f390f5 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -3198,7 +3198,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
>  	if (cmd.comp_mask)
>  		return -EINVAL;
>  
> -	if (!capable(CAP_NET_RAW))
> +	if (!ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_RAW))
>  		return -EPERM;

Looking at the code in drivers/infiniband/core/uverbs_cmd.c
I don't think original capable call is actually correct.

The problem is that infiniband runs commands through a file descriptor.
Which means that anyone who can open the file descriptor and
then obtain a program that will work like a suid cat can bypass
the current permission check.

Before we relax any checks that test needs to be:
file_ns_capable(file, &init_user_ns, CAP_NET_RAW);

Similarly the network namespace you are talking about in those
infiniband commands really needs to be derived from the file
descriptor instead of current.

Those kinds of bugs seem very easy to find in the infiniband code
so I have a hunch that the infiniband code needs some tender loving
care before it is safe for unprivileged users to be able to do
anything with it.

In particular there was a whole lot of bug fixes and other work done to
the mount namespace and in the networking stack before allowing
unprivileged users to use it.

In the ip part of the networking stack CAP_NET_RAW allows all kinds
of things but when it is limited to only a single networking stack
(one the user had to create) it becomes safe.  I don't remember
enough about infiniband to safe if those parts guarded with CAP_NET_RAW
are safe in that way.

Eric


>  
>  	if (cmd.flow_attr.flags >= IB_FLOW_ATTR_FLAGS_RESERVED)


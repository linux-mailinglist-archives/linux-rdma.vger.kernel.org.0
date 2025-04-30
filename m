Return-Path: <linux-rdma+bounces-9932-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69234AA4189
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Apr 2025 05:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6C7465CFE
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Apr 2025 03:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87AC1C84B6;
	Wed, 30 Apr 2025 03:55:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C275383;
	Wed, 30 Apr 2025 03:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745985343; cv=none; b=KVANi9EJJw3pnIC4QOsr37MRuoLndd5RHjaO8VCGG5LnaltYixUEG0gbMpdWNFGQIRmM4FCqkbOIEO3YWYH/TX7LlXTlqH+GFJr02rsfMpHA/+NQkuC3oKZSm3wbmphiMSu5dtkr+YieQL/QI1GAJd0uo9e4EB8kyLFaJbNFBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745985343; c=relaxed/simple;
	bh=Slvzz0MuimEJxiGmsZQOSUNtVIHwR5e74G12a0AJ3oY=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=WISzTRVxST+vnvfcZ9HxeywXsPesXuWN0J79sR2fT8LAlSlreNAgb3P4ZuvrON9CWciP1qkw63/gpBbp56YOjO4UNCrL5OdPq5nqbeXfq2iB+esa1q5t21S0zEDnh8PLzvJ0+11L4RSaCEkapoKBRSDRqPJ+wcFAKi5o6z80Sc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:35830)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u9yDw-000tkx-K3; Tue, 29 Apr 2025 21:35:04 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:49026 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u9yDv-0052df-9I; Tue, 29 Apr 2025 21:35:04 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,  "Serge E. Hallyn" <serge@hallyn.com>,
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
	<87tt68cj64.fsf@email.froward.int.ebiederm.org>
	<CY8PR12MB7195855B870B5D00EACFDC79DC802@CY8PR12MB7195.namprd12.prod.outlook.com>
Date: Tue, 29 Apr 2025 22:34:41 -0500
In-Reply-To: <CY8PR12MB7195855B870B5D00EACFDC79DC802@CY8PR12MB7195.namprd12.prod.outlook.com>
	(Parav Pandit's message of "Tue, 29 Apr 2025 10:39:39 +0000")
Message-ID: <874iy6b9v2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1u9yDv-0052df-9I;;;mid=<874iy6b9v2.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1//twEa4dhnEz/8trNrWTKmUK9DTT88SOc=
X-Spam-Level: **
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  1.0 XMGenDplmaNmb Diploma spam phrases+possible phone number
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Parav Pandit <parav@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 665 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.6 (0.5%), b_tie_ro: 2.5 (0.4%), parse: 0.73
	(0.1%), extract_message_metadata: 14 (2.0%), get_uri_detail_list: 1.59
	(0.2%), tests_pri_-2000: 12 (1.8%), tests_pri_-1000: 1.84 (0.3%),
	tests_pri_-950: 0.96 (0.1%), tests_pri_-900: 0.77 (0.1%),
	tests_pri_-90: 61 (9.2%), check_bayes: 60 (9.0%), b_tokenize: 6 (0.9%),
	 b_tok_get_all: 7 (1.0%), b_comp_prob: 1.49 (0.2%), b_tok_touch_all:
	44 (6.5%), b_finish: 0.59 (0.1%), tests_pri_0: 401 (60.3%),
	check_dkim_signature: 0.41 (0.1%), check_dkim_adsp: 2.9 (0.4%),
	poll_dns_idle: 156 (23.4%), tests_pri_10: 1.75 (0.3%), tests_pri_500:
	165 (24.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: leonro@nvidia.com, linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, serge@hallyn.com, jgg@nvidia.com, parav@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Parav Pandit <parav@nvidia.com> writes:

>> From: Eric W. Biederman <ebiederm@xmission.com>
>> Sent: Monday, April 28, 2025 10:34 PM
>
> [..]
>> > I said "user_ns of the netns"?  Credentials of the process is
>> > something else?
>> 
>> Exactly the credentials of the a process are not:
>> 	current->nsproxy->net_ns->user_ns;  /* Not this */
>> 
>> The credentials of a process are:
>> 	current->cred;  /* This */
>> 
>> With current->cred->user_ns the current processes user namespace.
>> 
> I am confused with your above response.
> In response [1], you described that net ns is the resource,
> hence resource's user namespace is considered.
> And your response [1] also aligns to existing code of [2] and many similar conversions done by your commit 276996fda0f33.
>
> [1] https://lore.kernel.org/linux-rdma/87ikmnd3j6.fsf@email.froward.int.ebiederm.org/T/#me5983d8248de0ff9670644c57d71009debaedd6f
> [2] https://elixir.bootlin.com/linux/v6.14.3/source/net/ipv4/af_inet.c#L314
>
> So in infiniband, when I replace existing capable() with ns_capable(), 
> shouldn't I use current->nsproxy->net_ns->user_ns following [1] and
> [2], because for infiniband too, the resource is net namespace.

Almost.

It is true that current->nsproxy->net_ns matches ib_device->net_ns at
open time, but those permission checks don't happen at open time.

After open time you want ib_device->net_ns.  Not
current->nsproxy->net_ns.

At which point your ns_capable call will look something like:

	ns_capable(ib_device->net_ns->user_ns, CAP_NET_RAW);

That ns_capable call will then check

ib_device->net_ns->user_ns against
current->cred->user_ns.

And it will verify that CAP_NET_RAW is in
current->cred->cap_effect.

Thus checking the resource (the ib_device) against the current
process's credentials.

----

The danger of using current->nsproxy->net_ns->user ns after
open time is the caller may have done.

unshare(CLONE_NEWUSER);
unshare(CLONE_NEWNET);

At which point
"ns_capable(current->nsproxy->net_ns->user_ns, CAP_NET_RAW)"
is guaranteed to be true.

But it isn't meaningful because there are be no ib_devices in that
network namespace.

----

Because of the shared device stuff a relaxed permission check
would actually need to look more like.

	struct user_ns *user_ns = shared ? &init_user_ns : ib_device->net_ns->user_ns;
        ns_capable(user_ns, CAP_NET_RAW);

This allows sharing the capable call for better maintenance but only
relaxing the permission check for the other cases.

Eric




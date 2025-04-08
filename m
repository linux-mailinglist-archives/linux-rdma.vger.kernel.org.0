Return-Path: <linux-rdma+bounces-9265-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 083A3A81005
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 17:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E62188519F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 15:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731CD226D0F;
	Tue,  8 Apr 2025 15:26:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480DD1D5CCD;
	Tue,  8 Apr 2025 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126002; cv=none; b=QswJMdKvPIy5vaqAgTdARON7u0oGuslbHZUwkFoRz7aTpyYO3//PENPxvuANoVfw/cf7tOD0m+qxxWbsX60ArjU0A6Gf90QevoNWI8FkLP37LklJh5NG+PCZSZI+dDgiC19Buo0OIIEocaGuEFIdze0wP4Ar95q3LQiQ31QrPs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126002; c=relaxed/simple;
	bh=C+MtY+usq7nMEaAJnvoz8DF3Tmuw1uXPUjqSJTGTAQk=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=XHZfZXphUEmpzkDgLk7GCtlZcpbozYDcnA0sjZDanUAY6OJEW+OZP21K/pABB39LJ3HVSHa3WPgFU+A9kah4NFAXc6Cy/Rtc+GkWqrFYCvkdQlt8OgeuXBs/05Ne9hr8Eh2cl/ptcvFT6eof0j5sYISD2zOcwCcWYucnzw14AAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:49296)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u2ABx-00DUGT-Lk; Tue, 08 Apr 2025 08:44:45 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:33912 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u2ABw-00Duhi-Cs; Tue, 08 Apr 2025 08:44:45 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,  "Serge E. Hallyn" <serge@hallyn.com>,
  "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
  "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,  Leon Romanovsky
 <leonro@nvidia.com>
References: <20250313050832.113030-1-parav@nvidia.com>
	<20250317193148.GU9311@nvidia.com>
	<CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250318112049.GC9311@nvidia.com>
	<87ldt2yur4.fsf@email.froward.int.ebiederm.org>
	<20250318225709.GC9311@nvidia.com>
	<CY8PR12MB7195B7FAA54E7E0264D28BAEDCA92@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250404151347.GC1336818@nvidia.com>
	<20250406141501.GA481691@mail.hallyn.com>
	<CY8PR12MB7195987AD22775DBBA7FD3B5DCAA2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250407161225.GF1557073@nvidia.com>
Date: Tue, 08 Apr 2025 09:44:13 -0500
In-Reply-To: <20250407161225.GF1557073@nvidia.com> (Jason Gunthorpe's message
	of "Mon, 7 Apr 2025 13:12:25 -0300")
Message-ID: <87ikned876.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1u2ABw-00Duhi-Cs;;;mid=<87ikned876.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+X8AWmDirKjmYUvPDfMZs7fbq6+1y3LOI=
X-Spam-Level: **
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4984]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
	*  1.0 XM_B_Phish_Phrases Commonly used Phishing Phrases
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Jason Gunthorpe <jgg@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 710 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 11 (1.6%), b_tie_ro: 10 (1.3%), parse: 1.07
	(0.2%), extract_message_metadata: 16 (2.2%), get_uri_detail_list: 2.8
	(0.4%), tests_pri_-2000: 18 (2.6%), tests_pri_-1000: 3.4 (0.5%),
	tests_pri_-950: 1.82 (0.3%), tests_pri_-900: 1.48 (0.2%),
	tests_pri_-90: 227 (32.0%), check_bayes: 225 (31.7%), b_tokenize: 10
	(1.4%), b_tok_get_all: 10 (1.3%), b_comp_prob: 3.5 (0.5%),
	b_tok_touch_all: 198 (27.9%), b_finish: 1.06 (0.1%), tests_pri_0: 410
	(57.7%), check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 3.1
	(0.4%), poll_dns_idle: 1.11 (0.2%), tests_pri_10: 2.3 (0.3%),
	tests_pri_500: 13 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: leonro@nvidia.com, linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, serge@hallyn.com, parav@nvidia.com, jgg@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Apr 07, 2025 at 11:16:35AM +0000, Parav Pandit wrote:
>> > > This all makes my head hurt. The right user namespace is the one that
>> > > is currently active for the invoking process, I couldn't understand
>> > > why we have net namespaces refer to user namespaces :\
>> > 
>> > A user at any time can create a new user namespace, without creating a new
>> > network namespace, and have privilege in that user namespace, over
>> > resources owned by the user namespace.
>>  
>> > So if a user can create a new user namespace, then say "hey I have
>> > CAP_NET_ADMIN over current_user_ns, so give me access to the RDMA
>> > resources belonging to my current_net_ns", that's a problem.
>
> But why is that possible? If the current user name space does not have
> CAP_NET_ADMIN then why can it create a new user name space that does?

Because it isn't CAP_NET_ADMIN.  The capabilities are per user
namespace.

AKA the pair (&init_user_ns, CAP_NET_ADMIN) is what you think of when
you think of CAP_NET_ADMIN.

The reason for this is a lot of things that capabilities guard are only
semantically a problem because it would confuse preexisting suid root
binaries.  Binding to the low ports (for example) is no more special
than binding to any other port, except that assumptions can be made
about who has bound to the low ports.

So if you can restrict binding to the low ports only to network
namespaces that you and your children control so there is no change
of confusing a suid root application that it is a legitimate operation
to perform.

In networking terms the user namespace and the subordinate namespace
created with user namespace permissions are a bit like a tunnel.  The
users of a tunnel can do anything inside their tunnel assign IP
addresses etc, and no one will care as long as it all stays inside the
tunnel.

So in essence the question is do you have capabilities within the tunnel
or do you have capabilities outside of a tunnel.


Do to historical silliness there is a practical concern about code that
only root could run.  People tend not to worry if there are bugs that
allow such code to do unintended things.  So even if semantically it is
safe to allow such code, generally the code needs a bit of an audit to
make certain there are not bugs or implementation assumptions that will
be violated when allowing additional functionality in a user namespace.

> And if userspace does have CAP_NET_ADMIN what is the issue with
> creating more user namespaces that also have it?
>
>> > So that's why the check should be ns_capable(device->net->user-ns,
>> > CAP_NET_ADMIN) and not ns_capable(current_user_ns, CAP_NET_ADMIN).
>> >
>> Given the check is of the process (and hence user and net ns) and not of the rdma device itself,
>> Shouldn't we just check,
>> 
>> ns_capable(current->nsproxy->user_ns, ...)
>> 
>> This ensures current network namespace's owning user ns is consulted.
>
> It sounds like the design does not store the capabilities inside the
> current user_ns, but it logically stores them in other NSs. Ie all the
> net related capabilities are in the netns.
>
> Presumably then we have a mapping of every capability to the proper
> namespace to store it?

Store is the wrong concept.  Namespaces remember which user namespace
they were created from.  This allows the capability checks to require
that you have the capability in the user namespace that created them,
or in a parent user namespace.

There exists a full set of capabilities that can be present in
a user namespace.  The initial process in a user namespace is given
all of those capabilities in it's struct cred.  Just like the init
process is given all capabilities at system start.  The difference
is that when all you have are capabilities that are limited to
a user namespace they don't allow anything to be done (other than
creating namespaces) unless some namespaces are created from that
user namespace.

> If the container has a user namespace and the net ns uses the same
> user namespace then you get the appearance of user namespace
> controlled capabilities...

Essentially yes.

That network namespace requires CAP_NET_ADMIN in the user namespace
it was created within (or a parent user namespace), for it's capability
checks.

Eric





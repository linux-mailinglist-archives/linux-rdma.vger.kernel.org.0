Return-Path: <linux-rdma+bounces-8795-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBABEA67E06
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 21:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990C27A89B5
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 20:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85247212B3E;
	Tue, 18 Mar 2025 20:30:05 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC368212FB3;
	Tue, 18 Mar 2025 20:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329805; cv=none; b=CqjskmnBahroaOoqWzSk34flvl1nZWkyyPLtIwHgsnZbzn2rx+l1SRQIEqZxxyllKjx1qzl9zLMoeInCOVTb0USOOQ7VxiXA9I9lcnZ3qrKVqU2RZCkQ97+e9UXgQsY9REmivGSIMVL2B8cXRPBNZAArAIBajnQlc0dm8j3m3fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329805; c=relaxed/simple;
	bh=DNQ/LFt+8y0Rt4wm+QWBs6cIPiYxhh5zCXUFhT87qIQ=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=V5HAqm70Q6QLMCTowOwsoXlQ9WcFwhQWUCVpsH7hHJv8h42R35mePVNM8J383CRX1+b6dW86xfRVxbi8RBcNZbnJ6p8/7fI6S0OhIuft7jmv4APHDgxsnh31jGchMHoq5i8NZku/6rEWINfMzujpmpj8YNkXE2B/w8yyGD1rH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:41312)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tud74-000r2i-Hx; Tue, 18 Mar 2025 14:00:34 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:47254 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1tud72-006mRP-TT; Tue, 18 Mar 2025 14:00:33 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,  "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>,  "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,  "serge@hallyn.com"
 <serge@hallyn.com>,  Leon Romanovsky <leonro@nvidia.com>
References: <20250313050832.113030-1-parav@nvidia.com>
	<20250317193148.GU9311@nvidia.com>
	<CY8PR12MB7195C6D8CCE062CFD9D0174CDCDE2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250318112049.GC9311@nvidia.com>
Date: Tue, 18 Mar 2025 15:00:15 -0500
In-Reply-To: <20250318112049.GC9311@nvidia.com> (Jason Gunthorpe's message of
	"Tue, 18 Mar 2025 08:20:49 -0300")
Message-ID: <87ldt2yur4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1tud72-006mRP-TT;;;mid=<87ldt2yur4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/5OJ+Cv2L3+h3cPE3hRy8+P55pe98Gl2A=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 XM_B_AI_SPAM_COMBINATION Email matches multiple AI-related
	*      patterns
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jason Gunthorpe <jgg@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 420 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 10 (2.4%), b_tie_ro: 9 (2.1%), parse: 0.82 (0.2%),
	 extract_message_metadata: 11 (2.7%), get_uri_detail_list: 1.60 (0.4%),
	 tests_pri_-2000: 15 (3.5%), tests_pri_-1000: 2.3 (0.5%),
	tests_pri_-950: 1.16 (0.3%), tests_pri_-900: 0.95 (0.2%),
	tests_pri_-90: 111 (26.5%), check_bayes: 110 (26.1%), b_tokenize: 6
	(1.5%), b_tok_get_all: 58 (13.7%), b_comp_prob: 2.6 (0.6%),
	b_tok_touch_all: 40 (9.5%), b_finish: 0.82 (0.2%), tests_pri_0: 256
	(60.9%), check_dkim_signature: 0.48 (0.1%), check_dkim_adsp: 2.4
	(0.6%), poll_dns_idle: 0.71 (0.2%), tests_pri_10: 1.91 (0.5%),
	tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: leonro@nvidia.com, serge@hallyn.com, linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, parav@nvidia.com, jgg@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out01.mta.xmission.com); SAEximRunCond expanded to false

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Tue, Mar 18, 2025 at 03:43:07AM +0000, Parav Pandit wrote:
>
>> > I would say no, that is not our model in RDMA. The process that opens the file
>> > is irrelevant. We only check the current system call context for capability,
>> > much like any other systemcall.
>> >
>> Eric explained the motivation [1] and [2] for this fix is:
>> A lesser privilege process A opens the fd (currently caps are not
>> checked), passes the fd to a higher privilege process B.
>
>> And somehow let process B pass the needed capabilities check for
>> resource creation, after which process A continue to use the
>> resource without capability.
>
> Yes, I'd say that is fine within our model, and may even be desirable
> in some cases.
>
> We don't use a file descriptor linked security model, it is always
> secured based on the individual ioctl system call. The file descriptor
> is just a way to route the system calls.
>
> The "setuid cat" risk is interesting, but we are supposed to be
> preventing that by using ioctl, no 'cat' program is going to randomly
> execute ioctls on stdout.

I guess I see a few places where inifiniband uses ioctl.

There are also a lot of places where inifinband uses raw read/write on
file descriptors.  I think last time I looked infiniband wasn't even using
ioctl.

Now maybe using an ioctl is the best you can do at this point, because
of some backwards compatibility. 

> You would not say that if process B creates a CAP_NET_RAW socket FD
> and passes it to process A without CAP_NET_RAW then A should not be
> able to use the FD.

But that is exactly what the infiniband security check were are talking
about appears to be doing.  It is using the credentials of process A
and failing after it was passed by process B.

> The same principle holds here too, the object handles scoped inside
> the FD should have the same kind of security properties as a normal FD
> would.

Which is fine as far as I understand it is fine.  The creation check is
what we were talking about.

Taking from your example above.  If process B with CAP_NET_RAW creates a
FD for opening queue pairs and passes it to process A without
CAP_NET_RAW then A is not able to create queue pairs.

That is what the code in
drivers/infiniband/core/ubvers_cmd.c:create_qp() currenty says.

That is what has us confused.  Exactly the kind of thing you said should
not be happening is happening.

Eric



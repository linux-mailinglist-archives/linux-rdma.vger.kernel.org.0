Return-Path: <linux-rdma+bounces-9742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD80A99507
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 18:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7C23B520E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 16:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8F1A0BE0;
	Wed, 23 Apr 2025 16:12:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0C19DFA7;
	Wed, 23 Apr 2025 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424764; cv=none; b=IluwngIvmAxgzLZEwHadPTSw7HMk6YY6zHExrdeY12d0NqSTbwQRlao6o1HGMFGuDgQkbgxCGSytOxd7uQzF4EJFt9dK/V/j8bEFoXQRpi6krxC56TupFfAOGbBzgIbS8hTPJ0siU5RpsazQ8UzZ0KgAnM62436YS4NEV2lanCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424764; c=relaxed/simple;
	bh=F/xISTNgLIzdCW9nv6KBRXu0Ac8JDl58yRjsuFhxIiw=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=LjqrS1r/lryx90PwwsAie5qJNvMX6ioAI5CjvRvrpbXk+eaH0X6itzpRb+RI6yIbnqJVKQ3OFUnjX25PDOvfDZQppx8u7hQONTqbLD1EowXzMgJawlWKYxhVhSbxwGzfn5/hyTaGXXPwv6TpAr4EHB7UgtFG1GmHLb1Y0W0ZW58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:45126)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u7cNy-001mxW-7y; Wed, 23 Apr 2025 09:51:42 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:37826 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u7cNx-00F7XC-5J; Wed, 23 Apr 2025 09:51:41 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>,  "Serge E. Hallyn" <serge@hallyn.com>,
  "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
  "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,  Leon Romanovsky
 <leonro@nvidia.com>
References: <20250421031320.GA579226@mail.hallyn.com>
	<CY8PR12MB7195E4A0C6E019F10222B543DCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250421130024.GA582222@mail.hallyn.com>
	<CY8PR12MB71955204622F18B2C3437BCBDCB82@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250421172236.GA583385@mail.hallyn.com>
	<20250422124640.GI823903@nvidia.com>
	<20250422131433.GA588503@mail.hallyn.com>
	<20250422161127.GO823903@nvidia.com>
	<20250422162943.GA589534@mail.hallyn.com>
	<CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250423144649.GA1743270@nvidia.com>
Date: Wed, 23 Apr 2025 10:43:40 -0500
In-Reply-To: <20250423144649.GA1743270@nvidia.com> (Jason Gunthorpe's message
	of "Wed, 23 Apr 2025 11:46:49 -0300")
Message-ID: <87msc6khn7.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1u7cNx-00F7XC-5J;;;mid=<87msc6khn7.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/DMyTdoa6WlVeBX+WPMsUVB+KePa8zYhE=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4998]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
	*  1.0 XMGenDplmaNmb Diploma spam phrases+possible phone number
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Jason Gunthorpe <jgg@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 569 ms - load_scoreonly_sql: 0.09 (0.0%),
	signal_user_changed: 15 (2.6%), b_tie_ro: 12 (2.2%), parse: 1.41
	(0.2%), extract_message_metadata: 18 (3.2%), get_uri_detail_list: 2.6
	(0.5%), tests_pri_-2000: 19 (3.4%), tests_pri_-1000: 2.4 (0.4%),
	tests_pri_-950: 1.45 (0.3%), tests_pri_-900: 1.17 (0.2%),
	tests_pri_-90: 107 (18.9%), check_bayes: 101 (17.7%), b_tokenize: 7
	(1.2%), b_tok_get_all: 38 (6.8%), b_comp_prob: 3.0 (0.5%),
	b_tok_touch_all: 46 (8.1%), b_finish: 1.62 (0.3%), tests_pri_0: 383
	(67.3%), check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 3.9
	(0.7%), poll_dns_idle: 0.57 (0.1%), tests_pri_10: 4.3 (0.8%),
	tests_pri_500: 11 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: leonro@nvidia.com, linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, serge@hallyn.com, parav@nvidia.com, jgg@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Wed, Apr 23, 2025 at 12:41:26PM +0000, Parav Pandit wrote:
>> 
>> > From: Serge E. Hallyn <serge@hallyn.com>
>> > Sent: Tuesday, April 22, 2025 10:00 PM
>> > 
>> > On Tue, Apr 22, 2025 at 01:11:27PM -0300, Jason Gunthorpe wrote:
>> > > On Tue, Apr 22, 2025 at 08:14:33AM -0500, Serge E. Hallyn wrote:
>> > > > Hi Jason,
>> > > >
>> > > > On Tue, Apr 22, 2025 at 09:46:40AM -0300, Jason Gunthorpe wrote:
>> > > > > On Mon, Apr 21, 2025 at 12:22:36PM -0500, Serge E. Hallyn wrote:
>> > > > > > > > 1. the create should check
>> > > > > > > > ns_capable(current->nsproxy->net->user_ns,
>> > > > > > > > CAP_NET_RAW)
>> > > > > > > I believe this is sufficient as this create call happens through the
>> > ioctl().
>> > > > > > > But more question on #3.
>> > > > >
>> > > > > I think this is the right one to use everywhere.
>> > > >
>> > > > It's the right one to use when creating resources, but when later
>> > > > using them, since below you say that the resource should in fact be
>> > > > tied to the creator's network namespace, that means that checking
>> > > > current->nsproxy->net->user_ns would have nothing to do with the
>> > > > resource being used, right?
>> > >
>> > > Yes, in that case you'd check something stored in the uobject.
>> > 
>> > Perfect, that's exactly the kind of thing I was looking for.  Thanks.
>> >
>> It means uboject create path will refcount and store user_ns, 
>> 
>> uobject->user_ns = get_user_ns(current->nsproxy->net->user_ns);
>> 
>> And uobject destroy will do,
>> 	put_user_ns(uobject->user_ns).
>> 
>> This will ensure that in below flow we won't have use_after_free.
>> 1. process_A created object in user_ns_A
>> 2. process_A shared fd with process_B in user_ns_B
>> 3. process_A is killed and
>> 4. user_ns_A is free is attempted (free is skipped, until uobject is destroyed by process_B).
>
> We only need to do that if something is legimitately doing capable
> from a uobject outside of creation? Did you find that?

I believe the proposed change that started this discussion,
was to make rdma usable inside of a user namespace.

Which led to the question: Are the current capable calls safe and
correct, as they aren't preserving the context that can with opening a
file descriptor?  If I have skimmed this thread correctly the answer
not preserving the opener's context is a seriously atypical but
deliberate choice.

> And I wonder if using the uobjects affiliated netdev's namespace is
> OK?

That is actually preferable.  It is what I updated the rest of the
network stack to do.  I don't know if you would use dev_net or
something else.

Going back to the original proposal I don't know how ready the code is
to handle callers that are not root.  This is both a question of
semantics (is it safe in theory) and a question of implementation (are
there unfixed bugs that no one cares about because only root has been
using the code).

Eric


Return-Path: <linux-rdma+bounces-9806-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D4A9CD88
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 17:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63469C1811
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BD328DF19;
	Fri, 25 Apr 2025 15:47:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4D28BA85;
	Fri, 25 Apr 2025 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596030; cv=none; b=XDyGEL6Oi4nZepD+oAjwnmA36I1j9KWJ48JcFpvAKgaRPRgacOs8S2vFWOpLND+Mmc900sa9F8yG9lZJrAWECJzDnSbsJ1b0nuANW76186GA4Ho69tKpQNBSArIAY7oUulDSuu+CTdER5Txpj3YAuMB/hqWkJILLz1K2NAfIzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596030; c=relaxed/simple;
	bh=E74+GAJ7a7TJM5ui/dTPScaQz4MmrSVHAT94nET6Dyg=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=mhKNov5z4OOUOaNq4yBUr2coB04i1sfuvVK4L3RomYrLtZDK7lRZAJlFQGlkZ/N+H3KQmUYWCmyCYBxUQpriyZIkzaosd+exA76+vcjOSNfFjHj1+9rc1502onG/I6mjygSuQKlIDmtsxTRzD4CVpME1+TLg3H533QB7MLBZZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:35550)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u8LGd-005SR8-8N; Fri, 25 Apr 2025 09:47:07 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:39646 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u8LGb-00D3vl-VV; Fri, 25 Apr 2025 09:47:06 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,  Jason Gunthorpe <jgg@nvidia.com>,
  "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
  "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,  Leon Romanovsky
 <leonro@nvidia.com>
References: <20250423144649.GA1743270@nvidia.com>
	<87msc6khn7.fsf@email.froward.int.ebiederm.org>
	<CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250423164545.GM1648741@nvidia.com>
	<CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250424141347.GS1648741@nvidia.com>
	<CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250425132930.GB1804142@nvidia.com>
	<20250425140144.GB610516@mail.hallyn.com>
	<20250425142429.GC1804142@nvidia.com>
	<20250425150641.GA610929@mail.hallyn.com>
	<PH8PR12MB720850A641460067F7CC548DDC842@PH8PR12MB7208.namprd12.prod.outlook.com>
Date: Fri, 25 Apr 2025 10:46:59 -0500
In-Reply-To: <PH8PR12MB720850A641460067F7CC548DDC842@PH8PR12MB7208.namprd12.prod.outlook.com>
	(Parav Pandit's message of "Fri, 25 Apr 2025 15:27:40 +0000")
Message-ID: <871ptgi6q4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1u8LGb-00D3vl-VV;;;mid=<871ptgi6q4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/thwJ/2b5mAl3SErLE510cXl4iCcwAd5U=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Parav Pandit <parav@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 612 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 10 (1.6%), b_tie_ro: 8 (1.4%), parse: 0.92 (0.2%),
	 extract_message_metadata: 19 (3.1%), get_uri_detail_list: 2.2 (0.4%),
	tests_pri_-2000: 23 (3.8%), tests_pri_-1000: 2.4 (0.4%),
	tests_pri_-950: 1.22 (0.2%), tests_pri_-900: 1.00 (0.2%),
	tests_pri_-90: 233 (38.2%), check_bayes: 222 (36.2%), b_tokenize: 9
	(1.4%), b_tok_get_all: 97 (15.8%), b_comp_prob: 2.7 (0.4%),
	b_tok_touch_all: 110 (18.0%), b_finish: 0.85 (0.1%), tests_pri_0: 307
	(50.1%), check_dkim_signature: 0.58 (0.1%), check_dkim_adsp: 3.0
	(0.5%), poll_dns_idle: 1.15 (0.2%), tests_pri_10: 2.2 (0.4%),
	tests_pri_500: 9 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: leonro@nvidia.com, linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@nvidia.com, serge@hallyn.com, parav@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Parav Pandit <parav@nvidia.com> writes:

>> From: Serge E. Hallyn <serge@hallyn.com>
>> Sent: Friday, April 25, 2025 8:37 PM
>> 
>> On Fri, Apr 25, 2025 at 11:24:29AM -0300, Jason Gunthorpe wrote:
>> > On Fri, Apr 25, 2025 at 09:01:44AM -0500, Serge E. Hallyn wrote:
>> > > On Fri, Apr 25, 2025 at 10:29:30AM -0300, Jason Gunthorpe wrote:
>> > > > On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
>> > > >
>> > > > > 1. In uobject creation syscall, I will add the check current->nsproxy-
>> >net->user_ns capability using ns_capable().
>> > > > > And we don't hold any reference for user ns.
>> > > >
>> > > > This is the thing that makes my head ache.. Is that really the
>> > > > right way to get the user_ns of current? Is it possible that
>> > > > current has multiple user_ns's? We are picking nsproxy because
>> > > > ib_dev has a net namespace affiliation?
>> > >
>> > > It's not that "current has multiple user_ns's", it's that the
>> > > various resources, including other namespaces, which current has or
>> > > belongs to have associated namespaces.
>> >
>> > That seems like splitting nits. Can I do current->XXX->user_ns and get
>> > different answers? Sounds like yes?
>> 
>> I don't think it's splitting nits.  current->nsproxy->net_ns->user_ns is not
>> current's user namespace.
>> 
>> > > current_user_ns() is the user namespace to which current belongs.
>> > > But if you want to check if it can have privilege over a resource,
>> > > you have to check whether current has ns_capable(resource->userns,
>> CAP_X).
>> >
>> > So what is the resource here?
>> 
>> That's what I've been trying to get answered :)
>>
> A. When a raw socket is created to send a packet vis netdev
> (resource), the cap is checked against the process in [1].

No.

> [1] https://elixir.bootlin.com/linux/v6.14.3/source/net/ipv4/af_inet.c#L314
> Not against the netdev's dev_net().

There isn't a netdevide to check against.

The resource is the network namespace aka net.

The permission check is not solely against the processes credentials
in current->cred.

> B. Netdev's dev_net() is crossed checked to see if current process can access netdev ifindex or not in send() call.
>
> So resource was netdev, but literally the check is against the process
> cap.

Not at all.    The process (user_ns,cap) pair in current->cred is checked
against the user_ns that owns the network namespace aka net->user_ns.

That current is used to find the network namespace is irrelevant for
the permission check.

> And considering above is right,
>
> I try to draw the parallels between the two types of network devices,
>
> the check for rdma raw QP (equivalent of raw socket), 
> Should check similarly against the process's net->user_ns during QP creation time.
> This will match #A.
>
> And process to rdma access check should be a separate check #B.

The way you described it sounds wrong, but your conclusion of
what needs to be checked seems correct.

Eric




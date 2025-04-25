Return-Path: <linux-rdma+bounces-9805-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E34A9CD1F
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 17:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEA64A6789
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Apr 2025 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815F628A1F3;
	Fri, 25 Apr 2025 15:33:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4822274FEE;
	Fri, 25 Apr 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595184; cv=none; b=apz2tTptzVqOj3taxDqPknbptwvtXEsjb+Zq90CA25AVSYUNSaZoVAx1pFG1q5PfGU9aAD7UGqa58faAOB8j9UtptCs+IhPBxHcxOfe8OwWqP7UFrPFoGAFUtmolKiYeVHLq9kkq3YQarKOSkAQqiGDbVsTTDvvP0bfshbDQ0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595184; c=relaxed/simple;
	bh=qynsqXKd3D9phI89whOTWMWqNDtwuVtbtMGvt0hfYjw=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=XbwB9u+ctp0bHUUG/3djX8uTdAKvxmG7XhACSUP6FzKbF0EUZy6sNTaRSIKx2TDO4X1/JCob9zIP/+jy39ZYKdagzbbcyFgT/kkfn42Vk2O27/UuK+frVH690K7TbRNqr+xT18qDELG/8QySPZls1AzkXvZrhn9qQrXGImnSI9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:57542)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u8L2t-005RKo-PB; Fri, 25 Apr 2025 09:32:55 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:54234 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u8L2s-00D2H5-Ki; Fri, 25 Apr 2025 09:32:55 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,  Parav Pandit <parav@nvidia.com>,
  "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
  "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,  Leon Romanovsky
 <leonro@nvidia.com>
References: <CY8PR12MB71955B492640B228145DB9CFDCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250423144649.GA1743270@nvidia.com>
	<87msc6khn7.fsf@email.froward.int.ebiederm.org>
	<CY8PR12MB71955CC99FD7D12E3774BA54DCBA2@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250423164545.GM1648741@nvidia.com>
	<CY8PR12MB7195D5ED46D8E920A5281393DC852@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250424141347.GS1648741@nvidia.com>
	<CY8PR12MB7195F2A210D670E07EC14DE9DC842@CY8PR12MB7195.namprd12.prod.outlook.com>
	<20250425132930.GB1804142@nvidia.com>
	<20250425140144.GB610516@mail.hallyn.com>
	<20250425142429.GC1804142@nvidia.com>
Date: Fri, 25 Apr 2025 10:32:27 -0500
In-Reply-To: <20250425142429.GC1804142@nvidia.com> (Jason Gunthorpe's message
	of "Fri, 25 Apr 2025 11:24:29 -0300")
Message-ID: <87h62ci7ec.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1u8L2s-00D2H5-Ki;;;mid=<87h62ci7ec.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/4nUbK0t+/c99EFTBcvEOCfWD1wSA3Z/w=
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4995]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jason Gunthorpe <jgg@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 495 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 11 (2.1%), b_tie_ro: 9 (1.9%), parse: 1.38 (0.3%),
	 extract_message_metadata: 17 (3.5%), get_uri_detail_list: 2.5 (0.5%),
	tests_pri_-2000: 22 (4.5%), tests_pri_-1000: 3.5 (0.7%),
	tests_pri_-950: 1.65 (0.3%), tests_pri_-900: 1.32 (0.3%),
	tests_pri_-90: 170 (34.4%), check_bayes: 169 (34.0%), b_tokenize: 11
	(2.3%), b_tok_get_all: 8 (1.6%), b_comp_prob: 3.5 (0.7%),
	b_tok_touch_all: 142 (28.7%), b_finish: 0.84 (0.2%), tests_pri_0: 251
	(50.6%), check_dkim_signature: 0.50 (0.1%), check_dkim_adsp: 2.3
	(0.5%), poll_dns_idle: 0.51 (0.1%), tests_pri_10: 2.4 (0.5%),
	tests_pri_500: 9 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
X-SA-Exim-Connect-IP: 166.70.13.52
X-SA-Exim-Rcpt-To: leonro@nvidia.com, linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, parav@nvidia.com, serge@hallyn.com, jgg@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out02.mta.xmission.com); SAEximRunCond expanded to false

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Fri, Apr 25, 2025 at 09:01:44AM -0500, Serge E. Hallyn wrote:
>> On Fri, Apr 25, 2025 at 10:29:30AM -0300, Jason Gunthorpe wrote:
>> > On Fri, Apr 25, 2025 at 01:14:35PM +0000, Parav Pandit wrote:
>> > 
>> > > 1. In uobject creation syscall, I will add the check current->nsproxy->net->user_ns capability using ns_capable().
>> > > And we don't hold any reference for user ns.
>> > 
>> > This is the thing that makes my head ache.. Is that really the right
>> > way to get the user_ns of current? Is it possible that current has
>> > multiple user_ns's? We are picking nsproxy because ib_dev has a net
>> > namespace affiliation?
>> 
>> It's not that "current has multiple user_ns's", it's that the various
>> resources, including other namespaces, which current has or belongs
>> to have associated namespaces.
>
> That seems like splitting nits. Can I do current->XXX->user_ns and get
> different answers? Sounds like yes?

Totally.

current->cred->user_ns (aka current_user_ns) is the what the process
has.


Everything else is what some resource XXX has as it's user_ns.  We could
have made the resources have a uid and gid or even a full struct cred
for their access permissions but when all you want are capability checks
anything more than a struct user_ns pointer is overkill.

But it isn't nits.  It is like files:
AKA current->mnt_ns->mnt_root->d_inode->i_uid doesn't have to
be related to current->cred->uid either.

The reason current shows up so much is that there is a principle of
relativity involved where things that show up are relative to which
process is looking.  Because different processes have different
namespaces.

The relativity and everything else predates user namespaces.  User
namespaces just drags credentials into it all.

>> current_user_ns() is the user namespace to which current belongs.
>> But if you want to check if it can have privilege over a resource,
>> you have to check whether current has ns_capable(resource->userns, CAP_X).
>
> So what is the resource here?
>
> It is definitely not the file descriptor.
>
> Is it the kernel's struct ib_device? It has a netns that is captured
> at its creation time.

Yes.  Very much so.

To relax the permissions for access the change would need to be:
capable(CAP_NET_XXX)  -> ns_capable(ib_device->net->user_ns, CAP_NET_XXX)

Eric


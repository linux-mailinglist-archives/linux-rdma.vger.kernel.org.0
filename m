Return-Path: <linux-rdma+bounces-9913-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 164CCAA00FB
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 05:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734E916DA25
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 03:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F832690CB;
	Tue, 29 Apr 2025 03:57:02 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0718D1876;
	Tue, 29 Apr 2025 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745899022; cv=none; b=CaoZYvcfYdmPhVGjsTG6xvSdqisUvn0+klXgO43GGQT+T47gzHeLbvFNBRGPKlqH4WCaf+VEBNSjuRlO5Bw6+Emv96qAYV2Q5WAKuV7vpRokpld0D8kU9LMnxf1R5zQ3Fc918oOwfLpiVSrRZiZYirnZsU/SNY5GDyZcnPK/5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745899022; c=relaxed/simple;
	bh=cFOMsBbwPSi3Bt1oRuZIcKi6mL3Xo1RJgbuK0xItMVQ=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=aPKoJChA3P9CvIlmhQShrN+ZGsoJ/pqcvmPkXDbA+JsWTcfbc/xM5j4saT9bK54JpzmokJU7+Q8Tg5TWfKLsVgpJBOLDj5F2sxd+QLF7SILs5efbELIN/xKZcfQP+DFx6CPJ/Hf3ziSS/uICVCQ1jyyiRt1IfbyrRUDEx0vO/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:51682)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u9c5b-000VC8-56; Mon, 28 Apr 2025 21:56:59 -0600
Received: from ip72-198-198-28.om.om.cox.net ([72.198.198.28]:48562 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1u9c5a-008svE-8b; Mon, 28 Apr 2025 21:56:58 -0600
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
	<87tt68cj64.fsf@email.froward.int.ebiederm.org>
Date: Mon, 28 Apr 2025 22:56:13 -0500
In-Reply-To: <87tt68cj64.fsf@email.froward.int.ebiederm.org> (Eric
	W. Biederman's message of "Mon, 28 Apr 2025 12:03:47 -0500")
Message-ID: <87ikmnd3j6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1u9c5a-008svE-8b;;;mid=<87ikmnd3j6.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.28;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18uH2pqgq6DvUjlbTsrqa8HDrUvJgshvvY=
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4996]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jason Gunthorpe <jgg@nvidia.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 390 ms - load_scoreonly_sql: 0.05 (0.0%),
	signal_user_changed: 4.7 (1.2%), b_tie_ro: 3.3 (0.8%), parse: 1.09
	(0.3%), extract_message_metadata: 14 (3.6%), get_uri_detail_list: 1.05
	(0.3%), tests_pri_-2000: 20 (5.2%), tests_pri_-1000: 1.87 (0.5%),
	tests_pri_-950: 0.98 (0.3%), tests_pri_-900: 0.79 (0.2%),
	tests_pri_-90: 50 (12.9%), check_bayes: 49 (12.6%), b_tokenize: 3.9
	(1.0%), b_tok_get_all: 5.0 (1.3%), b_comp_prob: 1.17 (0.3%),
	b_tok_touch_all: 37 (9.4%), b_finish: 0.70 (0.2%), tests_pri_0: 282
	(72.4%), check_dkim_signature: 0.38 (0.1%), check_dkim_adsp: 3.8
	(1.0%), poll_dns_idle: 2.4 (0.6%), tests_pri_10: 2.7 (0.7%),
	tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] RDMA/uverbs: Consider capability of the process that
 opens the file
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: leonro@nvidia.com, linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org, parav@nvidia.com, serge@hallyn.com, jgg@nvidia.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> Jason Gunthorpe <jgg@nvidia.com> writes:
>

>> It sounds like we just totally ignore current->cred->user_ns from the
>> rdma subsystem perspective?
>
> Since you don't allow anything currently to happen in a user namespace
> that is completely reasonable.
>
> Once ns_capable checks start being added that changes.

My apologies I misspoke.

Where infiniband currently uses current->cred->user_ns is in calls to
"capable()".

That will continue if those calls are relaxed to "ns_capable()".

All of which makes sense fundamentally because the only place it
really makes sense to look at the credentials of a process is in
the permission checks.

Eric




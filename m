Return-Path: <linux-rdma+bounces-20467-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF3YBhbqAmpKygEAu9opvQ
	(envelope-from <linux-rdma+bounces-20467-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 10:51:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90FD51D0A8
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E8CB3021B8B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2342B3947B8;
	Tue, 12 May 2026 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpVwbLMw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54961392829;
	Tue, 12 May 2026 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575885; cv=none; b=AfEthh0db28xeLBHK1oYREWvwB66jBjyakufVFh8GtXR0+Mi8cjgEwkd2vzwtfOvMtbGfOG6U3Nw7cH6VQokxEiraOii900lSV72kAmdshQ9jh1zhQrWYTLhZ4/NUMeC+poF0YNXlglq4IdukrDPB+PKxMqjmn0Zgl7WELeBeoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575885; c=relaxed/simple;
	bh=Wt32r9HqTnmChyHNUvyBHP0cnR5+BSMvmBHSczvrJoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StqXp7FxXpFY0/LnprFnqSDphyOiPAOkuXqY6GnoZQ86Ct5xu1VmqM93r4FqM2VdT1CK86WzpNEzv6HJ7PX9wDQZB1hHHJe2Qq2u4SHZJp60WRyOq/x1dQ2xiaOQLSuckz+WGQUFx4sIeWy/I/BJ0dgSqfsdO9sjWeiVS33TEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpVwbLMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B5CC2BCB0;
	Tue, 12 May 2026 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778575884;
	bh=Wt32r9HqTnmChyHNUvyBHP0cnR5+BSMvmBHSczvrJoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpVwbLMwNfdLpdSY7fNpWhpdW/X5XTGl0Oeb8wUNbwBSpkUthjBoWYQeNh48cWMZ5
	 goDoE0i3QnfiRzR+2MJq6c0MQIWWK3xM7ROSMekRm12lBmvaXyE43pZih47ptZ9R+S
	 PDdULsdVV7kwx9lNWNz5zMgwdTBQHdY/5cmqr1BjPvxXIiMDyqNd/Mq1PXlbAx0MfV
	 Mk6uHGyhGluXCTdftSM1NPR5c7VN+aW/QekePdpHiEHsmHReAbVmshmE/Jj5WmkffZ
	 rxnDddH520MD51johZ9H444ms3wVVgMAIy039yiMXyqYoznak8DKUlwQJieJM4ablg
	 tUzJyKrgr7+5w==
Date: Tue, 12 May 2026 11:51:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Firmware LSM hook
Message-ID: <20260512085118.GP15586@unreal>
References: <20260413231920.GS3694781@ziepe.ca>
 <CAHC9VhTLamfe4C81ZNRVT=H32x+KLxSqH3o0eBfrHsWAgAqxCA@mail.gmail.com>
 <20260415134705.GG2577880@ziepe.ca>
 <CAHC9VhSECYihup=tURo_Qk__xUdYYPkHgnz5CWA0BrRAkvwbog@mail.gmail.com>
 <20260417191749.GK2577880@ziepe.ca>
 <CAHC9VhQbpS9XpO6dWu7gOiX=ppjtAxnNBOFe6s5wjEZNpMRjgw@mail.gmail.com>
 <20260424143603.GB3611611@ziepe.ca>
 <CAHC9VhR++21SD+v4Bb16SQmYHgJYZ0ytQ+BecGPNK+fEOe4G7g@mail.gmail.com>
 <20260424221310.GA804026@ziepe.ca>
 <CAHC9VhTsx6cpKMP8nVgK4F=drXTFJtK3_D9k9pmKr56+ZFUu9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTsx6cpKMP8nVgK4F=drXTFJtK3_D9k9pmKr56+ZFUu9w@mail.gmail.com>
X-Rspamd-Queue-Id: A90FD51D0A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20467-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ziepe.ca,huaweicloud.com,kernel.org,google.com,iogearbox.net,gmail.com,linux.dev,fomichev.me,nvidia.com,intel.com,huawei.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:email]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 06:33:45PM -0400, Paul Moore wrote:
> On Fri, Apr 24, 2026 at 6:13 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > ... I wonder if we are even speaking the same language.
> 
> Let's reset the conversation.
> 
> As I understand it, based on our discussion in this thread and Leon's
> previous patchsets, the basic idea is to enable LSMs to enforce access
> control over fwctl requests/commands sent from userspace.  I'm going
> to start with that as a basis.

Yes, we proposed two users: FWCTL and RDMA DevX. Both are relevant, but
FWCTL is the higher priority.

> 
> Using the kernel's docs on fwctl, the userspace API appears to consist
> mostly of ioctls with some basic sysfs interfaces.  It looks like we
> can mostly ignore the sysfs interface and focus on the ioctl side of
> the API, do you agree?

Yes, all FW commands are routed through ioctls.

> 
> https://docs.kernel.org/userspace-api/fwctl/fwctl.html
> 
> While normally I would suggest simply using the existing
> security_file_ioctl() hook, Leon previously mentioned that the hook is
> too early for fwctl as the userspace copy happens much later.

I talked about general verbs interface in RDMA.

Thanks


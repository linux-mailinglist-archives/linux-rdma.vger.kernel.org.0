Return-Path: <linux-rdma+bounces-20032-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAPFKEkx+mlXKgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20032-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 20:04:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7674D278F
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 20:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DB6C307A8AC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC9C3B3C12;
	Tue,  5 May 2026 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zr5Jg4zo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF36175A6E;
	Tue,  5 May 2026 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004261; cv=none; b=UUnJ/5JM6YTDeqGgn83UTGnHC4Mt26YvVgITj8idibqoNgHNz/d1ZVDeAdtCMkw+SvUG6Iqy6QnAuRFY/MC+ENmohLvcnS8zaf5ec2EvHnppPi4QOba/+QmFB3f93RFckCi6Vqv6q9RKP2FLXlSe889uDe+XU7HYOdQbyZDYJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004261; c=relaxed/simple;
	bh=3mTZeVHSefVi+AiG2PyL7wAb7XbmEcO8m7IKhqMY1r8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pr9Z2Oy+XZnr8NRac/vUMRV0VuYTR6lhutWQ2cRA56MkeL4xMC28p6q3FBBgeFVtX2e/LD71boaxI2cBgitT6VJ59CJtRY23AqGI08xs/miPijsTBs6s3ThLinzjzvEB41vyjThY9ajIci/74/1srrMS09tNMPr9zF2WbZA6NZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zr5Jg4zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3136DC2BCC7;
	Tue,  5 May 2026 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778004261;
	bh=3mTZeVHSefVi+AiG2PyL7wAb7XbmEcO8m7IKhqMY1r8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Zr5Jg4zooK8XnA3PV9HZhiQViUqWpFwcI4KCCnnJhm2YVonatAeLEBpS9c4DLe1gq
	 PNx6jCZCk7DinGT82V3EFyR0kf7bj+tmtzLOqX3iSMFreW96JeU4FqI/biDgY0a5IC
	 laMkoBUFgPXEQ3Wb8H1/8aGGrS1Ki8Y2FZUcpOXvvsRKFYsI6dvieS55vDU3XlcZd7
	 BBzZwID6kevpt0BWkbt99FJUsCqnyW8fgqreRjWokAPuZjtK57ONMtBlVCTSqHhpAC
	 59PsuFZVEvjC718Tp3RsfvZuU9TjFnVIygDrzftgT9JGexV+wNKhAcZ0t11kW+iJEd
	 ykBywTuyOf+Cw==
Message-ID: <51fb70c0db4d2d065aac18729ee1d4862e9637fc.camel@kernel.org>
Subject: Re: [PATCH net 1/1] net/rds: handle zerocopy send cleanup before
 the message is queued
From: Allison Henderson <achender@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org,  santosh.shilimkar@oracle.com,
 sowmini.varadhan@oracle.com, willemb@google.com,  yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
 lx24@stu.ynu.edu.cn, tonanli66@gmail.com, Ren Wei <n05ec@lzu.edu.cn>, 
 netdev@vger.kernel.org
Date: Tue, 05 May 2026 11:04:19 -0700
In-Reply-To: <673288e7-37ac-4533-a4d3-2fa87dc282f1@redhat.com>
References: <cover.1777550074.git.tonanli66@gmail.com>
	 <d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1777550074.git.tonanli66@gmail.com>
	 <87f79bc7483aa1a7b3a44718b62a5cd5bd016f8c.camel@kernel.org>
	 <673288e7-37ac-4533-a4d3-2fa87dc282f1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: EF7674D278F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[ynu.edu.cn:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,oracle.com,gmail.com,lzu.edu.cn,stu.ynu.edu.cn,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20032-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[18];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_SPAM(0.00)[0.433];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 2026-05-05 at 15:32 +0200, Paolo Abeni wrote:
> On 5/1/26 9:40 PM, Allison Henderson wrote:
> > On Fri, 2026-05-01 at 09:08 +0800, Ren Wei wrote:
> > > From: Nan Li <tonanli66@gmail.com>
> > >=20
> > > A zerocopy send can fail after user pages have been pinned but before
> > > the message is attached to the sending socket.
> > >=20
> > > The purge path currently infers zerocopy state from rm->m_rs, so an
> > > unqueued message can be cleaned up as if it owned normal payload page=
s.
> > > However, zerocopy ownership is really determined by the presence of
> > > op_mmp_znotifier, regardless of whether the message has reached the
> > > socket queue.
> > >=20
> > > Capture op_mmp_znotifier up front in rds_message_purge() and use it a=
s
> > > the cleanup discriminator. If the message is already associated with =
a
> > > socket, keep the existing completion path. Otherwise, drop the pinned
> > > page accounting directly and release the notifier before putting the
> > > payload pages.
> > >=20
> > > This keeps early send failure cleanup consistent with the zerocopy
> > > lifetime rules without changing the normal queued completion path.
> > >=20
> > > Fixes: 0cebaccef3ac ("rds: zerocopy Tx support.")
> > > Cc: stable@kernel.org
> > > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > > Co-developed-by: Xiao Liu <lx24@stu.ynu.edu.cn>
> > > Signed-off-by: Xiao Liu <lx24@stu.ynu.edu.cn>
> > > Signed-off-by: Nan Li <tonanli66@gmail.com>
> > > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> >=20
> > This fix looks fine to me.  Thanks Ren Wei!
> > Reviewed-by: Allison Henderson <achender@kernel.org>
>=20
> Note that sashiko spotted more pre-existing problems in this area,
> please have a look:
>=20
> https://sashiko.dev/#/patchset/d2ea98a6313d5467bac00f7c9fef8c7acddb9258.1=
777550074.git.tonanli66%40gmail.com
>=20
> /P
Thanks for pointing this out.  It looks like a valid catch, I will see if I=
 can get a fix out today or tomorrow. =20

Thank you!
Allison

>=20



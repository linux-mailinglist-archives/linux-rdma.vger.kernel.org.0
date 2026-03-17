Return-Path: <linux-rdma+bounces-18251-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIdmKCtWuWnYAgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18251-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 14:24:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CDD2AACE3
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 14:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2EEE30451D2
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927013CB2E0;
	Tue, 17 Mar 2026 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cefOBNmt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D423CCFD4
	for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2026 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753781; cv=none; b=cSnHJUSvm26QzEaJzJvY8ihZ/f++kfejsboi37gbDRd2PlsNE0jWt1QdV3ncy9qVyWNvscUeXniL4mfrBuRg60QyzuawWKbdpM4u4FJmc/z2niqzQ2zdQ5oUoMw7XW6yvtntZq+7l0URES4iaGJ6qvFfzQeAgR+csSFcH7cmY8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753781; c=relaxed/simple;
	bh=EeLvoF12ulMH2JO1hHmV2Dh/zaxLH/OrSTLr8LwYgLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3es58EEkzldam++0h9fvLijvc3kkiJ8zDPPqB/+YO3BzHEL2O8K1vX3AJarCmkT+WTuE9ORT9zHArd7oW0eWmbOxH9cN+NamvT48dSL0OpL/uIrKLnI6Qo77gxlEDHJhFulFqLYfPzCXg/mkEnyk52xV6vWoTfr7vx2/CqH/3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cefOBNmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E62C4CEF7;
	Tue, 17 Mar 2026 13:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773753780;
	bh=EeLvoF12ulMH2JO1hHmV2Dh/zaxLH/OrSTLr8LwYgLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cefOBNmth9EdHNR/V1uhIcyeRXggQBAlY85Tn/apTRjbqhbs24yWL1fshFx3jN+dK
	 RjWfTEfN+y9hXgdbb3/7xiVKQdl/EDWF0q1T5TsfblvStWFcqAZDdypBJhLse13JPQ
	 bSwYABsa5HsFOZ01CpFvEVHkM35CkqC1NEfSyizOtKg+ggjPOWj060SVXISfMnDhre
	 LYkzbdb15dH2FRN+2wUS/Dmh/LEnOFmQccbvU51zcIweKjKVruPuij3gJEdkkOuK1d
	 uwNChaVwfhv6Kxb7rCQFebRbUYp3WwqjBKyYbBDdQSwg+gWDVMXqfC5vMaVZYmvoJV
	 8jFUttx/CRJTA==
Date: Tue, 17 Mar 2026 15:22:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Czurylo, Krzysztof" <krzysztof.czurylo@intel.com>
Cc: "jgg@nvidia.com" <jgg@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Subject: Re: [for-next 02/12] RDMA/irdma: Fix data race on
 cqp_request->request_done
Message-ID: <20260317132253.GX61385@unreal>
References: <20260316183949.261-1-tatyana.e.nikolova@intel.com>
 <20260316183949.261-3-tatyana.e.nikolova@intel.com>
 <20260317111230.GW61385@unreal>
 <DS0PR11MB7736961A569FE56FDB09631EEB41A@DS0PR11MB7736.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR11MB7736961A569FE56FDB09631EEB41A@DS0PR11MB7736.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18251-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,intel.com:email]
X-Rspamd-Queue-Id: 47CDD2AACE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 12:14:21PM +0000, Czurylo, Krzysztof wrote:
> 
> 
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: 17 March, 2026 12:13
> > To: Nikolova, Tatyana E <tatyana.e.nikolova@intel.com>
> > Cc: jgg@nvidia.com; linux-rdma@vger.kernel.org; Czurylo, Krzysztof
> > <krzysztof.czurylo@intel.com>
> > Subject: Re: [for-next 02/12] RDMA/irdma: Fix data race on cqp_request-
> > >request_done
> > 
> > On Mon, Mar 16, 2026 at 01:39:39PM -0500, Tatyana Nikolova wrote:
> > > From: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> > >
> > > Changes type of request_done flag from bool to atomic_t to fix
> > > data race in irdma_complete_cqp_request / irdma_wait_event
> > > reported by KCSAN:
> > 
> > Again, this fix is wrong too.
> 
> Could you please elaborate on what is wrong with this fix?
> And/or suggest how to fix it properly?
> 
> Please note 'request_done' is _not_ a bitfield and we only do simple
> load/store operations on it.  There is no RMW.
> Despite this, KCSAN still reports a data race on it.
> 
> Honestly, the original idea was just to change the type from
> 'bool' to 'u8'.  This is enough to silence KCSAN, but it is
> not clear why.  Perhaps it indicates a bug in KCSAN?

Yes, both u8 and atomic_t behave the same, they can't be interrupted
during read/write. This is why KCSAN doesn't warn you.

> I mean, maybe the report below is a false positive?

Sounds like that.

> 
> Thanks
> 
> > 
> > Thanks
> > 
> > >
> > > BUG: KCSAN: data-race in irdma_complete_cqp_request [irdma] /
> > irdma_wait_event [irdma]
> > >
> > > write (marked) to 0xffffa0bef390ad5c of 1 bytes by task 7761 on cpu 0:
> > >  irdma_complete_cqp_request+0x19/0x90 [irdma]
> > >  irdma_cqp_ce_handler+0x22d/0x290 [irdma]
> > >  cqp_compl_worker+0x1f/0x30 [irdma]
> > >  process_one_work+0x3dc/0x7c0
> > >  worker_thread+0xa6/0x6c0
> > >  kthread+0x17f/0x1c0
> > >  ret_from_fork+0x2c/0x50
> > >
> > > read to 0xffffa0bef390ad5c of 1 bytes by task 28566 on cpu 3:
> > >  irdma_wait_event+0x242/0x390 [irdma]
> > >  irdma_handle_cqp_op+0x93/0x210 [irdma]
> > >  irdma_hw_modify_qp+0xe3/0x2f0 [irdma]
> > >  irdma_modify_qp_roce+0x13df/0x1630 [irdma]
> > >  ib_security_modify_qp+0x34a/0x640 [ib_core]
> > >  _ib_modify_qp+0x16b/0x620 [ib_core]
> > >  ib_modify_qp_with_udata+0x3c/0x50 [ib_core]
> > >  modify_qp+0x6e1/0x920 [ib_uverbs]
> > >  ib_uverbs_ex_modify_qp+0xa6/0xf0 [ib_uverbs]
> > >  ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x16c/0x200 [ib_uverbs]
> > >  ib_uverbs_run_method+0x342/0x380 [ib_uverbs]
> > >  ib_uverbs_cmd_verbs+0x365/0x440 [ib_uverbs]
> > >  ib_uverbs_ioctl+0x111/0x190 [ib_uverbs]
> > >  __x64_sys_ioctl+0xc3/0x100
> > >  do_syscall_64+0x3f/0x90
> > >  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> > >
> > > value changed: 0x00 -> 0x01
> > >
> > > Fixes: f0842bb3d388 ("RDMA/irdma: Fix data race on CQP request done")
> > > Signed-off-by: Krzysztof Czurylo <krzysztof.czurylo@intel.com>
> > > Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> > > ---
> > >  drivers/infiniband/hw/irdma/hw.c    | 2 +-
> > >  drivers/infiniband/hw/irdma/main.h  | 2 +-
> > >  drivers/infiniband/hw/irdma/utils.c | 6 +++---
> > >  3 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/irdma/hw.c
> > b/drivers/infiniband/hw/irdma/hw.c
> > > index 6e0466ce83d1..3ba4809bc1ef 100644
> > > --- a/drivers/infiniband/hw/irdma/hw.c
> > > +++ b/drivers/infiniband/hw/irdma/hw.c
> > > @@ -235,7 +235,7 @@ static void irdma_complete_cqp_request(struct
> > irdma_cqp *cqp,
> > >  				       struct irdma_cqp_request *cqp_request)
> > >  {
> > >  	if (cqp_request->waiting) {
> > > -		WRITE_ONCE(cqp_request->request_done, true);
> > > +		atomic_set(&cqp_request->request_done, true);
> > >  		wake_up(&cqp_request->waitq);
> > >  	} else if (cqp_request->callback_fcn) {
> > >  		cqp_request->callback_fcn(cqp_request);
> > > diff --git a/drivers/infiniband/hw/irdma/main.h
> > b/drivers/infiniband/hw/irdma/main.h
> > > index 3d49bd57bae7..e22160e2ba33 100644
> > > --- a/drivers/infiniband/hw/irdma/main.h
> > > +++ b/drivers/infiniband/hw/irdma/main.h
> > > @@ -167,7 +167,7 @@ struct irdma_cqp_request {
> > >  	void (*callback_fcn)(struct irdma_cqp_request *cqp_request);
> > >  	void *param;
> > >  	struct irdma_cqp_compl_info compl_info;
> > > -	bool request_done; /* READ/WRITE_ONCE macros operate on it */
> > > +	atomic_t request_done;
> > >  	bool waiting:1;
> > >  	bool dynamic:1;
> > >  	bool pending:1;
> > > diff --git a/drivers/infiniband/hw/irdma/utils.c
> > b/drivers/infiniband/hw/irdma/utils.c
> > > index ab8c5284d4be..f9c99c216a2c 100644
> > > --- a/drivers/infiniband/hw/irdma/utils.c
> > > +++ b/drivers/infiniband/hw/irdma/utils.c
> > > @@ -480,7 +480,7 @@ void irdma_free_cqp_request(struct irdma_cqp *cqp,
> > >  	if (cqp_request->dynamic) {
> > >  		kfree(cqp_request);
> > >  	} else {
> > > -		WRITE_ONCE(cqp_request->request_done, false);
> > > +		atomic_set(&cqp_request->request_done, false);
> > >  		cqp_request->callback_fcn = NULL;
> > >  		cqp_request->waiting = false;
> > >  		cqp_request->pending = false;
> > > @@ -515,7 +515,7 @@ irdma_free_pending_cqp_request(struct irdma_cqp
> > *cqp,
> > >  {
> > >  	if (cqp_request->waiting) {
> > >  		cqp_request->compl_info.error = true;
> > > -		WRITE_ONCE(cqp_request->request_done, true);
> > > +		atomic_set(&cqp_request->request_done, true);
> > >  		wake_up(&cqp_request->waitq);
> > >  	}
> > >  	wait_event_timeout(cqp->remove_wq,
> > > @@ -610,7 +610,7 @@ static int irdma_wait_event(struct irdma_pci_f *rf,
> > >  	do {
> > >  		irdma_cqp_ce_handler(rf, &rf->ccq.sc_cq);
> > >  		if (wait_event_timeout(cqp_request->waitq,
> > > -				       READ_ONCE(cqp_request->request_done),
> > > +				       atomic_read(&cqp_request->request_done),
> > >  				       msecs_to_jiffies(CQP_COMPL_WAIT_TIME_MS)))
> > >  			break;
> > >
> > > --
> > > 2.31.1
> > >
> 


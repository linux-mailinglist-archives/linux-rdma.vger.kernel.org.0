Return-Path: <linux-rdma+bounces-22766-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6B56FshKSmpBBAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22766-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 14:15:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9212F709ED0
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Jul 2026 14:15:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Vos4l4Ix;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22766-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22766-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C895300CE61
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Jul 2026 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1E9378D82;
	Sun,  5 Jul 2026 12:15:01 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724327081F
	for <linux-rdma@vger.kernel.org>; Sun,  5 Jul 2026 12:15:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783253701; cv=none; b=f5SPByJBg9tQngazJWu4KBbFkX/db5j93Tugmc+aonVwKaBo3/Kkm5wscye9GMD51CXGJz6Lo7ARnsaOPuv35IWSn1m5NHEAV2ikhk/xTBqc531dCpQ0B1nZWINKMd00Qa52QsVIjN529WlKISxxBRMUh2OD2VJe5BT8tuxQ5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783253701; c=relaxed/simple;
	bh=eiGr/AcWWsU/A+qVKXXvT0Tlt8E7uI5/CCZD04NlAUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o29ZF4iCzxzD1wPIoLxGqf1JC2IqwdHywryyRhzyr04SA34oRIfcwsbfEaf1kWQenvwXpog6BwVOgVozBwH04awyRZSJ41SBbI6/odXCBsu466WcPE/xeYlX3H/eihb8S/wZTts22unuontwB1f33Fhs+1ChD74ffpAATH0KYZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vos4l4Ix; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8371F000E9;
	Sun,  5 Jul 2026 12:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783253700;
	bh=daDkV+w1kUVhn8pZgny8ODdXR+j5mMfcB9XrjXtRXFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vos4l4Ix0iiO2ikR/sDEU2XjMii56bkdXRKSkjz0IKCBjV0hga4Ut1f3BJDcn0fK/
	 TfUtAdVslPiqEMoIk9KUExzRRz2Dfge6wds8WMsxdvn9odfrAYPWAFrx6BBN1QPpM9
	 k+gcf+AcnB4F0inKDt4irhUNCqPCt+aeJsLtQOe2rESoewz1HUj8hp7u3yJA/vOGkE
	 /LL+vTu8G6tfMvk3EIgNeF+gDDkWxoKdyKfW4TqmPLVlJ53yFPJMZrUi58Rp4Stb1C
	 UNH20FCSIjb30ujUZa4sziGc3qyFFqb60USD+IJikfqgNPk2zK+sigtwgMc3q7JYze
	 eD1AmEtEpcbQQ==
Date: Sun, 5 Jul 2026 15:14:54 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jacob Moroni <jmoroni@google.com>, jgg@ziepe.ca
Cc: tatyana.e.nikolova@intel.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 3/5] RDMA/irdma: Use ib_respond_empty_udata
 where applicable
Message-ID: <20260705121454.GC15188@unreal>
References: <20260627025642.4064973-1-jmoroni@google.com>
 <20260627025642.4064973-4-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627025642.4064973-4-jmoroni@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22766-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jmoroni@google.com,m:jgg@ziepe.ca,m:tatyana.e.nikolova@intel.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9212F709ED0

On Sat, Jun 27, 2026 at 02:56:40AM +0000, Jacob Moroni wrote:
> Methods that do not provide any user response should use
> the ib_respond_empty_udata() helper to ensure that user
> response buffers are cleared.
> 
> Signed-off-by: Jacob Moroni <jmoroni@google.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
> index 19dcc475c355..d06df520d9be 100644
> --- a/drivers/infiniband/hw/irdma/verbs.c
> +++ b/drivers/infiniband/hw/irdma/verbs.c
> @@ -457,7 +457,7 @@ static int irdma_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
>  
>  	irdma_free_rsrc(iwdev->rf, iwdev->rf->allocated_pds, iwpd->sc_pd.pd_id);
>  
> -	return 0;
> +	return ib_respond_empty_udata(udata);

I wonder how this is supposed to work. What should the user do
after hitting this error? Retry the operation? The object has
already been deallocated.

Thanks.


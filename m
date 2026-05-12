Return-Path: <linux-rdma+bounces-20507-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL79AztuA2pS5wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20507-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:15:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8C852724B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7A3931821CF
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1125FA29;
	Tue, 12 May 2026 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GNNiitkp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51833D51A
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609026; cv=none; b=AW+Hk+gUmFl+egqEeT70XibS5lqXMW8SleuszsK2L3DZp3DytFyiJ8nZ3O7VoNMuMha4xehmhCdv1yi8KzHfevV1RGsGeIlQn59sH+pmJWykTOyOkBxtXrVwF68t1zYrnvCoAHP1qCf5lwPWWEx9+BguF2eh0npiUqWWdBeiNMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609026; c=relaxed/simple;
	bh=4H89997f5CleTxkJJvU1aIQvOXlA8jRXTnp7wsrwARk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mlg4nalQcNvhm/xJk652UXX4cZuwBI0Fvlhi5FJePBTm/amG/s2ifn1eVIjKbw5sjbMUtgK7uCP0Ex5OKK47gmZGkxDLbENWrqlPVQsgsL4Lprhm2L7vb6PV7berhI2lan9Nn4XkbKH0FHNgzDATbebbT8tmlEhGly2OopAl3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GNNiitkp; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-463f00cda04so3189990b6e.2
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778609023; x=1779213823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bXVpfXzT0jf/ZSOkmDiZcDjCT8XZgpZy6TPqRVEL8W8=;
        b=GNNiitkpAdQB/EgBBXiIf/6fRa+vQAqmUGuLWFc2F2j9QB6zntdQj4MktkFOt3Xk0V
         xkOp5udqyealdIJic5YtYQKDVuXAT9YZ7+a6V8WlvABWRUKs5gJW3z4SYg1vfUCiq24Y
         upgwXM+0tdgbt7m0h9Gqnu2NFz9y1A4xbeGnGpSulXQJ3p3xBCmawEHRaBS4SGScRG2O
         FqhWlKnaG73okgyFkeTLO9LuOwbAPAf+5r0VksU3Wd7yHX7vhCoeR1SZWsPaK7gk0EbO
         qxOjwVKWSLQc8FhZz9eg/XfXX9wnoa6poBnnJBOxaMQnQby2wkfwPZWX9yqtdE74pMIx
         UF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609023; x=1779213823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXVpfXzT0jf/ZSOkmDiZcDjCT8XZgpZy6TPqRVEL8W8=;
        b=Ymnx90Ph/u32nduJeQ/U+wYOCqnJzQ1BGm9OPbceyjCjEQSd0FyJQSDUSSD2gvIwRw
         yUJTqknYRwgmr0cvYA55Rydx/Hi68Rv/PL5RlrB6+d4+8A2kVwbFjjkZZzTktDRdEY3i
         Gd7PAgBaJiQm+4xSNN/T9vHDLjgmE/Im6FJdM209ESasvcChzgBDL3I1NQ9a2Dq/6Ayz
         efg171rOH/KDVupbZLnIJxIU5bnsFh8qJko6RM171ADdm9ibgmkTu/gvD0yDvqoTuxww
         j1cgzguX8qu3qbnFH98wRgd3BhcHKd3QgmLUdkFJDK24WS5vkOqrf/ja5WO8W296xjUW
         H82Q==
X-Gm-Message-State: AOJu0YzBT8gni3EMo6tDX6JzJbyeXIs38eGJfOyAZoeKN8JsjUprA9Ft
	4sbfKHbbXy8km7cUX/bwdYMomMOhFcQAsCUECrUGuM/uZRAOPUEkbhxafulFPX71rIM=
X-Gm-Gg: Acq92OGI0liWSY0aeuYrk8uXlSMmXErpHSqiNqGx1LBG34vrYHx4OPKuAWwHC5RlXNc
	jIIMTUU68m1J63eQbf5Sl/QdgGEjz04TTF9Rt66JKd7YooBhpJyQLwTNnN93FSHfmoczjw/eVER
	/r3oyUDlt0L7y9bTf5+TOmqyTq1BoSO2a2dDPZoCSyDLQWSvrxGZf3CRymiqE1AD1mhFvF00cVP
	nDgcrrxZGhwW4o5J+AzMOGCjp+UhRCigwFGkv+EiX7vu4KrSgDXeVCa727NY7Ha0zFrVWK8xhUe
	HdWxlaXAQZyVi7rnsVRUvn+nUU4/YD2ZyoYYjr3ZRoFwogigidy5heESRjc66xMmC15Idm4v3A7
	2g4ykvyriHzHED32BWP5mZw5w+Y7bVZ4KfSabnwPizYdv7iTvnvNHSMdXnhpd2jrhm9a/5kYTO9
	FPtsH88XESI9cYD/nGvaqGCvax8yOevzmaU8XWp7bo+jSt8rLpps0wbqyekJM+NBywNSqYcJB0F
	Y3oZg==
X-Received: by 2002:a05:6808:c14a:b0:479:72dc:bb6 with SMTP id 5614622812f47-482b2decfa2mr70445b6e.44.1778609023560;
        Tue, 12 May 2026 11:03:43 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e85bf27sm128561771cf.30.2026.05.12.11.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:03:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMrSI-00000000j33-0eDi;
	Tue, 12 May 2026 15:03:42 -0300
Date: Tue, 12 May 2026 15:03:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com,
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com,
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com,
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com,
	ynachum@amazon.com, huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com,
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v4 06/16] RDMA/uverbs: Push out CQ buffer umem
 processing into a helper
Message-ID: <20260512180342.GI7702@ziepe.ca>
References: <20260507125231.2950751-1-jiri@resnulli.us>
 <20260507125231.2950751-7-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507125231.2950751-7-jiri@resnulli.us>
X-Rspamd-Queue-Id: 6E8C852724B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20507-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 02:52:21PM +0200, Jiri Pirko wrote:

> +static int uverbs_create_cq_get_buffer_desc(struct uverbs_attr_bundle *attrs,
> +					    struct ib_uverbs_buffer_desc *desc)
> +{
> +	struct ib_device *ib_dev = attrs->context->device;
> +	int ret;
> +
> +	if (uverbs_attr_is_valid(attrs,
> UVERBS_ATTR_CREATE_CQ_BUFFER_VA)) {

I know this is just moving code, but I've always disliked this
function. I learned a trick using a case statement for this recently:

	u32 present_attrs = 0;
	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_VA))
		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_VA);
	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH))
		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH);
	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_FD))
		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_FD);
	if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET))
		present_attrs |= BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET);

	switch (present_attrs) {
	case 0:
		return -ENODATA;
	case BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_VA) |
		BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH):
[..]
		return 0;
	case BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_FD) |
		BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_OFFSET) |
		BIT(UVERBS_ATTR_CREATE_CQ_BUFFER_LENGTH):
[..]
		return 0;
	default:
		return -EINVAL;
	}

No need to build the complex tests to check in each branch if the
other branch attributes are presented.

Jason


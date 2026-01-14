Return-Path: <linux-rdma+bounces-15562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC14D20A36
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 18:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F7313020C6B
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 17:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215E32C924;
	Wed, 14 Jan 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XmVnMrq7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07332B99F
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 17:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412979; cv=none; b=qnRYKGBM/m1fDkTPKQ4rAhyHA7G43Zbz87SlXXPj/BlNMi+f91Ju7XF/sIyUpJWL9ugzSgVoXLKm+PENvU6iP6QZWbACpnkNoXMHVlvVi5mmmmTo3bUUgQB6glH3mmgcdmXRdMKcxNKtIHbcEhCAUj9y+mZnIcHNk1mCSbu9/ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412979; c=relaxed/simple;
	bh=iRfSXFGIDH+/5NwVXWN7AdcDXmYXyK7OrZtdqs5e9og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui+4m0GOI6atr4RREmdvXg4p9IC2u7oQ/ZNr2LrS0iU+SblMBZnNk7/4ZErOmfxB64uvgR/i47TYYPNCqO2voEbFjOqpwjd1EQicyyPAJiI/Qi6JrhgTHYSCMvmSl/UelcFwKVaEQbDCY4yGNzNMos/3YeSEiWfRrCv4vor6I30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XmVnMrq7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50143fe869fso508331cf.1
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 09:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768412973; x=1769017773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWgDwy0Q3bZkORG2Y73VLIlCK/FLw/swliFUf4mQVP0=;
        b=XmVnMrq7EyusXJwezfj8kSos92t8hGYvuL2L7TH1q1SidwY1iz0BSrWelM4/m5WY6S
         /1mV5LbxmSgzVH8TL77rWX7k6nxF3UBZSwr+x0xeRXWDmLmXCPi+xsl3G11cvHHstX7+
         fqiu37tPnwcq3Y6x/HntwlZbUvPO+sSXwykGyXReo5UwXZr9j1/Q2RvXDvVpwaflZi51
         xDC/0E60RWEKf+Jj54lODwKU9JQxF+dPwpv+sOuKNLbjJ5WjSf6AhVQSNvpa2CWVVuAe
         mR9dQidqIq8GOhSZa0a3KFyYOAnI7b3p73QFRSo7jQgvjUrKckS7JI/VNjdsSfrLlqXX
         5mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768412973; x=1769017773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWgDwy0Q3bZkORG2Y73VLIlCK/FLw/swliFUf4mQVP0=;
        b=Si1CSmKcBuqB0lC3aDFZgIvSlOtMBySev6H00bOfqH9LGtoqHEPbfaLnYALjp9t29u
         Jbb5sLiID+1/W6D6hvshoAJVvtIqBQWiDq9xdyouE9uGI0oE5OJHBJo3h+1zSK3rk3l7
         fuKUfp0761esEqHImj7fQy2cxIiyamFjLaOpHpBgb9W3TxRF07hT4HixzeoRyS/WSQbx
         /E4/tk7gjD+s6LQzj1Cby80KfHzVCP7rVfJPsylofa3PIyfjXWQBETK1Mb7hIHCgPj5J
         1tEQUbvB2xvgy6hYbhiTxe4K5GYBcuUSuYkp50/WdMFEbEwBYMsfvvfHI0L+29rFF2jn
         g9Og==
X-Forwarded-Encrypted: i=1; AJvYcCUISN/JVUqkddQrpFkeaAtSUCRBzVLw44HhbEyeEL3uJFLFf37YBOMSu6Ug652c5T5vaFaBxKOQ1FjM@vger.kernel.org
X-Gm-Message-State: AOJu0YzGIxzystGTelu9IIo0DJijfyvF1qChGBX3VvdqFTLnIag+oRUm
	cSbTY08ckWv6ifDNlb1Hfb3dwSSNolFKP+XxlsVXfoklrn0zQOJgSRNjDs2444uKS+w=
X-Gm-Gg: AY/fxX7I7o38QFRBD42O71+OKmG0zXFlZOSqmoeBJEqA+kMOdBI9gBodOT2hzheZqSZ
	5aKbNcb5VrxEe231/u+OH48qWBtllqXmwZ3u41pwDIlOJaPTV2m6Bn1Q3cvr88EeNL0kzTIO3Vq
	DOv7Q37iUYxdosLSmJIliROxRLV+OLU5VZEzRKXwsZvnlTzbJ4ju2uopjRsokTXqACuS7aq+HiR
	pLXlZR2mCXaGxDcpZlqC38W+GUK+Gs5J0jDjoSeloKhn+M7Xlxw4snTAerDSMin0v12EB6Pm40E
	JuIMyV4sTxE0mXY8FC1K140huEM8Q+Yu003kNLYtiTqA76x//7ARZN7b5gSi+jlo3dKlW7wYNNJ
	FeU0uJyHxc1YnqNMUzn8Gp0pyJVhfB825Dhv1xuggihyd0bsVs/92BoYudsOFlYIHpxlv1nYWrh
	hPlyk6FPq3MiFzfO7qYPhI3zqcOs3OBuoMkqwv+wnVXdwoflLWlDNcaIkz6/bS2gOHhMA=
X-Received: by 2002:ac8:5888:0:b0:4ec:f410:2470 with SMTP id d75a77b69052e-50148492671mr48314891cf.71.1768412972571;
        Wed, 14 Jan 2026 09:49:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148eba456sm17961751cf.20.2026.01.14.09.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:49:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vg4zr-00000004Fyg-1dVz;
	Wed, 14 Jan 2026 13:49:31 -0400
Date: Wed, 14 Jan 2026 13:49:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v7 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260114174931.GB961572@ziepe.ca>
References: <20260113170956.103779-1-sriharsha.basavapatna@broadcom.com>
 <20260113170956.103779-5-sriharsha.basavapatna@broadcom.com>
 <20260113173247.GT745888@ziepe.ca>
 <CAHHeUGWErNHmhFX13VHw3V6feswyV6JVzULegGoBNg+2x6O12w@mail.gmail.com>
 <20260113185957.GU745888@ziepe.ca>
 <CAHHeUGUgacV=t6pUJDX_orvxwzv4LEH_cnzyN61mCA-MMY7acA@mail.gmail.com>
 <20260114165909.GA961572@ziepe.ca>
 <CAHHeUGUuN+WBX5xKHH2MeS0XoRdDbZHDduDD_8aK=Tv8d12Zeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHHeUGUuN+WBX5xKHH2MeS0XoRdDbZHDduDD_8aK=Tv8d12Zeg@mail.gmail.com>

On Wed, Jan 14, 2026 at 11:14:30PM +0530, Sriharsha Basavapatna wrote:

> > Please don't pass object handles in structs, the attributes must be
> > used to pass these things. The driver can obtain the pointer with a
> > simple
> >
> >                         send_cq = uverbs_attr_get_obj(attrs,
> >                                         UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE);
> But there's no cmd buffer to fill this in as an attribute from the
> bnxt_re library, since it is using ibv_cmd_create_qp_ex().

??

DECLARE_UVERBS_NAMED_METHOD(
	UVERBS_METHOD_QP_CREATE,
	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_HANDLE,
			UVERBS_OBJECT_QP,
			UVERBS_ACCESS_NEW,
			UA_MANDATORY),
	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_XRCD_HANDLE,
			UVERBS_OBJECT_XRCD,
			UVERBS_ACCESS_READ,
			UA_OPTIONAL),
	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_PD_HANDLE,
			UVERBS_OBJECT_PD,
			UVERBS_ACCESS_READ,
			UA_OPTIONAL),
	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_SRQ_HANDLE,
			UVERBS_OBJECT_SRQ,
			UVERBS_ACCESS_READ,
			UA_OPTIONAL),
	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_SEND_CQ_HANDLE,
			UVERBS_OBJECT_CQ,
			UVERBS_ACCESS_READ,
			UA_OPTIONAL),
	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_QP_RECV_CQ_HANDL
[..]

DECLARE_UVERBS_NAMED_METHOD(
	UVERBS_METHOD_CQ_CREATE,
	UVERBS_ATTR_IDR(UVERBS_ATTR_CREATE_CQ_HANDLE,
			UVERBS_OBJECT_CQ,
			UVERBS_ACCESS_NEW,
			UA_MANDATORY),
	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_CQE,
			   UVERBS_ATTR_TYPE(u32),
			   UA_MANDATORY),
	UVERBS_ATTR_PTR_IN(UVERBS_ATTR_CREATE_CQ_USER_HANDLE,
			   UVERBS_ATTR_TYPE(u64),
			   UA_MANDATORY),
[..]

You can add a driver specific attribute using the mechanism:

ADD_UVERBS_ATTRIBUTES_SIMPLE(
        mlx5_ib_cq_create,
        UVERBS_OBJECT_CQ,
        UVERBS_METHOD_CQ_CREATE,
        UVERBS_ATTR_PTR_IN(
                MLX5_IB_ATTR_CREATE_CQ_UAR_INDEX,
                UVERBS_ATTR_TYPE(u32),
                UA_OPTIONAL));

const struct uapi_definition mlx5_ib_create_cq_defs[] = {
        UAPI_DEF_CHAIN_OBJ_TREE(UVERBS_OBJECT_CQ, &mlx5_ib_cq_create),
        {},

Shouldn't be a problem?

Jason


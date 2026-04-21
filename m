Return-Path: <linux-rdma+bounces-19451-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MiONdR652mZ9QEAu9opvQ
	(envelope-from <linux-rdma+bounces-19451-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 15:25:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275643B4D8
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9D5D300B45F
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Apr 2026 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035283A3E87;
	Tue, 21 Apr 2026 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pYRn6tiy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286AE1F5858
	for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777936; cv=none; b=U1b1FSqg9Zcq79Rl40PqPNMq1z4vK8LLEQffPl6JCJSoYUPhQHk2m7XRp9YA74fN/NH2+tu6Hq8OmDg7Zkk7qIt8eaTL28TpTYzyUIUm/9tW5fugpJxv23TFyKIcqB9k9OZ9Y5LoJUeaDs9nGRAV6+ebqgUSUdtEsklzEZOt26k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777936; c=relaxed/simple;
	bh=HFMaS4EVxN4dXsTaK+IAQN6qqlRuo5M4bvY1Ai7BQC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avivsbW5CF9Fl2x8oNU2FzAvph3XoV1vi1nYf5zO5quYW4MXT9uEXhc8stJs82bMAjnJqT4bIEGsLjzlMkbUdGKWRey1EeNhc9bZ5IAlxuXORN1OlZDhs/x9V6JLEeHfQaMrQ8fi++ldK6urWijwoNbzkAY6l2xAmYBIHSN0+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pYRn6tiy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50e614fdb42so18838931cf.3
        for <linux-rdma@vger.kernel.org>; Tue, 21 Apr 2026 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776777934; x=1777382734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVHNM3wywB+X9jjCcWjUgKOlkWg+UkGA1ew5VJwsorI=;
        b=pYRn6tiypQuAm8S2dAXDgtoyo6Gs8wDpJRd5uz82SULhrTkbBKLIIKQmtUdvt+h0SJ
         2HMuAPrGPTDaS0HE5zy/vm/t2LIWYJXOjO7ymfViGrg8kat7Cn0h5HDnGuq4aCz5CAHL
         NilLrw8WMk0+LrfzKOWMt9o9MVuFU3OFEhsxAdOD9T+7hKxDsq/Nx3jchtqzaQeU0r7e
         6K3VVZvQOvw4YPiRPrk117nR75mVi2iqlKEaOim8JyNevhA7+Vfbs8pYIwfY2t85h2lY
         0A37BW2m23po4mCbrBh6p6qwuhwwEzG9H0iBXOkV8w5dhtXRZ8oo9v0WuJZizJ28vO6l
         rNRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776777934; x=1777382734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVHNM3wywB+X9jjCcWjUgKOlkWg+UkGA1ew5VJwsorI=;
        b=TQdkoBuaYVZnz3yghyLwC3GQZPQsOAtPNIKNVFKIkLG7r1YZ2RMqQyneXBGGJ6bufb
         EdD/dvnj2T5Tm6UMJdfyLztGLcIY2MsxMEWyXh9qmlRu7Tics7FO50Al5q0lRZXzokkg
         EXgJzBln2t3QvfytjMAxY+PTVqCnYwVD/t59vIwBuQ8ORADelAtoi+9w06c01qAeSTFC
         N7O+r/M2AHgklFPOU2rTkienUZdm6J+HQN0MTwPgfCloN6jHJtnR40pZPC21hGW3nnNZ
         evM1MtPvBMGxjAhhDm8s+J0BjCyAZVp5AZLLMAV9DRGxk/PhPeqs9Fdo/YI6sERRNiJu
         +cGA==
X-Gm-Message-State: AOJu0Yw9uX0sDDEfLalgpu+nDFMRPpbxYDHS0Tapxn0iU+youSBylNJR
	SbvNjH8NLym3K4Q742tWgA44OYK7e7B21DqnnkyFXwoPb3JNIejNIdSsoG416o77T2I=
X-Gm-Gg: AeBDietOzmY02zCmf5a3fXEDMeE0NapIRM5kYF/oEotT56bVZi4ap/qsZQ4upAfldtY
	i7hteSLDyWmsz9bfaOC6HmiW9Q4Hp7PwKqiEKmS5MfhyWcoxWB3ND+R9fZwanjtUlnVRMI399Jl
	a8uxsU3cj726x5nH3HrTQFIOk7/wsND0Wyyh0YHcn1I4pzORwlwoHUVuz1Qllxc5g3QSqHCgTBj
	4E834yUmP1XTM+DML+n0tKjt38QGhwT6sqnbYFFqHb3c2+SC45U/Ti7okwl8LZmnLzHeFIRdZGR
	5+bWvR9YqE1mGkF5n+h45bEZhgfKBHLAK4qmAbCBpxneZtPo3SILcN28qrKYIn+MLF3SPRqaI3T
	cCjJQqO+K70bYhJzePwdsIxgg/cYtb8+WSxNyTxJGn4DK+Myy8gJPqo0yshbyvd0x2+gMU5E+MC
	hiqUmxithrbcYU2JG+mFlb+5jrJDQP9qlbZVkm2YZD9fpVHsf1jCVe6QFu01bdjYbWRpSf3bA0N
	okYToE4YpHCh4cw
X-Received: by 2002:a05:622a:4c18:b0:50d:7aa1:f405 with SMTP id d75a77b69052e-50e36b88d72mr262137991cf.9.1776777933910;
        Tue, 21 Apr 2026 06:25:33 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50fb80a5636sm9593731cf.6.2026.04.21.06.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:25:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFB6a-00000001aXY-2qu0;
	Tue, 21 Apr 2026 10:25:32 -0300
Date: Tue, 21 Apr 2026 10:25:32 -0300
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
Subject: Re: [PATCH rdma-next v2 02/15] RDMA/uverbs: Push out CQ buffer umem
 processing into a helper
Message-ID: <20260421132532.GA360923@ziepe.ca>
References: <20260411144915.114571-1-jiri@resnulli.us>
 <20260411144915.114571-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411144915.114571-3-jiri@resnulli.us>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19451-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7275643B4D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 04:49:02PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Extract the UVERBS_ATTR_CREATE_CQ_BUFFER_* attribute processing from
> the CQ create handler into uverbs_create_cq_get_umem() and separate
> buffer acquisition logic from the rest of CQ creation.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_std_types_cq.c | 127 ++++++++++--------
>  1 file changed, 69 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/infiniband/core/uverbs_std_types_cq.c b/drivers/infiniband/core/uverbs_std_types_cq.c
> index d2c8f71f934c..4afe27fef6c9 100644
> --- a/drivers/infiniband/core/uverbs_std_types_cq.c
> +++ b/drivers/infiniband/core/uverbs_std_types_cq.c
> @@ -58,6 +58,72 @@ static int uverbs_free_cq(struct ib_uobject *uobject,
>  	return 0;
>  }
>  
> +static struct ib_umem *uverbs_create_cq_get_umem(struct ib_device *ib_dev,
> +						  struct uverbs_attr_bundle *attrs)
> +{

I suggest making a function like this:

int uverbs_create_cq_to_umem_desc(struct uverbs_attr_bundle *attrs,
                                  struct ib_uverbs_buffer_desc *dec);

And lets focus the umem code on working consistently with struct
ib_uverbs_buffer_desc.

Ie as a general plan lets try to convert all the different
descriptions we have in the uapi for umems into a
ib_uverbs_buffer_desc and convert that to a umem?

Broadly I'd imagine introducing a new uattr for CQ to pass the
ib_uverbs_buffer_desc as well so the end result of all this churn has
the option for every umem to be described by ib_uverbs_buffer_desc at
the uapi boundary.

Jason


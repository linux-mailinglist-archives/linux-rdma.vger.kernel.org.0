Return-Path: <linux-rdma+bounces-20964-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEuoEbZmDGpXggUAu9opvQ
	(envelope-from <linux-rdma+bounces-20964-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:33:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 269D257FC1D
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D62B6304EF5B
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B83A348C68;
	Tue, 19 May 2026 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMJKcL/8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIoBG67H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E65834041F
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197457; cv=none; b=FuXXTAFNN9yiwSwAFeZ2tsedVYSdlc94mnQ3zC4SujnikBHlc/T4roMKskCZLP4mj6IdilOTb0/DezWLgX5w8tCljeqJy2w6payzSb03EW+JBBXL3fr5tgtCYsNneoB5OGYuRCUY2IOg7kJUXV8M6tbT+wZzK2qY7TR0YzQvqsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197457; c=relaxed/simple;
	bh=GNwt91Y/YiIXrN/ComEQSNR7c7pJ+6wypbzG/h6P8+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBZznCkLvoazWGsgk3MK8beSfL/Zru8AAhCQFqP3vRS/jza89dxkBApHF7E9PEUEJalZQdni8tgmksC84LlnWRnI6yx73+PXpEChQUJ/Wtgy4TOsq9v0Da3P7L7l8nlxu56eIKPPaErFGLJks8I6WK5LLwTIOzlUsgulXwuLLz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMJKcL/8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIoBG67H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779197454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/z2hwgz7OuA2Yx5IaqY06Z77nRzj4o/TXN2wk1POIRo=;
	b=XMJKcL/8UR27XNmxp3UoipVbBTfla0o1oM/SJdAXqhSJi8bGbGfCN/m2F42WkQTplwYQpr
	FGiknwr+73k7OZVSGZutoDF/TXi7EVFplhJXIgp/7lPBqPzGw2vI+MaFydA/bqIrbfg1Da
	hMxJWsMxqyx/QK6F3Zl9yY4n4ljeIAc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-lLGyD1JQPSeWE59uYQkrEA-1; Tue, 19 May 2026 09:30:52 -0400
X-MC-Unique: lLGyD1JQPSeWE59uYQkrEA-1
X-Mimecast-MFC-AGG-ID: lLGyD1JQPSeWE59uYQkrEA_1779197451
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45b7ff2140eso3143537f8f.3
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 06:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779197451; x=1779802251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/z2hwgz7OuA2Yx5IaqY06Z77nRzj4o/TXN2wk1POIRo=;
        b=KIoBG67Hb2wC2cmJiYmU59PJgUWXckmJgocJMiqx0R4vkHaswS8lH+qU7F7Gu/MDkF
         qRkBWc5k7hojdGTOpLg41FuPsq0mx4wVB6oZOIj3/OKnfYu/dELBPLwPNnxKwPnuhWBp
         dTa4Y1UnLzFTi+0B1xw5eLm0EMDMCC0M7t2jZHDoLy6sPf+K4KFs32zCBVA9EHKtsUAR
         AcAULmJ2Y8n0t8MQ/OmuW+7dim2nb89zr80tIR/F0qV4DQS/ya6B3gpzfSK0t8OJPtjT
         FayrjgB96HGf9r6SFrM/nR/TclkNF1HpA3zy9QqgyXW4CSLr0iC/ccUFYonM18al028A
         YvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197451; x=1779802251;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/z2hwgz7OuA2Yx5IaqY06Z77nRzj4o/TXN2wk1POIRo=;
        b=KM4FiN6VvsfCsCgz+pQXqhyB7ZOVTHnaHE2DaDXl0kKN2SCrQCuf9TFKgrflPi9mNt
         urgo1N84C+DjbuBAMTyEWnuTz4e26F29QEWHixg2+88huNv09ctdSmb/goGW2nqX5/KL
         AVl8WscapoEea8M6zJYZ07gjkD/4YB2+5pvNnbcCWAgWsSSUoYtzTDuh5qSZsGSj8UC7
         ixToyoJM5rAiyy9uz+2uDhC4WymwAg0Zjhn9jHQ/OpLPHcsJw4MAJPjPp4lyYi2V0g9B
         jvs/ozDCpox9QbhyW0QwJs1J7HCHWlCixVG70vmfSNeAD4KMX3VyLcyiYa3Gwb2MgA6k
         xL7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/WCyYHXHTNf3PK0F+rOGFcPqMDnuY/IA1e3VTgkBpQb7VAHgcSO7epkOu7zV/Jg7llSxKxMNvCFRjF@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdDpZJaYahiV/CfchwuqFXEhVWt6qs5jEGZlE+zx1YzHAHbPT
	Dp1ngtZqbKHUkV36EuwHnUTOuhY8MZgPwr07EHMuJndiLdg5xKPdsIn36W8EjXvj1ZQoQlrvGCV
	6o1PohwcR54pB5DDfqhXQkaQhl48e7CmvW/9j7fRX0FhWnSGzxUHjPddOXq12BpU=
X-Gm-Gg: Acq92OEHc3g8s0zdoAaN8Q6rJe40YuJo9RxToOumy+PkiAT3jiNc+dp5ElCUl65gVf9
	N1+dQl8mqdH8cUk7OaBQe7SZdlgMhDnvicpAG6Cb96Bu9Mmw1Ghvprlv5/YtmXRmaTug83s4xn/
	3GJdToAPszG7IFi//FB4Kh3LSAx9ur0T7IMx2GuDBZeH3sUsu3SUJlpT2fAtE915pefkKnvt3sj
	H48J7L253HQrgXPB1n0yZ7XDR9N6h3ZK8E2dVYXml6sSv/2v7UwSMwPH2vOOe6sg0M9Fc7K6oj/
	JYoh7/IO61LvUqAbwUP3rmk7a+EFwn5tHVRzxfpPbvHszhTLzmKuLz59dKCf5YfRXLjMTSEA/Vx
	cEvZ6gPbPfQDRRhnhwWFCdjsChvXPxNfmsxRlnMn9D5yiprZ04YjDEgA=
X-Received: by 2002:a05:6000:400f:b0:44b:cd2f:a3c8 with SMTP id ffacd0b85a97d-45e5c57d40bmr31702178f8f.4.1779197450893;
        Tue, 19 May 2026 06:30:50 -0700 (PDT)
X-Received: by 2002:a05:6000:400f:b0:44b:cd2f:a3c8 with SMTP id ffacd0b85a97d-45e5c57d40bmr31702094f8f.4.1779197450324;
        Tue, 19 May 2026 06:30:50 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm45094750f8f.30.2026.05.19.06.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:30:49 -0700 (PDT)
Message-ID: <e024150c-6970-47a5-8ba5-d16a7a189d89@redhat.com>
Date: Tue, 19 May 2026 15:30:47 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 1/6] net: mana: Create separate EQs for each
 vPort
To: longli@microsoft.com
Cc: kotaranov@microsoft.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, jgg@ziepe.ca, leon@kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, shradhagupta@linux.microsoft.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260515040508.491748-2-longli@microsoft.com>
 <20260519132825.172490-1-pabeni@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260519132825.172490-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20964-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 269D257FC1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/19/26 3:28 PM, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: mana: Create separate EQs for each vPort
> 
> This patch moves EQ allocation from per-device to per-vPort, exports
> mana_create_eq()/mana_destroy_eq() for use by the RDMA driver, takes
> a vport reference for RSS QPs, and adds cross-port PD-sharing
> rejection for raw QPs along with serialization between
> mana_set_channels() and the RDMA vport configuration.
> 
>> diff --git a/drivers/infiniband/hw/mana/main.c b/drivers/infiniband/hw/mana/main.c
>> index ac5e75dd3494..f8a9013f0ca3 100644
>> --- a/drivers/infiniband/hw/mana/main.c
>> +++ b/drivers/infiniband/hw/mana/main.c
>> @@ -40,13 +42,27 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
>>  
>>  	pd->vport_use_count++;
>>  	if (pd->vport_use_count > 1) {
>> +		/* Reject cross-port PD sharing. EQs and vport config
>> +		 * are per-port, so the PD must stay bound to the port
>> +		 * that was configured on the first raw QP creation.
>> +		 */
>> +		if (pd->vport_port != port) {
>> +			pd->vport_use_count--;
>> +			mutex_unlock(&pd->vport_mutex);
>> +			ibdev_dbg(&dev->ib_dev,
>> +				  "PD already bound to port %u\n",
>> +				  pd->vport_port);
>> +			return -EINVAL;
>> +		}
>>  		ibdev_dbg(&dev->ib_dev,
>>  			  "Skip as this PD is already configured vport\n");
>>  		mutex_unlock(&pd->vport_mutex);
>>  		return 0;
>>  	}
>>  
>> -	err = mana_cfg_vport(mpc, pd->pdn, doorbell_id);
>> +	pd->vport_port = port;
>> +
>> +	err = mana_cfg_vport(mpc, pd->pdn, doorbell_id, true);
>>  	if (err) {
>>  		pd->vport_use_count--;
>>  		mutex_unlock(&pd->vport_mutex);
> 
> [Low]
> In the failure path of mana_ib_cfg_vport(), if mana_cfg_vport() or the
> later mana_create_eq() fails, vport_use_count is rolled back to 0 but
> pd->vport_port keeps the value just written.
> 
> Is the contract that pd->vport_port is only meaningful while
> vport_use_count > 0?  That invariant is not documented in the struct
> mana_ib_pd comment, and a future reader who consults pd->vport_port
> without first checking vport_use_count under vport_mutex would see stale
> data.  Would it be worth either resetting pd->vport_port on the rollback
> path or documenting the rule explicitly?
> 
>> @@ -55,15 +71,23 @@ int mana_ib_cfg_vport(struct mana_ib_dev *dev, u32 port, struct mana_ib_pd *pd,
>>  		return err;
>>  	}
>>  
>> -	mutex_unlock(&pd->vport_mutex);
>>  
>> -	pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
>> -	pd->tx_vp_offset = mpc->tx_vp_offset;
>> +	err = mana_create_eq(mpc);
>> +	if (err) {
>> +		mana_uncfg_vport(mpc);
>> +		pd->vport_use_count--;
>> +	} else {
>> +		pd->tx_shortform_allowed = mpc->tx_shortform_allowed;
>> +		pd->tx_vp_offset = mpc->tx_vp_offset;
>> +	}
> 
> [ ... ]
> 
>> diff --git a/drivers/infiniband/hw/mana/qp.c b/drivers/infiniband/hw/mana/qp.c
>> index 0fbcf449c134..108ec4c5ce51 100644
>> --- a/drivers/infiniband/hw/mana/qp.c
>> +++ b/drivers/infiniband/hw/mana/qp.c
>> @@ -155,6 +156,18 @@ static int mana_ib_create_qp_rss(struct ib_qp *ibqp, struct ib_pd *pd,
>>  
>>  	qp->port = port;
>>  
>> +	/* Take a reference on the vport to ensure EQs outlive this QP.
>> +	 * The vport must already be configured by a raw QP.
>> +	 */
>> +	mutex_lock(&mana_pd->vport_mutex);
>> +	if (!mana_pd->vport_use_count) {
>> +		mutex_unlock(&mana_pd->vport_mutex);
>> +		ret = -EINVAL;
>> +		goto fail;
>> +	}
>> +	mana_pd->vport_use_count++;
>> +	mutex_unlock(&mana_pd->vport_mutex);
>> +
> 
> [Critical]
> The cross-port PD-sharing check added to mana_ib_cfg_vport() is not
> mirrored here.  mana_ib_create_qp_rss() takes the user-supplied port
> from ucmd.port and only checks that vport_use_count is non-zero, so the
> RSS path will happily attach to a different port than the one bound to
> the PD by the first raw QP.
> 
> If a user creates a raw QP on port A (which sets pd->vport_port=A and
> allocates mpc_A->eqs via mana_create_eq()), then creates an RSS QP on
> the same PD with ucmd.port=B where port B has no Ethernet up and no
> RDMA activity, mpc_B->eqs is NULL.  The subsequent code in this same
> function:
> 
> 	eq = &mpc->eqs[cq->comp_vector % mpc->num_queues];
> 	cq_spec.attached_eq = eq->eq->id;
> 
> would then dereference NULL through mpc_B->eqs.
> 
> If port B does have Ethernet up, mpc_B->eqs is owned by the Ethernet
> driver and the RSS QP attaches to those EQs.  When the QP is destroyed
> mana_ib_destroy_qp_rss() calls mana_ib_uncfg_vport(mdev, pd, qp->port=B),
> and once pd->vport_use_count reaches 0 mana_ib_uncfg_vport() will run
> mana_destroy_eq(mpc_B) on Ethernet's live EQs and call mana_uncfg_vport
> on a port whose apc->vport_use_count was never incremented by this PD,
> tripping the WARN_ON in mana_uncfg_vport() and corrupting Ethernet's
> vport state.  Meanwhile port A's EQs and vport configuration are leaked
> because nothing on this PD will destroy them.
> 
> Should mana_ib_create_qp_rss() apply the same pd->vport_port == port
> check that mana_ib_cfg_vport() now performs, before bumping
> vport_use_count?

Sashiko reported alredy this problematic pattern in 2 separate places.
Please ensure that there are no other similar buggy usage pattern
elsewhere in the newly introduced code.

/P



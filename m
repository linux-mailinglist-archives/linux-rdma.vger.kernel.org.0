Return-Path: <linux-rdma+bounces-16705-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eADAF68Ui2n5PQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16705-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 12:21:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D2B11A110
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 12:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91B5630488C3
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Feb 2026 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3E3191C0;
	Tue, 10 Feb 2026 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZljnbkXi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1nbFNb+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C046D2E764D
	for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 11:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770722467; cv=none; b=jVd2hJoNkZuR+m1XwnAllHnNR4Mo7oatvcUz3uRJppbNcm6n6wfxJuKgbch5iOxVXnlJKIaGGq4Ut0r5IJRbBcHVptQxUMkn02DYdFCdM/agG02cDp8/jA6M644UShfVrM3vqfNHXP6qun7PvY5C8Mxht1b2CNjZ4aCuRL+D6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770722467; c=relaxed/simple;
	bh=eKcEZlo17RdBD4UYDZAyhczV/J20m1EXzW92cGhob6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WsB4Cbmo0p0wCEPF7lmIiZqLBQHS/hIsMDbQPYoZLC2GkoQsveDkUhURc3WYXFDuYo9NjqAYXXaNwAZaSvqF4yTaXwZC8HFituSXICSkj5na+AX479QpKyTlo46cx6AVfrIIZTlmhnCsBoTI2KJ6i4aoFB5Bi/nauPo1LzT2Piw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZljnbkXi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I1nbFNb+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770722464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9E54hU5B9ixby1zjAn2P3Ap5YIv/BpVNItBJ+b/Jf4=;
	b=ZljnbkXin2vylX7YDV1UkyeVQtOnG4zHbDT9uw8vDJUjzFvLbf2dAt1h4WntSDv00apIiv
	G/v0tXUV8ybyro8BGTXogAw0Ra/ukBpUouldM6j7vlGsicSHhnWuA90mwr8eYh5pk2fCF8
	8qHkxd2nI1JW5Hlq0Y+FH34aImVi1EA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-mdPme9JzOA-Qz_2wfcr6dw-1; Tue, 10 Feb 2026 06:21:03 -0500
X-MC-Unique: mdPme9JzOA-Qz_2wfcr6dw-1
X-Mimecast-MFC-AGG-ID: mdPme9JzOA-Qz_2wfcr6dw_1770722462
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806fa4a180so34248895e9.2
        for <linux-rdma@vger.kernel.org>; Tue, 10 Feb 2026 03:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770722462; x=1771327262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A9E54hU5B9ixby1zjAn2P3Ap5YIv/BpVNItBJ+b/Jf4=;
        b=I1nbFNb+30U4KPiY2Jbu47b8yADGiug34Y3y9R/FYEK0ouhuhpvRf8Ie6DYdwQWdrE
         IlUnUuqjU62SfYNSYg3W/7zpPVDZn8IcQEOIho5fdAiIfxpyACN4Wd3fZk/McoPEfSyJ
         GzY2OWIlRvNa+4iYKyV9i6CcZf2iyvItdt3lUhXpECdkHkEJ4S154tNL+Y3pjcL867wH
         s1zcNM1ISx3aK7740iIzUz1hLslKKlAtlqEW2Mt0dcI0E5uuCWVx0SiRN5Y7NT8Zgtpg
         KaO4dCLJih3PIjCG9KEbsZih8ns3Hj+T1L73guXabrgdLJAwRkSYcp/KBSmucnggtJLR
         3CcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770722462; x=1771327262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9E54hU5B9ixby1zjAn2P3Ap5YIv/BpVNItBJ+b/Jf4=;
        b=W+yupHnbsSg1XpKRkWoL6aSn6lIgAiWGcl4SuFWAl9IVNArgvmuSa9zc3iiyLd1yKq
         yj77ysf/+sQ1SXjtSQ/2GjncGKpdbZXTU0agG2IiV/9wapmTltMF37Prd6kJpafJVBC/
         fJ22rFakba1qS/Q3ymPWrNculrIos/sSXN952OoirZgVYiRTTEp31M+NyrqThAgIr79g
         moMvyA8tVO46lbn121vIsl+f3aCgJn9Lu0fPwirbCBx7HPG/eU/FpR605CeE5lHJJ3Ax
         B4ClPZI21sEiAptz4LDccG2WFyoQyzNq0AFljmhoviwW37xJrvxsmY6okTegjd6q0+E8
         FwaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQq0jfqHyqBMO2fFZk+f+En9BFfVRlzNAF5tmU5fpVIekJ2MEG0sQOeoVI7qfDoZ1Dg6CzQ/eUGZmY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jOgR9KPE9WYvxHrqt8uBEJxijxZ80GBB6rxO6imFjRLnS9y7
	Z/x+EcmrLlfriUw86mEdsViCtJ3f2p7H9VdKVmaJPf0OF8Sh3TBFGi+V2d6xu3Kx4Qxyy+hFA1y
	mByf2HvwioWsqaJqClu+HlpD0rwvLxZu/N7w8yWXpJkjtsWD9OchVTqlLqOmZdqA=
X-Gm-Gg: AZuq6aK7clTPczI2Xvr/1lLIsXtLryauQhpUH5pUM+eivCEmuVRtvG0KCO+u3TvPwbA
	xEJc7XghSNnSgw1JMwk9aBOPkJeVAdEoSP/8Grp2k6R53tQ9n942Ap1CI1+jNRTezQ1/4BOKNTl
	rfNSA3IAtzJtBmi2rDOqD94GZrNy9cwqlFq6OKuftz94JeVzPsSx0VC2RLBQGG5+gey7D2v87CQ
	FwMPQVInxPZRdNrw2mYPokiN7NqCmOapJtyiUKs1W0Jix+fr2lo6BZ5lM5kQZXxiziK3wcAvi5a
	EEFsgEmeUdjXsJGBSPENpIMkTZ/WJnLZaEoiMlf/3EiRVqakMtaVKXV4ESbkm0iu9ZtYlVivJsM
	L1SnfQcYvC4a9PIMEbehua4A=
X-Received: by 2002:a05:600c:6612:b0:480:69ae:f0e9 with SMTP id 5b1f17b1804b1-483201ecbc3mr232437245e9.16.1770722462079;
        Tue, 10 Feb 2026 03:21:02 -0800 (PST)
X-Received: by 2002:a05:600c:6612:b0:480:69ae:f0e9 with SMTP id 5b1f17b1804b1-483201ecbc3mr232436535e9.16.1770722461601;
        Tue, 10 Feb 2026 03:21:01 -0800 (PST)
Received: from [192.168.88.32] ([150.228.25.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d8f2csm80277245e9.1.2026.02.10.03.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 03:21:01 -0800 (PST)
Message-ID: <ad37a4f4-7a03-4293-a8c3-1f0bad2f2489@redhat.com>
Date: Tue, 10 Feb 2026 12:20:56 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/2] net: hns3/mlx5e: fix CWR handling in drivers
 to preserve ACE signal
To: chia-yu.chang@nokia-bell-labs.com, linyunsheng@huawei.com,
 andrew+netdev@lunn.ch, parav@nvidia.com, jasowang@redhat.com,
 mst@redhat.com, shenjian15@huawei.com, salil.mehta@huawei.com,
 shaojijie@huawei.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leonro@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20260205141710.12609-1-chia-yu.chang@nokia-bell-labs.com>
 <20260205141710.12609-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260205141710.12609-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16705-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: F1D2B11A110
X-Rspamd-Action: no action

On 2/5/26 3:17 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Currently, hns3 and mlx5 Rx paths use SKB_GSO_TCP_ECN flag when a TCP
> segment with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN
> is only valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168
> ECN offload to clear the CWR flag. As a result, incoming TCP segments
> lose their ACE signal integrity required for AccECN (RFC9768),
> especially when the packet is forwarded and later re-segmented by GSO.
> 
> Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
> flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
> not clear the CWR flag, therefore preserving the ACE signal.
> 
> Fixes: d474d88f88261 ("net: hns3: add hns3_gro_complete for HW GRO process")
> Fixes: 92552d3abd329 ("net/mlx5e: HW_GRO cqe handler implementation")
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

IMHO this should be split into 2 separate patches, one for each affected
NIC.

/P



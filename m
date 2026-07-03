Return-Path: <linux-rdma+bounces-22739-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M+D4BFxnR2obXwAAu9opvQ
	(envelope-from <linux-rdma+bounces-22739-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 09:40:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 444426FFA3F
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Jul 2026 09:40:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BzEzIMfn;
	dkim=pass header.d=redhat.com header.s=google header.b=Seqb0eAv;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22739-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22739-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70BAF3076488
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2026 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953A36A01D;
	Fri,  3 Jul 2026 07:33:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD00235E1CC
	for <linux-rdma@vger.kernel.org>; Fri,  3 Jul 2026 07:33:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064021; cv=none; b=QvXhAn5tXLdVOHPrLknia8lecXTOg3/Zytg0GATKbSXYcqMqAl0KWlY9zMGV4XsTJPwz9PduW68M0V83d7WDA8wf6wNy1yL8moiv2d4vv8vIgVS3KmcvzNRs4E2PIeCCy/Qy1ZT/Ch/Jbm8SihtjHV7oVWX4oPozr5paQEJRi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064021; c=relaxed/simple;
	bh=gGwdwVnppKPNItxe2PP55HB8ljPKIMQ0qS2Lai78pnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSmuV4JiSnABXAN6ww+cv9iePdpPdHZIRpurrWYm4VtG7LknvJauLdFf6MWVz5hsCGUi9a+fEOLqc3Wm+efOOrfy38R6qXkGA5R3XNfCIObTGa4+jAp3oWHkab+96scbcUbnPAp2XQsc3oRPalOYfVSeWalKtaEJnr74XwHWYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzEzIMfn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Seqb0eAv; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783064018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLJfY0pd3sqslAge6SU+kYijg3eTsh0xGiRBVngI6RA=;
	b=BzEzIMfnXY+9/It+iKWnpkG/ESFyutts18xgMtRbq4i2H/rsgCu61zOFoQfB8mFLW3gqP1
	7Gfgw0U9gutT9pQh37QipljocD/k+5EWB2pKJye4zHbaAPv6CFRtI/24DRy0r7EyNVx7dM
	MuSZKgUXy5XQWDt/tQkzpkDWtgvdFqo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-p6baTP7BMEStRPOAcUEyBg-1; Fri, 03 Jul 2026 03:33:37 -0400
X-MC-Unique: p6baTP7BMEStRPOAcUEyBg-1
X-Mimecast-MFC-AGG-ID: p6baTP7BMEStRPOAcUEyBg_1783064016
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473bc66c837so283524f8f.0
        for <linux-rdma@vger.kernel.org>; Fri, 03 Jul 2026 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783064016; x=1783668816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GLJfY0pd3sqslAge6SU+kYijg3eTsh0xGiRBVngI6RA=;
        b=Seqb0eAvuNg/fCWJc0/lLWsvKYppI34CndbCgJ76pNCWC5zecbrZSmm3+3wD5FA9YZ
         mxMpcLGzYpGRivUywE6Qvhl0va45u3YWy1YxID22lWC8c/TOkoVDLzNOlqIY134lDJrU
         LbH7q9nvACWLK2D6sLmgfztU3p+4y5qdlkFuZCep3Iqor0qq8L+UcOMv6OG+j3NM+QvL
         DmREvwMbIKxFST5phUXx0w4gnDTyfGruepwSFMlmUd++wQTjs9QtD85fXg+8Y8hhnlQS
         4hATU1uPscYHLBBNii9VXHwE9a2i/orh+xgxEmtqbZA+XPy+R20AzFZ7+l/Mf2cuikQK
         ZM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783064016; x=1783668816;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLJfY0pd3sqslAge6SU+kYijg3eTsh0xGiRBVngI6RA=;
        b=ETZangOtPl0+QlTm1zC1vMvss40Luyi47hTrkExtnio1exUTExObfc79C3BJf9MJUn
         FIHRE6IvkLivpXoKjsr9Q2viv9hvXMwUMdFJmg+SB3J8JqKrliyKdA0HpgUcRW+aH/kK
         iA+cqd9WMgpuYnOhLIZMTFGCMuQ58mIyuruU81j3a6MRzwx4uhVNycnUieRbGAf0bAhq
         0ca4KkQz1UEM6TogtkP3QRJru7/H234eW1fASgsj9nWKvZIq1koghuKgbn42LpQsNcWY
         YYhBs55fyjrmZg31TpjaHgC8C1EV7OGTVCQZlm0LMoX8fMj3qKkygUAIQfcoNA9ygNKn
         VfXQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgBbCPbIZEPze5geWSgaaH1zeDw6KV8PTF30gcpNmgoL8GzSpa+3PVpqhxsANZGD6xAUyNqO+m11ag@vger.kernel.org
X-Gm-Message-State: AOJu0YzS5WNicIbHIZ7WdbkAZ7rHjJLiaMN1jA99VYdXStf7hEnx+ip7
	yOma/hnRST15ZYDJV1M0E4BqUeoHziiVXcrOX3xiVpMrpjPDDRBqKbQEtIepUtwzjR263FxWho3
	tD2a4AWzBYE8pTiGxUDaaTqllNbcCjcoN9OSgm+zy5F8MuaiBJ4dhTCLZLXN9q1g=
X-Gm-Gg: AfdE7ck74BWLFh7ujmqf2QaWaaHhQ/ZhT9JMw7IER7LRXFLCkM/8OgggLiTbzPt+miT
	9QGdEFdHQKh29TERgz3gwdzVLphOZ5GZj89svEsex6FEjAVnt4cBlvW9LaWrw2FIul67ls3/WIm
	7ImiO60LbqBVPMShmiVNe2FST/XpyGza40FzGkWWZ3VNtkCVNeBFPj3yNLBDXIMhTAAy/JUMVyG
	n26dAcSs1QuYEFbpseDvQYKP1C5KptvlWKRvMi+9sJDTV7kSb/B/ngyilFXVV3qtQWicE/hy5t7
	dq4xEHJnRQtmrPyfXFlMsknks/V14xXtSZgWSwJhWfXKPxrEzz/G3rCoDFBXavvMUFL43BgAyjI
	jkT1Yxjt223NYYD4HG+oVlS5zEheH73TeO73aGHCKoDqSj1hUJEnB9w40V7yxbQOFBzBWNo3hTN
	ZP0yLRTQ09mg==
X-Received: by 2002:a05:6000:2202:b0:475:f0d1:eb69 with SMTP id ffacd0b85a97d-4775cf53971mr14148219f8f.54.1783064016150;
        Fri, 03 Jul 2026 00:33:36 -0700 (PDT)
X-Received: by 2002:a05:6000:2202:b0:475:f0d1:eb69 with SMTP id ffacd0b85a97d-4775cf53971mr14148152f8f.54.1783064015587;
        Fri, 03 Jul 2026 00:33:35 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94cb64sm16390859f8f.23.2026.07.03.00.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 00:33:35 -0700 (PDT)
Message-ID: <55e4bc6f-f393-4e76-9220-a818b28c585b@redhat.com>
Date: Fri, 3 Jul 2026 09:33:33 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bnge/bng_re: fix ring ID widths
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
 bhargava.marreddy@broadcom.com, rahul-rg.gupta@broadcom.com,
 vsrama-krishna.nemani@broadcom.com, rajashekar.hudumula@broadcom.com,
 ajit.khaparde@broadcom.com, Siva Reddy Kallam <siva.kallam@broadcom.com>,
 Dharmender Garg <dharmender.garg@broadcom.com>,
 Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
References: <20260630101554.1221733-1-vikas.gupta@broadcom.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630101554.1221733-1-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22739-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:vikas.gupta@broadcom.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:jgg@nvidia.com,m:bhargava.marreddy@broadcom.com,m:rahul-rg.gupta@broadcom.com,m:vsrama-krishna.nemani@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:ajit.khaparde@broadcom.com,m:siva.kallam@broadcom.com,m:dharmender.garg@broadcom.com,m:yendapally.reddy@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 444426FFA3F

On 6/30/26 12:15 PM, Vikas Gupta wrote:
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
> index 341c7f81ed09..bb0c79a1ee60 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
> @@ -184,7 +184,7 @@ struct bnge_ctx_mem_info {
>  struct bnge_ring_struct {
>  	struct bnge_ring_mem_info	ring_mem;
>  
> -	u16			fw_ring_id;
> +	u32			fw_ring_id;

Sashiko gemini has a few concerns about the id size increases:

https://sashiko.dev/#/patchset/20260630101554.1221733-1-vikas.gupta%40broadcom.com

please have a look.

/P



Return-Path: <linux-rdma+bounces-16462-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD4TEj0MgmmCOQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16462-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 15:54:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B42BDDAD8F
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 15:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 939EA307C142
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547CB394466;
	Tue,  3 Feb 2026 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YL4Xz57p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8B392C36
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130487; cv=none; b=f7ycAIMRBlh5AGXhNK0vvjErM8QMVKQHaqa2h8M6bxLTLX9ctPuzT83b1DfOfuyFaJGc9ohtDxCO1Oz+7ubsHTx1qEASOUBrPNCHKbH9XmC9//4avM1KEgjfdDZXJoYJtcIIgzXugjWWC9AZdMW3s6zdkKA4fWQnEZeCxVGaTj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130487; c=relaxed/simple;
	bh=24QR3ADvl1XZUNAoYoDpao++7hj/gxtL1FrplRthpnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQr8AGUYJgKj4YW2B1v6nVU5ietY0egJq7A32OBQFJcvdZAcAqygbF81zbCQnjnEqhzx5Xqgn6ntzJRJpz2O2imRK9E7+VSj3vrEn88JUMQv7Y7mcwsp5r3NyLYQ/xaMXYod6HRfwPTBCgIiupUMTc0ul5vWLfz6R4PUv7XewY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YL4Xz57p; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8947404b367so62134016d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 06:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770130483; x=1770735283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHpiWLx1om6fcFV2GZ+lw98/ZfZPtcP7r3TnI//9RWE=;
        b=YL4Xz57pwX3qcActcgo2XL+XOvR74ILJYZKieIpGI+FATx5TSpdpw/CmgRE9WXYEMA
         XogimG57w6XlqHLlM2/LZBN95wTDwdr58pYhJVP4JouAtpj/KPHpwM9py/zDdJBVQSeD
         eLVCfFmxdvEOW/Fgfd9FCWORdhNzmFJH6HVf5ZTaaM48VzuP6eE1ZT8g6mO6oobbxxb1
         mXmoTqb2VcE4TUnJEC8q2LhMpeJEqi91fbZaiDMP6JRtdFmYcnw0RD1TU05KVs04cc34
         IyP9cahJJqeVVtkKZVed+J/ky+5LkiuPSLHhFJVb34CO01DyKb/OtrwYGhvscZdKZiw5
         3GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770130483; x=1770735283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHpiWLx1om6fcFV2GZ+lw98/ZfZPtcP7r3TnI//9RWE=;
        b=iyiNJpacUNGpqkTKZVfB2u9R8DtwhL5imPwVlNTsq/0uMfNqNhPOyEwapfsqG8eZkb
         D0ldRm7svIiIBIB9a2ySNigrvah3wMsnZDp/hlUBLCrfiqdxDssboyXisV+Ssrhspb/I
         cdETxpSngDKSR3S60xYlfxnejKC78bbQ9Vp4gGUXTSdu2UYHC87E+1QUCsI2rsgM5TDW
         2CNqke6AP8YEgCqPDWKSchwfSjMISmfdimQ0DsvLLVoZI8fwNjDRHiyLil/WZqCoCwl5
         S6zys7bg8e/ZSdV9s0Yx+qLOhZJkNce2aFuKeHlnlldU0udZRsrlO22FOdL6pgxXyLQy
         a8/g==
X-Forwarded-Encrypted: i=1; AJvYcCXrwwEZTG2emqxhe3o5ziJUfdQ33Zth5qC2xyJbnQQzmRu8R7UmNYp8POazsR5J9S3Wrsf1PA7jaw6W@vger.kernel.org
X-Gm-Message-State: AOJu0YxUK6sKN/GkQ0q4N5/Ug4hsbrSwRaK12J1xW7TMXrqVRmXuLrmw
	GFyllVL2EAgx7nwOz1/GTVzwWCd6C9ZAu/6ce3SPIbF87kk94xxdnklMpfIUMcBA1Dk=
X-Gm-Gg: AZuq6aKLe2c3qxaIL+rtY7D/2tpUnxHk7yZYlB4+yJUyHX9q9bXWtMgy97xniBgh6oV
	0eSvIocDI68zGzPhHvewCLUZ1tb8iXzq8kWJ9GeASogB/V4PEfr0csQIkVb5Vlmpr5YAZsyHPBJ
	DaQmtrIFxBeLjRfSy/L4u+ob4LUjDGb+RsuypJR386T+4xykCcdYwwPcqGUzvJ44xghrRPbqLTP
	mLGOn8LJlD0nDLbDa8+uUq84n4d7fpn2fO7HLaqe7/7YpsLqCMXhwtIBGwqODlKhASSXneZ9nwt
	YJ/JZ1aXRyBCMtkjUzNHukEWlMtR2mGw1J0C3+Ibdr7A2ivVO3koiwxmWwJSVPa11ObPFA4ECd/
	1odEL2xwJFNb5pYnBvYubDJkqm2K0EUCUd1/KFOMW1hKun3u++XX1VJaOAaxJ9oNF/b38L7c9Q/
	QnoiGDpPPAuEvUM+o3ASve6PbErdEKgkteOFGkcWZwrri6qUdcETrXWvrSxmFqvX2ZwVE=
X-Received: by 2002:ad4:5f4a:0:b0:882:437d:2823 with SMTP id 6a1803df08f44-894ea026ebbmr221175726d6.41.1770130483032;
        Tue, 03 Feb 2026 06:54:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d3740d73sm136181526d6.27.2026.02.03.06.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 06:54:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vnHnd-0000000GW5b-409x;
	Tue, 03 Feb 2026 10:54:41 -0400
Date: Tue, 3 Feb 2026 10:54:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v10 6/6] RDMA/bnxt_re: Direct Verbs: Support QP
 verbs
Message-ID: <20260203145441.GR2328995@ziepe.ca>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-7-sriharsha.basavapatna@broadcom.com>
 <xhic2uwkvuwxh2v3h4vhbd4nichqhdooo3ew4ju42v3vq3tnc7@sul3tfcmeld4>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhic2uwkvuwxh2v3h4vhbd4nichqhdooo3ew4ju42v3vq3tnc7@sul3tfcmeld4>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-16462-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,ziepe.ca:mid,ziepe.ca:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B42BDDAD8F
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:03:52AM +0100, Jiri Pirko wrote:
> Tue, Feb 03, 2026 at 06:00:49AM +0100, sriharsha.basavapatna@broadcom.com wrote:
> >The following Direct Verbs have been implemented, by enhancing the
> >driver specific udata in existing verbs.
> >
> >QP Direct Verbs:
> >----------------
> >- CREATE_QP:
> >  Create a QP using the specified udata (struct bnxt_re_qp_req).
> >  The driver registers a new device op 'create_qp_umem' that is
> >  used to process QP memory allocated by the userspace application.
> >  The driver maps/pins the SQ/RQ user memory and registers it
> >  with the hardware.
> >
> >- DESTROY_QP:
> >  Unmap SQ/RQ user memory and destroy the QP.
> 
> This patch adds direct verbs to create/destroy QP and also it uses the
> new umem op. Why you need both? If you need both, could you clearly
> describe why and send both approaches as separate patches? I suggest
> to more rely on your head than your AI tool :/

It's true.. I'd also appreciate not calling this "direct verbs", that
isn't something in the kernel.

What this does is add some more controls over the configuration of the
QP and CQ that userspace and use. Ideally you'd describe those
controls and what they do.

The umem changes are about supporting DMABUF.

Still, I will check the uapi hopefully it is good now.

Jason


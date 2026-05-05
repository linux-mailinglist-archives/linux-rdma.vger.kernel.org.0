Return-Path: <linux-rdma+bounces-20011-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHp7La3v+WmcFQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20011-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 15:25:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2674CE6CC
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 15:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D520301F37F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46A031F99E;
	Tue,  5 May 2026 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fhjiQ0Q7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67070241CB7
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987217; cv=pass; b=SO4BHhHpoM2n2Nr2c+JA2lI5hvplHpiOv+ryJChDJqzdfRKcbPsMHuaLNZLbvIfAOB2cT1P6+maRV6Gq2su7C1JLH3ummSrk34QjZXaYuOx4WuTbYypQ4osEptWKmYXN3t1RPGe9CwaCB0j4fdBIFSl04aQHD3U09sgZiNRRAQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987217; c=relaxed/simple;
	bh=KI4D1YaAvpJW5G7zm05sRe67tdYkt4cT3nEOjexAaAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2hmeaGcKyMCEboBmDUB111pkuBqBSk1WB/h+sSpH6w1mpszjrimvQAffEyfHxyPeTOejyHA0za8uPZQazEgU2kZOm813S3qK9xwbwWnM/7+zo7JQpKlQPcPvMWM8Od+upZu5DTTQ2Qj6Ykt3Ow2yqGWavs5QmO8exzDzRTvlTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fhjiQ0Q7; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7dccb8644c4so2738776a34.0
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 06:20:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777987215; cv=none;
        d=google.com; s=arc-20240605;
        b=ESN9AxhA3Jcczh17XbxZ4J+Gshcii6nckF5y4WviBaxivGq1qMYw4Xk4Ixsr3qozd6
         KpJ35/HFru5Ks0xzKjq85JYEPZ+MDmRxVq2TdIU+Ma0XYWWXgSJ333xVZF/z10tb/CmS
         7VB6nmi8S5Txhxc5ZawQNMg/1rGIBmJq0pgWmN+3kdC9Q/mMnUH8GZZ5Loz/g3EiwrKk
         1PcRjoZyR4IJjcRts4WJtdavT1CIpO8rYlGXkwg5QacQQ8yvzec5cPDtWP0EIz3gLGDC
         WOknyxZCN0ftiv0M4y5KMCG8FJhOm+eyoL0eEH/buCVPO7MbEA801zVS1QqLnyCdVIJ7
         gXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KI4D1YaAvpJW5G7zm05sRe67tdYkt4cT3nEOjexAaAU=;
        fh=NM3QlVm2gljnKIq8nzxobuktninE1S8cE3JEJ/Y4+cY=;
        b=HoJC6ORmwwP9RCvxhvoPCf2+W/10nydRiXyYx/kQwePNGXI8kceh74kXb7NWhm9PcQ
         6QlG+2XEL2bvthnojDP+m47dcAaBuJ/FkKEG4kZH+GfRu/jTyF8Zdei66pTixJW4gcZr
         ozYzzZyU+BNzsX+9OmHxFDwIGuBh3/9vEX/pIo8nYq/OKP9QoNWlsQ6g5fHN7I/wcmwg
         C3BLRXCKhykCk3AHKXGravLubiK8/ZQVbQx0j88xT9YEdxvg0ocrCOStnGxaiVJgqT20
         9D3oqj0dUQCMdA/v/tX5etrxVkxQk5CTzIuG82WZmfC615ZFFvWcK+rWdB16LPUVUgCk
         Acfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777987215; x=1778592015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KI4D1YaAvpJW5G7zm05sRe67tdYkt4cT3nEOjexAaAU=;
        b=fhjiQ0Q7NaTw5VH+8/0AsmSMu/7aGvZPBdp1zJ+u27gv3o5mBE0Zwf3Z2bpOvM75TU
         LRLFSS+2XLLct37pZLY4XsHgZncMppwc2v+Rnj+UANsEpi2VUkDs+3fvFa8SuY8wKQFQ
         N7ZKdXeJraIYnmN0gU5gQ+mW1z5ZgqCI9VB/ehg64aCZbMfIFzdRsEtAC6UCu2/LMqDc
         U5KHC/wvnsWjKPxf09L/tcrJJH/Y+UFGR4Jlc4OMLMwB2a2v1ZJ4VC8eTRibmRqj9PWY
         CAvJD0LIZUXaMAZ+SQr/CctCUwBypYn30aoyIZK0isPIQlMEH3p0P/kdy163aks8jM9U
         /PjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987215; x=1778592015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KI4D1YaAvpJW5G7zm05sRe67tdYkt4cT3nEOjexAaAU=;
        b=TUpnr3gqVc32lGhAx8omS7d7IWrbSdzg4CO2901141+8qHp+8X73HyXEV5qgxWTSYb
         sgRAjwjqrfh2l8Y8dZKSVjnrLwEg/EOsTeiO+uBDfcrOs15fkKeCGDIbl3F3HP97hu0/
         WGKcUSaojKb1SZ1F6VGnXnlWKmLgY6FF+6hKhV7qCHcYaJTjQzR9Lq8AQMHYOQvKqFCj
         1tm201EDV2Z8RyTbcGrBob5DBI12xUCd9eOIDdCSEDkbT4S4YI++OTGjtgq1C2kczo5U
         IQjq5FxBJW83mapcwSnM2+5LDdDImImgD3PYvKJ46qnjWecfMAmnb7HNkSLhBwmAIn8k
         omXw==
X-Gm-Message-State: AOJu0YxxtKgUN2A8jSL3CPaZPdmyTzNXZOaIU4/6Ddyl13B1qg1Em4RI
	6poUnmpzEie0VSxCNtKhQ3HJqBBLxXPjh8sm2Fc8bfA+oGY1raHso4nBG/CGzyz8tlJlUMzWew2
	D3Q9krBAzzNGI+R1BrS76zeNJxCNti/iuaHv1xgcssySZj6wYFqxR+Awc
X-Gm-Gg: AeBDietqgNbs8IDwzkwxjumaqTtKm3HNi9yj0Wf8WCzMTCVS+uRYDBAm/qdLqGuSELQ
	zzwjpAxe2aX6Z1+t823XPvzs9PM4cbriRLnqDm4Qd/7MYd1IV6VmivWdCcN1JKppqZN6c8+2Xx7
	mbzr4z7DrLIX4UWXaEBb4GY9W4FGnfzNiWXJRn1gqU6XCWvqcN/81FDJ3IknDwXKAm60N4HCuQF
	sw0SmHC3INJeRumv6h8FvMxVAQTJbFZMk/5QLRcMMvfZqTz1EJIPHSh83WA9DDTdrGbArz2+KJj
	nVxQpKVBHfgRYgegTIM5WfDc5e8DWA==
X-Received: by 2002:a05:6830:67c5:b0:7de:a2cc:9da2 with SMTP id
 46e09a7af769-7dee13a4e13mr8330911a34.15.1777987214936; Tue, 05 May 2026
 06:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505061149.2361536-1-jiri@resnulli.us> <20260505061149.2361536-3-jiri@resnulli.us>
In-Reply-To: <20260505061149.2361536-3-jiri@resnulli.us>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 5 May 2026 09:20:01 -0400
X-Gm-Features: AVHnY4KLd_PvsWncPV3iVRGoJuzugBaOoor9U1lwEnwWSM8wTX-5S-XCwcCpDl0
Message-ID: <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	edwards@nvidia.com, kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com, 
	yishaih@nvidia.com, lirongqing@baidu.com, huangjunxian6@hisilicon.com, 
	liuy22@mails.tsinghua.edu.cn
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BD2674CE6CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20011-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi,

Out of curiosity, it seems like we set DMA_ATTR_REQUIRE_COHERENT, so
would that have caused these registrations to fail anyway since it would
be trying to use swiotlb if running in a CVM?

It's not really related to your change but something else I was curious about is
how to handle drivers that allocate their ring buffers in userspace and register
them (irdma). I was hoping that the new cc_shared heap could be used without
modifying the kernel driver by replacing the normal allocations in the provider
with a dmabuf allocation+mmap and just passing the resulting pointer to reg_mr,
but that won't work because it's a PFN mapping.

The driver could be modified to accept the actual dmabuf instead for the QP/CQ
rings, but I just wanted to see if that matches your vision here or if
you had something
else in mind. Another idea was to just allocate them in the kernel using the DMA
allocator and map them into userspace but it would be a larger change.

Thanks,
Jake


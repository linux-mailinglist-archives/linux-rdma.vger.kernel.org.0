Return-Path: <linux-rdma+bounces-22351-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P4VqIokANGr6KgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22351-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 16:28:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D88BE6A0EF3
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 16:28:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="BTbOpqE/";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22351-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22351-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA2D6300F53B
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 14:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD143CFF4F;
	Thu, 18 Jun 2026 14:28:13 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA42D7DC8
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 14:28:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792893; cv=pass; b=lC6KaHDJEo4m8n5j78jGwiFD5CF3q4inYPNJiiz+E2mTv1YXG9aVXATGSjkmCFXPmIxaJM12IlGNoVqsxigacSG2iajKDuVCZ0Pf6FpgRavU+fDcgrDbRMRRKBID2xov0vS9O+S/qyYIcv059usSvC96khdlieGLarzD5b/ccko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792893; c=relaxed/simple;
	bh=i2B+NxU0CZTK0xwM8OLVyFfmzdA22KKzORXTSg+xy+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adusba8f0F9ucEm6Fza46P8lCiaaRWbECEugIFOsTD3tg3qdxJLBMj082uJpfqIOcCJypv0RILTAJ0JJFcPDkc7QR4BsuT+wxC7noYXL0F1n1HuewJ96fE16rpVWqOXetkNHM2oSqXyGnXoL+otHJP5pSjtxdGOpBtKRKxf1hMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTbOpqE/; arc=pass smtp.client-ip=209.85.161.41
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69e32df92c1so634089eaf.0
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 07:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781792891; cv=none;
        d=google.com; s=arc-20240605;
        b=CWuhzI4icHHl8Q8J+3gOQJuN225+NpRL2cGDJ7nJqHHMYkBfzEAs/xaE0LXBJbm35l
         FsxO2g19GYMtlJlQu+oK3KO03STZP3XByv/7kBiqWWD7GzA+mF0u0w1haUpOgQg5DD+9
         buR7xtzO64GqoN19c6evp5O+bNGReYJgP9M75RDWswfTADB+R19eMRvBvoxDSmPEcNTN
         wwfm/0bUY9ggo44CKJxCuoyXgAeFUDCRnlsB9HkvJfvLLH2/qt9OlsQ36k1d0uHzZFwU
         qkowkNc45JmCj1Ax2U0OPz1SI4Xz5fFpEGjdU8xq1EhV04FT0fQcEAjZZyfI82B4wfm/
         avPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i2B+NxU0CZTK0xwM8OLVyFfmzdA22KKzORXTSg+xy+M=;
        fh=E/b4JziRVrSsMDD9PvHrPgyIuxaa4n/33eq4zWTKQGg=;
        b=SlhQ1rUmGNA7YNK3Bj+NsABmZ7Y+tOrAYymf29VOsDFyHaoC38Wrlt4mItIsKl0YWu
         hXumkxcUKBVtaHaqNrrJzJM2Q20VOmZZ5+sbwxOFn5LSynNAQBFruF6YG2Z4jEHaq6SC
         UgnxatXjEuS8xzEymtuXvQOcLEOUEsrnWKbMpX/fOMKy2MRPgN0Bw3ugp6Be+QmL39xO
         cuKZpVBlv7Es6sHV9UCgvRlzynOWbNZmgXgGJkEIOa40M86DoXlWdGiJNw/5plP0a6LY
         KTvLb7rT5J/Qlcl1WPSCKKqYcbfBZXDifZ7mmaIJ+uVyXlR/UPy2mtUJCqAjU+WlS+uB
         /vyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781792891; x=1782397691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i2B+NxU0CZTK0xwM8OLVyFfmzdA22KKzORXTSg+xy+M=;
        b=BTbOpqE/YsvALZwdi0rHQmqIA5V3p99EWmuKWYdgiLPt5MwfVUAzaRnxQkqJtOJpyI
         tn1zdmwztBX0VxPE7fQLiY7h1TGdndvoNq86kcjQveuGIgMf+uR1+YvyZTf0VkJN+65M
         lBS4eCwioL5K8pIGZiQEwmvJvD8DtbSyA0V3y+BFlKMRCJPg5vJk5sKonb5USwkBpaqd
         /H+PsFFLXPIlKkNRtMNqlurAEm6n5Pk71d7bkhbNR+uID5BsHfPjlk6xzaA79gwXRY4D
         2UmWIgpNWu+5UyBwiD8wF8ie1DZTwggZ3SkviYCRIvXjI3/yARuNTSbTvG1FMPrHOsOo
         ydjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781792891; x=1782397691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2B+NxU0CZTK0xwM8OLVyFfmzdA22KKzORXTSg+xy+M=;
        b=ffIWUawl4KMmlZ4o/57PLU8+hOKANSDAzKP4eei+fGb1b4ViQboHvcTqWo7Rm21m4/
         v0QzZ6t0rbpXTYKxhI9s8i7KItLTCEuAuOXxnqpxGqC27N9EY8G+uh7Qf2C3I2cUyTV6
         oOAt8BIlcpWxkbsnlewMjLW/geAB/fLP5VYSwGOIpvFlDtuqHUzSYelOYUmw9vjWSm6+
         9miXQK2cD3nly/ZTMCvhug1gafUDY4dxgtnsuG2CS4t/w374YwxXjap+danMOKX63jvQ
         /YD1xGxaDAgR53jUoGBCq1AHsnN8qcBiNcSgqHKYincaahY4H0ApuuAYvo5/b9QmUg9F
         k4pg==
X-Forwarded-Encrypted: i=1; AFNElJ95Q9Jj08TH9ieofezMkSlWcBsaBt1jFB4n+B/EjRybJPAWExGlIRl1Df2MyySUpQmHUXQw+w4KhNcM@vger.kernel.org
X-Gm-Message-State: AOJu0YwT7BdsL4mzHrJ8IqomVx3EdeukxfGj6MWzg/Lz2odAwYp2WK0O
	2BOFds8WbXehi0K7AgByfaZLso6THFR2/51WkTQkcHFKljzo6Ei3Smfn/juJrkDgjrn70Xj8YsM
	T8FaAKWHfJqIdUEzSb4KNq7y1NeE6OI3IDd2arZai
X-Gm-Gg: Acq92OEH5OMK2094Lxo6/q9Yb3auIfR/9IqCnUAyH18hN2f+sUlLBgTWt73uUUU20hl
	j3l/tmTjEht7XegveH1hieZgkLC+GvyzrrhvivClTINwAJ++Sv69NEFt5sBHfcGP8sYe0piGFST
	DdBo35DrIG3uq4FpZkVHfxRMQWWznOYH2Gty2Z2lOxVYyl3HliwIekkLJGmJVSk187WJ++UXEYV
	fg6XqZNkoBquOUQdbvJ+19bvCsEEtwyi5mspj9lxbOeqnhV/oojBiC13Hy/+PJfVAQvFxJLdQ==
X-Received: by 2002:a05:6820:906:b0:69e:8afe:e989 with SMTP id
 006d021491bc7-6a0b60c5d75mr6777398eaf.30.1781792890090; Thu, 18 Jun 2026
 07:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618045120.51210-1-boshiyu@linux.alibaba.com> <20260618045120.51210-4-boshiyu@linux.alibaba.com>
In-Reply-To: <20260618045120.51210-4-boshiyu@linux.alibaba.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Thu, 18 Jun 2026 10:27:57 -0400
X-Gm-Features: AVVi8CcdyMecEicEHWhNU69Z7SQQB1zykbolqmG2tPB9UGEo2gSAu2cpDPoB91s
Message-ID: <CAHYDg1Sqb2XfH8pi12sy3HwrU_WqM+F7NeXmwyW5jDJNNP+s3Q@mail.gmail.com>
Subject: Re: [PATCH for-next v3 3/3] RDMA/erdma: Implement erdma_reg_user_mr_dmabuf
To: Boshi Yu <boshiyu@linux.alibaba.com>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org, 
	chengyou@linux.alibaba.com, kaishen@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:boshiyu@linux.alibaba.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22351-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D88BE6A0EF3

Reviewed-by: Jacob Moroni <jmoroni@google.com>


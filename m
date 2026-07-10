Return-Path: <linux-rdma+bounces-23019-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UvuWEkBhUWoEDgMAu9opvQ
	(envelope-from <linux-rdma+bounces-23019-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 23:16:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E4F73EB0A
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 23:16:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b="RYK35fQ/";
	dmarc=pass (policy=reject) header.from=meta.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23019-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23019-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C495300FEF2
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 21:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E273B3C12;
	Fri, 10 Jul 2026 21:13:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DB3B0AD8
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 21:13:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718026; cv=fail; b=r0jYsvry132yF4Ex1xDNhO7yriCPqoTBefhRPImuAmn+RXOD4Gd5Ca6XdKrpjITz5TlIp45TS2/4wAybyzoxy6Da3PyD9AYk77PCKmhlCIzOwAB5rpHeha1OOZlSzRMIeBxfRGdoPqZbe8IpLgT9J5tboZ0bWAoTOjXDyBp6MiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718026; c=relaxed/simple;
	bh=qTGJ1qCsNSroWoULGPtpQMjb5UjkQ/i1Jx9oQeZCKyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQqNi4g7ygAE8g17Oi43VDfsyklKz1lycObaRMXzBN3CPu6nCTJ0xVW8DB1LM5fy3MynWcJfjoTolkDWwim9zm67ghteKbo183G/MVnFFDHvbgCPJsNGvubWX5yCaL5KR/ulHc9aY+5Jt/vqQemtlICEExwy90gnNOjPpmRghZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RYK35fQ/; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AK308j2450181
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 14:13:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=RF8cFAwOnRSkhH9D0DDvmvcNKGy8nfBCbBtEkVfL0v4=; b=RYK35fQ/CwFt
	9Y6liH/+T+e8GjLaxejo6rcLnWNoms5TDAneieLNEs3hl1aa2PsrH/U24euiowpl
	9luuMEPbfvWzkjV6f+XoTtHYas77VVD5ZWtxfcDX+6WYOimoCorso3lVvOn7BFr8
	jgFGWDg5+s368ZiJ1y+Idu0Hy9dtSy4mLqOl1ApPtN0Q4jAwmaMMJYd/7GaIeqHq
	hRwsF7KvtNf+HLABfW3TP0f6XjwilIPxO1af7LFe+Aa3IMnPKCrPiujbH+hMKUIf
	QrfNgj7RQdzrvELzpA8rSXxe86AHthCE8wer5/AyftFWjSgImjzNasXhC8aOsEav
	+4nOGAwTFw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4faku8xtp4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 14:13:43 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7ead3468408so922907a34.0
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2026 14:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718023; cv=none;
        d=google.com; s=arc-20260327;
        b=r3sPKezoxxuR6GXw+d6BixbTeaFfm/IkFczb0RMran54f+zkVDbyOX8RdwyC1xD4f3
         srSbYRO6tW9H62sNTAatC0LtPLM8vjiJgAkZvzPZzuwg/v0AX6/wmbZgGtHJsTKQmnPQ
         kV80gCeLDMwaOasKwnXZAy8lPMCh39M0R0vPHxbfqQA9/BFj/wOmzVm5Bhy0oW3mOsg0
         C3/4zf7wR4BrKEppSY+0UxDMCtGld+3ieTp/CBkmKlnGTtNDcHMto1KbArVx/LGA8jkk
         xMc/Qes2G1VkQgPS762R8l5Jc9ucofR5/EpJ1ro8EagJN4VoYJE9sv9GtuDP8D5+PQaC
         iIGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=dzINuCyV1AjhEQXZagg0c3klT12KrUQB8e556Tlb738=;
        fh=XmhFWWsCik74KgN37Dv0ki5W+cGAfxfDYK5+Vl2FAO0=;
        b=nlJW1fog+Rh3gl0Ciev8fQNqNmAC+LCj5JH7GfemA0GWl4q6KwEZ7hhgXF2F1UNkUo
         n3zSbO57Y9icQa4KZ0Dq+wU4M6vK94SQkA1PqTa1dVj3o5VfUZfboUlfW97ODsoqY5AL
         5VJQigo58K5EfSMmaFIwJfxCDL7zvflPc8X2GzDgb4Npywof/rpMMjluTSbsikg3Zogs
         ldOA+sUCfatsfupSBn6wRiVcpRnh0a0/Ezn7G6MQlSmGbSwV4iC0a59ULNOX0pUybTU9
         juXyH3uhKdKXsG+rLxxYk2PUL+4HDnNCveVdv8DgtUfvRGPyQjE8rT4XPJWi0Uqs6SKn
         PqYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718023; x=1784322823;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzINuCyV1AjhEQXZagg0c3klT12KrUQB8e556Tlb738=;
        b=J4wHMLjtgpo2jkgJ3dvg0ec1cGisYYV1NMybB6u9kb6gBMAJQ2iG5hNsgCjvzF6kL6
         IAukgAUpML43RCssYaXS814SAoQZIUNbggWNilY87AgjUQKIeRhDk3yMHztJSPJWH//x
         9Cc9BAdCrThiTQ5ddw65pECSj/XJ6t1qyQoPikT4oOR5wR2QbU0vw11nbnnG5Y33qIWd
         5wvpWvlRXa4JKgf88eZT4aES9J6zFwGKH4Yf26ZU4/7xXl+Gr+9JDDnEefhY+i6OAGPp
         YE3ce2W0Dk1RFmBULkAIBcG2tDy/NtOyWWif42Ct/ZzPHW/zEXrUR+yZklaXL9C39AXO
         roJw==
X-Forwarded-Encrypted: i=1; AFNElJ/UU2LHZUXEagD7/49o92A9uLP8BO0hBpziKRjMbi+LRjENrwe7BFcBfZTuJOiDWnAqYZULRfIqgYhX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq8acOl7usJ/AvUPRkUXxKWn7WGBN1G+sjnqCu6mqexDLFv9Za
	itWGmNfUFBXCHpfxVOh05mcTKlUd7RWEVUJ/9R0CxajbLr78LdC+6S1yr0p5V03Q/2jRZ5R9KJ+
	jV/0GRHn0xe5oXPAY++6Z2xu5FSuw+VKcy5jZHmIPHdnREJxhYfdHFU3/l9/9ek1Q21FxYBCuvo
	LE++SF6xrMi+dwGzHtCKf69LpHNgFp942aU395
X-Gm-Gg: AfdE7cl3JZsRooNiY3w7PvBG36MbtR4Rr8OM8rWr90uNiJ+STZKGlkzAAbx1VHXrm6n
	DBNljkHdTe5agLcEORcWVsCZTBLdQA5I/Cl3HhA+2u4/nmwqtX+I2WsmRuotkFgOfnBI1Bk8a3G
	KWCqNB7yePlutQxVQ57LGWTLneBLoDl31mML98TdcAw1pNQouw0plLw+o7kw+Oqr7ee2dTjHVLp
	kn/5tKJ9Gs=
X-Received: by 2002:a05:6830:6c11:b0:7e9:b772:9aae with SMTP id 46e09a7af769-7ec0981c52amr316858a34.23.1783718022918;
        Fri, 10 Jul 2026 14:13:42 -0700 (PDT)
X-Received: by 2002:a05:6830:6c11:b0:7e9:b772:9aae with SMTP id
 46e09a7af769-7ec0981c52amr316843a34.23.1783718022507; Fri, 10 Jul 2026
 14:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702181025.2694961-1-zhipingz@meta.com> <20260709132602.6a3fb084@shazbot.org>
In-Reply-To: <20260709132602.6a3fb084@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Fri, 10 Jul 2026 14:13:31 -0700
X-Gm-Features: AVVi8CfXe8KvJ5Z7sUtkIYqefn9JRiYpvw-OvxoKOz-vRkAAzCUP8YaHHQIwWXo
Message-ID: <CAH3zFs3OwPyTrWk7oaMYETq7sBEQ7VRfDtzWWamhiE3AJzVShw@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: Alex Williamson <alex@shazbot.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Konig <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a516087 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=c92rfblmAAAA:8 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=r1p2_3pzAAAA:8
 a=FfEKJDObtavKmf3ECVgA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=gKebqoRLp9LExxC7YDUY:22 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxMyBTYWx0ZWRfX6q5cSHfbIUjb
 MlgeN7IA4Rm9NW7tUNbCi9ZbpWJPMMcZY3YaMkc4KVnCDH1OBz0+8fWZy7IOLzCR3GZxlV/Ytmr
 EfueNJt+Nc4JzorG6HprQGE/kbkTe8c=
X-Proofpoint-GUID: dlWCJMIWlYcjetmG9VHJIqjsiHaRSpwT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxMyBTYWx0ZWRfXxVvAtl4vm5fY
 xDkmfLWXMA0suhedZJodx6mpY30aeXcHrLoYPvzBTFxUIamDzVgNxhVpAkjnoldnLAzuWDiTr7Y
 15Z4MLY/cYDv7/fACHhW5iCHGXYe+oyuaTwwvArPyAjrjlI+wQPgl0ws8FU70kZHH9dO5GD1UIL
 qGY4RPS0mRtBrFBuqEJENqu5EvHc6Iuz9SAbYYZ01s1rMd80tyKsUqjTRzWKd2TSz6z/D24pN7H
 8+U+46Ms8dmTI32jIyq4ycQGTsQKf2Nk5YYW8aNeiVjIqIesVie0oVREnCW/m9l28VZ9IwpYuue
 RAkn7B2hV2hwfFA2C8t3l+5MAVaMN9RkVXhmp9m1f9zgNoysdTLUab/7ambu9c0v9VxxWn8uwFI
 QHtJmfV4xIJL7ZfkiQ/6Gx2b9zs5f+8oGwWfEPxu0cZiJyyDnAGrAPaKz6At8HVjGRh6tURduFs
 U9jxazGRWE+xmKImWdw==
X-Proofpoint-ORIG-GUID: dlWCJMIWlYcjetmG9VHJIqjsiHaRSpwT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23019-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,meta.com:from_mime,meta.com:email,meta.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90E4F73EB0A

On Thu, Jul 9, 2026 at 12:26=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 2 Jul 2026 11:10:13 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Changes since v10:
> >   Patch 2 (dma-buf): Per Christian K=C3=B6nig, document that the ST/PH
> >   returned by dma_buf_get_pci_tph() is only valid until the exporter
> >   invalidates the current mapping and must be re-queried afterwards;
> >   note added to the wrapper kernel-doc and referenced from the callback
> >   kernel-doc. Also add dma_buf_get_pci_tph() and dma_buf_ops.get_pci_tp=
h()
> >   to the central dma-buf locking convention.
> >
> >   Patch 3 (vfio/pci): Per Alex Williamson, update the vfio_pci_dma_buf
> >   comment to note that @revoked is additionally protected by memory_loc=
k,
> >   and describe the READ_ONCE() rationale in the commit log. No behavior
> >   change.
>
> Sashiko has valid comments[1] across most of the series.
>
>  - Passing through 0b10 seems mis-categorized as High in patch 1, but
>    is valid hardening if tph_req_type can ever hold an invalid value.
>

agreed, not High and pre-existing: get_rp_completer_type() is from the
original TPH
support and untouched here. I can send the hardening change in a separate p=
atch.

>  - The documentation error in patch 2 is real.
>

will fix!

>  - Patch 4 ironically fails to re-validate according to the lifecycle
>    requirements that patch 2 specifies.  This is a significant gap in
>    the implementation proof for a real requester.
>

Got it, I'll re-query ma_buf_get_pci_tph() there and reprogram the
mkey's steering tag,
so the lifecycle is honored.

>  - The broadened scope of the existing memory leak in patch 4 is
>    already addressed in [2], ok.  Maybe should be folded into this
>    series if mlx5 isn't going to pick it up separately.
>

 [2] is already accepted and landing through the mlx5/RDMA tree.

I plan to keep it as a standalone dependency.

> Thanks,
> Alex
>
> [1]https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260702181=
025.2694961-1-zhipingz@meta.com__;Iw!!Bt8RZUm9aw!5x8TPHfbpTXQJ872nmZaHsPIXH=
7HsL9ICbZR3G37yKkHgB-RukCDOy3XiLIOhfhP-yTczTyWQmud$
> [2]https://lore.kernel.org/linux-rdma/20260612170406.3339093-1-zhipingz@m=
eta.com

Thanks,
Zhiping


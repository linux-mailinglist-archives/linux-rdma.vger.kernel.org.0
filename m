Return-Path: <linux-rdma+bounces-22196-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hfa6CE/YLWoqlQQAu9opvQ
	(envelope-from <linux-rdma+bounces-22196-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 00:23:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D68967FEA0
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 00:23:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=RXC4frVr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22196-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22196-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 129CB3011A4E
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jun 2026 22:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9650E3A6F0A;
	Sat, 13 Jun 2026 22:23:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F1315D21
	for <linux-rdma@vger.kernel.org>; Sat, 13 Jun 2026 22:23:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781389386; cv=fail; b=NI4KxPUS+dq57s05MvJNbM9YyDOvLLF7Cr7obURU5ktLckOUhc3fSLQtHnb651zC+DFn1xoUvaSS2QPkBfPmXr62t80VPHdDCWtp7DjY2p7ZH4wv5rwbq3ag7XFt7FWrl0YQdSGiRTxRKCJHF4Wj+kcoYJbqiLLa5JN/sftI1iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781389386; c=relaxed/simple;
	bh=7+UCwdV1ne49cq4fcMibRTQe+zHj7j8TUy7YJPYz0Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQXzmB2+VlTSh8V3y78nj0vFQjk7S+jQO71we89WSf2bf+KtCZAb9BoRkFeLgNXF0dYt4PGGFUK1AC7OZhzmU2bm93NAADM2gPpMcbALa1hmUSnLxmmjGCC1ehQfLmuuV6ReJpHeoXMcv8bHBrAc20FSEfpHo6uCF+/pVRRjnQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RXC4frVr; arc=fail smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DLD6Wi1655030
	for <linux-rdma@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Jwd8bTapbEIKBMHRp+HoohnDcRxDUqI6nQwnmy5apkc=; b=RXC4frVrigul
	2+TPl69gny41YkeXpqOqbJD8TTbXSg8TLF3Mqa8gIyDAaPL1Ca9do2i2HlOHn+65
	CoxCrdgf9qWE8+7MbwigjUdDtdmp1AfYUyFCWoWend8LDbrYFB8tNlx+eS0wmY0e
	XBwyjB+KqTqOCrpMWoYa0NoDEtLtARehii4jUKwa9uklgqAWQAFaJ6LVMcE8YQM7
	alz+Qg7XmM00FAWye9ws7HX8pcHw0/UMPEsTvpByxH2Ie212YLkrrayKib69EdsZ
	UWVGo6QknIJteioPFD+o+4G2J5duEz4k2lDmocBu7Ml/04FaNl4K9dVPzKfy55Vh
	8w9vDSJ9BA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es515syts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6c8a160c4so4184315a34.1
        for <linux-rdma@vger.kernel.org>; Sat, 13 Jun 2026 15:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781389381; cv=none;
        d=google.com; s=arc-20240605;
        b=AiCeasJSDbJrmOPfWTH6Mv0qfzb14iQudblcka30rTk0Cs1RxWJ3RpzSHk0ob7MxMf
         yVEwWhW+3GWJTh+eE5x9URYPZipCZ5MKqSyjddPX+z/9M5DmqIHrLXAG6yEz+GA4l7+N
         +jX7vlhOsSWHwArP6R6HUp9b1C1wjvH1nMH/wVt70eu06U1LFa3EY9Gcytjp1+JHqHsk
         LQIc0IwmQNrmjgj9mfkCDX23eRlkNItEkwQG37ASjTaQ113GViuZihw6Z8uwrI/XqpXH
         RBrZNf3BLPDGmHxVeti0rT7axrZFaKTD0fB5weMwNdZjnoC6Qax2EWioGuZ51qCdOgvs
         hVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=h6kN9+j+P+sc+s3Q1KrZzNdCmFSiMsMf2TTL/GK/Pms=;
        fh=vU5CEZA0uO7gOkjTFj+fe2RtG9Z6yVNMDhkqFK6MWmY=;
        b=SqauD43aogl8LQWCrjm6izAJsaHWg1u5I2rcwbqs3P8NE1ccA5ty9jD0w7XUtvLK6N
         JB+og+Hjs1YUL0nJWeuob0G1oft4J59LFo4lked1y/OQOb3aRZ4g3GmkKkOnRMVy4sqf
         8pERi2Y+twwIYXwcdKS6AeOMCbL/eKxjQTistMQrcWqESroozu2CMDcemdTWBXYf/hdF
         ZwpY5eStz0GBkA/RXuGEIAE6okBcPW4tvN2HSIoexqc9tDyQQuvxG51xtKKDU8HU/nus
         dD2O6hnlbPe1T96RrBet5WXlMleOlO5PrhqbVUX1hn9D4lPE8Om1936vnD5/oOWUpMYm
         ow7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781389381; x=1781994181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h6kN9+j+P+sc+s3Q1KrZzNdCmFSiMsMf2TTL/GK/Pms=;
        b=X4HRfJEiMTXIBc9pnSI9adFcQtCAhR2zhUngjW79tcAPZVlPSWA23N89PqP3+th8gd
         DOr8uzdWxDV1/4sYZsUZP/6IY7tL/X6yRHleuzMB5WNTYDXanSUqdgw/Q77+xCtZnZCR
         lQ31X1p9b6CTt1n1zpk72VZCDeNplDPUuAbz2Tafot9g771jg8UdjO0yz2vS9pQ+/tJl
         grA5dW9UXD7BqpuZuRaeks6WFT51Zwg5FH5eUl24SZEkRmB+L+s8uiNu7ZlHnS9JZ2Ed
         +mtZc6C1ULLyw+r8eBMPLbmx/3A5imxvuN1I0YziAza3hjetATHe1h5+SdhWvr9KSNMH
         TG+A==
X-Forwarded-Encrypted: i=1; AFNElJ91ygUT9aQ45C/siCMRx5oRYNKAtfnX0fTK+NBWsp7fkYoAmPqjikwrRA38RMYrZFTihsKuI9lBIOzR@vger.kernel.org
X-Gm-Message-State: AOJu0YzGnEyu/KSJJxqTWfV8XDUxarmg15h9FWSp6VtT8iQxET9GXn+1
	HT5zvmKkiA/Kr4xUY1SdpqWFtOp7EFmAegtuAsY4g6AnGfPl8YH/OiAifWEnZ/0oH5E98uW/bOG
	VroZNqxFV/YDp9b30UNLiomiXPimgO/B0UzTxeyUIIXnPL/X0LtcFSi5D9zhcJ1TAyqbavjkgT5
	apxWRsrkhdc9U8heNxUMTB8tZzG7d9FpESVb5q
X-Gm-Gg: Acq92OExDjF2bRJKBGiAB0fmiLNUwp8KLXzg5C13iBu62xjb29rBFpyVVSFCk2rFL1C
	VA0MpfEc08VDRGIyAADPTVtTikkkLfK4QaHklzq5vUG3oWki1WRtYgoNzKg7yYmcgM0tvXqaIZ5
	zZyO+AyvzGxAp3GEai2OPNEpBmSnpmhkY1T1crij3C/C8BEc4qpklbxtzsTbYorxOET2fpej+NA
	7VNYB6KYsTzaDgNGVTKMw==
X-Received: by 2002:a05:6830:6b03:b0:7e7:16b9:e274 with SMTP id 46e09a7af769-7e7846b44b2mr6299913a34.8.1781389381591;
        Sat, 13 Jun 2026 15:23:01 -0700 (PDT)
X-Received: by 2002:a05:6830:6b03:b0:7e7:16b9:e274 with SMTP id
 46e09a7af769-7e7846b44b2mr6299886a34.8.1781389381161; Sat, 13 Jun 2026
 15:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161546.4075580-1-zhipingz@meta.com> <20260611161546.4075580-3-zhipingz@meta.com>
 <20260612105248.7d8431f2@shazbot.org>
In-Reply-To: <20260612105248.7d8431f2@shazbot.org>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Sat, 13 Jun 2026 15:22:49 -0700
X-Gm-Features: AVVi8CfDNU1g_5HOJkneMc79yczUqiaSKei6CEAn7F8ZvFdakbFhyfrfCnrLCmw
Message-ID: <CAH3zFs0+zF2JQMpVZMM9ndh+07KE1ULQNOkKrLozWq+_kRdMyg@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] PCI/TPH: Add requester/completer type helpers
To: Alex Williamson <alex@shazbot.org>
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 6aozus0AwoWsgqMHrJ5xwv-q6Bp6hWod
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX8ZNhP4zCoo9r
 AeYljxhE7bwbSAvN+puRRZgBWXsdysLjiMMvm8ZJFbQFtvyoZc/94NPzU9RQj+VX8o8imngUAfW
 5RrvqcRBxrzTeMvGdc4B55cCgu/OvYE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDIzNCBTYWx0ZWRfX66yVsJHlAK98
 8FJ60uMRzW5btygCUSqW7FGrh3b1XheqGeMuNHEmcJogdXrFewvt2I+Tw29neVsBuSZcqxfDOgC
 nXAj3JW3Qxr8PFth53NN2EfBR4IcBbThpFjZ5HHT1kZFINgqkiXjQNlvhZSBnEQa58+75wmo3Jp
 5klCycyVRM7wGr5b34hvsRH/qJYMZsawXb46/3XhqGPuq24Wz9qVyD9ljMX0Bz5Ya+WcBGEpwpR
 MC2COFic98UBqIoGPHmffyfMPcXW2IxRebejdctQ+RXdJd7tFFogTm6Mb9S7qBfN/VfiMD45UYm
 FLtfhAmb350irGNHSSsui7+ZC6ZefUzXennG3uNm5iQx745G+T1rMm1856GDwRWNZHI2GJESrZ0
 KWpBf/d904CFsGyUmalhlezMKfnDOZunUZ3TsTkFfCq9WeKizgIyG4avDQ8f/Qtx5D/O2mCXogl
 O0jFVPS5oT56Ier2ZOQ==
X-Authority-Analysis: v=2.4 cv=JqnBas4C c=1 sm=1 tr=0 ts=6a2dd846 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=1XWaLZrsAAAA:8 a=JzgkHKIk_dV2mhMsj_sA:9
 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 6aozus0AwoWsgqMHrJ5xwv-q6Bp6hWod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_04,2026-06-12_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22196-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alex@shazbot.org,m:netdev@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:bhelgaas@google.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D68967FEA0

On Fri, Jun 12, 2026 at 9:53=E2=80=AFAM Alex Williamson <alex@shazbot.org> =
wrote:
>
> >
> On Thu, 11 Jun 2026 09:11:17 -0700
> Zhiping Zhang <zhipingz@meta.com> wrote:
>
> > Add pcie_tph_enabled_req_type() so drivers can query the enabled TPH
> > requester mode without reaching into pci_dev internals.
> >
> > Add pcie_tph_completer_type() so drivers that publish TPH metadata for
> > a device acting as a completer can gate on the "TPH Completer
> > Supported" field of Device Capabilities 2 (bits 13:12,
> > PCI_EXP_DEVCAP2_TPH_COMP_MASK) rather than reusing requester-side
> > state. Fold the reserved 0b10 encoding into NONE so callers only see
> > the defined values.
> >
> > This keeps pci_dev::tph_req_type and the completer-capability decode
> > inside the PCI/TPH code and provides !CONFIG_PCIE_TPH stubs for
> > callers.
> >
> > Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> This is carrying forward an ack for v6, where half the interface here
> was dropped and changed shape.  Thanks,
>
> Alex
>
Good catch, will drop in v8 and request from Bjorn on the new shape.


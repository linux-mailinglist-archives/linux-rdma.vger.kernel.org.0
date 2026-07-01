Return-Path: <linux-rdma+bounces-22662-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GuBYFD5URWpQ+goAu9opvQ
	(envelope-from <linux-rdma+bounces-22662-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 19:54:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA006F072E
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 19:54:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=te9NKp0K;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22662-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22662-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=meta.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F8EB3010C04
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 17:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA4D4BC009;
	Wed,  1 Jul 2026 17:53:41 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C2137DAAD
	for <linux-rdma@vger.kernel.org>; Wed,  1 Jul 2026 17:53:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928421; cv=pass; b=cdP0UbVs+YuPSuYU16DAffNcv+WVpmSX5XrJjs+W/59CsAQ0bvGG1yDRc77n6898vcQbC81BevKuxVE0tZTY1g8vsZFCaoZx/cogIeZz0HoHNp+yZFU6Goa5eXzae4h3MIcrfGbWZlQ4p/Jy+5MYTLPayOE9d1gEyFlG8vhXBUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928421; c=relaxed/simple;
	bh=6RtQ4aX4MIiDBOUtFN4cE0U13b1ydyIimdMtAEGn2wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQQNgy4I9rPVN2Lb0S9mCBReHVXRqDxKwJoj4nhq1M8VHgQCp7RrDR6i1jfeB/yNZdOA+c/mdYVS4Qe8ZKtuVRlhQscn4RnjfIbPzhHLsUQNXmfjuNA2mszKeMZwKY/j1mz5mGOCa2fvNZGW6VWn8AskVD0/THgX/r1L2ppfiFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=te9NKp0K; arc=pass smtp.client-ip=67.231.153.30
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GqChi418352
	for <linux-rdma@vger.kernel.org>; Wed, 1 Jul 2026 10:53:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=; b=te9NKp0KSuAB
	gJAStcqVmXyO90PdrOMhuz1QH+omYd4+Mw3B8TEdXPLJtkYQrsX/45BVNWyEblz+
	JCUQhK20eJ/NvICPYCtpkvbiKi0EHSaSmpoWEug8KslbHuTVqxo1Cyiq8npvWq8O
	iWJN4c+SNKe9prCgyypFFuDT+2fW//iCpWAfn5FZiHT3Ma+UfgQldfxu1JwL3wjT
	puoEMSaFB2J+gLTdLoKhlZdm4JHFAsQvSKn60MMl3h0pRepyXYCBK4DH/emUGdVP
	7d65A6CTugo700ojlRhKudPV6DZBXhMFm8x8LUWJmnAbgYzkzF4XYX6nodZkJ3HT
	F2Y7Da8ekA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4f4719ehtr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2026 10:53:38 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e7624e584dso1347172a34.2
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jul 2026 10:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782928418; cv=none;
        d=google.com; s=arc-20260327;
        b=WQxJ2CqSYtTk1HqAPHJYUN6QMEwHTMPUJZ3z9A/ZHPqMCBQZGuL4GITBKMr/t/0HiL
         63Yx907ieLikoE2p9/z1la6UjTfh1/7zRmNgBPykeNknfxoTUhk5XLg1mIVehLSchroZ
         n4OnKVf3jhgeLUD2JnZodaEEjmIXYR9Al2eXpGzWminfS4pm8z1e/rXFH4yCKG6DwC0V
         ZQcmve/TONOMZht6ou4YyTDfCKkWs7YGq9j4dVf3eYhcd/AnxlLTwpiMhX/3mowy/4jI
         rzpUajYSc7+iStEsbqCCC54M9xkQzbZESTTYqH9SLxaKMT8GRx4J0E91iQwyxpb4HmxC
         yE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=;
        fh=H0wGbDv2igyXFZvVlcqI2RsNN1Rlpdvt1s4E8Mh2bxg=;
        b=jW3aUzzdh87sEoinAV1zi4nD/BLTaWIwAN2327FH/GsXCMqwa9SAJ+wql3JryxwCmj
         jiIWnZsQpaFji6+8by/y4yHW6DVkI1RU+5hlVud0Yx/AZfKzkut5V6BbTFN6gTqUffl0
         dN3GOU7Wqqhg27zZecwVV312Erm6i0ZZTYumFFc15gssd8VoJ0WeUQ4JY9BmlOOaoG5I
         DoWUqFHAjhltHgVyj54B8s6xThlFvCv2HpM/tVX5sflMZreiNwv6N4L/WPB4GruqUfFl
         AIoHkeRyzOTdgKByYvxJXt6NynVUaMvH/3DsnEKuVoSOAVAD2+RvmSk4Um8guwJIPbIj
         +ikQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782928418; x=1783533218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e7kmcvrJXFeA+SwUp+Q4JZ9GBs/Tu0VczqJ6zfGHtFQ=;
        b=pFVOpFR8iwQ0OhlmEICsZ3uhfFlZXBOp+KklmCUiRydUXE84O1tsUXWkbxZFO1pYrl
         6Rb+ydZlQedI5SL8hoXEpWM7n8NHsHwzhUhAkk/ipCYS58sMqUuKjpI79qPZb6HcoIo7
         LL4ie6IXEEaozIMhPcj3x5tGktV1+8RBfztjNAaNK3fJJmFdQnwHsDjtMzb8yq5GTRpQ
         y/fklWnlY15z1kSWEiZLaLIE1j0feyxpgK/I2yoTHI9bKHNMgZySCBsnRuhRww2AqPgI
         9x8xm9YoADZWH/VYPv5rrd8ZTE352KyKdHzdQQRdfXHaY0DJPZq6zoJJ+hYPSkKtOPO7
         AjMg==
X-Forwarded-Encrypted: i=1; AFNElJ+oJEz8wZ9pHfl5Lnm12j9d03O+fBRXXzsv7NHbwxMyw65EnBVwpyUCZ/zueqX/MCF8FTofXm+q88+e@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdwl3AkTGqE4TQrR1dvrVH7beivyGgcW+XNWOJvZPmsJHtE2jH
	mWFOB4a0ZhNkKfM1vyxnk8rwUiXqiN3vVhJikB3KyBgmd/jvVucySGXvxGyw7ql8mjr+UUA60k4
	zeKHF9Jp05YvulaZfHzEGI8cnDuKJxHb0hpsts3hYDR05aNhdrJVwbcfF6RGUp3KTho/e9sOlUS
	6g6MPaaYdvLDnBJVDr9ftMKGNLHsmqC64CdS/z
X-Gm-Gg: AfdE7cn2LnQvxuCz0rwI+oZAqevIO8IyH+na7vA3c3TNDaoKddUXKL5oHpCr56l+hI3
	Vq4OkcFc6j8AC4hTYvhV5d5c3AgEP+eOWnxt/14hTkVIduhSsjB9ykLbo8JL4Epd8ztGzZIBIfn
	7+Dv+uJ5Kj8DLBTAuIl86tTt71UVhillYhMCC+hc0xZ/lgNXruaahbkche6uIfbg0FOE7s9M/BV
	vufnJQkYw==
X-Received: by 2002:a05:6830:348f:b0:7e7:62f:727e with SMTP id 46e09a7af769-7eb505175d6mr1172070a34.22.1782928417975;
        Wed, 01 Jul 2026 10:53:37 -0700 (PDT)
X-Received: by 2002:a05:6830:348f:b0:7e7:62f:727e with SMTP id
 46e09a7af769-7eb505175d6mr1172044a34.22.1782928417437; Wed, 01 Jul 2026
 10:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630224328.3218796-1-zhipingz@meta.com> <20260630224328.3218796-3-zhipingz@meta.com>
 <e132eb91-554e-493f-9da2-aff5a538da6a@amd.com>
In-Reply-To: <e132eb91-554e-493f-9da2-aff5a538da6a@amd.com>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Wed, 1 Jul 2026 10:53:26 -0700
X-Gm-Features: AVVi8CfUmWw3yG8Q376o8lxaFsAzKao0Cd3LEJcq9dJNu4sURoDLmPjujqACaso
Message-ID: <CAH3zFs2tkxA9w-oCr0N4ixe2VupXXQF-cA2o8-fToj6uFyuMJQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] dma-buf: add optional get_pci_tph() callback
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alex Williamson <alex@shazbot.org>,
        Bjorn Helgaas <bhelgaas@google.com>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: Tay_mQbU_JkWo6GpSgQwco_lhly0Lk8M
X-Authority-Analysis: v=2.4 cv=Q9jiJY2a c=1 sm=1 tr=0 ts=6a455422 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=I4J65MU22ScPYueRrkgA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5MSBTYWx0ZWRfX7t/oPYrKVnr3
 Hm63Ef8Ipb4deCEur7V6uo3dFqBNNUGIcOu14SZgrveaq+9NThIASiMU453OXeC66RggC5P2oib
 1/r1WEaf7cNMSswpApSuEfOY8/QsPg30vTrHNFSpLQY1qDuyjrMkEttGd7vz/RofD83MEr+zFpV
 7HwkspUh3oRoGA0aZDMjmemzMA1tIbxNqz51/LNt+UsieesUxQm2UEqq8I8g5PCkNxjhzqZjnzX
 kxb6l5ktcWFe/R45h+TT56/dk38CThpYL8g3rQPcknoxjOn4350j1x+KQbdu8RYuk107FJG0flw
 kdBOcRUNYYV+T82meIslHJ4Pj3HjXY0NsFaOVh5dEzcKylEbigbVOLKDd8ZmdZCQboMw1jG5sms
 jbgtoc8nXhfFyizDk1B+p3plsSNYFh7jlI16+H+u/4W8mu9ovUt/y/RQ5UKLeYmPpiQeoYedA3d
 yJPVllRoZc65DLTFRCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE5MSBTYWx0ZWRfX5QWOc9APcItO
 /n727/Ui5TQoZcUPQDOuvSkKHqJzvZwH/M4F89T5HoFWHsEkxoxbQt1Pd/9Ff2kg76TGf3bbXcA
 hQlO+FO1V8aqBFY85K+Co1LmDUxvopM=
X-Proofpoint-ORIG-GUID: Tay_mQbU_JkWo6GpSgQwco_lhly0Lk8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22662-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:christian.koenig@amd.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:michaelgur@nvidia.com,m:sumit.semwal@linaro.org,m:alex@shazbot.org,m:bhelgaas@google.com,m:kvm@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-pci@vger.kernel.org,m:dri-devel@lists.freedesktop.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[meta.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FA006F072E

> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index d504c636dc29..7a4c9b0d5dab 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -1144,6 +1144,31 @@ void dma_buf_unpin(struct dma_buf_attachment *at=
tach)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(dma_buf_unpin, "DMA_BUF");
> >
> > +/**
> > + * dma_buf_get_pci_tph - Retrieve PCIe TLP Processing Hint (TPH) metad=
ata
> > + * @dmabuf: DMA buffer to query
> > + * @extended: false for 8-bit ST, true for 16-bit Extended ST
> > + * @steering_tag: returns the raw steering tag for the requested names=
pace
> > + * @ph: returns the TPH processing hint
> > + *
> > + * Wrapper for the optional &dma_buf_ops.get_pci_tph callback.
> > + *
> > + * Must be called with &dma_buf.resv held. Returns -EOPNOTSUPP if the
> > + * exporter does not implement the callback or has no metadata for the
> > + * requested namespace.
>
> Please add something like this:
>
> * The returned information is only valid till the next invalidate_mapping=
s() callback from the exporter and should be re-queried when a new mapping =
is created after invalidation.
>

Thanks, Will do in v11!

> Apart from that it looks good to me, but I still think we need some kind =
of example that this works for other DMA-buf users as well.
>
> Just demonstrating that this also works with some simple FPGA or similar =
PCIe endpoint should be sufficient.
>
> Regards,
> Christian.
>

On v10, I have validated a second importer: another vendor's NIC
(driver not upstream yet, so locally patched to
call dma_buf_get_pci_tph). A PCIe analyzer confirms the TLP steering
tag matches the exporter's for both mlx5/ConnectX-8
and this second NIC =E2=80=94 two unrelated importer drivers exercising the
API end-to-end.

Thanks,
Zhiping


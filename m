Return-Path: <linux-rdma+bounces-21616-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHhXNS6EHmrQkQkAu9opvQ
	(envelope-from <linux-rdma+bounces-21616-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 09:20:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 376FA62986F
	for <lists+linux-rdma@lfdr.de>; Tue, 02 Jun 2026 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F51530BC2B5
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2026 07:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC99B3955EC;
	Tue,  2 Jun 2026 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OQZ6oiRN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE53A0EB3
	for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2026 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384500; cv=fail; b=myxhGlOBC9nPMCzsI3jX6uL5jY+C5//UuOewIA+ETPdvg5fqljUAPjjDacoMdR9yyM7XQd51nO7EtW2cWqhTo/JL4SPyQMClaLggct6LCG93NnRsoLWhwUmTFcYx3cg8EsJ/IoZ+hOx0daJ1kRLldMIJ6T+nXXdeYMp/3VbIxgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384500; c=relaxed/simple;
	bh=GNbqOP8/vOBlC/5NmVa3CquXtyGbio1xnntDWh6iGKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKIQ/CKYuWi4/9aUIiL6CVu/qVUGIyYzTNagcQcaGwP7ZOjrVTBFyw74o31nUrm9s8XRJ57+pvMbMEdZwHVhXe3s994cbpR0NnxHODEwP7xTD8rlFaeRsHXJ7WvKtqXpJy43JZwLjMngWGPpJPFNz5VYMqN7ckzF41HbOjPS/x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OQZ6oiRN; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651J9x2x3693931
	for <linux-rdma@vger.kernel.org>; Tue, 2 Jun 2026 00:14:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=GNbqOP8/vOBlC/5NmVa3CquXtyGbio1xnntDWh6iGKE=; b=OQZ6oiRNKfXF
	HFDFBWZ8BdlnmCUnJoqopQ8ht44IyIcRngTo5vzbD9eE3PHci7hw9MS25fO/+eto
	Ufhbzh5w0syuQ2ggQfOY2tYEThW6kK0fREz6MbHOgTTfppfQkpqdfn+SQPXexuAD
	Ie6ANRJ+b1YRc1xewkyhZx2bIIsI7MRe/jwOSfdaywuF9473KLIHfYoKIPRCh2Y8
	WWdocGE13zKd1J50r3VdsLTAZO5pqjzJkcYBoHjogiZO27cQxUvXRQ3zUmWXlq15
	g0ZF1xKWkn2Pxg3MqRPI0HmbFBBYIOMYNp9JoPpIzHq9+nA8JFAN2q0RoJ8mT7O6
	eVDAMsqcKQ==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4efwjxy3s9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6b5c2bcc8so3400966a34.0
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780384494; cv=none;
        d=google.com; s=arc-20240605;
        b=PEPwnFaPqhKNzXePYTBVlm+jzewIfX0bi+RDMcJ289Jy4et2lkjoprah0uqw5K0ywe
         CZr17Pc9Jdrkp1C4ch4+P8nGeHMP4rs0f3mUKeqkMIC9L0GiEOqqRiTr5eCwd9VWntjy
         mmp7kJ4b0EmZtR5sUM1lOSTv5hcLc/GA6sGsBTTS/jd8dsOkyPw6xE+Z/FAGfBUlzVlG
         7Le3Epq/8tQMOBSf99em0SLFRKCjF7K7wJJJXFNWSzvjyIXRo9RIjmCQLcE75zCPdWMf
         fBJxisd0zUUKzFyCfaQ8aN1IXZv2DPgZnRGJOAMa/9huduJ2A/BNWMMeY2iD8mznVMKG
         ap4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=eU0M4rF9MI3wrJoAUMjH5Oo4i+TWDq0gEOuY0ahh7I4=;
        fh=a5c5rbE37UGVm0C4tz2nlDc/HSHr7INPAJQPrxj54L0=;
        b=fnMPl6DHA60X0gwzbv2x/x1deUxoZ92GTvLRlfKwWbXLYrjhq4RietCySZSwMqIrXX
         loHTWzPC7Jv6ADogVmh3yPYnDv7mbMgM0pu98hn10lWLK3h3Vvja+NLYx0wxZu7hTth8
         +KiamQ5+sIcFpJxXDMI50sRJB5DczbkhKYC9Hy/TEMjez1d1qhhyccEJ9yCZaXfSnwcV
         fikNvUebs2IsYlaYdG8H85KL2jxD8EJpV6i5An5MwuXXcdVcHv+qL7nsPkqAFecvuk9q
         pywX1cOIKwsca8CNBowuCf65l81/IrrPIVgbXgsY99P0Qo0A79C45XJnyviq6w3KMjM3
         Jweg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780384494; x=1780989294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eU0M4rF9MI3wrJoAUMjH5Oo4i+TWDq0gEOuY0ahh7I4=;
        b=K3x2BcTH491xKnh9iTg1KYyuF+fAJEutUal7pEA1W4ng70r1XfJwbc+wKnc39XjFTr
         0VtDhx/CwC1PareAFny+hcevSp1kf0jU1PCT6BKUALJ6lpj/xg7V10iIxTCOEw97cHvB
         Cb4edc2+2jPL19NfqnOAlD5LTK+7JAhCXwULpEMEZHt3LmE5d7tfCt8wUQ3M234QSUbL
         BozxKXFZguGeUAYMg0/k8HBNbn8miD3mCQaQTZ5mtNq7EGteoVql/p4g/qjdUls52Vt/
         mB6o3X1uRnqnEID8IoFh3FXYEyeH0aK6ga12WBC/0i46KzoYJtj7h152KUbmgvaef6pK
         IBfw==
X-Forwarded-Encrypted: i=1; AFNElJ8NwnhI33M/L2709xNqF/CHO5uE/MI+hfsv5IoPKiN318kicvpLjN2xYAoVqj3KTeAdq0go/v0ZQ29/@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGXk7qRs/nwvNy9y8PaCxZsfgocC5mUBG0UnKVMlW5j51S7t0
	BbXHB/Hz3GBZ4rqKCB+F1SvGxCiudB1XRg/F3OKxFS4m/ir+ZJX2HHAb/4EP4XPD0VmeF26Q+CO
	WWjQARyCbJC8zKp/7N7nAh8lcLYGuEhl473N7hsKQHkr0rFbDCVMMajYcbRAec0JcFRVnDQ8OJC
	TNh/qdOGoYx9E6LjisxnzopLKOugVkqssBd7/C
X-Gm-Gg: Acq92OGKU/UQWa1dUc/SeCD/Vfv88XUVZX2vMER5mFaC3fvhG0s/1NxtI1J8tk9R+DD
	aLpTBWBDrUJLpM8TIhmf2FEyuxRSGfm1CGrxUFsb8Tn1HbCRJoQ5ebzajxxC4PZmuz5Pm6674Rq
	Y5aJyaIEmFYnor6Ag8T94uR56q5KhI4i1LPXqQ8GuNYcUh70Xcr7OccV2P10/1NJQabuStrtRfc
	YZKxIdd/lyAZYIgGRoVuYH7xoIyXIWXBndkC1EGQE4XHah51oc=
X-Received: by 2002:a05:6830:b8a:b0:7dc:d725:fdb with SMTP id 46e09a7af769-7e6d22714f0mr1524747a34.8.1780384494167;
        Tue, 02 Jun 2026 00:14:54 -0700 (PDT)
X-Received: by 2002:a05:6830:b8a:b0:7dc:d725:fdb with SMTP id
 46e09a7af769-7e6d22714f0mr1524729a34.8.1780384493717; Tue, 02 Jun 2026
 00:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527123634.GK2487554@ziepe.ca> <a5ff1930-e9fb-43f5-82ab-9875d7a28421@amd.com>
 <CAH3zFs2KALuHXReLZG_uoqvBBWvBzU6rHKakmt6HBV7PZEsD=w@mail.gmail.com>
 <71302a7a-6b9f-40da-af81-b1862dbd637a@amd.com> <CAH3zFs036sr93duQKx613pCyOYw4t0_x_TdSza1xBCaEmqijyA@mail.gmail.com>
 <8d9bb0b7-182d-4930-b683-d5d24da6b2ab@amd.com> <20260529201130.GU2487554@ziepe.ca>
 <190a1eeb-bd70-4b7b-93a4-60e14f0d6c7e@amd.com> <20260601174734.GB2487554@ziepe.ca>
 <dedd8e8f-118c-4ee5-9552-cd2220dbdd23@amd.com> <20260601184838.GE2487554@ziepe.ca>
In-Reply-To: <20260601184838.GE2487554@ziepe.ca>
From: Zhiping Zhang <zhipingz@meta.com>
Date: Tue, 2 Jun 2026 00:14:42 -0700
X-Gm-Features: AVHnY4Is8GEC0NoEl3YOomYHVUTID0QdEceI4eqR8x2YX12M9DU2UU8lLqhKsf4
Message-ID: <CAH3zFs0Lz=oe4coFS=Ws14rKsY_Wi0=ueT1DGx+YpaSvt=DkAA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer access
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NiBTYWx0ZWRfX1MTr3CkFEupp
 2VzRcGilsvUYHvxcFIkwVjfxRpltv5LZRfrcfB1atGLUUh98MRq9NCQRfSF9SWYQUBZxL1n++DR
 6VMQ3o5mGT+21kRNiiWDyK9VWXh/aiot5hQsBXd24ft8EWgwrYw4G9ImInSz3Vg6JJZw1FWoype
 eV+pq/P7M5LZzxMFSQxiW/dcRRfaiZVUI+YuWu64ndUCZxH53sWtTwzQx72Bz9dVokt/W3vtONX
 HbQIMRW5+AmIxOm4DNcEj5Iufp2Phgdwgz6HoNytQPZeJ23U2ucK5Rr/IbFlgQrzrysjL4FTcsr
 wIT52F12JTvAICcQXCGumxVn5YjhLqMUmiQiBEEzFTr1osXVHk+Ef5DJo92etYzR19MRF7Bflq9
 ixzwKyDOSgOokhVCbhJu/N/kxKFh0HH2x1ufOPer0Cbp0M7w35Z3tTpalh35tADQbTZjjBCsTWV
 C8qu/clKvmiTQ9X+ECg==
X-Authority-Analysis: v=2.4 cv=araCzyZV c=1 sm=1 tr=0 ts=6a1e82ef cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=9jRdOu3wAAAA:8 a=80MmiaoySdvbWJADnQkA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-ORIG-GUID: jpkANgj_b-BuiYAiACvxYGdqqksE04-Z
X-Proofpoint-GUID: jpkANgj_b-BuiYAiACvxYGdqqksE04-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21616-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[meta.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhipingz@meta.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 376FA62986F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks everyone for the feedback.

For v6 I plan to improve the cover letter to explain what the
Steering Tag concretely does on the completer side and why it
applies to P2P - the ST is consumed by the endpoint's ingress
block, not the root complex, so it's orthogonal to cache snooping.

I'll also include test results showing ST's functional effect on
P2P writes. In our case the ST is used to select in-flight data
operation.

Is there anything else you'd want to see addressed before v6?

Thanks,
Zhiping


On Mon, Jun 1, 2026 at 11:48=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> >
> On Mon, Jun 01, 2026 at 08:17:15PM +0200, Christian K=C3=B6nig wrote:
> > On 6/1/26 19:47, Jason Gunthorpe wrote:
> > > On Mon, Jun 01, 2026 at 11:59:55AM +0200, Christian K=C3=B6nig wrote:
> > >>>> When you have a complete open source driver stack which utilizes
> > >>>> VFIO passthrough as the interface to communicate with the kernel
> > >>>> drivers then we can eventually talk about that.
> > >>>
> > >>> That decision is not up to dmabuf
> > >>
> > >> Yes it is. This is the DMA-buf API which is added here.
> > >
> > > It is a DMA-buf kernel API that is added, I think it is overreaching
> > > to try to veto a VFIO uAPI that calls it..
> >
> > Well as long as that is a private interface between VFIO and mlx5 I
> > have no objection at all.
>
> Well, as you know, we are using dmabuf to mediate many of these
> connections now.
>
> I don't mind a "private" interface as a starting point, but it does
> need to discoverable and negotiated without weird module dependencies
> or symbol_gets.
>
> > But when it starts to affect DMA-buf I need to make sure that it
> > works for everybody. And without even being able to test it that
> > becomes really tricky.
>
> They should have an argument how it can be used for CPU backed memory,
> IMHO.
>
> > > This exposes a PCI SIG defined TPH capability in a reasonable simple
> > > VFIO uAPI that can be re-used by any other device that happens to
> > > support TPH on inbound MMIO. The uAPI has sensible general semantics
> > > based around the PCI spec.
> >
> > That it's implementing an official PCI spec is a good argument.
> >
> > But on the other hand looking at the spec it's not really specifying
> > much since everything is architecture specific.
>
> Yeah, spec doesn't say what TPH does when it is received. It is
> intended as an opaque channel between the source and target.
>
> Even on the CPU DRAM side we make an opaque call into ACPI and the
> BIOS returns back the right value to use for the CPU. The whole thing
> is agressively opaque as to what the values mean to any particular
> device.
>
> So I don't have an issue with VFIO supplying a value for MMIO it
> owns, it fits the general architecture.
>
> > > Anyone can repeat the demonstration Meta outlined in their cover
> > > letter: Use this new VFIO uAPI, import the DMABUF to mlx5, use a PCI
> > > analyzer and you will see the PCI SIG defined TPH bits set the way the
> > > VFIO uAPI says they should be set.
> > >
> > > There is nothing uniquely tied to Meta's device here, or unusable by
> > > someone else's devices. Arguably this is actually a mlx5 feature to
> > > allow VFIO to control its TPH generation HW.
> >
> > Would it be possible to demonstrate the functionality with some FPGA
> > implementing an PCIe endpoint?
>
> Sure, you don't even need a special endpoint, any endpoint that
> doesn't explode when it receives a TPH is fine to illustrate that mlx5
> is emitting it correctly.
>
> A fpga reference board with an out of the box PCIe IP demo is likely
> entirely sufficient, and you can use a FPGA logic analyzer to inspect
> the packets.
>
> Though keep in mind mlx5 is formally supporting TPH in a growing
> number of kernel contexts, so we do test and verify our device is
> working properly as an initiator. So I wouldn't advocate anyone
> actually use their time on FPGA :)
>
> > Doesn't needs to be anything funky, just the ability to exercise
> > this for basically everybody who can spend a few $ on the HW.
>
> Topologically you also probably need a PCIe switch as the CPU P2P
> likely discards the header.
>
> Jason
>

